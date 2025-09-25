package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.BoardService;
import com.example.test1.dao.StudentService;
import com.example.test1.dao.UserService;
import com.google.gson.Gson;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("/board-list.do") 
    public String list(Model model) throws Exception{

        return "/board-list";
    }
	
//	@RequestMapping(value = "/stu-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public String studentinfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		
//		resultMap = studentService.studentInfo(map);		
//		
//		return new Gson().toJson(resultMap);
//	}
//	
	@RequestMapping(value = "/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardlist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();		
		
		resultMap = boardService.boardList(map);
		
		return new Gson().toJson(resultMap);
	}

}
