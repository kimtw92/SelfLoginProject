  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 외래강사 수당관리 메시지 관리
// date : 2008-07-18
// auth : 정 윤철
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
    var mode = "<%=requestMap.getString("mode")%>";
	var qu = "<%=requestMap.getString("qu")%>";
    var msg = "<%=requestMap.getString("msg")%>";
    //메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
    //페이징값
    var currPage = "<%=requestMap.getString("currPage")%>";
    //검색명
    var name = "<%=requestMap.getString("name")%>";
    var url = "";
	
	//메시지 
	alert("<%=requestMap.getString("msg")%>");

	if(mode == "exec"){
		url = "/tutorMgr/tutorPaper.do?menuId="+menuId+"&mode=tutorPaperList&currPage="+currPage+"&name="+name;
		location.href = url;
	}
  //-->
  </SCRIPT>
