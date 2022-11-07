package loti.homepageMgr.mapper;

import java.sql.SQLException;
import java.util.Map;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface FoodMapper {

	int selectFoodListCount(Map<String, Object> paramMap) throws SQLException;

	DataMap selectFoodList(Map<String, Object> pageInfo) throws SQLException;

	DataMap selectFoodRow(Map<String, Object> paramMap) throws SQLException;

	int insertFood(Map<String, Object> paramMap) throws SQLException;

	int updateFood(Map<String, Object> paramMap) throws SQLException;

	int ajaxCountChechk(Map<String, Object> paramMap) throws SQLException;

	int deleteFood(Map<String, Object> paramMap) throws SQLException;

}
