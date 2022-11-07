<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 동영상강의 입력/수정 실행후 메세지 처리
// date  : 2009-06-03
// auth  : hwani
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String msg  = (String)request.getAttribute("RESULT_MSG");
	String mode = requestMap.getString("mode");
	
	System.out.println("rtn >>> msg ========= " + msg);
	
	
%>

<script language="JavaScript">

	//변수 및 파라미터 설정.
	var msg 	= "<%=msg%>";
	var mode 	= "<%=mode%>";
	var url 	= "";

	//닫기 버튼 클릭시 현재 과목코드의 동영상 전체 삭제
	if(mode == "movExec") {
		if(msg == "ok") {
			self.close();
			opener.window.go_list();
		} else {
			alert("입력에 실패했습니다.");
			history.back();
		}
		
		
	} else if(mode == "deleteMovBySubj") {
		if(msg == "ok") {
			self.close();
		} else {
			history.back();
		}
	}
	
	
</script>