<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 사진미리보기
// date  : 2008-06-25
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	String imgurl = Util.getValue( request.getParameter("imgurl"), "");
	//out.print(imgurl);
%>

<form>
<div id="img_show" style="width:100px;height:100px;background:url('');"></div> 
</form>

<script language="JavaScript" type="text/JavaScript">
<!--
//var img_id = document.getElementById("img_show");
//img_id.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<% out.print(imgurl); %>',sizingMethod=scale)"; 
//-->
</script>
