package loti.homepageMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface SiteMapper {

	int selectSiteListCount(DataMap pagingInfoMap) throws SQLException;

	DataMap selectSiteList(DataMap pagingInfoMap) throws SQLException;

	DataMap selectSiteRow(int siteNo) throws SQLException;

	int insertSite(DataMap requestMap) throws SQLException;

	int modifySite(DataMap requestMap) throws SQLException;

	int deleteSite(int siteNo) throws SQLException;
}
