<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 과정기수관리의 과목 등록 실행.
// date : 2008-06-18
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
	var grcode = "<%= requestMap.getString("grcode") %>";
	var grseq = "<%= requestMap.getString("grseq") %>";
	
	var url = "/courseMgr/courseSeq.do?mode=list&menuId="+menuId+"&year="+year;

	//메세지 출력
	alert(msg);
	if(qu == "insert" || qu == "insert_copy"){
		url = url + "&grcode="+grcode+"&grseq="+grseq;
		opener.location.href = url;
		window.close();
	}else if(qu == "update"){
		location.href = url;
	}
//-->
</script>