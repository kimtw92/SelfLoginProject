<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 안내문 리스트
// date : 2008-09-18
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

    //과정 안내문 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");

	//list
	String listStr = "";
	String tmpStr = "";
	for(int i=0; i < listMap.keySize("guideNo"); i++){

		listStr += "\n<tr>";

		//번호
		listStr += "\n	<td>" + (pageNum+i+1) + "</td>";

		//지문제목
		tmpStr = "<a href=\"javascript:go_modify('"+listMap.getString("guideNo", i)+"');\" >" + listMap.getString("guideGrinqTitle", i) + "</a>";
		listStr += "\n	<td>" + tmpStr + "</td>";

		//선택
		tmpStr = "<input type='button' value='선택' onclick=\"go_select('"+listMap.getString("guideNo", i)+"');\" class='boardbtn1'>";
		listStr += "\n	<td class='br0'>" + tmpStr + "</td>";

		listStr += "\n</tr>";
	}

	//row가 없으면.
	if( listMap.keySize("guideNo") <= 0){
		listStr += "\n<tr>";
		listStr += "\n	<td colspan='100%' height='100' class='br0'>등록된 안내문이 없습니다.</td>";
		listStr += "\n</tr>";
	}


	//페이징 String
	String pageStr = "";
	if(listMap.keySize("guideNo") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}


%>

						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//검색
function go_search(){

	if(IsValidCharSearch($F("searchValue"))){
		$("currPage").value = 1;
		go_list();
	}
}
//전체보기
function go_resetList(){

	$("searchValue").value = "";
	go_search();

}

//리스트
function go_list(){

	$("mode").value = "guide_list";

	pform.action = "/poll/coursePoll.do";
	pform.submit();

}

//선택시 (부모창에 hidden값 넣어줌)
function go_select(guideNo){

	opener.$("guideNo").value = guideNo;
	window.close();

}


//추가
function go_add(){

	$("guideNo").value = "";

	$("mode").value = "guide_form";
	$("qu").value = "insert";

	pform.action = "/poll/coursePoll.do";
	pform.submit();

}

//수정
function go_modify(guideNo){

	$("guideNo").value = guideNo;

	$("mode").value = "guide_form";
	$("qu").value = "update";

	pform.action = "/poll/coursePoll.do";
	pform.submit();

}

onload = function()	{

	$("searchKey").value = "<%= Util.getValue(requestMap.getString("searchKey"), "GUIDE_GRINQ_TITLE") %>";
}

//-->
</script>
<script language="javascript" src="/courseMgr/mail/sms.js"></script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post" >
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" name="grseq"				value='<%=requestMap.getString("grseq")%>'>

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">

<input type="hidden" name="guideNo"				value=''>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 과정 안내문보기</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<!-- 검색 -->
			<table class="search01">
				<tr>
					<td>
						<select name="searchKey">
							<option value='GUIDE_GRINQ_TITLE'>제목</option>
							<option value='GUIDE_TEXT'>내용</option>
						</select>
						<input type="text" class="textfield" name="searchValue" value="<%= requestMap.getString("searchValue") %>" style="width:150px;" onKeyPress="if(event.keyCode == 13) { go_search(); return false;}"/>
					</td>
					<td width="180" class="btnr" rowspan="2">
						<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
						<input type="button" value="전체보기" onclick="go_resetList();" class="boardbtn1">
						<input type="button" value="입력" onclick="go_add();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--//검색 -->	
			<div class="space01"></div>

			<!-- 리스트  -->
			<table class="datah01">
				<thead>
				<tr>
					<th>번호</th>
					<th>지문제목</th>
					<th class="br0">선택</th>
				</tr>
				</thead>

				<tbody>
					<%= listStr %>
				</tbody>
			</table>
			<!-- //리스트  -->

			<div class="paging">
				<%=pageStr%>
			</div>

			<!-- 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 닫기 버튼  -->
			<div class="h10"></div>


		</td>
	</tr>
</table>

</form>

</body>