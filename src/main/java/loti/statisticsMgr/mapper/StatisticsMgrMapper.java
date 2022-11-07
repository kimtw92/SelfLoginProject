package loti.statisticsMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface StatisticsMgrMapper {

	DataMap tabMenu(Map<String, Object> params) throws SQLException;

	DataMap majorList(Map<String, Object> params) throws SQLException;

	DataMap courseStats(Map<String, Object> params) throws SQLException;
	
	DataMap departBestStats(String grseq) throws SQLException;
	
	DataMap ageBestStats(String grseq) throws SQLException;
	
	DataMap genderManBestStats(String grseq) throws SQLException;
	
	DataMap genderWomanBestStats(String grseq) throws SQLException;
	
	DataMap courseStats2(Map<String, Object> params) throws SQLException;

	DataMap accidentStats(String searchYear) throws SQLException;

	DataMap selectJikr(String searchYear) throws SQLException;

	DataMap targetEduStatsByJikr(Map<String, Object> params) throws SQLException;

	DataMap targetEduStatsByHuman(String searchYear) throws SQLException;

	DataMap eduPlanAvgScore(Map<String, Object> params) throws SQLException;

	DataMap eduPlanRange(Map<String, Object> params) throws SQLException;

	DataMap cyberCourseStats(Map<String, Object> params) throws SQLException;

	DataMap courseRgister(Map<String, Object> params) throws SQLException;

	DataMap cyberGrseqInfo(String grseq) throws SQLException;

	DataMap cyberDeptInfo(String grseq) throws SQLException;

	DataMap cyberDeptRgister(Map<String, Object> params) throws SQLException;

	DataMap cyberDetailDeptRgister(Map<String, Object> params) throws SQLException;

	DataMap courseRgisterTotal(Map<String, Object> params) throws SQLException;

	DataMap cyberGrseqInfoTotal(String grseq) throws SQLException;

	DataMap cyberDeptInfoTotal(String grseq) throws SQLException;

	DataMap cyberDeptRgisterTotal(Map<String, Object> params) throws SQLException;

	DataMap cyberDetailDeptRgisterTotal(Map<String, Object> params) throws SQLException;

	DataMap pollStatsQuestion() throws SQLException;

	DataMap pollStatsByGrseq(String sqlWhere) throws SQLException;

	DataMap pollStatsByGrcode(String sqlWhere) throws SQLException;

	DataMap logStatsByDay(Map<String, Object> params) throws SQLException;

	DataMap logStatsByMonth(Map<String, Object> params) throws SQLException;

	DataMap selectPeriodMemberStatsList(DataMap requestMap) throws SQLException;

	DataMap selectDeptMemberStatsList(DataMap requestMap) throws SQLException;

	DataMap selectJiktMemberStatsList(DataMap requestMap) throws SQLException;

	DataMap selectSigunMemberStatsList(DataMap requestMap) throws SQLException;

	DataMap selectScholarshipMemberStatsList(DataMap requestMap) throws SQLException;

	DataMap selectAgeMemberStatsList(DataMap requestMap) throws SQLException;

	DataMap selectMemberAgeStatsList(DataMap requestMap) throws SQLException;

	DataMap selectTutorWorkStatsDateList(DataMap requestMap) throws SQLException;

	int selectTutorWorkStatsDateListCount(DataMap requestMap) throws SQLException;

	DataMap selectTutorWorkStatsMonthList(DataMap requestMap) throws SQLException;

	int selectTutorWorkStatsMonthListCount(DataMap requestMap) throws SQLException;

	int selectMobileMonthListCount(DataMap requestMap) throws SQLException;

	DataMap selectMobileMonthList(DataMap requestMap) throws SQLException;

	int selectMobileDayListCount(DataMap requestMap) throws SQLException;

	DataMap selectMobileDayList(DataMap requestMap) throws SQLException;

	int mobileMemberCnt() throws SQLException;
	
	String getMaxGrSeq() throws SQLException;
	
	DataMap tierBestStats(String grseq) throws SQLException;

}
