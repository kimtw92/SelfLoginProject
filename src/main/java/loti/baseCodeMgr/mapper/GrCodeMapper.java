package loti.baseCodeMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface GrCodeMapper {

	int selectGrCodeListCount(DataMap requestMap) throws SQLException;
	
	DataMap selectGrCodeList(Map<String, Object> pageInfo) throws SQLException; 
	
	DataMap selectGrCodeRow(String grCode) throws SQLException;
	
	String selectMaxGrCode(String grGubun) throws SQLException;
	
	int insertGrCode(Map<String, Object> paramMap) throws SQLException;
	
	int updateGrCode(Map<String, Object> paramMap) throws SQLException;
	
	int selectGrSeqCheck(String grCode) throws SQLException;
	
	int deleteGrCode(String grCode) throws SQLException;
}
