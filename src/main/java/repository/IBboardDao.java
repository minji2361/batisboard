package repository;

import java.util.List;

public interface IBboardDao {

	// 글 등록
	public int insertContent(BboardVo board);
	
	// 글 전체 조회
	public List<BboardVo> showList();
	
	// 글 1개 세부내용 확인
	public BboardVo getContentInfo(String id);
	
	// 글 수정
	public int updateContent(BboardVo board);
	
	// 글 삭제
	public int deleteContent(String id);
	
	// 글 검색 (작성자 검색)
	public List<BboardVo> searchWriter(String search);
	
//	// 페이징
//	public List<BboardVo> boardPaging(Criteria cri);
//	
//	// 글 갯수
//	public int listCount();
	
}
