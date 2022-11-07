package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("courseMgrNoticeMapper")
public interface NoticeMapper {

	int selectGrNoticeListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrNoticeList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectGrNoticeRow(Map<String, Object> paramMap) throws SQLException;

	int selectGrNoticeMaxNo(Map<String, Object> paramMap) throws SQLException;

	int insertGrNotice(Map<String, Object> paramMap) throws SQLException;

	int updateGrNotice(Map<String, Object> paramMap) throws SQLException;

	int deleteGrNotice(Map<String, Object> paramMap) throws SQLException;

}
