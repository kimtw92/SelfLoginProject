<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%

	String url = (String)request.getAttribute("url");
	out.println("<meta http-equiv=\"Refresh\" content='0; URL="+url+"'>");
%>
