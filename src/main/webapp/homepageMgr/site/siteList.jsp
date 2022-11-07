<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 참고사이트관리
// date : 2008-06-19
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
	if(listMap.keySize("siteNo") > 0 ){
		for(int i=0; listMap.keySize("siteNo") > i; i++){
			html.append("<tr>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\"><input type=\"checkBox\" id=\"check\" name=\"check"+i+"\" value=\"Y\"><input type=\"hidden\" name=\"siteNo"+i+"\" value=\""+listMap.getString("siteNo",i)+"\"></td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"left\" style=\"padding-left:10px\"><a href=\"javascript:go_form('modify','"+listMap.getString("siteNo",i)+"');\">"+listMap.getString("siteName",i)+"</a></td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\" style=\"padding-left:10px\">"+listMap.getString("siteAddr",i)+"("+listMap.getString("siteZipCode")+")"+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("siteTel",i)+"</td>");	
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

function go_form(qu,siteNo){
	//폼이동
	$("mode").value="form";
	$("qu").value=qu;
	$("siteNo").value=siteNo;
	var popWindow = popWin('about:blank', 'majorPop11', '400', '300', 'no', 'no');
	pform.action = "/homepageMgr/site.do";
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

function go_delete(){

	var chk = 0;
	var siteNo = <%=listMap.keySize("siteNo")%>;
	
	for(i=0	;i<=siteNo-1;i++){
		if($("check"+i).checked  == true){
		chk = 1;
		}
	}
	
	if(chk == 0){
		alert("삭제할 항목을 선택하여 주십시오.");
		return false;
	}
	
	//관련사이트 삭제
	if(confirm("삭제 하시겠습니까?")){
		$("mode").value="exec";
		$("qu").value="delete";
		pform.action = "/homepageMgr/site.do";
		pform.submit();
	}
}

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}
//기관별 리스트. 비교값은 기관명 그대로 쓴다.. 예:)  siteType ='전체'
function go_gubunList(siteType){
	$("siteType").value = siteType;
	$("mode").value="list";
	$("currPage").value="";
	go_list();
}

//리스트
function go_list(){
	pform.action = "/homepageMgr/site.do";
	pform.submit();
}

//전체 체크박스 체크드
function go_check() {
	var siteNo = <%=listMap.keySize("siteNo")%>;

	if(document.getElementById("allCheck").checked == true) {
		for(i=0	;i<=siteNo-1;i++){
			$("check"+i).checked  = true;
		}
	} else {
		for(i=0	;i<=siteNo-1;i++){
			$("check"+i).checked  = false;
		}
	}
}
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value="<%=requestMap.getString("currPage")%>">
<input type="hidden" name="siteType"			value="<%=requestMap.getString("siteType") %>">
<!-- siteNo 수정시 사용 -->
<input type="hidden" name="siteNo"			value="<%=requestMap.getString("siteNo")%>">

<!-- 삭제시 사용 키값으로 사용-->
<input type="hidden" name="keySize" value="<%=listMap.keySize()%>">
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>참고사이트관리</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td width="100%" align="right"> <input type="button" value="관련사이트추가" class=boardbtn1 onclick="go_form('insert','');">&nbsp;<input type="button" value="삭제" class=boardbtn1 onclick="go_delete();"></td>
				</tr>
			</table>	
			<!-- space --><table height="10"><tr><td>&nbsp;</td></tr></table>
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td width="100%" align="center">
						<a href="javaScript:go_gubunList('');">전체</a> |
						<a href="javaScript:go_gubunList('중앙부처교육기관');">중앙부처교육기관</a> |
						<a href="javaScript:go_gubunList('지방자치단체교육기관');">지방자치단체교육기관 </a> |
						<a href="javaScript:go_gubunList('민간교육기관');">민간교육기관</a>
						
					</td>
				</tr>
			</table>
			<!-- space --><table height="10"><tr><td>&nbsp;</td></tr></table>			
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">		
				<tr>
					<td>
                    
                    <!-- search[s] -->
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
						<tr>
							<td height="28" width="50" class="tableline11 white" bgcolor="#5071B4" align="center" width="100"><strong><input type="checkbox" id="allCheck" name="allCheck" onclick="go_check();">선택</strong></td>
							<td height="28" width="" class="tableline11 white" bgcolor="#5071B4" align="center"><strong>기관명</strong></td>
							<td height="28" width="" class="tableline11 white" bgcolor="#5071B4" align="center">주소(우편번호)</td>
							<td height="28" width="100" align="center" bgcolor="#5071B4" class="tableline21 white" width="100">전화번호</td>
						</tr>
						<%=html.toString() %>
						
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
					</table>
                    <!-- search[e] -->
                    					
					<!---[s] content -->
					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
                     <!---[e] content -->
                     <!---[s] content --><table width="100%" height="10"><tr><td></td></tr></table>
                   	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                   		<tr>
                   			<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                   		</tr>
                   	</table>
                   <!-- sapce[s] -->	<table height="50"><tr><td></td></tr></table>
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
