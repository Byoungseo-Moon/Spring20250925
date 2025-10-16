package com.example.test1.model;

import lombok.Data;
//
//lombok : get/set을 자동으로 만들어줌 ... get/set method불필요 (자동으로 만들어줌)
@Data
public class Member {
	
	private String userId;
	private String password;
	private String name;
	private String addr;
	private String birth;
	private String phone;
	private String gender;
	private String nickName;
	private String status;
	private String cdate;
	private String udate;
	private int cnt;
	private String cBirth;
	private String cPhone;
	
	private String fileNo;
	private String filePath;
	private String fileName;	
	
	
}
