<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 설문은행 설문 등록/수정/삭제 실행.
// date : 2008-09-26
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
	var msg      = "<%=msg%>";
	var menuId   = "<%=requestMap.getString("menuId")%>";
	var qu       = "<%=requestMap.getString("qu")%>";
	var currPage = "<%=requestMap.getString("currPage")%>"

	var url = url = "/poll/pollBank.do?mode=list&menuId=" + menuId + "&currPage=" + currPage;
		
	//메세지 출력
	alert(msg);
	location.href = url;
	
//-->
</script>