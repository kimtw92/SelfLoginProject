package loti.baseCodeMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface DicMapper {

	DataMap selectDicTypeList() throws SQLException;

	DataMap selectDicTypeRow(String types) throws SQLException;

	DataMap selectDicTypesCheck(String types) throws SQLException;

	int insertDicType(DataMap requestMap) throws SQLException;

	int updateDicType(DataMap requestMap) throws SQLException;

	int selectDicListCount(DataMap requestMap) throws SQLException;

	DataMap selectDicList(DataMap requestMap) throws SQLException;

	DataMap selectDicRow(DataMap requestMap) throws SQLException;

	int insertDic(DataMap requestMap) throws SQLException;

	int updateDic(DataMap requestMap) throws SQLException;

	int deleteDic(DataMap requestMap) throws SQLException;

	DataMap selectDicTestList() throws SQLException;

	DataMap selectDicViewBySubj(DataMap requestMap) throws SQLException;

	DataMap selectSearchDic(DataMap requestMap) throws SQLException;

}
