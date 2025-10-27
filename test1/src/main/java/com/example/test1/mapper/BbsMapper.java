package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;

@Mapper
public interface BbsMapper {
	
	// 게시글 목록(복수)
	List<Bbs> bbsList(HashMap<String, Object> map); 		
	
	// 게시글등재 (파일첨부에 사용하는 boardNo가 map에 들어 있음)
	int insertBbs(HashMap<String, Object> map);
	
	
	// 게시글삭제
	int deleteBbs(HashMap<String, Object> map);
	
	// 게시글 상세 조회
	Bbs selectBbs(HashMap<String, Object> map);
		
	// 게시글 수정
	int updateBbs(HashMap<String, Object> map);
	
	//게시글 총개수
	int selectBbsListCnt(HashMap<String, Object> map);

}
