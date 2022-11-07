/*
 * Created on 2003-07-29
 *
 */
package ut.lib.util;

/**
 * <p>Title: NumConv.java</p>
 * <p>Description: 주로 화면에 표시하기 위한 변환 (Long->콤마가 있는 String등)</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Neomoney Corp,.</p>
 * @author JeongSik,Kim (coffey6919@hotmail.com)
 * @version 1.0
 */
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.StringTokenizer;
public class NumConv {

	public static String setComma(Object num) {
		String ret = "";
		String pattern = "###,###,###,###,##0";
		try {
			if (num instanceof Float) {
				pattern = "###,###,###,###,##0.00";
			} else if (num instanceof Long) {
			} else if (num instanceof Integer) {
			} else if (num instanceof Double) {
				pattern = "###,###,###,###,##0.00";
			} else if (num instanceof String) {
				//
				// 숫자인지 아닌지 Check
				//
				try {
					Double numDouble = new Double("0.0");
					numDouble = Double.valueOf(String.valueOf(num));
				} catch (NumberFormatException e) {
					//                    " is not a number.");
					num = "0";
				}
				StringTokenizer st =
					new StringTokenizer(String.valueOf(num), ".");
				//
				// 소수점형태의 String인지 check
				//
				if (st.countTokens() > 1) {
					num = Double.valueOf(String.valueOf(num));
					pattern = "###,###,###,###,##0.00";
				} else {
					num = Long.valueOf(String.valueOf(num));
					pattern = "###,###,###,###,##0";
				}
			}
			//
			// Unsupported Format
			//
			else {
				num = "0";
			}
		} catch (NumberFormatException e) {
		} catch (Exception e) {
		}
		NumberFormat formatter = NumberFormat.getNumberInstance();
		DecimalFormat form = (DecimalFormat) formatter;
		try {
			if (form instanceof DecimalFormat) {
				form.applyPattern(pattern);
				ret = formatter.format(num);
			}
		} catch (Exception e) {
			ret = "0";
		}
		return ret;
	}
	/**
	 * Convert Object to Commaed String with pattern
	 *
	 * @param num Object
	 * @param pattern String
	 * @return String
	 */
	public static String setComma(Object num, String pattern) {
		String ret = "";
		try {
			if (num instanceof Float) {
			} else if (num instanceof Integer) {
			} else if (num instanceof Long) {
			} else if (num instanceof Double) {
			} else if (num instanceof String) {
				//
				// 숫자인지 아닌지 Check
				//
				try {
					Double numDouble = new Double("0.0");
					numDouble = Double.valueOf(String.valueOf(num));
				} catch (NumberFormatException e) {
					//                     " is not a number.");
					num = "0";
				}
				StringTokenizer st =
					new StringTokenizer(String.valueOf(num), ".");
				//
				// 소수점형태의 String인지 check
				//
				if (st.countTokens() > 1) {
					num = Double.valueOf(String.valueOf(num));
				} else {
					num = Long.valueOf(String.valueOf(num));
				}
			}
			//
			// Unsupported Format
			//
			else {
				num = "0";
			}
		} catch (NumberFormatException e) {
		} catch (Exception e) {
		}
		NumberFormat formatter = NumberFormat.getNumberInstance();
		DecimalFormat form = (DecimalFormat) formatter;
		try {
			if (form instanceof DecimalFormat) {
				form.applyPattern(pattern);
				ret = formatter.format(num);
			}
		} catch (Exception e) {
			ret = "0";
		}
		return ret;
	}

