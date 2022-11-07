<%@ page contentType="text/javascript; charset=utf-8" pageEncoding="utf-8"
%><%
request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");
response.setContentType("text/javascript; charset=utf-8");

String userAgent = request.getHeader("User-Agent");
userAgent = (userAgent == null || "".equals(userAgent)) ? "navigator.userAgent" : "\"" + userAgent.replace("\"", "") + "\"";
%>/*
 ***************************************************************************
 * nProtect Online Security, 1.6.0
 *
 * For more information on this product, please see
 * http://www.inca.co.kr / http://www.nprotect.com
 *
 * Copyright (c) INCA Internet Co.,Ltd  All Rights Reserved.
 *
 * 본 코드에 대한 모든 권한은 (주)잉카인터넷에게 있으며 동의없이 사용/배포/가공할 수 없습니다.
 *
 ***************************************************************************
 */
var nua = <%= userAgent %>;
<%
String include = request.getParameter("i");
if(include != null && !"".equals(include)) {
	%>document.write("<script type=\"text/javascript\" src=\"<%= include %>\" charset=\"utf-8\"></script>");<%
}
%>