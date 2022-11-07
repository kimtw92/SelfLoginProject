  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 학적부관리 처리 실행 후 메시지 처리
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
	
    //이동할 주소값 저장
    var url = "";
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	//유저 주민번호
	var resno = "<%=requestMap.getString("resno")%>";
	//유저 번호
	var userno = "<%=requestMap.getString("userno")%>";
	
	if(mode=="modifyStudyExec"){
		//부서코드 등록 & 등록 체크후 이동 경로
		url = "/member/member.do?mode=studySchoolRegList&menuId="+menuId + "&resno="+resno+"&userno="+userno ;
		window.opener.location.href = url;
		self.close();		
	}
	
	
	
	
  //-->
  </SCRIPT>
