package loti.baseCodeMgr.mapper;

import java.sql.SQLException;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface DeptMapper {

	DataMap selectDeptCodeList(DataMap pagingInfoMap) throws SQLException;

	DataMap selectAllDeptCodeList(DataMap requestMap) throws SQLException;

	DataMap selectPartCodeList(String dept) throws SQLException;

	DataMap selectDeptCodeForm(String dept) throws SQLException;

	DataMap selectAllDeptCodeForm(String dept) throws SQLException;

	DataMap selectDeptCodeCountRow(String dept) throws SQLException;

	int insertDept(DataMap requestMap) throws SQLException;

	int insertAllDept(DataMap requestMap) throws SQLException;

	int modifyDeptCode(DataMap requestMap) throws SQLException;

	int modifyAllDeptCode(DataMap requestMap) throws SQLException;

	DataMap selectPartCodeRow(String dept) throws SQLException;

	DataMap selectPartCodeCountRow(String partcd) throws SQLException;

	int insertPart(DataMap requestMap) throws SQLException;

	int partUpdate(DataMap requestMap) throws SQLException;

	DataMap selectPartRow(DataMap requestMap) throws SQLException;

	int selectPartCodeCheckRow(String dept) throws SQLException;

	int deptDelete(String dept) throws SQLException;

	int allDeptDelete(String dept) throws SQLException;

	int partDelete(DataMap requestMap) throws SQLException;

	int selectDeptCodeListCount(DataMap requestMap) throws SQLException;

	DataMap selectDeptCodeListNotPaging(DataMap requestMap) throws SQLException;

	int selectAllDeptCodeListCount(DataMap requestMap) throws SQLException;

	DataMap selectAllDeptCodeRow(DataMap requestMap) throws SQLException;
}
