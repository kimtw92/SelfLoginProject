<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%

	String reqMap = (String)request.getAttribute("strResult");
	out.println(reqMap);
	
%>

