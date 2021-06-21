package com.petboard.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.petboard.repository.BoardDao;
import com.petboard.repository.BoardDaoImpl;
import com.petboard.repository.BoardVo;
import com.petboard.repository.LikeCountVo;
import com.petboard.repository.ReplyVo;

@Service
public class BoardServiceImpl implements BoardService{

	@Inject
	private BoardDaoImpl boardDao;

	@Override	//최신순 리스트(디폴트)
	public List<BoardVo> showList(String type) {
		List<BoardVo> list = boardDao.showList(type);
		return list;
	}

	@Override	//오래된 순 리스트
	public List<BoardVo> oldList(String type) {
		List<BoardVo> list = boardDao.oldList(type);
		return list;
	}

	@Override	//추천순 리스트
	public List<BoardVo> likecountList(String type) {
		List<BoardVo> list = boardDao.LikecountList(type);
		return list;
	}

	@Override	//조회순 리스트
	public List<BoardVo> readcountList(String type) {
		List<BoardVo> list = boardDao.readcountList(type);
		return list;
	}

	@Override	//공지글 리스트
	public List<BoardVo> noticeList(String type) {
		List<BoardVo> list = boardDao.noticeList(type);
		return list;
	}

	@Override	//글작성
	public int write(BoardVo boardVo) {
		return boardDao.write(boardVo);
	}

	@Override	//글 내용 보기
	public BoardVo select(int boardNumber) {
		boardDao.addReadcount(boardNumber);
		return boardDao.select(boardNumber);
	}

	@Override	//추천수 1증가
	public int plusLikecount(int boardNumber) {		
		return boardDao.plusLikecount(boardNumber);
	}

	@Override	//추천수 1감소
	public int minusLikecount(int boardNumber) {
		return boardDao.minusLike(boardNumber);
	}

	@Override	//수정
	public int updateWrite(BoardVo boardVo) {
		return boardDao.updateWrite(boardVo);
	}

	@Override	//글삭제
	public int deleteWrite(int  boardNumber) {		
		return boardDao.deleteWrite(boardNumber);
	}

	@Override	//닉네임으로 글검색
	public List<BoardVo> searchNickname(BoardVo boardVo) {		
		return boardDao.searchNickname(boardVo);
	}

	@Override	//제목으로 글검색
	public List<BoardVo> searchTitle(BoardVo boardVo) {
		return boardDao.searchTitle(boardVo);
	}

	@Override	//내용으로 글검색
	public List<BoardVo> searchContent(BoardVo boardVo) {
		return boardDao.searchContent(boardVo);
	}

	@Override	//지역으로 글검색
	public List<BoardVo> searchArea(BoardVo boardVo) {
		return boardDao.searchArea(boardVo);
	}
	
	@Override	//내가 쓴 글 리스트(유저페이지)
	public List<BoardVo> myWriteList(String nickName){
		List<BoardVo> list = boardDao.myWriteList(nickName);
		return list;
	}
	
	@Override	//내가 작성한 글 갯수(유저페이지)
	public int countWrite(int memberNumber) {
	
		return boardDao.countWrite(memberNumber);
	}

	@Override	//삭제 된 글 리스트(관리자 페이지)
	public List<BoardVo> deleteWriteList(char boardStatus) {
		return boardDao.deleteWriteList(boardStatus);
	}

	@Override	//삭제된 글 갯수(관리자 페이지)
	public int deleteWriteCount(char boardStatus) {
		return boardDao.deleteWriteCount(boardStatus);
	}

	@Override	//작성된 글 총 갯수(관리자 페이지)
	public int writeListAll(String boardStatus) {
		return boardDao.writeListAll(boardStatus);
	}

	@Override	//보드리스트 페이징
	public int boardPaging(String boardStatus) {
		return boardDao.boardPaging(boardStatus);
	}

	@Override	//삭제된 글 리스트 페이징
	public int deletePaging(String boardStatus) {
		return boardDao.deletePaging(boardStatus);
	}



	@Override	//댓글 작성
	public int insertReply(ReplyVo replyVo) {
		return boardDao.insertReply(replyVo);
	}

	@Override	//댓글 리스트 불러오기
	public List<ReplyVo> selectReply(int boardNumber) {
		return boardDao.selectReply(boardNumber);
	}

	@Override	//댓글 수정
	public int updateReply(ReplyVo replyVo) {		
		return boardDao.updateReply(replyVo);
	}

	@Override	//댓글 삭제
	public int deleteReply(int replyNumber) {
		return boardDao.deleteReply(replyNumber);
	}

	@Override	//댓글 카운트
	public int countReply(int boardNumber) {
		return boardDao.countReply(boardNumber);
	}

	@Override 	//추천하기
	public int updateLike(Map<String, Object>m) {
		return boardDao.updateLike(m);
	}

	@Override	//추천취소
	public int deleteLike(Map<String, Object>m) {
		return boardDao.deleteLike(m);
	}

	@Override	//추천수 카운트
	public int countLike(int boardNumber) {
		return boardDao.countLike(boardNumber);
	}
	@Override
	public int checkLike(Map<String, Object>m) {
		return boardDao.checkLike(m);
	}

	
	@Override	//글 작성자 확인
	public String checkNickBoard(int boardNumber) {
		return boardDao.checkNickBoard(boardNumber);
	}

	@Override	//댓글 작성자 확인
	public String checkNickReply(int boardNumber) {
		return boardDao.checkNickReply(boardNumber);
	}
	
	@Override
	public int checkReplyNum(int boardNumber) {
		return boardDao.checkReplyNum(boardNumber);
	}
	
	@Override	//애견치료소게시판 리스트 조회
	public List<BoardVo> showNewList(String type,String oder,int start,int end) {
		List<BoardVo> list = boardDao.showNewList(type,oder,start,end);
		return list;
	}
	
	@Override	//애견치료소게시판 게시글 수 조회
	public int showNewListCount(String type) {
		return boardDao.showNewListCount(type);
	}
	
	@Override	//애견치료소게시판 게시글열람
	public BoardVo showNewSelect(BoardVo boardVo) {
		BoardVo select = boardDao.showNewSelect(boardVo);
		return select;
	}

	@Override  	//관리자 게시판 작성글/삭제글
	public List<BoardVo> showNewStatus(BoardVo boardVo) {
		List<BoardVo> list  = boardDao.showNewStatus(boardVo);
		return list;
	}

	@Override  	//통합검색 제목 내용 작성자(닉네임)
	public List<BoardVo> showNewsearchType(BoardVo boardVo) {
		List<BoardVo> list  = boardDao.showNewsearchType(boardVo);
		return list;
	}

	
}
