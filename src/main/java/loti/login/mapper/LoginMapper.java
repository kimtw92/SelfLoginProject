package loti.login.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface LoginMapper {

	DataMap selectLoginChk(String userId) throws SQLException;
	
	DataMap selectLoginPwdChk(String userId) throws SQLException;

	DataMap selectAuthority(String userNo) throws SQLException;

	int updateLoginInfo(String userNo) throws SQLException;

	int updateLoginFailInfo(Map<String, Object> params) throws SQLException;

	String checkPasswordIsNull(String id) throws SQLException;

	String checkPersonalInfo(Map<String, Object> params) throws SQLException;

	void sendSmsSetPassword(Map<String, Object> params) throws SQLException;

	int openUpdatePassword(Map<String, Object> params) throws SQLException;
	
	int openUpdateDamoPassword(Map<String, Object> params) throws SQLException;

	void setPasswordLog(Map<String, Object> params) throws SQLException;

	DataMap selectSSOLoginChk(String resno) throws SQLException;
	
	DataMap selectPwdChk(String userno) throws SQLException;

}
