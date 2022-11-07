package loti.member.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapException;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper
public interface MemberMapper {

	int ajaxCreateId2(DataMap requestMap) throws SQLException;

	DataMap selectMemberListAuth5(DataMap requestMap) throws SQLException;

	int selectMemberListAuth5Count(DataMap requestMap) throws SQLException;

	DataMap selectMemberListAuth(DataMap requestMap) throws SQLException;

	DataMap selectDeptList() throws SQLException;

	DataMap selectTotalMemberRow() throws SQLException;

	DataMap selectIdRow() throws SQLException;

	int selectMemberListAuthCount(DataMap requestMap) throws SQLException;

	DataMap selectMemberInfoRow(String userNo) throws SQLException;

	DataMap selectLdapCodeList(String dept) throws SQLException;

	DataMap selectPartCodeList(String dept) throws SQLException;

	int memberCheckID(String user_id) throws SQLException;

	int modifyMember_userId(DataMap reqeustMap) throws SQLException;

	int modifyMember2(DataMap reqeustMap) throws SQLException;

	DataMap selectStudyDocList(DataMap requestMap) throws SQLException;

	DataMap selectEducationalRow() throws SQLException;

	int modifyStudyExec(DataMap requestMap) throws SQLException;

	DataMap selectGadminList() throws SQLException;

	DataMap selectManagerList(DataMap pagingMap) throws SQLException;

	int selectManagerListCount(DataMap pagingMap) throws SQLException;

	DataMap selectGadminRow() throws SQLException;

	int selectAdminHistoryListCount(DataMap pagingMap) throws SQLException;

	DataMap selectAdminHistoryList(DataMap pagingMap) throws SQLException;

	int selectGadminCount(DataMap requestMap) throws SQLException;

	DataMap selectMemberList(DataMap requestMap) throws SQLException;

	int insertAdminExec(DataMap requestMap) throws SQLException;

	int selectGadminSaveCount(DataMap requestMap) throws SQLException;

	int deleteManager(DataMap requestMap) throws SQLException;

	int updateGadmin(String userNo) throws SQLException;

	int updateDisabledGadmin(DataMap requestMap) throws SQLException;

	int insertGadminHistroy(DataMap requestMap) throws SQLException;

	DataMap selectSchoolRegRow(Map<String, Object> params) throws SQLException;

	DataMap selectCompleteList(DataMap requestMap) throws SQLException;

	DataMap selectSchoolRegList(DataMap requestMap) throws SQLException;

	DataMap selectstudyPersonList(DataMap requestMap) throws SQLException;

	DataMap selectPointSearchPerson(Map<String, Object> params) throws SQLException;

	DataMap selectPointSearchPerson2(String search) throws SQLException;

	int updatePointPerson(DataMap requestMap) throws SQLException;

	int deletePointPerson(DataMap requestMap) throws SQLException;

	int insertBreakDownExec(DataMap requestMap) throws SQLException;

	int ajaxCreateId(DataMap requestMap) throws SQLException;

}
