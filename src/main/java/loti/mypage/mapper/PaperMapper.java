package loti.mypage.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper
public interface PaperMapper {

	DataMap paperNewCount(String sessNo) throws SQLException;

	int paperUpdate(DataMap requestMap) throws SQLException;

	int paperListCount(Map<String, Object> params) throws SQLException;
	
	DataMap paperList(Map<String, Object> params) throws SQLException;

	int memberListCount(String search) throws SQLException;

	DataMap memberList(Map<String, Object> pageInfo) throws SQLException;

	int paperInsert(DataMap requestMap) throws SQLException;

	int paperDelete(Map<String, Object> params) throws SQLException;

	int paperDeleteAll(Map<String, Object> params) throws SQLException;

}
