package loti.homepageMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("homepageMgrNoticeMapper")
public interface NoticeMapper {

	DataMap selectNotiPerGrpList(DataMap params) throws SQLException;

	DataMap selectNotiPerGrpRow(int seq) throws SQLException;

	int updateNotiPerGrpVisitCnt(int seq) throws SQLException;

}
