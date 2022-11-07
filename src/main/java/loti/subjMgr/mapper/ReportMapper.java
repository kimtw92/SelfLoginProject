package loti.subjMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ReportMapper {

	DataMap selectReportList(DataMap requestMap) throws SQLException;

	DataMap selectReportClassNoList(DataMap requestMap) throws SQLException;

	DataMap selectReportRow(DataMap requestMap) throws SQLException;

	DataMap selectReportDatesRow(String subj) throws SQLException;

	DataMap selectReportClassTutorRow(DataMap requestMap) throws SQLException;

	int updateReport(DataMap requestMap) throws SQLException;

	int selectReportMaxDates(DataMap requestMap) throws SQLException;

	int insertReport(DataMap requestMap) throws SQLException;

	int deleteReportGrade(DataMap params) throws SQLException;

	int deleteReportSubmit(DataMap params) throws SQLException;

	int deleteReport(DataMap params) throws SQLException;

	DataMap selectReportGradePointRow(DataMap requestMap) throws SQLException;

	DataMap selectReportGradeMaxPointRow(DataMap requestMap) throws SQLException;

	DataMap reportAppGradePointRow(DataMap requestMap) throws SQLException;

	DataMap reportAppClassNameRow(DataMap requestMap) throws SQLException;

	DataMap selectGradeGrcode(DataMap requestMap) throws SQLException;

	DataMap selectGradeEvalCnt(DataMap requestMap) throws SQLException;

	DataMap selectReportGradeList(DataMap requestMap) throws SQLException;

	int selectReportGradeCountRow(DataMap requestMap) throws SQLException;

	int insertReportGrade(DataMap params) throws SQLException;

	int updateReprtGrade(DataMap params) throws SQLException;

	DataMap reportAppList(DataMap requestMap) throws SQLException;

	int updateGeportApp(DataMap params) throws SQLException;

	int updateReportSubmit(DataMap params) throws SQLException;

	int insertGradetApp(DataMap params) throws SQLException;

	int selectReportSubmitCountRow(DataMap params) throws SQLException;

	DataMap selectGradeAppList(DataMap params) throws SQLException;

	DataMap selectReportClassNoRow(DataMap params) throws SQLException;

	String selectReportAppGradeCntRow(DataMap requestMap) throws SQLException;

	int regChoice(DataMap params) throws SQLException;

	int reportInsert(DataMap params) throws SQLException;

	int reportUpdate(DataMap params) throws SQLException;

}
