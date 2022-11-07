<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<%
//request 데이터
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 인증 에러시 alert 설정
if(requestMap.getString("msg").equals("1")) {  // 인증 되었을 때
	out.println("<script>javascript:alert('실명인증에 성공했습니다.');</script>");
	out.println("<form name='insForm' method='post' action='support.do' >");
	out.println("<input type='hidden' name='guest' value='"+requestMap.getString("checkName")+"'>");
	out.println("<input type='hidden' name='qu' value='"+requestMap.getString("qu")+"'>");
	out.println("<input type='hidden' name='boardId' value='"+requestMap.getString("boardId")+"'>");
	out.println("<input type='hidden' name='mode' value='"+requestMap.getString("url")+"'>");
	out.println("<input type='hidden' name='seq' value='"+requestMap.getString("seq")+"'>");
	out.println("</form>");
	out.println("<script>document.insForm.submit();</script>");
} else {
	// 인증코드 실패시 팝업창 띄움 확인 페이지 확인 
	//out.println( "<script>javascript:window.open('auth_err.php?type="+requestMap.getString("type")+"&code="+requestMap.getString("returnCode")+"', 'pop', 'width=672, height=500');</script>");
	out.println("<script>javascript:alert('실명인증에 실패했습니다.');history.back();</script>");
}
%>