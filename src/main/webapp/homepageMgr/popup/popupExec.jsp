  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 팝업 메시지 처리
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
	var no = "<%=requestMap.getString("no")%>";
	var qu = "<%=requestMap.getString("qu")%>";
    //이동할 주소값 저장
    var url = "";
    
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	
	if(mode=="exec"){
	
		if(qu == "delete"){
			//사용여부 수정, 삭제 후 이동
			url = "/homepageMgr/popup.do?menuId="+menuId;
			location.href = url;
		}else{
			//게시판 등록,수정 후 이동
			url = "/homepageMgr/popup.do?mode=form&qu=modify&menuId="+menuId+"&no="+no;
			location.href = url;
		}
	}
  //-->
  </SCRIPT>
