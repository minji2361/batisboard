package service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import repository.BboardVo;
import repository.Criteria;

public interface IBboardService {
	
	// 글 등록
	public boolean insertContent(BboardVo board);
	
	// 글 전체 조회
	public List<BboardVo> showList();
	
	// 글 1개 세부내용 확인
	public BboardVo getContentInfo(String id);
	
	// 글 수정
	public boolean updateContent(BboardVo board, String id);
	
	// 글 삭제
	public boolean deleteContent(String id);
	
	// 글 검색
	public List<BboardVo> searchWriter(String search);
	
//	// 페이징
//	public List<BboardVo> boardPaging(Criteria cri);
//	
//	// 글 갯수
//	public int listCount();
	
}
