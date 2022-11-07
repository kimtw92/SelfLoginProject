<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : left menu 진행과정, 전체과정 변경시 세션저장
// date : 2008-05-14
// auth : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%
	String gubun = Util.getValue( (String)session.getAttribute("sess_gubun") );
%>
<%= gubun %>