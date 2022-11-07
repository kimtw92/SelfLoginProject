  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : FAQ 메시지 처리
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
    var mode = "<%=requestMap.getString("mode")%>";
	var qu = "<%=requestMap.getString("qu")%>";
    var msg = "<%=requestMap.getString("msg")%>";
    
    //이동할 주소값 저장
    var url = "";
	if(qu == "insert" && msg == "back"){
		alert("중복된 값입니다.\n확인 후 다시 입력 하십시오.");
	}else if(qu == "modify" && msg == "back"){
		alert("중복된 값입니다.\n확인 후 다시 입력 하십시오.");
	}else{
		//메시지 
		alert("<%=requestMap.getString("msg")%>");
	}
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	

	//등록, 수정, 삭제
	url = "/homepageMgr/classRoom.do?menuId="+menuId;
	location.href = url;
	
  //-->
  </SCRIPT>
