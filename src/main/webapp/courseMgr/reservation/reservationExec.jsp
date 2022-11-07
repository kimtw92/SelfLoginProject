<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 시설임대관리 > 관리자SMS 등록/삭제 실행 후 처리
// date  : 2010-03-24
// auth  : hwani
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
	var msg    = "<%=msg%>";
	var menuId = "<%=requestMap.getString("menuId")%>";
	var qu     = "<%=requestMap.getString("qu")%>";

	var url = "";
	url = "/courseMgr/reservation.do?mode=list&menuId="+menuId;


	//메세지 출력
	//alert(msg);
	location.href = url;
//-->
</script>