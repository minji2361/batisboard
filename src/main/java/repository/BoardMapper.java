package repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class BoardMapper implements RowMapper<BboardVo>{
		public BboardVo mapRow(ResultSet rs, int rowNum) throws SQLException{
			return new BboardVo (
				rs.getString("ID"),
				rs.getString("WRITER"),
				rs.getString("TITLE"),
				rs.getTimestamp("WRITEDATE"),
				rs.getString("CONTENT"),
				rs.getInt("READCOUNT"),
				rs.getString("FILE_NAME"),
				rs.getString("FILE_TYPE"),
				rs.getString("FILE_PATH"));
		}
}
