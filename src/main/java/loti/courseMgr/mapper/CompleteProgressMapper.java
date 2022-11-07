package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CompleteProgressMapper {
	
	int selectSubjSeqCloseChk(Map<String, Object> paramMap) throws SQLException;
	
	int selectGrseqCloseChk(Map<String, Object> paramMap) throws SQLException;
	
	int selectSubjSeqCloseChkByAllSubj(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectSubjSeqByAllSubjList(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectStuLecUserListBySubj(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectExResultRow(Map<String, Object> paramMap) throws SQLException;
	
	int updateStuLecByResultData(DataMap paramMap) throws SQLException;
	
	DataMap selectSubjSeqListByNotClosing(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectStuLecListByResultInfo(Map<String, Object> paramMap) throws SQLException;
	
	int selectSubjResultStuChk(DataMap paramMap) throws SQLException;
	
	int updateSubjResult(DataMap paramMap) throws SQLException;
	
	int insertSubjResult(DataMap paramMap) throws SQLException;
	
	int updateSubjSeqByClosing(Map<String, Object> paramMap) throws SQLException;
	
	int deleteSubjResultByGrseq(Map<String, Object> paramMap) throws SQLException;
	
	int updateStuLecByGrayn(Map<String, Object> paramMap) throws SQLException;
	
	int updateSubjSeqByGrseqClosing(Map<String, Object> paramMap) throws SQLException;
	
	int selectSubjSeqBySubjTypeCloseChk(Map<String, Object> paramMap) throws SQLException;
	
	int selectGrseqCloseYesChk(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectGrseqByResultSimpleRow(Map<String, Object> paramMap) throws SQLException;
	
	int selectAppInfoByGrchkCnt(Map<String, Object> paramMap) throws SQLException;
	
	int deleteGrResult(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectSubjResultByDistinctUserList(Map<String, Object> paramMap) throws SQLException;

	String selectStuLecGrseqTotalPaccept(Map<String, Object> paramMap) throws SQLException;

	String selectGrStuMasAddpoint(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectSubjSeqSubjCntBySubjType(Map<String, Object> paramMap) throws SQLException;

	int selectStuLecGraynCnt(Map<String, Object> paramMap) throws SQLException;

	int insertGrResult(DataMap paramMap) throws SQLException;

	DataMap selectGrResultUserListByCalc(Map<String, Object> paramMap) throws SQLException;

	int selectGrResultMaxSeqno(Map<String, Object> paramMap) throws SQLException;

	int selectAppInfoEduno(Map<String, Object> paramMap) throws SQLException;

	int updateGrResultByTempCompletion(DataMap paramMap) throws SQLException;

	DataMap selectGrResultListByEduno(Map<String, Object> paramMap) throws SQLException;

	int selectGrResultMaxRno(String grseq) throws SQLException;

	int updateGrResultRno(Map<String, Object> paramMap) throws SQLException;

	int updateGrseqClosing(Map<String, Object> paramMap) throws SQLException;

	int updateGrResultTempCompletion(Map<String, Object> paramMap) throws SQLException;
}
