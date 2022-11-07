<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 웹진자료관리 메시지처리
// date : 2008-07-03
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

<script type="text/javascript" language="javascript">

	//모드값 저장
    var mode 		= "<%=requestMap.getString("mode")%>";
	var qu 			= "<%=requestMap.getString("qu")%>";
	var currPage 	= "<%=requestMap.getString("currPage")%>";
	var date 		= "<%=requestMap.getString("date")%>";
	
    //이동할 주소값 저장
    var url = "";
    
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	
	if(mode=="complateExec"){
		if(qu == "insertComplate"){
			//등록 후 이동
			url = "/webzine.do?mode=complateList&menuId="+menuId+"&date="+date;
			window.opener.location.href = url;
			self.close();
		}else if(qu == "modifyComplate"){
			//등록 후 이동
			url = "/webzine.do?mode=complateList&menuId="+menuId+"&currPage="+currPage+"&date"+date;
			window.opener.location.href = url;
			self.close();
		}
	}else if(mode == "ebookExec"){
		if(qu == "insertEbook" || qu == "delete"){
			//등록 후 이동
			url = "/webzine.do?mode=ebookList&menuId="+menuId
			location.href = url;
			
		}else if(qu == "modifyEbook"){
			//등록 후 이동
			url = "/webzine.do?mode=ebookList&menuId="+menuId+"&currPage="+currPage
			location.href = url;
			
		}	 
	}
	
</script>
