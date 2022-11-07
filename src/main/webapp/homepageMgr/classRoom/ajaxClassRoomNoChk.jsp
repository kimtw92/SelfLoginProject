<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// prgnm : 계정관리의 부서코드 셀렉트  박스 리스트(AJAX)
// date : 2008-05-29
// auth : 정 윤철
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
	//request
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
%>
<%=requestMap.getString("count")%>
