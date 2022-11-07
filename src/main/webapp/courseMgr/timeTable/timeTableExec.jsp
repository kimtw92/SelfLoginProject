<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 과목선택/과목수정/과목추가 / 일자별 삭제 / 초기화 실행
// date : 2008-07-31
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
	var studyWeek = "<%=requestMap.getString("studyWeek")%>";
	var searchKey = "<%=requestMap.getString("searchKey")%>";

	//메세지 출력
	alert(msg);

	var url = "/courseMgr/timeTable.do?mode=list&menuId=" + menuId + "&studyWeek=" + studyWeek + "&searchKey=" + searchKey;

	if(qu == "insert" || qu == "update" || qu == "add"){

		opener.location.href = url;
		window.close();

	}else{
		location.href = url;
	}


//-->
</script>