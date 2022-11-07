<%@ page language="java" import="java.io.*,java.net.*,ut.lib.security.StringEncrypter2" contentType="text/xml; charset=utf-8"  pageEncoding="utf-8"%>

<%

String ID = nukkCheck(request.getParameter("ID"));
String NAME = new String(URLDecoder.decode(nukkCheck(request.getParameter("NAME")),"UTF-8"));
String JOIN = nukkCheck(request.getParameter("JOIN"));
String EMAIL = nukkCheck(request.getParameter("EMAIL"));
String HP1 = nukkCheck(request.getParameter("HP1"));
String HP2 = nukkCheck(request.getParameter("HP2"));
String HP3 = nukkCheck(request.getParameter("HP3"));
String COMPANY_BU = new String(URLDecoder.decode(nukkCheck(request.getParameter("COMPANY_BU")),"UTF-8"));
String COMPANY_JIKGUB = new String(URLDecoder.decode(nukkCheck(request.getParameter("COMPANY_JIKGUB")),"UTF-8"));
String COMPANY_NAME = new String(URLDecoder.decode(nukkCheck(request.getParameter("COMPANY_NAME")),"UTF-8"));
String SEX = nukkCheck(request.getParameter("SEX"));


StringEncrypter2 stringEncrypter2 = new StringEncrypter2("incheon", "cyber");
/*

HP1 = stringEncrypter2.encrypt(HP1);
HP2 = stringEncrypter2.encrypt(HP2);
HP3 = stringEncrypter2.encrypt(HP3);
EMAIL = stringEncrypter2.encrypt(EMAIL);
COMPANY_BU = stringEncrypter2.encrypt(COMPANY_BU);
COMPANY_JIKGUB = stringEncrypter2.encrypt(COMPANY_JIKGUB);
COMPANY_NAME = stringEncrypter2.encrypt(COMPANY_NAME);
*/
ID = URLEncoder.encode(ID, "utf-8");
NAME = URLEncoder.encode(NAME, "utf-8");
JOIN = URLEncoder.encode(JOIN, "utf-8");
EMAIL = URLEncoder.encode(EMAIL, "utf-8");
HP1 = URLEncoder.encode(HP1, "utf-8");
HP2 = URLEncoder.encode(HP2, "utf-8");
HP3 = URLEncoder.encode(HP3, "utf-8");
COMPANY_BU = URLEncoder.encode(COMPANY_BU, "utf-8");
COMPANY_JIKGUB = URLEncoder.encode(COMPANY_JIKGUB, "utf-8");
COMPANY_NAME = URLEncoder.encode(COMPANY_NAME, "utf-8");
SEX = URLEncoder.encode(SEX, "utf-8");

String paramURL = "ID=" + ID + "&NAME=" + NAME+ "&JOIN=" + JOIN + "&EMAIL=" + EMAIL + "&HP1=" + HP1 + "&HP2=" + HP2 + "&HP3=" + HP3 + "&COMPANY_BU=" + COMPANY_BU + "&COMPANY_JIKGUB=" + COMPANY_JIKGUB + "&COMPANY_NAME=" + COMPANY_NAME + "&SEX=" + SEX;


//out.println(excutePost("http://www.learnnrun.com/incheon/checkm", paramURL));
out.println(excutePost("http://hrd.rosettakorea.com/incheon/checkm", paramURL));




%>

<%!
 public static String excutePost(String targetURL, String urlParameters)  {   
		URL url;   
		HttpURLConnection connection = null;  
		InputStream is = null;
		try { 
		url = new URL(targetURL);    
		connection = (HttpURLConnection)url.openConnection();    
		connection.setRequestMethod("POST");     
		connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		connection.setRequestProperty("Content-Length", "" + Integer.toString(urlParameters.getBytes().length)); 
		connection.setRequestProperty("Content-Language", "en-US");
		connection.setUseCaches (false);
		connection.setDoInput(true);  
		connection.setDoOutput(true);
		DataOutputStream wr = new DataOutputStream (connection.getOutputStream ());
		wr.writeBytes (urlParameters);
		wr.flush ();
		wr.close (); 
		is = connection.getInputStream();
		BufferedReader rd = new BufferedReader(new InputStreamReader(is));
		String line;
		StringBuffer response = new StringBuffer();
		while((line = rd.readLine()) != null) { 
			response.append(line); 
			response.append('\r'); 
		} 
			rd.close(); 
			return response.toString();  
		} catch (Exception e) {     
			e.printStackTrace();     
			return null;    
		} finally { 
			try {
				if(is != null) { 
					is.close();   
				}  
			} catch(Exception e) {
			}
			if(connection != null) { 
				connection.disconnect();   
			}  
 		} 
  }

	public static String nukkCheck(String data)  {   
		if(data == null || "".equals(data)) {
			return "";
		} else {
			return data;
		}

	}
%>