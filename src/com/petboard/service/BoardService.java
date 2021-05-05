package com.petboard.service;

import java.util.List;
import java.util.Map;

import com.petboard.repository.BoardVo;
import com.petboard.repository.LikeCountVo;
import com.petboard.repository.ReplyVo;

public interface BoardService {
	
	//최신순 리스트(디폴트 리스트)
	public abstract List<BoardVo> showList(String type);
	//오래된순 리스트
	public abstract List<BoardVo> oldList(String type);
	//추천순 리스트
	public abstract List<BoardVo> likecountList(String type);
	//조회순 리스트
	public abstract List<BoardVo> readcountList(String type);
	//공지 글
	public abstract List<BoardVo> noticeList(String type);
	//글쓰기
	public abstract int write(BoardVo boardVo);
	//글 하나 불러오기
	public abstract BoardVo select(int boardNumber);
	//조회수 증가
	//public abstract int addReadcount(int boardNumber);
	//추천수 1증가
	public abstract int plusLikecount(int boardNumber);
	//추천수 1감소
	public abstract int minusLikecount(int boardNumber);
	//수정
	public abstract int updateWrite(BoardVo boardVo);
	//삭제
	public abstract int deleteWrite(int boardNumber);
	//글 작성자 확인
	public abstract String checkNickBoard(int boardNumber);
	//닉네임으로 글검색
	public abstract List<BoardVo> searchNickname(BoardVo boardVo);
	//제목으로 글검색
	public abstract List<BoardVo> searchTitle(BoardVo boardVo);
	//내용으로 글검색
	public abstract List<BoardVo> searchContent(BoardVo boardVo);
	//지역으로 글검색
	public abstract List<BoardVo> searchArea(BoardVo boardVo);
	//내가 쓴 글 리스트(유저페이지)
	public abstract List<BoardVo> myWriteList(String nickName);
	//내가 작성한 글 갯수(유저페이지)
	public abstract int countWrite (int memberNumber);
	//삭제 된 글 리스트(관리자 페이지)
	public abstract List<BoardVo> deleteWriteList (char boardStatus);
	//삭제된 글 갯수(관리자 페이지)
	public abstract int deleteWriteCount (char boardStatus);
	//작성된 글 총 갯수(관리자 페이지)
	public abstract int writeListAll (String boardStatus);
	//보드리스트 페이징
	public int boardPaging (String boardStatus);
	//삭제된 글 리스트 페이징
	public int deletePaging (String boardStatus);
	
	//댓글 작성
	public abstract int insertReply(ReplyVo replyVo);
	//댓글 리스트 불러오기
	public abstract List<ReplyVo> selectReply(int boardNumber);
	//댓글 작성자 확인
	public abstract String checkNickReply(int boardNumber);
	//댓글 번호 확인
	public abstract int checkReplyNum(int boardNumber);
	//댓글 수정
	public abstract int updateReply(ReplyVo replyVo);
	//댓글 삭제
	public abstract int deleteReply(int replyNumber);
	//댓글 카운트
	public abstract int countReply(int boardNumber);
	
	
	
	//추천하기
	public abstract int updateLike(Map<String, Object>m);
	//추천취소
	public abstract int deleteLike(Map<String, Object>m);
	//추천수 카운트
	public abstract int countLike(int boardNumber);
	//추천 중복 확인
	public abstract int checkLike(Map<String, Object>m);
	
	//애견치료소게시판 리스트 조회
	public abstract List<BoardVo> showNewList(String type,String oder,int start,int end);
	
	//애견치료소게시판 게시글 수 조회
	public abstract int showNewListCount(String type);
	
	//관리자 게시판 유저 검색
	public abstract BoardVo showNewSelect(BoardVo boardVo);
	
	//관리자 게시판 작성글/삭제글
	public abstract List<BoardVo> showNewStatus(BoardVo boardVo);

	//통합검색 제목 내용 작성자(닉네임)
	public abstract List<BoardVo> showNewsearchType(BoardVo boardVo);
}

