package loti.tutorMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface StatisticsMapper {

	DataMap salaryStatsList(Map<String, Object> params) throws SQLException;

	DataMap salaryStatsListType1(Map<String, Object> params) throws SQLException;

	DataMap salaryStatsListType2(Map<String, Object> params) throws SQLException;

	DataMap tutorGradeStats(Map params) throws SQLException;

	DataMap tutorMemberList(String year) throws SQLException;

}
