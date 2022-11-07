<%@page import="ut.lib.support.DataMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

DataMap requestMap = (DataMap) request.getAttribute("REQUEST_DATA");

int res = (Integer) request.getAttribute("res");

%>
<%=res%>명의 답안지가 복구되었습니다.\n

