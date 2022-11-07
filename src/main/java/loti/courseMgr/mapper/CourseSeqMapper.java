package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper
public interface CourseSeqMapper {

	DataMap selectGrSeqDistictYearList(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectGrSeqList(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectSubjLecTypeList1(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectSubjLecTypeList2(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectGrSeqRow(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectGrSeqRowForCyber(DataMap requestMap) throws SQLException;
	
	int updateGrSeq(DataMap paramMap) throws SQLException;
	
	int updateSubjSeqDate(DataMap paramMap) throws SQLException;
	
	int selectGrSeqSubjConnectChk(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectSessClassGrCodeList(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectGrcodeList(DataMap requestMap) throws SQLException;
	
	DataMap selectGrseqMaxList(Map<String, Object> paramMap) throws SQLException;
	
	int insertGrSeqGrcodeLittle(Map<String, Object> paramMap) throws SQLException;
	
	int insertGrSubjSpec(Map<String, Object> paramMap) throws SQLException;
	
	int insertSubjSeqSpec(Map<String, Object> paramMap) throws SQLException;
	
	int insertSubjClassSpec(Map<String, Object> paramMap) throws SQLException;
	
	int deleteGrSubjClass(DataMap requestMap) throws SQLException;
	
	int deleteSubjSeq(DataMap requestMap) throws SQLException;
	
	int deleteGrsubj(DataMap requestMap) throws SQLException;
	
	int deleteGrseqGrcode(DataMap requestMap) throws SQLException;
	
	int insertGrSeqGrcode(DataMap requestMap) throws SQLException;
	
	int deleteGrSeqGrcode(DataMap requestMap) throws SQLException;
	
	DataMap selectGrStuMasList(DataMap requestMap) throws SQLException;
	
	DataMap selectGrStuMasGubunList(DataMap requestMap) throws SQLException;
	
	DataMap selectGrSeqAppMemberList(DataMap requestMap) throws SQLException;
	
	int insertGrSeqStuMas(Map<String, Object> paramMap) throws SQLException;
	
	int deleteGrSeqStuMas(DataMap requestMap) throws SQLException;
	
	int selectMemberTutorListCount(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectMemberTutorList(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectNextGrSeqRow(Map<String, Object> paramMap) throws SQLException;
	
	int selectSubjByIndexListCount(DataMap requestMap) throws SQLException;
	
	DataMap selectSubjByIndexList(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectSubjInGrSeqList(DataMap requestMap) throws SQLException;
	
	DataMap selectSubjList(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectSubjInfoList(Map<String, Object> paramMap) throws SQLException;
	
	int insertGrSubj(DataMap paramMap) throws SQLException;
	
	int insertSubjSeq(DataMap paramMap) throws SQLException;
	
	int insertSubjClass(DataMap paramMap) throws SQLException;
	
	int selectStuLecCnt(Map<String, Object> paramMap) throws SQLException;
	
	int selectStuLecSubjCnt(Map<String, Object> paramMap) throws SQLException;
	
	int insertStuLecSubjSpec(Map<String, Object> paramMap) throws SQLException;
	
	List<EgovMap> selectSubjListFromSubjGrp(String subj) throws SQLException;
	
	int selectGrResultCnt(DataMap requestMap) throws SQLException;
	
	int selectSubjResultCnt(DataMap requestMap) throws SQLException;
	
	int selectSubjAllResultCnt(DataMap requestMap) throws SQLException;
	
	DataMap selectSubjSeqRow(DataMap requestMap) throws SQLException;
	
	int updateSubjSeq(DataMap requestMap) throws SQLException;
	
	int updateSubjSeqDateSub(DataMap requestMap) throws SQLException;
	
	DataMap selectGrSeqByNotInList(DataMap requestMap) throws SQLException;
	
	DataMap selectSubjSeqList(DataMap requestMap) throws SQLException;
	
	DataMap selectSubjSeqCopyList(DataMap requestMap) throws SQLException;
	
	DataMap selectGrseqMngGrseqList(int year) throws SQLException;
	
	DataMap selectGrcodeListByGrseq(DataMap requestMap) throws SQLException;
	
	int insertGrseqByGrseqMng(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectGrseqSimpleRow(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectMemberSimpleRowAndUserid(String userNo) throws SQLException;
	
	String selectGrseqPrevMaxGrseq(DataMap requestMap) throws SQLException;
	
	int insertGrSubjByPrevGrseq(Map<String, Object> paramMap) throws SQLException;
	
	int insertSubjSeqByPrevGrseq(Map<String, Object> paramMap) throws SQLException;
	
	int insertSubjClassByPrevGrseq(Map<String, Object> paramMap) throws SQLException;

	DataMap selectEdunoRow(Map<String, Object> paramMap) throws SQLException;

	int insertEvalInfoGrseqByPrevGrseq(Map<String, Object> paramMap) throws SQLException;

	int insertEvalInfoSubjByPrevGrseq(Map<String, Object> paramMap) throws SQLException;

	int insertExPageByPrevGrseq(Map<String, Object> paramMap) throws SQLException;

	int updateGrseqByEvlDate(Map<String, Object> paramMap) throws SQLException;

	int updateSubjSeqByEvlNull(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrInqTtlByGrseqSimpleList(Map<String, Object> paramMap) throws SQLException;

	int selectGrInqTtlMaxTitleNo() throws SQLException;

	int insertGrInqTtlByPrevGrseq(Map<String, Object> paramMap) throws SQLException;

	int insertGrInqQuestionSetByPrevGrseq(Map<String, Object> paramMap) throws SQLException;

	int insertGrInqSampSetByPrevGrseq(Map<String, Object> paramMap) throws SQLException;

	int updateGrseqByQuestionDate(Map<String, Object> paramMap) throws SQLException;

	int updateGrseqByGroupFileNo(Map<String, Object> paramMap) throws SQLException;

	int selectAppInfoByGrcodeYearCnt(DataMap requestMap) throws SQLException;

	DataMap selectMemberLecture(String userno) throws SQLException;

	DataMap findSubjseqJoinSubjJoinEvlinfoJoinEvlCntByGrcodeAndGrseqAndSubjAndPtype(DataMap requestMap) throws SQLException;

	DataMap findExamMJoinExamSubjectByGrcodeAndGrseqAndSubj(DataMap resultMap) throws SQLException;

	DataMap findExamUnitByIdExam(DataMap resultMap) throws SQLException;

	DataMap countExamQByIdExamAndIdSubject(DataMap examUnit) throws SQLException;

	DataMap findQAnsByKeyExceptNo(DataMap dataMap) throws SQLException;
	
	DataMap selectQCount(String subj) throws SQLException;

	DataMap selectExamPaper(String idExam) throws SQLException;

	int selectExamPaperSetCount(String idExam) throws SQLException;

	int insertExamM(Map<String, Object> paramMap) throws SQLException;

	int insertExamUnit(Map<String, Object> paramMap) throws SQLException;

	DataMap selectExamSubject(Map<String, Object> paramMap) throws SQLException;

	int insertExamSubject(Map<String, Object> paramMap) throws SQLException;

	String selectIdExamFromDual(String idCompany) throws SQLException;

	DataMap selectRandomQuestions(Map<String, Object> paramMap) throws SQLException;

	int insertQuestionIntoPaper(Map<String, Object> paramMap2) throws SQLException;

	int insertQuestionIntoQ(Map<String, Object> paramMap2) throws SQLException;

	int selectExamQCnt(Map<String, Object> paramMap2) throws SQLException;

	DataMap selectExamPaperBySet(DataMap requestMap) throws SQLException;
	
	DataMap selectOffExamPaperBySet(DataMap requestMap) throws SQLException;
	
	int updateExamM(Map<String, Object> paramMap) throws SQLException;
	
	int updateExamDate(Map<String, Object> paramMap) throws SQLException;

	int updateExamUnit(Map<String, Object> paramMap) throws SQLException;

	int updateExamSubject(Map<String, Object> paramMap) throws SQLException;

	int deleteQuestionFromPaper(Map<String, Object> paramMap2) throws SQLException;

	int deleteQuestionFromQ(Map<String, Object> paramMap2) throws SQLException;

	int updateYNEnable(DataMap requestMap) throws SQLException;

	DataMap selectSubjSeq(Map<String, Object> paramMap) throws SQLException;

	int updateOffExamM(Map<String, Object> paramMap) throws SQLException;

	int updateOffExamSubject(Map<String, Object> paramMap) throws SQLException;

	int insertOffExamM(Map<String, Object> paramMap) throws SQLException;

	int insertOffExamUnit(Map<String, Object> paramMap) throws SQLException;

	int insertOffExamSubject(Map<String, Object> paramMap) throws SQLException;

	DataMap selectOffExamQuestion(Map<String, Object> paramMap) throws SQLException;

	DataMap selectOrderedQuestions(Map<String, Object> paramMap) throws SQLException;

	DataMap selectMaxCountByPType(Map<String, Object> paramMap) throws SQLException;

	int deleteExamQ(String idExam) throws SQLException;

	int deleteExamPaper(String idExam) throws SQLException;

	int deleteExamSubject(String idExam) throws SQLException;

	int deleteExamUnit(String idExam) throws SQLException;

	int deleteExamM(String idExam) throws SQLException;
	
	int deleteOffExamQ(String idExam) throws SQLException;

	int deleteOffExamPaper(String idExam) throws SQLException;

	int deleteOffExamSubject(String idExam) throws SQLException;

	int deleteOffExamUnit(String idExam) throws SQLException;

	int deleteOffExamM(String idExam) throws SQLException;

	DataMap selectEvalSubjectList(DataMap requestMap) throws SQLException;

	DataMap selectMainChapterBySubj(String subj) throws SQLException;

	DataMap selectSubChapterBySubj(Map<String, Object> paramMap) throws SQLException;

	DataMap selectChapterByIdExam(Map<String, Object> paramMap) throws SQLException;

	Object selectSubjnm(String subj) throws SQLException;

	int deleteOffQuestions(Map<String, Object> paramMap) throws SQLException;

	int deleteOffQ(String string) throws SQLException;

	int deleteOffChapter(String string) throws SQLException;
}
