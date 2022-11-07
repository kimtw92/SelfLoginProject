package loti.evalMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface EvalAnalyMapper {

	DataMap selectScoreTotData(DataMap requestMap) throws SQLException;

	DataMap selectScoreAvgData(DataMap requestMap) throws SQLException;

	DataMap selectScoreList(DataMap requestMap) throws SQLException;

	DataMap selectAnalyListParam1(DataMap requestMap) throws SQLException;

	DataMap selectAnalyListParam2(DataMap requestMap) throws SQLException;

	DataMap selectAnalyListParam3(DataMap requestMap) throws SQLException;
	
	DataMap selectAnalyListParam4(DataMap requestMap) throws SQLException;

	DataMap selectCourseHistoryGrcode() throws SQLException;

}
