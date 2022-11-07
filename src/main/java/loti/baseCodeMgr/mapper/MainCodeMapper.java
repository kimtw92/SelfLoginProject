package loti.baseCodeMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MainCodeMapper {
	public DataMap selectMainCodeList() throws SQLException;
	
	public DataMap selectSubCodeList(Map<String, Object> paramMap) throws SQLException;
	
	public DataMap selectMinorPopFormList(Map<String, Object> paramMap) throws SQLException;
	
	public void updateSubCode(Map<String, Object> paramMap) throws SQLException;
	
	public DataMap selectMajorPopFormList(Map<String, Object> paramMap) throws SQLException;
	
	public void updateMainCode(Map<String, Object> paramMap) throws SQLException;
	
	public DataMap selectSubMaxCode(Map<String, Object> paramMap) throws SQLException;
	
	public int insertSubCode(Map<String, Object> paramMap) throws SQLException;
	
	public DataMap selectMainMaxCode(DataMap requestMap) throws SQLException;
	
	public int insertMainCode(DataMap requestMap) throws SQLException;
	
	public DataMap selectMainCodeGubunUseYnList(Map<String, Object> paramMap) throws SQLException;
	
	public DataMap selectMainSubCodeList(DataMap requestMap) throws SQLException;
}
