<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

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
if(listMap.keySize("userno") > 0){		
	for(int i=0; i < listMap.keySize("userno"); i++){
		sbListHtml.append("<tr>\n");
		sbListHtml.append("<td class=\"bl0\">"+listMap.getString("no", i)+"</td>\n");
		sbListHtml.append("<td class=\"sbj\"><a href=\"javascript:onView('"+listMap.getString("no",i)+"');\">"+listMap.getString("title",i)+"</a></td>\n");
		sbListHtml.append("<td class=\"\">"+listMap.getString("regdate",i)+"</td>\n");
		sbListHtml.append("<td>"+listMap.getString("name",i)+"</td>\n");
		sbListHtml.append("<td>"+listMap.getString("visit",i)+"</td>\n");
		sbListHtml.append("</tr>\n");
		iNum ++;
		
	}
	pageStr = pageNavi.FrontPageStr();
}else{
	// 리스트가 없을때
	sbListHtml.append("<tr><td colspan=\"5\"> 게시된 글이 없습니다.</td></tr>");
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천사이버교육센터(시민포털)에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/board.css" />
<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	pform.action = "/mypage/myclass.do?mode=selectGrnoticeList";
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
</head>

<!-- popup size 400x220 -->
<body>
<div class="top">
	<h1 class="h1">공지사항</h1>
</div>
<div class="contents">

	<div class="h10"></div>

	<div class="h10"></div>
	<!-- data -->
	<table class="dataH01" style="width:100%;">	
	<colgroup>
		<col width="" />
		<col width="" />
		<col width="" />
		<col width="" />
		<col width="" />
	</colgroup>

	<thead>
	<tr>
		<th>No</th>
		<th>제 목</th>
		<th>게시일자</th>
		<th>작성자</th>
		<th>조회</th>
	</tr>
	</thead>
	                                                                        
	<tbody>
	<%=sbListHtml.toString() %>

	</tbody>
	</table>
	<!-- //data --> 


	<!-- button -->
	<!-- button -->
	<div class="btnC" style="width:100%;">
		<a href="javascript:window.close();"><img src="../../../images/skin1/button/btn_close01.gif" alt="닫기" /></a>		
	</div>	
	<!-- //button -->
	<!-- //button -->
</div>
</body>
</html>
