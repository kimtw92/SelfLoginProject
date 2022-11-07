package loti.homeFront.mapper;

import java.sql.SQLException;

import loti.homeFront.vo.PersonVO;
import ut.lib.config.MailMapper;

@MailMapper
public interface IndexMailMapper {

	int sendMail(PersonVO vo) throws SQLException;

}
