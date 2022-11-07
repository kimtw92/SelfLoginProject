<%@ page language="java" import="java.io.*,java.net.*" contentType="text/xml; charset=utf-8"  pageEncoding="utf-8"%>

<%
String user_id = nukkCheck(request.getParameter("user_id"));
String user_name = new String(URLDecoder.decode(nukkCheck(request.getParameter("user_name")),"UTF-8"));
String user_email = nukkCheck(request.getParameter("user_email"));
String user_hp1 = nukkCheck(request.getParameter("hp1"));
String user_hp2 = nukkCheck(request.getParameter("hp2"));
String user_hp3 = nukkCheck(request.getParameter("hp3"));
String user_birthday = nukkCheck(request.getParameter("user_birthday"));
String user_sex = nukkCheck(request.getParameter("user_sex"));
String user_area = new String(URLDecoder.decode(nukkCheck(request.getParameter("user_area")),"UTF-8"));
String user_no = nukkCheck(request.getParameter("user_no"));
String join = nukkCheck(request.getParameter("join"));

try {
	user_name = URLEncoder.encode(user_name, "euc-kr");
} catch(Exception e) {
	user_name = "";
}

try {
	user_area = URLEncoder.encode(user_area, "euc-kr");
} catch(Exception e) {
	user_area = "";
}


String postURL = "http://eg21.co.kr/incheonsimin/sso_userExe.asp";


String paramURL = "user_id="+user_id+"&user_name="+user_name+"&user_email="+user_email+"&hp1="+user_hp1+"&hp2="+user_hp2+"&hp3="+user_hp3+"&user_birthday="+user_birthday+"&user_sex="+user_sex+"&user_area="+user_area+"&user_no="+user_no+"&join="+join;

out.println(excutePost(postURL, paramURL));

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