package loti.common.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CommonMapper { 

	DataMap selectClassRoomList() throws SQLException;

	DataMap selectGrCodeByTutor(Map params) throws SQLException;

	DataMap selectGrCodeByIng(Map params) throws SQLException;

	DataMap selectGrCodeByAll(Map params) throws SQLException;

	DataMap selectGrSeqByTutor(Map param) throws SQLException;

	DataMap selectGrSeq(Map param) throws SQLException;

	DataMap selectSubj(Map param) throws SQLException;

	DataMap selectPageAdminInfo(String menucode) throws SQLException;

	DataMap selectUploadFileList(Integer fileNo) throws SQLException;

	void deleteUploadGroupFileNo(int groupfileNo) throws SQLException;

	DataMap checkKeyword() throws SQLException;

	DataMap selectTopMenu(String menuGrade) throws SQLException;

	DataMap selectLeftMenu(Map params) throws SQLException;

	DataMap selectLeftSubMenu(Map params) throws SQLException;

	DataMap selectTotalLeftMenu(Map params) throws SQLException;

	DataMap selectCurrentMenuName(Map params) throws SQLException;

	DataMap selectNavigationMenu(Map params) throws SQLException;

	DataMap selectGrSeqByCyber(String year) throws SQLException;

	DataMap selectUploadFileRow(Map params) throws SQLException;

	String selectUserNameString(String userNo) throws SQLException;

	DataMap selectSearchZip(String addrStr) throws SQLException;

	DataMap selectSearchZip(Map params) throws SQLException;

	DataMap selectTwoSearchZip(Map params) throws SQLException;

	int selectMaxGroupFileNo() throws SQLException;

	void insertCopyUpload(Map params) throws SQLException;

	void insertFileUpload(Map insertMap) throws SQLException;

	int updateUploadVisitCnt(Map params) throws SQLException;

	DataMap selectSearchDept(String jiknm) throws SQLException;

	DataMap selectDicGroupCodeByCbo() throws SQLException;

	DataMap selectSubjCodeByCbo() throws SQLException;

	DataMap selectTutorGubunByCbo() throws SQLException;

	DataMap selectTutorLevelByCbo() throws SQLException;

	DataMap selectGrCodeByRow(String grCode) throws SQLException;

	DataMap selectSubjByRow(String subj) throws SQLException;

	int deleteCommonQuery(Map params) throws SQLException;

	DataMap selectDeptSearch(String deptnm) throws SQLException;

	DataMap selectPageAdminInfoList() throws SQLException;

	DataMap selectMenuScoreList() throws SQLException;

	DataMap selectTotalMenuScoreList(String menucode) throws SQLException;

	int savePageAdmininfo(Map params) throws SQLException;

	int updateMenuScoreUseyn(Map params) throws SQLException;

	int saveMenuScore(Map params) throws SQLException;

	int selectMenuScore(Map params) throws SQLException;

	String selectDeptnmRow(String dept) throws SQLException;

	DataMap selectGrCodeByLec() throws SQLException;

	DataMap selectGrSeqByLec(String grCode) throws SQLException;

	DataMap selectSubjByLec(Map params) throws SQLException;

	DataMap selectGrcodeByCyber(String grSeq) throws SQLException;

	DataMap selectEtestExamList(Map params) throws SQLException;

	void deleteAllZipcode() throws SQLException;

	int insertAllZipcode(Map params) throws SQLException;

	DataMap selectSubjClassByClassList(Map params) throws SQLException;

	DataMap selectSubjSeqByChioceList(Map params) throws SQLException;

	void updatePasswd(Map<String, Object> params) throws SQLException;

	String selectGadminString(String gadmin) throws SQLException;


	
	
	
}
