<%
	String result = "";

	result = (String)request.getAttribute("resultnum");
	
	if(result.equals("1")) {
		out.print("YES");
	}else {
		out.print("NO");	
	}
%>