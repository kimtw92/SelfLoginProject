  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 특수권한자 등록,삭제 후 메시지 창과 해당 페이지로이동을 한다.
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
    //검색조건값 저장
	var selGadmin = "<%=requestMap.getString("selGadmin")%>";
	var currPage = "<%=requestMap.getString("currPage")%>";
	
    //이동할 주소값 저장
    var url = "";
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	
		var qu = "<%=requestMap.getString("qu")%>";
		if(qu == "insertAdmin"){
			url = "/member/member.do?mode=adminList&menuId="+menuId;
			location.href = url;
		}else if(qu == "deleteAdmin"){
			url = "/member/member.do?mode=adminList&menuId="+menuId+"&selGadmin="+selGadmin+"&currPage="+currPage;
			location.href = url;
		}
	

  //-->
  </SCRIPT>