package loti.baseCodeMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import ut.lib.support.DataMap;

@Mapper
public interface QuestionMgrMapper {

	int selectSubjWithQuestionListCount(DataMap requestMap) throws SQLException;

	DataMap selectSubjWithQuestionList(Map<String, Object> pageInfo) throws SQLException;

	int selectSubjWithQuestionByIndexCount(DataMap requestMap) throws SQLException;

	DataMap selectSubjWithQuestionByIndex(Map<String, Object> pageInfo) throws SQLException;

	int selectQuestionListBySubjCount(DataMap requestMap) throws SQLException;

	DataMap selectQuestionListBySubj(Map<String, Object> pageInfo) throws SQLException;

	int updateUseYn(Map<String, Object> paramMap) throws SQLException;

	DataMap selectChapter(String subj) throws SQLException;

	int insertChapter(Map<String, Object> paramMap) throws SQLException;

	int insertQuestion(Map<String, Object> paramMap) throws SQLException;

	DataMap selectQuestionExcelBySubj(DataMap requestMap) throws SQLException;

	DataMap selectQuestion(String idQ) throws SQLException;

	int updateQuestion(Map<String, Object> paramMap) throws SQLException;

	int deleteQuestion(Map<String, Object> paramMap) throws SQLException;

	int insertQForOff(Map<String, Object> paramMap) throws SQLException;

	String selectIdChapterFromDual(String idCompany) throws SQLException;

	int insertChapter2(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectChapter2(String idChapter) throws SQLException;

	int deleteQuestion2(Map<String, Object> paramMap) throws SQLException;

	int updateErrorQuestion(DataMap requestMap) throws SQLException;

}
