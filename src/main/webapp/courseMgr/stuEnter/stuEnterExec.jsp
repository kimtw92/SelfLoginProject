<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 교육생 직접 입력 및 교육생 정보 수정 처리.
// date : 2008-06-30
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

	//메세지 출력
	alert(msg);
	if(qu == "app_update"){
		url = "/courseMgr/stuEnter.do?mode=list&menuId="+menuId;
		opener.location.href = url;
		window.close();
	}else if(qu == "reenter" || qu == "approval"){
		location.href = "/courseMgr/stuEnter.do?mode=approval_list&menuId="+menuId;
	}else{
		location.href = "/courseMgr/stuEnter.do?mode=form&menuId="+menuId;
	}

//-->
</script>