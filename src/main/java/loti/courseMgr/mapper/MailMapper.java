package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("courseMgrMailMapper")
public interface MailMapper {

	DataMap selectGrcodeRow(String grcode) throws SQLException;

	DataMap selectAppInfoEnterList(Map<String, Object> params) throws SQLException;

	DataMap selectGrResultUserList(Map<String, Object> params) throws SQLException;

	DataMap selectUserInfo(String userid) throws SQLException;

	DataMap selectDeptManagerList(Map<String, Object> params) throws SQLException;

	DataMap selectClassTutorGrseqList(Map<String, Object> params) throws SQLException;

	DataMap selectAppInfoEnterUserList(Map<String, Object> params) throws SQLException;

	DataMap selectGrResultUserList2(Map<String, Object> params) throws SQLException;

	DataMap selectDeptManagerUserList(Map<String, Object> params) throws SQLException;

	DataMap selectClassTutorGrseqList2(Map<String, Object> params) throws SQLException;

}
