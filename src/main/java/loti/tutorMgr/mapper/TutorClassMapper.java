package loti.tutorMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface TutorClassMapper {

	int selectTutorClassListCount(Map<String, Object> params) throws SQLException;

	DataMap selectTutorClassList(Map<String, Object> params) throws SQLException;

	DataMap selectSubjSeq(Map<String, Object> params) throws SQLException;

	int selectTutorSubjInputListCount(DataMap requestMap) throws SQLException;

	DataMap selectTutorSubjInputList(Map<String, Object> pageInfo) throws SQLException;

	int selectClassTutorInfoCount(DataMap requestMap) throws SQLException;

	DataMap selectClassTutorInfo(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectClassRoom() throws SQLException;

	int updateClassTutor(DataMap requestMap) throws SQLException;

	DataMap checkClassTutor(DataMap requestMap) throws SQLException;

	int insertClassTutor(DataMap requestMap) throws SQLException;

	int deleteClassTutor(DataMap requestMap) throws SQLException;

	DataMap tutorInfoPopByBaseInfo(String userno) throws SQLException;

	DataMap tutorInfoPopByHistory(String userno) throws SQLException;

	DataMap tutorInfoPopByClassTutor(String userno) throws SQLException;

	DataMap tutorInfoPopByClassTutorNew(String userno) throws SQLException;

}
