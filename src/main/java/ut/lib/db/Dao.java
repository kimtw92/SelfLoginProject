//package ut.lib.db;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.CallableStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.ArrayList;
//
//
//import ut.lib.log.Log;
//import ut.lib.page.PageFactory;
//import ut.lib.page.PageInfo;
//import ut.lib.page.PageNavigation;
//import ut.lib.support.DataMap;
//import ut.lib.util.Constants;
//
///**
// * <B>NDao</B><br>
// * - 최상위 DAO<br>
// * - Database와 연동에 필요한 공통 메서드를 포함한다.
// * @author  miru
// * @version 2005. 6. 16.
// */
//
//public class Dao {
//    private Connection con;
//
//    private int start;
//    private int end;
//
//    /**
//     * Constructor
//     * @param Connection
//     */
//    protected Dao(Connection connection)
//    {
//        setConnection(connection);
//    }
//
//    /**
//     * Constructor
//     * @param
//     */
//    protected Dao()
//    {
//    }
//
//
//    /**
//     * Set Connection object.
//     * @param Connection
//     */
//    protected void setConnection(Connection connection)
//    {
//        con = connection;
//    }
//
//    /**
//     * Get Connection instance.
//     * @return Connection instance
//     */
//    protected Connection getConnection()
//    {
//        return con;
//    }
//
//    /**
//     * Close preparedStatement
//     * @param PreparedStatement object
//     */
//    protected void close(PreparedStatement preparedstatement)
//    {
//        if(preparedstatement != null)
//            try
//            {
//                preparedstatement.close();
//            }
//            catch(SQLException sqlexception)
//            {
//                Log.info(this.getClass(), sqlexception.getMessage());
//            }
//    }
//
//    /**
//     * Close statement
//     * @param Statement object
//     */
//    protected void close(Statement statement)
//    {
//        if(statement != null)
//            try
//            {
//                statement.close();
//            }
//            catch(SQLException sqlexception)
//            {
//            	Log.info(this.getClass(), sqlexception.getMessage());
//            }
//    }
//
//    /**
//     * Close CallableStatement
//     * @param CallableStatement object
//     */
//    protected void close(CallableStatement callableStatement)
//    {
//        if(callableStatement != null)
//            try
//            {
//            	callableStatement.close();
//            }
//            catch(SQLException sqlexception)
//            {
//            	Log.info(this.getClass(), sqlexception.getMessage());
//            }
//    }
//
//    /**
//     * Close ResultSet
//     * @param ResultSet object
//     */
//    protected void close(ResultSet resultset)
//    {
//        if(resultset != null)
//            try
//            {
//                resultset.close();
//            }
//            catch(SQLException sqlexception)
//            {
//            	Log.info(this.getClass(), sqlexception.getMessage());
//            }
//    }
//
//    /**
//     * Close PreparedStatement, ResultSet
//     * @param PreparedStatement object
//     * @param ResultSet object
//     */
//    protected void close(PreparedStatement preparedstatement, ResultSet resultset)
//    {
//        close(preparedstatement);
//        close(resultset);
//    }
//
//
//
//    /**
//     * Close Statement, ResultSet
//     * @param Statement object
//     * @param ResultSet object
//     */
//    protected void close(Statement statement, ResultSet resultset)
//    {
//        close(resultset);
//        close(statement);
//    }
//
//    /**
//     * Create PreparedStatement
//     * @param query
//     * @return PreparedStatement instance
//     */
//    protected PreparedStatement createPreparedStatement(String query)
//    throws SQLException
//	{
//    		return new PreparedStatementImpl(con.prepareStatement(query), query, this.getClass());
//	}
//
//
//
//    /**
//     * Create CallableStatement
//     * @param query
//     * @return PreparedStatement instance
//     */
//    protected CallableStatement createCallableStatement(String query)
//    throws SQLException
//	{
//    		return con.prepareCall(query);
//	}
//
//
//
//    /**
//     * 페이징 관련 계산을 수행후 Page navigation 객체를 리턴함.
//     * @param PreparedStatement
//     * @param 파라미터 데이터
//     * @return PageNavigation
//     */
//    public PageNavigation getPagingInfo(PreparedStatement pstmt, DataMap pagingInfoMap) throws SQLException
//    {
//        PageNavigation pageNavi = null;
//    	String query = ((PreparedStatementImpl)pstmt).getQueryPagingCount(pagingInfoMap);
//    	PreparedStatement npstmt = createPreparedStatement(query);
//
//        ArrayList arrParam = ((PreparedStatementImpl)pstmt).getParameter();
//        for(int i=0; i < arrParam.size(); i++) {
//        	((PreparedStatementImpl)npstmt).setObject((i+1), arrParam.get(i));
//        }
//
//		ResultSet rs = null;
//		try {
//			rs = npstmt.executeQuery();
//
//			int totalCnt = 0;
//
//			while (rs.next()) {
//				totalCnt = rs.getInt("N_COUNT");
//			}
//			pagingInfoMap.setNullToInitialize(true);
//
//			int currPage = 1;
//
//			if (pagingInfoMap.containsKey("currPage")) {
//			    if (pagingInfoMap.getString("currPage").equals("") || pagingInfoMap.getString("currPage").equals("0")) {
//			        currPage = 1;
//			        pagingInfoMap.setInt("currPage", currPage);
//			    } else {
//			        currPage = pagingInfoMap.getInt("currPage");
//			    }
//			}
//
//			start = (currPage-1)*pagingInfoMap.getInt("rowSize") + 1;
//			end = currPage*pagingInfoMap.getInt("rowSize");
//
//	    	PageInfo pageInfo = new PageInfo(totalCnt, pagingInfoMap.getInt("rowSize"), pagingInfoMap.getInt("pageSize"), currPage);
//
//	    	pageNavi = PageFactory.getInstance(Constants.DEFAULT_PAGE_CLASS, pageInfo);
//
//		} finally {
//			close(npstmt, rs);
//		}
//    	return pageNavi;
//
//    }
//
//
//
//    /**
//     * 페이징 관련 계산을 수행후 Page navigation 객체를 리턴함. (대용량 처리용)
//     * @param PreparedStatement
//     * @param 파라미터 데이터
//     * @return PageNavigation
//     */
//    public PageNavigation getPagingInfoBig(PreparedStatement pstmt, DataMap paramData) throws SQLException
//    {
//
//		paramData.setNullToInitialize(true);
//
//		int currPage = 1;
//		if (paramData.containsKey("currPage")) {
//		    if (paramData.getString("currPage").equals("") || paramData.getString("currPage").equals("0")) {
//		        currPage = 1;
//		        paramData.setInt("currPage", currPage);
//		    } else {
//		        currPage = paramData.getInt("currPage");
//		    }
//		}
//
//
//        PageNavigation pageNavi = null;
//    	String query = ((PreparedStatementImpl)pstmt).getQueryPagingCountBig(paramData);
//    	PreparedStatement npstmt = createPreparedStatement(query);
//        ArrayList arrParam = ((PreparedStatementImpl)pstmt).getParameter();
//        for(int i=0; i < arrParam.size(); i++) {
//        	((PreparedStatementImpl)npstmt).setObject((i+1), arrParam.get(i));
//        }
//    	int idx = ((PreparedStatementImpl)npstmt).length();
//
//
//    	int firstPageOfRow = ((paramData.getInt("currPage")-1)/paramData.getInt("pageSize"))*paramData.getInt("pageSize") + 1;
//    	int getRows = (firstPageOfRow + paramData.getInt("pageSize")- 1) * paramData.getInt("rowSize") + 1;
//
//    	npstmt.setInt(++idx, getRows);
//
//
//
//
//
//		ResultSet rs = null;
//		try {
//			rs = npstmt.executeQuery();
//
//			int totalCnt = 0;
//
//			while (rs.next()) {
//				totalCnt = rs.getInt("N_COUNT");
//			}
//
//
//			start = (currPage-1)*paramData.getInt("rowSize") + 1;
//			end = currPage*paramData.getInt("rowSize");
//
//	    	PageInfo pageInfo = new PageInfo(totalCnt, paramData.getInt("rowSize"), paramData.getInt("pageSize"), currPage);
//
//	    	pageNavi = PageFactory.getInstance(paramData.getString("pageClass"), pageInfo);
//
//		} finally {
//			close(npstmt, rs);
//		}
//    	return pageNavi;
//
//    }
//
//
//    /**
//     * Query를 가공하여 PreparedStatement instance를 리턴함.
//     * @param PreparedStatement
//     * @param 파라미터 데이터
//     * @return PreparedStatement instance
//     */
//    public PreparedStatement convertToPagingPreparedStatement(PreparedStatement pstmt, DataMap paramData) throws SQLException
//    {
//    	String query = ((PreparedStatementImpl)pstmt).getQueryPagingRow(paramData);
//    	PreparedStatement npstmt = createPreparedStatement(query);
//
//        ArrayList arrParam = ((PreparedStatementImpl)pstmt).getParameter();
//        for(int i=0; i < arrParam.size(); i++) {
//        	((PreparedStatementImpl)npstmt).setObject((i+1), arrParam.get(i));
//        }
//
//    	int idx = ((PreparedStatementImpl)npstmt).length();
//
//    	npstmt.setInt(++idx, end);
//    	npstmt.setInt(++idx, start);
//
//
//    	close(pstmt);
//
//    	return npstmt;
//
//    }
//
//    /**
//     * 2007/11/15 admin->상품관리 페이지에 asc,desc 정렬을 위한 Query 추가
//     * Query를 가공하여 PreparedStatement instance를 리턴함.
//     * @param PreparedStatement
//     * @param 파라미터 데이터
//     * @return PreparedStatement instance
//     */
//    public PreparedStatement convertToPagingPreparedStatementSort(PreparedStatement pstmt, DataMap paramData,String sortName,String sortFlag) throws SQLException
//    {
//    	String query = ((PreparedStatementImpl)pstmt).getQueryPagingRowSort(paramData,sortName,sortFlag);
//    	PreparedStatement npstmt = createPreparedStatement(query);
//
//        ArrayList arrParam = ((PreparedStatementImpl)pstmt).getParameter();
//        for(int i=0; i < arrParam.size(); i++) {
//        	((PreparedStatementImpl)npstmt).setObject((i+1), arrParam.get(i));
//        }
//
//    	int idx = ((PreparedStatementImpl)npstmt).length();
//
//    	npstmt.setInt(++idx, end);
//    	npstmt.setInt(++idx, start);
//
//
//    	close(pstmt);
//
//    	return npstmt;
//
//    }
//
//
//}
