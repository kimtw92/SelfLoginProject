package loti.baseCodeMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface GrannaeMapper {

	DataMap selectGrAnnaeList(String year) throws SQLException;
	
	DataMap selectGrannaeRow(DataMap requestMap) throws SQLException;
	
	DataMap selectGrannae2List(DataMap requestMap) throws SQLException;
	
	DataMap selectGrSeqList(DataMap requestMap) throws SQLException;

	int insertGrannae(DataMap requestMap) throws SQLException;
	
	int insertGrannae2(Map<String, Object> paramMap) throws SQLException;
	
	int updateGrannae(DataMap requestMap) throws SQLException;
	
	int deleteGrannae(Map<String, Object> paramMap) throws SQLException;
	
	int deleteGrannae2(Map<String, Object> paramMap) throws SQLException;
	
	DataMap selectGrannaeByPrevYearList(DataMap requestMap) throws SQLException;
	
	int selectGrannaeCount(Map<String, Object> paramMap) throws SQLException;
	
	int insertGrannaeCopy(Map<String, Object> paramMap) throws SQLException;
	
	int insertGrannae2Copy(Map<String, Object> paramMap) throws SQLException;
}
