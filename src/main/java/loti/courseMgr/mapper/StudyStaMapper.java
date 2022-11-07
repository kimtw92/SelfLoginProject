package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface StudyStaMapper {

	DataMap selectStuLecBySubjStudyStaList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectSubjSeqByTotalSubjList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectSubjSeqBySubjPointList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByStuTotPointList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectSubjSeqByCyberSubjList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectSubjSeqByCyberStuPointList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByNoCyberUserList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByWhereStrList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectCyberStuStudyPointList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectCyberSMSStuStudyPointList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectEtestExamRow(String examId) throws SQLException;

	DataMap selectOnlineExamStuList(Map<String, Object> paramMap) throws SQLException;

}
