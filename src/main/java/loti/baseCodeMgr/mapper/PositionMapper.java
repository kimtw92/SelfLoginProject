package loti.baseCodeMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface PositionMapper {

	int selectPositionListCount(DataMap requestMap) throws SQLException;
	
	DataMap selectPositionList(Map<String, Object> paramMap) throws SQLException;

	DataMap rowMaxPosition() throws SQLException;

	DataMap selectPositionPopList() throws SQLException;

	int insertPosition(Map<String, Object> paramMap) throws SQLException;

	int modifyPosition(Map<String, Object> paramMap) throws SQLException;

	int selectGuBunCodeListCount(String guBun) throws SQLException;

	DataMap selectGuBunCodeList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectGuBunCodeSelectBoxList() throws SQLException;

	int selectGubunCodeCountRow(String code) throws SQLException;

	int insertGubunCode(Map<String, Object> paramMap) throws SQLException;

	int selectCountJikRow(String jik) throws SQLException;

	int insertAllPosition(Map<String, Object> paramMap) throws SQLException;
}
