package loti.homepageMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("homepageMgrPopupZoneMapper")
public interface PopupZoneMapper {

	int selectPopupZoneListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectPopupZoneList(Map<String, Object> pageInfo) throws SQLException;

	int insertPopupZone(DataMap requestMap) throws SQLException;

	DataMap selectPopupZone(String seq) throws SQLException;

	int deletePopupZoneFile(DataMap requestMap) throws SQLException;

	int deletePopupZone(String seq) throws SQLException;

	int updatePopupZone(DataMap requestMap) throws SQLException;

	DataMap getMainPopupZoneList() throws SQLException;

}
