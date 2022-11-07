<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
// prgnm : 사용자 게시판 메시지 처리
// date : 2008-09-30
// auth : jonng03
%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
%>
<form name="execFrm" id="execFrm" method="post" >
<input type="hidden" name="username" id="username" value="<%=requestMap.getString("username")%>">
<input type="hidden" name="phone" id="phone" value="<%=requestMap.getString("phone")%>">
<input type="hidden" name="mode" id="mode" value="personList">
</form>
  <SCRIPT LANGUAGE="JavaScript">
  <!--
    //모드값 저장
    var mode = "<%=requestMap.getString("mode")%>";
	var qu = "<%=requestMap.getString("qu")%>";
	
	var frm = document.execFrm;
    //이동할 주소값 저장
    var url = "";
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	if(mode=="personExec"){
		var mode1 = "";
		
		if(qu == "deleteBbsBoard"){
			mode1 = "personList";
			frm.mode.value = mode1;
			frm.action = "/homepage/support.do";
			frm.submit();
		}else{
			//alert("성공");
			mode1 = "personList";
			//게시판 등록,수정 후 이동
			frm.mode.value = mode1;
			frm.action = "/homepage/support.do";
			frm.submit();
		}
	}
  //-->
  </SCRIPT>
