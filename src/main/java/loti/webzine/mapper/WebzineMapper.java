package loti.webzine.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper
public interface WebzineMapper {

	int selectComplateListCount(Map<String, Object> params) throws SQLException;

	DataMap selectComplateList(Map<String, Object> params) throws SQLException;

	DataMap selectComplateRow(int photoNo) throws SQLException;

	DataMap selectNewYearList() throws SQLException;

	int insertPhotoUpload(DataMap insertMap) throws SQLException;

	int deleteComplate(int photoNo) throws SQLException;

	int modifyComplate(DataMap insertMap) throws SQLException;

	int modifyHoldComplate(Map<String, Object> params) throws SQLException;

	DataMap selectEbookList(DataMap pagingInfoMap) throws SQLException;

	int selectEbookListCount(DataMap pagingInfoMap) throws SQLException;

	DataMap selectEbookRow(int ebookNo) throws SQLException;

	int insertEbook(DataMap insertMap) throws SQLException;

	int deleteEbook(int ebookNo) throws SQLException;

	int modifyEbook(DataMap insertMap) throws SQLException;

	int modifyHoldEbook(DataMap requestMap) throws SQLException;

}
