<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
// prgnm : 설문 등록
// date : 2008-09-30
// auth : 최종삼
%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<%
    //request 데이터
	String  Msg = (String)request.getAttribute("Msg");
%>
  <SCRIPT LANGUAGE="JavaScript">
  <!--
    //메시지 
	alert("<%=Msg%>");
	window.close();
  //-->
  </SCRIPT>
