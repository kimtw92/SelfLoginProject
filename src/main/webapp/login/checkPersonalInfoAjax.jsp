<%
	String result = "";
	result = (String)request.getAttribute("result");

	
	if(result.equals("1")) {
		out.print("YES");
	}else {
		out.print("NO");	
	}
%>