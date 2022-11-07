package loti.evalMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("evalMgrReportMapper")
public interface ReportMapper {

	DataMap selectReportClassNoList(DataMap requestMap) throws SQLException;

	DataMap selectReportNoList(DataMap requestMap) throws SQLException;

	DataMap selectReportYearList(String commYear) throws SQLException;

	DataMap selectReportGrCodeList(DataMap requestMap) throws SQLException;

	DataMap selectReportGrSeqList(DataMap requestMap) throws SQLException;

	DataMap selectReportEndDate(DataMap requestMap) throws SQLException;

	DataMap selectReportStudentList(DataMap requestMap) throws SQLException;

	DataMap selectReportNoSMSList(Map<String, Object> paramMap) throws SQLException;


	DataMap selectReportGrcodeNm(String commGrcode) throws SQLException;

}
