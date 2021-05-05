package com.petboard.service;

import java.util.List;

import com.petboard.repository.BoardVo;
import com.petboard.repository.MemberVo;

public interface MemberService {

	public int loginCheck(String email, String password); // <!-- 로그인확인 -->	
	
	public int emailCheck(String email); // <!-- 이메일 중복 검사 -->
	
	public int nickNameCheck(String nickName); // <!-- 닉네임 중복 검사 -->
	
	public int insertMember(MemberVo memberVo); // <!-- 회원가입 -->

	public int adminCheck(String memberLevel); //<!-- 관리자/유저 구별 -->
	
	public int updatePwd(MemberVo memberVo); //<!-- 비밀번호 변경 (찾기) -->
	
	public MemberVo selectUser(int memberNumber); //<!-- 마이페이지 --> <!-- 회원 정보 조회 -->
	
	public String checkPwd (String email) throws Exception;//<!-- 회원 탈퇴(탈퇴체크) --> <!-- 비밀번호 체크 -->
	
	public int deleteUser (int memberNumber) throws Exception;//<!-- 탈퇴 -->
	
	public int updateUser (MemberVo memberVo);//<!-- 회원 정보 수정 -->
		
	public int findUser (String email);//<!-- 유저 찾기 -->
	
	public int selectLevel(int memberNumber); //회원등급 불러오기
	
	public int userCount (String memberStatus);//<!-- 가입자 수 -->
	
	public int userPaging (String memberStatus);//<!-- 회원리스트 페이징 -->

	
	
	public String selectNick(String email); //닉네임 불러오기
	
	public int selectMemberNum(String email); //멤버넘버 불러오기
	
	public List<MemberVo> userListAll(String memberStatus);	//유저 전체리스트 (관리자페이지)

	//관리자 게시판 이메일 / 닉네임 검색
	public List<MemberVo> showNewOption(MemberVo memberVo);
	
}
