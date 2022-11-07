<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 팝업존관리 리스트
// date  : 2011-07-7
// auth  : 김준호
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
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer html = new StringBuffer();
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("fyear") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	int currPage = requestMap.getInt("currPage");
	
	
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


//폼 페이지 이동
function go_form(){
	$("mode").value = "form";
	pform.action = "/homepageMgr/popzone.do";
	pform.submit();
}

//수정모드
function go_modify(seq){
	$("mode").value = "modForm";
	$('seq').value = seq;
	pform.action = "/homepageMgr/popzone.do";
	pform.submit();
}



//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value="<%=requestMap.getString("currPage")%>">
<input type="hidden" name="qu"		value="">
<input type="hidden" name="sYear"		value="<%=listMap.getString("") %>">
<input type="hidden" name="sDate"		value="">
<input type="hidden" name="eDate"		value="">
<input type="hidden" name="gubun"		value="">
<input type="hidden" name="seq"	id = "seq"	/>

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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>팝업존관리</strong>
					</td>
				</tr>
			</table> 
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"class="contentsTable">
				<tr>
					<td>
						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>기간</th>
							</tr>
							</thead>

							<tbody>
							<%
							if(listMap.keySize("seq") > 0){
								for(int i =0; i < listMap.keySize("seq"); i++){
							%>
							<tr>
								<td><%=listMap.getString("rm", i) %></td>
								<td><a href="javascript:go_modify('<%=listMap.getString("seq", i) %>')"><%=listMap.getString("title", i) %></a></td>
								<td><%=listMap.getString("startDt", i) %> ~ <%=listMap.getString("endDt", i) %></td>
							</tr>
							<%
								}
							}
							%>
	
							</tbody>
						</table>
						<!-- 테이블하단 버튼   -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="등록" onclick="go_form();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->
						
					</td>
				</tr>
			</table>	

	        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
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