package loti.courseMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface DiscussMapper {

	DataMap selectGrDiscussTopList(Map<String, Object> paramMap) throws SQLException;

	int selectGrDiscussBySearchListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectGrDiscussBySearchList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectGrDiscussRow(Map<String, Object> paramMap) throws SQLException;

	int selectGrDiscussReplyCheck(Map<String, Object> paramMap) throws SQLException;

	int updateGrDiscussByDelete(Map<String, Object> paramMap) throws SQLException;

	int deleteGrDiscuss(Map<String, Object> paramMap) throws SQLException;

	int selectGrDiscussMaxSeq() throws SQLException;

	int insertGrDiscuss(Map<String, Object> paramMap) throws SQLException;

	int updateGrDiscuss(Map<String, Object> paramMap) throws SQLException;

	double selectGrDiscussReplyCheck2(Map<String, Object> paramMap) throws SQLException;

	int insertGrDiscussByReply(Map<String, Object> paramMap) throws SQLException;

}
