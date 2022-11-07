<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 수강신청 조회/승인  승인/승인취소 실행.
// date : 2008-06-26
// auth : 이용문
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
	var grcode = "<%=requestMap.getString("grcode")%>";
	var grseq = "<%=requestMap.getString("grseq")%>";
	
	var mode = "list";
	if(qu == "cyber_agree" || qu == "cyber_cancel")
		mode = "cyber_list";
	else if(qu == "dept_agree" || qu == "dept_cancel")
		mode = "dept_list";
		
	var url = "/courseMgr/lectureApply.do?mode=" + mode +"&menuId=" + menuId + "&commYear=" + year + "&commGrcode=" + grcode + "&commGrseq=" + grseq;

	//메세지 출력
	alert(msg);
	if(qu != "appinfo_update" && qu != "appinfo_delete"){
		location.href = url;
	} else {
		//회원정보 수정/수강신청정보 삭제인 경우는 팝업 닫고 부모창 리로드.
		self.close();
		opener.go_reload();
	}
//-->
</script>