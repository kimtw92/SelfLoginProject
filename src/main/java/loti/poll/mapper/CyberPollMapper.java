package loti.poll.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CyberPollMapper {

	DataMap selectCyberPollList(Map requestMap) throws SQLException;

	int selectCyberPollListCount(Map requestMap) throws SQLException;

	DataMap selectCyberPollTitleRow(int titleNo) throws SQLException;

	DataMap selectCyberPollInqSampRow(Map<String, Object> params) throws SQLException;

	DataMap selectCyberPollQuestionNoRow(int titleNo) throws SQLException;

	DataMap selectCyberPollInqQustionList(int titleNo) throws SQLException;

	DataMap selectCyberPollInqQustionRow(Map<String, Object> params) throws SQLException;

	int insertCyberPollTitleInfo(Map requestMap) throws SQLException;

	int deleteSampRow(Map requestMap) throws SQLException;

	int deleteQuestionRow(Map requestMap) throws SQLException;

	int insertCyberPollQuestion(Map requestMap) throws SQLException;

	int insertSamp(Map<String, Object> params) throws SQLException;

	int selectMaxQuestionRow() throws SQLException;

	int selectCyberPollMaxTitleNo() throws SQLException;

	int selectCyberPollMaxQuestionNo(int titleNo) throws SQLException;

	int modifyCyberPollTitleInfo(Map requestMap) throws SQLException;

	DataMap selectQuestionNo(int titleNo) throws SQLException;

	int selectAnswerNoCountRow(Map<String, Object> params) throws SQLException;

	int deleteTtl(int titleNo) throws SQLException;

	DataMap selectPreviewPop(int titleNo) throws SQLException;

	String selectSubTitleCyberRow(int titleNo) throws SQLException;

	DataMap selectHtmlPreviewPop(int titleNo) throws SQLException;

	int selectResultCount(Map<String, Object> params) throws SQLException;

	int resultInsert(Map<String, Object> params) throws SQLException;

	int selectAnswerInNoCount(Map<String, Object> params) throws SQLException;

	int selectAnswerTotalNoCount(Map<String, Object> params) throws SQLException;

}
