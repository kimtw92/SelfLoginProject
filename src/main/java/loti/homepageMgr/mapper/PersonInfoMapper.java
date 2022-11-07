package loti.homepageMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface PersonInfoMapper {

	int selectPersonInfoListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectPersonInfoList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectPersonInfoExcel(Map<String, Object> paramMap) throws SQLException;

}
