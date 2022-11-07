<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.dreamsecurity.eam.gpki.pmi.*, java.util.*, java.io.*, java.lang.*, java.text.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../common/include/SSOInit.jsp" %>

<%
        int nRet = 0;
        MGApiJni mgApi = new MGApiJni();                              
        nRet = mgApi.getCert(MG_CERT_INFO);
%>
<HTML>
<HEAD>
<TITLE>:::: 라이브러리 로딩 테스트 ::::</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</HEAD>

<body>
라이브러리 로딩 테스트 페이지 입니다. ^^
</BODY>
</HTML>
