<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>

<%
		String domains = "";

		Pattern regex1 = Pattern.compile(".dunet.co.kr"); 
		Pattern regex2 = Pattern.compile(".cyber.incheon.kr"); 
		
		Matcher regexMatcher1 = regex1.matcher(request.getServerName()); 
		Matcher regexMatcher2 = regex2.matcher(request.getServerName()); 
		if (regexMatcher1.find()) { 
			domains = ".dunet.co.kr";
		} else if (regexMatcher2.find()){ 
			domains = ".cyber.incheon.kr";
		} else {
			domains = ".incheon.go.kr";
		} 

		if(request.getParameter("mode").equals("login")) {
	        Cookie cookie = new Cookie("CMLMS", request.getParameter("cookie_no"));
	        cookie.setDomain(domains);
	        cookie.setPath("/");
			response.addCookie(cookie);
			
			if(cookie != null) {
				System.out.println("abc"+cookie.getName()+"abc");
			}
		}else if(request.getParameter("mode").equals("logout")) {
			Cookie[] cookies = request.getCookies();
			 for(int i=0; i< cookies.length; i++){
				Cookie cook = cookies[i];
				if(cook.getName().equals("CMLMS")) {
					cook.setPath("/");
					cook.setDomain(domains);
					cook.setMaxAge(0);
					response.addCookie(cook);
			    }
		     }
		}
%>

<html>
<head>
<script>
	function goUrl() {
		location.replace('<%=request.getParameter("url")%>')
	}
</script>
</head>
<body onload="goUrl();">

</body>
</html>
