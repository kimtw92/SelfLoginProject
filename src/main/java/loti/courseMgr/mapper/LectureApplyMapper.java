package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface LectureApplyMapper {

	DataMap selectMemberBySimpleDataList(String where) throws SQLException;

	DataMap selectMemberBySimpleDataList2(Map<String, Object> params) throws SQLException;

	int insertStuLecUserSpec(DataMap requestMap) throws SQLException;

	int updateAppInfoGrChk(DataMap lecMap) throws SQLException;
//
	DataMap selectDeptList() throws SQLException;

	DataMap selectGrseqFinishMember2(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrseqFinishMemberForCyber(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByDeptList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByDeptListForCyber2(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByDeptCntList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByDeptCntListForCyber(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByGrChkList(Map<String, Object> paramMap) throws SQLException;

	int updateAppInfoEduNo(DataMap appInfoMap) throws SQLException;

	int selectStuLecUserCnt(Map<String, Object> paramMap) throws SQLException;

	int updateAppInfoGrChkAndEduNo(DataMap appInfoMap) throws SQLException;

	int deleteSubjResultByUserno(Map<String, Object> paramMap) throws SQLException;

	int deleteStuLecByGrseq(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoByGrChkMaxCnt(Map<String, Object> paramMap) throws SQLException;

	int updateAppInfoDeptChk(DataMap appInfoMap) throws SQLException;

	DataMap selectMemberDeptSimpleRow(String userNo) throws SQLException;

	DataMap selectMemberFinishList(String userNo) throws SQLException;

	DataMap selectAppInfoRow(Map<String, Object> paramMap) throws SQLException;

	DataMap selectDeptByUserYnList(String useYn) throws SQLException;

	DataMap selectPartUseList(String dept) throws SQLException;

	DataMap selectLdapcodeList(String dept) throws SQLException;

	int setMemberDept2(Map<String, Object> paramMap) throws SQLException;

	int updateGrrSultDeptAndPart(Map<String, Object> paramMap) throws SQLException;

	int updateAppInfoDeptAndPart(Map<String, Object> paramMap) throws SQLException;

	int selectAppInfoListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectGrseqByCyberGrcodeList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoBySessDeptList2(Map<String, Object> paramMap) throws SQLException;

	int selectAppInfoBySessDeptList3Count(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoBySessDeptList3(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectDeptBySimpleRow(String dept) throws SQLException;

	int updateAppInfoDeptNChk(Map<String, Object> paramMap) throws SQLException;

}
