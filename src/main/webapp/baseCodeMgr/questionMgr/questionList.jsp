<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과목코드별 문항관리 - 문항 목록
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
	
	DataMap rowMap = (DataMap)request.getAttribute("SUBJ_ROW_DATA");
	rowMap.setNullToInitialize(true);
	
	DataMap listMap = (DataMap)request.getAttribute("QUESTION_LIST_DATA");
	listMap.setNullToInitialize(true);
	
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	String subj = rowMap.getString("subj");
	String subjnm = rowMap.getString("subjnm");
	
	String[] aryUseYn = new String[3];
	
	aryUseYn[0] = "";
	aryUseYn[1] = "";
	aryUseYn[2] = "";
	
	if (requestMap.getString("s_useYn").equals("")) {
		aryUseYn[0] = "checked";
	} else if (requestMap.getString("s_useYn").equals("Y")) {
		aryUseYn[1] = "checked";
	} else if (requestMap.getString("s_useYn").equals("N")) {
		aryUseYn[2] = "checked";	
	}
	
	String[] aryDifficulty = new String[7];
	
	aryDifficulty[0] = "";
	aryDifficulty[1] = "";
	aryDifficulty[2] = "";
	aryDifficulty[3] = "";
	aryDifficulty[4] = "";
	aryDifficulty[5] = "";
	aryDifficulty[6] = "";
	
	if (requestMap.getString("s_difficulty").equals("")) {
		aryDifficulty[6] = "checked";
	} else if (requestMap.getString("s_difficulty").equals("0")) {
		aryDifficulty[0] = "checked";
	} else if (requestMap.getString("s_difficulty").equals("1")) {
		aryDifficulty[1] = "checked";	
	} else if (requestMap.getString("s_difficulty").equals("2")) {
		aryDifficulty[2] = "checked";	
	} else if (requestMap.getString("s_difficulty").equals("3")) {
		aryDifficulty[3] = "checked";	
	} else if (requestMap.getString("s_difficulty").equals("4")) {
		aryDifficulty[4] = "checked";	
	} else if (requestMap.getString("s_difficulty").equals("5")) {
		aryDifficulty[5] = "checked";	
	}
	
	String[] aryQType = new String[7];
	
	aryQType[0] = "";
	aryQType[1] = "";
	aryQType[2] = "";
	aryQType[3] = "";
	aryQType[4] = "";
	aryQType[5] = "";
	
	if (requestMap.getString("s_qType").equals("")) {
		aryQType[0] = "checked";
	} else if (requestMap.getString("s_qType").equals("1")) {
		aryQType[1] = "checked";
	} else if (requestMap.getString("s_qType").equals("2")) {
		aryQType[2] = "checked";	
	} else if (requestMap.getString("s_qType").equals("3")) {
		aryQType[3] = "checked";	
	} else if (requestMap.getString("s_qType").equals("4")) {
		aryQType[4] = "checked";	
	} else if (requestMap.getString("s_qType").equals("5")) {
		aryQType[5] = "checked";	
	}
	
	StringBuffer sbListHtml = new StringBuffer();
	
	String param = "";
	String pageStr = "";
	if (listMap.keySize("idQ") > 0) {
		for(int i=0; i < listMap.keySize("idQ"); i++) {
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\"><a href=\"javascript:fnView('").append(listMap.getString("idQ", i)).append("')\">").append(listMap.getString("idQ", i)).append("</a></td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">").append(String.valueOf(pageNum - i)).append("</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">").append(listMap.getString("difficulty", i)).append("</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">").append(listMap.getString("qtype", i)).append("</td>");
			sbListHtml.append("	<td align=\"left\" class=\"tableline11\">&nbsp;").append(listMap.getString("q", i)).append("&nbsp;</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">");
			sbListHtml.append(listMap.getString("ecnt", i));
			sbListHtml.append(" <input type='hidden' name='ecnt[]' value='").append(listMap.getString("ecnt", i)).append("'>");
			sbListHtml.append("</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">").append(listMap.getString("useYn", i)).append("</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline21\">").append("<INPUT TYPE='checkbox' NAME='qtId[]' value='").append(listMap.getString("idQ", i)).append("'>").append("</td>");
			sbListHtml.append("</tr>");
		}
		
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	} else {
		sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">등록된 문항이 없습니다.<br/>단일등록 또는 엑셀일괄등록 버튼을 통해 문항을 등록하기 바랍니다.</td>");		
		sbListHtml.append("</tr>");
	}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript" type="text/JavaScript">
