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

%>

<script language="JavaScript">
<!--
	//변수 및 파라미터 설정.
	var msg = "<%=msg%>";
	var menuId = "<%=requestMap.getString("menuId")%>";
	var qu = "<%=requestMap.getString("qu")%>";
	var year = "<%=requestMap.getString("year")%>";
	var rtn = "<%=requestMap.getString("rtn")%>";
	var grseq = "<%=requestMap.getString("grseq")%>";
	
	var url = "";
	if(rtn == "")
		url = "/courseMgr/courseSeq.do?mode=list&menuId="+menuId+"&year="+year;
	else
		url = rtn+"&menuId="+menuId+"&year="+year;

	if(qu == "insert_form2")
		url = "/courseMgr/courseSeq.do?mode=grcode_form2&menuId="+menuId+"&grseq="+grseq;

	//메세지 출력
	alert(msg);
	location.href = url;
//-->
</script>