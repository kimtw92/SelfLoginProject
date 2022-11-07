<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 용어사전 저장시 처리 페이지
// date  : 2008-06-01
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String menuId = requestMap.getString("menuId");
	
	// 처리 메세지
	String msg = (String)request.getAttribute("RESULT_MSG");
	// 처리 구분
	String resultType = (String)request.getAttribute("RESULT_TYPE");
	
	String param = "";
	
	if(requestMap.getString("mode").equals("updateDic")){
		
		param = "&currPage=" + requestMap.getString("currPage");
		param += "&s_subj=" + requestMap.getString("s_subj");
		param += "&s_groups=" + requestMap.getString("s_groups");
		param += "&s_dicTypes=" + requestMap.getString("s_dicTypes");
		param += "&s_searchTxt=" + requestMap.getString("s_searchTxt");
		
	}
	
%>



<script language="JavaScript" type="text/JavaScript">

	switch("<%=resultType%>"){
	
		case "ok":
			alert("<%= msg %>");
			var param = "?mode=dicList";
			param += "&menuId=<%=menuId%>";
			param += "<%=param%>";
			
			location.href="dic.do" + param;
						
			break;
			
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;
	}
	

</script>