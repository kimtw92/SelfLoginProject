package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("courseMgrStuEnterMapper")
public interface StuEnterMapper {

	DataMap selectMemberSimpleByResnoRow(Map<String, Object> paramMap) throws SQLException;

	DataMap selectMemberSimpleByUseridRow(Map<String, Object> paramMap) throws SQLException;

	DataMap selectMemberSimpleByNameRowAndUserid(Map<String, Object> paramMap) throws SQLException;

	int selectGrseqEapplyedChk(Map<String, Object> paramMap) throws SQLException;

	int selectGrseqEndsentChk(Map<String, Object> paramMap) throws SQLException;

	int updateMemberSimple2(Map<String, Object> paramMap) throws SQLException;

	int selectMemberResnoChk(String resno) throws SQLException;

	String selectMemberMaxUserNo() throws SQLException;

	int insertMemberSimple(DataMap requestMap) throws SQLException;

	int selectAppInfoMemberChk(Map<String, Object> paramMap) throws SQLException;

	int updateAppInfoDirect(Map<String, Object> paramMap) throws SQLException;

	int insertAppInfoDirect(DataMap appInfoMap) throws SQLException;

	int selectAppInfoBySessAndDeptList2Count(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoBySessAndDeptList2(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectAppInfoBySessAndDeptList(Map<String, Object> paramMap) throws SQLException;

	int updateAppInfoByDeptAndJik(DataMap requestMap) throws SQLException;

	int updateMemberByDept(DataMap requestMap) throws SQLException;

	DataMap selectDeptByAppInfoList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectDeptDogsCrossList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectJikrByAppInfoList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectJikrDogsCrossList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppMemberUpsdateList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoUpsdateRowBySysdate(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoStatisticsByAgeRowBirthdate(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoStatisticsBySchoolList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoStatisticsByAddrList(Map<String, Object> paramMap) throws SQLException;

	int selectSubjSeqEndDateChkByCyber(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByMemberList(Map<String, Object> paramMap) throws SQLException;

	void updateAppInfoGrChkAndStartExam(DataMap appMap) throws SQLException;

	int stuMemberListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap stuMemberList(Map<String, Object> pageInfo) throws SQLException;

}
