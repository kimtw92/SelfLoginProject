<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 과목코드  저장시 처리 페이지
// date  : 2008-06-03
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	
	String menuId = requestMap.getString("menuId");
	
	// 처리 메세지
	String msg = (String)request.getAttribute("RESULT_MSG");
	// 처리 구분
	String resultType = (String)request.getAttribute("RESULT_TYPE");
	
	String param 		= "";
	String mode  		= "";
	String currPage 	= "";
	String s_indexSeq 	= "";
	String s_useYn 		= "";
	String s_subType 	= "";
	String s_searchTxt 	= "";
	
	
	if(requestMap.getString("mode") != null)
		mode = requestMap.getString("mode");
	
	// 업데이트 일때 검색파라메터를 리턴한다.
	if(requestMap.getString("mode").equals("sUpdate") || requestMap.getString("mode").equals("oUpdate")){
		//param = "&currPage=" + requestMap.getString("currPage");
		//param += "&s_indexSeq=" + requestMap.getString("s_indexSeq");
		//param += "&s_useYn=" + requestMap.getString("s_useYn");
		//param += "&s_subType=" + requestMap.getString("s_subType");
		//param += "&s_searchTxt=" + requestMap.getString("s_searchTxt");
		currPage = requestMap.getString("currPage");
		s_indexSeq = requestMap.getString("s_indexSeq");
		s_useYn = requestMap.getString("s_useYn");
		s_subType = requestMap.getString("s_subType");
		s_searchTxt = requestMap.getString("s_searchTxt");
	}
%>

<html>
<head>

</head>

<body>
<form id="pform" name="pform" method="post" >
	<input type="hidden" name="mode" 			value="">
	<input type="hidden" name="menuId" 			value="">
	
	<input type="hidden" name="currPage" 		value="">
	<input type="hidden" name="s_indexSeq" 		value="">
	<input type="hidden" name="s_useYn" 		value="">
	<input type="hidden" name="s_subType" 		value="">
	<input type="hidden" name="s_searchTxt" 	value="">
</form>


<script language="JavaScript" type="text/JavaScript">

	var form = document.pform;
	var mode = "<%=mode%>";
	
	if(mode == "sUpdate" || mode == "oUpdate") {
		form.currPage.value 	= "<%=currPage%>";
		form.s_indexSeq.value 	= "<%=s_indexSeq%>";
		form.s_useYn.value 		= "<%=s_useYn%>";
		form.s_subType.value 	= "<%=s_subType%>";
		form.s_searchTxt.value 	= "<%=s_searchTxt%>";
	}

	switch("<%=resultType%>"){
	
		case "ok":
			alert("<%= msg %>");
			//var param = "?mode=list";
			//param += "&menuId=< %=menuId%>";
			//param += "< %=param%>";
			//location.href="subj.do" + param;
			form.action="?mode=list";
			form.mode.value = "list";
			form.menuId.value = "<%=menuId%>";
			form.submit();
			break;
			
		case "deleteok":
			alert("<%= msg %>");
			var param = "?mode=list";
			param += "&menuId=<%=menuId%>";
			location.href="subj.do" + param;
			break;
			
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;
	}
	

</script>

</body>
</html>
