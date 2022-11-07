package loti.evalMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface EvalItemMapper {

	DataMap selectEvalItemClosing(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemEvalCnt(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemChildParent(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemRecordList(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemSrecordList(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemReportCnt(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemGradeInfo(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemClassInfo(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemSubjClosing(DataMap requestMap) throws SQLException;

	int updateEvalItemSubjList(Map<String, Object> paramMap) throws SQLException;

	int updateEvalItemSubjSlist(Map<String, Object> paramMap) throws SQLException;

	int updateEvalItemReportpoint(Map<String, Object> paramMap) throws SQLException;

	int updateEvalItemReportCnt(Map<String, Object> paramMap) throws SQLException;

	DataMap selectEvalItemPointInfo(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemSubjPointInfo(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemGunTaePoint(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemMpoint(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemLpoint(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemSsubjPoint(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemStepPoint(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemReportPoint(DataMap requestMap) throws SQLException;

	DataMap selectEvalItemQuizPoint(DataMap requestMap) throws SQLException;

	int updateEvalItemEduTrain(DataMap requestMap) throws SQLException;

}
