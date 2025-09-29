package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student;
import com.example.test1.model.User;

@Mapper
public interface StudentMapper {
	
	Student studentInfo(HashMap<String, Object> map);	// return이 한개일 때
	
	List<Student> studentList(HashMap<String, Object> map);  // return이 2개 이상이면 list로	
	
	int deleteStudent(HashMap<String, Object> map);
	
	//학생성적조회
	Student selectStudent(HashMap<String, Object> map);
	
}
