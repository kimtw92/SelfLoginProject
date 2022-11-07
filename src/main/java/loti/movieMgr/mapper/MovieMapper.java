package loti.movieMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MovieMapper {

	int deleteContInfoBySubj(DataMap requestMap) throws SQLException;

	DataMap selectDivList() throws SQLException;

	DataMap selectContList(DataMap requestMap) throws SQLException;

	int selectContListCount(DataMap requestMap) throws SQLException;

	DataMap selectContList_(DataMap requestMap) throws SQLException;

	int selectContList_count(DataMap requestMap) throws SQLException;

	DataMap selectContListBySubj(String subj) throws SQLException;

	DataMap selectContListBySubj_(String subj) throws SQLException;

	DataMap selectDivRow(String divCode) throws SQLException;

	DataMap selectContRow(String contCode) throws SQLException;

	DataMap selectContRowLec(DataMap requestMap) throws SQLException;

	int insertDivInfo(DataMap requestMap) throws SQLException;

	int insertItem(DataMap requestMap) throws SQLException;

	int insertContInfo(DataMap requestMap) throws SQLException;

	int updateDivInfo(DataMap requestMap) throws SQLException;

	int updateContInfo(DataMap requestMap) throws SQLException;

	int updateVisitCountMov(DataMap requestMap) throws SQLException;

	int updateCmiTime(DataMap requestMap) throws SQLException;

	int deleteDivInfo(DataMap requestMap) throws SQLException;

	int deleteContInfo(DataMap requestMap) throws SQLException;

	int deleteItem(DataMap requestMap) throws SQLException;

	String selectSequence() throws SQLException;

	String selectSubjCode() throws SQLException;

}
