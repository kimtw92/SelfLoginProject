package loti.poll.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CoursePollMapper {

	DataMap selectGrinqTtlBySearchList(DataMap requestMap) throws SQLException;

	DataMap selectGrinqByNotApplyList(Map<String, Object> params) throws SQLException;

	int selectGrinqAnswerChk(int titleNo) throws SQLException;

	int selectGrinqAnswerBySetUserChk(Map<String, Object> params) throws SQLException;

	int deleteGrinqSampSet(int titleNo) throws SQLException;

	int deleteGrinqQuestionSet(int titleNo) throws SQLException;

	void deleteGrinqTtl(int titleNo) throws SQLException;

	DataMap selectGrinqTtlRow(int titleNo) throws SQLException;

	DataMap selectGrinqQuestionSetByTtlList(int titleNo) throws SQLException;

	DataMap selectGrinqTtlByTimeTableSubjList(DataMap grseqMap) throws SQLException;

	DataMap selectGrinqBankQuestionBySearchList(Map<String, Object> params) throws SQLException;

	int selectGrinqGuideListCount(DataMap requestMap) throws SQLException;

	DataMap selectGrinqGuideList(DataMap requestMap) throws SQLException;

	DataMap selectGrinqGuideRow(int guideNo) throws SQLException;

	int deleteGrinqGuide(int guideNo) throws SQLException;

	int insertGrinqGuide(DataMap requestMap) throws SQLException;

	int updateGrinqGuide(DataMap requestMap) throws SQLException;

	int selectGrinqGuideMaxKey() throws SQLException;

	DataMap selectGrinqQuestionSetByTutorSubjList(Map<String, Object> params) throws SQLException;

	DataMap selectGrinqQuestionSetByRequstList(Map<String, Object> params) throws SQLException;

	int selectGrinqAnswerBySetChk(Map<String, Object> params) throws SQLException;

	int deleteGrinqSampSetBySet(Map<String, Object> params) throws SQLException;

	int deleteGrinqQuestionSetBySet(Map<String, Object> params) throws SQLException;

	int selectGrinqTtlByMaxTitleNo() throws SQLException;

	int selectGrinqTtlByMaxTitleSeq(DataMap requestMap) throws SQLException;

	int insertGrinqTtl(DataMap requestMap) throws SQLException;

	int updateGrinqTtl(DataMap requestMap) throws SQLException;

	int selectGrinqQuestionSetMaxSetNo(int titleNo) throws SQLException;

	DataMap selectGrseqBySimpleCyberRow(DataMap requestMap) throws SQLException;

	DataMap selectGrseqByClassTutorList(DataMap requestMap) throws SQLException;

	DataMap selectGrseqByClassTutorCyberList(DataMap requestMap) throws SQLException;

	DataMap selectGrinqBankQuestionRow(int bankQuestionNo) throws SQLException;

	int selectGrinqQuestionSetByMaxQuestionNo(DataMap setMap) throws SQLException;

	void insertGrinqQuestionSetBySpecBank(DataMap setMap) throws SQLException;

	int selectGrinqBankSampCount(int bankQuestionNo) throws SQLException;

	int insertGrinqSampSetBySpecBank(DataMap setMap) throws SQLException;

	DataMap selectNoneChkPollList(DataMap requestMap) throws SQLException;

	String selectGrcodenameRow(String grcode) throws SQLException;

	DataMap selectUserNameRow(String userno) throws SQLException;

	DataMap selectGrinqQuestionSetList(Map<String, Object> params) throws SQLException;

	DataMap selectGrinqSampSetList(Map<String, Object> params) throws SQLException;

	DataMap selectGrinqQuestionSetByQuestionCheckNoList(	Map<String, Object> params) throws SQLException;

	DataMap selectGrinqQuestionSetRow(Map prevMap) throws SQLException;

	int insertGrinqAnswer(DataMap answerMap) throws SQLException;

	DataMap selectGrinqAnswerByTxtList(Map<String, Object> params) throws SQLException;

	int selectGrinqAnswerBySampTotalCnt(Map<String, Object> params) throws SQLException;

	int selectGrinqAnswerBySampChioceCnt(Map<String, Object> params) throws SQLException;

	DataMap selectGrinqGrseqTotalResultList(String grcode) throws SQLException;

	DataMap selectGrinqGrseqTotalResultByTutorList(String grcode) throws SQLException;

	DataMap selectGrinqSampSetByQuestionNoList(Map<String, Object> params) throws SQLException;

	DataMap selectGrinqTtlByCyberList(Map<String, Object> params) throws SQLException;
	
	DataMap selectPollList(DataMap params) throws SQLException;
	
	DataMap selectNewPollList(DataMap params) throws SQLException;
	
	int updatePollYN(DataMap params) throws SQLException;
	
	int selectNewPollYN(DataMap params) throws SQLException;
	
	int insertIp(DataMap params) throws SQLException;
	
	DataMap selectIpList(DataMap params) throws SQLException;
	
	DataMap selectUsernoChk(String params) throws SQLException;
	
	int deleteAnsNo(DataMap params) throws SQLException;
	
	DataMap selectScore(DataMap params) throws SQLException;
	
	String selectPollYNChk(DataMap params) throws SQLException;
	
	
	


}
