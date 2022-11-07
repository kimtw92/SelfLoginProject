<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// prgnm : 특수과목 점수 입력   저장시 처리 페이지
// date  : 2008-08-07
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
	
		
	String param = "";		
	param = "&commYear=" + requestMap.getString("commYear");
	param += "&commGrcode=" + requestMap.getString("commGrcode");
	param += "&commGrseq=" + requestMap.getString("commGrseq");
	param += "&commSubj=" + requestMap.getString("commSubj");
	param += "&a_eval_method=" + requestMap.getString("a_eval_method");
	param += "&spsubj_totpoint=" + requestMap.getString("spsubj_totpoint");
%>

<script language="JavaScript" type="text/JavaScript">

	var param = "";

	switch("<%=resultType%>"){
				
		case "ok":			
			alert("<%= msg %>");
			param = "?mode=list";
			param += "&menuId=<%=menuId%>";
			param += "<%=param%>";

			
			location.href = "score.do" + param;
			break;
								
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;
				
	}
</script>