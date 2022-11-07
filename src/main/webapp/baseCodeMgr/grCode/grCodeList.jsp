<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시스템관리자 > 과정/콘텐츠관리 > 기초코드관리 > 과정코드관리 리스트.
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

	for(int i=0; i < listMap.keySize("grcode"); i++){

		listStr += "<tr bgColor='#FFFFFF' height='25'>";

		listStr += "<td align='center' class='tableline11' >" + (pageNum - i) + "</td>";
		listStr += "<td align='center' class='tableline11' ><a href=\"javascript:go_modify('"+listMap.getString("grcode", i)+"')\">" + listMap.getString("grcode", i) + "</a></td>";
		listStr += "<td align='center' class='tableline11' >" + listMap.getString("mcodeName", i) + "</td>";
		listStr += "<td align='center' class='tableline11' >" + listMap.getString("scodeName", i) + "</td>";
		listStr += "<td align='center' class='tableline11' >" + listMap.getString("grcodenm", i) + "&nbsp;</td>";
		listStr += "<td align='center' class='tableline11' >" + listMap.getString("useYn", i) + "&nbsp;</td>";
		listStr += "<td align='center' class='tableline21' >" + listMap.getString("grtime", i) + "&nbsp;</td>";
		//listStr += "<td align='center' class='tableline11' >" + listMap.getString("rullYn", i) + "&nbsp;</td>";
		//listStr += "<td align='center' class='tableline21' >" + listMap.getString("musicYn", i) + "&nbsp;</td>";

		listStr += "</tr>";

	}

	if( listMap.keySize("grcode") <= 0){

		listStr += "<tr bgColor='#FFFFFF'>";
		listStr += "<td align='center' class='tableline21' colspan='100%' height='100'>등록된 과정코드가 없습니다.</td>";
		listStr += "</tr>";

	}
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("grcode") > 0){
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
	if(IsValidCharSearch($("searchValue").value) == false){
		return false;
	}

	$("currPage").value = 1;
	go_list();
}


//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/baseCodeMgr/grCode.do";
	pform.submit();

}

//수정
function go_modify(grcode){

	$("mode").value = "form";
	$("qu").value = "update";
	$("grcode").value = grcode;
	pform.action = "/baseCodeMgr/grCode.do";

	pform.submit();

}

//등록
function go_add(){

	$("mode").value = "form";
	$("qu").value = "insert";
	pform.action = "/baseCodeMgr/grCode.do";

	pform.submit();

}

//로딩시.
onload = function()	{

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="grcode"				value=''>

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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과정코드관리 리스트</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->


			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!-- space --><table width="100%" height="15"><tr><td></td></tr></table>


						<!--[s] 검색 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#5071B4"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td width="80" align="center" class="tableline11"><strong>구분</strong></td>
								<td width="30%" align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<input type="radio" class="chk_01" name="searchKey" id="searchKey1" value="" <%=requestMap.getString("searchKey").equals("") ? "checked" : ""%>><label for="searchKey1">전체</label>
									<input type="radio" class="chk_01" name="searchKey" id="searchKey2" value="Y" <%=requestMap.getString("searchKey").equals("Y") ? "checked" : ""%>><label for="searchKey2">사용</label>
									<input type="radio" class="chk_01" name="searchKey" id="searchKey3" value="N" <%=requestMap.getString("searchKey").equals("N") ? "checked" : ""%>><label for="searchKey3">미사용</label>
								</td>
								<td width="80" align="center" class="tableline11"><strong>과정명</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<input type='text' onkeypress="if(event.keyCode==13){go_search();return false;}" name='searchValue' id="searchValue" style='width:100' class="font1" value="<%=requestMap.getString("searchValue")%>">
								</td>
								<td width="150" align="center" class="tableline21" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<input type="button" value="검색" class="boardbtn1" onclick="go_search()">
									<input type="button" value="과정추가" class="boardbtn1" onclick="go_add();">
									<!-- &nbsp;&nbsp;<input type="button" value="리스트" class="boardbtn1" onclick="go_list();"> -->
								</td>
							</tr>
							<tr bgcolor="#5071B4"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->



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
												<strong>번호</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>과정코드</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>과정분류</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>상세분류</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>과정명</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>사용여부</strong>
											</td>
											<td align='center' class="tableline21 white">
												<strong>이수시간</strong>
											</td>
<!-- 											<td align='center' class="tableline11 white">
												<strong>규정</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>악보이미지</strong>
											</td> -->
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

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>

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