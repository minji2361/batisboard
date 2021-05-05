package com.petboard.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.petboard.repository.BoardVo;
import com.petboard.repository.MemberDao;
import com.petboard.repository.MemberDaoImpl;
import com.petboard.repository.MemberVo;


@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDaoImpl memberDao;
	
	@Override
	public int loginCheck(String email, String password) {
		int check = memberDao.loginCheck(email, password);
		return check;
	}
	
	@Override
	public int emailCheck(String email) {
		return memberDao.emailCheck(email);
	}

	@Override
	public int adminCheck(String memberLevel) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updatePwd(MemberVo memberVo) {
		return memberDao.updatePwd(memberVo);
	}

	@Override
	public MemberVo selectUser(int memberNumber) {
		return memberDao.selectUser(memberNumber);
	}

	@Override
	public String checkPwd(String email) {
	 return memberDao.checkPwd(email);
	}
	
	@Override
    public int deleteUser(int memberNumber) throws Exception{
        
        return memberDao.deleteUser(memberNumber); 

    }

	@Override
	public int updateUser(MemberVo memberVo) {
		
		return memberDao.updateUser(memberVo);
	}


	@Override
	public int findUser(String email) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int selectLevel(int memberNumber) {
		return memberDao.selectLevel(memberNumber);
	}

	
	@Override
	public int userCount(String memberStatus) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int userPaging(String memberStatus) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String selectNick(String email) {
		return memberDao.selectNick(email);
	}

	@Override
	public int selectMemberNum(String email) {
		return memberDao.selectMemberNum(email);
	}

	@Override
	public int nickNameCheck(String nickName) {
		return memberDao.nickNameCheck(nickName);
	}

	@Override
	public int insertMember(MemberVo memberVo) {
		return memberDao.insertMember(memberVo);
	}

	@Override
	public List<MemberVo> userListAll(String memberStatus) {
		return memberDao.userListAll(memberStatus);
	}
	
	@Override  	//관리자 게시판 이메일 / 닉네임 검색
	public List<MemberVo> showNewOption(MemberVo memberVo) {
		List<MemberVo> list  = memberDao.showNewOption(memberVo);
		return list;
	}
	
}
