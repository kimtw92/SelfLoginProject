package ut.lib.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Reader;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.*;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.*;

import java.lang.String;

//import oracle.sql.CLOB;
import ut.lib.log.Log;
import ut.lib.page.PageFactory;
import ut.lib.page.PageInfo;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import common.NamoMime;


/**
 * <B>Util</B>
 * - 공통 Utility 클래스
 */
public class Util {
    public Util() {

    }
    /**
     * CLOB Type의 Data를 Table에 Insert(Update) 한다.
     * @param clob 대상이 되는 clob객체
     * @param reqData clob컬럼에 등록될 실 Data
     */

//    public static void setClob (CLOB cl, String sb)
//        throws Exception {
//
//        try {
//
//			// 스트림을 이용한 값 저장
//			BufferedWriter writer = new BufferedWriter(cl.getCharacterOutputStream());
//			writer.write(sb);
//			writer.close();
//
//
//
//        	/*
//            Writer writer = ((Clob)clob).getCharacterStream();
//
//
//        	//Writer writer = ((Clob)clob).getCharacterStream();
//            Reader reader = new CharArrayReader(reqData.toCharArray());
//            char[] buffer = new char[1024];
//            int read = 0;
//            while ( (read = reader.read(buffer,0,1024)) != -1 ) {
//                writer.write(buffer,0,read);
//            }
//            reader.close();
//            writer.close();
//            */
//        }catch(SQLException e) {
//            Log.info("LobData.class",
//                        "[ LobData.setClob() ]"
//                        + e.getMessage());
//                throw e;
//        }catch(IOException e) {
//        	Log.info("LobData.class",
//                        "[ LobData.setClob() ]"
//                        + e.getMessage());
//            throw e;
//        }
//    }

