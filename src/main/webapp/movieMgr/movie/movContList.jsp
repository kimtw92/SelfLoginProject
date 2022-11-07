<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 동영상강의 학습 목록
// date  : 2009-06-03
// auth  : hwani
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
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	
	for(int i=0; i < listMap.keySize("contCode"); i++){
		
		String tmpStr = "";
		int rowNum	  = 0;
		
		listStr.append("\n<tr bgColor='#FFFFFF' height='25'>");
		
		//번호
		rowNum = ((requestMap.getInt("currPage") - 1) * 20) + (i+1);
		listStr.append("\n	<td align='center' class='tableline11'>" + rowNum + "</td>");
		// 섬네일 이미지
		listStr.append("\n	<td align='center' class='tableline11'>");
		if (listMap.getString("filePath",i).length() > 0){
			listStr.append("<img src=\""+listMap.getString("filePath",i)+"\" width=\"70\" height=\"60\">"); 
		} else {
			listStr.append("<img src=\"/images/skin4/icon/icon_memo01.gif\" width=\"70\" height=\"60\">");
		}
		listStr.append("</td>");
		
		//학습명
		tmpStr = "<a href=\"javascript:go_view('" + listMap.getString("contCode", i) + "')\">" + listMap.getString("contName", i) + "</a>";
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "</td>");

		//분류명(카테고리)
		listStr.append("\n	<td align='center' class='tableline11'>" + listMap.getString("divName", i) + "</td>");
		
		// 동영상 제작일시
		listStr.append("\n	<td align='center' class='tableline11'>" + listMap.getString("movEntDate", i) + "</td>");
		//등록일시
		// listStr.append("\n	<td align='center' class='tableline11'>" + listMap.getString("ldate", i) + "</td>");
		
		//학습시간
		tmpStr = listMap.getString("movTime", i) + "분 " + listMap.getString("movMin", i) + "초";
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "</td>");
		
		//수정
		tmpStr = "<input type='button' value='수정' class='boardbtn1' onClick=\"javascript:go_modify('"+listMap.getString("contCode", i)+"')\">";
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "</td>");
		
		//삭제
		tmpStr = "<input type='button' value='삭제' class='boardbtn1' onClick=\"javascript:go_delete('"+listMap.getString("contCode", i)+"')\">";
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "</td>");
		
		listStr.append("\n</tr>");

	} //END === for()


	//row가 없으면.
	if( listMap.keySize("contCode") <= 0){

		listStr.append("<tr bgColor='#FFFFFF'>");
		listStr.append("	<td align='center' class='tableline21' colspan='100%' height='100'> 등록된 동영상 콘텐츠가 없습니다.</td>");
		listStr.append("</tr>");

	}

	//페이징 String
	String pageStr = "";
	if(listMap.keySize("contCode") > 0){
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

// 리로딩 되는 함수.
function go_reload() {
	go_list();
}

//리스트
function go_list() {

	$("mode").value = "contList";

	pform.action = "/movieMgr/movie.do";
	pform.submit();

}

//분류 목록으로 이동
function go_divList() {

	$("mode").value = "list";

	pform.action = "/movieMgr/movie.do";
	pform.submit();

}

//동영상 팝업창 띄우기
function go_view(code) {

	var mode = "movView";
	var menuId = $F("menuId");
	//var url = "/movieMgr/movie.do?mode=" + mode + "&menuId=" + menuId + "&divCode=" + code;
	url = "/movieMgr/movie.do?mode=" + mode + "&menuId=" + menuId + "&contCode=" + code;

	popWin(url, "pop_contView", "800", "477", "0", "0");
}

//수정 팝업
function go_modify(code) {

	var mode 	= "contForm";
	var qu   	= "update";
	var menuId 	= $F("menuId");
	var divCode = $F("divCode");
	var url = "/movieMgr/movie.do?mode=" + mode + "&menuId=" + menuId + "&contCode=" + code + "&qu=" + qu + "&divCode=" + divCode;

	popWin(url, "pop_contForm", "650", "650", "0", "1");

}

//입력 팝업
function go_form() {

	var mode 	= "contForm";
	var qu   	= "insert"; 
	var menuId 	= $F("menuId");
	var divCode = $F("divCode");
	var url = "/movieMgr/movie.do?mode=" + mode + "&menuId=" + menuId + "&qu=" + qu + "&divCode=" + divCode;

	popWin(url, "pop_contForm", "650", "650", "0", "1");
}

//삭제
function go_delete(code) {

	if(confirm('해당 학습을 \n\n 삭제 하시겠습니까?')) {

		$("mode").value     = "contExec";
		$("qu").value       = "delete";
		$("contCode").value = code;
		pform.action = "/movieMgr/movie.do";
		pform.submit();
	}
}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"			value="<%= requestMap.getString("qu") %>">
<input type="hidden" name="reload"		value="GO">
<input type="hidden" name="contCode"	value="<%= requestMap.getString("contCode") %>">
<input type="hidden" name="divCode"		value="<%= requestMap.getString("divCode")%>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap="nowrap"><a href="/"><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></a></td>
        <td width="8" valign="top" nowrap="nowrap"><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
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

			<!--[s] subTitle -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp; <strong>동영상 콘텐츠  리스트</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!--[s] 검색 -->
						<br>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="right">
									<input type="button" value="동영상 콘텐츠 등록" class="boardbtn1" onclick="go_form();">&nbsp;
									<input type="button" value="동영상 분류 목록"	class="boardbtn1" onclick="go_divList();">&nbsp;
								</td>
							</tr>
						</table>
						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>

						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="100%"></td>
										</tr>
										<tr height='35' bgcolor="#5071B4">
											<td width="6%" align='center' class="tableline11 white">
												<strong>NO</strong>
											</td>
											<td width="10%" align='center' class="tableline11 white">
												<strong>이미지</strong>
											</td>
											<td width="30%" align='center' class="tableline11 white">
												<strong>학습명</strong>
											</td>
											<td width="10%" align='center' class="tableline11 white">
												<strong>분류명</strong>
											</td>
											<td width="10%" align='center' class="tableline11 white">
												<strong>제작일시</strong>
											</td>
											<!-- td width="15%" align='center' class="tableline11 white">
												<strong>등록일시</strong>
											</td -->
											<td width="8%" align='center' class="tableline11 white">
												<strong>학습시간</strong>
											</td>
											<td width="6%" align='center' class="tableline11 white">
												<strong>수정</strong>
											</td>
											<td width="6%" align='center' class="tableline11 white">
												<strong>삭제</strong>
											</td>
										
										</tr>

										<%= listStr.toString() %>

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

