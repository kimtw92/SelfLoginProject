package loti.courseMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ResultHtmlMapper {

	DataMap selectResultDocRow(int no) throws SQLException;

	int updateResultDoc(DataMap objMap) throws SQLException;

	int insertResultDoc(DataMap objMap) throws SQLException;

}
