<%
	String result = "hahaha";

	if(request.getAttribute("passwordisnull") == null) {
		result = "null";
	}

	//result = (String)request.getAttribute("passwordisnull");
	
	if(result.equals("null")) {
		out.print("YES");
	}else {
		out.print("NO");	
	}
%>