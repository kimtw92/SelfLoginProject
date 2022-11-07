<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 강사지정 처리 페이지
// date  : 2008-07-02
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String mode = requestMap.getString("mode");
	
	// 메뉴ID
	String menuId = requestMap.getString("menuId");
	
	// 처리 메세지
	String msg = (String)request.getAttribute("RESULT_MSG");
	
	// 처리 구분
	String resultType = (String)request.getAttribute("RESULT_TYPE");
	
	String param = "";
	
	if(mode.equals("update")){
		param = "&currPage=1";
		param += "&searchSubj=" + requestMap.getString("searchSubj");
	}
	
%>

<script language="JavaScript" type="text/JavaScript">

	var param = "";

	switch("<%=resultType%>"){
				
		case "chkErr":
			// 중복체크
			alert("<%=msg%>");
			history.back();
			break;
			
		case "ok":
			alert("<%=msg%>");
			location.href="/tutorMgr/tclass.do?mode=list&menuId=<%=menuId%><%= param %>";
			break;
								
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;
	}
	

</script>