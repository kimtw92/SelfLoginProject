<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : CyberPoll관리 리스트
// date : 2008-06-05
// auth : 정 윤철
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
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("titleNo") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	//컨텐츠
	StringBuffer html = new StringBuffer();
	if(listMap.keySize("titleNo") > 0 ){
		for(int i=0; listMap.keySize("titleNo") > i; i++){
			html.append("\n<tr>");
			html.append("\n	<td height=\"28\" class=\"tableline11\" align=\"center\">"+(i+1)+"</td>");
			html.append("\n	<td height=\"28\" class=\"tableline11\" align=\"center\"><a href=\"javascript:go_titleModify('"+listMap.getString("titleNo",i)+"')\">"+listMap.getString("title",i)+"</a></td>");
			html.append("\n	<td height=\"28\" class=\"tableline11\" align=\"center\"><input type=\"button\" class=\"boardbtn1\" value=\"수정\" onclick=\"go_subForm('"+listMap.getString("titleNo",i)+"');\"></td>");
			html.append("\n	<td height=\"28\" class=\"tableline11\" align=\"center\"><input type=\"button\" class=\"boardbtn1\" value=\"설문분석\" onclick=\"go_preview('"+listMap.getString("titleNo",i)+"');\"></td>");
			html.append("\n	<td height=\"28\" class=\"tableline11\" align=\"center\"><input type=\"button\" class=\"boardbtn1\" value=\"인쇄용\" onclick=\"go_preview('"+listMap.getString("titleNo",i)+"');\"></td>");
			html.append("\n	<td height=\"28\" class=\"tableline11\" align=\"center\"><input class=\"boardbtn1\" type=\"button\" value=\"미리보기\" onclick=\"go_htmlPreview('"+listMap.getString("titleNo",i)+"');\"></td>");			
			html.append("\n	<td height=\"28\" class=\"tableline21\" width=\"80\" align=\"center\">"+listMap.getString("sdate",i)+"<br>"+listMap.getString("edate",i)+"</td>");			
			html.append("\n</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("	<td colspan=\"100%\" height=\"300\" align=\"center\"> 등록된 글이 없습니다. </td>");
		html.append("</tr>");
		
	}
	
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//미리보기 팝업
function go_preview(titleNo){
	$("titleNo").value = titleNo;
	$("mode").value="previewPop";
	pform.action = "/poll/homepage.do";
	var popWindow = popWin('about:blank', 'majorPop11', '720', '500', 'yes', 'auto');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

//html미리보기
function go_htmlPreview(titleNo){
	$("titleNo").value = titleNo;
	$("mode").value="resultPop";
	pform.action = "/poll/homepage.do";
	var popWindow = popWin('about:blank', 'majorPop11', '516', '500', 'yes', 'auto');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

//수정 팝업
function go_subForm(titleNo){
	$("titleNo").value = titleNo;
	$("mode").value="subForm";
	pform.action = "/poll/homepage.do";
	pform.submit();
}

//리스트
function go_list(){
	pform.action = "/poll/homepage.do";
	pform.submit();
}


//조회
function go_search(){
	
	if(IsValidCharSearch($("selectValue").value) == false){
		$("selectValue").value="";
		$("selectValue").focus();
		return false;
	}
	$("currPage").value="";
	
	$("mode").value="list";
	pform.action = "/poll/homepage.do";
	pform.submit();
}


//설문 타이틀 등록 폼
function go_titleInsert(){
	$("mode").value = "form";
	$("qu").value = "insert";
	pform.action = "/poll/homepage.do";
	pform.submit();
	
}

//설문 타이틀 수정 폼
function go_titleModify(titleNo){
	$("titleNo").value = titleNo;
	$("mode").value = "form";
	$("qu").value = "modify";
	pform.action = "/poll/homepage.do";
	pform.submit();
	
}

</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<!-- 수정 삭제 시 사용되는 키값 -->
<input type="hidden" name="titleNo" 				value="">

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

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>Cyber Poll</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                    
                    					
					<!---[s] content -->
										<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
					<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                   		<tr>
                   			<td align="right" colspan="100%" style="padding:0 0 0 0" width="100%"><input type="button" onclick="go_titleInsert();" class="boardbtn1" value="신규설문작성"></td>
                   		</tr>
                   	</table>
					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="2" colspan="100%" bgcolor="#5071B4"></td>
						</tr>					
						<tr>
							<td bgcolor="#F7F7F7" width="100" align="center" class="tableline11">
								<strong>조회</strong>
							</td>
							<td style="padding-left:10px;" class="tableline11">
								<input type="text" maxlength="20" class="textfield" onkeypress="if(event.keyCode==13){go_search();return false;}" name="selectValue" value="<%=requestMap.getString("selectValue") %>">

							</td>
							<td width="70" align="center" class="tableline21">
								<input type="button" class="boardbtn1" onClick="go_search();" value="검색">
							</td>
						</tr>	
						<tr>
							<td height="2" colspan="100%" bgcolor="#5071B4"></td>
						</tr>						
					</table>

					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>                   	
					<table width="100%" border="0" cellpadding="0" cellspacing="0">					
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						</tr>
						<tr bgcolor="#5071B4">
						  <td height="28" width="50" align="center" class="tableline11 white" ><strong>번호</strong></td>
						  <td class="tableline11 white" align="center" width=""><strong>설문주제</strong></td>
						  <td class="tableline11 white" align="center" width="60"><strong>설문입력</strong></td>
						  <td class="tableline11 white" align="center" width="100"><strong>설문분석</strong></td>
						  <td class="tableline11 white" align="center" width="80"><strong>미리보기</strong></td>
  						  <td class="tableline11 white" align="center" width="100"><strong>미리보기</strong></td>
   						  <td class="tableline21 white" align="center" width="80" ><strong>기간</strong></td>
						</tr>
						<%=html.toString() %>
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694" style=""></td>
						</tr>
                    </table>
                    
                     <!---[e] content -->
                     <!---[s] content --><table width="100%" height="10"><tr><td></td></tr></table>
                   	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                   		<tr>
                   			<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                   		</tr>
                   	</table>
                   	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                   		<tr>
                   			<td width="100%" height="50" align="center"></td>
                   		</tr>
                   	</table>
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

