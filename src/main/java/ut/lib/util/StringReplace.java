/*******************************************************************************
 * Title        : StringReplace.java
 * @author      : ???
 * @date        : 2002.05.28
 * @version     : 1.1
 * @Description : 스트링내의 임의의 문자열을 새로운 문자열로 대치하는 클래스
 *
 * @Copyright   : Neomoney Co., Ltd.
 *******************************************************************************
 * 수정일       수정자  수정사유
 * 2002.06.05   김정태  static 메소드로 변경
 * 2002.08.28   홍상진  convertTxt2Tag 추가
 * 2002.08.29   홍상진  convertTxt2Tag 메소드에 " -> &quot; 기능 추가
 * 2002.08.28   홍기영  token 추가
******************************************************************************/

package ut.lib.util;


public class StringReplace {

    /**
     * "<",">","\r","\n" 을 html 코드로 변환 한다.
     *
     * @param st_content     text
     * @return 변경된 문자열
     */
    public static String convertTxt2Tag(String st_content)
    {
        st_content = change(st_content, "<","&lt;");
        st_content = change(st_content, ">","&gt;");
        st_content = change(st_content, "\"","&quot;");
        st_content = change(st_content, "'","''");
        st_content = change(st_content, "\n","<br>");
        st_content = change(st_content, "\r","");

        return st_content ;
    }


	public static String convertHtmlDecode(String htmlstr){
		String convert = new String();
		convert = change(htmlstr, "&lt;", "<");
		convert = change(convert, "&gt;", ">");
		convert = change(convert, "&quot;", "\"");
		convert = change(convert, "&amp;nbsp;", "&nbsp;");
		return convert;
	}
	
	public static String convertHtmlEncode(String htmlstr){
		String convert = new String();
		convert = change(htmlstr, "<", "&lt;");
		convert = change(convert, ">", "&gt;");
		convert = change(convert, "\"", "&quot;");
		convert = change(convert, "&nbsp;", "&amp;nbsp;");
		return convert;
	}
	

	public static String convertHtmlDecodeNamo(String htmlstr){
		String convert = new String();
		convert = change(htmlstr, "&lt;", "<");
		convert = change(convert, "&gt;", ">");
		convert = change(convert, "\\'", "'"); //2008.08.25 수정 수료증HTML관리의 ' 문자 때문에 추가 
		convert = change(convert, "&quot;", "\"");
		convert = change(convert, "&amp;nbsp;", "&nbsp;");
		return convert;
	}
	
	public static String convertHtmlEncodeNamo(String htmlstr){
		String convert = new String();
		convert = change(htmlstr, "<", "&lt;");
		convert = change(convert, ">", "&gt;");
		return convert;
	}
	public static String convertHtmlEncodeNamo2(String htmlstr){
		String convert = new String();
		convert = change(htmlstr, "<", "&lt;");
		convert = change(convert, ">", "&gt;");
		convert = change(convert, "\"", "&quot;");
		convert = change(convert, "\\'", "'");
		convert = change(convert, "&nbsp;", "&amp;nbsp;");
		return convert;
	}

    /**
     * 스트링내의 임의의 문자열을 새로운 문자열로 대치하는 메소드
     *
     * @param source    스트링
     * @param before    바꾸고자하는 문자열
     * @param after     바뀌는 문자열
     * @return 변경된 문자열
     */
    public static String change(String source, String before, String after) {
        int i = 0;
        int j = 0;
        StringBuffer sb = new StringBuffer();

        while ((j = source.indexOf(before, i)) >= 0) {
            sb.append(source.substring(i, j));
            sb.append(after);
            i = j + before.length();
        }

        sb.append(source.substring(i));
        return sb.toString();
    }

    /**
     * 캐리지 리턴값을 체크 컨버젼
     *
     * @param comment 캐리지 리턴값을 체크할 문자열
     * @return 캐리지 리턴값이 변환된 문자열(br tag로 변환)
     */
    public static String convertHtmlBr(String comment) {
     	
        int length = comment.length();
        StringBuffer buffer = new StringBuffer();

        for (int i = 0; i < length; ++i) {
            String comp = comment.substring(i, i+1);

            /** 2008-07-09 이용문 <br>이 두번들어가서 주석 처리 
            if ("\r".compareTo(comp) == 0) {
                comp = comment.substring(++i, i+1);

                if ("\n".compareTo(comp) == 0) {
                    buffer.append("<BR>\r");
                }

                else {
                    buffer.append("\r");
                }
            }
            */

            if ("\n".compareTo(comp) == 0) {
                if (i < length-1) {
                    comp = comment.substring(++i, i+1);
                    buffer.append("<BR>\r");
                }
            }

            buffer.append(comp);
        }
        return buffer.toString();
        
    	
    }


