package loti.homeFront.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CourseMapper {

	int getCourseDataCnt(Map<String, Object> params) throws SQLException;

	DataMap getCourseData(Map<String, Object> params) throws SQLException;

	DataMap getCourseInfoPopup1(String grcode) throws SQLException;

	DataMap getCourseInfoPopup2(String grcode) throws SQLException;

	DataMap getCourseInfoSum(String grcode) throws SQLException;

	DataMap getCourseInfoSubSum(Map<String, Object> params) throws SQLException;

	DataMap getCourseInfoDetail(String grcode) throws SQLException;

	int searchCourseDataCnt(Map<String, Object> params) throws SQLException;

	DataMap searchCourseData(Map<String, Object> params) throws SQLException;

	int selecteducationcourseCount(Map<String, Object> params) throws SQLException;

	DataMap selecteducationcourse(Map<String, Object> params) throws SQLException;

}
