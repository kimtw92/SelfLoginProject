package loti.evalMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ResultMapper {

	DataMap selectResultList(DataMap requestMap) throws SQLException;

	DataMap selectResultList2(DataMap requestMap) throws SQLException;

	DataMap selectJachiList(DataMap requestMap) throws SQLException;

	DataMap selectSungJukList(DataMap requestMap) throws SQLException;

}
