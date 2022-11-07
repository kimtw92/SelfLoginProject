//package ut.lib.db;
//
//import java.sql.CallableStatement;
//import java.sql.Connection;
//import java.sql.DatabaseMetaData;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//import java.sql.SQLWarning;
//import java.sql.Savepoint;
//import java.util.Map;
//
//import javax.naming.Context;
//import javax.naming.InitialContext;
//import javax.naming.NamingException;
//import javax.sql.DataSource;
//
//import ut.lib.log.Log;
//
//
///**
// * @author Administrator
// *
// * TODO To change the template for this generated type comment go to
// * Window - Preferences - Java - Code Style - Code Templates
// */
//public abstract class DBManager implements Connection {
//    private static Connection con;
//
//
//    public DBManager(Connection connection) throws SQLException
//    {
//    	con = null;
//        if(connection == null)
//        {
//            throw new SQLException("conneciton is null.");
//        } else
//        {
//        	con = connection;
//            return;
//        }
//    }
//    
//    // 2008-04-25 강주영 추가
//    public static Connection getConnection() throws SQLException{
//    	return getConnection("inchlms");
//    }
//
//    // 2008-04-25 강주영 내용수정
//    public static Connection getConnection(String sid) throws SQLException {
//        
//    	Connection connection = null;
//                   
//        String psid = sid;
//        
//        /*
//        String psid = "";
//        if(ut.lib.util.Util.getValue(sid).equals("")){
//        	psid = "inchlms";
//        }else{
//        	psid = sid;
//        }                
//        */
//        
//  //      System.out.println("psid="+psid);
//
//        try {
//        	
//        	/** weblogic */
//        	/*
//            Context ctx = new InitialContext();
//            DataSource datasource = (DataSource)ctx.lookup(psid);
//            con = datasource.getConnection();
// */
//
//            /** tomcat */
//        	
//            //System.out.println("연결시작 ~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//			Context initCtx = new InitialContext();
//			//System.out.println("연결시작1 ~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//			//System.out.println(initCtx);
//			Context envCtx = (Context) initCtx.lookup("java:comp/env");
//			//System.out.println("연결시작2 ~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//			//System.out.println(envCtx);
//			DataSource ds = (DataSource) envCtx.lookup("jdbc/loti");
//			//System.out.println("연결시작3 ~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//			//System.out.println(ds);
//			connection = ds.getConnection();
//			//System.out.println(connection);
//			//System.out.println("연결완료 ~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//			
//            if (connection == null) {
//            	Log.error(DBManager.class, "[Exception in " + DBManager.class.getName() + "]" + "DB Connection Fail!");
//                throw new SQLException("COMMON.MSG05");
//            }
//        } catch (SQLException e) {
//        	throw new SQLException("COMMON.MSG05");
//        } catch (NamingException e) {
//        	throw new SQLException("COMMON.MSG05");
//        }
//        return connection;
//    }
//    
//    
//
//    public static void closeConnection(Connection conn) throws SQLException {
//    	conn.close();
//    }
//
//    public PreparedStatement prepareStatement(String s)
//    throws SQLException
//    {
//        return new PreparedStatementImpl(con.prepareStatement(s), s);
//    }
//
//    public CallableStatement prepareCall(String s)
//    throws SQLException
//    {
//        return con.prepareCall(s);
//    }
//
//    public String nativeSQL(String s)
//    throws SQLException
//    {
//        return con.nativeSQL(s);
//    }
//
//    public void setAutoCommit(boolean flag)
//    throws SQLException
//    {
//    	con.setAutoCommit(flag);
//    }
//
//    public boolean getAutoCommit()
//    throws SQLException
//    {
//        return con.getAutoCommit();
//    }
//
//    public void commit()
//    throws SQLException
//    {
//    	con.commit();
//    }
//
//    public void rollback()
//    throws SQLException
//    {
//    	con.rollback();
//    }
//
//    public void close()
//    throws SQLException
//    {
//    	con.close();
//    }
//
//    public boolean isClosed()
//    throws SQLException
//    {
//        return con.isClosed();
//    }
//
//    public DatabaseMetaData getMetaData()
//    throws SQLException
//    {
//        return con.getMetaData();
//    }
//
//    public void setReadOnly(boolean flag)
//    throws SQLException
//    {
//    	con.setReadOnly(flag);
//    }
//
//    public boolean isReadOnly()
//    throws SQLException
//    {
//        return con.isReadOnly();
//    }
//
//    public void setCatalog(String s)
//    throws SQLException
//    {
//    	con.setCatalog(s);
//    }
//
//    public String getCatalog()
//    throws SQLException
//    {
//        return con.getCatalog();
//    }
//
//    public void setTransactionIsolation(int i)
//    throws SQLException
//    {
//    	con.setTransactionIsolation(i);
//    }
//
//    public int getTransactionIsolation()
//    throws SQLException
//    {
//        return con.getTransactionIsolation();
//    }
//
//    public SQLWarning getWarnings()
//    throws SQLException
//    {
//        return con.getWarnings();
//    }
//
//    public void clearWarnings()
//    throws SQLException
//    {
//    	con.clearWarnings();
//    }
//
//
//    public PreparedStatement prepareStatement(String s, int i)
//    throws SQLException
//    {
//        PreparedStatement preparedstatement = con.prepareStatement(s, i);
//        return new PreparedStatementImpl(preparedstatement, s);
//    }
//
//    public PreparedStatement prepareStatement(String s, int ai[])
//    throws SQLException
//    {
//        PreparedStatement preparedstatement = con.prepareStatement(s, ai);
//        return new PreparedStatementImpl(preparedstatement, s);
//    }
//
//    public PreparedStatement prepareStatement(String s, String as[])
//    throws SQLException
//    {
//        PreparedStatement preparedstatement = con.prepareStatement(s, as);
//        return new PreparedStatementImpl(preparedstatement, s);
//    }
//
//    public PreparedStatement prepareStatement(String s, int i, int j)
//    throws SQLException
//    {
//        PreparedStatement preparedstatement = con.prepareStatement(s, i, j);
//        return new PreparedStatementImpl(preparedstatement, s);
//    }
//
//    public PreparedStatement prepareStatement(String s, int i, int j, int k)
//    throws SQLException
//    {
//        PreparedStatement preparedstatement = con.prepareStatement(s, i, j, k);
//        return new PreparedStatementImpl(preparedstatement, s);
//    }
//
//    public CallableStatement prepareCall(String s, int i, int j)
//    throws SQLException
//    {
//        return con.prepareCall(s, i, j);
//    }
//
//    public CallableStatement prepareCall(String s, int i, int j, int k)
//    throws SQLException
//    {
//        return con.prepareCall(s, i, j, k);
//    }
//
//    public Map getTypeMap()
//    throws SQLException
//    {
//        return con.getTypeMap();
//    }
//
//    public void setTypeMap(Map map)
//    throws SQLException
//    {
//    	con.setTypeMap(map);
//    }
//
//    public int getHoldability()
//    throws SQLException
//    {
//        return con.getHoldability();
//    }
//
//    public void releaseSavepoint(Savepoint savepoint)
//    throws SQLException
//    {
//    	con.releaseSavepoint(savepoint);
//    }
//
//    public void rollback(Savepoint savepoint)
//    throws SQLException
//    {
//    	con.rollback(savepoint);
//    }
//
//    public void setHoldability(int i)
//    throws SQLException
//    {
//    	con.setHoldability(i);
//    }
//
//    public Savepoint setSavepoint()
//    throws SQLException
//    {
//        return con.setSavepoint();
//    }
//
//    public Savepoint setSavepoint(String s)
//    throws SQLException
//    {
//        return con.setSavepoint(s);
//    }
//
//
//}
