package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Mapper
public interface BoardMapper {
	
	// 게시글 목록
	List<Board> boardList(HashMap<String, Object> map);  // return이 2개 이상이면 list
//	List<Board> selectBoardList(HashMap<String, Object> map);
	
	// 게시글삭제
	int deleteBoard(HashMap<String, Object> map);
	
	// 게시글등재
	int insertBoard(HashMap<String, Object> map);
	
	// 게시글 상세 조회
	 Board selectBoard(HashMap<String, Object> map);	
	 
	 //댓글 목록
	 List<Comment> selectCommentList(HashMap<String, Object> map);
	 
	//게시글 전체 개수 
	 int selectBoardCnt(HashMap<String, Object> map);
	 
	//댓글 입력
	 int insertComment(HashMap<String, Object> map);
	 
	//조회수 증가
	 int updateCnt(HashMap<String, Object> map);
	 
	
	 
}
