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
<TITLE>:::: ���̺귯�� �ε� �׽�Ʈ ::::</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</HEAD>

<body>
���̺귯�� �ε� �׽�Ʈ ������ �Դϴ�. ^^
</BODY>
</HTML>
