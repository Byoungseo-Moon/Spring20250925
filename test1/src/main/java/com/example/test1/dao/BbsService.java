package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;



@Service
public class BbsService {
	
	@Autowired             
	BbsMapper bbsMapper;
	
	@Autowired
	HttpSession session;	
	
	@Autowired
	PasswordEncoder passwordEncoder;	
	
	//List
	public HashMap<String, Object> bbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Bbs> bbs = bbsMapper.bbsList(map);		
		
		resultMap.put("list", bbs);	
		
		resultMap.put("result", "success");
			
		return resultMap;
	}
	
	
	// login
		public HashMap<String, Object> login(HashMap<String, Object> map){
			
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
			Bbs bbs = bbsMapper.bbsLogin(map);
			
			String message = ""; // login 성공실패 여부 메시지
			String result = ""; // login 성공실패여부
			
			/* 해시 적용 후 */
			if(bbs != null) {
				message = "로그인 성공";
				result = "success";
				
				session.setAttribute("sessionId", bbs.getUserId());
				resultMap.put("url", "/bbs/list.do");					

			} else {
				//아이디 없음
				message = "아이디가 존재하지 않습니다.";
				result = "fail";
			}	
			
			resultMap.put("msg", message);
			resultMap.put("result", result);			
			
			return resultMap;
		}
		
		//bbs add
		public HashMap<String, Object> addBbs(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
					
			int cnt = bbsMapper.insertBbs(map);
			
			resultMap.put("bbsNum",map.get("bbsNum"));
					
			resultMap.put("result", "success");
				
			return resultMap;
		}
		
		
		public void addBbsFile(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			int cnt = bbsMapper.insertBbsFile(map);
			
		}
	
	
	
	

}
