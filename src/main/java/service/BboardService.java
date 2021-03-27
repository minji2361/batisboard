package service;

import java.util.List;

import org.springframework.stereotype.Service;

import repository.BboardDao;
import repository.BboardVo;
import repository.Criteria;

@Service("bboardService")
public class BboardService implements IBboardService{
	
	private BboardDao boardDao;
	public void setBboardDao(BboardDao boardDao) {
		this.boardDao = boardDao;
	}

	@Override
	public boolean insertContent(BboardVo board) {
		boolean check = false;
		int insert = boardDao.insertContent(board);	
		if (insert == 1) check = true;	//등록 성공
		else check = false;	//등록 실패
		
		return check;
	}

	@Override
	public List<BboardVo> showList() {
		List<BboardVo> list = boardDao.showList();
		return list;
	}

	@Override
	public BboardVo getContentInfo(String id) {
		BboardVo board = boardDao.getContentInfo(id);
		return board;
	}

	@Override
	public boolean updateContent(BboardVo board, String id) {
		boolean update = false;	// 수정 실패
		board.setId(id);
		int check = boardDao.updateContent(board);
		//System.out.println(board.getId());
		if(check == 1) update = true;	//수정 성공 
		else update = false;
		
		return update;
	}

	@Override
	public boolean deleteContent(String id) {
		boolean delete = false;		//삭제 실패
		int check = boardDao.deleteContent(id);
		if(check == 1) delete = true;	//삭제 실패
		else delete = false;
		
		return delete;
	}

	@Override
	public List<BboardVo> searchWriter(String search) {
		List<BboardVo> list = boardDao.searchWriter(search);
		return list;
	}

//	@Override
//	public List<BboardVo> boardPaging(Criteria cri) {
//		return boardDao.boardPaging(cri);
//	}
//
//	@Override
//	public int listCount() {
//		return boardDao.listCount();
//	}

}
