<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// prgnm : 주어진 일자가 월요일인지 체크(AJAX)
// date : 2008-07-15
// auth : 정 윤철
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

%>
<%=requestMap.getString("date")%>