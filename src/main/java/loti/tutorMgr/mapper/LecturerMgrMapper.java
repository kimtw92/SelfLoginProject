package loti.tutorMgr.mapper;

import java.sql.SQLException;
import java.util.List;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface LecturerMgrMapper {

	DataMap getAjaxCheckYN(DataMap requestMap) throws SQLException;

	int selectLecturerInfoListCount(DataMap requestMap) throws SQLException;

	DataMap selectLecturerInfoList(DataMap requestMap) throws SQLException;

	int getAjaxUpdakYN(DataMap requestMap) throws SQLException;

}
