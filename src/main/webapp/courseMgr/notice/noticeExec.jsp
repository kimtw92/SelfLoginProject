<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 시스템관리자 > 과정운영 > 학습 > 과정공지 등록/수정 실행.
// date : 2008-06-04
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
	var searchKey	= "<%=requestMap.getString("searchKey")%>";
	var searchValue	= "<%=requestMap.getString("searchValue")%>";
	var qu			= "<%=requestMap.getString("qu")%>";

	var commYear	= "<%=requestMap.getString("commYear")%>";
	var commGrcode	= "<%=requestMap.getString("commGrcode")%>";
	var commGrseq	= "<%=requestMap.getString("commGrseq")%>";

	var no	= "<%=requestMap.getString("no")%>";

	var modeStr = "&mode=list";
	if(qu == 'update')
		modeStr = "&mode=view&qu=view&no="+no;

	var url = "/courseMgr/notice.do?menuId="+menuId+"&commYear="+commYear+"&commGrcode="+commGrcode+"&commGrseq="+commGrseq+modeStr;

	//메세지 출력
	alert(msg);
	
	location.href = url;
//-->
</script>