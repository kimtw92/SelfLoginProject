<%
	String result = "";
	result = (String)request.getAttribute("result");

	if(result.equals("1") || result.equals("2") || result.equals("4") || result.equals("5")) {
		out.print("YES");
	//}else if(result.equals("2")) {
	//	out.print("UNDER");
	}else if(result.equals("1000")) {
		out.print("REJOIN");
	}else {
		out.print("NO");	
	}
%>