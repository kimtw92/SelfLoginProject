package loti.homepageMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface FaqMapper {

	DataMap selectFaqList(DataMap pagingInfoMap) throws SQLException;

	int selectFaqListCount(DataMap pagingInfoMap) throws SQLException;

	DataMap selectSubCodeFaqList() throws SQLException;

	DataMap selectFaqViewRow(String fno) throws SQLException;

	int selectFaqFnoRow() throws SQLException;

	int insertFaq(DataMap params) throws SQLException;

	int modifyFaqUseYn(Map<String, Object> params) throws SQLException;

	int modifyFaqFno(int fno) throws SQLException;

	int modifyFaq(DataMap params) throws SQLException;

	int deleteFaq(int fno) throws SQLException;

}