    /**
     * CLOB Type의 Data를 Table에서 읽어 온다.
     * @param reader ResultSet에서 읽어온 Clob 객체 ( rs.getCharacterStream(int index) )
     * @return CLOB Data
     */
    public static String getClob(Clob clob){
    	try {
			return getClob(clob.getCharacterStream());
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return "";
    }
    public static String getClob(Reader rd)
    	throws Exception{
    	 // CLOB column에 대한 스트림을 얻는다.
		StringBuffer sb = new StringBuffer();
        char[] buf = new char[1024];
        int readcnt;

        if (rd != null) {
	        while ((readcnt = rd.read(buf, 0, 1024)) != -1) {
				// 스트림으로부터 읽어서 스트링 버퍼에 넣는다.
				sb.append(buf, 0, readcnt);
	        }
	        rd.close();
        }

        return sb.toString();

    }

    /**
     * 제한된 글자수 만큼 잘라내고 '...'을 붙인다.
     * @param String 문자열
     * @param int 글자수
     * @return void
     */
    public static synchronized String cutString(String str,int maxNum) {
        int tLen = str.length();
        int count = 0;
        char c;
        int s=0;
        for(s=0;s<tLen;s++){
            c = str.charAt(s);
            if(count > maxNum) break;
            if(c>127) count +=2;
            else count ++;
        }
        return (tLen >s)? str.substring(0,s)+"..." : str;
    }

    /**
     * 캐리지 리턴을 br 태그로 replace한다.
     * @param String 문자열
     * @return br태그로 변경된 문자열
     */
    public static synchronized String N2Br(String s)
    {
        return replaceString("\n", "<BR>", s);
    }

    public static synchronized String convertFlashString(String s) {
        String temp = s;
        temp = replaceString(" ", "%20", temp);
        temp = replaceString("!", "%21", temp);
        temp = replaceString("\"", "%22", temp);
        temp = replaceString("#", "%23", temp);
        temp = replaceString("$", "%24", temp);
        temp = replaceString("%", "%25", temp);
        temp = replaceString("&", "%26", temp);

        return temp;
    }

    public static synchronized String replaceString(String s, String s1, String s2)
    {
        int i = 0;
        int j = 0;
        StringBuffer stringbuffer = new StringBuffer();

        while((j = s2.indexOf(s, i)) >= 0)
        {
            stringbuffer.append(s2.substring(i, j));
            stringbuffer.append(s1);
            i = j + s.length();
        }

        stringbuffer.append(s2.substring(i));

        return stringbuffer.toString();
    }

    /**
     * yyyyMMddhh24miss 를 yyyy-MM-dd hh24:mi:ss 로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static String convertDate1(String date) {
        if (date.length() == 14) {
            return date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8) + " " + date.substring(8, 10) + ":" + date.substring(10, 12) + ":" + date.substring(12);
        } else if (date.length() == 8) {
            return date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8);
        } else {
            return "";
        }
    }

    /**
     * yyyyMMddhh24miss 를 yyyy년 MM월dd일로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static String convertDate2(String date) {
        if (date.length() == 14) {
            return date.substring(0, 4) + "년 " + Integer.parseInt(date.substring(4, 6)) + "월" + Integer.parseInt(date.substring(6, 8)) + "일" ;
        } else if (date.length() == 8) {
            return date.substring(0, 4) + "년 " + Integer.parseInt(date.substring(4, 6)) + "월 " + Integer.parseInt(date.substring(6, 8)) + "일";
        } else {
            return "";
        }
    }

    /**
     * yyyyMMddhh24miss 를 yyyy년 MM월dd일로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static String convertDate4(String date) {
        if (date.length() == 14) {
            return Integer.parseInt(date.substring(4, 6)) + "월" + Integer.parseInt(date.substring(6, 8)) + "일" ;
        } else if (date.length() == 8) {
            return Integer.parseInt(date.substring(4, 6)) + "월 " + Integer.parseInt(date.substring(6, 8)) + "일";
        } else {
            return "";
        }
    }

    /**
     * yyyyMMddhh24 를 yyyy년 MM월dd일 오후 2시로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static String convertDate5(String date) {

         String divideDate = date.replaceAll("-","");

        if (date.length() == 10) {
            divideDate = date.substring(0, 4) + "년 " + Integer.parseInt(date.substring(4, 6)) + "월" + Integer.parseInt(date.substring(6, 8)) + "일" ;

            if ( Integer.parseInt(date.substring(8, 10)) < 12 )
            {
                divideDate = divideDate + " 오전 "+Integer.parseInt(date.substring(8, 10))+ "시";
            } else if ( Integer.parseInt(date.substring(8, 10)) >= 12 )
            {
                divideDate = divideDate + " 오후 "+ (Integer.parseInt(date.substring(8, 10))-12 ) +  "시";
            }
        } else {
            return "";
        }

        return divideDate;
    }

    /**
     * 문자형 한자리 숫자에 0 + 숫자 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static String plusZero(String number) {
        if (number.length() == 1) {
            return "0"+number;
        } else {
            return number;
        }
    }


    /**
     * 문자형 한자리 숫자에 0 + 숫자 리턴한다.
     * @param int
     * @return 변경된 문자열
     */
    public static String plusZero(int number) {
        String temp = String.valueOf(number);
        if (temp.length() == 1) {
            return "0"+temp;
        } else {
            return temp;
        }
    }



    /**
     * 넘어온 휴대전화번호를 쪼개준다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static String[] divideMPhone(String phone) {

        String phoneNumber = phone.replaceAll("-","");
               phoneNumber = phoneNumber.replaceAll(" ","");

        String[] mphone = { "", "", ""} ;

        if ( phoneNumber.length() != 0 )
        {
            if (phoneNumber.length() == 11) {
                if ( phoneNumber.substring(0, 3).equals("013") || phoneNumber.substring(0, 3).equals("050") ) {
                    mphone[0] = phoneNumber.substring(0, 4);
                    mphone[1] = phoneNumber.substring(4, 7);
                    mphone[2] = phoneNumber.substring(7, 11);
                }
                else {
                    mphone[0] = phoneNumber.substring(0, 3);
                    mphone[1] = phoneNumber.substring(3, 7);
                    mphone[2] = phoneNumber.substring(7, 11);
                }
            } else if (phoneNumber.length() == 10) {
                mphone[0] = phoneNumber.substring(0, 3);
                mphone[1] = phoneNumber.substring(3, 6);
                mphone[2] = phoneNumber.substring(6, 10);
            }
            else if  (phoneNumber.length() == 12)  {
                mphone[0] = phoneNumber.substring(0, 4);
                mphone[1] = phoneNumber.substring(4, 8);
                mphone[2] = phoneNumber.substring(8, 12);
            }
        }

        return mphone;
    }

    /**
     * 넘어온 전화번호를 쪼개준다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static String[] divideHPhone(String hphone) {

        String phoneNumber = hphone.replaceAll("-","");
               phoneNumber = phoneNumber.replaceAll(" ","");

        String[] phone = { "", "", "" } ;

        if ( phoneNumber.length() != 0 )
        {
            if ( phoneNumber.substring(0, 2).equals("02") ) {

                if ( phoneNumber.length() == 10 )
                {
                    phone[0] = phoneNumber.substring(0, 2);
                    phone[1] = phoneNumber.substring(2, 6);
                    phone[2] = phoneNumber.substring(6, 10);
                }
                else if ( phoneNumber.length() == 9 )
                {
                    phone[0] = phoneNumber.substring(0, 2);
                    phone[1] = phoneNumber.substring(2, 5);
                    phone[2] = phoneNumber.substring(5, 9);
                }
            }

            if ( phoneNumber.length() == 12 )
            {
                phone[0] = phoneNumber.substring(0, 4);
                phone[1] = phoneNumber.substring(4, 8);
                phone[2] = phoneNumber.substring(8, 12);
            }
            else if ( phoneNumber.length() == 11 )
            {
                if ( phoneNumber.substring(0, 3).equals("013") || phoneNumber.substring(0, 3).equals("050") )
                {
                        phone[0] = phoneNumber.substring(0, 4);
                        phone[1] = phoneNumber.substring(4, 7);
                        phone[2] = phoneNumber.substring(7, 11);
                }
                else if ( !phoneNumber.substring(0, 3).equals("013") || !phoneNumber.substring(0, 3).equals("050"))
                {
                        phone[0] = phoneNumber.substring(0, 3);
                        phone[1] = phoneNumber.substring(3, 7);
                        phone[2] = phoneNumber.substring(7, 11);
                }
            }
            else if ( !phoneNumber.substring(0, 2).equals("02") && phoneNumber.length() == 10 )
            {
                phone[0] = phoneNumber.substring(0, 3);
                phone[1] = phoneNumber.substring(3, 6);
                phone[2] = phoneNumber.substring(6, 10);
            }
        }

        return phone;
    }

     /**
     * yyyyMMddhh24miss 를 영문요일로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static String convertDate3() {

            Calendar now   = Calendar.getInstance();

            int day = now.get(Calendar.DAY_OF_WEEK);
            now.set(Calendar.YEAR,Calendar.MONTH,Calendar.DATE);

            String   today = "";

            switch(day) {

	            case 1: today = "SUN"; break;
	            case 2: today = "MON"; break;
	            case 3: today = "TUE"; break;
	            case 4: today = "WED"; break;
	            case 5: today = "THU"; break;
	            case 6: today = "FRI"; break;
	            case 7: today = "SAT";
            }

            return today;
    }


    /**
     * 해당날짜를 요일정보[1,2,3,4,5,6,7]로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static int startDayOfWeek(int Year, int Month) {

    	int year = Year; //Integer.parseInt(Year);
    	int month = Month; //Integer.parseInt(Month);

    	int START_DAY_OF_WEEK = 0;

    	Calendar sDay = Calendar.getInstance();
    	sDay.set(year, month-1, 1);

    	START_DAY_OF_WEEK = sDay.get(Calendar.DAY_OF_WEEK);

            Calendar now   = Calendar.getInstance();

            now.set(Calendar.YEAR,Calendar.MONTH,Calendar.DATE);



            return START_DAY_OF_WEEK;
    }

    /**
     * 해당월의 마지막날짜를 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static int monthEndDay(int Year, int Month) {

    	int year = Year;//Integer.parseInt(Year);
    	int month = Month;//Integer.parseInt(Month);

    	int END_DAY = 0;

    	Calendar eDay = Calendar.getInstance();
    	eDay.set(year, month, 1);
    	eDay.add(Calendar.DAY_OF_MONTH, -1);

    	END_DAY = eDay.get(Calendar.DAY_OF_MONTH);


    	return END_DAY;
    }


    /**
     * yyyyMMddhh24miss 를 yyyy-MM-dd hh24:mi:ss 로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */
    public static String convertDate4(String date, String sep) {
        if (date.length() > 7) {
            return date.substring(0, 4) + sep + date.substring(4, 6) + sep + date.substring(6, 8) ;
        } else {
            return "";
        }
    }

    /**
     * 복수의 파일 삭제
     * @param String path 	삭제할 파일의 경로
     * @param String[] fileName 삭제할 파일명
     */
    public static void deleteFiles(String path, String[] fileName) {
	    for (int i=0 ; i < fileName.length; i++) {
	        deleteFiles(path, fileName[i]);
	    }
    }

    /**
     * 파일 삭제
     * @param String path 	삭제할 파일의 경로
     * @param String fileName 삭제할 파일명
     */
    public static void deleteFiles(String path, String fileName) {
        File file = new File(path+File.separator+fileName);
        file.delete();
    }



    public static String getNextWeek() {
        Calendar now = Calendar.getInstance();
        now.add(Calendar.DATE, 7);
        Date date = now.getTime();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
        return formatter.format(date);
    }


	public static String formatNumber(long number, String format) {
		DecimalFormat formatter = new DecimalFormat(format);
		return formatter.format(number);
	}

	/**
     * 문자를 ###,###,###,### format으로 변환
     * @param 문자열
     * @return 변경된 문자열
     */
	public static String commaFormat(String number) {
		return formatNumber(Long.parseLong(number), "###,###,###,###");
	}

	/**
     * 문자를 특정 format으로 변환
     * @param 문자열
     * @param format
     * @return 변경된 문자열
     */
	public static String commaFormat(String number, String format) {
		return formatNumber(Long.parseLong(number), format);
	}

	/**
     * null 값이 아닌 string을 주어진 길이 만큼 space 문자를 채운후 반환
     * @param 문자열
     * @param 길이
     * @return 변경된 문자열
     */
	public static String fixString( String str, int len )
	{
		String 		temp1;
		StringBuffer temp;
		int	i,j;

		i = str.length();
		temp = new StringBuffer( str );
		if ( i < len ){
			for ( j = 1; j <= ( len - i ); j ++ ){
				temp.append(" ");
			}
			temp1 = new String(temp);
		} else {
			if ( i > len ) {
				temp1 = str.substring( 0, len );
			} else	temp1 =  str;
		}

		return temp1;
	}

   /**
    * 금액데이타 123,345,567 형식으로 보여주기
    * @param n
    * @return
    */
    public static String moneyFormValue(String n)
    {
        boolean nFlag=true;

        String o     = "";
        String p     = "";
        String minus = "";

        if ( n.length() != 0 && n.substring(0,1).equals("-") ) {
            minus = n.substring(0,1);
            n     = n.substring(1);
        }

        if ( n.indexOf(".")>0 ) {
            o = n.substring(0, n.indexOf("."));
            p = n.substring(n.indexOf(".")+1, n.length());
        }
        else    {
            o = n;
        }

        o = Util.replace(o," ","");
        o = Util.replace(o,",","");
        o = Util.replace(o,"+","");

        int tLen = o.length();
        String tMoney = "";
        for(int i=0;i<tLen;i++){
            if (i!=0 && ( i % 3 == tLen % 3) ) tMoney += ",";
            if(i < tLen ) tMoney += o.charAt(i);
        }

        if ( p.length()>0 )     tMoney += "."+p;
        if ( nFlag == false )   tMoney = "-"+tMoney;

        if ( minus.equals("-") ) {
            tMoney = minus + tMoney;
        }

        return tMoney;
    }

    /**
     * 문자열대 문자열로 바꿔준다.
     * @param line
     * @param oldString
     * @param newString
     * @return
     */
    public static String replace(String line, String oldString, String newString)
    {
        line = getValue(line);
        for(int index = 0; (index = line.indexOf(oldString, index)) >= 0; index += newString.length())
            line = line.substring(0, index) + newString + line.substring(index + oldString.length());

        return line;
    }
	
    /**
     * 문자열을 받아서 null이면 공백 문자열로 리턴
     * @param str
     * @return
    */
    public static boolean isNull(String str)
    {
        if ((str == null) || (str.trim().equals("")) || (str.trim().equals("null")))
            return true;
        else
            return false;
    }


    
    
    
    /**
	 * 쿠키 설정 함수
	 * @param res
	 * @param cname
	 * @param cvalue
	 */
	public static void setCookie(HttpServletResponse res, String cname, String cvalue) {
		try {
			cvalue = java.net.URLEncoder.encode(cvalue, "KSC5601");
			Cookie newcookie = new Cookie(cname, cvalue);
			newcookie.setPath("/");
			newcookie.setMaxAge(new Long(System.currentTimeMillis()).intValue() + 2592000);
			res.addCookie(newcookie);
		}
		catch(Exception e){;}
	}

	/**
	 * 쿠키 검색 함수
	 * @param req
	 * @param cname
	 * @return
	 */	
	public static String getCookie(HttpServletRequest req, String cname) {
		try {
			Cookie	cookies[]			=	req.getCookies();
			String	c_value				=	null;

			for(int i=0; i<cookies.length; i++) {
				if(cname.equals(cookies[i].getName())) {
					c_value				=	(String)cookies[i].getValue();
					c_value				=	java.net.URLDecoder.decode(c_value, "KSC5601");
				}
			}
			return  Util.getValue(c_value);
		}
		catch(Exception e) {
			return  "";
		}
	}
	/*
	public static String getCookie(HttpServletRequest httpservletrequest, String s) throws Exception {
	    Cookie acookie[] = httpservletrequest.getCookies();
	    String s1 = "";

	    if(acookie != null) {
	        for(int i = 0; i < acookie.length; i++) {
	            Cookie cookie = acookie[i];

	            if(cookie.getName().equals(s))
	                return URLDecoder.decode(cookie.getValue(), "KSC5601");
	        }
	    }

	    return s1;
	}
	*/
	
    
    
    
    

	public static String getTime(String format)
	{
		if ( format == null || format.equals("") == true )
			format = "yyyyMMddHHmmss";

		TimeZone tz = TimeZone.getDefault();
		tz.setRawOffset((60*60*1000) * 9);
		TimeZone.setDefault(tz);
		Calendar cal = Calendar.getInstance(tz);
		Date date = cal.getTime();
		SimpleDateFormat formater = new SimpleDateFormat(format);
		String timestamp = formater.format(date);

		return timestamp;
	}

    /**
     * Admin에서 버튼 출력을 위해 사용한다.
     * @param String buttonName : 버튼이름, buttonLink : 해당 링크
     * @return String
     */
	public static String dispMenuName(DataMap data){
		DataMap menuData = null;
		String retStr = "";

		if (data.containsKey("MENU_DATA")) {
			menuData = (DataMap)data.get("MENU_DATA");
			retStr += "<SCRIPT>top.adminTop.menuPath.innerHTML = \""+menuData.getString("menuPath")+"\";</SCRIPT>\n";
			if (menuData != null) {
				retStr += menuData.getString("menuName");
			}
		}

		return retStr;
	}

	public static String right(String str, int length) {
		String rtnStr = "";
		if (!isNull(str) && length > 0 && (str.length() - length >= 0)) {
			rtnStr = str.substring(str.length() - length);
		}else{
			rtnStr = str;
		}
		return rtnStr;
	}



	public static String printOption(DataMap map, String valueField, String textField, String defaultValue) {
		String tmp = "";
		for (int i = 0; i < map.keySize(valueField); i++) {
			tmp += "<option value=\"" + map.getString(valueField, i) + "\"";

			if (defaultValue != null) {
				if (map.getString(valueField, i).equals(defaultValue)) {
					tmp += " selected";
				}
			}
			tmp += ">" + map.getString(textField, i) + "</option>";
		}

		return tmp;
	}

	public static String printOption(DataMap map, String valueField, String textField) {
		return printOption(map, valueField, textField, null);
	}

	public static boolean startWith(String str, String chr) {
		if (str.indexOf(chr) == 0) {
			return true;
		} else {
			return false;
		}
	}



	/**
	 * 입력받은 문자열이 null 이거나 NULL 이거나 "" 이면 원하는 문자열로 변환
	 * @param value 입력받은 문자열
	 * @param defaultValue 변환할 문자열
	 * @return 변환처리된 문자열
	 */
	public static String getValue(String value) {
		if(value == null) {
			return "";
		}else if(value.equals("null")) {
			return "";
		}else if(value.equals("NULL")) {
			return "";
		}else if(value.equals("")) {
			return "";
		}else {
			return value;
		}
	}
	public static String getValue(String value, String defaultValue) {
		if(value == null) {
			return defaultValue;
		}else if(value.equals("null")) {
			return defaultValue;
		}else if(value.equals("NULL")) {
			return defaultValue;
		}else if(value.equals("")) {
			return defaultValue;
		}else {
			return value;
		}
	}

	public static int getIntValue(String value, int defaultValue ) {

		if (value == null ||
			value.equals("null") ||
			value.equals("NULL") ||
			value.equals("") ||
			value.equals("0"))
			return defaultValue;
		else{
			return Integer.parseInt(value.toString());
		}
	}

	public static int getIntValue(int value, int defaultValue ) {

		if (value == 0)
			return defaultValue;
		else{
			return value;
		}
	}

	public static double getDoubleValue(String value, double defaultValue ) {

		if (value == null ||
			value.equals("null") ||
			value.equals("NULL") ||
			value.equals("") ||
			value.equals("0"))
			return defaultValue;
		else{
			return Double.parseDouble(value.toString());
		}
	}

	/**
	 * 입력받은 첨부 화일명을 pkid_index.ext 형태로 변환
	 * @param no 일련번호
	 * @param seq 순번
	 * @param path 경로
	 * @param baseFile 원본 화일명
	 * @return 변환된 화일
	 */
	public static File getFileRename(String no, String seq, String path){

		File returnFile = null;
		String newFileName = "";

		//String fileName = baseFile.getName();


		/**
		String ext = "txt";

		StringTokenizer st =new StringTokenizer(fileName, ".");
		int tokenLength = st.countTokens();
		for(int a=0;a<tokenLength;a++){
			ext = st.nextToken();
		}
		*/

		newFileName = no+"_"+seq;

		returnFile = new File(path + "/" + newFileName);

		return returnFile;

	}
	
	public static File getFileRename2(String path, String fileNm){

		File returnFile = null;
		String newFileName = "";

		//String fileName = baseFile.getName();


		/**
		String ext = "txt";

		StringTokenizer st =new StringTokenizer(fileName, ".");
		int tokenLength = st.countTokens();
		for(int a=0;a<tokenLength;a++){
			ext = st.nextToken();
		}
		*/

		newFileName = fileNm;

		returnFile = new File(path + newFileName);
		
		System.out.println("==" + path + newFileName);

		return returnFile;

	}

	
	/**
	 * 현재의 주소를 가져온다. (파라미터 정보를 포함하여 반환한다.)
	 * @param request
	 * @return
	 */
	public static String getNowUrl(HttpServletRequest request) throws IOException {
		String parameterList = ""; 
	   	String ret_url = "http://" + request.getHeader("Host") + request.getRequestURI();// No Parameter URL 
	
	   	int k1=0; 
	   	for (Enumeration e = request.getParameterNames(); e.hasMoreElements() ;k1++) { 
			String name = (String) e.nextElement(); 
			String[] value = request.getParameterValues(name); 
			if (k1 == 0) 
				ret_url = ret_url + "?";
			else if (k1>0)
				ret_url = ret_url + "&";
			parameterList = parameterList + "&";
			
			for (int q1 = 0; q1 < value.length; q1++){
				if (q1 > 0) {
					ret_url = ret_url + "&";
					parameterList = parameterList + "&";
				}
				ret_url = ret_url + name + "=" + value[q1]; 
				parameterList = parameterList + name + "=" + value[q1]; 
			}
	    }
	    return URLEncoder.encode(ret_url, "UTF-8");
	}
	
	
	/**
	 * 화면에 글자 
	 * @param response
	 * @param str
	 */
	public static void out(HttpServletResponse response, String str){
		
		try {

			//입력한 값이 다시 표현 될 때 한글을 표현가능하게 한다.?
			//OutputStreamWriter outp2=new OutputStreamWriter(response.getOutputStream(),"ISO8859-1");
			//PrintWriter out=new PrintWriter(outp,true);
			
			//소스에 포함된 한글을 다시 표현할때 한글 깨짐을 막기위해서다.?
			OutputStreamWriter outp2 = new OutputStreamWriter(response.getOutputStream(),"ksc5601");
			PrintWriter out2=new PrintWriter(outp2,true);
			//out2.println(HtmlUtility.URLDecode(html));
			out2.println(str);
			
			out2.flush();
			out2.close();
			
		}catch(IOException e){
			e.printStackTrace(System.err);
		}
	}
	
	
	/**
	 * 나모 웹에디터로 넘어온 내용 시스템에 맞게끔 재구성하여 Map에 담아서 보냄.
	 * @param requestMap
	 * @param contentName
	 * @param savaContentName
	 * @param saveDir
	 * @return
	 * @throws Exception
	 */
	public static DataMap saveNamoContent(DataMap requestMap, String contentName, String saveContentName, String saveDir) throws Exception{
		
		try {
			
			// 업로드할 위치와 MIME에서 대치할 LINK를 만듭니다.
			String uploadPath = SpringUtils.getRealPath() + Constants.UPLOAD + saveDir;
			//String uploadUrl = Constants.URL + File.separatorChar + Constants.UPLOAD + saveDir;
			String uploadUrl = Constants.URL + "/" + Constants.UPLOAD + saveDir;
			
			File makeDir = new File(uploadPath);								// 업로드할 디렉토리 생성
			if(!makeDir.exists())
				makeDir.mkdir();
			makeDir = null;
			
			// MIME 디코딩 하기
			NamoMime mime = new NamoMime();
			mime.setSaveURL(uploadUrl);	
			mime.setSavePath(uploadPath);
			mime.decode(StringReplace.convertHtmlEncodeNamo(requestMap.getString(contentName)));	// MIME 디코딩			
			mime.saveFile();						// 포함한 파일 저장하기
			String mimeCotent = mime.getBodyContent();
			mime.changeCIDPath(mimeCotent);
			
			requestMap.setString(saveContentName, StringReplace.convertHtmlEncodeNamo(StringReplace.replaceStr(mimeCotent, "'", "\\'")) );
			
		}catch (Exception e){
			e.printStackTrace();
		}

		return requestMap;
	}

	public static DataMap saveDaumContent(DataMap requestMap, String contentName, String saveContentName, String saveDir) throws Exception{
		
		try {
			
			// 업로드할 위치와 MIME에서 대치할 LINK를 만듭니다.
			String uploadPath = SpringUtils.getRealPath() + Constants.UPLOAD + saveDir;
			//String uploadUrl = Constants.URL + File.separatorChar + Constants.UPLOAD + saveDir;
			String uploadUrl = Constants.URL + "/" + Constants.UPLOAD + saveDir;
			
			File makeDir = new File(uploadPath);								// 업로드할 디렉토리 생성
			if(!makeDir.exists())
				makeDir.mkdir();
			makeDir = null;
			requestMap.setString(saveContentName, StringReplace.replaceStr(requestMap.getString(contentName), "'", "\\'") );
			
		}catch (Exception e){
			e.printStackTrace();
		}

		return requestMap;
	}

	public static String nvl(Object o){
		return nvl(o, "");
	}
	
	public static String nvl(Object o, String defaultValue){
		if(o==null){
			return defaultValue;
		}
		return o.toString();
	}
	
	/**
	 * 페이지 정보
	 * @param totalCnt 전체
	 * @param currPage 현재
	 * @param rowSize 페이지에 보여줄 row size
	 * @return
	 */
	public static Map<String,Object> getPageInfo(int totalCnt, DataMap requestMap){
    	int currPage = 1;
    	int rowSize = 0;
    	
    	try{
    		currPage = Integer.parseInt(requestMap.getString("currPage"));
    	}catch(NumberFormatException nfe){
    		currPage = 1;
    		requestMap.setInt("currPage", currPage);
    	}
    	try{
    		rowSize = Integer.parseInt(requestMap.getString("rowSize"));
    	}catch(NumberFormatException nfe){
    		rowSize = 10;
    	}
    	
    	return getPageInfo(totalCnt, currPage, rowSize);
	}
	
	public static Map<String,Object> getPageInfo(int totalCnt, int currPage, int rowSize){

		Map<String, Object> result = new HashMap<String, Object>();
		
		int start = 0;
		int end = 0;

	    if (currPage == 0) {
	        currPage = 1;
	    } 

		start = (currPage-1)*rowSize + 1;
		end = currPage*rowSize;
		
		result.put("totalCnt", totalCnt);
		result.put("currPage", currPage);
		result.put("start", start);
		result.put("end", end);
		result.put("rowSize", rowSize);
		
		return result;
	}
	public static PageNavigation getPageNavigation(Map<String,Object> pageInfo){
		
		int totalCnt = Integer.parseInt(pageInfo.get("totalCnt").toString());
		int rowSize = Integer.parseInt(pageInfo.get("rowSize").toString());
		int currPage = Integer.parseInt(pageInfo.get("currPage").toString());
		
		PageInfo pi = new PageInfo(totalCnt, rowSize, 0, currPage);

       	return PageFactory.getInstance(Constants.DEFAULT_PAGE_CLASS, pi);
	}
	
	public static int parseInt(Object obj){
		return parseInt(obj, 0);
	}
	public static int parseInt(Object str, int defaultValue){
		try{
			return Integer.parseInt(str.toString());
		}catch(Exception e){
			return defaultValue;
		}
	}
	public static Map<String, Object> getMapOfDataMapIdxZero(DataMap dataMap) {
		Map<String,Object> res = new HashMap<String, Object>();
		for(Object o : dataMap.keySet()){
			res.put(o.toString(), dataMap.get(o, 0));
		}
		return res;
	}
	public static Map valueToMap(Object...keyAndValues) {
		
		if(keyAndValues.length % 2 != 0){
			return null;
		}
		
		Map map = new HashMap();
		
		for(int i=0; i<keyAndValues.length; ++i){
			map.put(keyAndValues[i], keyAndValues[++i]);
		}
		return map;
	}
	
	public static String getClientIpAddr(HttpServletRequest request) { 
	    String ip = request.getHeader("X-Forwarded-For"); 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	    ip = request.getHeader("Proxy-Client-IP"); 
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	    ip = request.getHeader("WL-Proxy-Client-IP"); 
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	    ip = request.getHeader("HTTP_CLIENT_IP"); 
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	    ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	    ip = request.getRemoteAddr(); 
	    } 
	    return ip; 
	}
}






