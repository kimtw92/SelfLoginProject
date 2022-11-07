package loti.common.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("commonStuOutMapper")
public interface StuOutMapper {

	int insertStuLecByRejSpec(DataMap requestMap) throws SQLException;

	int insertReportSubmitByRejSpec(DataMap requestMap) throws SQLException;

	int insertExResultByRejSpec(DataMap requestMap) throws SQLException;

	int deleteRejExResultSpec(DataMap requestMap) throws SQLException;

	int deleteRejReportSubmitSpec(DataMap requestMap) throws SQLException;

	int deleteRejStuLecSpec(DataMap requestMap) throws SQLException;

	int insertRejStuLecSpec(Map<String, Object> params) throws SQLException;

	int insertRejReportSubmitSpec(Map<String, Object> params) throws SQLException;

	int insertRejExresultSpec(Map<String, Object> params) throws SQLException;

	int deleteExResultSpec(Map<String, Object> params) throws SQLException;

	int deleteReportSubmitSpec(Map<String, Object> params) throws SQLException;

	int deleteStuLecSpec(Map<String, Object> params) throws SQLException;

}
