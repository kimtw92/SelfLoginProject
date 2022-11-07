<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ page import="ut.lib.support.DataMap" %>
<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	out.print(requestMap.getString("Msg").trim());
%>


