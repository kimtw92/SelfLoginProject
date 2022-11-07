<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 과정 토론방 등록/수정/삭제/답변 실행
// date : 2008-07-10
// auth : LYM
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
	var msg			= "<%=msg%>";
	var menuId		= "<%=requestMap.getString("menuId")%>";
	var qu			= "<%=requestMap.getString("qu")%>";
	var isCyber		= "<%=requestMap.getString("isCyber")%>";
	var titleNo		= "<%=requestMap.getString("titleNo")%>";
	var grcode		= "<%=requestMap.getString("grcode")%>";
	var grseq		= "<%=requestMap.getString("grseq")%>";

	var moreStr = "";
	var url = "/poll/coursePoll.do?menuId="+menuId;

	if( qu == 'set_delete'){
		if( isCyber == 'Y')
			url += "&mode=form&qu=update&isCyber=Y&titleNo="+titleNo+"&commGrcode="+grcode + "&commGrseq=" + grseq;
		else
			url += "&mode=form&qu=update&titleNo="+titleNo;
	}else{
		if( isCyber == 'Y'){
			url += "&mode=cyber_list&qu=&commGrcode="+grcode + "&commGrseq=" + grseq;
		}else
			url += "&mode=list&qu=";

	}

	//메세지 출력
	alert(msg);
	location.href = url;
//-->
</script>