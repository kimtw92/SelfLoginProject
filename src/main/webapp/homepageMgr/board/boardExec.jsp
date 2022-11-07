  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 게시판관리 메시지 처리
// date : 2008-06-04
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
    var qu = "<%=requestMap.getString("qu")%>";
	
    //이동할 주소값 저장
    var url = "";
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";

	
	if(qu=="modifyBoard"){
		//게시판 등록,수정,삭제 후 이동
		url = "/homepageMgr/board.do?mode=list&menuId="+menuId;
		location.href = url;
	}else if(qu=="insertBoard"){
		//게시판 등록,수정,삭제 후 이동
		url = "/homepageMgr/board.do?mode=list&menuId="+menuId;
		location.href = url;
	}else if(qu=="deleteBoard"){
		//게시판 등록,수정,삭제 후 이동
		url = "/homepageMgr/board.do?mode=list&menuId="+menuId;
		location.href = url;
	}
	
	
	
	
	
  //-->
  </SCRIPT>
