package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
<<<<<<< HEAD

=======
>>>>>>> branch 'main' of https://github.com/Byoungseo-Moon/Spring20250925.git

@Mapper
<<<<<<< HEAD
public interface BoardMapper {
	
	// 게시글 목록
	List<Board> boardList(HashMap<String, Object> map);  // return이 2개 이상이면 list
//	List<Board> selectBoardList(HashMap<String, Object> map);
	
	// 게시글삭제
	int deleteBoard(HashMap<String, Object> map);
	
	// 게시글등재
	int insertBoard(HashMap<String, Object> map);
	
	// 게시글 조회
	 Board selectBoard(HashMap<String, Object> map);
	
		
=======
public interface BoardMapper {	
	List<Board> boardList(HashMap<String, Object> map);  // return이 2개 이상이면 list로	
>>>>>>> branch 'main' of https://github.com/Byoungseo-Moon/Spring20250925.git
}
