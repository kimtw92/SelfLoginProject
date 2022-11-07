<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 콘텐츠 관리 - 리스트
// date : 2008-09-03
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

	//목록리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");


	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("subj"); i++){

		listStr.append("\n<tr>");

		//no
		listStr.append("\n	<td>" + (pageNum-i) + "</td>");

		//과목명
		listStr.append("\n	<td>" + listMap.getString("subjnm", i) + "</td>");

		//학습창템플릿
		listStr.append("\n	<td>" + listMap.getString("imgName", i) + "</td>");

		//학습창크기
		listStr.append("\n	<td>" + listMap.getString("lcmsWidth", i) + "X" + listMap.getString("lcmsHeight", i) + "</td>");

		//맛보기
		if(listMap.getInt("previewCnt", i) > 0)
			tmpStr = "<a href=\"javascript:go_sammple('"+listMap.getString("subj", i)+"')\">[보기]</a>";
		else
			tmpStr = "없음";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//콘텐츠 보기
		tmpStr = "<a href=\"javascript:go_detail('"+listMap.getString("subj", i)+"')\">[보기]</a>";
		listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");

		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("subj") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' class='br0' style='height:100px'>등록된 과목이 없습니다.</td>");
		listStr.append("\n</tr>");

	}


	//페이징 String
	String pageStr = "";
	if(listMap.keySize("subj") > 0){
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

//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
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

	pform.action = "/contentsMgr/contents.do";
	pform.submit();

}


//등록된 회차 보기.
function go_detail(subj){

	$("mode").value = "seq_list";
	$("qu").value = "";

	$("subj").value = subj;

	pform.action = "/contentsMgr/contents.do";
	pform.submit();

}

//맛보기 팝업
function go_sammple(subj){

	var mode = "sample";
	var menuId = $F("menuId");
	var url = "/contentsMgr/contents.do?mode=" + mode + "&menuId=" + menuId + "&subj=" + subj;

	popWin(url, "pop_contentPreview", "600", "500", "1", "");

}

//콘텐츠 등록 새창
function go_add(subj){

	var url = "/lcms/";

	window.open(url, "_blank", "");

}



//로딩시.
onload = function()	{


}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">
<input type="hidden" name="qu"					value="">

<input type="hidden" name="subj"				value="">

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
			<!-- subTitle
			<div class="tit01">
				<h2 class="h2"><img src="../images/bullet003.gif">과정기수관리 리스트</h2>
			</div>
			// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>

						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="100" class="bl0">
									과목명
								</th>
								<td>
									<input type='text' name='searchValue' style='width:100' class="font1" value="<%=requestMap.getString("searchValue")%>" onKeyPress="if(event.keyCode == 13) { go_search(); return false;}">
								</td>
								<td width="200" class="btnr">
									<input type="button" value="검색" onclick="go_search();return false;" class="boardbtn1">
									&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="콘텐츠 등록" onclick="go_add();return false;" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--//검색 -->
						<div class="space01"></div>


						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>NO</th>
								<th>과목명</th>
								<th>학습창템플릿</th>
								<th>학습창크기</th>
								<th>맛보기</th>
								<th class="br0">콘텐츠보기</th>
							</tr>
							</thead>

							<tbody>
							<%= listStr.toString() %>
							</tbody>
						</table>

						<div class="paging">
							<%=pageStr%>		
						</div>

						<!--//[e] 리스트  -->



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

