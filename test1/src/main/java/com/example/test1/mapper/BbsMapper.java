package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;
import com.example.test1.model.Member;

@Mapper
public interface BbsMapper {
	
	// 게시글 목록
	List<Bbs> bbsList(HashMap<String, Object> map); 
	
	//로그인
	Bbs bbsLogin(HashMap<String, Object> map);
	
	// 게시글등재 (파일첨부에 사용하는 boardNo가 map에 들어 있음)
	int insertBbs(HashMap<String, Object> map);
	
	//첨부파일 업로드
	int insertBbsFile(HashMap<String, Object> map);

}