    /**
     * null값을 체크해서 지정된 문자열로 대체.
     *
     * @param param 변환할 문자열
     * @param newParam 변환된 문자열
     * @return 널 대체 문자열
     */
    public static String nvl(String param,String newParam) {

        if (param == null ||
            param.equals("") ||
            param.length() == 0 ||
            param.equals("null")) {

            String reParam = newParam;
            return reParam;

        }

        else {
            return param;
        }
    }

    /**
     * 지정한 길이만큼의 문자열만 추출해서 보여주되 끝부분은 ...으로
     * 대체
     *
     * @param str 대체할 문자열
     * @param len 보여줄 문자열의 길이
     * @return 바뀐 문자열
     */
    public static String subStringPoint(String str , int len) {

        if (str.length() <= len) {
            return str;
        }

        str = str.substring(0 , len - 3);
        str = str + "...";

        return str;
    }



    /**
     * 지정된 Token으로 지정한 위치의 문자열을 리턴
     *
     * @param str 원시문자열
     * @param delim 분리될Token
     * @param ipos 분리된 문자열 위치
     * @return 분리된 문자열
     */
    public static String token(String str, String delim, int ipos) {
		int i;
		int ilen = str.length();
		int idel = delim.length();
		int ista = 0, iend = 0, isee = 0;

		for (i=0; i<ilen; i++) {
			String ss2 = str.substring(i,idel+i);
			if (ss2.equals(delim)) {

				if (isee == 0)
					ista = 0;
				else
					ista = iend+1;

				iend = i;
				if (ipos == isee) {
					return str.substring(ista, iend);
				}
				isee++;
			}
		}
		if (isee == 0) {
			return str;
		}
		if (i == ilen) {
			ista = iend+1;
			iend = ilen;
			return str.substring(ista, iend);
	    }

        return "";
    }

    /**
     * Replace 특정문자를 새로운 문자로 대체한다.
     * @param original
     * @param oldstr
     * @param newstr
     * @return
     */
	public static String replaceStr(String original, String oldstr, String newstr)
	{
		String convert = new String();
		int pos = 0;
		int begin = 0;
		pos = original.indexOf(oldstr);

		if(pos == -1)
			return original;

		while(pos != -1)
		{
			convert = convert + original.substring(begin, pos) + newstr;
			begin = pos + oldstr.length();
			pos = original.indexOf(oldstr, begin);
		}
		convert = convert + original.substring(begin);

		return convert;
	}
	
	/**
	 * Html로 이루어진 내용을 웹에디터창에 넣을때 사용함.
	 * @param contents
	 * @return
	 */
	public static String convertContentToWebEdit(String contents){
		
		String data = replaceStr(contents, "\n", "<br>");
		//data = replaceStr(data, "\r", "");		
		data = replaceStr(data, "\"", "'");
		
		return data;
	}
	
	/**
	 * 원하는 SubString 형태로 잘라준다
	 * Exception 처리를 위해.
	 * @param htmlStr
	 * @param startIdx
	 * @param endIdx
	 * @return
	 */
	public static String subString(String htmlStr, int startIdx, int endIdx){

		
		if(htmlStr == null || htmlStr.equals("") || htmlStr.length() <= 0)
			return "";
		
		if( startIdx > htmlStr.length() )
			return "";
		
		if( endIdx > htmlStr.length() )
			return subString(htmlStr, startIdx);
			
		
		String returnValue = htmlStr;
		try{
			returnValue = htmlStr.substring(startIdx, endIdx);
		}catch(Exception e){}
		
		
		return returnValue;
	}

	/**
	 * 원하는 SubString 형태로 잘라준다
	 * Exception 처리를 위해.
	 * @param htmlStr
	 * @param startIdx
	 * @return
	 */
	public static String subString(String htmlStr, int startIdx){

		
		if(htmlStr == null || htmlStr.equals("") || htmlStr.length() <= 0 || htmlStr.length() < startIdx)
			return "";
		
		String returnValue = htmlStr;
		try{
			returnValue = htmlStr.substring(startIdx);
		}catch(Exception e){}
		
		
		return returnValue;
	}
	
}
