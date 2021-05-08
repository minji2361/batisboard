package com.petboard.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PutMapping;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	
	@Inject
	private SqlSessionTemplate sqlSessionTemplate;
	
	public BoardDaoImpl(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	public void setSqlMapClient(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	@Override
	//목록보기
	public List<BoardVo> showList(String type) {
		return sqlSessionTemplate.selectList("showList", type);
	}
	@Override
	//오래된순 리스트
	public List<BoardVo> oldList(String type) {
		return sqlSessionTemplate.selectList("oldList", type);
	}
	@Override
	//추천순 리스트
	public List<BoardVo> LikecountList(String type){
		return sqlSessionTemplate.selectList("LikeCountList", type);
	}
	@Override
	//조회순 리스트
	public List<BoardVo> readcountList(String type){
		return sqlSessionTemplate.selectList("readcountList", type);
	}
	@Override
	//공지글 리스트
	public List<BoardVo> noticeList(String type){
		return sqlSessionTemplate.selectList("noticeList", type);
	}
	
	@Override
	//글삭제
	public int deleteWrite(int boardNumber) {
		return sqlSessionTemplate.update("deleteWrite",boardNumber);
	}
	@Override
	//글 수정
	public int updateWrite(BoardVo boardVo) {
		return sqlSessionTemplate.update("updateWrite",boardVo);
	}
	@Override
	//글작성
	public int write(BoardVo boardVo) {
		return sqlSessionTemplate.insert("write", boardVo);
	}
	
	@Override
	//글보기
	public BoardVo select(int boardNumber) {
		BoardVo vo= (BoardVo) sqlSessionTemplate.selectOne("selectOne", boardNumber);
		return vo;
	}
	@Override
	//글 조회수
	public int addReadcount(int boardNumber) {
		return sqlSessionTemplate.update("addReadcount", boardNumber);
	}
	@Override
	//추천수 업
	public int plusLikecount(int boardNumber) {
		return sqlSessionTemplate.update("plusLikecount",boardNumber);
	}
	//추천수 다운
	public int minusLike(int boardNumber) {
		return sqlSessionTemplate.update("minusLike",boardNumber);
	}
	//글 작성자 확인 

	@Override
	public String checkNickBoard(int boardNumber) {
		return sqlSessionTemplate.selectOne("checkNickBoard",boardNumber);
		
	}
	
	@Override
	// 닉네임 검색
	public List<BoardVo> searchNickname(BoardVo boardVo){
		return sqlSessionTemplate.selectList("searchNickname",boardVo);
	}
	@Override
	// 제목검색
	public List<BoardVo> searchTitle(BoardVo boardVo){
		return sqlSessionTemplate.selectList("searchTitle", boardVo);
	}
	
	@Override
	// 내용검색
	public List<BoardVo> searchContent(BoardVo boardVo){
		return sqlSessionTemplate.selectList("searchContent", boardVo);
	}
	@Override
	// 지역검색
	public List<BoardVo> searchArea(BoardVo boardVo){
		return sqlSessionTemplate.selectList("searchArea", boardVo);
	}
	@Override
	// 닉네임검색 더보기
	public List<BoardVo> moreNickname(BoardVo boardVo){
		return sqlSessionTemplate.selectList("moreNickname", boardVo);
	}
	@Override
	// 제목검색 더보기
	public List<BoardVo> moreTitle(BoardVo boardVo){
		return sqlSessionTemplate.selectList("moreTitle", boardVo);
	}
	@Override
	// 내용검색 더보기
	public List<BoardVo> moreContent(BoardVo boardVo){
		return sqlSessionTemplate.selectList("moreContent", boardVo);
	}
	@Override
	// 지역검색 더보기
	public List<BoardVo> moreArea(BoardVo boardVo){
		return sqlSessionTemplate.selectList("moreArea", boardVo);
	}
	
	//내가 쓴 글 리스트
	@Override
	public List<BoardVo> myWriteList(String nickName) {
		return sqlSessionTemplate.selectList("myWriteList", nickName);
	}
	
	@Override	//내가 작성한 글 갯수
	public int countWrite(int memberNumber) {
		return sqlSessionTemplate.selectOne("countWrite", memberNumber);
	}
	
	@Override	//삭제된 글 리스트
	public List<BoardVo> deleteWriteList(char boardStatus) {
		return sqlSessionTemplate.selectList("deleteWriteList", boardStatus);
	}

	@Override	//삭제 된 글 갯수
	public int deleteWriteCount(char boardStatus) {	
		return sqlSessionTemplate.selectOne("deleteWriteCount", boardStatus);
	}

	@Override	//작성된 글 총 갯수
	public int writeListAll(String boardStatus) {
		return sqlSessionTemplate.selectOne("writeListAll", boardStatus);
	}

	@Override	//보드리스트 페이징
	public int boardPaging(String boardStatus) {
		return sqlSessionTemplate.selectOne("boardPaging", boardStatus);
	}

	@Override	//삭제된 글 리스트 페이징
	public int deletePaging(String boardStatus) {
		return sqlSessionTemplate.selectOne("deletePaging", boardStatus);
	}



	@Override
	// 댓글 작성
	public int insertReply(ReplyVo replyVo) {
		return sqlSessionTemplate.insert("insertReply", replyVo);
	}
	@Override
	// 댓글 목록
	public List<ReplyVo> selectReply(int boardNumber) {
		return sqlSessionTemplate.selectList("selectReply", boardNumber);
	}
	@Override
	// 댓글 작성자 확인
	public String checkNickReply(int boardNumber) {
		return sqlSessionTemplate.selectOne("selectReply", boardNumber);
	}
	@Override
	// 댓글 번호 확인
	public int checkReplyNum(int boardNumber) {
		return sqlSessionTemplate.selectOne("checkReplyNum", boardNumber);
	}
	@Override
	// 댓글 수정
	public int updateReply (ReplyVo replyVo) {
		return sqlSessionTemplate.update("updateReply", replyVo);
	}
	@Override
	// 댓글 삭제
	public int deleteReply (int replyNumber) {
		return sqlSessionTemplate.delete("deleteReply", replyNumber);
	}
	@Override
	// 댓글 수 확인
	public int countReply (int boardNumber) {
		return sqlSessionTemplate.selectOne("countReply", boardNumber);
	}
	@Override
	//추천하기
	public int updateLike (Map<String, Object>m) {
		return sqlSessionTemplate.insert("updateLike", m);
	}
	@Override
	//추천취소
	public int deleteLike (Map<String, Object>m){
		return sqlSessionTemplate.delete("deleteLike", m);
	}
	@Override
	//추천수
	public int countLike (int boardNumber) {
		return sqlSessionTemplate.selectOne("countLike", boardNumber);
	}
	@Override
	//추천 중복 확인
	public int checkLike(Map<String, Object>m) {
		return sqlSessionTemplate.selectOne("checkLike", m);
	}
	
	@Override
	//애견치료소게시판 리스트 조회
	public List<BoardVo> showNewList(String type,String oder,int start,int end){
		Map<String,Object> map =new HashMap<String, Object>();
		map.put("type",type);
		map.put("oder",oder);
		map.put("start",start);
		map.put("end",end);
		return sqlSessionTemplate.selectList("showNewList", map);
	}
	
	@Override
	//애견치료소게시판 게시글 수 조회
	public int showNewListCount(String type) {

		return sqlSessionTemplate.selectOne("showNewListCount", type);
	}
	
	
	@Override
    //애견치료소게시판 게시글열람
    public BoardVo showNewSelect(BoardVo boardVo) {
        return sqlSessionTemplate.selectOne("showNewSelect", boardVo);
    }


	/*
	 * @Override //관리자 게시판 작성글 public List<BoardVo> showNewStatus(int start, int
	 * end) { Map<String,Object> map =new HashMap<String, Object>();
	 * map.put("start",start); map.put("end",end); return
	 * sqlSessionTemplate.selectList("showNewStatus", map); }
	 * 
	 * @Override //관리자 게시판 삭제글 public List<BoardVo> showNewDelect(int start2, int
	 * end2) { Map<String,Object> map =new HashMap<String, Object>();
	 * map.put("start2",start2); map.put("end2",end2); return
	 * sqlSessionTemplate.selectList("showNewStatus", map); }
	 */
	
	//통합검색 제목 내용 작성자(닉네임)
	@Override
	public List<BoardVo> showNewsearchType(BoardVo boardVo) {

		 return sqlSessionTemplate.selectList("showNewsearchType", boardVo);
	}

	/*
	 * //관리자 게시판 작성 게시글 수
	 * 
	 * @Override public int showNewStatusCount(String count) { return
	 * sqlSessionTemplate.selectOne("showNewStatusCount", count); }
	 * 
	 * //관리자 게시판 삭제 게시글 수
	 * 
	 * @Override public int showNewDelectCount(String count) { return
	 * sqlSessionTemplate.selectOne("showNewDelectCount", count); }
	 */

	@Override
	//관리자 게시판 작성글/삭제글
	public List<BoardVo> showNewStatus(BoardVo boardVo) {

		 return sqlSessionTemplate.selectList("showNewStatus", boardVo);
	}
	

	
}