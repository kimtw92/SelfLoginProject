package loti.tutorMgr.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface TutorMgrMapper {

	DataMap selectTutorField() throws SQLException;

	DataMap selectTutorLevelTotal() throws SQLException;

	DataMap selectTutorJobList() throws SQLException;

	int selectCategotyTutorListCount(Map requestMap) throws SQLException;

	DataMap selectCategotyTutorList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectTutorManagerCount(Map<String, Object> params) throws SQLException;

	int changeTutorAuthStep1ByUpdate(Map<String, Object> params) throws SQLException;

	int changeTutorAuthStep2ByUpdate(Map<String, Object> params) throws SQLException;

	int changeTutorAuthStep3ByDelete(Map<String, Object> params) throws SQLException;

	int changeTutorAuthStep4ByInsert(Map<String, Object> params) throws SQLException;

	int changeTutorAuthStep5ByInsert(Map<String, Object> params) throws SQLException;

	DataMap selectSessnoBy7(String userno) throws SQLException;

	DataMap selectMemberDamo(String userno) throws SQLException;

	DataMap selectTutorHistory(Map<String, Object> params) throws SQLException;

	DataMap selectTutorDamo(String userno) throws SQLException;

	DataMap selectTutorGubun() throws SQLException;

	DataMap selectTutorLevel() throws SQLException;

	DataMap selectClassInfo(String userno) throws SQLException;

	DataMap selectGoodTutorlList(Map requestMap) throws SQLException;

	DataMap selectExcelHistoryList(Map requestMap) throws SQLException;

	DataMap selectHistoryList(Map requestMap) throws SQLException;

	DataMap selectTutorLevelName() throws SQLException;

	DataMap selectTutorLevelCount(Map requestMap) throws SQLException;

	int selectHistoryListCount(Map requestMap) throws SQLException;

	int selectNsalaryCountRow(Map requestMap) throws SQLException;

	DataMap selectYsalaryList(Map requestMap) throws SQLException;

	DataMap selectNsalaryList(Map requestMap) throws SQLException;

	DataMap selectNcollecList(Map<String, Object> params) throws SQLException;

	DataMap selectYcollecList(Map<String, Object> params) throws SQLException;

	DataMap selectNcopyPayList(Map<String, Object> params) throws SQLException;

	DataMap selectYcopyPayList(Map<String, Object> params) throws SQLException;

	DataMap selectNexamList(Map<String, Object> params) throws SQLException;

	DataMap selectYexamList(Map<String, Object> params) throws SQLException;

	DataMap selectCoursorList() throws SQLException;

	DataMap selectTutorCyberAndCollecPop() throws SQLException;

	DataMap selectTutorSalaryQustionRow() throws SQLException;

	void insertTutorSalaryNcyberPay(Map<String, Object> params) throws SQLException;

	void updateSalaryCyberNReport(Map<String, Object> params) throws SQLException;

	void updateSalaryCyberNSubjQna(Map<String, Object> params) throws SQLException;

	void deleteSalaryCyber(Map<String, Object> params) throws SQLException;

	DataMap insertSalaryNcollecPayList(Map<String, Object> params) throws SQLException;

	int insertTutorSalaryNcollecPay(Map listMap) throws SQLException;

	int updateTutorSalaryTime(Map<String, Object> params) throws SQLException;

	int updateTutorSalaryLecHistory(Map<String, Object> params) throws SQLException;

	int insertCopyPay(Map<String, Object> params) throws SQLException;

	void updateSalaryCopyYn(Map<String, Object> params) throws SQLException;

	int insertExam(Map<String, Object> params) throws SQLException;

	void updateSalaryYnExam(Map<String, Object> params) throws SQLException;

	void deleteExam(Map<String, Object> params) throws SQLException;

	int selectTutorSubjectCountRow() throws SQLException;

	void insertTutorSubject(Map requestMap) throws SQLException;

	void updateTutorSubject(Map requestMap) throws SQLException;

	int selectTutorQuestionCountRow() throws SQLException;

	void insertTutorQuestion(Map requestMap) throws SQLException;

	void updateTutorQuestion(Map requestMap) throws SQLException;

	void updateTutorAllowance(Map<String, Object> params) throws SQLException;

	void insertCopyPayPOP(Map requestMap) throws SQLException;

	void deleteCopyPayPOP(String no) throws SQLException;

	int selectSalaryExamPopCountPopRow() throws SQLException;

	void insertSalaryExamPop(Map requestMap) throws SQLException;

	void updateSalaryExamPop(Map requestMap) throws SQLException;

	DataMap selectTutorSalaryCopyPayRow(String part) throws SQLException;

	DataMap checkMemberDamoByResno(String resno) throws SQLException;

	DataMap checkMemberDamoByUserId(String userId) throws SQLException;

	DataMap selectSubjCode(String subjNm) throws SQLException;

	DataMap selectSearchTutorPop(Map requestMap) throws SQLException;

	DataMap selectMaxByUserNo() throws SQLException;

	void insertMemberDamo(Map requestMap) throws SQLException;

	void insertTutorDamo(Map requestMap) throws SQLException;

	void updateMemberDamo(Map requestMap) throws SQLException;

	DataMap selectMangerDupCnt(String userno) throws SQLException;

	void updateTutorDamo(Map requestMap) throws SQLException;

	void insertManger(Map requestMap) throws SQLException;

	void insertTutorHistory(Map<String, Object> params) throws SQLException;

	void deleteTutorHistory(String userno) throws SQLException;

	DataMap selectTutorSalaryList(Map requestMap) throws SQLException;

	DataMap selectTutorLevelList() throws SQLException;

	DataMap selectGreadeResultList(Map requestMap) throws SQLException;

	int selectTseat(Map<String, Object> params) throws SQLException;

	DataMap selectTutorPaperList(Map requestMap) throws SQLException;

	int selectTutorPaperListCount(Map requestMap) throws SQLException;

	int selectTutorPaperCountRow(Map requestMap) throws SQLException;

	void insertTutorPaper(Map requestMap) throws SQLException;

	int deleteTutorPaper(Map requestMap) throws SQLException;

	DataMap seleteTutorPaperGrcodeList() throws SQLException;

	DataMap seleteTutorPaperGrseqList(Map requestMap) throws SQLException;

	DataMap seleteTutorPaperSubjList(Map requestMap) throws SQLException;

	DataMap seleteTutorPaperTutorNameList(Map requestMap) throws SQLException;

}
