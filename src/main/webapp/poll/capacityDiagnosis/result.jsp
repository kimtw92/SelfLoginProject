<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%
//request 데이터
DataMap requestMap = (DataMap)request.getAttribute("REQUES_DATA");
requestMap.setNullToInitialize(true);
%>
<body>
<script language="JavaScript" type="text/JavaScript">
	alert("<%=requestMap.getString("msg")%>");
	window.close();
</script>
</body>






