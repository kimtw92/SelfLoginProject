package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface StuAddressMapper {

	int selectAppInfoDetailInfoListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectAppInfoDetailInfoList(Map<String, Object> pageInfo) throws SQLException;

}
