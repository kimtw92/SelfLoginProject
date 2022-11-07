<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 개인공지 관리 등록/수정/삭제 실행.
// date : 2008-05-23
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

	var year = "<%=requestMap.getString("year")%>";
	var url = "/commonMgr/notice.do?mode=list&menuId=7-1-1";

	//메세지 출력
	alert(msg);
	location.href = url;
//-->
</script>