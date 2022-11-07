<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 강사관리 처리 페이지
// date  : 2008-06-22
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String mode = requestMap.getString("mode");
	
	// 메뉴ID
	String menuId = requestMap.getString("menuId");
	
	// 처리 메세지
	String msg = (String)request.getAttribute("RESULT_MSG");
	
	// 처리 구분
	String resultType = (String)request.getAttribute("RESULT_TYPE");
	
	String sessClass = Util.getValue( (String)request.getAttribute("SESSCLASS") );
	
	String param = "";
	
	if( mode.equals("saveTutorForm") ){
		param = "&currPage=" + requestMap.getString("currPage") +
				"&searchTutorGubun=" + requestMap.getString("searchTutorGubun") +
				"&searchJob=" + requestMap.getString("searchJob") +
				"&searchAddr=" + requestMap.getString("searchAddr") +
				"&searchBirth=" + requestMap.getString("searchBirth") +
				"&searchTutorLevel=" + requestMap.getString("searchTutorLevel") +
				"&searchSchool=" + requestMap.getString("searchSchool") +
				"&searchSubjNm=" + requestMap.getString("searchSubjNm") +
				"&searchTname=" + requestMap.getString("searchTname");
	}
	
	
%>

<script language="JavaScript" type="text/JavaScript">

	var param = "";

	switch("<%=resultType%>"){
				
		case "changeAuthOk":
		case "changeAuthError":		
			break;
			
		case "pkDup":
			// 주민번호, 아이디 중복체크
			alert("<%=msg%>");
			history.back();
			break;
			
		case "tutorRegOk":
			// 강사 등록
			alert("<%=msg%>");
			location.href = "tutor.do?mode=list&menuId=<%=menuId%>"
			break;
			
		case "tutorUpdateOk":
			// 강사 수정
			alert("<%=msg%>");
			<% if(sessClass.equals("7")){ %>
				location.href = "/tutorMgr/tutor.do?mode=regForm&menuId=3-1-1";
			<% }else{ %>
				location.href = "tutor.do?mode=categoty&menuId=<%=menuId%><%=param%>";
			<% } %>
			break;
											
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;
	}	
</script>