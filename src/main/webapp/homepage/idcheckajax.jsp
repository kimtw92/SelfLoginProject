<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="ut.lib.support.DataMap" %><%
	DataMap requestMap = (DataMap)request.getAttribute("JOIN_YN");
	requestMap.setNullToInitialize(true);
	
	if(requestMap.keySize("count") > 0) {
		if(requestMap.getString("count", 0).equals("1")) {
			out.println("1");
		}else {
			out.println("0");
		}
	}	else {
		out.println("2");
	}
%>