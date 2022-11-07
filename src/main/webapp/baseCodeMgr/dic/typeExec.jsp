<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 용어분류코드 저장시 처리 페이지
// date  : 2008-05-28
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String menuId = requestMap.getString("menuId");
	
	// 처리 메세지
	String msg = (String)request.getAttribute("RESULT_MSG");
	// 처리 구분
	String resultType = (String)request.getAttribute("RESULT_TYPE");
	
%>

<script language="JavaScript" type="text/JavaScript">

	switch("<%=resultType%>"){
	
		case "ok":
			alert("<%= msg %>");
			var param = "?mode=typeList";
			param += "&menuId=<%=menuId%>";
			window.opener.location.href="dic.do" + param;
			self.close();
			break;
			
		case "saveError":			
		case "pkError":
			alert("<%=msg%>");
			history.back();
			break;
	}

</script>