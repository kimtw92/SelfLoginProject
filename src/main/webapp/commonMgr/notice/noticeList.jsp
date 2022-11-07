<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시스템관리자 > 시스템관리 > 홈페이지 관리 > 개인공지 관리 리스트.
// date : 2008-05-23
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

	String listStr = "";
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("seq"); i++){

		listStr += "<tr bgColor='#FFFFFF' height='25'>";

		listStr += "	<td align='center' class='tableline11' >" + (pageNum - i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' ><a href=\"javascript:go_view('"+listMap.getString("seq", i)+"')\">" + listMap.getString("title", i) + "</a></td>";

		tmpStr = (!listMap.getString("groupfileNo", i).equals("-1") ? "<a href='javascript:fileDownloadPopup("+listMap.getString("groupfileNo", i)+");'><img src=/images/compressed.gif border=0 valign='middle'>" : "&nbsp;");
		listStr += "	<td align='center' class='tableline11' >" + tmpStr + "</td>";
		
		tmpStr = (listMap.getString("notiGubun", i).equals("P") ? "개인" : "그룹");
		listStr += "	<td align='center' class='tableline11' >" + tmpStr + "</td>";

		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("regdate", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("username", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("visit", i) + "&nbsp;</td>";

		listStr += "</tr>";

	}

	if( listMap.keySize("seq") <= 0){

		listStr += "<tr bgColor='#FFFFFF'>";
		listStr += "	<td align='center' class='tableline11' colspan='100%' height='100'>등록된 공지사항이 없습니다.</td>";
		listStr += "</tr>";

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

//조회 버튼
function go_search() {

	if(IsValidCharSearch($F("searchValue"))){
		$("currPage").value = 1;
		go_list();
	}
}


//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/commonMgr/notice.do";
	pform.submit();

}

function go_view(seq){

	$("mode").value = "view";
	$("qu").value = "view";
	$("seq").value = seq;
	pform.action = "/commonMgr/notice.do";

	pform.submit();

}


//등록
function go_add(){

	$("mode").value = "form";
	$("qu").value = "insert";
	pform.action = "/commonMgr/notice.do";

	pform.submit();

}

//로딩시.
onload = function()	{

	var searchKey = '<%=requestMap.getString("searchKey")%>';
	$("searchKey").value = searchKey;

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>

<input type="hidden" name="seq"					value=''>
<input type="hidden" name="qu"					value=''>


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


			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>공지사항 리스트</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->


			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="100%"></td>
										</tr>
										<tr height='28' bgcolor="#5071B4">
											<td align='center' class="tableline11 white">
												<strong>NO</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>제목</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>첨부</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>구분</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>게시일자</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>작성자</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>조회</strong>
											</td>
										</tr>

										<%= listStr %>

									</table>
								</td>
							</tr>
						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#ffffff">
								<td align='center'>
									<%=pageStr%>
								</td>
							</tr>
						</table>

						<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="80%">
									<select name="searchKey" id="searchKey">
										<option value="">선택</option>
										<option value="TITLE">제목</option>
										<option value="CONTENT">내용</option>
									</select>
									&nbsp;<input type='text' name='searchValue' id="searchValue" style='width:100' class="font1" value="<%=requestMap.getString("searchValue")%>">
									<input type="button" value="검색" class="boardbtn1" onclick="go_search()">
								</td>
								<td width="20%" align="right">&nbsp;</td>
							</tr>
						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="50%">&nbsp;</td>
								<td width="50%" align="right">
									<input type="button" value="글쓰기" class="boardbtn1" onclick="go_add();">
								</td>
							</tr>
						</table>

						<!---[e] content -->
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->

			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

