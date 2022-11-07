package loti.subjMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ClassMapper {

	DataMap selectCountBySubjresult(DataMap requestMap) throws SQLException;

	DataMap selectDeptClassList(DataMap requestMap) throws SQLException;

	DataMap selectClassList(DataMap requestMap) throws SQLException;

	DataMap selectClassViewList(DataMap requestMap) throws SQLException;

	DataMap selectCountByStuLec(DataMap requestMap) throws SQLException;

	DataMap selectStuLecList(DataMap requestMap) throws SQLException;

	int deleteBySubjClass(DataMap requestMap) throws SQLException;

	int insertBySubjClass(DataMap params) throws SQLException;

	int updateByStulec(DataMap requestMap) throws SQLException;

	DataMap selectCountBySubjClass(DataMap requestMap) throws SQLException;

	int deleteBySubjClassToOne(DataMap requestMap) throws SQLException;

	DataMap selectSubjClass(Map<String, Object> params) throws SQLException;

	int updateSubjClassByDept(DataMap params) throws SQLException;

	DataMap selectSubjClassByDeptType2(DataMap requestMap) throws SQLException;

	DataMap selectFreeList(DataMap requestMap) throws SQLException;

	int updateSubjClassByFreeOption(DataMap params) throws SQLException;

	DataMap selectOptionList(DataMap requestMap) throws SQLException;

	DataMap selectOtherClassList(DataMap requestMap) throws SQLException;

	int otherClassStep1ByDelete(DataMap params) throws SQLException;

	int otherClassStep2ByInsert(DataMap params) throws SQLException;

	DataMap selectStuLec(DataMap requestMap) throws SQLException;

	int otherClassStep3ByUpdate(DataMap params) throws SQLException;

	DataMap selectStuClassList(String sqlWhere) throws SQLException;

	DataMap selectStuClassTopSubj(String subj) throws SQLException;

	DataMap selectCheckGrayn(DataMap params) throws SQLException;

	DataMap selectStuClassListByDetail(DataMap params) throws SQLException;

	int updateStuClassListByDetail(DataMap params) throws SQLException;

}
