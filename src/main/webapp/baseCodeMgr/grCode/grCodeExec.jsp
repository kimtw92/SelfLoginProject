<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 과정 코드 등록/수정/삭제 실행.
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
	var currPage = "<%=requestMap.getString("currPage")%>";
	var searchKey = encodeURI("<%=requestMap.getString("searchKey")%>");
	var searchValue = encodeURI("<%=requestMap.getString("searchValue")%>");
	var grcode = "<%=requestMap.getString("grcode")%>";

	var url = "/baseCodeMgr/grCode.do?menuId="+menuId+"&currPage="+currPage+"&searchKey="+searchKey+"&searchValue="+searchValue;

	//구분에 따라 부모페이지 제어.
	if(qu == "insert"){
		url += "&mode=list";
	}else if(qu == "update"){
		url += "&mode=form&qu=update&grcode="+grcode;
	}else if(qu == "delete"){
		url += "&mode=list";
	}
	//alert(url);

	//메세지 출력
	alert(msg);
	location.href = url;
//-->
</script>