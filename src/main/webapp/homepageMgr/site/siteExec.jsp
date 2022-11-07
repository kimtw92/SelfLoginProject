  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사이트관리 메시지 처리
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
	var siteNo = "<%=requestMap.getString("siteNo")%>";
	var qu = "<%=requestMap.getString("qu")%>";
	var siteType = "<%=requestMap.getString("siteType")%>";
	var currPage = "<%=requestMap.getString("currPage")%>";
    //이동할 주소값 저장
    var url = "";
    
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	
	if(mode=="exec"){
	
		if(qu == "delete"){
			//사용여부 수정, 삭제 후 이동
			url = "/homepageMgr/site.do?menuId="+menuId+"&siteType="+siteType;
			location.href = url;
		}else if(qu == "modify"){
			//게시판 등록,수정 후 이동
			url = "/homepageMgr/site.do?mode=list&menuId="+menuId+"&siteNo="+siteNo+"&siteType="+siteType+"&currPage="+currPage;
			opener.location.href = url;
			self.close();
		}else{
		
			url = "/homepageMgr/site.do?mode=list&menuId="+menuId+"&siteNo="+siteNo+"&siteType="+siteType;
			window.opener.location.href = url;
			self.close();
		}
	}
  //-->
  </SCRIPT>
