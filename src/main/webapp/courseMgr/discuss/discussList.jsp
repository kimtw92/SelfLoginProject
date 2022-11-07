<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%   
// prgnm : 과정 토론방 리스트 
// date : 2008-07-09
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

	String tmpStr = "";

	//상위글 리스트
	DataMap topListMap = (DataMap)request.getAttribute("TOP_LIST_DATA");
	topListMap.setNullToInitialize(true);

	StringBuffer topListStr = new StringBuffer(); //리스트 결과 변수.
	for(int i=0; i < topListMap.keySize("seq"); i++){

		topListStr.append("\n<tr bgcolor=orange>");

		//No
		topListStr.append("\n	<td>[토론주제]</td>");

		//제목
		tmpStr = "<a href=\"javascript:go_view(" + topListMap.getInt("seq", i) + ")\">" + topListMap.getString("title", i) + "</a>";
		topListStr.append("\n	<td class='sbj'>" + tmpStr + "</td>");

		//첨부
		tmpStr = (topListMap.getInt("groupfileNo", i) > 0) ? "<a href='javascript:fileDownloadPopup("+topListMap.getString("groupfileNo", i)+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : "없음";
		topListStr.append("\n	<td>" + tmpStr + "</td>");

		//작성자
		topListStr.append("\n	<td>" + topListMap.getString("username", i) + "</td>");
		
		//작성일
		topListStr.append("\n	<td class='br0'>" + topListMap.getString("regdate", i) + "</td>");

		topListStr.append("\n</tr>");

	}


	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	for(int i=0; i < listMap.keySize("seq"); i++){

		listStr.append("\n<tr>");

		//No
		listStr.append("\n	<td>" + (pageNum - i) + "</td>");

		tmpStr = "";
		//제목
		if( listMap.getInt("depth", i) > 0 ){
			for(int j=0; j < listMap.getInt("depth", i) ; j++)
				tmpStr += "&nbsp;";
			tmpStr += "<img src='/images/icon_re.gif' width='24' height='11' align='absmiddle'>";
		}
		tmpStr += "<a href=\"javascript:go_view(" + listMap.getInt("seq", i) + ")\">" + listMap.getString("title", i) + "</a>";
		listStr.append("\n	<td class='sbj'>" + tmpStr + "</td>");

		//첨부
		tmpStr = (listMap.getInt("groupfileNo", i) > 0) ? "<a href='javascript:fileDownloadPopup("+listMap.getString("groupfileNo", i)+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : "없음";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//작성자
		listStr.append("\n	<td>" + listMap.getString("username", i) + "</td>");
		
		//작성일
		listStr.append("\n	<td class='br0'>" + listMap.getString("regdate", i) + "</td>");

		listStr.append("\n</tr>");


	} //end for 



	//row가 없으면.
	if( topListMap.keySize("seq") <= 0 && listMap.keySize("seq") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' class='br0' style='height:100px'>토론글이 없습니다.</td>");
		listStr.append("\n</tr>");

	}


	//페이징 String
	String pageStr = "";
	if(listMap.keySize("seq") > 0){
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
	$("currPage").value = 1;
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

	pform.action = "/courseMgr/discuss.do";
	pform.submit();

}


//상세보기
function go_add(){

	if($F("grcode") == "" && $F("grseq") == ""){
		alert("과정 또는 과정 기수를 선택해주세요.");
		return;
	}

	$("mode").value = "form";
	$("qu").value = "insert";

	pform.action = "/courseMgr/discuss.do";
	pform.submit();

}

//상세보기
function go_view(seq){

	$("mode").value = "view";
	$("qu").value = "view";

	$("seq").value = seq;

	pform.action = "/courseMgr/discuss.do";
	pform.submit();

}





//로딩시.
onload = function()	{

	var searchKey = '<%=requestMap.getString("searchKey")%>';
	$("searchKey").value = searchKey;

	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = "grSeq"; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);

}

function go_formChk(){

	go_search();
}
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" onSubmit="go_formChk();return false;">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">

<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">

<input type="hidden" name="qu"					value="">
<input type="hidden" name="seq"					value="">

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
								<th width="80" class="bl0">
									년도
								</th>
								<td width="20%">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCommGrCode('grSeq');" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th width="80">
									과정명
								</th>
								<td>

									<div id="divCommGrCode" class="commonDivLeft">
										<select name="commGrcode" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>

								</td>
								<td width="100" class="btnr" rowspan="2">
									<input type="button" value="검색" onclick="go_search();return false;" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th class="bl0">
									기수명
								</th>
								<td>
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th class="bl0">
									구분
								</th>
								<td>
									<select name="searchKey" id="searchKey">
										<option value="">선택</option>
										<option value="TITLE">제목</option>
										<option value="CONTENT">내용</option>
									</select>
									&nbsp;<input type='text' name='searchValue' id="searchValue" style='width:100' class="font1" value="<%=requestMap.getString("searchValue")%>">
								</td>
							</tr>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>


						<!--[s] 리스트  -->

						<table class="datah01">
							<thead>
							<tr>
								<th>No</th>
								<th>제목</th>
								<th>첨부</th>
								<th>작성자</th>
								<th class="br0">작성일</th>
							</tr>
							</thead>

							<tbody>
							
							<%= topListStr.toString() %>
							<%= listStr.toString() %>
							</tbody>
						</table>


						<div class="paging">
							<%=pageStr%>		
						</div>

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="글쓰기" onclick="go_add();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->
						<div class="space01"></div>

						
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

