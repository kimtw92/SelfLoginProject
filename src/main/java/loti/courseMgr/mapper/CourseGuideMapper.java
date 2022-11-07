package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CourseGuideMapper {

	int selectGrGuideListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrGuideList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectSubjClassByMaxClassNoList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrGuideRow(Map<String, Object> paramMap) throws SQLException;

	int selectGrGuideChk(Map<String, Object> paramMap) throws SQLException;

	String selectGrGuideMaxGrseq(Map<String, Object> paramMap) throws SQLException;

	int updateGrGuide(DataMap requestMap) throws SQLException;

	int insertGrGuide(DataMap requestMap) throws SQLException;

	int deleteGrGuide(Map<String, Object> paramMap) throws SQLException;

	DataMap selectCourseGuideBySubjTutorList(Map<String, Object> paramMap) throws SQLException;

}
