//package ut.lib.db;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//import java.util.Map;
//import java.util.StringTokenizer;
//
//import ut.lib.exception.BizException;
//import ut.lib.log.Log;
//
///**
// * @author Administrator
// *
// * TODO To change the template for this generated type comment go to
// * Window - Preferences - Java - Code Style - Code Templates
// */
//public class DBTracer {
//
//	    DBTracer()
//	    {
//	    }
//
//	    static void a(String s, long l)
//	    {
//	        Log.dbwrap(DBTracer.class, _mthif(s + ' ' + ("Laptime : " + l) + ' ' + l + ' ' + "Result : batch job success."));
//	    }
//
//	    static void a(String s, long l, String s1)
//	    {
//	    	Log.dbwrap(DBTracer.class, _mthif(s + ' ' + ("Laptime : " + l) + ' ' + l + ' ' + ("Result : batch job fail : " + s1)));
//	    }
//
//	    static void a(String s, String s1, ArrayList arraylist)
//	    {
//	        String s2;
//	        if(s1 != null)
//	        {
//	            if(!a(((List) (arraylist))))
//	                s2 = a(s1, arraylist.toArray(new Object[arraylist.size()]));
//	            else
//	                s2 = s1;
//	        } else
//	        {
//	            s2 = "NOSQL";
//	        }
//	        Log.dbwrap(DBTracer.class, _mthif(s + "\n" + s2));
//	    }
//
//	    static void a(String s, String s1, ArrayList arraylist, String s2)
//	    {
//	        String s3;
//	        if(s1 != null)
//	        {
//	            if(!a(((List) (arraylist))))
//	                s3 = a(s1, arraylist.toArray(new Object[arraylist.size()]));
//	            else
//	                s3 = s1;
//	        } else
//	        {
//	            s3 = "NOSQL";
//	        }
//	        StringBuffer stringbuffer = (new StringBuffer()).append(s).append("\n").append(s3).append("\n");
//	        stringbuffer.append("Result : add batch job fail : " + s2);
//	        Log.dbwrap(DBTracer.class, _mthif(stringbuffer.toString()));
//	    }
//
//	    static void logPrint(String s, long l, String s1, ArrayList arraylist, int i, String returnMsg, Class className)
//	    {
//	        String s2;
//	        if(s1 != null)
//	        {
//	            if(!a(((List) (arraylist))))
//	                s2 = a(s1, arraylist.toArray(new Object[arraylist.size()]));
//	            else
//	                s2 = s1;
//	        } else
//	        {
//	            s2 = "NOSQL";
//	        }
//	        StringBuffer stringbuffer = new StringBuffer();
//	        stringbuffer.append(s).append(" Laptime : " + l).append("\n");
//	        stringbuffer.append("-------------------------------------------------\n");
//	        stringbuffer.append(s2 + "\n");
//	        stringbuffer.append("-------------------------------------------------\n");
//
//	        if (returnMsg.equals("")) {
//		        if(s2.trim().toLowerCase().startsWith("insert"))
//		            stringbuffer.append("Result : " + i + " row(s) inserted.");
//		        else
//		        if(s2.trim().toLowerCase().startsWith("delete"))
//		            stringbuffer.append("Result : " + i + " row(s) deleted.");
//		        else
//		        if(s2.trim().toLowerCase().startsWith("update"))
//		            stringbuffer.append("Result : " + i + " row(s) updated.");
//		        else
//		        if(s2.trim().toLowerCase().startsWith("select"))
//		            stringbuffer.append("Result : select completed.");
//	        } else {
//	        	stringbuffer.append(returnMsg);
//
//	        }
//	        if (className==null) {
//	        	Log.dbwrap(DBTracer.class, _mthif(stringbuffer.toString()));
//	        } else {
//	        	Log.dbwrap(className, _mthif(stringbuffer.toString()));
//	        }
//	    }
//
//	    static void logPrint(String s, long l, String s1, ArrayList arraylist, String s2, Class className)
//	    {
//	        String s3;
//	        if(s1 != null)
//	        {
//	            if(!a(((List) (arraylist))))
//	                s3 = a(s1, arraylist.toArray(new Object[arraylist.size()]));
//	            else
//	                s3 = s1;
//	        } else
//	        {
//	            s3 = "NOSQL";
//	        }
//	        StringBuffer stringbuffer = new StringBuffer();
//	        stringbuffer.append(s).append(" Laptime : " + l).append("\n");
//	        stringbuffer.append("-------------------------------------------------\n");
//	        stringbuffer.append(s3 + "\n");
//	        stringbuffer.append("-------------------------------------------------\n");
//
//	        if(s3.trim().toLowerCase().startsWith("insert"))
//	            stringbuffer.append("Result : insert fail.:" + s2);
//	        else
//	        if(s3.trim().toLowerCase().startsWith("delete"))
//	            stringbuffer.append("Result : delete fail.:" + s2);
//	        else
//	        if(s3.trim().toLowerCase().startsWith("update"))
//	            stringbuffer.append("Result : update fail.:" + s2);
//	        else
//	        if(s3.trim().toLowerCase().startsWith("select"))
//	            stringbuffer.append("Result : select fail.:" + s2);
//	        if (className==null) {
//	        	Log.dbwrap(className, _mthif(stringbuffer.toString()));
//	        } else {
//	        	Log.dbwrap(DBTracer.class, _mthif(stringbuffer.toString()));
//	        }
//	    }
//
//	    static boolean a(Object obj)
//	    {
//	        return obj == null;
//	    }
//
//	    static boolean a(String s)
//	    {
//	        return s == null || s.length() == 0;
//	    }
//
//	    static boolean a(Number number)
//	    {
//	        return number == null || number.doubleValue() == 0.0D;
//	    }
//
//	    static boolean a(List list)
//	    {
//	        return list == null || list.size() == 0;
//	    }
//
//	    static boolean a(Object aobj[])
//	    {
//	        return aobj == null || aobj.length == 0;
//	    }
//
//	    static boolean a(Map map)
//	    {
//	        return map == null || map.size() == 0;
//	    }
//
//	    static String a(String s, Object aobj[])
//	    {
//	        if(s == null || aobj == null)
//	            return s;
//	        StringBuffer stringbuffer = new StringBuffer();
//	        StringTokenizer stringtokenizer = new StringTokenizer(s, "?");
//	        if(stringtokenizer.hasMoreTokens())
//	            stringbuffer.append(stringtokenizer.nextToken());
//	        int i = 0;
//	        for(; stringtokenizer.hasMoreTokens(); stringbuffer.append(stringtokenizer.nextToken()))
//	            if(i < aobj.length)
//	            {
//	                if((aobj[i] instanceof String) || (aobj[i] instanceof Date))
//	                    stringbuffer.append("'" + aobj[i] + "'");
//	                else
//	                    stringbuffer.append(aobj[i]);
//	                i++;
//	            } else
//	            {
//	                stringbuffer.append('?');
//	            }
//
//	        for(; i < aobj.length; i++)
//	            if((aobj[i] instanceof String) || (aobj[i] instanceof Date))
//	                stringbuffer.append("'" + aobj[i] + "'");
//	            else
//	                stringbuffer.append(aobj[i]);
//
//	        return stringbuffer.toString();
//	    }
//
//	    static String a(String s, Object obj)
//	    {
//	        if(s == null)
//	            return null;
//	        char ac[] = s.toCharArray();
//	        ArrayList arraylist = new ArrayList();
//	        for(int i = 0; i < ac.length; i++)
//	            if('?' == ac[i])
//	                arraylist.add(obj);
//
//	        return a(s, arraylist.toArray());
//	    }
//
//	    static int _mthdo(String s)
//	    {
//	        if(s == null)
//	            return 0;
//	        char ac[] = s.toCharArray();
//	        int i = 0;
//	        for(int j = 0; j < ac.length; j++)
//	            if('?' == ac[j])
//	                i++;
//
//	        return i;
//	    }
//
//	    static String _mthif(String s)
//	    {
//	        String s1 = "";//LTxTrace.getTxID().trim();
//	        StringBuffer stringbuffer = new StringBuffer();
//	        for(StringTokenizer stringtokenizer = new StringTokenizer(s, "\n"); stringtokenizer.hasMoreTokens(); stringbuffer.append("\r\n" + s1 + " " + stringtokenizer.nextToken()));
//	        return stringbuffer.toString();
//	    }
//
//
//	    /**
//	     * DB에 해당 쿼리의 수행결과를 저장한다.
//	     * @param String saveQuery 쿼리
//	     * 		  int runTime 수행 시간
//	     * @throws Exception
//	     */
//		public void dbSave(String saveQuery, long runTime, Class className) {
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			try {
//
//	            con = DBManager.getConnection();
//	            con.setAutoCommit(false);
//
//
//			    //String query = XmlQueryParser.getInstance().getSql("AdminBoardBigSample.xml", "list");
//				String query = "INSERT INTO HFW_DBTRACE (SEQ, CLASS, USE_TIME, QUERY) VALUES (HFW_DBTRACE_S.NEXTVAL, ?, ?, ?)";
//				pstmt = con.prepareStatement(query);
//				pstmt.setString(1, className.toString());
//				pstmt.setLong(2, runTime);
//                pstmt.setString(3, saveQuery);
//
//
//				pstmt.executeUpdate();
//
//				con.commit();
//	            con.setAutoCommit(true);
//
//	        } catch (SQLException e) {
//	        	try {
//					con.rollback();
//				} catch (SQLException e1) {
//					// TODO Auto-generated catch block
//					e1.printStackTrace();
//				}
//	        } finally {
//	            if (pstmt != null) {
//	                try {
//	                	pstmt.close();
//	                } catch (SQLException e1) {
//	                    e1.printStackTrace();
//	                }
//	            }
//
//	            if (con != null) {
//	                try {
//	                    con.close();
//	                } catch (SQLException e1) {
//	                    e1.printStackTrace();
//	                }
//	            }
//	        }
//		}
//}
