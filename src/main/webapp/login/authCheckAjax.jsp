<%
	String result = "";
	result = (String)request.getAttribute("result");

	
	if(result.equals("1") || result.equals("4")) {
		out.print("YES");
	} else if(result.equals("1000")) {
		out.print("REJOIN");
	} else if(result.equals("2")) {
		out.print("CHECKNOPASS");
	} else {
		out.print("NO");	
	}
%>

