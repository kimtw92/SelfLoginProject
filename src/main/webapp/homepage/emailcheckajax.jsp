<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="ut.lib.support.DataMap" %><%
	DataMap requestMap = (DataMap)request.getAttribute("EMAIL_YN");
	requestMap.setNullToInitialize(true);
	
	if(requestMap.keySize("count") > 0) {
		if("1".equals(requestMap.getString("count", 0)) || "2".equals(requestMap.getString("count", 0))) {
			out.println("1");
		}else {
			out.println("0");
		}
	}	else {
		out.println("2");
	}
%>