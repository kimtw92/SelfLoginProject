<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 공통 업로드 팝업 처리 페이지
// date  : 2008-07-02
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String mode = requestMap.getString("mode");
	
	
	// 처리 메세지
	String msg = (String)request.getAttribute("RESULT_MSG");
	
	// 처리 구분
	String resultType = (String)request.getAttribute("RESULT_TYPE");
	
	String retObj = requestMap.getString("retObj");
	String fileGroupNo = (String)request.getAttribute("FILEGROUPNO");
	
	
%>

<script language="JavaScript" type="text/JavaScript">

	switch("<%=resultType%>"){
				
		case "ok":
			alert("<%=msg%>");
			opener.<%=retObj%>.value = "<%= fileGroupNo %>";
			opener.fnFileUploadOk();
			self.close();
			break;
			
		case "nonfile":
			alert("<%=msg%>");
			history.back();
			break;
								
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;
	}
	

</script>