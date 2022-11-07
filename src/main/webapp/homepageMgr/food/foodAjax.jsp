<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// prgnm :  식단관리 카운터체크
// date : 2008-08-06
// auth : 정 윤철
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
%>
<%=requestMap.getString("count")%>

