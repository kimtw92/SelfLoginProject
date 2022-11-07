package loti.tutorMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ChulTutorMapper {

	DataMap selectChulTutorList(DataMap requestMap) throws SQLException;

	int selectChulTutorListCount(DataMap requestMap) throws SQLException;

	DataMap selectChulTutorAllCountRow() throws SQLException;

	DataMap selectChulTutorCourseAllCountRow(String grcode) throws SQLException;

	DataMap selectChulTutorCourseCountRow(String grcode) throws SQLException;

	DataMap selectCoursorList() throws SQLException;

	DataMap selectChulTutorListExcel(DataMap requestMap) throws SQLException;

	int selectTotalListCount(DataMap requestMap) throws SQLException;

	DataMap selectTotalList(DataMap requestMap) throws SQLException;

}