	public static String LongToComma(Long num) {
		if (num == null)
			return "0";
		String ret = "0";
		//NumberFormat formatter = NumberFormat.getNumberInstance( Locale.KOREA );
		NumberFormat formatter = NumberFormat.getNumberInstance();
		DecimalFormat form = (DecimalFormat) formatter;
		if (form instanceof DecimalFormat) {
			form.applyPattern("###,###,###,###,##0");
			ret = formatter.format(num.longValue());
		}
		return ret;
	}
	public static String LongToComma(long num) {
		String ret = "0";
		NumberFormat formatter = NumberFormat.getNumberInstance();
		DecimalFormat form = (DecimalFormat) formatter;
		if (form instanceof DecimalFormat) {
			form.applyPattern("###,###,###,###,##0");
			ret = formatter.format(num);
		}
		return ret;
	}
	public static String LongToComma(String numStr) {
		if (numStr == null)
			return "0";
		String ret = "0";
		long num = 0;
		try {
			num = new Long(numStr).longValue();
			NumberFormat formatter = NumberFormat.getNumberInstance();
			DecimalFormat form = (DecimalFormat) formatter;
			if (form instanceof DecimalFormat) {
				form.applyPattern("###,###,###,###,##0");
				ret = formatter.format(num);
			}
		} catch (Exception e) {
			ret = "0";
		}
		return ret;
	}
	public static String FloatToCommaPeriod(double num) {
		String ret = "0";
		NumberFormat formatter = NumberFormat.getNumberInstance();
		DecimalFormat form = (DecimalFormat) formatter;
		if (form instanceof DecimalFormat) {
			form.applyPattern("###,###,###,###,##0.00");
			ret = formatter.format(num);
		}
		return ret;
	}
	public static String FloatToCommaPeriod(float num) {
		String ret = "0";
		NumberFormat formatter = NumberFormat.getNumberInstance();
		DecimalFormat form = (DecimalFormat) formatter;
		if (form instanceof DecimalFormat) {
			form.applyPattern("###,###,###,###,##0.00");
			ret = formatter.format(num);
		}
		return ret;
	}
	/**
	 * 스트링의 마지막에 .을 찍어서 보내면 "0.00"타입으로 아니면 "0"타입으로 리턴
	 * @param numStr
	 * @return
	 */
	public static String FloatToCommaPeriod(String numStr) {
		String ret = "0";
		float num = 0.0f;
		try {
			num = new Float(numStr).floatValue();
			NumberFormat formatter = NumberFormat.getNumberInstance();
			DecimalFormat form = (DecimalFormat) formatter;
			if (form instanceof DecimalFormat) {
				form.applyPattern("###,###,###,###,##0.00");
				ret = formatter.format(num);
			}
		} catch (Exception e) {
			ret = "0.00";
		}
		return ret;
	}

	/**
	 * Convert Commaed String to String
	 *
	 * @param num
	 * @return String
	 */
	public static String unsetComma(String num) {
		String ret = "";
		StringTokenizer stComma = new StringTokenizer(num, ",");
		try {
			while (stComma.hasMoreTokens()) {
				ret += new String(stComma.nextToken());
			}
		} catch (Exception e) {
			return num;
		}
		return ret;
	}
	/**
	 * Convert Comma String to String.
	 * 결과값이 숫자인지를 체크함
	 *
	 * @param num String
	 * @param checkForce boolean
	 * @return String
	 */
	public static String unsetComma(String num, boolean checkForce) {
		String ret = unsetComma(num);
		if (checkForce) {
			try {
				double retDouble = Double.parseDouble(ret);
				return ret;
			} catch (NumberFormatException e) {
				System.out.println(
					"unsetComma error : " + num + ". Is that a Number ?");
				return "0";
			} catch (Exception e) {
				System.out.println(
					"unsetComma error : " + num + ". Error unknown.");
				return "0";
			}
		}
		return ret;
	}

	/**
	 * Convert int to Commaed String
	 * @param num
	 * @return String
	 */
	public static String setComma(int num) {
		return setComma(new Integer(num));
	}
	/**
	 * Convert int to Commaed String with pattern
	 * @param num
	 * @param pattern
	 * @return String
	 */
	public static String setComma(int num, String pattern) {
		return setComma(new Integer(num), pattern);
	}
	/**
	 * Convert long to Commaed String
	 * @param num
	 * @return String
	 */
	public static String setComma(long num) {
		return setComma(new Long(num));
	}
	/**
	 * Convert long to Commaed String with pattern
	 * @param num
	 * @param pattern
	 * @return String
	 */
	public static String setComma(long num, String pattern) {
		return setComma(new Long(num), pattern);
	}
	/**
	 * Convert float to Commaed String
	 * @param num
	 * @return String
	 */
	public static String setComma(float num) {
		return setComma(new Float(num));
	}
	/**
	 * Convert float to Commaed String with pattern
	 * @param num
	 * @param pattern
	 * @return String
	 */
	public static String setComma(float num, String pattern) {
		return setComma(new Float(num), pattern);
	}
	/**
	 * Convert double to Commaed String
	 * @param num
	 * @return
	 */
	public static String setComma(double num) {
		return setComma(new Double(num));
	}
	/**
	 * Convert double to Commaed String with pattern
	 * @param num
	 * @param pattern
	 * @return
	 */
	public static String setComma(double num, String pattern) {
		return setComma(new Double(num), pattern);
	}
}
