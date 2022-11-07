package loti.tutorMgr.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface AllowanceMapper {

	DataMap selectAllowanceList() throws SQLException;

	DataMap selectAllowanceRow(String tlevel) throws SQLException;

	DataMap selectLevelgruList(String tlevel) throws SQLException;

	String selectLevelName(String tlevel) throws SQLException;

	DataMap selectLevelgruRow(Map<String, Object> params) throws SQLException;

	int insertLevelgru(DataMap requestMap) throws SQLException;

	int modifyLevelgru(DataMap requestMap) throws SQLException;

	int deleteLevelgru(DataMap requestMap) throws SQLException;

	int selectAllowanceCount(String tlevel) throws SQLException;

	int insertAllowance(DataMap requestMap) throws SQLException;

	int insertLevel(DataMap requestMap) throws SQLException;

	int modifyAllowance(DataMap requestMap) throws SQLException;

	int modifyLevel(DataMap requestMap) throws SQLException;

}
