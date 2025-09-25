package com.example.test1.model;

//import lombok.Data;
//
//@Data
public class Board {
	private int boradNo;
	private String title;
	private String contents;
	private String userId;
	private int cnt;
	private int favorite;
	private int kind;
	private String cDateTime;
	private String uDateTime;
	
	public int getBoradNo() {
		return boradNo;
	}
	public void setBoradNo(int boradNo) {
		this.boradNo = boradNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getFavorate() {
		return favorite;
	}
	public void setFavorate(int favorate) {
		this.favorite = favorate;
	}
	public int getKind() {
		return kind;
	}
	public void setKind(int kind) {
		this.kind = kind;
	}
	public String getcDateTime() {
		return cDateTime;
	}
	public void setcDateTime(String cDateTime) {
		this.cDateTime = cDateTime;
	}
	public String getuDateTime() {
		return uDateTime;
	}
	public void setuDateTime(String uDateTime) {
		this.uDateTime = uDateTime;
	}
		
	
}		
	