package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
	
	//로그인
	Member memberLogin(HashMap<String, Object> map);
	
	//아이디체크
	Member memberCheck(HashMap<String, Object> map);
	
	//회원 등재
	int memberAdd(HashMap<String, Object> map);
	
	//회원리스트(관리자)
	List<Member> selectMemberList(HashMap<String, Object> map);
	
	//첨부파일(이미지) 업로드
	int insertUserImg(HashMap<String, Object> map);
		
	//복수 첨부파일(이미지) 업로드
	List<Member> selectFileList (HashMap<String, Object> map);
	
	//로그인성공
	int cntInit(HashMap<String, Object> map);	
	
	//로그인실패
	int cntIncrease(HashMap<String, Object> map);
	
	//사용자 인증 1(리턴 Member)
	Member authMember1 (HashMap<String, Object> map);
	
	//사용자 인증 2 (리턴 int)
	int authMember2(HashMap<String, Object> map);
	
	//비밀번호 변경
	int updatePwd(HashMap<String, Object> map);	
	
}
