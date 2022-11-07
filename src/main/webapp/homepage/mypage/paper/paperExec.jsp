<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
// prgnm : 회원검색
// date : 2008-09-30
// auth : 최 종삼
%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
%>
  <SCRIPT LANGUAGE="JavaScript">
  <!--
    //모드값 저장
    var mode = "<%=requestMap.getString("rMode") %>";
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	url = "/mypage/paper.do?mode="+mode;
	location.href = url;
	
  //-->
  </SCRIPT>
