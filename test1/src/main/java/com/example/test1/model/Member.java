package com.example.test1.model;

import lombok.Data;

@Data
public class Member {
	
	private String userId;
	private String passWord;
	private String name;
	private String birth;
	private String nickName;
	private String status;
	
	// lombok : get/set을 자동으로 만들어줌 ... get/set method불필요 (자동으로 만들어줌)
	
	
}
