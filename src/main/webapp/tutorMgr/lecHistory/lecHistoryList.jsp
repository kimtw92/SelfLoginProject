<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강의기록 입력 리스트
// date  : 2008-07-07
// auth  : kangs
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
	
	
	// 검색조건
	String searchName = requestMap.getString("searchName");
	String searchResno = requestMap.getString("searchResno");
	
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	
	// 페이징
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	String pageStr = "";
	
	String paramForm = "";
	String paramView = "";
	
	if(listMap.keySize("userno") > 0){		
		for(int i=0; i < listMap.keySize("userno"); i++){
			
			paramForm = "fnRegForm('" + listMap.getString("userno", i) + "');";
			paramView = "javascript:fnDetailAjax('" + listMap.getString("userno", i) + "');";
			
			sbListHtml.append("<tr style=\"height:25px\">");
			
			sbListHtml.append("	<td >" + (pageNum - i) + "</td>");
			sbListHtml.append("	<td >" + listMap.getString("resno", i) + "</td>");
			sbListHtml.append("	<td ><a href=\"" + paramView + "\">" + listMap.getString("name", i) + "</a></td>");
			sbListHtml.append("	<td style=\"text-align: center\">" + listMap.getString("tposition", i) + "</td>");
			sbListHtml.append("	<td >" + listMap.getString("tlevel", i) + "</td>");
			sbListHtml.append("	<td >" + listMap.getString("gubun", i) + "</td>");
			sbListHtml.append("	<td >" + listMap.getString("officeTel", i) + "</td>");
			sbListHtml.append("	<td ><input type=\"button\" value=\"강의기록입력\" class=\"boardbtn1\" style=\"width:80px\" onclick=\"" + paramForm + "\"  ></td>");			
			sbListHtml.append("	<td class=\"br0\"><input type=\"button\" value=\"출강확인서\" class=\"boardbtn1\" style=\"width:80px\" onclick=\"report('"+memberInfo.getSessNo()+"','" + listMap.getString("userno", i) + "')\"></td>");
						
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
	
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" src="/AIViewer/AIScript.js"></script>


<script language="JavaScript">
<!--

// 페이지 이동
function go_page(page) {

	$("currPage").value = page;
	$("mode").value = "list";
	pform.action = "/tutorMgr/lecHistory.do";
	pform.submit();
}

// 검색
function fnSearch(){
	$("currPage").value = "1";
	$("mode").value = "list";
	pform.action = "/tutorMgr/lecHistory.do";
	pform.submit();
}


//내역서를 출력 하는 이유 등록 팝업 페이지
function report(sessNo, userno){
	$("mode").value = "breakdownPop";
	$("userno").value = userno;
	$("sessNo").value = sessNo;
	$("breakDownGubun").value = "2";
	
	pform.action = "/member/member.do";
	var popup =popWin('about:blank','majorPop11', '600', '200', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
	
}


// 등록 팝업
function fnRegForm(userno){

	var url = "/tutorMgr/lecHistory.do";
	url += "?mode=formPop";
	url += "&userno=" + userno;
	
	pwinpop = popWin(url,"lecPop","500","350","no","no");
}

// 수정 팝업
function fnModifyForm(userno, grCode, grSeq, subj, no){

	var url = "/tutorMgr/lecHistory.do";
	url += "?mode=formPop";
	url += "&userno=" + userno;
	url += "&grCode=" + grCode;
	url += "&grSeq=" + grSeq;
	url += "&subj=" + subj;
	url += "&no=" + no;
	
	pwinpop = popWin(url,"lecPop","500","350","no","no");
}

// 삭제
function fnDelete(no, userno){
	
	var url = "/tutorMgr/lecHistory.do";
	var pars = "mode=delete";
	pars += "&no=" + no;
	
	if(confirm("삭제하시겠습니까 ?")){
	
		var myAjax = new Ajax.Request(
			url, 
			{
				asynchronous : "true",
				method : "get", 
				parameters : pars,
				onLoading : function(){								
				},
				onSuccess : function(originalRequest){
					alert(originalRequest.responseText.trim());
					fnDetailAjax(userno);										
				},
				onFailure : function(){					
					alert("삭제하는데 오류가 발생했습니다.");				
				}
			}
		);
	}
	
}


// 상세보기
function fnDetailAjax(userno){

	var url = "/tutorMgr/lecHistory.do";
	var pars = "mode=detailAjax";
	pars += "&userno=" + userno;

	var divId = "divLecHistory";
	
	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : "true",
			method : "get", 
			parameters : pars,
			onLoading : function(){								
			},
			onSuccess : function(){
				$("divLecHistory").style.display="";															
			},
			onFailure : function(){
				$("divLecHistory").style.display="none";
				alert("데이타 가져오는데 오류가 발생했습니다.");				
			}
		}
	);

}

//-->
</script>
<script for="window" event="onload">
<!--
	var userno = "<%=requestMap.getString("userno")%>";
	var breakDownGubun = "<%=requestMap.getString("breakDownGubun")%>";
	if(userno != "" && breakDownGubun != ""){
		popAI('http://152.99.42.130/report/report_90a.jsp?p_userno='+userno);
	}
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 출력내역서 구분 변수-->
<input type="hidden" name="breakDownGubun" value="<%= requestMap.getString("breakDownGubun")%>" >
<!-- 유저 번호 -->
<input type="hidden" name="userno" value="<%=requestMap.getString("userno") %>">
<!-- 세션번호 -->
<input type="hidden" name="sessNo" value="<%=requestMap.getString("sessNo") %>">

<!-- 페이징용 -->
<input type="hidden" name="currPage" 	id="currPage"	value="<%= requestMap.getString("currPage")%>">


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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강의기록입력</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			

			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80">성명</th>
								<td width="20%" >
									<input type="text" class="textfield" name="searchName" id="searchName" value="<%= searchName %>"  style="width:100px" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}" />
								</td>
								<th width="80">주민등록번호</th>
								<td>
									<input type="text" class="textfield" name="searchResno" id="searchResno" maxlength="13" value="<%= searchResno %>"  style="width:100px" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}" />
								</td>
								<td width="100" class="btnr">
									<input type="button" value="검색" onclick="fnSearch();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--//검색 -->
						<div class="space01"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th>주민번호</th>
								<th>이름</th>
								<th>소속</th>
								<th>등급</th>
								<th>담당분야</th>
								<th>전화번호</th>
								<th>강의기록입력</th>
								<th class="br0">출강확인서</th>
							</tr>
							</thead>

							<tbody>
							
							<%= sbListHtml.toString() %>
							
							</tbody>
						</table>
						<!--//리스트  -->	
						<div class="h5"></div>            						

						<!-- 페이징 --> 
						<br>						
						<div class="paging">
							<%=pageStr%>
						</div>
						<!-- //페이징 -->
						<div class="space01"></div>
					</td>
				</tr>
			</table>
			
			<!--[s] 상세 리스트  -->
			<div class="space_ctt_bt"></div>
			<div id="divLecHistory"></div>
			<!--[e] 상세 리스트  -->
			
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

<script language="JavaScript">
    document.write(tagAIGeneratorOcx);
</script>