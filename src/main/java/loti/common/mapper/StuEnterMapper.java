package loti.common.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface StuEnterMapper {

	DataMap selectMemberSimpleByResnoRow(Map<String, Object> params) throws SQLException;

	DataMap selectMemberSimpleByUseridRow(Map<String, Object> params) throws SQLException;

	DataMap selectMemberSimpleByNameRow(Map<String, Object> params) throws SQLException;

	int selectGrseqEapplyedChk(Map<String, Object> params) throws SQLException;

	int selectGrseqEndsentChk(Map<String, Object> params) throws SQLException;

	int updateMemberSimple(Map userMap) throws SQLException;

	int selectMemberResnoChk(String resno) throws SQLException;

	String selectMemberMaxUserNo() throws SQLException;

	int insertMemberSimple(Map requestMap) throws SQLException;

	int selectAppInfoMemberChk(DataMap requestMap) throws SQLException;

	int updateAppInfoDirect(DataMap requestMap) throws SQLException;

	int insertAppInfoDirect(DataMap appInfoMap) throws SQLException;

	DataMap selectAppInfoBySessAndDeptList2(Map pagingInfoMap) throws SQLException;

	DataMap selectAppInfoBySessAndDeptList(Map<String, Object> params) throws SQLException;

	int updateAppInfoByDeptAndJik(DataMap requestMap) throws SQLException;

	int updateMemberByDept(DataMap requestMap) throws SQLException;

	DataMap selectDeptByAppInfoList(Map<String, Object> params) throws SQLException;

	DataMap selectDeptDogsCrossList(Map<String, Object> params) throws SQLException;

	DataMap selectJikrByAppInfoList(Map<String, Object> params) throws SQLException;

	DataMap selectJikrDogsCrossList(Map<String, Object> params) throws SQLException;

	DataMap selectAppMemberUpsdateList(Map<String, Object> params) throws SQLException;

	DataMap selectAppInfoUpsdateRowBySysdate(Map<String, Object> params) throws SQLException;

	DataMap selectAppInfoStatisticsByAgeRow(Map<String, Object> params) throws SQLException;

	DataMap selectAppInfoStatisticsBySchoolList(Map<String, Object> params) throws SQLException;

	DataMap selectAppInfoStatisticsByAddrList(Map<String, Object> params) throws SQLException;

	int selectSubjSeqEndDateChkByCyber(Map<String, Object> params) throws SQLException;

	DataMap selectAppInfoByMemberList(Map<String, Object> params) throws SQLException;

	int updateAppInfoGrChkAndStartExam(DataMap appMap) throws SQLException;

	DataMap stuMemberList(DataMap requestMap) throws SQLException;

	int stuMemberListCount(DataMap requestMap) throws SQLException;

}
