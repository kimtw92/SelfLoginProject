package loti.baseCodeMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface SubjMapper {

	DataMap selectCharIndex() throws SQLException;

	int selectSubjListCount(DataMap requestMap) throws SQLException;

	DataMap selectSubjList(Map<String, Object> pageInfo) throws SQLException;

	int selectSubjListByIndexCount(DataMap requestMap) throws SQLException;

	DataMap selectSubjListByIndex(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectSubjRow(String subj) throws SQLException;

	String selectSubjNextSubj(String tmpSubj) throws SQLException;

	int insertSubjByCyber(DataMap requestMap) throws SQLException;

	int selectScormMappingInfoMaxSeq() throws SQLException;

	int insertScormMappingInfo(Map<String, Object> paramMap) throws SQLException;

	int selectScormMappingOrgMaxSeq() throws SQLException;

	int insertScormMappingOrg(DataMap paramMap) throws SQLException;

	DataMap selectLcmsItemListBySimple(String orgDir) throws SQLException;

	int insertScormMappingItem(Map<String, Object> paramMap) throws SQLException;

	int insertSubjByGeneral(DataMap requestMap) throws SQLException;

	int insertSubjByMov(DataMap requestMap) throws SQLException;

	int insertOrganization(DataMap paramMap) throws SQLException;

	int deleteScormMappingItem(String subj) throws SQLException;

	int deleteScormMappingOrg(String subj) throws SQLException;

	int deleteScormMappingInfo(String subj) throws SQLException;

	int updateSubjByCyber(DataMap requestMap) throws SQLException;

	int updateSubjByGeneral(DataMap requestMap) throws SQLException;

	int insertSubjgrp(Map<String, Object> paramMap) throws SQLException;

	int deleteSubjByStep1(String subj) throws SQLException;

	int deleteSubjByStep2(String subj) throws SQLException;

	int deleteSubjByStep3(String subj) throws SQLException;

	int deleteLcmsOrg(String subj) throws SQLException;

	DataMap selectSearchSubjPop(String searchTxt) throws SQLException;

	DataMap selectSubjgrp(String subj) throws SQLException;

	DataMap selectMaxSubj(String subjCode) throws SQLException;

	int insertSubjBySelect(DataMap requestMap) throws SQLException;

	DataMap selectLcmsCategoryList() throws SQLException;

	DataMap selectSubjByContentMappingList(String subj) throws SQLException;

	DataMap selectLcmsOrganizationList(String lcmsCtId) throws SQLException;

}
