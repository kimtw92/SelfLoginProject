  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 식단관리
// date : 2008-08-06
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
    var currPage = "<%=requestMap.getString("currPage")%>";
    //이동할 주소값 저장
    var url = "";
    
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	
	if(mode=="exec"){
		//사용여부 수정, 삭제 후 이동
		url = "/homepageMgr/food.do?menuId="+menuId+"&currPage="+currPage;
		location.href = url;
	}
  //-->
  </SCRIPT>
