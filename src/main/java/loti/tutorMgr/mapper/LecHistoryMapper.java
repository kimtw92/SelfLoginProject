package loti.tutorMgr.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface LecHistoryMapper {

	int tutorLecHistoryListCount(Map params) throws SQLException;

	DataMap tutorLecHistoryList(Map<String, Object> pageInfo) throws SQLException;

	DataMap tutorLecHistoryInfo(String no) throws SQLException;

	DataMap checkMonday(String strDate) throws SQLException;

	DataMap checkLecHistoryDupcnt(DataMap requestMap) throws SQLException;

	int insertTutorLecHistory(DataMap requestMap) throws SQLException;

	int updateTutorLecHistory(DataMap requestMap) throws SQLException;

	DataMap selectLecHistoryDetail(String userno) throws SQLException;

	int deleteTutorLecHistory(String no) throws SQLException;


}
