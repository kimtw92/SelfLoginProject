<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="loti.mypage.model.PollVO" %>
<%
// prgnm 	: 설문
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

// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);

//페이징 필수
FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");

StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";
int iNum = 0;
if(listMap.keySize("answerTxt") > 0){		
	for(int i=0; i < listMap.keySize("answerTxt"); i++){
		sbListHtml.append(((requestMap.getInt("currPage")-1)*requestMap.getInt("rowSize")+(i+1)) + "&nbsp;&nbsp;" + listMap.getString("answerTxt",i) + "<br />");
	}
	pageStr = pageNavi.FrontPageStr();
}else{
	// 리스트가 없을때
}
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
<input type="hidden" name="currPage"  value="<%=requestMap.getString("currPage") %>">
<input type="hidden" name="title_no"  value="<%=requestMap.getString("title_no") %>">
<input type="hidden" name="set_no"  value="<%=requestMap.getString("set_no") %>">
<input type="hidden" name="question_no"  value="<%=requestMap.getString("question_no") %>">
<div class="top">
	<h1 class="h1">주관식 답변</h1>
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
		<%=sbListHtml.toString() %>
		</td>
	</tr>

    </tbody>
	</table>

	<div class="paging_ptm" style="width:375px;">
		<%=pageStr.toString() %>
	</div>

	<!-- button -->
	<div class="btnC" style="width:375px;">
		<a href="javascript:window.close();"><img src="/images/<%=skinDir %>/button/btn_close01.gif" alt="닫기" /></a>		
	</div>	
	<!-- //button -->
</div>

</form>
</body>



	