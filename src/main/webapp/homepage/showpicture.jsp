<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// date	: 2008-08-26
// auth 	: 양정환
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천사이버교육센터(시민포털)에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
<!-- [Page Customize] -->
<style type="text/css">
<!--

-->
</style>
<!-- [/Page Customize] -->
</head>

<!-- popup size 400x220 -->
<body>
<div class="top">
	<h1 class="h1">사진보기</h1>
</div>
<div class="contents">

<%
	String wcomments = (String)request.getAttribute("wcomments");
	if(wcomments == null) {
		wcomments = "";
	}
%>
	<!-- 검색결과 -->
	<div class="schList01">
		<img src='<%="/pds"+(String)request.getAttribute("imgPath") %>' alt='<%=wcomments%>' title='<%=wcomments%>' />
		<br />
		<div><b><%=wcomments%></b></div>
	</div>
	<!-- //검색결과 -->

	<!-- button -->
	<div class="btnC">
        <a href="javascript:window.close()"><img src="/images/skin1/button/btn_close01.gif" alt="닫기" /></a>
	</div>	
	<!-- //button -->

</div>
</body>
</html>


