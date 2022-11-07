<%@page import="ut.lib.support.DataMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

DataMap requestMap = (DataMap) request.getAttribute("REQUEST_DATA");

int count = (Integer) request.getAttribute("count");

%>

<script type="text/javascript">

alert("<%=count%>건의 데이터를 LMS로 내보냈습니다.");

</script>