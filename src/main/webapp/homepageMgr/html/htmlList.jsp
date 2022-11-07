<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : html관리
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
	if(listMap.keySize() > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	//컨텐츠
	StringBuffer html = new StringBuffer();
	if(listMap.keySize("menuid") > 0 ){
		for(int i=0; listMap.keySize("menuid") > i; i++){
			html.append("<tr>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+(pageNum-i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("htmlId",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("menuid",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("htmlTitle",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("ldate",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline21\" align=\"center\"><input class=\"boardbtn1\" type=\"button\" value=\"미리보기\" onclick=\"go_view('"+listMap.getString("htmlId",i)+"')\"></td>");			
			html.append("</tr>");
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

//미리보기 
function go_view(htmlId){
	$("htmlId").value = htmlId;
	$("mode").value="view";
	pform.action = "/homepageMgr/html.do";
	pform.submit();
}

//리스트
function go_list(){
	pform.action = "/homepageMgr/html.do";
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
	pform.action = "/homepageMgr/html.do";
	pform.submit();
}

//폼이동
function go_form(){
	$("mode").value = "form";
	$("qu").value = "insert";
	pform.action = "/homepageMgr/html.do";
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
<input type="hidden" name="htmlId" 				value="<%=requestMap.getString("htmlId") %>">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>HTML 관리</strong>
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
                   			<td align="right" colspan="100%" style="padding:0 0 0 0" width="100%"><input type="button" onclick="go_form();" class="boardbtn1" value="html등록"></td>
                   		</tr>
                   	</table>
					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						</tr>					
						<tr>
							<td bgcolor="#F7F7F7" width="100" align="center" class="tableline11">
								<strong>조회</strong>
							</td>
							<td style="padding-left:10px;" class="tableline11">
								<select name="selectType">
									<option value="all">전체</option>
									<option value="title">제목</option>
									<option value="content">내용</option>
								</select>
								&nbsp;															
								<input type="text" class="textfield"  onkeypress="if(event.keyCode==13){go_search();return false;}" name="selectValue" value="<%=requestMap.getString("selectValue") %>">

							</td>
							<td width="70" align="center" class="tableline21">
								<input type="button" class="boardbtn1" onClick="go_search();" value="검색">
							</td>
						</tr>	
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						</tr>						
					</table>

					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>                   	
					<table width="100%" border="0" cellpadding="0" cellspacing="0">					
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						</tr>
						<tr bgcolor="#5071B4">
						  <td height="28" width="50" align="center" class="tableline11 white" ><strong>NO</strong></td>
						  <td class="tableline11 white" align="center" width=""><strong>ID</strong></td>
						  <td class="tableline11 white" align="center" width=""><strong>메뉴 ID</strong></td>
						  <td class="tableline11 white" align="center" width=""><strong>제목</strong></td>
						  <td class="tableline11 white" align="center" width=""><strong>등록일</strong></td>
  						  <td class="tableline11 white" align="center" width="100"><strong>미리보기</strong></td>
						</tr>
						<%=html.toString() %>
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
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
<script language="JavaScript" type="text/JavaScript">
	//검색 조건 셀렉티드
	var selectType = "<%=requestMap.getString("selectType")%>";
	len = $("selectType").options.length
	
	for(var i=0; i < len; i++) {
		if($("selectType").options[i].value == selectType){
			$("selectType").selectedIndex = i;
		 }
 	 }
</script>
