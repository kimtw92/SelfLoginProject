<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 과정기수관리의 개설과정 추가 등록/삭제 실행.
// date : 2008-05-22
// auth : 이용문
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String msg = (String)request.getAttribute("RESULT_MSG");
	String code = (String)request.getAttribute("RESULT_CODE");
	String name = (String)request.getAttribute("RESULT_NAME");

%>

<script language="JavaScript">
<!--
	//변수 및 파라미터 설정.
	var masGubun = "<%=requestMap.getString("masGubun")%>";
	var msg = "<%=msg%>";
	var returnCode = "<%=code%>";
	var returnName = "<%=name%>";
	
	//메세지 출력
	alert(msg);
	opener.set_returnStuMas(masGubun, returnCode, returnName);
	window.close();
//-->
</script>