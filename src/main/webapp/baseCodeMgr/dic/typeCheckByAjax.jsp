<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 용어분류코드 중복체크
// date  : 2008-05-28
// auth  : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

	String countTypes = "";
	
	if(rowMap != null){
		if(rowMap.keySize("countTypes") > 0){
			countTypes = rowMap.getString("countTypes");		
		}
	}

	System.out.println(rowMap.keySize("countTypes"));

%>
<%=countTypes%>