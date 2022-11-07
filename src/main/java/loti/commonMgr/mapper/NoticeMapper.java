package loti.commonMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface NoticeMapper {

	int selectNoticeMaxNo() throws SQLException;

	int insertNotice(DataMap requestMap) throws SQLException;

	int deleteNotice(Map<String, Object> params) throws SQLException;

	int updateNotice(DataMap requestMap) throws SQLException;

	DataMap selectSearchPerList(DataMap requestMap) throws SQLException;

	int selectSearchPerListCount(DataMap requestMap) throws SQLException;

	DataMap selectNotiPerGrpList(DataMap pagingInfoMap) throws SQLException;

	int selectNotiPerGrpListCount(DataMap pagingInfoMap) throws SQLException;

	DataMap selectNotiPerGrpRow(int seq) throws SQLException;

	DataMap searchName(String userno) throws SQLException;

	int updateNotiPerGrpVisitCnt(int seq) throws SQLException;

}
