package loti.poll.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface PollBankMapper {

	int selectGrinqBankQuestionBySearchDescListCount(DataMap requestMap) throws SQLException;

	DataMap selectGrinqBankQuestionBySearchDescList(DataMap requestMap) throws SQLException;

	DataMap selectGrinqBankQuestionBySimpleList(String whereStr) throws SQLException;

	int deleteGrinqBankSampByQuestionNo(int questionNo) throws SQLException;

	int deleteGrinqBankQuestion(int questionNo) throws SQLException;

	DataMap selectGrinqBankSampList(int questionNo) throws SQLException;

	DataMap selectNotPagingGrinqBankQuestionBySearchDescList(int questionNo) throws SQLException;

	int selectGrinqBankQuestionMaxNo() throws SQLException;

	int insertGrinqBankQuestion(DataMap requestMap) throws SQLException;

	int insertGrqinqBankSamp(DataMap bankSamp) throws SQLException;

	int updateGrinqBankQuestion(DataMap requestMap) throws SQLException;

}
