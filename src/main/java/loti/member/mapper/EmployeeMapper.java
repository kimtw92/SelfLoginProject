package loti.member.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface EmployeeMapper {

	int selectMemberStatsListCount(DataMap requestMap) throws SQLException;

	DataMap selectMemberStatsList(DataMap requestMap) throws SQLException;

	DataMap selectMemberStatsRow(DataMap requestMap) throws SQLException;

	int insertMemberStats(DataMap requestMap) throws SQLException;

	int modifyMemberStats(DataMap requestMap) throws SQLException;

	int deleteMemberStats(DataMap requestMap) throws SQLException;

}
