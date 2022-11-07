<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육관련 FAQ관리
// date : 2008-06-16
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
	
	//FAQ유형 데이터
	DataMap faqListMap = (DataMap)request.getAttribute("FAQLIST_DATA");
	faqListMap.setNullToInitialize(true);	

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
	
	if(listMap.keySize("fno") > 0 ){
		for(int i=0; listMap.keySize("fno") > i; i++){
			html.append("<tr>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+(pageNum -i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("codeName",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"left\" style=\"padding-left:10px\"><a href=\"javascript:go_view('"+listMap.getString("fno",i)+"');\">"+listMap.getString("question",i)+"</a></td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("regdate",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("visit",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+(listMap.getString("useYn",i).equals("") ? "&nbsp;" : listMap.getString("useYn",i))+"</td>");
			html.append("	<td height=\"28\" class=\"tableline21\" align=\"center\">"+(listMap.getString("useYn",i).equals("Y") ? "<input type=\"button\" class=\"boardbtn1\" value=\"사용안함\" onclick=\"go_modify('exec', 'modifyFaqUseYn',"+listMap.getString("fno",i)+",'N')\"" : "<input type=\"button\" class=\"boardbtn1\" value=\"사용함\" onclick=\"go_modify('exec', 'modifyFaqUseYn',"+listMap.getString("fno",i)+",'Y')\"")+"</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("	<td colspan=\"100%\" height=\"300\" align=\"center\"> 등록된 글이 없습니다. </td>");
		html.append("</tr>");
		
	}
	
	//FAQ유형 셀렉박스
	StringBuffer option = new StringBuffer();
	
	if(faqListMap.keySize() > 0){
		for(int i=0; faqListMap.keySize() > i; i++){
			option.append("<option value=\""+faqListMap.getString("minorCode",i)+"\">"+faqListMap.getString("scodeName",i)+"</option>");
		}
	}
	
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
function go_modify(mode, qu, fno , useYn){

	$("mode").value 	= mode;
	$("qu").value	 	= qu;
	$("fno").value		= fno;
	$("useYn").value	= useYn;
	pform.action = "/homepageMgr/faq.do";
	pform.submit();
	
}

function go_form(qu){
	//폼이동
	$("mode").value="form";
	$("qu").value=qu;
	pform.action = "/homepageMgr/faq.do";
	pform.submit();
	
}

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

function go_view(fno){
	$("fno").value=fno;
	$("mode").value="view";
	$("qu").value="faqView";
	pform.action = "/homepageMgr/faq.do";
	pform.submit();
}

//리스트
function go_list(){
	pform.action = "/homepageMgr/faq.do";
	pform.submit();
}

function go_search(){
	if(NChecker($("pform"))){
		var minVisit = $("minVisit").value;	
		var maxVisit = $("maxVisit").value;		
		
		if(IsValidCharSearch($("minVisit").value) == false){
			$("minVisit").value="";
			$("minVisit").focus();
			return false;
		}
		
		if(IsValidCharSearch($("maxVisit").value) == false){
			$("maxVisit").value="";
			$("maxVisit").focus();		
			return false;
		}
		
		if(IsValidCharSearch($("question").value) == false){
			$("question").value="";
			$("question").focus();		
			return false;
		}		
		
		$("mode").value="list";
		$("qu").value="faqList";
		pform.action = "/homepageMgr/faq.do";
		pform.submit();
	}
}

function go_refresh(){
	location.href = "/homepageMgr/faq.do?menuId=<%=requestMap.getString("menuId") %>";
}

</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>

<!-- 글넘버 -->
<input type="hidden" name="fno">
<!-- faq사용여부 -->
<input type="hidden" name="useYn">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>교육관련 FAQ</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                    
                    <!-- search[s] -->
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
						<tr>
							<td height="28" width="15%" class="tableline11" bgcolor="#F7F7F7" align="center"><strong>질문유형</strong></td>
							<td height="28" width="20%" class="tableline11" align="left" style="padding-left:10px"><select name="selectType"><option value="">==질문유형==</option><%=option.toString() %></select></td>
							<td height="28" width="15%" class="tableline11" bgcolor="#F7F7F7" align="center"><strong>조회수</strong></td>
							<td height="28" width="20%" class="tableline11" align="center">
								<input name="minVisit" size="4" dataform="num!숫자만 입력해야 합니다." class="textfield" onkeypress="if(event.keyCode==13){go_search();return false;}" maxlength="4" value="<%=requestMap.getString("minVisit") %>"> ~ 
								<input name="maxVisit" size="4" dataform="num!숫자만 입력해야 합니다." class="textfield" onkeypress="if(event.keyCode==13){go_search();return false;}" maxlength="4" value="<%=requestMap.getString("maxVisit") %>">	
							</td>
							<td height="28" width="30%" align="center" class="tableline21" rowspan="2">
								<input type="button" class="boardbtn1" value="조회" onclick="go_search();">
								<input type="button" class="boardbtn1" value="새로고침" onclick="go_refresh();">
								<input type="button" class="boardbtn1" value="FAQ등록" onclick="go_form('insertFaq');">
							</td>
						</tr>
						<tr>
							<td height="28" width="15%" class="tableline11" align="center" bgcolor="#F7F7F7"><strong>Question</strong></td>
							<td colspan="3" class="tableline11" style="padding-left:10px;"><input size="30" class="textfield" maxlength="20" onkeypress="if(event.keyCode==13){go_search();return false;}" type="text" name="question" value="<%=requestMap.getString("question") %>"></td>
						</tr>
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
					</table>
                    <!-- search[e] -->
                    					
					<!---[s] content -->
					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						  <tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						  </tr>
						<tr bgcolor="#5071B4">
						  <td height="28" width="5%" align="center" class="tableline11 white" ><strong>NO</strong></td>
						  <td class="tableline11 white" align="center" width="15%"><strong>질문유형</strong></td>
						  <td class="tableline11 white" align="center" width="46%"><strong>Question</strong></td>
						  <td class="tableline11 white" align="center" width="10%"><strong>등록일</strong></td>
						  <td class="tableline11 white" align="center" width="7%"><strong>조회수</strong></td>
						  <td class="tableline11 white" align="center" width="7%"><strong>상태</strong></td>
						  <td class="tableline21 white" align="center" width="10%"><strong>사용여부</strong></td>
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

