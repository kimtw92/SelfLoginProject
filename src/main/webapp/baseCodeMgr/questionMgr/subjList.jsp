<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 과목코드별 문항관리 리스트
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
	
	// 한글문자 인덱스
	DataMap charIndexMap = (DataMap)request.getAttribute("CHARINDEX_DATA");
	charIndexMap.setNullToInitialize(true);
	StringBuffer sbCharIndex = new StringBuffer();
	String charIndexBold = "";
	
	for(int i=0; i < charIndexMap.keySize("indexseq"); i++){
		sbCharIndex.append("<a href=\"javascript:fnCharIndex('" + charIndexMap.getString("indexseq", i) + "');\">");
		
		if( charIndexMap.getString("indexseq", i).equals( requestMap.getString("s_indexSeq") ) ){
			sbCharIndex.append("<b>" + charIndexMap.getString("startchar", i) + "</b>");
		}else{
			sbCharIndex.append( charIndexMap.getString("startchar", i) );
		}
				
		sbCharIndex.append("</a>&nbsp;");
	}
	
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	StringBuffer sbListHtml = new StringBuffer();
	
	String param = "";
	String pageStr = "";
	
	if(listMap.keySize("subj") > 0){
		for(int i=0; i < listMap.keySize("subj"); i++){
			String selGubunByMode = "";
			if( listMap.getString("selGubun", i).equals("P")){
				selGubunByMode = "oUform";	// 선택과목 수정시				
			}else{
				selGubunByMode = "sUform";	// 일반과목 수정시
			}
			
			param = "javascript:fnQuestionList('" + listMap.getString("subj", i) + "');";
			
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">").append(String.valueOf(pageNum - i)).append("</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">").append(listMap.getString("subj", i)).append("</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">").append(listMap.getString("selGubunNm", i)).append("</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">").append(listMap.getString("subjgubunNm", i)).append("</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">").append(listMap.getString("subjtypeNm", i)).append("</td>");
			sbListHtml.append("	<td align=\"left\"   class=\"tableline11\" style='padding:0 0 0 10'>").append(listMap.getString("subjnm", i)).append("</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\"><a href=\"").append(param).append("\">").append(listMap.getInt("qcnt", i)).append("</a></td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline21\">").append(listMap.getString("useYn", i)).append("</td>");
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
	
	
	
	// 검색 파라메터 세팅
	
	String[] aryUseYn = new String[3];
	
	aryUseYn[0] = "";
	aryUseYn[1] = "";
	aryUseYn[2] = "";
	
	if( requestMap.getString("s_useYn").equals("")){
		aryUseYn[0] = "checked";
	}else if( requestMap.getString("s_useYn").equals("Y")){
		aryUseYn[1] = "checked";
	}else if( requestMap.getString("s_useYn").equals("N")){
		aryUseYn[2] = "checked";	
	}
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript" type="text/JavaScript">

// 한글 인덱스 클릭시
function fnCharIndex(charindex){
	$("s_indexSeq").value = charindex;
	fnSearch();
}

// 검색
function fnSearch(){
	if(IsValidCharSearch($("s_searchTxt").value) == false){
		return;
	}

	// radio
	if( Form.Element.getValue("use") != null ){
		$("s_useYn").value = Form.Element.getValue("use");
	}else if( Form.Element.getValue("use_y") != null ){
		$("s_useYn").value = Form.Element.getValue("use_y");
	}else if( Form.Element.getValue("use_n") != null ){
		$("s_useYn").value = Form.Element.getValue("use_n");
	}
	
	$("currPage").value = "1";
	
	fnList();
}

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	$("mode").value = "subjList";
	pform.action = "questionMgr.do";
	pform.submit();
}

function fnQuestionList(subj) {
	var param = "";
	param = param + "?mode=questionList";
	param = param + "&subj=" + subj;
	
	$("s_useYn").value = "";
	$("s_searchTxt").value = "";
	$("currPage").value = "1";
	
	pform.action = "questionMgr.do" + param;
	pform.submit();
}


</script>

<script for="window" event="onload">

	$("s_subType").value = "<%= requestMap.getString("s_subType") %>";

</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode" value="<%= requestMap.getString("mode") %>">

<!-- 검색 -->
<input type="hidden" name="s_indexSeq" value="<%= requestMap.getString("s_indexSeq") %>">
<input type="hidden" name="s_useYn" value="<%= requestMap.getString("s_useYn") %>">

<!-- 페이징 -->
<input type="hidden" name="currPage" value="<%= requestMap.getString("currPage")%>">

<!-- 문항리스트에서 다시 과목 리스트로 이동 시 검색 및 페이징 유지를 위한 변수 -->
<input type="hidden" name="s_subjIndexSeq" value="<%= requestMap.getString("s_indexSeq") %>">
<input type="hidden" name="s_subjUseYn" value="<%= requestMap.getString("s_useYn") %>">
<input type="hidden" name="s_subjSearchTxt" value="<%= requestMap.getString("s_searchTxt") %>">
<input type="hidden" name="subjCurrPage" value="<%= requestMap.getString("currPage")%>">

<!-- 컨텐츠 회차 리스트용 -->
<input type="hidden" name="qu">
<input type="hidden" name="subj">
<input type="hidden" name="retType" value="subj">


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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>과목코드별 문항관리 과목리스트</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<br>
						<!--[s] 검색 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td width="80" align="center" class="tableline11"><strong>인덱스</strong></td>
								<td align="left" class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">
									<%= sbCharIndex.toString() %>
								</td>
								
								<td rowspan="2" bgcolor="#FFFFFF" width="100" align="center">
									<input type="button" value="검 색" onclick="fnSearch();" class="boardbtn1">
								</td>
							</tr>
							<tr height="28" bgcolor="F7F7F7">
								<td align="center" class="tableline11"><strong>검색</strong></td>
								<td align='left' class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">
									<input type="radio" name="use_yn" value=""  id="use"   <%= aryUseYn[0] %> >&nbsp;<label for="use">전체</label>&nbsp;
									<input type="radio" name="use_yn" value="Y" id="use_y" <%= aryUseYn[1] %> >&nbsp;<label for="use_y">사용</label>&nbsp;
									<input type="radio" name="use_yn" value="N" id="use_n" <%= aryUseYn[2] %> >&nbsp;<label for="use_n">미사용</label>
									&nbsp;&nbsp;
									<select name="s_subType">
										<option value="">과목유형선택</option>
										<option value="Y">사이버</option>
										<option value="N">집합</option>
										<option value="S">특수</option>
									</select>
									&nbsp;
									<input type="text" name="s_searchTxt" id="s_searchTxt" class="textfield" size="20" value="<%= requestMap.getString("s_searchTxt") %>" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}">
								</td>								
							</tr>														
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->
						
						<!--[s] 리스트  -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height='28' bgcolor="#5071B4">
								<td width="80" align="center" class="tableline11 white"><strong>번 호</strong></td>
								<td width="80" align="center" class="tableline11 white"><strong>과목코드</strong></td>
								<td align="center" class="tableline11 white"><strong>과목구분</strong></td>
								<td align="center" class="tableline11 white"><strong>과목유형</strong></td>
								<td align="center" class="tableline11 white"><strong>교과목분류</strong></td>
								<td align="center" class="tableline11 white"><strong>과목명</strong></td>
								<td align="center" class="tableline11 white"><strong>등록<br>문항수</strong></td>
								<td align="center" class="tableline11 white"><strong>사용<br>여부</strong></td>
							</tr>
							
							<%= sbListHtml.toString() %>
							
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>															
						<!--[e] 리스트  -->
						
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