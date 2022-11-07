package loti.homeFront.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.config.SmsMapper;

@SmsMapper
public interface IndexSmsMapper {
	

	int sendSms(Map<String, Object> params) throws SQLException;

}
