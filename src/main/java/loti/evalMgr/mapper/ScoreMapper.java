package loti.evalMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ScoreMapper {

	DataMap selectScoreOption(DataMap requestMap) throws SQLException;

	DataMap selectScoreSubj(DataMap requestMap) throws SQLException;

	DataMap selectScoreInfo(DataMap requestMap) throws SQLException;

	DataMap selectLangClass(String commSubj) throws SQLException;

	DataMap selectClassCnt(DataMap requestMap) throws SQLException;

	DataMap selectBf_Pcnt(DataMap requestMap) throws SQLException;

	DataMap selectPersonList(DataMap requestMap) throws SQLException;

	DataMap selectClassCount(DataMap requestMap) throws SQLException;

	DataMap selectClassList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectLangClassCount(DataMap requestMap) throws SQLException;

	DataMap selectLangClassList(Map<String, Object> paramMap) throws SQLException;

	int updatePerson(Map<String, Object> paramMap) throws SQLException;

	int updateClass(Map<String, Object> paramMap) throws SQLException;

	int updateLangClass(Map<String, Object> paramMap) throws SQLException;

	int updateLangClassPoint(Map<String, Object> paramMap) throws SQLException;

	int updateLangClassPoint2(Map<String, Object> paramMap) throws SQLException;

	DataMap selectScoreParam3(DataMap requestMap) throws SQLException;

	DataMap selectPointUpList(DataMap requestMap) throws SQLException;

	DataMap selectPointUpClosing(DataMap requestMap) throws SQLException;

	int updatePoint(Map<String, Object> paramMap) throws SQLException;


}
