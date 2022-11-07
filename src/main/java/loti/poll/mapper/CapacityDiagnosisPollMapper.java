package loti.poll.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CapacityDiagnosisPollMapper {

	
	DataMap selectCapacityDiagnosisByCheck(DataMap requestMap) throws SQLException;
	
	DataMap selectCapacityDiagnosisBySearchList(DataMap requestMap) throws SQLException;

	int insertCapacityDiagnosis(DataMap requestMap) throws SQLException;

}
