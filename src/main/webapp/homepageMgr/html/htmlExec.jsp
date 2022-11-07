  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : html 메시지 처리
// date : 2008-06-23
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
    var complate = "<%=requestMap.getString("complate")%>";
    //등록 수정후 이동할 뷰페이지 주소
    var htmlId = "<%=requestMap.getString("htmlId")%>";
    //이동할 주소값 저장
    var url = "";
    var currPage = "<%=requestMap.getString("currPage")%>";
	var selectValue = "<%=requestMap.getString("selectValue")%>";
    
	//메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";

	//등록, 수정, 삭제
	if(qu == "insert"){
		if(complate == "ok"){

			url = "/homepageMgr/html.do?mode=view&menuId="+menuId+"&htmlId="+htmlId+"&selectValue="+selectValue+"&currPage="+currPage;
			location.href = url;
			
		}else if(complate == "cancle"){
			url = "/homepageMgr/html.do?mode=form&menuId="+menuId+"&qu=insert";
			location.href = url;
			
		}
		
	}else if(qu == "modify"){
		url = "/homepageMgr/html.do?mode=view&menuId="+menuId+"&htmlId="+htmlId+"&selectValue="+selectValue+"&currPage="+currPage;
		location.href = url;
		
	}else if(qu == "delete"){
		url = "/homepageMgr/html.do?mode=list&menuId="+menuId;
		location.href = url;
	}
	
	
	
  //-->
  </SCRIPT>
