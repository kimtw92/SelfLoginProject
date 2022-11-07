<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="loti.mypage.model.PollVO" %>
<%
// prgnm 	: 과제물
// date		: 2008-09-30
// auth 	: jong03
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
<%

// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

%>

<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	pform.action = "/mypage/myclass.do?mode=juView";
	pform.submit();
}

//상세보기
function onView(form){
	$("no").value = form;
	$("mode").value ="grnoticeListView";
	pform.action = "/mypage/myclass.do";
	pform.submit();
}

function setForm(form){
	$("mode").value = form;
	$("viewNo").value = "";
	pform.action = "/mypage/myclass.do";
	pform.submit();
}

//-->
</script>

<body>
<form id="pforam" name="pform" method="post">
<div class="top">
	<h1 class="h1">평가의견</h1>
</div>
<div class="contents">

	<div class="h10"></div>
	
	
    <table class="dataW02" style="width:370px;">	
	<colgroup>
		<col width="370" />
	</colgroup>
	<tbody>
	<tr>
		<td>
		<%=StringReplace.convertHtmlEncodeNamo2(requestMap.getString("strEstmate")) %>
		</td>
	</tr>

    </tbody>
	</table>
	<!-- button -->
	<div class="btnC" style="width:375px;">
		<a href="javascript:window.close();"><img src="/images/<%=skinDir %>/button/btn_close01.gif" alt="닫기" /></a>		
	</div>	
	<!-- //button -->
</div>

</form>
</body>



	