<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 주민등록번호, 아이디 중복체크용
// date  : 2008-06-23
// auth  : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	
	// 처리 결과
	String retValue = (String)request.getAttribute("RESULT_VALUE");
	
	
%>
<%=retValue%>
