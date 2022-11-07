<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 시험지 등록/수정 실행
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String menuId = requestMap.getString("menuId");
	String subj = requestMap.getString("subj");
	String commGrcode = requestMap.getString("grcode");
	String commGrseq = requestMap.getString("grseq");
	String ptype = requestMap.getString("ptype");
	
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
<input type="hidden" name="mode" 		value="">
<input type="hidden" name="menuId" 		value="">

<input type="hidden" name="subj" 		value="">
<input type="hidden" name="commGrcode" 	value="">
<input type="hidden" name="commGrseq" 	value="">
<input type="hidden" name="grcode" 		value="">
<input type="hidden" name="grseq" 		value="">
<input type="hidden" name="ptype" 		value="">
</form>

<script language="JavaScript" type="text/JavaScript">
	var form = document.pform;
	
	alert("<%= msg %>");
	
	switch("<%=resultType%>"){
	
		case "OK":
			form.action="?mode=evlinfoSubjForm";
			form.mode.value = "evlinfoSubjForm";
			form.menuId.value = "<%=menuId%>";
			form.subj.value = "<%=subj%>";
			form.commGrcode.value = "<%=commGrcode%>";
			form.commGrseq.value = "<%=commGrseq%>";
			form.ptype.value = "<%=ptype%>";
			form.submit();
			break;

		case "offOK":
			form.action="?mode=evlinfoSubjOffForm";
			form.mode.value = "evlinfoSubjOffForm";
			form.menuId.value = "<%=menuId%>";
			form.subj.value = "<%=subj%>";
			form.grcode.value = "<%=commGrcode%>";
			form.grseq.value = "<%=commGrseq%>";
			form.submit();
			break;
			
		case "Error":		
			history.back();
			break;
	}
	

</script>

</body>
</html>