package loti.homeFront.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface LecturerMapper {

	String nextLecturerSeqno() throws SQLException;

	int insertLecturer(DataMap p_requestMap) throws SQLException;

	void insertLecturerHistory(Map<String, Object> params) throws SQLException;

	int updateLecturer(DataMap p_requestMap) throws SQLException;

	void deleteLecturerHistory(String string) throws SQLException;

	DataMap getLecturerSearch(Map<String, Object> params) throws SQLException;

	DataMap getLecturerView(Map<String, Object> params) throws SQLException;

	DataMap getLecturerView2(String p_seqno) throws SQLException;

	DataMap getLecturerFileNo(Map<String, Object> params) throws SQLException;

	DataMap getLecturerFileNo2(String p_seqno)throws SQLException;

	DataMap lecturerHistoryList(Map<String, Object> params) throws SQLException;

	int deleteLecturer(String p_seqno) throws SQLException;

}