//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

//리스트
function fnList(){
	$("mode").value = "questionList";
	pform.action = "questionMgr.do";
	pform.submit();
}

function fnSubjList() {
	$("s_indexSeq").value = $("s_subjIndexSeq").value;
	$("s_useYn").value = $("s_subjUseYn").value;
	$("s_searchTxt").value = $("s_subjSearchTxt").value;
	$("currPage").value = $("subjCurrPage").value;
	$("mode").value = "subjList";
	pform.action="/baseCodeMgr/questionMgr.do";
	pform.submit();
}

//검색
function fnSearch(){
	if(IsValidCharSearch($("s_searchTxt").value) == false){
		return;
	}

	// 난이도
	if (Form.Element.getValue("difficulty6") != null) {
		$("s_difficulty").value = Form.Element.getValue("difficulty6");
	} else if (Form.Element.getValue("difficulty0") != null) {
		$("s_difficulty").value = Form.Element.getValue("difficulty0");
	}  else if (Form.Element.getValue("difficulty1") != null) {
		$("s_difficulty").value = Form.Element.getValue("difficulty1");
	}  else if (Form.Element.getValue("difficulty2") != null) {
		$("s_difficulty").value = Form.Element.getValue("difficulty2");
	}  else if (Form.Element.getValue("difficulty3") != null) {
		$("s_difficulty").value = Form.Element.getValue("difficulty3");
	}  else if (Form.Element.getValue("difficulty4") != null) {
		$("s_difficulty").value = Form.Element.getValue("difficulty4");
	}  else if (Form.Element.getValue("difficulty5") != null) {
		$("s_difficulty").value = Form.Element.getValue("difficulty5");
	}
	
	// 사용여부
	if (Form.Element.getValue("use") != null) {
		$("s_useYn").value = Form.Element.getValue("use");
	} else if (Form.Element.getValue("use_y") != null) {
		$("s_useYn").value = Form.Element.getValue("use_y");
	} else if (Form.Element.getValue("use_n") != null) {
		$("s_useYn").value = Form.Element.getValue("use_n");
	}
	
	// 문제유형
	if (Form.Element.getValue("qType0") != null) {
		$("s_qType").value = Form.Element.getValue("qType0");
	} else if (Form.Element.getValue("qType1") != null) {
		$("s_qType").value = Form.Element.getValue("qType1");
	} else if (Form.Element.getValue("qType2") != null) {
		$("s_qType").value = Form.Element.getValue("qType2");
	} else if (Form.Element.getValue("qType3") != null) {
		$("s_qType").value = Form.Element.getValue("qType3");
	} else if (Form.Element.getValue("qType4") != null) {
		$("s_qType").value = Form.Element.getValue("qType4");
	} else if (Form.Element.getValue("qType5") != null) {
		$("s_qType").value = Form.Element.getValue("qType5");
	}
	
	$("currPage").value = "1";
	
	fnList();
}

function fnAllChk(objname){
	var obj = document.getElementsByName(objname);
	for(var i=0; i<obj.length; i++) {
		obj[i].checked = !(obj[i].checked);
	}
}

function fnSetUseYn(qu) {
	$("mode").value = "setUseYn";
	pform.action = "questionMgr.do?qu="+qu;
	pform.submit();	
}

function fnDelete() {
	var obj = document.getElementsByName('qtId[]');
	var obj2 = document.getElementsByName('ecnt[]');
	for(var i=0; i<obj.length; i++) {
		if (obj[i].checked == true) {
			if(obj2[i].value != "0") {
				alert("선택한 문항은 평가에 사용된 이력이 있어 삭제할 수 없습니다.");
				return false;
			}
		}
	}
	
	$("mode").value = "mDelete";
	pform.action = "questionMgr.do";
	pform.submit();	
}

function fnSingleInsert() {
	$("mode").value = "questionForm";
	pform.action = "questionMgr.do";
	pform.submit();	
}

