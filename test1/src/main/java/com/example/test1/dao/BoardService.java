package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.controller.StuController;
import com.example.test1.mapper.BoardMapper;
import com.example.test1.mapper.StudentMapper;
import com.example.test1.mapper.UserMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Student;
import com.example.test1.model.User;

@Service
public class BoardService {

	@Autowired
	BoardMapper boardMapper;
   	
	public HashMap<String, Object> boardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
				
			List<Board> board = boardMapper.boardList(map);
						
		resultMap.put("input", board);	
		resultMap.put("result", "success");
			
		return resultMap;
	}
		
}
