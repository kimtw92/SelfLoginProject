  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 직급코드관리 메시지 처리
// date : 2008-05-15
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
    var menuId = "<%=requestMap.getString("menuId")%>";
    //이동할 주소값 저장
    var url = "";	
    var qu = "<%=requestMap.getString("qu") %>";
    var search = "<%=requestMap.getString("search") %>";
    var currPage = "<%=requestMap.getString("currPage") %>";
    
	alert("<%=requestMap.getString("msg")%>");

	if(mode == "positionExec"){
		if(qu == "insert"){
			//메인코드 등록
			url = "/baseCodeMgr/position.do?menuId="+menuId;
		}else{
			//메인코드 수정
			url = "/baseCodeMgr/position.do?menuId="+menuId+"&search="+search+"&currPage="+currPage;
		}
		
	}else if(mode == "guBunCodeExec"){
		//구분코드 등록
		url = "/baseCodeMgr/position.do?mode=guBunCodeList&menuId="+menuId+"&search="+search+"&currPage="+currPage;
			
	}else if(mode == "positionAllUpload"){
		//일괄등록
		url = "/baseCodeMgr/position.do?mode=list&menuId="+menuId;
	}else if(mode == "guBunCodeUpload"){
		//구분일괄코드 등록
		url = "/baseCodeMgr/position.do?mode=guBunCodeList&menuId="+menuId+"&search="+search+"&currPage="+currPage;
			
	}
	
	window.opener.location.href = url;
	self.close();
	
	
  //-->
  </SCRIPT>
