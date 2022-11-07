  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 우편번호 일괄등록관리 메시지 처리
// date : 2008-08-22
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
    
	alert("<%=requestMap.getString("msg")%>");

	//이동
	url = "/baseCodeMgr/zip.do?menuId="+menuId+"&mode=form";
		
	location.href = url;
	
  //-->
  </SCRIPT>
