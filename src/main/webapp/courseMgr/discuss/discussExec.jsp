<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 과정 토론방 등록/수정/삭제/답변 실행
// date : 2008-07-10
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
<!--
	//변수 및 파라미터 설정. 
	var msg			= "<%=msg%>";
	var menuId		= "<%=requestMap.getString("menuId")%>";
	var searchKey	= "<%=requestMap.getString("searchKey")%>";
	var searchValue	= "<%=requestMap.getString("searchValue")%>";
	var qu			= "<%=requestMap.getString("qu")%>";

	var moreStr = "";
	if( qu == 'update' || qu == 'reply')
		moreStr = "&searchKey="+searchKey+"&searchValue="+searchValue;
	var url = "/courseMgr/discuss.do?mode=list&menuId="+menuId + moreStr;

	//메세지 출력
	alert(msg);
	location.href = url;
//-->
</script>