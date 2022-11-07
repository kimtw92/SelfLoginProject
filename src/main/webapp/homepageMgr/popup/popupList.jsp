<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 팝업리스트
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
	
	if(listMap.keySize("no") > 0 ){
		for(int i=0; listMap.keySize("no") > i; i++){
			html.append("<tr>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("no",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"left\" style=\"padding-left:10px\"><a href=\"javascript:go_form('modify','"+listMap.getString("no",i)+"');\">"+listMap.getString("title",i)+"</a></td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\"><a href=\"javascript:go_view('"+listMap.getString("no",i)+"','"+listMap.getString("popupWidth",i)+"', '"+listMap.getString("popupHeight",i)+"', '"+listMap.getString("popupLeft",i)+"', '"+listMap.getString("popupTop",i)+"')\">[보기]</a></td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("pstrDate",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline21\" align=\"center\">"+listMap.getString("pendDate",i)+"</td>");
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
function go_form(qu,no){
	//폼이동
	$("mode").value="form";
	$("qu").value=qu;
	$("no").value=no;
	
	pform.action = "/homepageMgr/popup.do";
	pform.submit();
	
}

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//팝업 미리보기 
function go_view(no, w, h, l, t){
// w : width
// h : height
// l : left
// t : top

	$("no").value=no;
	$("mode").value="view";
	$("qu").value="popupView";
	pform.action = "/homepageMgr/popup.do";
	var popup = popupWindow('about:blank', 'majorPop11', w, h, l, t, 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

//리스트
function go_list(){
	pform.action = "/homepageMgr/popup.do";
	pform.submit();
}

</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>

<!-- 글넘버 -->
<input type="hidden" name="no">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>팝업관리</strong>
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
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td colspan="100%" align="right">
								<input type="button" class="boardbtn1" value="이벤트추가" onclick="go_form('insert','');">
							</td>
						</tr>
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						</tr>
						<tr bgcolor="#5071B4">
						  <td height="28" width="5%" align="center" class="tableline11 white" ><strong>번호</strong></td>
						  <td class="tableline11 white" align="center" width="65%"><strong>제목</strong></td>
						  <td class="tableline11 white" align="center" width="10%"><strong>미리보기</strong></td>
						  <td class="tableline11 white" align="center" width="10%"><strong>이벤트<br>시작일</strong></td>
						  <td class="tableline11 white" align="center" width="10%"><strong>이벤트<br>종료일</strong></td>
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

