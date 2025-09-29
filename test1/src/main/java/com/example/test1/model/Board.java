package com.example.test1.model;

//import lombok.Data;
//
//@Data  ---- get set이 필요 없음
public class Board {
	private int boardNo;
	private String title;
	private String contents;
	private String userId;
	private int cnt;
	private int favorite;
	private int kind;
	private String cDate;
	private String uDate;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
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
	public String getcDate() {
		return cDate;
	}
	public void setcDateTime(String cDate) {
		this.cDate = cDate;
	}
	public String getuDateTime() {
		return uDate;
	}
	public void setuDateTime(String uDate) {
		this.uDate = uDate;
	}
		
	
}		
	