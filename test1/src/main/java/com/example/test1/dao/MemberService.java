package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;


@Service
public class MemberService {

	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;	
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	// login
	public HashMap<String, Object> login(HashMap<String, Object> map){
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.memberLogin(map);
		String message = ""; // login 성공실패 여부 메시지
		String result = ""; // login 성공실패여부
		int cnt = 0;	
		
		map.put("userId", map.get("id"));   // login 때 #{id}를 썼는데, 중복체크할 때 #{userId}를 써서 parameter가 달라 문제됨..	

		/* 해시 적용 후 */
		if(member != null) {
			//아이디가 존재하므로 비밀번호 비교
			//사용자가 보낸 비밀번호를 map에서 꺼낸 후 해시화한 값과
			//member 객체안에 있는 이미 해시화되어 db에 저장된 password와 비교
						
			Boolean loginFlg = passwordEncoder.matches((String) map.get("pwd"), member.getPassword());			
			
			
			System.out.println(loginFlg);	
			
			System.out.println(map.get("pwd"));
			System.out.println(member.getPassword());
			if(loginFlg) {
				
				if(member.getCnt() >=5) {
					//비밀번호 5회이상 틀린경우
					message = "비밀번호를 5회 이상 잘못 입력하였습니다.";									
					
				} else {
					//로그인 성공 : 
					memberMapper.cntInit(map);
					
					session.setAttribute("sessionId", member.getUserId());
					session.setAttribute("sessionName", member.getName());
					session.setAttribute("sessionStatus", member.getStatus());
					
					if(member.getStatus().equals("A")) {
						resultMap.put("url", "/mgr/member/list.do");
					} else {
						resultMap.put("url", "/main.do");
					}
					
					if(member.getPhone() == map.get("phone")) {
						resultMap.put("url", "/member/pwd.do");
					} else {
						message = "회원정보를 확인해 주세요.";
						resultMap.put("url", "/member/login.do");
					}
				}
				
			} else {				
											
				if(member.getCnt() >= 5) {					
					message = "비밀번호를 5회 이상 잘못 입력하였습니다.";
				} else {
					message = "패스워드를 확인해 주세요."; // 아이디는 있는데 pw를 잘못입력한 경우
					memberMapper.cntIncrease(map);
				}
			}			
			
		} else {
			//아이디 없음
			message = "아이디가 존재하지 않습니다.";
		}
			
		
		/* Hash 적용 전
		if(member != null && member.getCnt() >= 5) {
			message = "비밀번호를 5회 이상 잘못 입력하였습니다.";
			result = "success";
		
		}else if(member != null) {
			message = "로그인 성공";
			result = "success";
			// 로그인 성공했으므로 0으로 초기화
			memberMapper.cntInit(map);
			
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
			
			if(member.getStatus().equals("A")) {
				resultMap.put("url", "/mgr/member/list.do");
			} else {
				resultMap.put("url", "/main.do");
			}
			
		} else {
			map.put("userId", map.get("id"));   // login 때 #{id}를 썼는데, 중복체크할 때 #{userId}를 써서 parameter가 달라 문제됨.. 
			Member idCheck = memberMapper.memberCheck(map); // userid 중복 check함수 부름
			 
			if(idCheck != null){
				
				if(idCheck.getCnt() >= 5) {
					message = "비밀번호를 5회 이상 잘못 입력하였습니다.";
				} else {
					message = "패스워드를 확인해 주세요."; // 아이디는 있는데 pw를 잘못입력한 경우
					memberMapper.cntIncrease(map);
				}

			} else {
				message = "아이디가 존재하지 않습니다.";
			}
		}	
	      해시 적용 전  */
		
		resultMap.put("msg", message);
		resultMap.put("result", result);
		resultMap.put("cnt", cnt);
		
		return resultMap;
	}
	
	// member check
	public HashMap<String, Object> check(HashMap<String, Object> map){
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();					

		Member member = memberMapper.memberCheck(map);	
		
		String result = member != null ? "success" : "fail"; 
		
		resultMap.put("result", result);	
		
		return resultMap;
	}
	
	public HashMap<String, Object> logout(HashMap<String, Object> map){
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//세션정보 삭제하는 방법은
		// 1개씩하거나, 전체를 한번에 삭제
		
		String message = session.getAttribute("sessionName") + "님 로그아웃 되었습니다."; 			
			
		resultMap.put("msg", message);	
		
//		session.removeAttribute("sessionId"); // 1개씩 삭제		
		session.invalidate(); // 모든 세션정보 삭제
		
		return resultMap;
	}
	
	public HashMap<String, Object> memberInsert(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String hashPwd = passwordEncoder.encode((String) map.get("pwd")); // map에서 pwd를 꺼낸뒤 해시화		
		map.put("hashPwd", hashPwd);  // 이후 password는 hash화 된것으로 query에서 변수명이 hashPwd
		
		int cnt = memberMapper.memberAdd(map);	
		if(cnt < 1) {
			resultMap.put("result", "fail");
		} else {
			resultMap.put("result", "success");
		}
			
		return resultMap;
	}
	
	
	public HashMap<String, Object> getMemberList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Member> list = memberMapper.selectMemberList(map);
			resultMap.put("list",list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());  // 어떤 오류인지 확인하기 위한 것
		}
			
		return resultMap;
	}
	
	
	public HashMap<String, Object> getMemberView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Member> list = memberMapper.selectMemberList(map);
			resultMap.put("list",list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());  // 어떤 오류인지 확인하기 위한 것
		}
			
		return resultMap;
	}
	
	
	
	public HashMap<String, Object> removeCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			memberMapper.cntInit(map);			
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());  // 어떤 오류인지 확인하기 위한 것
		}
			
		return resultMap;
	}
	
	
	
	public void addUserImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		int cnt = memberMapper.insertUserImg(map);		
	}
	
	
	public HashMap<String, Object> authMember(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Member member = memberMapper.authMember1(map);
			resultMap.put("Info",member);
			resultMap.put("result", "success");			
			
			// alternative로 진행하는 경우
//			int cnt = memberMapper.authMember2(map);
//			if(cnt < 1) {
//				resultMap.put("result", "fail");
//			} else {
//				resultMap.put("result", "success");
//			}
			
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());  // 어떤 오류인지 확인하기 위한 것
		}
			
		return resultMap;
	}
	
	
	public HashMap<String, Object> updatePwd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Member member = memberMapper.memberLogin(map);
			
			Boolean pwdFlg = passwordEncoder.matches((String) map.get("pwd"), member.getPassword());
			if(pwdFlg) {
				resultMap.put("result", "fail");
				resultMap.put("msg", "비밀번호가 이전과 동일합니다.");
			} else {
				String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
				map.put("hashPwd", hashPwd);
				int cnt = memberMapper.updatePwd(map);		 // int cnt는 쓰지 않아도 됨	
				resultMap.put("result", "success");	
				resultMap.put("msg", "수정되었습니다.");
			}						
			
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());  // 어떤 오류인지 확인하기 위한 것
		}
			
		return resultMap;
	}
	
	
}
