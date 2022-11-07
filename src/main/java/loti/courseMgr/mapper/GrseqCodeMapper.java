package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface GrseqCodeMapper {

	DataMap selectGrseqMngList(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrseqMngRow(Map<String, Object> paramMap) throws SQLException;

	int selectGrseqMngMaxSeq(Map<String, Object> paramMap) throws SQLException;

	int selectGrseqMngGrseqChk(Map<String, Object> paramMap) throws SQLException;

	int insertGrseqMng(Map<String, Object> paramMap) throws SQLException;

	int updateGrseqMng(Map<String, Object> paramMap) throws SQLException;

	int deleteGrseqMng(Map<String, Object> paramMap) throws SQLException;

}
