package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface OutTimeTableMapper {

	DataMap selectOutTimeTableByEtcRow(String date) throws SQLException;

	DataMap selectOutTimeTableList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectOutTimeTableByWeekDateRow(String date) throws SQLException;

	DataMap selectClassRoomList() throws SQLException;

	DataMap selectClassRoomRow(String classNo) throws SQLException;

	DataMap selectOutTimeTableRow(Map<String, Object> paramMap) throws SQLException;

	DataMap selectOutTimeTableByStudytimeChkList(Map<String, Object> paramMap) throws SQLException;

	int deleteOutTimeTable(Map<String, Object> paramMap) throws SQLException;

	int deleteOutTimeTableInfo(Map<String, Object> paramMap) throws SQLException;

	int selectOutTimeTableInfoMaxSeq() throws SQLException;

	int insertOutTimeTableInfo(Map<String, Object> paramMap) throws SQLException;

	void insertOutTimeTable(Map<String, Object> paramMap) throws SQLException;

	int updateOutTimeTableInfo(Map<String, Object> paramMap) throws SQLException;

}
