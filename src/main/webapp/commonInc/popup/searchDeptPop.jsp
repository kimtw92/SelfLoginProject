<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 공통 기관 검색 조회 (팝업)
// date : 2008-06-30
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       


    //기관 리스트.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	String listStr = "";
	String tmpStr = "";
	for(int i = 0; i < listMap.keySize("dept"); i++){

		listStr += "\n<tr>";

		//기관코드
		listStr += "\n	<td>" + listMap.getString("dept", i) + "</td>";

		//기관명 전체
		tmpStr = "<a href=\"javascript:go_selected('" + listMap.getString("dept", i) + "', '" + listMap.getString("deptnm", i) + "', '" + listMap.getString("lownm", i) + "');\">" + listMap.getString("deptnm", i) + "</a>";
		listStr += "\n	<td>" + tmpStr + "</td>";

		//기관명 하위
		listStr += "\n	<td class='br0 sbj'>" + listMap.getString("lownm", i) + "</td>";

		listStr += "\n</tr>";

	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--


//검색
function go_search(){
	if($F("searchValue") == ""){
		alert("검색어를 입력하세요.");
		return;
	}
	if(IsValidCharSearch($F("searchValue"))){
		go_list();
	}

}

//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/commonInc/searchDept.do";
	pform.submit();

}



//선택시.
function go_selected(dept, deptnm, lownm){

	var objDept = opener.document.getElementById("<%= requestMap.getString("deptField") %>");
	var objDeptnm = opener.document.getElementById("<%= requestMap.getString("deptnmField") %>");

	objDept.value = dept;
	objDeptnm.value = deptnm;
	try {
		var deptsub = opener.document.all.deptsub.value;
		opener.getMemSelDept(dept, deptsub);
	} catch(e) {
	}

	self.close();
}

function go_formChk(){

	go_search();
}
//-->
</script>

<body onload="javascript:$('searchValue').focus();">
<form id="pform" name="pform" method="post" onSubmit="go_formChk();return false;">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="search"				value="GO">

<input type="hidden" name="deptField"			value="<%= requestMap.getString("deptField") %>">
<input type="hidden" name="deptnmField"			value="<%= requestMap.getString("deptnmField") %>">
<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" />기관 검색</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<!-- date -->
			<div class="pop_datainput01">
				<input type="text" class="textfield" name="searchValue" value="<%= requestMap.getString("searchValue") %>" style="width:120px" />
				<input type="button" value="검색" onclick="go_search();return false;" class="boardbtn1">
			</div>
			<!-- //date -->

			<div class="pop_txt01">기관명을 입력 후 검색을 선택하세요.</div>

			<div class="space01"></div>
			
			<!-- 리스트  -->
			<% if( requestMap.getString("search").equals("GO") ){ %>
			<table class="datah01">
				<thead>
				<tr>
					<th>기관코드</th>
					<th>기관명(전체)</th>
					<th class="br0">기관명(하위)</th>
				</tr>
				</thead>

				<tbody>
					<%= listStr %>
				</tbody>
			</table>

			<% } %>
			<!-- //리스트  -->
			<div class="space01"></div>



			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="self.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>
</form>

</body>
