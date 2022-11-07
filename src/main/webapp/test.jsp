<%@page import="ut.lib.util.WebUtils"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="ut.lib.util.SpringUtils"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <% --%>
<!-- // String realpath = SpringUtils.getRealPath(request); -->
<!-- // String applicationpath = SpringUtils.getApplicationRealPath(); -->
<%-- %> --%>
<%-- <%=realpath%><br> --%>
<%-- <%=applicationpath%> --%>

<%

 
request.getServerName() + ":" + request.getServerPort()
%>

<%=request.getServerName() %>
<%=request.getServerPort() %>

