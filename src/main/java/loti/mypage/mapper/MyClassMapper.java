package loti.mypage.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MyClassMapper {

	DataMap ldapList(String deptCode) throws SQLException;

	DataMap partList(String deptCode) throws SQLException;

	DataMap attendList(String userno) throws SQLException;

	String getRestrict(String userno) throws SQLException;

	DataMap selectAttendDetail(String userno) throws SQLException;

	DataMap selectCourseList(Map<String, Object> params) throws SQLException;

	DataMap courseReView(String userno) throws SQLException;

	DataMap courseApplication(String userno) throws SQLException;

	DataMap selectCompletionList(String userno) throws SQLException;

	DataMap getMyQuestionList(Map<String, Object> params) throws SQLException;

	int getMyQuestionListCount(String userno) throws SQLException;

	DataMap getModifyInfoPic(String userno) throws SQLException;

	DataMap getModifyInfoNoRes(String userno) throws SQLException;

	void deleteUser(String userno) throws SQLException;

	void updateUser(Map<String, Object> requestMap) throws SQLException;

	void updateUserLog(Map<String, Object> requestMap) throws SQLException;

	void updateUserPicture(Map<String, Object> params) throws SQLException;

	void updateUserPassword(Map<String, Object> params) throws SQLException;
	
	void updateUserDamoPassword(Map<String, Object> params) throws SQLException;

	DataMap deptList() throws SQLException;

	DataMap sameClass(Map<String, Object> params) throws SQLException;

	DataMap grseqList(Map<String, Object> params) throws SQLException;

	DataMap sameTimeList(Map<String, Object> params) throws SQLException;

	DataMap sameCourseList(Map<String, Object> params) throws SQLException;

	int insertData(Map<String, Object> params) throws SQLException;

	void modUserInfo(Map<String, Object> params) throws SQLException;

	void modUserInfoLog(Map<String, Object> params) throws SQLException;

	DataMap ajaxCountGrcodeYear(Map<String, Object> params) throws SQLException;

	DataMap ajaxCountGrcodeYearTotal(Map<String, Object> params) throws SQLException;

	DataMap ajaxCountGrseq(Map<String, Object> params) throws SQLException;

	DataMap ajaxGetCount(Map<String, Object> params) throws SQLException;

	DataMap ajaxGetTseat(Map<String, Object> params) throws SQLException;

	DataMap selectAjaxReadCnt(Map<String, Object> params) throws SQLException;

	int examTestBackup(Map<String, Object> params) throws SQLException;

	int deleteExamTestDelAns(Map<String, Object> params) throws SQLException;

	int deleteExamTestDelAnsNon(Map<String, Object> params) throws SQLException;

	DataMap selectLcmsCmiXML(DataMap requestMap) throws SQLException;

	int updateLcmsCmiXML(DataMap requestMap) throws SQLException;

	String viewReportSubmit(DataMap requestMap) throws SQLException;

	int selectGriqAnswerTxtCount(DataMap requestMap) throws SQLException;

	DataMap selectGriqAnswerTxt(DataMap requestMap) throws SQLException;

	int insertGrinqAnswer(DataMap requestMap) throws SQLException;

	DataMap grinqQuestionSet(DataMap requestMap) throws SQLException;

	DataMap grinqSampSet(Map params) throws SQLException;

	List<String> grinqAnswerText(Map params) throws SQLException;

	int grinqAnswerOne(Map params) throws SQLException;

	int grinqAnswerSome(Map egovMap) throws SQLException;

	DataMap pollList(DataMap requestMap) throws SQLException;

	DataMap courseTest(DataMap requestMap) throws SQLException;

	DataMap findGrade(DataMap requestMap) throws SQLException;

	DataMap findGrade2(DataMap requestMap) throws SQLException;

	DataMap reportCheck(DataMap requestMap) throws SQLException;

	int regChoice(DataMap requestMap) throws SQLException;

	int reportInsert(DataMap requestMap) throws SQLException;

	int reportUpdate(DataMap requestMap) throws SQLException;

	DataMap findScore(DataMap requestMap) throws SQLException;

	DataMap reportView(DataMap requestMap) throws SQLException;

	DataMap selectReportList(DataMap requestMap) throws SQLException;

	DataMap attendConfirm(DataMap requestMap) throws SQLException;

	int attendCancel(DataMap requestMap) throws SQLException;

	DataMap checkDeleteYn(DataMap requestMap) throws SQLException;

	int canonStuLec(DataMap requestMap) throws SQLException;

	DataMap sameCousreList(DataMap requestMap) throws SQLException;

	int ajaxMemberUpdate(DataMap requestMap) throws SQLException;

	DataMap attendPopupList(DataMap requestMap) throws SQLException;
	
	DataMap attendPopupBasicList(DataMap requestMap) throws SQLException;

	String getRestrict(DataMap requestMap) throws SQLException;

	double selectSuggestionMinNoRow(Map params) throws SQLException;

	int modifySuggestion(DataMap requestMap) throws SQLException;

	int updateDiscussLikeDelete(DataMap requestMap) throws SQLException;

	int deleteDiscuss(DataMap requestMap) throws SQLException;

	int suggestionMaxCount(DataMap requestMap) throws SQLException;

	int suggestionListCount(DataMap requestMap) throws SQLException;

	DataMap suggestionList(DataMap requestMap) throws SQLException;

	String getGrseqName(DataMap requestMap) throws SQLException;

	DataMap suggestionView(DataMap requestMap) throws SQLException;

	int insertSuggestion(DataMap requestMap) throws SQLException;

	double selectDiscussMinNoRow(Map params) throws SQLException;

	int modifyDiscuss(DataMap requestMap) throws SQLException;

	int deleteSuggestion(DataMap requestMap) throws SQLException;

	int updateSuggestionLikeDelete(DataMap requestMap) throws SQLException;

	DataMap discussList(DataMap requestMap) throws SQLException;

	int discussListCount(DataMap requestMap) throws SQLException;

	DataMap discussView(DataMap requestMap) throws SQLException;

	int insertDiscuss(DataMap requestMap) throws SQLException;

	DataMap progressRate(DataMap requestMap) throws SQLException;

	int choiceSubLecture(DataMap requestMap) throws SQLException;

	String kindSubLecture(String subj) throws SQLException;

	DataMap selectSubLecture(DataMap requestMap) throws SQLException;

	DataMap courseDetail(DataMap requestMap) throws SQLException;

	int grnoticeCntPlus(DataMap requestMap) throws SQLException;

	DataMap selectGrnoticeView(DataMap requestMap) throws SQLException;

	DataMap selectGrnoticeList(DataMap requestMap) throws SQLException;

	DataMap courseDetailView(DataMap requestMap) throws SQLException;

	DataMap classView(DataMap requestMap) throws SQLException;

	DataMap classList(DataMap requestMap) throws SQLException;

	DataMap searchDeleteUserEmail(DataMap requestMap) throws SQLException;

	DataMap searchDeleteUser(DataMap requestMap) throws SQLException;

	DataMap getUserNoticeList(DataMap requestMap) throws SQLException;

	DataMap getUserNoticeView(DataMap requestMap) throws SQLException;

	int getUserNoticeViewReadUpdate(DataMap requestMap) throws SQLException;

	DataMap getMyQuestionView(DataMap requestMap) throws SQLException;

	DataMap selectItemList(DataMap requestMap) throws SQLException;	

	Double selectProgressscoAvg(DataMap requestMap) throws SQLException;

	int discussCnt(String stringQuery) throws SQLException;

	int selectGrnoticeListCount(DataMap requestMap) throws SQLException;

	int classListCount(DataMap requestMap) throws SQLException;

	int classViewCount(DataMap requestMap) throws SQLException;

	int discussCntUpdate(String stringQuery) throws SQLException;

	DataMap courseList(String strCList) throws SQLException;
	
	DataMap courseBasicList(String strCList) throws SQLException;
	
	DataMap selectGrInfo(DataMap requestMap) throws SQLException;
	
	String selectDeptInfo(String userno) throws SQLException;
}
