package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface QuestionMapper {

	int selectGrSuggestionByHighListCount(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectQuestionPopup() throws SQLException;

	DataMap selectGrSuggestionByHighList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectGrSuggestionByLowRow(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrSuggestionRow(Map<String, Object> paramMap) throws SQLException;

	int updateGrSuggestion(DataMap requestMap) throws SQLException;

	int selectGrSuggestionMaxNo(DataMap requestMap) throws SQLException;

	int insertGrSuggestionByReply(Map<String, Object> paramMap) throws SQLException;

	void updateGrSuggestionByReplySpec(DataMap requestMap) throws SQLException;

	int updateGrSuggestionByReply(DataMap requestMap) throws SQLException;

	DataMap selectMemberSimpleByQuestion(Map<String, Object> paramMap) throws SQLException;

	int deleteGrSuggestion(DataMap requestMap) throws SQLException;
	
}
