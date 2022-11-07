package ut.lib.util;

/**
 * <p>Title: 형변환</p>
 * <p>Description: primitive형으로 변환</p>
 * <p>Copyright: Copyright (c) 2002 NeoMoney Co., Ltd.</p>
 * <p>Company: NeoMoney Co., Ltd.</p>
 * @author susia
 * @version 1.0
 */

import java.text.DecimalFormat;

public class ConvType {
	public static String sTmp = "";
	public static int iTmp = 0;
	public static long lTmp = 0L;
	public static float fTmp = 0f;
	public static double dTmp = 0.0;

	public static DecimalFormat decimalformat = new DecimalFormat();

	public ConvType() {
	}

	// return 값은 String.
	public static String getStr(int in_i) {
		sTmp = String.valueOf(in_i);
		return sTmp;
	}

	public static String getStr(long in_l) {
		sTmp = String.valueOf(in_l);
		return sTmp;
	}

	public static String getStr(float in_f) {
		sTmp = String.valueOf(in_f);
		return sTmp;
	}

	public static String getStr(double in_d) {
		sTmp = String.valueOf(in_d);
		return sTmp;
	}
	// return 값은 String End.

	// return 값은 int.
	public static int getInt(String in_s) {

		if (in_s == null)
			in_s = "";
		try {
			iTmp = decimalformat.parse(in_s).intValue();
		} catch (Exception e) {
			iTmp = 0;
		}

		return iTmp;
	}

	public static int getInt(long in_l) {
		Long oLong = new Long(in_l);
		iTmp = oLong.intValue();
		return iTmp;
	}

	public static int getInt(float in_f) {
		Float oFloat = new Float(in_f);
		iTmp = oFloat.intValue();
		return iTmp;
	}

	public static int getInt(double in_d) {
		Double oDouble = new Double(in_d);
		iTmp = oDouble.intValue();
		return iTmp;
	}
	// return 값은 int End.

	// return 값은 long.
	public static long getLong(String in_s) {

		if (in_s == null)
			in_s = "";
		try {
			lTmp = decimalformat.parse(in_s).longValue();
		} catch (Exception e) {
			lTmp = 0;
		}

		return lTmp;
	}

	public static long getLong(int in_i) {
		Integer oInteger = new Integer(in_i);
		lTmp = oInteger.longValue();
		return lTmp;
	}

	public static long getLong(float in_f) {
		Float oFloat = new Float(in_f);
		lTmp = oFloat.longValue();
		return lTmp;
	}

	public static long getLong(double in_d) {
		Double oDouble = new Double(in_d);
		lTmp = oDouble.longValue();
		return lTmp;
	}
	// return 값은 long End.

	// return 값은 float.
	public static float getFloat(String in_s) {

		if (in_s == null)
			in_s = "";
		try {
			fTmp = decimalformat.parse(in_s).floatValue();
		} catch (Exception e) {
			fTmp = 0;
		}

		return fTmp;
	}

	public static float getFloat(int in_i) {
		Integer oInteger = new Integer(in_i);
		fTmp = oInteger.floatValue();
		return fTmp;
	}

	public static float getFloat(long in_l) {
		Long oLong = new Long(in_l);
		fTmp = oLong.floatValue();
		return fTmp;
	}

	public static float getFloat(double in_d) {
		Double oDouble = new Double(in_d);
		fTmp = oDouble.floatValue();
		return fTmp;
	}
	// return 값은 float End.

	// return 값은 double.
	public static double getDouble(String in_s) {

		if (in_s == null)
			in_s = "";
		try {
			dTmp = decimalformat.parse(in_s).doubleValue();
		} catch (Exception e) {
			dTmp = 0;
		}

		return dTmp;
	}

	public static double getDouble(int in_i) {
		Integer oInteger = new Integer(in_i);
		dTmp = oInteger.intValue();
		return dTmp;
	}

	public static double getDouble(long in_l) {
		Long oLong = new Long(in_l);
		dTmp = oLong.doubleValue();
		return dTmp;
	}

	public static double getDouble(float in_f) {
		Float oFloat = new Float(in_f);
		dTmp = oFloat.doubleValue();
		return dTmp;
	}
	// return 값은 double End.

	
	
    /**
     * 문자형 숫자에 0 을 붙여서 숫자 리턴한다.
     * number 들어온 숫자
     * maxLength 원하는 자릿수
     * 
     * ex) plusZero(7, 3) => 007
     * @param int
     * @return 변경된 문자열
     */	
    public static String plusZero(int number) {
    	return plusZero(number, 2);
    }
    public static String plusZero(int number, int maxLength) {
    	
    	String returnValue = "";
    	try{
            String temp = String.valueOf(number);
            
            for(int i=0;i<maxLength - temp.length();i++)
            	returnValue += "0";
            
            returnValue += temp;
    		
    	}catch(Exception e){
    		
    		for(int i = 0;i<maxLength;i++)
    			returnValue += "0";
    		
    		returnValue += "1";
    	}
    	
    	return returnValue;

    }
    
}
