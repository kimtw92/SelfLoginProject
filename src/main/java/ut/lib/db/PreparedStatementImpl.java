//package ut.lib.db;
//
//
//import java.io.InputStream;
//import java.io.Reader;
//import java.math.BigDecimal;
//import java.net.URL;
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.Calendar;
//
//import ut.lib.support.DataMap;
//import ut.lib.util.Constants;
//import ut.lib.util.UseTime;
//
//
///**
// * @author Administrator
// *
// * TODO To change the template for this generated type comment go to
// * Window - Preferences - Java - Code Style - Code Templates 
// */
//
//public class PreparedStatementImpl implements PreparedStatement{
//    private PreparedStatement pstmt;
//    private String str;
//    private ArrayList list;
//    private Class className;
//
//    public int length() {
//    	return list.size();
//    }
//
//    private void a(int i, Object obj)
//    {
//        if(i < 1)
//            return;
//        for(; i > list.size(); list.add(null));
//        list.set(i - 1, obj);
//    }
//
//    public PreparedStatementImpl(PreparedStatement preparedstatement, String s)
//    {
//        str = null;
//        list = new ArrayList();
//        pstmt = preparedstatement;
//        str = s;
//    }
//
//
//    public PreparedStatementImpl(PreparedStatement preparedstatement, String s, Class className)
//    {
//        str = null;
//        list = new ArrayList();
//        pstmt = preparedstatement;
//        str = s;
//        this.className = className;
//    }
//
//
//
//    public ResultSet executeQuery() throws SQLException
//    {
//        ResultSet resultset;
//        UseTime ut = new UseTime();
//        String returnMessage = "";
//
//        try {
//			resultset = (ResultSet)new ResultSetImpl(pstmt.executeQuery());
//        } catch (SQLException sqlexception) {
//			sqlexception.printStackTrace();
//			returnMessage = sqlexception.getMessage();
//
//			throw sqlexception;
//		} finally {
//			long useTime = ut.getTime();
//	    	if (Constants.DBWRAP_FLAG) {
//	    		DBTracer.logPrint("PSTMT.EQ", useTime, str, list, 0, returnMessage, className);
//	    	}
//
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//
//	    	}
//        }
//        return resultset;
//    }
//
//    public int executeUpdate() throws SQLException
//    {
//        int i = 0;
//        UseTime ut = new UseTime();
//        String returnMessage = "";
//
//        try {
//        	i = pstmt.executeUpdate();
//		} catch (SQLException sqlexception) {
//
//			returnMessage = sqlexception.getMessage();
//
//	    	if (Constants.DBWRAP_FLAG) {
//	    		DBTracer.logPrint("PSTMT.EU", 0, str, list, sqlexception.toString(), className);
//	    	}
//			throw sqlexception;
//		} finally {
//			long useTime = ut.getTime();
//	    	if (Constants.DBWRAP_FLAG) {
//	    		DBTracer.logPrint("PSTMT.EQ", useTime, str, list, i, returnMessage, className);
//	    	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//
//	    	}
//        }
//        return i;
//    }
//
//
//
//    public void setNull(int i, int j) throws SQLException
//    {
//        a(i, null);
//        pstmt.setNull(i, j);
//    }
//
//    public void setBoolean(int i, boolean flag) throws SQLException
//    {
//        a(i, new Boolean(flag));
//        pstmt.setBoolean(i, flag);
//    }
//
//    public void setByte(int i, byte byte0) throws SQLException
//    {
//        a(i, new Byte(byte0));
//        pstmt.setByte(i, byte0);
//    }
//
//    public void setShort(int i, short word0) throws SQLException
//    {
//        a(i, new Short(word0));
//        pstmt.setShort(i, word0);
//    }
//
//    public void setInt(int i, int j) throws SQLException
//    {
//        a(i, new Integer(j));
//        pstmt.setInt(i, j);
//    }
//
//    public void setLong(int i, long l) throws SQLException
//    {
//        a(i, new Long(l));
//        pstmt.setLong(i, l);
//    }
//
//    public void setFloat(int i, float f) throws SQLException
//    {
//        a(i, new Float(f));
//        pstmt.setFloat(i, f);
//    }
//
//    public void setDouble(int i, double d) throws SQLException
//    {
//        a(i, new Double(d));
//        pstmt.setDouble(i, d);
//    }
//
//    public void setBigDecimal(int i, BigDecimal bigdecimal) throws SQLException
//    {
//        a(i, bigdecimal);
//        pstmt.setBigDecimal(i, bigdecimal);
//    }
//
//    public void setString(int i, String s) throws SQLException
//    {
//        a(i, s);
//
//        pstmt.setString(i, s);
//        //pstmt.setString(i, s);
//    }
//
//    public void setBytes(int i, byte abyte0[]) throws SQLException
//    {
//        a(i, abyte0);
//        pstmt.setBytes(i, abyte0);
//    }
//
//    public void setDate(int i, Date date) throws SQLException
//    {
//        a(i, date);
//        pstmt.setDate(i, date);
//    }
//
//    public void setTime(int i, Time time) throws SQLException
//    {
//        a(i, time);
//        pstmt.setTime(i, time);
//    }
//
//    public void setTimestamp(int i, Timestamp timestamp) throws SQLException
//    {
//        a(i, timestamp);
//        pstmt.setTimestamp(i, timestamp);
//    }
//
//    public void setAsciiStream(int i, InputStream inputstream, int j) throws SQLException
//    {
//        a(i, inputstream + "(" + j + ")");
//        pstmt.setAsciiStream(i, inputstream, j);
//    }
//
//    public void setUnicodeStream(int i, InputStream inputstream, int j) throws SQLException
//    {
//        throw new SQLException("Not Support : setUnicodeStream(int parameterIndex, InputStream x, int length)");
//    }
//
//    public void setBinaryStream(int i, InputStream inputstream, int j) throws SQLException
//    {
//        a(i, "InputStream(" + j + ")");
//        pstmt.setBinaryStream(i, inputstream, j);
//    }
//
//    public void clearParameters() throws SQLException
//    {
//        list = new ArrayList();
//        pstmt.clearParameters();
//    }
//
//    public void setObject(int i, Object obj, int j, int k) throws SQLException
//    {
//        a(i, obj);
//        pstmt.setObject(i, obj, j, k);
//    }
//
//    public void setObject(int i, Object obj, int j) throws SQLException
//    {
//        a(i, obj);
//        pstmt.setObject(i, obj, j);
//    }
//
//    public void setObject(int i, Object obj) throws SQLException
//    {
//        a(i, obj);
//
//        if (obj instanceof String) {			// 한글 처리를 위해서 스트링만 별도 처리한다.
//        	setString(i, (String)obj);
//        } else {
//            pstmt.setObject(i, obj);
//        }
//
//    }
//
//    public boolean execute() throws SQLException
//    {
//        boolean flag1;
//        UseTime ut = new UseTime();
//
//        try
//        {
//            flag1 = pstmt.execute();
//        }
//        finally
//        {
//			long useTime = ut.getTime();
//        	if (Constants.DBWRAP_FLAG) {
//                DBTracer.logPrint("PSTMT.E", useTime, str, list, 0, "", className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//
//
//        }
//        return flag1;
//
//    }
//
//    public void addBatch() throws SQLException
//    {
//
//        pstmt.addBatch();
//    }
//
//    public void setCharacterStream(int i, Reader reader, int j) throws SQLException
//    {
//        a(i, reader);
//        pstmt.setCharacterStream(i, reader, j);
//    }
//
//    public void setRef(int i, Ref ref) throws SQLException
//    {
//        pstmt.setRef(i, ref);
//    }
//
//    public void setBlob(int i, Blob blob) throws SQLException
//    {
//        a(i, blob);
//        pstmt.setBlob(i, blob);
//    }
//
//    public void setClob(int i, Clob clob) throws SQLException
//    {
//        a(i, clob);
//        pstmt.setClob(i, clob);
//    }
//
//    public void setArray(int i, Array array) throws SQLException
//    {
//        a(i, array);
//        pstmt.setArray(i, array);
//    }
//
//    public ResultSetMetaData getMetaData() throws SQLException
//    {
//        return pstmt.getMetaData();
//    }
//
//    public void setDate(int i, Date date, Calendar calendar) throws SQLException
//    {
//        a(i, date);
//        pstmt.setDate(i, date, calendar);
//    }
//
//    public void setTime(int i, Time time, Calendar calendar) throws SQLException
//    {
//        a(i, time);
//        pstmt.setTime(i, time, calendar);
//    }
//
//    public void setTimestamp(int i, Timestamp timestamp, Calendar calendar) throws SQLException
//    {
//        a(i, timestamp);
//        pstmt.setTimestamp(i, timestamp, calendar);
//    }
//
//    public void setNull(int i, int j, String s) throws SQLException
//    {
//        a(i, null);
//        pstmt.setNull(i, j, s);
//    }
//
//    public ResultSet executeQuery(String s) throws SQLException
//    {
//        ResultSet resultset;
//        UseTime ut = new UseTime();
//        try
//        {
//            resultset = (ResultSet)new ResultSetImpl(pstmt.executeQuery(s));
//        }
//        finally
//        {
//        	long useTime = ut.getTime();
//        	if (Constants.DBWRAP_FLAG) {
//                DBTracer.logPrint("PSTMT.EQ", useTime, s, list, 0, "", className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//        }
//        return resultset;
//    }
//
//    public int executeUpdate(String s) throws SQLException
//    {
//        int i;
//        i = 0;
//        UseTime ut = new UseTime();
//        try
//        {
//            i = pstmt.executeUpdate(s);
//        }
//        catch(SQLException sqlexception)
//        {
//        	if (Constants.DBWRAP_FLAG) {
//        		DBTracer.logPrint("PSTMT.EU", 0, s, list, sqlexception.toString(), className);
//        	}
//            throw sqlexception;
//        }
//        finally
//        {
//        	long useTime = ut.getTime();
//        	if (Constants.DBWRAP_FLAG) {
//                DBTracer.logPrint("PSTMT.EU", useTime, s, null, i, "", className);
//                DBTracer.logPrint("PSTMT.EU", useTime, s, list, i, "", className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//        }
//        return i;
//    }
//
//    public void close() throws SQLException
//    {
//        try
//        {
//            pstmt.close();
//        }
//        catch(SQLException sqlexception)
//        {
//            throw sqlexception;
//        }
//    }
//
//    public int getMaxFieldSize() throws SQLException
//    {
//        return pstmt.getMaxFieldSize();
//    }
//
//    public void setMaxFieldSize(int i) throws SQLException
//    {
//        pstmt.setMaxFieldSize(i);
//    }
//
//    public int getMaxRows() throws SQLException
//    {
//        return pstmt.getMaxRows();
//    }
//
//    public void setMaxRows(int i) throws SQLException
//    {
//        pstmt.setMaxRows(i);
//    }
//
//    public void setEscapeProcessing(boolean flag) throws SQLException
//    {
//        pstmt.setEscapeProcessing(flag);
//    }
//
//    public int getQueryTimeout() throws SQLException
//    {
//        return pstmt.getQueryTimeout();
//    }
//
//    public void setQueryTimeout(int i) throws SQLException
//    {
//        pstmt.setQueryTimeout(i);
//    }
//
//    public void cancel() throws SQLException
//    {
//        pstmt.cancel();
//    }
//
//    public SQLWarning getWarnings() throws SQLException
//    {
//        return pstmt.getWarnings();
//    }
//
//    public void clearWarnings() throws SQLException
//    {
//        pstmt.clearWarnings();
//    }
//
//    public void setCursorName(String s) throws SQLException
//    {
//        pstmt.setCursorName(s);
//    }
//
//    public boolean execute(String s) throws SQLException
//    {
//        boolean flag1;
//        UseTime ut = new UseTime();
//        try
//        {
//            flag1 = pstmt.execute(s);
//        }
//        finally
//        {
//        	long useTime = ut.getTime();
//        	if (Constants.DBWRAP_FLAG) {
//                DBTracer.logPrint("PSTMT.E", useTime, s, null, 0, "", className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//        }
//        return flag1;
//
//    }
//
//    public ResultSet getResultSet() throws SQLException
//    {
//        return pstmt.getResultSet();
//    }
//
//    public int getUpdateCount() throws SQLException
//    {
//        return pstmt.getUpdateCount();
//    }
//
//    public boolean getMoreResults() throws SQLException
//    {
//        return pstmt.getMoreResults();
//    }
//
//    public void setFetchDirection(int i) throws SQLException
//    {
//        pstmt.setFetchDirection(i);
//    }
//
//    public int getFetchDirection() throws SQLException
//    {
//        return pstmt.getFetchDirection();
//    }
//
//    public void setFetchSize(int i) throws SQLException
//    {
//        pstmt.setFetchSize(i);
//    }
//
//    public int getFetchSize() throws SQLException
//    {
//        return pstmt.getFetchSize();
//    }
//
//    public int getResultSetConcurrency() throws SQLException
//    {
//        return pstmt.getResultSetConcurrency();
//    }
//
//    public int getResultSetType() throws SQLException
//    {
//        return pstmt.getResultSetType();
//    }
//
//    public void addBatch(String s) throws SQLException
//    {
//        //NDBTracer.logPrint("PSTMT.AB", 0, s, null);
//        pstmt.addBatch(s);
//    }
//
//    public void clearBatch() throws SQLException
//    {
//        pstmt.clearBatch();
//    }
//
//    public int[] executeBatch() throws SQLException
//    {
//        UseTime ut = new UseTime();
//        int ai[] = null;
//        String returnMessage = "";
//
//        try
//        {
//            ai = pstmt.executeBatch();
//		} catch (SQLException sqlexception) {
//
//			returnMessage = sqlexception.getMessage();
//	    	if (Constants.DBWRAP_FLAG) {
//	    		DBTracer.logPrint("PSTMT.EU", 0, str, list, sqlexception.toString(), className);
//	    	}
//			throw sqlexception;
//		}
//
//        finally
//        {
//        	long useTime = ut.getTime();
//        	int execRow = 0;
//        	for (int i=0; i<ai.length; i++) {
//        		if (ai[i]==-2) {				// 정상적으로 실행했으나 결과를 알수 없을때
//        			execRow++;
//        		} else {
//        			execRow += ai[i];
//        		}
//        	}
//
//        	if (Constants.DBWRAP_FLAG) {
//        		DBTracer.logPrint("PSTMT.EB", useTime, str, list, execRow, returnMessage, className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//        }
//        return ai;
//    }
//
//
//    public Connection getConnection() throws SQLException
//    {
//        try {
//            return (Connection)DBManager.getConnection();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    public ParameterMetaData getParameterMetaData() throws SQLException
//    {
//        return pstmt.getParameterMetaData();
//    }
//
//    public void setURL(int i, URL url) throws SQLException
//    {
//        pstmt.setURL(i, url);
//    }
//
//    public boolean execute(String s, int i) throws SQLException
//    {
//        boolean flag1;
//        UseTime ut = new UseTime();
//        try
//        {
//            flag1 = pstmt.execute(s, i);
//        }
//        finally
//        {
//        	long useTime = ut.getTime();
//        	if (Constants.DBWRAP_FLAG) {
//                DBTracer.logPrint("PSTMT.E", useTime, s, list, 0, "", className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//        }
//        return flag1;
//    }
//
//    public boolean execute(String s, int ai[]) throws SQLException
//    {
//        boolean flag1;
//        UseTime ut = new UseTime();
//        try
//        {
//            flag1 = pstmt.execute(s, ai);
//        }
//        finally
//        {
//        	long useTime = ut.getTime();
//        	if (Constants.DBWRAP_FLAG) {
//                DBTracer.logPrint("PSTMT.E", useTime, s, list, 0, "", className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//        }
//        return flag1;
//    }
//
//    public boolean execute(String s, String as[]) throws SQLException
//    {
//        boolean flag1;
//        UseTime ut = new UseTime();
//        try
//        {
//            flag1 = pstmt.execute(s, as);
//        }
//        finally
//        {
//        	long useTime = ut.getTime();
//        	if (Constants.DBWRAP_FLAG) {
//                DBTracer.logPrint("PSTMT.E", useTime, s, list, 0, "", className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//        }
//        return flag1;
//    }
//
//    public int executeUpdate(String s, int i) throws SQLException
//    {
//        int j;
//        j = 0;
//        UseTime ut = new UseTime();
//        try
//        {
//            j = pstmt.executeUpdate(s, i);
//        }
//        catch(SQLException sqlexception)
//        {
//        	if (Constants.DBWRAP_FLAG) {
//        		DBTracer.logPrint("PSTMT.EU", 0, s, list, sqlexception.toString(), className);
//        	}
//            throw sqlexception;
//        }
//        finally
//        {
//        	long useTime = ut.getTime();
//        	if (Constants.DBWRAP_FLAG) {
//                DBTracer.logPrint("PSTMT.EU", useTime, s, list, j, "", className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//        }
//        return j;
//    }
//
//    public int executeUpdate(String s, int ai[]) throws SQLException
//    {
//        int i;
//        i = 0;
//        UseTime ut = new UseTime();
//        try
//        {
//            i = pstmt.executeUpdate(s, ai);
//        }
//        catch(SQLException sqlexception)
//        {
//        	if (Constants.DBWRAP_FLAG) {
//        		DBTracer.logPrint("PSTMT.EU", 0, s, list, sqlexception.toString(), className);
//        	}
//            throw sqlexception;
//        }
//        finally
//        {
//        	long useTime = ut.getTime();
//        	if (Constants.DBWRAP_FLAG) {
//                DBTracer.logPrint("PSTMT.EU", useTime, s, list, i, "", className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//        }
//        return i;
//    }
//
//    public int executeUpdate(String s, String as[]) throws SQLException
//    {
//        int i;
//        i = 0;
//        UseTime ut = new UseTime();
//        try
//        {
//            i = pstmt.executeUpdate(s, as);
//        }
//        catch(SQLException sqlexception)
//        {
//        	if (Constants.DBWRAP_FLAG) {
//        		DBTracer.logPrint("PSTMT.EU", 0, s, list, sqlexception.toString(), className);
//        	}
//            throw sqlexception;
//        }
//        finally
//        {
//        	long useTime = ut.getTime();
//        	if (Constants.DBWRAP_FLAG) {
//                DBTracer.logPrint("PSTMT.EU", 0, s, list, i, "", className);
//        	}
//	    	if (Constants.TRACE_FLAG) {
//	    		DBTracer dbt = new DBTracer();
//	    		dbt.dbSave(str, useTime, className);
//	    	}
//        }
//        return i;
//    }
//
//    public ResultSet getGeneratedKeys() throws SQLException
//    {
//        return pstmt.getGeneratedKeys();
//    }
//
//    public boolean getMoreResults(int i) throws SQLException
//    {
//        return pstmt.getMoreResults(i);
//    }
//
//    public int getResultSetHoldability() throws SQLException
//    {
//        return pstmt.getResultSetHoldability();
//    }
//
//    public String getQueryPagingCount(DataMap paramData)
//    {
//    	String query = "";
//
//    	query += "SELECT COUNT(*) N_COUNT FROM (\n";
//    	query += str;
//    	query += ")";
//
//    	return query;
//    }
//
//    public String getQueryPagingCountBig(DataMap paramData)
//    {
//
//    	String query = "";
//
//    	query += "SELECT COUNT(*) N_COUNT FROM (\n";
//    	query += "	SELECT * FROM (\n";
//    	query += str;
//    	query += "	) WHERE ROWNUM <= ? \n";
//    	query += ")";
//
//    	return query;
//    }
//
//
//    public String getQueryPagingRow (DataMap paramData)
//    {
//    	String query = "";
//
//    	query += "SELECT * FROM ( SELECT ROWNUM nPaging_rnum, nQuery.* FROM (\n";
//    	query += str;
//    	query += ") nQuery WHERE ROWNUM <= ?) WHERE nPaging_rnum >= ?";	// 새로운 페이징으로 바꿈 2005.09.26 해영
//    	//query += ") nQuery ) WHERE nPaging_rnum BETWEEN ? AND ?";		// 기존의 페이징 쿼리
//    	return query;
//    }
//
//    //2007/11/15 asc,desc를 위한 query 추가
//    public String getQueryPagingRowSort (DataMap paramData,String sortName,String sortFlag)
//    {
//    	String query = "";
//    	query += "SELECT * FROM ( SELECT ROWNUM nPaging_rnum, nQuery.* FROM (\n";
//    	query += str;
//    	query += ") nQuery WHERE ROWNUM <= ?) WHERE nPaging_rnum >= ? \n";	// 새로운 페이징으로 바꿈 2005.09.26 해영
//    	//query += ") nQuery ) WHERE nPaging_rnum BETWEEN ? AND ?";		// 기존의 페이징 쿼리
//    	query += "ORDER BY"+" "+ sortName +" "+ sortFlag;
//    	return query;
//    }
//
//    public ArrayList getParameter()
//    {
//    	return (ArrayList)list.clone();
//    }
//    
//    
//    
//    
//    
//    /** JDK 1.6 버젼에서 로 오버라이딩 되어야할 메소드 START  */
//    /**  *1.6 이하 버젼에서는 주석처리 하여야함.  */
//    /*
//    
//    
//    
//    public void setNClob(int parameterIndex, Reader value) throws SQLException{
//	    a(parameterIndex, value);
//	    pstmt.setNClob(parameterIndex, value);
//	}
//    public void setNClob(int parameterIndex, Reader value, long length) throws SQLException{
//	    a(parameterIndex, value);
//	    pstmt.setNClob(parameterIndex, value, length);
//	}
//    public void setNClob(int parameterIndex, NClob value) throws SQLException{
//	    a(parameterIndex, value);
//	    pstmt.setNClob(parameterIndex, value);
//	}
//    public void setBlob(int parameterIndex, InputStream inputStream) throws SQLException{
//	    a(parameterIndex, inputStream);
//	    pstmt.setBlob(parameterIndex, inputStream);
//	}
//    public void setBlob(int parameterIndex, InputStream inputStream, long length) throws SQLException{
//	    a(parameterIndex, inputStream);
//	    pstmt.setBlob(parameterIndex, inputStream, length);
//	}
//    public void setClob(int i, Reader reader, long length) throws SQLException{
//        a(i, reader);
//        pstmt.setClob(i, reader, length);
//    }
//    public void setClob(int i, Reader reader) throws SQLException{
//        a(i, reader);
//        pstmt.setClob(i, reader);
//    }
//    public void setRowId(int parameterIndex, RowId x) throws SQLException{
//    	a(parameterIndex, x);
//	    pstmt.setRowId(parameterIndex, x);
//	}
//    public void setCharacterStream(int i, Reader reader) throws SQLException{
//        a(i, reader);
//        pstmt.setCharacterStream(i, reader);
//    }
//    public void setCharacterStream(int i, Reader reader, long j) throws SQLException{
//        a(i, reader);
//        pstmt.setCharacterStream(i, reader, j);
//    }
//    public void setBinaryStream(int i, InputStream inputstream) throws SQLException{
//        a(i, inputstream);
//        pstmt.setBinaryStream(i, inputstream);
//    }
//    public void setBinaryStream(int i, InputStream inputstream, long j) throws SQLException
//    {
//        a(i, "InputStream(" + j + ")");
//        pstmt.setBinaryStream(i, inputstream, j);
//    }
//    public void setNString(int parameterIndex, String value) throws SQLException{
//        a(parameterIndex, value);
//        pstmt.setNString(parameterIndex, value);
//    }
//    public void setSQLXML(int parameterIndex, SQLXML xmlObject) throws SQLException{
//        a(parameterIndex, xmlObject);
//        pstmt.setSQLXML(parameterIndex, xmlObject);
//    }
//
//
//
//    public void setPoolable(boolean poolable) throws SQLException{
//	    pstmt.setPoolable(poolable);
//	}
//    
//    public boolean isPoolable() throws SQLException{
//	    return pstmt.isPoolable();
//	}
//    public boolean isClosed() throws SQLException{
//	    return pstmt.isClosed();
//	}
//    public void setNCharacterStream(int parameterIndex, Reader value) throws SQLException{
//	    a(parameterIndex, value);
//	    pstmt.setNCharacterStream(parameterIndex, value);
//	}
//    public void setNCharacterStream(int parameterIndex, Reader value, long length) throws SQLException{
//	    a(parameterIndex, value);
//	    pstmt.setNCharacterStream(parameterIndex, value, length);
//	}
//
//    
//    public void setAsciiStream(int i, java.io.InputStream inputstream, long length) throws SQLException {
//        a(i, inputstream + "(" + length + ")");
//        pstmt.setAsciiStream(i, inputstream, length);
//    }
//    
//    public void setAsciiStream(int i, java.io.InputStream inputstream) throws SQLException {
//        a(i, inputstream);
//        pstmt.setAsciiStream(i, inputstream);
//    }
//
//
//    public <T> T unwrap(java.lang.Class<T> iface)throws java.sql.SQLException{
//    	return pstmt.unwrap(iface);
//    }
//    public boolean isWrapperFor(java.lang.Class<?> iface)throws java.sql.SQLException{
//    	return pstmt.isWrapperFor(iface);
//    }
//    */
//    /** JDK 1.6 버젼에서 로 오버라이딩 되어야할 메소드 END  */
//}
