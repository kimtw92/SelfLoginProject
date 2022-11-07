/*------------------------------------------------------------------------------
 * 수정일      요청자     수정자       수정사유
 *------------------------------------------------------------------------------
 *20031127    삼성투신    강경호      소스정리
 *------------------------------------------------------------------------------
 *
 * Copyright 2003 Neomoney Co., Ltd. All rights reserved.
 */

package ut.lib.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


//import com.caucho.sql.DBPool;

/*
 * Encrypter.java
 *
 * Created on 2002-08-06
 */

public class Encrypter {

	public Encrypter() {
	}

	/**
	 *
	 * 2003-11-27 Administrator
	 * @param MEMBER_FLAG
	 * @param P_NO1
	 * @param P_NO2
	 * @return
	 * @throws NamingException
	 */
//	public static long PNOEncrypt(int MEMBER_FLAG, String P_NO1, String P_NO2)
//		throws NamingException {
//
//		long result;
//		DataSource ds = null;
//		Connection conn = null;
//		Statement stmt = null;
//		ResultSet rs = null;
//
//		System.out.println("PNOEncrypt: P_NO11=" + P_NO1 + ",P_NO2=" + P_NO2);
//		String query = null;
//		result = 0;
//
//		String P_NO = P_NO1 + P_NO2;
//		int P2_Key = P_NO.hashCode();
//		System.out.println("PNOEncrypt: P2_Key=" + P2_Key);
//		String TableName = "";
//		try {
//
//			/*switch (MEMBER_FLAG) {
//				case 0 :
//					TableName = "member_table0";
//					break;
//				case 1 :
//				case 3 :
//				case 5 :
//				case 6 :
//					TableName = "member_table1";
//					break;
//				case 2 :
//				case 4 :
//					TableName = "member_table2";
//					break;
//			}*/
//
//			TableName = "member_t";
//
//			System.out.println("PNOEncrypt: DBConnector");
//
//			System.out.println("PNOEncrypt: initialcontext");
//
//		//	ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
//
//			System.out.println("ic.lookup");
//
//		/*	DBPool dp = DBPool.getPool("java:comp/env/jdbc/ora816");
//			System.out.println("DBPool lookup1");
//
//			int con_count = dp.getMaxConnections();
//			System.out.println("con_count" + con_count);
//
//			int total_con_count = dp.getTotalConnections();
//			System.out.println("to_count=" + total_con_count);
//
//			con_count = dp.getActiveConnections();
//			System.out.println("con_count" + con_count);
//*/
//			conn = DBManager.getConnection();
//
//			System.out.println("getConnection()");
//
//			stmt = conn.createStatement();
//
//			System.out.println("PNOEncrypt: DBConnector complete");
//
//			query =
//				"select to_char(REG_DATE,'YYYYMMDDQJ') AS REGDATE from "
//					+ TableName
//					+ " where p_no2="
//					+ P2_Key;
//			rs = stmt.executeQuery(query);
//
//			System.out.println(query);
//
//			System.out.println("PNOEncrypt: Select executeQuery");
//			System.out.println("rs = " + rs);
//
//			if (rs.next()) {
//				long D_Key = rs.getLong("REGDATE");
//				System.out.println("PNOEncrypt:D_Key=" + D_Key);
//				String inv_P_NO = P_NO2 + P_NO1; //inverse P_NO
//				long P1_Key = Long.parseLong(inv_P_NO) * 399;
//				System.out.println("PNOEncrypt: P1_Key=" + P1_Key);
//				result = D_Key - P1_Key;
//				System.out.println("PNOEncrypt: result=" + result);
//
//			}
//			System.out.println("PNOncrypt: if(rs.next()) end");
//
//		} catch (SQLException e) {
//		} finally {
//			try {
//				if (rs != null)
//					rs.close();
//				if (stmt != null)
//					stmt.close();
//				if (conn != null)
//					conn.close();
//			} catch (Exception s) {
//				System.out.println("Encoding error no:" + P2_Key);
//			}
//			System.out.println("finally result = " + result);
//			return result;
//		}
//
//	}

	/**
	 *
	 * 2003-11-27 Administrator
	 * @param MEMBER_FLAG
	 * @param P_NO1
	 * @param P_NO2
	 * @return
	 * @throws NamingException
	 */
	public static long PNOEncrypt(Connection conn, int MEMBER_FLAG, String P_NO1, String P_NO2) {

		long result;
		Statement stmt = null;
		ResultSet rs = null;

		String query = null;
		result = 0;

		String P_NO = P_NO1 + P_NO2;
		int P2_Key = P_NO.hashCode();
		String TableName = "member_t";

		try {
			stmt = conn.createStatement();

			query =
				"select to_char(REG_DATE,'YYYYMMDDQJ') AS REGDATE from "
					+ TableName
					+ " where p_no2="
					+ P2_Key;
			rs = stmt.executeQuery(query);

			if (rs.next()) {
				long D_Key = rs.getLong("REGDATE");

				String inv_P_NO = P_NO2 + P_NO1; //inverse P_NO
				long P1_Key = Long.parseLong(inv_P_NO) * 399;

				result = D_Key - P1_Key;


			}

		} catch (SQLException e) {
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
			} catch (Exception s) {
				System.out.println("Encoding error no:" + P2_Key);
			}
			System.out.println("finally result = " + result);
			return result;
		}

	}

	/**
	 *
	 * 2002-08-07 최범진
	 * @param NO Member NO
	 * @param member_flag
	 * @return Persnal NO
	 * @throws NamingException
	 */
	public static String PNODecrypt(String NO, int member_flag)
		throws NamingException {

		DataSource ds = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sresult = "";

		String query = null;

		long D_Key;
		long P1_Key;

		String TableName = "";
		try {
			/*switch (member_flag) {
				case 0 :
					TableName = "MEMBER_TABLE0";
					break;
				case 1 :
				case 3 :
				case 5 :
				case 6 :
					TableName = "MEMBER_TABLE1";
					break;
				case 2 :
				case 4 :
					TableName = "MEMBER_TABLE2";
					break;
			}
			*/
			TableName = "MEMBER_T";
			query =
				"select to_char(REG_DATE, 'YYYYMMDDQJ') AS REGDATE, P_NO1 FROM "
					+ TableName
					+ " where NO="
					+ NO;

			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("PensionDS");
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);

			if (rs.next()) {
				D_Key = rs.getLong("REGDATE");
				P1_Key = rs.getLong("P_NO1");

				long P_NO1 = (D_Key - P1_Key) / 399;

				//reverse P_NO
				String temppno = P_NO1 + "";
				String p_no2 = temppno.substring(0, 7);
				String p_no1 = temppno.substring(7);
				sresult = p_no1 + p_no2;

			}
		} catch (SQLException e) {
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception s) {
			}

			return sresult;
		}

	}

}
