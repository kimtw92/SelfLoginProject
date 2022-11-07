package loti.homepageMgr.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper
public interface BoardMapper {

//	@Select("SELECT VISIT FROM TB_BOARD_${boardId} WHERE SEQ =#{seq}")
	@Select("${value}")
	int selectBbsBoardCount(String query) throws SQLException;

	int updateBbsBoardVisit(Map<String, Object> params) throws SQLException;

	DataMap selectbbsBoardViewWithoutPhoneAndAddr(Map<String,Object> params) throws SQLException;

	DataMap selectbbsBoardViewWithPhoneAndAddr(Map<String,Object> params) throws SQLException;

	@Select("SELECT COUNT(*) AS TOTAL FROM TB_BOARD_${boardId} WHERE STEP < #{step} AND STEP > #{minSetp}")
	int selectBbsBoardCountBetweenStep(Map<String, Object> params) throws SQLException;

	int deleteBbsBoard(String talbeName) throws SQLException;

	int modifyBbsBoard(Map<String, Object> params) throws SQLException;

	double selectBbsBoardMinNoRow(Map<String, Object> params) throws SQLException;

	DataMap selectBbsPopup() throws SQLException;

	int selectBoardListCount(DataMap pagingInfoMap) throws SQLException;

	DataMap selectBoardList(DataMap pagingInfoMap) throws SQLException;

	DataMap selectBoardManagerRow(String boardId) throws SQLException;

	DataMap selectAuthBoardRow(String boardId) throws SQLException;

	DataMap selectUseBoardAuthRow(DataMap params) throws SQLException;

	DataMap selectGadminBoardRow() throws SQLException;

	int updateDefaultInfo(DataMap requestMap) throws SQLException;

	int deleteAuthBoardInfo(String boardId) throws SQLException;

	int insertAuthBoardInfo(Map<String, Object> params) throws SQLException;

	int selectBoardIdChk(String boardId) throws SQLException;

	int insertBoardMnger(DataMap requestMap) throws SQLException;

	int createBoardTable(String boardId) throws SQLException;

	int setBoardTablePk(String boardId) throws SQLException;

	int setBoardTableComment(String boardId) throws SQLException;

	int dropBoardTable(String boardId) throws SQLException;

	int renameBoardTable(Map<String, Object> params) throws SQLException;

	int deleteBoardManager(String boardId) throws SQLException;

	int deleteBoardAuth(String boardId) throws SQLException;

	int selectBbsBoardListCount(Map<String, Object> params) throws SQLException;

	DataMap selectBbsBoardList(Map<String, Object> params) throws SQLException;

	DataMap selectbbsBoardViewIncludePostAndPhone(Map<String, Object> params) throws SQLException;

	DataMap selectbbsBoardViewExceptPostAndPhone(Map<String, Object> params) throws SQLException;

	int insertBbsBoard(DataMap requestMap) throws SQLException;

	DataMap selectbbsBoardViewQna(Map<String, Object> params) throws SQLException;

	DataMap selectbbsBoardViewWithEpilogue(Map<String, Object> params) throws SQLException;

}
