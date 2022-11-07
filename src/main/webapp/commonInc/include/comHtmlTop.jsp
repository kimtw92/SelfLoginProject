<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%

	// css class name
	String cssName = request.getParameter("cssName");



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>인천광역시인재개발원에 오신 것을 환영합니다.[1]</title>

	<link rel="stylesheet" type="text/css" href="/commonInc/css/<%= skinDir %>/<%= cssName %>.css" />
	
	<link href="/commonInc/css/protoload.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript" language="javascript" src="/commonInc/js/<%= skinDir %>/gnbMenu.js"></script>
	<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
	<script type="text/javascript" language="javascript" src="/commonInc/js/NChecker.js"></script>
	<script type="text/javascript" language="javascript" src="/commonInc/js/protoload.js"></script>
	<script type="text/javascript" language="javascript" src="/commonInc/js/homeCategory.js"></script>
	<script type="text/javascript" language="javascript" src="/commonInc/inno/InnoDS.js"></script>		
	<script type="text/javascript" language="javascript" src="/pluginfree/js/jquery-1.11.0.min.js"></script>		
</head>
