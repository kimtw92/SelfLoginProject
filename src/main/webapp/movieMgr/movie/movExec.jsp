<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 동영상강의 입력/수정 실행
// date  : 2009-06-03
// auth  : hwani
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String msg  = (String)request.getAttribute("RESULT_MSG");
	
	//DataMap resultMap = (DataMap)request.getAttribute("RESULT_MAP");
	//resultMap.setNullToInitialize(true);
	
%>

<script language="JavaScript">
<!--
	//변수 및 파라미터 설정.
	var msg 	= "<%=msg%>";
	var menuId 	= "<%=requestMap.getString("menuId")%>";
	var qu 		= "<%=requestMap.getString("qu")%>";
	var mode 	= "<%=requestMap.getString("mode")%>";
	var url 	= "";
	
	if("contExec" == mode) {
		mode = "contList";
		var divCode = "<%=requestMap.getString("divCode")%>";
		url = "/movieMgr/movie.do?mode=" + mode + "&divCode=" + divCode + "&menuId=" + menuId;
		 
	} else if("updateCmiTime" == mode) {
		
		//window.opener.location.reload();
		opener.location.reload();
	 
	} else {
		mode = "list";
		url = "/movieMgr/movie.do?mode=" + mode + "&menuId=" + menuId; 
	}

	 

	//메세지 출력
	alert(msg);

	if("delete" == qu) {
		location.href = url;
	} else {
		self.close();
		opener.go_reload();
	}
	
//-->
</script>