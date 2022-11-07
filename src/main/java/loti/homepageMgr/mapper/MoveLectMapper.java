package loti.homepageMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MoveLectMapper {

	int selectMoveLectListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectMoveLectList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectFileUrl(String groupfileNo) throws SQLException;

	DataMap selectMoveLectRow(String string) throws SQLException;

	int insertMovelect(DataMap requestMap) throws SQLException;

	int updateMovelect(DataMap requestMap) throws SQLException;

	int deleteMovelect(DataMap requestMap) throws SQLException;

}
