package loti.poll.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface InquiryPollMapper {

	DataMap selectInquiryPollAjax(DataMap requestMap) throws SQLException;

	DataMap selectInquirySetPollAjax(DataMap requestMap) throws SQLException;

}
