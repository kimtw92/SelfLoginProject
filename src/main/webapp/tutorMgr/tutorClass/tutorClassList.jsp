<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사지정 리스트
// date  : 2008-06-27
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
	
	
	
	// 검색용
	String searchSubj = requestMap.getString("searchSubj");
	
	
	
	
	// 과목 셀렉트 박스용
	StringBuffer sbSubjHtml = new StringBuffer();
	DataMap subjMap = (DataMap)request.getAttribute("SUBJ_DATA");
	if(subjMap == null) subjMap = new DataMap();
	subjMap.setNullToInitialize(true);
	
	String tmpSelected = "";
	
	sbSubjHtml.append("<select name=\"searchSubj\" id=\"searchSubj\" class=\"mr10\" >");
	sbSubjHtml.append("<option value=\"\">** 전체 **</option>");
	if(subjMap.keySize("subj") > 0){		
		for(int i=0; i < subjMap.keySize("subj"); i++){
			
			if( subjMap.getString("subj", i).equals(searchSubj) ){
				tmpSelected = "selected";
			}else{
				tmpSelected = "";
			}
			
			sbSubjHtml.append("<option value=\"" + subjMap.getString("subj", i) + "\"  " + tmpSelected + " >" + subjMap.getString("lecnm", i) + "</option>");			
		}
	}
	sbSubjHtml.append("</select>");
	
	
	
	
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	
	// 페이징
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	String pageStr = "";
	String paramUpdate = "";
	String paramInsert = "";
	String paramFileDown = "";
	String paramTutorInfoPop = "";
	
	if(listMap.keySize("grcode") > 0){		
		for(int i=0; i < listMap.keySize("grcode"); i++){
			
			paramUpdate = "javascript:fnForm('" + listMap.getString("grcode", i) + "','" + listMap.getString("grseq", i) + "','" + listMap.getString("subj", i) + "','" + listMap.getString("classno", i) + "','update');  ";
			paramInsert = "javascript:fnForm('" + listMap.getString("grcode", i) + "','" + listMap.getString("grseq", i) + "','" + listMap.getString("subj", i) + "','" + listMap.getString("classno", i) + "','insert');  ";
			paramTutorInfoPop = "javascript:fnPrintInfo('" + listMap.getString("userno", i) + "');";
						
			sbListHtml.append("<tr style=\"height:25px\">");
			
			if(	!listMap.getString("rowCount", i).equals("")  ){
				sbListHtml.append("	<td align=\"center\" rowspan=\"" + listMap.getString("rowCount", i) + "\" ><a href=\"" + paramUpdate + "\">" + listMap.getString("lecnm", i) + "</a></td>");
				sbListHtml.append("	<td align=\"center\" rowspan=\"" + listMap.getString("rowCount", i) + "\" >" + listMap.getString("classnm", i) + "</td>");
				sbListHtml.append("	<td align=\"center\" rowspan=\"" + listMap.getString("rowCount", i) + "\" >" + listMap.getString("eduinwon", i) + "</td>");			
			}
									
			sbListHtml.append("	<td align=\"center\" ><a href=\"" + paramTutorInfoPop + "\">" + listMap.getString("name", i) + "</a></td>");
			sbListHtml.append("	<td align=\"center\" >" + listMap.getString("tgubunNm", i) + "</td>");

			paramFileDown = (listMap.getInt("groupfileNo", i) != 0 ? "<a href='javascript:fileDownloadPopup("+listMap.getString("groupfileNo", i)+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : "&nbsp;");
			sbListHtml.append("	<td align=\"center\" >" + paramFileDown + "</td>");
			
			if(	!listMap.getString("rowCount", i).equals("")  ){
				sbListHtml.append("	<td align=\"center\" class=\"br0\" rowspan=\"" + listMap.getString("rowCount", i) + "\" ><a href=\"" + paramInsert + "\">강사추가</a></td>");
			}
			
			sbListHtml.append("</tr>");
						
		}
		
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
		
	}else{
		sbListHtml.append("<tr>");
		sbListHtml.append("	<td align=\"center\" style=\"height:100px\" colspan=\"100%\" class=\"br0\">검색결과가 없습니다.</td>");
		sbListHtml.append("</tr>");
	}
	
	
	String btnVisible = "";
	if( memberInfo.getSessClass().equals("0") ||
		memberInfo.getSessClass().equals("2") ||
		memberInfo.getSessClass().equals("A") ){
		
		btnVisible = "";
	}else{
		btnVisible = "style=\"display:none\"";
	}
	
			
			
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--

