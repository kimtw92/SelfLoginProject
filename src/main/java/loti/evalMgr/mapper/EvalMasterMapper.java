package loti.evalMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface EvalMasterMapper {

	DataMap selectEvalMasterParam1(DataMap requestMap) throws SQLException;

	DataMap selectEvalMasterParam2(DataMap requestMap) throws SQLException;

	DataMap selectEvalMasterList1(DataMap requestMap) throws SQLException;

	DataMap selectEvalMasterGrcodeNm(String commGrcode) throws SQLException;

	DataMap selectEvalMasterInfoGrseq(DataMap requestMap) throws SQLException;

	DataMap selectEvalMasterInfoPtype(DataMap requestMap) throws SQLException;

	DataMap selectEvalMasterInfoMptype(DataMap requestMap) throws SQLException;

	DataMap selectEvalMasterClosing(DataMap requestMap) throws SQLException;

	int updateEvInfoGrseq(DataMap requestMap) throws SQLException;

	int insertEvInfoGrseq(DataMap requestMap) throws SQLException;

	DataMap selectGrcodeLecNm(DataMap requestMap) throws SQLException;

	DataMap selectEvalMasterSubjPtype(DataMap requestMap) throws SQLException;

	DataMap selectEvalSubjType(String commSubj) throws SQLException;

	DataMap selectEvalMasterDates(String commSubj) throws SQLException;

	DataMap selectEvalMasterExchange(Map<String, Object> paramMap) throws SQLException;

	int deleteEvalInfoSubj(Map<String, Object> paramMap) throws SQLException;

	int updateEvalInfoSubj(Map<String, Object> paramMap) throws SQLException;

	DataMap selectTotalSubj(Map<String, Object> paramMap) throws SQLException;

	int insertEvalInfoSubj(Map<String, Object> paramMap) throws SQLException;

}
