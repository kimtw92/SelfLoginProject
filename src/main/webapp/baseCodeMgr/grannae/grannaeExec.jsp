<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 교육계획 코드 등록/수정/삭제 실행.
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

	var year = "<%=requestMap.getString("year")%>";
	var url = "/baseCodeMgr/grannae.do?mode=list&menuId="+menuId+"&year="+year;
	
	//메세지 출력
	alert(msg);
	if(qu != 'ALL' && qu != 'ONE') { //교육계획 복사가 아니면.
		location.href = url;
	}else{
		window.close();
		opener.location.href = url;
	}
//-->
</script>