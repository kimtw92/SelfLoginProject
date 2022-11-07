package loti.subjMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface LangSubjMapper {

	DataMap selectLangSubjList(String sqlWhere) throws SQLException;

	DataMap selectClassList(Map<String, Object> params) throws SQLException;

	DataMap selectLangSubjFormList(Map<String, Object> params) throws SQLException;

	int selectLangSubjFormListCount(Map<String, Object> params) throws SQLException;

	int updateLangSubj(Map<String, Object> params) throws SQLException;

}