function fnExcel() {
	$("mode").value = "questionExcel";
	pform.action = "questionMgr.do";
	pform.submit();
}

function fnView(idQ) {
	$("mode").value = "questionForm";
	pform.action = "questionMgr.do?mode="+$("mode").value+"&idQ="+idQ;
	pform.submit();	
}

function fnExcelInsert() {
	$("mode").value = "excelUpload";
	var popWindow = popWin('about:blank', 'majorPop11', '700', '340', 'auto', 'no');
	pform.action = "/baseCodeMgr/questionMgr.do";
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}
</script>

<script for="window" event="onload">
var sType = "<%= requestMap.getString("s_searchType") %>";

if (sType == null || sType == '') {
	$("s_searchType").value = 'Q';
} else {
	$("s_searchType").value = sType;
}
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<form id="pform" name="pform" method="post">

<input type="hidden" name="menuId" id="menuId" value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode" id="mode" value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="subj" id="subj" value="<%= subj %>">
<input type="hidden" name="subjnm" id="subjnm" value="<%= subjnm %>">

<!-- 과목 리스트 검색결과 유지 -->
<input type="hidden" name="s_subjIndexSeq" value="<%= requestMap.getString("s_subjIndexSeq") %>">
<input type="hidden" name="s_indexSeq">
<input type="hidden" name="s_subjUseYn" value="<%= requestMap.getString("s_subjUseYn") %>">
<input type="hidden" name="s_subType" value="<%= requestMap.getString("s_subType") %>">
<input type="hidden" name="s_subjSearchTxt" value="<%= requestMap.getString("s_subjSearchTxt") %>">
<!-- 과목 리스트 페이징 유지 -->
<input type="hidden" name="subjCurrPage" id="subjCurrPage" value="<%= requestMap.getString("subjCurrPage")%>">

<!-- 검색 -->
<input type="hidden" name="s_difficulty" value="<%= requestMap.getString("s_difficulty") %>">
<input type="hidden" name="s_useYn" value="<%= requestMap.getString("s_useYn") %>">
<input type="hidden" name="s_qType" value="<%= requestMap.getString("s_qType") %>">

