<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 설문 응답 등록 실행.
// date : 2008-09-23
// auth : LYM
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

	//변수 및 파라미터 설정. 
	var msg			= "<%=msg%>";
	var menuId		= "<%=requestMap.getString("menuId")%>";
	var qu			= "<%=requestMap.getString("qu")%>";
	var titleNo		= "<%=requestMap.getString("titleNo")%>";
	var setNo		= "<%=requestMap.getString("setNo")%>";

	//메세지 출력
	alert(msg);
	window.close();

</script>