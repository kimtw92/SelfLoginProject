<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 과정 설문 안내문 등록 / 수정 / 삭제
// date : 2008-09-18
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

	var grcode = "<%=requestMap.getString("grcode")%>";
	var grseq = "<%=requestMap.getString("grseq")%>";
	var searchKey = "<%=requestMap.getString("searchKey")%>";
	var searchValue = "<%=requestMap.getString("searchValue")%>";
	var currPage = "<%=requestMap.getString("currPage")%>";

	var url = "/poll/coursePoll.do?mode=guide_list&menuId="+menuId+"&grcode="+grcode+"&grseq="+grseq+"&searchKey="+searchKey+"&searchValue="+searchValue+"&currPage="+currPage;

	//메세지 출력
	alert(msg);
	location.href = url;
//-->
</script>