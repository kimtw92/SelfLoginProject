package loti.evalMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.config.SmsMapper;

@SmsMapper
public interface ReportSmsMapper {

	void insertSMSList(Map<String, Object> paramMap) throws SQLException;

}
