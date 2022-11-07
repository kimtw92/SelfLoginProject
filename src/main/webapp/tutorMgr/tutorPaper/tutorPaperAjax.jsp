<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// prgnm : 검색일자가 월요일인지, 금요일인지 체크
// date : 2008-08-20
// auth : 정 윤철
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

%>
<%=requestMap.getString("date")%>