package loti.homeFront.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper
public interface EBookMapper {

	int ebookListCount() throws SQLException;

	DataMap ebookList(Map<String, Object> pageInfo) throws SQLException;

}
