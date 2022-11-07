<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// prgnm : 평가항목관리 처리 페이지
// date  : 2008-08-28
// auth  : 최형준
%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	// 메뉴ID
	String menuId = requestMap.getString("menuId");
	
	// 처리 메세지
	String msg = (String)request.getAttribute("RESULT_MSG");
	
	// 처리 구분
	String resultType = (String)request.getAttribute("RESULT_TYPE");
	
	//모드
	String mode=requestMap.getString("mode");
	
	if(mode.equals("eduTrainEdit")){
		mode="eduTrain";		
	}else{
		mode="list";
	}	
	String param = "";		
	param = "&commYear=" + requestMap.getString("commYear");
	param += "&commGrcode=" + requestMap.getString("commGrcode");
	param += "&commGrseq=" + requestMap.getString("commGrseq");		
%>

<script language="JavaScript" type="text/JavaScript">
	var param = "";
	
	switch("<%=resultType%>"){
				
		case "ok":			
			alert("<%= msg %>");
			param = "?mode=<%=mode%>";
			param += "&menuId=<%=menuId%>";
			param += "<%=param%>";
			document.location.href = "/evalMgr/evalItem.do" + param;
			break;
								
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;
	}
</script>