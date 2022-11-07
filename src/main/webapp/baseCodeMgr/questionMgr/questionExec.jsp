<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 과목코드별 문항관리 저장
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String menuId = requestMap.getString("menuId");
	String subj = requestMap.getString("subj");
	String subjnm = requestMap.getString("subjnm");
	
	// 처리 메세지
	String msg = (String)request.getAttribute("RESULT_MSG");
	// 처리 구분
	String resultType = (String)request.getAttribute("RESULT_TYPE");
	
	String mode = "";
	
	if(requestMap.getString("mode") != null)
		mode = requestMap.getString("mode");
%>

<html>
<head>
</head>

<body>
<form id="pform" name="pform" method="post" >
<input type="hidden" name="mode" 			value="">
<input type="hidden" name="menuId" 			value="">
	
<input type="hidden" name="subj" 			value="">
<input type="hidden" name="subjnm" 			value="">

<!-- 과목 리스트 검색결과 유지 -->
<input type="hidden" name="s_subjIndexSeq" value="<%= requestMap.getString("s_subjIndexSeq") %>">
<input type="hidden" name="s_indexSeq">
<input type="hidden" name="s_subjUseYn" value="<%= requestMap.getString("s_subjUseYn") %>">
<input type="hidden" name="s_subType" value="<%= requestMap.getString("s_subType") %>">
<input type="hidden" name="s_subjSearchTxt" value="<%= requestMap.getString("s_subjSearchTxt") %>">
<!-- 과목 리스트 페이징 유지 -->
<input type="hidden" name="subjCurrPage" id="subjCurrPage" value="<%= requestMap.getString("subjCurrPage")%>">

<!-- 검색 -->
<input type="hidden" name="s_difficulty" value="<%= requestMap.getString("s_difficulty") %>">
<input type="hidden" name="s_useYn" value="<%= requestMap.getString("s_useYn") %>">
<input type="hidden" name="s_qType" value="<%= requestMap.getString("s_qType") %>">

<!-- 페이징 -->
<input type="hidden" name="currPage" id="currPage" value="<%= requestMap.getString("currPage")%>">
</form>

<script language="JavaScript" type="text/JavaScript">
	var form = document.pform;
	var mode = "<%=mode%>";
	
	alert("<%= msg %>");
	
	switch("<%=resultType%>"){
	
		case "SetUseYnOK":		
			form.action="?mode=questionList";
			form.mode.value = "questionList";
			form.menuId.value = "<%=menuId%>";
			form.subj.value = "<%=subj%>";
			form.subjnm.value = "<%=subjnm%>";
			form.submit();
			break;

		case "SetUseYnError":		
			history.back();
			break;
			
		case "sInsertOK":
			form.action="?mode=questionList";
			form.mode.value = "questionList";
			form.menuId.value = "<%=menuId%>";
			form.subj.value = "<%=subj%>";
			form.subjnm.value = "<%=subjnm%>";
			form.submit();
			break;

		case "sInsertError":		
			history.back();
			break;
			
		case "sUpdateOK":
			form.action="?mode=questionList";
			form.mode.value = "questionList";
			form.menuId.value = "<%=menuId%>";
			form.subj.value = "<%=subj%>";
			form.subjnm.value = "<%=subjnm%>";
			form.submit();
			break;

		case "sUpdateError":		
			history.back();
			break;
	}
	

</script>

</body>
</html>