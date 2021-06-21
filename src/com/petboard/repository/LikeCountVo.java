package com.petboard.repository;

public class LikeCountVo {

	private int memberNumber;
	private String email;
	private int boardNumber;
	private char likeCount;
	
	public LikeCountVo() {}
	
	public LikeCountVo(int memberNumber, String email, int boardNumber, char likeCount) {
		super();
		this.memberNumber = memberNumber;
		this.email = email;
		this.boardNumber = boardNumber;
		this.likeCount = likeCount;
	}

	public int getMemberNumber() {
		return memberNumber;
	}

	public void setMemberNumber(int memberNumber) {
		this.memberNumber = memberNumber;
	}

	public int getBoardNumber() {
		return boardNumber;
	}

	public void setBoardNumber(int boardNumber) {
		this.boardNumber = boardNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public char getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(char likeCount) {
		this.likeCount = likeCount;
	}

	
	
	
	
}
