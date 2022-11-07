package loti.homeFront.mapper;

import java.sql.SQLException;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import ut.lib.support.DataMap;

@Mapper
public interface PersonBoardMapper {

//	int selectBbsBoardPersonCount(String query) throws SQLException;

//	DataMap selectbbsBoardPersonView(Map<String, Object> params) throws SQLException;

//	int modifyBbsBoardPerson(Map<String, Object> params) throws SQLException;

//	int deleteBbsBoardPerson(String talbeName) throws SQLException;

	int selectBoardPersonListCount(Map<String, Object> params) throws SQLException;
	
	DataMap selectBoardPersonList(Map<String, Object> params) throws SQLException;
	
	DataMap selectBoardPersonView(Map<String, Object> params) throws SQLException;

	int modifyBoardPerson(Map<String, Object> params) throws SQLException;

	int insertBoardPerson(Map<String, Object> params) throws SQLException;

}
