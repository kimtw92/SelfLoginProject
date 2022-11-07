<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 어학점수 입력   저장시 처리 페이지
// date  : 2008-06-16
// auth  : kang
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
	param += "&grCode=" + requestMap.getString("grCode");
	param += "&grSeq=" + requestMap.getString("grSeq");
	param += "&subj=" + requestMap.getString("subj");
	param += "&selSubjClass=" + requestMap.getString("selSubjClass");		
	param += "&currPage=" + requestMap.getString("currPage");
				
	
	
%>

<script language="JavaScript" type="text/JavaScript">

	var param = "";

	switch("<%=resultType%>"){
				
		case "ok":			
			alert("<%= msg %>");
			param = "?mode=form";
			param += "&menuId=<%=menuId%>";
			param += "<%=param%>";

			
			location.href = "langSubj.do" + param;
			break;
								
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;
				
	}
	

</script>