package com.example.test1.model;

import lombok.Data;
//
//lombok : get/set을 자동으로 만들어줌 ... get/set method불필요 (자동으로 만들어줌)
@Data
public class Member {
	
	private String userId;
	private String pwd;
	private String name;
	private String addr;
	private String phone;
	private String gender;
	private String status;
	private String cdate;
	private String udate;
	
	private String fileNo;
	private String filePath;
	private String fileName;
		
	
}
