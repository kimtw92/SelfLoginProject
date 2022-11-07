<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 과정 질문 수정/답변등록/답변수정 실행
// date : 2008-07-09
// auth : 이용문
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String msg = (String)request.getAttribute("RESULT_MSG");

%>

<script language="JavaScript">
<!--
	//변수 및 파라미터 설정.
	var msg = "<%=msg%>";
	var menuId = "<%=requestMap.getString("menuId")%>";
	var qu = "<%=requestMap.getString("qu")%>";

	var url = "";
	url = "/courseMgr/question.do?mode=list&menuId="+menuId;

	//메세지 출력
	alert(msg);
	//location.href = url;
	history.go(-3);
//-->
</script>