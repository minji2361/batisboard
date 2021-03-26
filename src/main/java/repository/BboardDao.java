package repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("bboardDao")
public class BboardDao implements IBboardDao{

	private SqlSessionTemplate sqlSessionTemplate;
	
	public BboardDao (SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	
	@Override
	public int insertContent(BboardVo board) {
		return sqlSessionTemplate.insert("insertContent", board);
	}

	@Override
	public List<BboardVo> showList() {
		return sqlSessionTemplate.selectList("showList");
	}

	@Override
	public BboardVo getContentInfo(String id) {
		sqlSessionTemplate.update("readCountUp", id);
		return sqlSessionTemplate.selectOne("getContentInfo", id);
	}

	@Override
	public int updateContent(BboardVo board) {
		return sqlSessionTemplate.update("updateContent", board);
		
	}

	@Override
	public int deleteContent(String id) {
		return sqlSessionTemplate.delete("deleteContent", id);
	}


	@Override
	public List<BboardVo> searchWriter(String search) {
		return sqlSessionTemplate.selectList("searchWriter", search);
	}
	
}
