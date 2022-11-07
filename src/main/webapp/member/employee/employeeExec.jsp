  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 직원관리 메시지 처리
// date : 2008-08-19
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
	var menuId = "<%=requestMap.getString("menuId")%>";
    //이동할 주소값 저장
    var url = "";
    var part = "<%=requestMap.getString("searchPart")%>";
    var name = "<%=requestMap.getString("searchName")%>";
    var content = "<%=requestMap.getString("searchContent")%>";
    
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	if(mode=="exec"){
		if(qu == "insert" || qu == "delete"){
			//직원관리 등록, 삭제 후 이동 
			url = "/member/employee.do?mode=list&menuId="+menuId;
			location.href = url;
		}else if(qu == "modify"){
			//수정
			url = "/member/employee.do?mode=list&menuId="+menuId+"&currPage="+currPage+"&part="+part+"&name="+name+"&content="+content;
			location.href = url;		
		}
	}
	
  //-->
  </SCRIPT>
