<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 설문관리 - 설문지 관리.
// date : 2008-09-25
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////


	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("questionNo"); i++){

		listStr.append("\n<tr>");

		//CheckBox
		listStr.append("\n	<td><input type='checkbox' class='chk_01' name='chkQuestionNo[]' id='chkQuestionNo[]' value='" + listMap.getString("questionNo", i) + "' ></td>");

		//번호
		listStr.append("\n	<td>" + listMap.getString("questionNo", i) + "</td>");

		//설문내용
		listStr.append("\n	<td class='left'><a href=\"javascript:go_modify(" + listMap.getString("questionNo", i) + ");\">" + listMap.getString("question", i) + "</a></td>");

		//구분
		if( listMap.getString("questionGubun", i).equals("0") )
			tmpStr = "필수";
		else if( listMap.getString("questionGubun", i).equals("1") )
			tmpStr = "공통";
		else if( listMap.getString("questionGubun", i).equals("2") )
			tmpStr = "과목";
		else
			tmpStr = "";
		listStr.append("\n	<td>" + tmpStr + "</td>");


		//형태
		tmpStr = listMap.getString("answerKind", i).equals("4") ? "주관식" : "객관식";
		listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");


		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("questionNo") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' style=\"height:100px\"  class='br0'>검색된 설문이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

	//페이징 String
	String pageStr = "";
	if(listMap.keySize("questionNo") > 0){
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

<script language="JavaScript" type="text/JavaScript">
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
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/poll/pollBank.do";
	pform.submit();

}

//리스트 checkBox
function listSelectAll() {
	
	var obj = document.getElementsByName("chkQuestionNo[]");

	if( obj != undefined )
		for(var i = 0; i < obj.length; i++)
			obj[i].checked = $("checkAll").checked;

}

//추가
function go_add(){

	$("questionNo").value = "";

	$("mode").value = "form";
	$("qu").value = "insert";

	pform.action = "/poll/pollBank.do";
	pform.submit();

}

//수정
function go_modify(questionNo){

	$("questionNo").value = questionNo;

	$("mode").value = "form";
	$("qu").value = "update";

	pform.action = "/poll/pollBank.do";
	pform.submit();

}

//삭제
function go_delete(){

	var isCheck = false;
	var obj = document.getElementsByName("chkQuestionNo[]");

	if( obj != undefined ){
		for(var i = 0; i < obj.length; i++)
			if(obj[i].checked){
				isCheck = true;
				break;
			}
	}

	if( !isCheck ){
		alert("삭제하실 설문을 선택해 주세요.!");
		return;
	}

	if(confirm('삭제 하시겠습니까?')) {

		$("mode").value = "exec";
		$("qu").value = "delete";

		pform.action = "/poll/pollBank.do";
		pform.submit();

	}
}


//로딩시.
onload = function()	{

}


//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">

<input type="hidden" name="qu"					value="">
<input type="hidden" name="questionNo"			value="">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>            
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->



			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80">
									<strong>검색</strong>
								</th>
								<td>
									<input type="radio" name="searchKey" value="0" id="searchKey0" <%= requestMap.getString("searchKey").equals("0") ? "checked" : "" %>>
									<label for="searchKey0">
										필수 
									</label>
									<input type="radio" name="searchKey" value="1" id="searchKey1" <%= requestMap.getString("searchKey").equals("1") ? "checked" : "" %>>
									<label for="searchKey1">
										공통 
									</label>
									<input type="radio" name="searchKey" value="2" id="searchKey2" <%= requestMap.getString("searchKey").equals("2") ? "checked" : "" %>>
									<label for="searchKey2">
										과목 
									</label>
									<input type="radio" name="searchKey" value="" id="searchKey3" <%= requestMap.getString("searchKey").equals("") ? "checked" : "" %>>
									<label for="searchKey3">
										전체  
									</label>
									&nbsp;&nbsp;<input type="text" class="textfield" name="searchValue" value="<%= requestMap.getString("searchValue") %>" style="width:200px;" maxlength="30" onKeyPress="if(event.keyCode == 13) { go_search(); return false;}" />
								</td>
								<td width="100" class="btnr">
									<input type="button" value="검색" onclick="go_search();" class="boardbtn1" >
								</td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th style='width:50'>
									선택 <input type="checkbox" class="chk_01" name="checkAll" onClick="listSelectAll()" >
								</th>
								<th style='width:30'>번호</th>
								<th>설문내용</th>
								<th style='width:50'>구분</th>
								<th class="br0" style='width:50'>형태</th>
							</tr>
							</thead>

							<tbody>

							<%= listStr.toString() %>

							</tbody>
						</table>
						<!--// 리스트  -->	

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="설문작성" onclick="go_add();" class="boardbtn1">
									<input type="button" value="삭제" onclick="go_delete();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->

						<!--페이징 -->
						<div class="paging">
							<%=pageStr%>
						</div>
						<!-- //페이징 -->
					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>


        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

