package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("courseMgrStuOutMapper")
public interface StuOutMapper {

	DataMap selectAppRejectList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppRejectRow(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByNameSearchList(Map<String, Object> paramMap) throws SQLException;

	int selectGrResultChk(Map<String, Object> paramMap) throws SQLException;

	int insertAppRejectSpec(DataMap requestMap) throws SQLException;

	int insertRejStuLecSpec(DataMap requestMap) throws SQLException;

	int insertRejReportSubmitSpec(DataMap requestMap) throws SQLException;

	int insertRejExresultSpec(DataMap requestMap) throws SQLException;

	int deleteExResultSpec(DataMap requestMap) throws SQLException;

	int deleteReportSubmitSpec(DataMap requestMap) throws SQLException;

	int deleteStuLecSpec(DataMap requestMap) throws SQLException;

	int deleteAppReject(DataMap requestMap) throws SQLException;

	int deleteRejExResultSpec(DataMap requestMap) throws SQLException;

	int deleteRejReportSubmitSpec(DataMap requestMap) throws SQLException;

	int deleteRejStuLecSpec(DataMap requestMap) throws SQLException;

	int deleteAppInfo(DataMap requestMap) throws SQLException;

	int insertStuLecByRejSpec(DataMap requestMap) throws SQLException;

	int insertReportSubmitByRejSpec(DataMap requestMap) throws SQLException;

	int insertExResultByRejSpec(DataMap requestMap) throws SQLException;

}
