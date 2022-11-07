<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 용어사전 리스트
// date  : 2008-05-30
// auth  : kang
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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	
	StringBuffer sbListHtml = new StringBuffer(); //목록
	
	String param = "";
	String pageStr = "";
	
	if(listMap.keySize("subj") > 0){
		
		for(int i=0; i < listMap.keySize("subj"); i++){
			
			param = "javascript:fnModity('" + listMap.getString("subj", i) + "','" + listMap.getString("dicSeq", i) + "')";
			
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + (pageNum - i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("subjnm", i) + "</td>");
			sbListHtml.append("	<td align=\"left\"   class=\"tableline11\" style='padding:0 0 0 10'><a href=\"" + param + "\">" + listMap.getString("words", i) + "</a></td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("typenm", i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline21\">" + listMap.getString("groups", i) + "</td>");
			sbListHtml.append("</tr>");			
		}
		
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
		
	}else{
		sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">작성된 글이 없습니다.</td>");		
		sbListHtml.append("</tr>");
	}
	

	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript" type="text/JavaScript">


// 검색
function fnSearch(){

	$("s_subj").value = $("searchSubj").value;
	$("s_groups").value = $("searchGroups").value;
	$("s_dicTypes").value = $("searchTypes").value;
	
	if(IsValidCharSearch($("searchTxt").value) == false){
		return;
	}else{
		$("s_searchTxt").value = $("searchTxt").value;
	}
	
	$("currPage").value = "";

	fnList();
	
}

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 새로고침
function fnReload(){
	$("currPage").value = "";
	$("s_subj").value = "";
	$("s_groups").value = "";
	$("s_dicTypes").value = "";
	$("s_searchTxt").value = "";
	
	fnList();
}

// 리스트
function fnList(){
	$("mode").value = "dicList";
	pform.submit();
}

// 추가
function fnReg(){
	$("mode").value = "dicReg";
	pform.submit();
}

// 수정
function fnModity(subj, dicSeq){

	var param = "";
	param = "?subj=" + subj;
	param += "&dicSeq=" + dicSeq
	
	$("mode").value = "dicModify";
	
	pform.action = "dic.do" + param;
	pform.submit();
}



</script>

<script for="window" event="onload">

	// 과목만들기	
	fnSingleSelectBoxByAjax("subj",
						"divSubj", 
						"searchSubj", 
						"subj", 
						"subjnm", 
						"<%= requestMap.getString("s_subj") %>", 
						"230", 
						"true", 
						"false", 
						"true");
	
	// 색인만들기	
	fnSingleSelectBoxByAjax("dicGroup", 
						"divDicGroup", 
						"searchGroups", 
						"groups", 
						"groups", 
						"<%= requestMap.getString("s_groups") %>", 
						"150", 
						"true", 
						"false", 
						"true");
	
	// 용어분류만들기
	fnSingleSelectBoxByAjax("dicType", 
						"divTypes", 
						"searchTypes", 
						"types", 
						"typenm", 
						"<%= requestMap.getString("s_dicTypes") %>", 
						"230", 
						"true", 
						"false", 
						"true");
	
	
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" action="dic.do">

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">

<!-- 검색 -->
<input type="hidden" name="s_subj"		value="<%= requestMap.getString("s_subj") %>">
<input type="hidden" name="s_groups"	value="<%= requestMap.getString("s_groups") %>">
<input type="hidden" name="s_dicTypes"	value="<%= requestMap.getString("s_dicTypes") %>">
<input type="hidden" name="s_searchTxt"	value="<%= requestMap.getString("s_searchTxt") %>">

<!-- 페이징 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">



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

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>용어사전 관리 리스트</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
					
						<!--[s] 상단 추가, 새로고침 버튼  -->
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="right">
									<input type="button" value="추 가" onclick="fnReg();" class="boardbtn1">
									&nbsp;
									<input type="button" value="새로고침" onclick="fnReload();" class='boardbtn1'>
								</td>
							</tr>
							<tr><td height="5"></td></tr>
						</table>						
						<!--[e] 상단 추가, 새로고침 버튼  -->
					
						<!--[s] 검색 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="5"></td></tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td width="100" align="center" class="tableline11"><strong>과목선택</strong></td>
								<td align="left" class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">
									<div id="divSubj">
										<select name="searchSubj"></select>
									</div>									
								</td>
								<td width="100" align="center" class="tableline11"><strong>검색어</strong></td>
								<td align="left" class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">
									<input type="text" name="searchTxt" class="textfield" size="20" value="<%= requestMap.getString("s_searchTxt") %>" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}">
								</td>
								<td rowspan="2" bgcolor="#FFFFFF" width="100" align="center">
									<input type="button" value="검 색" onclick="fnSearch();" class='boardbtn1'>
								</td>
							</tr>
							<tr height="28" bgcolor="F7F7F7">
								<td align="center" class="tableline11"><strong>용어분류</strong></td>
								<td align='left' class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">
									<div id="divTypes">
										<select name="searchTypes"></select>
									</div>
								</td>
								<td align="center" class="tableline11"><strong>색 인</strong></td>
								<td align="left" class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">
									<div id="divDicGroup">
										<select name="searchGroups"></select>
									</div>
								</td>
							</tr>														
							<tr bgcolor="#375694"><td height="2" colspan="5"></td></tr>
						</table>
						<!--[e] 검색 -->
						
						<!--[s] 리스트 -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="#5071B4">
								<td width="80" align="center" class="tableline11 white"><strong>번 호</strong></td>
								<td align="center" class="tableline11 white"><strong>과 목</strong></td>
								<td align="center" class="tableline11 white"><strong>용 어</strong></td>
								<td align="center" class="tableline11 white"><strong>분 류</strong></td>
								<td align="center" class="tableline11 white"><strong>색 인</strong></td>
							</tr>
							
							<%= sbListHtml.toString() %>
														
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>						
						<!--[e] 리스트 -->
						
						<!--[s] 페이징 -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#ffffff"><td align="center"><%=pageStr%></td></tr>
						</table>
						<!--[e] 페이징 -->
						<br><br>
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

	
</form>
</body>
					


