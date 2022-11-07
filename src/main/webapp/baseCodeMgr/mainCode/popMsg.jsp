<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 과정분류코드관리 메시지 처리
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
	
	if(mode == "majorExec"){
		//메인코드 등록
		url = "/baseCodeMgr/mainCode.do?menuId="+menuId;
	}else if(mode =="minorExec"){
		url = "/baseCodeMgr/mainCode.do?cdGubun=<%=requestMap.getString("cdGubun")%>";
		url += "&majorCode=<%=requestMap.getString("majorCode")%>";
		url += "&sub_name=<%=requestMap.getString("sub_name")%>";
		url += "&menuId=<%=requestMap.getString("menuId")%>";
	}
	
	window.opener.location.href = url;
	self.close();
	
	
  //-->
  </SCRIPT>
