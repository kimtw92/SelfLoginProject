package loti.courseMgr.mapper;

import java.sql.SQLException;

import ut.lib.config.SmsMapper;
import ut.lib.support.DataMap;

@SmsMapper
public interface MailSmsMapper {

	int insertSmsMsg(DataMap smsMap) throws SQLException;

}
