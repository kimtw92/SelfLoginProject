package ut.lib.interceptors;

import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.executor.resultset.ResultSetHandler;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ResultMap;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;

import ut.lib.support.DataMap;

@Intercepts({ @Signature(type = ResultSetHandler.class, method = "handleResultSets", args = { Statement.class }) })
public class ResultSetInterceptor implements Interceptor {

	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		List actual = new ArrayList();

		Object[] args = invocation.getArgs();
		Statement statement = (Statement) args[0];
		ResultSet rs = statement.getResultSet();
		ResultSetMetaData rsmd = rs.getMetaData();

		ResultSetHandler resultSetHandler = (ResultSetHandler) invocation.getTarget();

		Field mappendStatement = resultSetHandler.getClass().getDeclaredField("mappedStatement"); 
		
		if(!mappendStatement.isAccessible()){
			mappendStatement.setAccessible(true);
		}

		MappedStatement ms = (MappedStatement) mappendStatement.get(resultSetHandler);
		

		if (rs == null)
			return actual;

		List list = (List) invocation.proceed();
		
		List<ResultMap> rms = ms.getResultMaps();
		ResultMap rm = rms != null && rms.size() > 0 ? rms.get(0) : null;
		Class type = rm != null && rm.getType() != null ? rm.getType() : null;
		
		if(type == DataMap.class){
			DataMap result = new DataMap().putAll(list);
			list = new ArrayList();
			list.add(result);
			return list;
		}
		

//		if (list.size() < 1) {
//
//			int columnCount = rsmd.getColumnCount();
//			Map columnMeta = new EgovMap();
//
//			for (int i = 1; i <= columnCount; i++) {
//				String columnName = rsmd.getColumnName(i);
//				columnMeta.put(columnName, "");
//			}
//
//			actual.add(columnMeta);
//		} else if (list.size() > 0) {
//			actual = list;
//		}

		actual = list;
		
		return actual;
	}

	@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	@Override
	public void setProperties(Properties paramProperties) {
		// TODO Auto-generated method stub

	}

}
