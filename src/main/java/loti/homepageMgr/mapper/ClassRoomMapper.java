package loti.homepageMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("homepageMgrClassRoomMapper")
public interface ClassRoomMapper {

	DataMap selectClassRoomList(DataMap requestMap) throws SQLException;

	int selectClassRoomNoChk(String classroomNo) throws SQLException;

	int modifyClassRoom(DataMap requestMap) throws SQLException;

	int insertClassRoom(DataMap requestMap) throws SQLException;

	int deleteClassRoom(String string) throws SQLException;

	DataMap selectExcelList(String date) throws SQLException;

}
