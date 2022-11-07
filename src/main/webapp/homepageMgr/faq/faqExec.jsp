  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : FAQ 메시지 처리
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
	var fno = "<%=requestMap.getString("fno")%>";
	var qu = "<%=requestMap.getString("qu")%>";
    
    //이동할 주소값 저장
    var url = "";
    
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	var sessClass = "<%=requestMap.getString("sessClass")%>";
	
	if(mode=="exec"){
	
		if(qu == "modifyFaqUseYn" || qu == "deleteFaq"){
			//사용여부 수정, 삭제 후 이동
			url = "/homepageMgr/faq.do?menuId="+menuId;
			location.href = url;
		}else{
			//게시판 등록,수정 후 이동
			url = "/homepageMgr/faq.do?mode=view&menuId="+menuId+"&fno="+fno;
			location.href = url;
		}
	}
  //-->
  </SCRIPT>
