package loti.evalMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface DistributionMapper {

	DataMap selectTotList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectJikList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectDeptList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAgeList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectSexList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectSubjOption(DataMap requestMap) throws SQLException;

	DataMap selectScoreParam1(DataMap requestMap) throws SQLException;

}
