package com.petboard.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDaoImpl implements MemberDao {
private SqlSessionTemplate sqlSessionTemplate;
	
	public MemberDaoImpl (SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	@Override // <!-- 로그인확인 -->
	public int loginCheck(String email, String password) {
		int check = -1;	// 아이디, 비밀번호 다 틀림 
		String pwd = sqlSessionTemplate.selectOne("login", email);
		
		if(pwd==null) {
			check = -1; // 아이디, 비밀번호 다 틀림 
		} else {
			if(pwd.equals(password)) {
				if(email.equals("lovecatlovedog1004@gmail.com")) {
					check = 0; // 관리자 로그인
				}
				else {
					check = 1; // 유저 로그인
				}
			} 
		}
		System.out.println("dao" + email);
		
		return check;
	}
		

	@Override//<!-- 관리자/유저 구별 -->
	public int adminCheck(String memberLevel) { 
	int check = 0;
	String level = sqlSessionTemplate.selectOne("유저 구별",memberLevel);
	if(level.equals(memberLevel)) {
		check = 0; // 관리자
	}
	else {
		check = 1; // 유저
	}
	System.out.println("관리자 = 0, 유저 = 1");
	System.out.println("계정 레벨은 " + memberLevel + "입니다");
	return check;
	
	}

	@Override  //<!-- 비밀번호 변경 (찾기) -->
	public int updatePwd(MemberVo memberVo) {
	
		return sqlSessionTemplate.update("updatePwd",memberVo);
	}

	@Override  //<!-- 마이페이지 --> <!-- 회원 정보 조회 -->
	public MemberVo selectUser(int memberNumber) {
		MemberVo vo = (MemberVo) sqlSessionTemplate.selectOne("selectUser",memberNumber);
		return vo;
	}

	@Override  //<!-- 회원 탈퇴(탈퇴체크) --> <!-- 비밀번호 체크 -->
	public String checkPwd(String email) {

		return sqlSessionTemplate.selectOne("checkPwd",email);
	}

	@Override  //<!-- 탈퇴 -->
	public int deleteUser(int memberNumber) {
		return sqlSessionTemplate.update("deleteUser", memberNumber);
	}

	@Override //<!-- 회원 정보 수정 -->
	public int updateUser(MemberVo memberVo) {

		return sqlSessionTemplate.update("updateUser", memberVo);
	}

	@Override  //<!-- 유저 찾기 -->
	public int findUser(String email) {
		
		return sqlSessionTemplate.selectOne("findUser", email);
	}
	@Override  //회원 등급 불러오기
	public int selectLevel(int memberNumber) {
		return sqlSessionTemplate.selectOne("selectLevel", memberNumber);
	}
	@Override //<!-- 가입자 수 -->
	public int userCount(String userStatus) {

		return sqlSessionTemplate.selectOne("userCount", userStatus);
	}

	@Override //<!-- 회원리스트 페이징 -->
	public int userPaging(String userStatus) {

		return sqlSessionTemplate.selectOne("userPaging", userStatus);
	}

	@Override //<!-- 이메일 중복확인 -->
	public int emailCheck(String email) {
		return sqlSessionTemplate.selectOne("emailCheck", email);
	}

	@Override // 유저 리스트
	public int userList(String email) {
		return sqlSessionTemplate.selectOne("userList", email);
	}

	@Override
	public String selectNick(String email) {
		return sqlSessionTemplate.selectOne("selectNick", email);
	}

	@Override
	public int selectMemberNum(String email) {		
		return sqlSessionTemplate.selectOne("userNum", email);
	}

	@Override
	public int nickNameCheck(String nickName) {
		return sqlSessionTemplate.selectOne("nicknameCheck", nickName);
	}

	@Override
	public int insertMember(MemberVo memberVo) {
		return sqlSessionTemplate.insert("join", memberVo);
	}

	@Override
	public List<MemberVo> userListAll(String memberStatus) {
		return sqlSessionTemplate.selectList("userListAll", memberStatus);
	}
	
	@Override
	//관리자 게시판 이메일 / 닉네임 검색
	public List<MemberVo> showNewOption(MemberVo memberVo) {

		 return sqlSessionTemplate.selectList("showNewOption", memberVo);
	}
}
