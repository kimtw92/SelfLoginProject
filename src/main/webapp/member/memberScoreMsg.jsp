<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
			param = "?mode=pointUp";
			param += "&menuId=<%=menuId%>";
			param += "<%=param%>";
			
			parent.opener.document.location.href = "/evalMgr/score.do" + param;			
			
			window.close();		
			
			break;
								
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;				
	}
</script>