package loti.homepageMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("homepageMgrTimeTableMapper")
public interface TimeTableMapper {

	Integer selectWeekCnt(Map<String, Object> params) throws SQLException;

	DataMap selectStartEndDateByNow(Map<String, Object> params) throws SQLException;

	DataMap selectTimeGosiListBetween1And9() throws SQLException;

	DataMap selectTimeGosiList() throws SQLException;

	DataMap selectClassRoomByGrseqRow(Map<String, Object> params) throws SQLException;

	String selectDualTableByOneCol(String string) throws SQLException;

	DataMap selectTimeTableByPlan1(Map<String, Object> params) throws SQLException;

	DataMap selectTimeTableByPlan2(Map<String, Object> params) throws SQLException;

}
