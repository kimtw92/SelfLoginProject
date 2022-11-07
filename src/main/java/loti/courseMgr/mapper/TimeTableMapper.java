package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("courseMgrTimeTableMapper")
public interface TimeTableMapper {

	int selectWeekCnt(Map<String, Object> paramMap) throws SQLException;

	DataMap selectStartEndDateByNow(Map<String, Object> paramMap) throws SQLException;

	int selectTimeTableGrseqCnt(Map<String, Object> paramMap) throws SQLException;

	int selectSubjSeqCnt(Map<String, Object> paramMap) throws SQLException;

	DataMap selectTimeGosiList(Map<String, Object> paramMap) throws SQLException;

	String selectDualTableByOneCol1(Map<String, Object> paramMap) throws SQLException;
	
	String selectDualTableByOneCol2(Map<String, Object> paramMap) throws SQLException;
	
	String selectDualTableByOneCol3(Map<String, Object> paramMap) throws SQLException;

	DataMap selectTimeTableByPlan1(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectTimeTableByPlan2(Map<String, Object> paramMap) throws SQLException;

	DataMap selectTimeTableRow(DataMap requestMap) throws SQLException;

	DataMap selectTimeTableTuListBySubj(DataMap requestMap) throws SQLException;

	DataMap selectClassRoomByGrseqRow(Map<String, Object> paramMap) throws SQLException;

	DataMap selectClassTutorListByClassRoom(Map<String, Object> paramMap) throws SQLException;

	DataMap selectSubjSeqBySubjSearchList(Map<String, Object> paramMap) throws SQLException;

	int insertTimeTable(DataMap paramMap) throws SQLException;

	int insertTimeTableTu(DataMap tutorMap) throws SQLException;

	int selectTimeTableBySubjChk(Map<String, Object> paramMap) throws SQLException;

	int selectOutTimeTableChk(Map<String, Object> paramMap) throws SQLException;

	int deleteTimeTableTuBySubj(Map<String, Object> paramMap) throws SQLException;

	void updateTimeTable(Map<String, Object> paramMap) throws SQLException;

	DataMap selectClassTutorByTimeTableSubjList(Map<String, Object> paramMap) throws SQLException;

	int deleteTimeTableTuByDay(Map<String, Object> paramMap) throws SQLException;

	int deleteTimeTableByDay(Map<String, Object> paramMap) throws SQLException;

	int deleteTimeTableTuByGrseq(Map<String, Object> paramMap) throws SQLException;

	int deleteTimeTableByGrseq(Map<String, Object> paramMap) throws SQLException;

	int updateSubjSeqByLessonTime(Map<String, Object> paramMap) throws SQLException;

	DataMap selectTimeTableBySubjGubunCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGubunBySubjGubun() throws SQLException;

	DataMap selecttimeTableBySubjGubunList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectDualCalDateRow(Map<String, Object> paramMap) throws SQLException;

	DataMap selectTimeTableByPrint(Map<String, Object> paramMap) throws SQLException;

}