// 페이지 이동
function go_page(page) {

	if( $F("selGrCode") == "" || $F("selGrSeq") == "" ){
		alert("좌측에서 년도, 과정, 기수를 선택하세요.");
		return false;
	}

	$("currPage").value = page;
	$("mode").value = "list";
	pform.action = "/tutorMgr/tclass.do";
	pform.submit();
}

// 검색
function fnSearch(){

	if( $F("selGrCode") == "" || $F("selGrSeq") == "" ){
		alert("좌측에서 년도, 과정, 기수를 선택하세요.");
		return false;
	}

	$("currPage").value = "1";
	$("mode").value = "list";
	pform.action = "/tutorMgr/tclass.do";
	pform.submit();
}

// 등록,수정 화면
function fnForm(grcode, grseq, subj, classno, flag){
	
	$("mode").value = "form";
	
	$("grcode").value = grcode;
	$("grseq").value = grseq;
	$("subj").value = subj;
	$("classno").value = classno;
	$("modeType").value = flag;
	
	pform.action = "/tutorMgr/tclass.do";
	pform.submit();
	
}

// 강사정보 팝업
//function fnPrintInfo(userno){
//
//	var url = "/tutorMgr/tclass.do";
//	url += "?mode=infoPop";
//	url += "&userno=" + userno;
//	
//	pwinpop = popWin(url,"infoPop","800","700","yes","no");
//
//}

function fnPrintInfo(userNo){
	
	$("mode").value = "tutorPopView";
	var popWindow = popWin('about:blank', 'majorPop11', '700', '800', '1', '0')
	pform.action = "/tutorMgr/tclass.do?mode=infoPop&userno=" + userNo;
	// pform.action = "tutor.do?type=3&userno=" + userNo;
	pform.target = "majorPop11";
	pform.submit();
	$("mode").value="";
	pform.target = "";

}


//-->
</script>
<script for="window" event="onload">
<!--

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">


<!-- 페이징용 -->
<input type="hidden" name="currPage" 	id="currPage"	value="<%= requestMap.getString("currPage")%>">
<input type="hidden" name="s_currPage" 	id="s_currPage"	value="<%= requestMap.getString("currPage")%>">

<input type="hidden" name="modeType" 	id="modeType" >
<input type="hidden" name="grcode" 		id="grcode" >
<input type="hidden" name="grseq" 		id="grseq" >
<input type="hidden" name="subj" 		id="subj" >
<input type="hidden" name="classno" 	id="classno" >


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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강사지정</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			
			
			<!--[s] Contents Form  -->
			<div class="h10"></div>
			
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">과목명</th>
								<td>
									<%= sbSubjHtml.toString() %>
								</td>
								<td width="100" class="btnr">
									<input type="button" value="검색" onclick="fnSearch();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--//검색 -->
						<div class="space01"></div>

						<!-- 상단 버튼  -->
						<table class="btn01" <%= btnVisible %> >
							<tr>
								<td class="right">									
									<input type="button" value="시간표" onclick="fnGoTimeTableByAdmin();" class="boardbtn1">
									<input type="button" value="과정기수관리" onclick="fnGoCourseSeqByAdmin();" class="boardbtn1">
								</td>
							</tr>
							<tr><td height="5"></td></tr>
						</table>						
						<!--// 상단 버튼  -->

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>과목명</th>
								<th>반명</th>
								<th>반인원</th>
								<th>강사명</th>
								<th>강사구분</th>
								<th>첨부파일</th>
								<th class="br0">기능</th>
							</tr>
							</thead>

							<tbody>
							<%= sbListHtml.toString() %>
							</tbody>
						</table>
						<!--//리스트  -->	
						<div class="h5"></div>
            
						<!--[s] 페이징 -->
						<br>						
						<div class="paging">
							<%=pageStr%>
						</div>						
						<!--[e] 페이징 -->
						
						
					</td>
				</tr>
			</table>

			<div class="space_ctt_bt"></div>
						
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>