<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// prgnm : 강사레벨 코드중복체크(AJAX)
// date : 2008-07-09
// auth : 정 윤철
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
	//request
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);
	

%>
<%=requestMap.getString("count")%>