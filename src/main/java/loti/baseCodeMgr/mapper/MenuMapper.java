package loti.baseCodeMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MenuMapper {
	
	DataMap selectMenuAdminList() throws SQLException;
	
	DataMap selectMenuList(String menuGrade) throws SQLException;
	
	int insertMenuCheck(DataMap requestMap) throws SQLException;
	
	int insertMenu(DataMap requestMap) throws SQLException;
	
	int updateMenu(DataMap requestMap) throws SQLException;
	
	int deleteMenu(DataMap requestMap) throws SQLException;
	
	DataMap getLayerList() throws SQLException;

}