<!-- 페이징 -->
<input type="hidden" name="currPage" id="currPage" value="<%= requestMap.getString("currPage")%>">

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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>과목코드별 문항관리 문항 리스트</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!--[s] 검색 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td width="80" align="center" class="tableline11"><strong>과목명</strong></td>
								<td colspan="3" align="left" class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9"><%=subjnm %></td>
								<td rowspan="3" bgcolor="#FFFFFF" width="100" align="center">
									<input type="button" value="검 색" onclick="fnSearch();" class="boardbtn1">
								</td>
							</tr>
							<tr height="28" bgcolor="F7F7F7">
								<td align="center" class="tableline11"><strong>난이도</strong></td>
								<td align='left' class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">
									<input type="radio" name="difficulty" value="" id="difficulty6" <%= aryDifficulty[6] %> >&nbsp;<label for="difficulty6">전체</label>&nbsp;
									<input type="radio" name="difficulty" value="0" id="difficulty0" <%= aryDifficulty[0] %> >&nbsp;<label for="difficulty0">없음</label>&nbsp;
									<input type="radio" name="difficulty" value="1" id="difficulty1" <%= aryDifficulty[1] %> >&nbsp;<label for="difficulty1">최상</label>
									<input type="radio" name="difficulty" value="2" id="difficulty2" <%= aryDifficulty[2] %> >&nbsp;<label for="difficulty2">상</label>&nbsp;
									<input type="radio" name="difficulty" value="3" id="difficulty3" <%= aryDifficulty[3] %> >&nbsp;<label for="difficulty3">중</label>
									<input type="radio" name="difficulty" value="4" id="difficulty4" <%= aryDifficulty[4] %> >&nbsp;<label for="difficulty4">하</label>&nbsp;
									<input type="radio" name="difficulty" value="5" id="difficulty5" <%= aryDifficulty[5] %> >&nbsp;<label for="difficulty5">최하</label>
								</td>
								<td align="center" class="tableline11"><strong>사용여부</strong></td>
								<td align='left' class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">
									<input type="radio" name="use_yn" value=""  id="use"   <%= aryUseYn[0] %> >&nbsp;<label for="use">전체</label>&nbsp;
									<input type="radio" name="use_yn" value="Y" id="use_y" <%= aryUseYn[1] %> >&nbsp;<label for="use_y">사용</label>&nbsp;
									<input type="radio" name="use_yn" value="N" id="use_n" <%= aryUseYn[2] %> >&nbsp;<label for="use_n">미사용</label>
								</td>
							</tr>
							<tr height="28" bgcolor="F7F7F7">
								<td align="center" class="tableline11"><strong>문제유형</strong></td>
								<td colspan="3" align='left' class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">
									<input type="radio" name="qType" value=""  id="qType0" <%= aryQType[0] %> >&nbsp;<label for="qType0">전체</label>&nbsp;
									<input type="radio" name="qType" value="1" id="qType1" <%= aryQType[1] %> >&nbsp;<label for="qType1">OX형</label>&nbsp;
									<input type="radio" name="qType" value="2" id="qType2" <%= aryQType[2] %> >&nbsp;<label for="qType2">선다형</label>
									<input type="radio" name="qType" value="3" id="qType3" <%= aryQType[3] %> >&nbsp;<label for="qType3">복수 답안형</label>&nbsp;
									<input type="radio" name="qType" value="4" id="qType4" <%= aryQType[4] %> >&nbsp;<label for="qType4">단답형</label>
									<input type="radio" name="qType" value="5" id="qType5" <%= aryQType[5] %> >&nbsp;<label for="qType5">논술형</label>
									&nbsp;&nbsp;
									<select name="s_searchType">
										<option value="Q">문항</option>
										<option value="E">보기</option>
										<option value="X">해설</option>
										<option value="H">힌트</option>
										<option value="T">지문</option>
									</select>
									&nbsp;
									<input type="text" name="s_searchTxt" id="s_searchTxt" class="textfield" size="20" value="<%= requestMap.getString("s_searchTxt") %>" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}">
								</td>
							</tr>
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->
						<br>
						<!--[s] 상단 버튼  -->
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="right">
									<input type="button" value="단일등록" onclick="fnSingleInsert();" class="boardbtn1">
									<input type="button" value="엑셀일괄등록" onclick="fnExcelInsert();" class='boardbtn1'>
									<input type="button" value="엑셀일괄저장" onclick="fnExcel();" class='boardbtn1'>
									<a class='boardbtn1' href="/down/question.xls">엑셀 서식 다운로드</a>
								</td>
							</tr>
						</table>
						<!--[e] 상단 버튼  -->
						
						<!--[s] 리스트  -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height='28' bgcolor="#5071B4">
								<td align="center" class="tableline11 white"><strong>Q_ID</strong></td>
								<td align="center" class="tableline11 white"><strong>번 호</strong></td>
								<td align="center" class="tableline11 white"><strong>난이도</strong></td>
								<td align="center" class="tableline11 white"><strong>문제유형</strong></td>
								<td width="70%" align="center" class="tableline11 white"><strong>문항</strong></td>
								<td align="center" class="tableline11 white"><strong>출제<br/>횟수</strong></td>
								<td align="center" class="tableline11 white"><strong>사용<br/>여부</strong></td>
								<td align="center" class="tableline11 white">
									<strong>전체<br/>선택</strong>
									<br/>
									<INPUT TYPE='checkbox' NAME='allCheck' onClick="allChk('qtId[]');" id="allCheck">
								</td>
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
						
						
						<!--[s] 하단 버튼  -->
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="right">
									<input type="button" value="사용함" onclick="fnSetUseYn('Y');"  class="boardbtn1" >
									<input type="button" value="사용안함" onclick="fnSetUseYn('N');"  class="boardbtn1" >
									<input type="button" value="삭제" onclick="fnDelete();"  class="boardbtn1" >
									<input type="button" value="과목목록" onclick="fnSubjList();"  class="boardbtn1" >
								</td>
							</tr>
							<tr><td height="5"></td></tr>
						</table>
						<!--[e] 하단 버튼  -->
						
					
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<iframe id="download" name="download" height="0px" frameborder="0"></iframe>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>