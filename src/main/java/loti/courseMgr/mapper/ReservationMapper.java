package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ReservationMapper {
	
	DataMap reservationlist(String type) throws SQLException;

	int reservationaction(Map<String, Object> paramMap) throws SQLException;

	int updateReservationaction(Map<String, Object> paramMap) throws SQLException;

	int delReservation(String pk) throws SQLException;

	DataMap holyday(String yyyy) throws SQLException;

	DataMap selectYearGroup() throws SQLException;

	int insertHolyDay(DataMap requestMap) throws SQLException;

	int updateHolyDay(DataMap requestMap) throws SQLException;

	int deleteHolyDay(DataMap requestMap) throws SQLException;

	int countHolyday(String holyday) throws SQLException;

	String selectHolyDay(String holydayKey) throws SQLException;

	int saveChackHolyday() throws SQLException;

	String saveChackEndDate() throws SQLException;

	int saveChackStartDate() throws SQLException;

	String getCurrentdate(String format) throws SQLException;

	DataMap getUseMenu() throws SQLException;

	DataMap getUseMenu2(String menucd) throws SQLException;

	DataMap holydayUiList(Map<String, Object> paramMap) throws SQLException;

	void updateUseMenu(DataMap requestMap) throws SQLException;

	DataMap selectResvAdmin() throws SQLException;

	int selectRaNo() throws SQLException;

	int insertResvAdmin(DataMap requestMap) throws SQLException;

	int deleteResvAdmin(DataMap requestMap) throws SQLException;

	int saveReservationSurvey(Map<String, Object> paramMap) throws SQLException;
	
	DataMap setResvAdmin() throws SQLException;

	int getDayCheck() throws SQLException;

	int ajaxSaveMgrYn(DataMap requestMap) throws SQLException;

	int ajaxDeleteMgrYn(DataMap requestMap) throws SQLException;

	DataMap CheckSaveMgrYn(DataMap requestMap) throws SQLException;

	DataMap SaveMgrYnList(DataMap requestMap) throws SQLException;
	
}
