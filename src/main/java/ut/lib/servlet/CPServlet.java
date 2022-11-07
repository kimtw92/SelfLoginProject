package ut.lib.servlet;

import java.io.*;
import java.net.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.StringTokenizer;

public class CPServlet extends HttpServlet{
    public CPServlet() {
    }

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	//response.setContentType("text/html; charset=euc-kr");
	    PrintWriter out = response.getWriter();
        String paramStr = request.getParameter("paramStr");
        if (paramStr.indexOf("_PF3-") != -1) paramStr = strReplace(paramStr,"_PF3-","?");
        if (paramStr.indexOf("_P26-") != -1) paramStr = strReplace(paramStr,"_P26-","&");
        if (paramStr.indexOf(" ") != -1)     paramStr = strReplace(paramStr," ","%20");
        String output = getAIScript(toKor(paramStr));
        out.println(output);
	}

	public String getAIScript(String arg) {
	    String[] args = gubunReport(arg);
		StringBuffer buf = new StringBuffer();
		String repStr = "";
		int endIndex = args.length - 1;
		int curMaxPageNum = 0;
		int incrementNum = 0;
		try {
			for(int i=0;i<args.length;i++){
				if (i != 0) {
					repStr = getUrlData(args[i]);
					if (endIndex != i) {
					    repStr = delStr(repStr,false,false,incrementNum);
					    incrementNum = numMax(repStr);
					}else{
					    repStr = delStr(repStr,false,true,incrementNum);
					}
				} else {
					repStr = getUrlData(args[i]);
					if (endIndex != i) {
					    repStr = delStr(repStr,true,false,incrementNum);
					    incrementNum = numMax(repStr);
					}
				}
				buf.append(repStr);
			}
			repStr = buf.toString();
            //System.out.println(repStr);
		}catch(Exception e){
			e.printStackTrace();
		}
		return repStr;
	}

    // ���� ����
    private String[] gubunReport(String strAll) {
        int ch;
        int max = 0;
        for(int c = 0; c < strAll.length(); c++) {
            ch = strAll.charAt(c);
            if (ch == ',') max++;
        }
        max++;
        String[] arrStr = new String[max];
        StringTokenizer st = new StringTokenizer(strAll,",");
        int i = 0;
        while (st.hasMoreTokens()) {
            arrStr[i] = st.nextToken();
            i++;
        }
        return arrStr;
    }
    
    // �ش� URL ������ �޾ƿ���
	private String getUrlData(String strIn) throws MalformedURLException, IOException{
		URL url = new URL(strIn);
		StringBuffer buf = new StringBuffer();
		int ch;
		
		InputStream urlIn = url.openStream();
		if (urlIn != null) {
			do {
				ch = urlIn.read();
				if (ch != -1) buf.append((char)ch);
			}while(ch != -1);
			urlIn.close();
		}
		
		return buf.toString();
	}
	
	// ��ũ��Ʈ ����
    private String delStr(String strAll,boolean startScript,boolean endScript,int incrementNum) {
        String startStr = "--SCRIPT_START";
        String endStr = "--SCRIPT_END--";
        String pageStr = "PAGE --";
        StringBuffer buf = new StringBuffer();
        int ch;
        int size = strAll.length();
        int startPos = 0;
        String tmpStr = "";
        int indexNum;
        for (int i=0; i<size; i++) {
			ch = strAll.charAt(i);
			if (ch == 13) {
			    tmpStr = strAll.substring(startPos,i);
			    
			    if (tmpStr.indexOf(startStr) != -1 && startScript) {
			        tmpStr = tmpStr + "\r\n--PAPER_INFO--";
			    }
			    if (tmpStr.indexOf(startStr) != -1 && startScript == false) {
			        tmpStr = "--PAPER_INFO--";
			    }
			    if (tmpStr.indexOf(endStr) != -1 && endScript == false) {
			        tmpStr = "";
			    }
			    if ((indexNum = tmpStr.indexOf(pageStr)) != -1) {
			        tmpStr = "-- " + (Integer.parseInt(tmpStr.substring(3,indexNum).trim()) + incrementNum) + " PAGE --";
			    }
			    buf.append(tmpStr+"\r\n");
			    startPos = i+1;
			}
        }
        return buf.toString();
    }

    // ������ �ִ� ��������ȣ ����
    private int numMax(String strAll) {
        String delStr = " PAGE --";
        int ch;
        int size = strAll.length();
        int startPos = 0;
        int indexNum;
        int tmpNum = 0;
        int maxNum = 0;
        String tmpStr = "";
        for (int i=0; i<size; i++) {
			ch = strAll.charAt(i);
			if (ch == 13) {
			    tmpStr = strAll.substring(startPos,i);
			    if ((indexNum = tmpStr.indexOf(delStr)) != -1) {
			        tmpStr = tmpStr.substring(4,indexNum);
			        tmpNum = Integer.parseInt(tmpStr);
			        if (maxNum < tmpNum) maxNum = tmpNum;
			    }
			    startPos = i+1;
			}
	    }
	    return maxNum;
    }	
    	
	// ��������� replace�޼ҵ�
	private String strReplace(String strAll, String strSrc, String strDest) {
		int size = strAll.length();
		int len = strSrc.length();
		int pointer = -1;
		int st = 0;
		StringBuffer buf = new StringBuffer(size);	
	    	  
		while ((pointer = strAll.indexOf(strSrc, pointer)) != -1) {
		    buf.append(strAll.substring(st, pointer));
		    buf.append(strDest);
		    pointer += len;
		    st = pointer;
		}
		
		if (st < size) {
		    buf.append(strAll.substring(st));
		}
		
		return buf.toString();
	}	
	
	// �ѱ����ڵ�
    final String toKor (String en){
		if(en==null){
			return "";
		}
		try{
			return new String(en.getBytes("8859_1"), "KSC5601");
		}catch(Exception e){return en;}
	}	
}