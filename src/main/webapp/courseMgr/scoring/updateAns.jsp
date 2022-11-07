<%@page import="ut.lib.support.DataMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

DataMap requestMap = (DataMap) request.getAttribute("REQUEST_DATA");

int res = (Integer) request.getAttribute("res");
String userName = request.getParameter("userName");
if(res>0){
	out.println(userName + "님 답안 정보를 성공적으로 수정하였습니다.");
}
String msg = userName + "님 답안 정보를 성공적으로 수정하였습니다.";
%>

<script type="text/javascript">
	alert("<%=msg%>");
	opener.document.getElementsByClassName("onTap")[0].click();
	window.close();
</script>
