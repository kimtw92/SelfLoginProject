<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr"%>
<%@ page import="ut.lib.util.* "%>
<%
	String errorCode = Util.getValue((String)request.getAttribute("errorCode"),"");
	String errorMsg = Util.getValue((String)request.getAttribute("errorMsg"),"");
%>
<script language = "javascript"> 
	<!--
		var errorCode = "<%=errorCode%>";
		var errorMsg = "<%=errorMsg%>";
		alert(errorMsg);
		if(errorCode > 0) {
			document.location.href = "/homepage/lecturer.do?mode=lecturerSearch";
		} else {
			history.back(-1);			
		}
	//-->
</script>