<%@page import="ut.lib.support.DataMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

DataMap requestMap = (DataMap) request.getAttribute("REQUEST_DATA");

int res = (Integer) request.getAttribute("res");

String ynEnd = request.getParameter("ynEnd");
String endNm = "Y".equals(ynEnd) ? "완료" : "미완료";

%>
<script type="text/javascript">
	alert('<%=res%>명의 시험을 <%=endNm%> 처리 하였습니다.');
	parent.document.location.reload();
</script>