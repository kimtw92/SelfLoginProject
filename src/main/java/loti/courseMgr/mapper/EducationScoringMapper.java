package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface EducationScoringMapper {

	int countExamAnsByKey(Map examAns) throws SQLException;

	int updateExamAns(Map examAns) throws SQLException;

	int insertExamAns(Map examAns) throws SQLException;

	DataMap findExamAnsByKeyExceptUserid(Map params) throws SQLException;

	DataMap findOneGrseqByKey(Map keyMap) throws SQLException;

	DataMap findAnsBySubjAndGrcodeAndGrseqAndIdExam(DataMap dataMap) throws SQLException;

	String findOneExamIdByIdCourseAndCourseYearAndCourseNo(Map params) throws SQLException;

	int deleteExamAns(Map examAns) throws SQLException;

	String findUsernoInAppInfoByGrcodeAndGrseqAndEduNo(Map m) throws SQLException;

	int deleteExamAnsByIdCompanyAndIdExamAndIdSubject(Map examAns) throws SQLException;

	List<Map> findAnsBySubjAndGrcodeAndGrseqAndYnEnd(DataMap dataMap) throws SQLException;

	int countExresult(Map exresult) throws SQLException;

	int insertExresult(Map exresult) throws SQLException;

	int updateExresult(Map exresult) throws SQLException;

	List<Map> findExamPaper2ByIdExamAndIdSubject(Map params) throws SQLException;

	int updateExamAnsScoring(Map m) throws SQLException;

	int updateExamAnsYnEnd(Map params) throws SQLException;

	DataMap findExamMByGrcodeAndGrseq(DataMap requestMap) throws SQLException;

	DataMap findBakAnsBySubjAndGrcodeAndGrseqAndIdExam(DataMap dataMap) throws SQLException;

	DataMap selectOneExamAns(Map params) throws SQLException;

	int countBakExamAnsByKey(Map params) throws SQLException;

	int updateBakExamAns(Map params) throws SQLException;

	int insertBakExamAns(Map params) throws SQLException;

	int deleteBakExamAns(Map params) throws SQLException;

	DataMap selectOneBakExamAns(Map params) throws SQLException;

	List<Map> findExamPaper2ByIdExamAndIdSubjectAndNrSet(Map requestMap) throws SQLException;

	int findBakAnsBySubjAndGrcodeAndGrseqAndIdExamCount(DataMap requestMap) throws SQLException;

	int findAnsBySubjAndGrcodeAndGrseqAndIdExamCount(DataMap requestMap) throws SQLException;

	int updateAnswersExamAns(DataMap requestMap) throws SQLException;

	Integer selectOneExamKindOfExamM(String idExam) throws SQLException;
}
