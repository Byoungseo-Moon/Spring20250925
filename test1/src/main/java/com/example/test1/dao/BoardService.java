package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;


@Service
public class BoardService {

	@Autowired             // 재사용을 위한 annotation
	BoardMapper boardMapper;
   	
	public HashMap<String, Object> boardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Board> board = boardMapper.boardList(map);
		int cnt = boardMapper.selectBoardCnt(map);
		
		resultMap.put("list", board);	
		resultMap.put("cnt", cnt);
		resultMap.put("result", "success");
			
		return resultMap;
	}
	
	public HashMap<String, Object> removeBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
				
		int cnt = boardMapper.deleteBoard(map);			
			
		resultMap.put("result", "success");
			
		return resultMap;
	}
	
	public HashMap<String, Object> addBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
				
		int cnt = boardMapper.insertBoard(map);			
				
		resultMap.put("result", "success");
			
		return resultMap;
	}
	
	public HashMap<String, Object> getBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = boardMapper.updateCnt(map); // 목록 부르기 전에 조회수 증가
		Board board = boardMapper.selectBoard(map);
				
		List<Comment> commentList = boardMapper.selectCommentList(map); 
						
		resultMap.put("info", board);	
		resultMap.put("commentList", commentList);
		resultMap.put("result", "success");
			
		return resultMap;
	}
	
	public HashMap<String, Object> addComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = boardMapper.insertComment(map);	//error발생가능코드
			resultMap.put("result", "success");
			resultMap.put("msg","댓글이 등록되었습니다.");
			
		} catch (Exception e) {   //Exception 대신 SQL을 넣으면 query부분에러만 예외
			// TODO: handle exception
			resultMap.put("result", "fail");
			resultMap.put("msg","댓글 등록이 않되었습니다!!!");
		}			
					
		return resultMap;
	}
	
	
	
}
