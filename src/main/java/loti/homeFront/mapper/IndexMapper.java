package loti.homeFront.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import loti.homeFront.vo.PersonVO;
import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface IndexMapper {
	
	DataMap getNoticeList() throws SQLException;

	DataMap getCyberList() throws SQLException;

	DataMap getNonCyberList() throws SQLException;

	DataMap getMonthList(Map<String, Object> param) throws SQLException;

	DataMap getWeekList() throws SQLException;

	DataMap getPopupList() throws SQLException;

	DataMap getPhotoList() throws SQLException;

	DataMap getGrseqPlanList() throws SQLException;

	int insertLoginStats(Map<String, Object> param) throws SQLException;

	DataMap getExistIdValue(String ssn) throws SQLException;

	DataMap getAllNonCyberList() throws SQLException;

	DataMap getAllCyberList() throws SQLException;

	DataMap getPopupView(String no) throws SQLException;

	DataMap getEducationMonthAJAXList(Map<String,Object> dataMap) throws SQLException;

	int getEducationMonthAJAXListCount(String monthajax) throws SQLException;

	DataMap getTeamList() throws SQLException;

	DataMap getTeamListByName(String name) throws SQLException;

	DataMap getTeamListByWork(String work) throws SQLException;

	DataMap getEatList(Map<String, Object> params) throws SQLException;

	int existAlreadyReservation(Map<String, Object> params) throws SQLException;

	DataMap getReservationList(Map<String, Object> params) throws SQLException;

	int getDuplicateReservationCount(Map<String, Object> params) throws SQLException;

	int getMaxApplication() throws SQLException;

	int setReservation(Map<String, Object> params) throws SQLException;

	DataMap getReservationConfirm(Map<String, Object> params) throws SQLException;

	DataMap getDeptList() throws SQLException;

	Integer getFileNo() throws SQLException;

	void setJoinPicture(Map<String, Object> params) throws SQLException;

	DataMap getJoinYn(String string) throws SQLException;

	DataMap getEmailYn(String string) throws SQLException;

	DataMap getZikList(String string) throws SQLException;

	DataMap getUserNo() throws SQLException;

	void joinMemberRnG(Map<String, Object> requestMap) throws SQLException;
	
	void updateDamoMemberRnG(Map<String, Object> params) throws SQLException;

	DataMap pageingSample(Map<String, Object> pageInfo) throws SQLException;

	DataMap getZipcodeList(String address) throws SQLException;

	DataMap findPasswordByEmail(DataMap requestMap) throws SQLException;

	DataMap findPassword(DataMap requestMap) throws SQLException;

	DataMap findUserPassword(DataMap requestMap) throws SQLException;

	DataMap iPinfindUserPassword(DataMap requestMap) throws SQLException;

	DataMap findQuestion(DataMap requestMap) throws SQLException;

	int updatePasswd(DataMap requestMap) throws SQLException;

	DataMap finddupinfo(DataMap requestMap) throws SQLException;

	void setPassword(Map<String, Object> params) throws SQLException;

	String getMailSeq() throws SQLException;

	PersonVO getPersonInfo(String userno) throws SQLException;
	
	String getPersonInfoByhp(Map<String, Object> params) throws SQLException;

	int sendMail(PersonVO vo) throws SQLException;


	DataMap getGoodLectureList() throws SQLException;

	Integer checkCmlmsJoin(Map<String, Object> params) throws SQLException;

	void updateCmlmsId(Map<String, Object> params) throws SQLException;

	Integer checkCmlmsIdExist(String id) throws SQLException;

	void joinCmlmsMember(DataMap requestMap) throws SQLException;

	String getCmlmsUserNo() throws SQLException;

	void setRejoin(Map<String, Object> params) throws SQLException;

	void modifyReservation(Map<String, Object> params) throws SQLException;

	DataMap getReservationModify(String taPk) throws SQLException;

	int updateAgreement(String tapk) throws SQLException;

	DataMap getReservationConfirmRev(Map<String, Object> params) throws SQLException;

	DataMap getReservationSurvey() throws SQLException;

	DataMap getReservationSurveyDetail() throws SQLException;

	int getMemberSSOAgree(Map<String, Object> params) throws SQLException;

	void insertSSOAgree(Map<String, Object> params) throws SQLException;
	
	void changeNewPwd(Map<String, Object> params) throws SQLException;
	
	int insertGrinqAnswer(DataMap answerMap) throws SQLException;

	String checkMemberSSOAgree(String value);

	

//	DataMap getMonthAJAXList(String string);

}
