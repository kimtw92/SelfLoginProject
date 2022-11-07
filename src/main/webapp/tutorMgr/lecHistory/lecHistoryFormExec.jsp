<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 강의기록 처리 페이지
// date  : 2008-07-14
// auth  : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

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
	
	
	String userno = requestMap.getString("userno");
	
	
	if(!mode.equals("delete")){
%>
<script language="JavaScript" type="text/JavaScript">

	var param = "";

	switch("<%=resultType%>"){
				
		case "insertOk":
			alert("<%=msg%>");
			opener.fnDetailAjax("<%= userno %>");
			self.close();
			break;
			
		case "updateOk":
			alert("<%=msg%>");
			opener.fnDetailAjax("<%= userno %>");
			self.close();
			break;
			
			
		case "dupErr":
		case "mondayErr":		
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;
	}
</script>
<% } %>
<%= msg %>