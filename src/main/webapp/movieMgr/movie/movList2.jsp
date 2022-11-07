<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);

DataMap divListMap = (DataMap)request.getAttribute("DIV_LIST_DATA");
listMap.setNullToInitialize(true);

StringBuffer divListBuff = new StringBuffer(); //분류 리스트
StringBuffer listStr 	 = new StringBuffer(); //동영상 리스트

for(int j=0; j < divListMap.keySize("divCode"); j++) {
	if("88785".equals(divListMap.getString("divCode", j)) || "88786".equals(divListMap.getString("divCode", j)) || "88787".equals(divListMap.getString("divCode", j))) {
		continue;
	}
	divListBuff.append("<li><a href=\"javascript:go_listDiv('" + divListMap.getString("divCode", j) + "', '" + divListMap.getString("divName", j) + "')\" title=\"" + divListMap.getString("divName", j) + "\" ><span><font color=\"#FFFFFF\">" + divListMap.getString("divName", j) + "</span></font></a></li>");
	
}

//동영상 리스트
for(int i=0; i < listMap.keySize("contCode"); i++) {
	String tmpStr = "";
	listStr.append("\n<tr>");
	
	if (listMap.getString("filePath",i).length() > 4) {
		listStr.append("\n	<td><img src='http://hrd.incheon.go.kr"+listMap.getString("filePath",i)+"' width='82' height='57' class='imgtum' alt='"+listMap.getString("contName", i)+"' /></td>");
	} else {
		listStr.append("\n <td><img src='/images/table/noimg.gif' class='imgtum' alt='이미지없음'/></td>");
	}
	listStr.append("<td class=\"sbj\"> \n");
	listStr.append("<strong>" + listMap.getString("contName", i) + "</strong> \n");
	listStr.append("<a href=\"javascript:go_view(" + listMap.getString("contCode", i) + ");\"><img src='/images/button/btn_listen.gif' style='vertical-align:middle' alt='강의듣기' /></a> \n");
	listStr.append("<div class='space_5'></div> \n");
	listStr.append("<strong>게시일:" + listMap.getString("ldate", i) + "</strong> &nbsp; &nbsp; &nbsp;<strong>조회수:" + listMap.getString("visit", i) + "</strong> \n");
	listStr.append("<div class='space_5'></div> \n");
	listStr.append("<font class='t11px'>"+StringReplace.subStringPoint(listMap.getString("contSummary",i),150)+"</font> \n");
	listStr.append("</td>");
	listStr.append("\n</tr>");
	
}


if( listMap.keySize("contCode") <= 0){

	listStr.append("<tr bgColor='#FFFFFF'>");
	listStr.append("	<td align='center' class='tableline21' colspan='100%' height='100'>등록된 동영상강의가 없습니다.</td>");
	listStr.append("</tr>");

}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/movie/layout2.css" />
<script type="text/javascript" src="/commonInc/js/commonJs.js"></script>

<Script type="text/javascript">
<!--
//리스트
function go_list() {
	var mode = "movList2";
	document.pform.action = "/movieMgr/movieUse.do?mode=" + mode;
	document.pform.submit();
}

//분류별 리스트
function go_listDiv(divCode, divName) {
	/* 2011.04.04 추가*/

	if(divCode == "88785" || divCode == "88786" || divCode == "88787") {
		alert("경제 포커스, 자기계발, 교양강좌는 준비중 입니다.");
		return;
	}
	var mode = "movList2";
	document.pform.divCode.value = divCode;
	document.pform.divName.value = divName;
	document.pform.action = "/movieMgr/movieUse.do?mode=" + mode;
	document.pform.submit();
}

//검색
function go_search() {
	var mode = "movList2";
	document.pform.action = "/movieMgr/movieUse.do?mode=" + mode;
	document.pform.submit();
}

//강의듣기 팝업
function go_view(contCode) {

	var mode = "movView";
	url = "/movieMgr/movieUse.do?mode=" + mode + "&contCode=" + contCode;
	window.open(url, 'pop_contView', 'width=800,height=500,left=0,top=0,status=yes');
}


-->
</script>
</head>

<body>
<form id="pform" name="pform" method="post" style="padding-left:10px" action="">
<input type="hidden" name="divCode"	value="" />
<input type="hidden" name="divName"	value="" />
<div id="wrapper">
	<span class="alignL">
		<select class="select01" name="s_searchType">
			<option value="cont_name">강좌명</option>
		</select>
		<input type="text" id="s_searchText" name="s_searchText" class="input01" value="<%= requestMap.getString("s_searchText") %>" />
		<a href="javascript:go_search();"> <img src="/images/movie/button/btn_search.gif" alt="검색" class="vm1" /> </a>
	</span>
	<table class="bList01">	
	<colgroup>
		<col width="113" />
		<col width="*" />
	</colgroup>
	<tbody>
	<%= listStr %>
	</tbody>
	</table>
</div>
</form>
</body>
</html>