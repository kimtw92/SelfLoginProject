<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 메뉴 등록 페이지.
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String msg = (String)request.getAttribute("RESULT_MSG");
	String refresh = (String)request.getAttribute("RESULT_REFRESH");
%>

<script language="JavaScript" type="text/JavaScript">
    var msg = "<%=msg%>";
	var menuId = "<%=requestMap.getString("menuId")%>";
	var menuGrade = "<%=requestMap.getString("menuGrade")%>";
	var refresh = "<%=refresh%>";

    alert(msg);
    //if (refresh == "Y"){
        location.href="/baseCodeMgr/menu.do?mode=list&search=GO&menuGrade="+menuGrade+"&menuId="+menuId;
	//}else{
	//	location.href="/baseCodeMgr/menu.do?mode=list&menuId="+menuId;
	//}
</script>