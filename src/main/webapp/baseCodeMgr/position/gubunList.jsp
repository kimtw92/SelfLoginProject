<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 직급구분코드 리스트
// date : 2008-05-14
// auth : 정윤철
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
	
	DataMap listMap = (DataMap)request.getAttribute("GUBUNLIST_DATA");
	listMap.setNullToInitialize(true);
	
	DataMap selectBoxMap = (DataMap)request.getAttribute("SELECTBOX_DATA");
	selectBoxMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//직급코드관리 셀렉트박스 리스트
	StringBuffer selectBoxList = new StringBuffer();
	for(int i=0;selectBoxMap.keySize("jikgubunnm") >i;i++){
		selectBoxList.append("<option value=\""+selectBoxMap.getString("jikgubun",i)+"\">"+selectBoxMap.getString("jikgubunnm",i)+"");
	}
	
	//직급코드관리 리스트 
	StringBuffer contentList = new StringBuffer();
	if(listMap.keySize("jikgubunnm") > 0 ){
		for(int i=0; listMap.keySize("jikgubunnm") > i; i++) {
			contentList.append("<tr>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(pageNum - i)+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(!listMap.getString("jikgubunnm",i).equals("") ? listMap.getString("jikgubunnm",i) : "&nbsp")+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(!listMap.getString("code",i).equals("") ? listMap.getString("code",i) : "&nbsp")+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(!listMap.getString("codenm",i).equals("") ? listMap.getString("codenm",i) : "&nbsp")+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(!listMap.getString("orders",i).equals("") ? listMap.getString("orders",i) : "&nbsp")+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline21\" align=\"center\">"+(!listMap.getString("useYn",i).equals("") ? listMap.getString("useYn",i) : "&nbsp")+"</td>");
			contentList.append("</tr>");
		}
	}else{
		contentList.append("	<tr>");
		contentList.append("		<td colspan=\"100%\" class=\"tableline11\" align=\"center\" height=\"100\"> 등록된 자료가 없습니다. </td>");
		contentList.append("	</tr>");
	}
	
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("jikgubunnm") > 0){
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
	//페이징 리스트
	function go_list(){
		$("mode").value = "guBunCodeList";
		pform.submit();
	}
	//직급구분별 리스트
	function go_gubunList(){
		$("mode").value = "guBunCodeList";
		$("currPage").value ="";
		pform.submit();
	}
		//페이지 이동
	function go_page(page) {
		$("currPage").value = page;
		go_list();
	}	

	//팝업 폼
	function go_form(qu){
		$("mode").value = "guBunCodeForm";
		$("qu").value = qu;
		var popWindow = popWin('about:blank', 'majorPop11', '320', '300', 'auto', 'no');
		pform.target = "majorPop11";
		pform.submit();
		pform.target = "";
	}
	
	
	//일괄등록
	function goAllInsert(){
		$("mode").value = "guBunCodeUploadForm";
		var popWindow = popWin('about:blank', 'majorPop11', '700', '340', 'auto', 'no');
		pform.action = "/baseCodeMgr/position.do";
		pform.target = "majorPop11";
		pform.submit();
		pform.target = "";
	}
	

</script>
	
	
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" action="/baseCodeMgr/position.do">

	<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
	<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
	<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
	<input type="hidden" name="qu">
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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>직급구분코드 관리 리스트</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->
			
			
			<!-- buuton[s] -->
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsTable">
				<tr>
					<td colspan="3">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td align="right">
									<input type="button" onClick="go_form('insert');"  value="개별입력" class="boardbtn1">&nbsp;&nbsp;
									<input type="button" onClick="goAllInsert();"  value="일괄입력" class="boardbtn1">&nbsp;&nbsp;
									<input type="button" onClick="fnGoFileDown('jikgubun.xls', '/excel/');"  value="업로드파일 서식 다운로드" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<td height="2" bgcolor="#5071B4" style="width:85%" ></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td >
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="" >
							<tr>
								<td class="tableline11">&nbsp;</td>
								<td width="100" height="28"class="tableline11" bgcolor="#F7F7F7" align="center"> <Strong>코드 구분 선택 :</Strong></td>
								<td width="100" height="20" class="tableline21"align="center" style="padding:0 0 0 0">
									<select name="guBun" style="width:80px;text-align:center;" onChange="go_gubunList();">
									<option value="">전체</option>
									<%=selectBoxList.toString() %>
									</select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
							<tr>
								<td height="2" bgcolor="#5071B4" style="width:85%" ></td>
							</tr>
							<tr>
								<td height="2"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<!-- buuton[e] -->
			
			
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                        <!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694">
								<td height="2" colspan="9"></td>
							</tr>
							
							<tr bgcolor="#5071B4">
								<td height=28 align="center" class="tableline11 white"><strong>번호</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>구분명</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>코드</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>코드명</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>서열</strong></td>
								<td height="28" align="center" class="tableline21 white" ><strong>사용</strong></td>
							</tr>
								<%=contentList.toString() %>
							<tr>
								<td height="2" colspan="100%" bgcolor="#375694"></td>
							</tr>
						</table>
                        <!---[e] content -->
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<!-- pageing[s] -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td colspan="8" align="center">
						<%=pageStr %>
					</td>
				</tr>
				
			</table>
			<!-- space --><table><tr><td height="30">&nbsp;</td></tr></table>
			<!-- pageing[e] -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

<script language="JavaScript" type="text/JavaScript">
//직종 셀렉티드
 	var guBun = "<%=requestMap.getString("guBun")%>";
 	len = $("guBun").options.length
	 for(var i=0; i < len; i++) {
	     if($("guBun").options[i].value == guBun){
	      	$("guBun").selectedIndex = i;
		 }
 	 }
</script>

