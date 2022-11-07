package loti.contentsMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ContentsMapper {

	int selectContentSubjListCount(DataMap requestMap) throws SQLException;

	DataMap selectContentSubjList(Map<String, Object> pageInfo) throws SQLException;

	int selectLecturerListCount(DataMap requestMap) throws SQLException;

	DataMap selectLecturerList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectSubjBySimpleRow(String subj) throws SQLException;

	DataMap selectScormMappingOrgList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectScormMappingOrgBySeqKeyList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectLcmsImageCategoryList() throws SQLException;

	DataMap selectLcmsCategoryList() throws SQLException;

	int updateScormMappingOrgByPreviewYn(DataMap requestMap) throws SQLException;

	int deleteSubjSeq(Map<String, Object> paramMap) throws SQLException;

}
