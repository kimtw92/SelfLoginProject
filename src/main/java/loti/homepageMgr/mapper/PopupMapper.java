package loti.homepageMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("homepageMgrPopupMapper")
public interface PopupMapper {
	
	DataMap getMainPopupZoneList() throws SQLException;

	int selectPopupListCount(DataMap pagingInfoMap) throws SQLException;

	DataMap selectPopupList(DataMap pagingInfoMap) throws SQLException;

	DataMap selectPopupViewRow(int no) throws SQLException;

	DataMap selectPopupModifyRow(int no) throws SQLException;

	int insertPopup(DataMap params) throws SQLException;

	int selectMaxNoRow() throws SQLException;

	int modifyPopup(DataMap params) throws SQLException;

	int deletePopup(int no) throws SQLException;

}
