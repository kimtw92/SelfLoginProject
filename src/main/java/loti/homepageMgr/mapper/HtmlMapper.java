package loti.homepageMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("homepageMgrHtmlMapper")
public interface HtmlMapper {

	int selectHtmlListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectHtmlList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectHtmlRow(String htmlId) throws SQLException;

	int selectHtmlCountRow(String string) throws SQLException;

	int insertHtml(DataMap requestMap) throws SQLException;

	int modifyHtml(DataMap requestMap) throws SQLException;

	int deleteHtml(String htmlId) throws SQLException;

}
