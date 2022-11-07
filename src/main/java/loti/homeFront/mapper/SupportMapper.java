package loti.homeFront.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface SupportMapper {

	DataMap memberView(String sessUserId) throws SQLException;

	int boardListCount(Map<String, Object> params) throws SQLException;

	DataMap boardList(Map<String, Object> params) throws SQLException;

	int insertBbsBoard(Map<String, Object> params) throws SQLException;

	int selectResNoCnt(String resno) throws SQLException;

	int selectFaqListCount(String where) throws SQLException;

	DataMap selectFaqList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectSubCodeFaqList() throws SQLException;

	DataMap selectFaqViewRow(String fno) throws SQLException;

	int selectFaqFnoRow() throws SQLException;

	int modifyFaqFno(int fno) throws SQLException;

	int getOpenCourseListCount(Map<String, Object> params) throws SQLException;
	
	DataMap getOpenCourseList(Map<String, Object> params) throws SQLException;

	DataMap getOpenCourseView(String subj) throws SQLException;

	int countExistResno(String resno) throws SQLException;

	int countExistDupinfo(String dupinfo) throws SQLException;

	int countExistVirtualno(String virtualno) throws SQLException;

	DataMap selectMyGrCodeNmList(DataMap requestMap) throws SQLException;

	int insertBbsBoardPerson(Map<String, Object> params) throws SQLException;

	int boardPersonListCount(Map<String, Object> params) throws SQLException;

	DataMap boardPersonList(Map<String, Object> params) throws SQLException;


	void popupEctInsert(Map<String, Object> params) throws SQLException;

}
