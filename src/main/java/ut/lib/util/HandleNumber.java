/*------------------------------------------------------------------------------
 * 수정일      요청자  수정자  수정사유
 *------------------------------------------------------------------------------
 * 2002.07.08 이상곤  류지형   스트링객체를 인자로 받는 getCommaPonitNumber()추가
 *----------------------------------------------------------------------------*/

/*
 * @(#)HandleNumber.java
 *
 * Copyright 2002 Neomoney Co., Ltd. All rights reserved.
 */

package ut.lib.util;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

/**
 * 여러가지 숫자를 특정한 형태로 반환해 주는 클래스
 *
 * @author 김정식
 * @version 1.1 refactoring (류지형)
 * @version 1.0
 */
public class HandleNumber {

	/**
	 * 입력된 숫자를 000,000.00의 형태로 변환
	 *
	 * @param num 변환할 숫자
	 * @return
	 */
	public static String getCommaPointNumber(float num) {
		return getPointFormat().format(num);
	}

	/**
	 * 입력된 숫자를 000,000.00의 형태로 변환
	 *
	 * @param num a <code>Float</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaPointNumber(Float num) {
		return getPointFormat().format(num);
	}

	/**
	 * 입력된 숫자를 000,000.00의 형태로 변환
	 *
	 * @param num a <code>double</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaPointNumber(double num) {
		return getPointFormat().format(num);
	}

	public static String getCommaPointNumber(String num) {
		if (num == null || num.equals("")) {
			return "";
		}
		return getPointFormat().format(
			Double.parseDouble(
				StringReplace.change(StringReplace.nvl(num, "0"), ",", "")));
	}

	public static String getCommaPointNumber(String num, String rep) {
		return getPointFormat().format(
			Double.parseDouble(
				StringReplace.change(StringReplace.nvl(num, rep), ",", "")));
	}

	/**
	 * 입력된 숫자를 000,000.00의 형태로 변환
	 *
	 * @param num a <code>Double</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaPointNumber(Double num) {
		return getPointFormat().format(num);
	}
	/**
	 * 입력된 숫자를 000,000.0의 형태로 변환
	 *
	 * @param num a <code>Double</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaOnePointNumber(Double num) {
		return getOnePointFormat().format(num);
	}
	
	/**
	 * 입력된 숫자를 000,000의 형태로 변환
	 *
	 * @param num a <code>float</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaNumber(float num) {
		return getRoundFormat().format(num);
	}

	/**
	 * 입력된 숫자를 000,000의 형태로 변환
	 *
	 * @param num a <code>Float</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaNumber(Float num) {
		return getRoundFormat().format(num);
	}

	/**
	 * 입력된 숫자를 000,000.00의 형태로 변환
	 *
	 * @param num a <code>double</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaNumber(double num) {
		return getRoundFormat().format(num);
	}

	/**
	 * Describe <code>getCommaNumber</code> method here.
	 *
	 * @param num a <code>Double</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaNumber(Double num) {
		return getRoundFormat().format(num);
	}

	/**
	 * Describe <code>getCommaNumber</code> method here.
	 *
	 * @param num an <code>int</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaNumber(int num) {
		return getRoundFormat().format(num);
	}

	/**
	 * Describe <code>getCommaNumber</code> method here.
	 *
	 * @param num an <code>Integer</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaNumber(Integer num) {
		return getRoundFormat().format(num);
	}

	/**
	 * Describe <code>getCommaNumber</code> method here.
	 *
	 * @param num a <code>long</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaNumber(long num) {
		return getRoundFormat().format(num);
	}

	/**
	 * Describe <code>getCommaNumber</code> method here.
	 *
	 * @param num a <code>Long</code> value
	 * @return a <code>String</code> value
	 */
	public static String getCommaNumber(Long num) {

		return getRoundFormat().format(num);
	}

	public static String getCommaNumber(String strNum) {
		if (strNum == null || strNum.equals("")) {
			return "";
		}
		return getRoundFormat().format(
			toLong(
				StringReplace.change(StringReplace.nvl(strNum, "0"), ",", "")));
	}
	/**
	 * 소수점 첫째자리까지 반올림 해서 보여주는 메소드
	 */
	public static String getFloatNumber(float a) {
		return getOnePointFormat().format((double) a);
	}

	public static String getCommaNumber(String strNum, String rep) {
		return getRoundFormat().format(
			toLong(
				StringReplace.change(StringReplace.nvl(strNum, rep), ",", "")));
	}

	public static long toLong(String longValue) {

		return (long) Double.parseDouble(StringReplace.nvl(longValue, "0"));
	}

	public static double toDouble(String doubleValue) {
		return Double.parseDouble(StringReplace.nvl(doubleValue, "0"));
	}

	public static float toFloat(String floatValue) {
		return Float.parseFloat(StringReplace.nvl(floatValue, "0"));
	}

	public static int toInt(String intValue) {
		return (int) Double.parseDouble(StringReplace.nvl(intValue, "0"));
	}

	private static DecimalFormat getFormat(String pattern) {
		NumberFormat formatter = NumberFormat.getNumberInstance(Locale.US);
		DecimalFormat form = (DecimalFormat) formatter;
		if (form instanceof DecimalFormat) {
			form.applyPattern(pattern);
		}

		return form;
	}

	private static DecimalFormat getRoundFormat() {
		NumberFormat formatter = NumberFormat.getNumberInstance(Locale.US);
		DecimalFormat form = (DecimalFormat) formatter;
		if (form instanceof DecimalFormat) {
			form.applyPattern("###,###,###,###,##0");
		}

		return form;
	}

	private static DecimalFormat getPointFormat() {
		NumberFormat formatter = NumberFormat.getNumberInstance(Locale.US);
		DecimalFormat form = (DecimalFormat) formatter;
		if (form instanceof DecimalFormat) {
			form.applyPattern("###,###,###,###,##0.00");
		}

		return form;
	}

	private static DecimalFormat getOnePointFormat() {
		NumberFormat formatter = NumberFormat.getNumberInstance(Locale.US);
		DecimalFormat form = (DecimalFormat) formatter;
		if (form instanceof DecimalFormat) {
			form.applyPattern("###,###,###,###,##0.0");
		}

		return form;
	}

	/**
	 * 문자의 자릿수마다 콤마를 붙여주되 단 소수점 이하의 숫자가 0 이면 지워서 보내는 함수.
	 * ex)	1111.12 -> 1,111.12
	 * 		1111.00 -> 1,111
	 * 		1111.0	-> 1,111
	 * 	
	 * @param strNum
	 * @return
	 */
	public static String getCommaZeroDeleteNumber(String strNum) {
		
		if (strNum == null || strNum.equals("")) {
			return "";
		}
		Double num = toDouble(strNum);
		if(strNum.indexOf(".") > -1){  //넘어온 문자의 . 이 포함되어있는지 확인.
			
			String sosuStr = strNum.substring(strNum.indexOf(".")); //소수점 이하의 문자 추출
			if(sosuStr.length() >= 3){ //.00 이상
				
				if( Integer.parseInt(sosuStr.substring(1, 3)) > 0 ) //소수점두째 자리 까지의 숫자가 00 이 아니라면
					return getPointFormat().format(num);
				
			}else if(sosuStr.length() > 2){
				
				if( Integer.parseInt(sosuStr.substring(1, 2)) > 0 ) //소수점두째 자리 까지의 숫자가 0 이 아니라면
					return getOnePointFormat().format(num);
				
			}
		}
		
		return getRoundFormat().format(num);
	}


}
