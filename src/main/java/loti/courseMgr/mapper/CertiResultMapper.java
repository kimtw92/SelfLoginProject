package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CertiResultMapper {

	DataMap selectGrResultByAllList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrResultByAllNotSearchList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrResultCompletionCntRow(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrResultDeptList(Map<String, Object> paramMap) throws SQLException;

	int updateGrResultByAllRawardnoNull(Map<String, Object> paramMap) throws SQLException;

	int updateGrResultByAllRnoNull(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrResultSimpleList(Map<String, Object> paramMap) throws SQLException;

	int updateGrResultByRno(Map<String, Object> paramMap) throws SQLException;

	int selectGrResultByUserRawardNoChk(Map<String, Object> paramMap) throws SQLException;

	void updateGrResultByRawardNo(Map<String, Object> paramMap) throws SQLException;

	int selectGrResultNextRawardNo(String year) throws SQLException;

	DataMap selectGrResultListBySearch(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrResultListByUserno(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrResultListByDept(Map<String, Object> paramMap) throws SQLException;

	int selectGrResultByAllListForCyberCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrResultByAllListForCyber(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectGrResultByAllListForCyber2(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrResultCompletionCntRowForCyber(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrResultDeptListForCyber(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrResultByResultDocList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectStuLectBySubjStudyList(Map<String, Object> paramMap) throws SQLException;

}
