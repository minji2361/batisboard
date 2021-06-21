package com.petboard.repository;

import java.sql.Timestamp;

public class ReplyVo {
	
	private int replyNumber;
	private int memberNumber;
	private String email;
	private int boardNumber;
	private String replyText;
	private String nickName;
	private Timestamp regDate;
	private char replyStatus;
	
	public ReplyVo() {}
	
	public ReplyVo(int replyNumber, int memberNumber, String email, int boardNumber, String replyText, 
			String nickName, Timestamp regDate, char replyStatus) {
		super();
		this.replyNumber = replyNumber;
		this.memberNumber = memberNumber;
		this.email = email;
		this.boardNumber = boardNumber;
		this.replyText = replyText;
		this.nickName = nickName;
		this.regDate = regDate;
		this.replyStatus = replyStatus;
	}

	public int getReplyNumber() {
		return replyNumber;
	}

	public void setReplyNumber(int replyNumber) {
		this.replyNumber = replyNumber;
	}

	public int getMemberNumber() {
		return memberNumber;
	}

	public void setMemberNumber(int memberNumber) {
		this.memberNumber = memberNumber;
	}
	
		public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getBoardNumber() {
		return boardNumber;
	}

	public void setBoardNumber(int boardNumber) {
		this.boardNumber = boardNumber;
	}

	public String getReplyText() {
		return replyText;
	}

	public void setReplyText(String replyText) {
		this.replyText = replyText;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public char getReplyStatus() {
		return replyStatus;
	}

	public void setReplyStatus(char replyStatus) {
		this.replyStatus = replyStatus;
	}
	

}
