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
    
    var url = "";
	
	//메시지 
	alert("<%=requestMap.getString("msg")%>");

	if(mode == "tutorSalaryExec"){
		url = "/tutorMgr/salary.do?menuId="+menuId+"&mode=salaryList&sDate=<%=requestMap.getString("sDate")%>&salaryType=<%=requestMap.getString("salaryType")%>&gubun=<%=requestMap.getString("gubun")%>&grcode=<%=requestMap.getString("grcode")%>&menuId=<%=requestMap.getString("menuId")%>";
		location.href = url;
	}
	
	if(mode == "salaryPopExec"){
		url = "/tutorMgr/salary.do?menuId="+menuId+"&mode=salaryList&sDate=<%=requestMap.getString("sDate")%>&salaryType=<%=requestMap.getString("salaryType")%>&gubun=<%=requestMap.getString("gubun")%>&grcode=<%=requestMap.getString("grcode")%>&menuId=<%=requestMap.getString("menuId")%>";
		opener.location.href = url;
		self.close();
	}
	
	
  //-->
  </SCRIPT>
