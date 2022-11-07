<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 과정기수관리 개설과정 추가 등록/삭제 실행.
// date : 2008-07-11
// auth : 이용문
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String result = Util.getValue((String)request.getAttribute("RESULT_DATA"), "1"); //기본값 1 성공
	String msg = (String)request.getAttribute("RESULT_MSG");

	
%>

<script language="JavaScript">
<!--
	//변수 및 파라미터 설정.
	var msg = "<%=msg%>";
	var menuId = "<%=requestMap.getString("menuId")%>";
	var qu = "<%=requestMap.getString("qu")%>";
	var result = "<%= result  %>";
	/*
	var url = "";
	if(rtn == "")
		url = "/courseMgr/courseSeq.do?mode=list&menuId="+menuId+"&year="+year;
	else
		url = rtn+"&menuId="+menuId+"&year="+year;
	*/

	//메세지 출력
	alert(msg);
	

	/*
	result > 0 는 성공
	실패시(result <= 0(상장번호가 더 작은지 머 그런경우는 msg만 출력
	*/
	 
	if(result > 0){ //성공시
		parent.go_print3('AWARD_PRINT');
		window.setTimeout( "parent.go_reload()" , 1000);
	}
	

	
	
	
//-->
</script>