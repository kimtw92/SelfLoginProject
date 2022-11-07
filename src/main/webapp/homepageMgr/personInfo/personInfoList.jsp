<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 개인정보조회출력
// date : 2008-10-02
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
	
	
	if(listMap.keySize("userno") > 0){
		for(int i=0; i < listMap.keySize("userno"); i++){
			html.append("<tr>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+(pageNum - i)+"</td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+listMap.getString("name", i)+"</td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+(listMap.getString("gubun", i).equals("1") ? "교육확인서" : "출강확인서")+"</td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+listMap.getString("content", i)+"</td>");
			html.append("	<td class=\"tableline21\" align=\"center\">"+listMap.getString("regdate", i)+"</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("	<td height=\"100\" align=\"center\" colspan=\"100%\" >등록된 내역이 없습니다.</td>");
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


//리스트
function go_list(){
	pform.action = "/homepageMgr/personInfo.do";
	pform.submit();
}

//검색
function go_search(){
	if(NChecker($("pform"))){
		if($("date1").value == ""){
			alert("검색 시작일자를 입력 하십시오.");
			return false;
			
		}
		
		if($("date2").value == ""){
			alert("검색 종료일자를 입력 하십시오.");
			return false;	
				
		}
		
		if(IsValidCharSearch($("searchName").value) == false){
			$("searchName").value="";
			$("searchName").focus();
			return false;
		}
		
		if(IsValidCharSearch($("searchContents").value) == false){
			$("searchContents").value="";
			$("searchContents").focus();		
			return false;
		}
		
		
		$("mode").value="list";
		pform.action = "/homepageMgr/personInfo.do";
		pform.submit();
	}
}

//엑셀출력
function go_excel(){
	
	if($("date1").value == ""){
		alert("검색 시작일자를 입력 하십시오.");
		return false;
		
	}
	
	if($("date2").value == ""){
		alert("검색 종료일자를 입력 하십시오.");
		return false;	
			
	}
	
	$("mode").value = "excel";
	pform.action = "/homepageMgr/personInfo.do";
	pform.submit();
}

</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>개인정보조회출력</strong>
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
							<td height="28" width="60" class="tableline11" bgcolor="#F7F7F7" align="center"><strong>작성자</strong></td>
							<td height="28" class="tableline11" align="left" style="padding-left:10px"><input type="text" class="textfield" onkeypress="if(event.keyCode==13){go_search();return false;}" maxlength="10" name="searchName" value="<%=requestMap.getString("searchName")%>"></td>
							<td height="28" width="60" class="tableline11" bgcolor="#F7F7F7" align="center"><strong>기간</strong></td>
							<td height="28" class="tableline11" align="center">
								<input type="text" class="textfield" name="date1" value="<%=requestMap.getString("date1")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','date1');" src="../images/icon_calen.gif" alt="" />
									~
									<input type="text" class="textfield" name="date2" value="<%=requestMap.getString("date2")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','date2');" src="../images/icon_calen.gif" alt="" />								
							</td>
							<td height="28" align="center" class="tableline21" rowspan="2">
								<input type="button" class="boardbtn1" value="조회" onclick="go_search();">
								<input type="button" class="boardbtn1" value="EXCEL" onclick="go_excel();">
							</td>
						</tr>
						<tr>
							<td height="28" class="tableline11" align="center" bgcolor="#F7F7F7"><strong>내역</strong></td>
							<td colspan="3" class="tableline11" style="padding-left:10px;"><input class="textfield" maxlength="20" onkeypress="if(event.keyCode==13){go_search();return false;}" type="text" name="searchContents" value="<%=requestMap.getString("searchContents") %>"></td>
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
						  <td class="tableline11 white" align="center" width="15%"><strong>요청인</strong></td>
  						  <td class="tableline11 white" align="center" width="15%"><strong>구분</strong></td>
						  <td class="tableline11 white" align="center" width="46%"><strong>사유</strong></td>
						  <td class="tableline11 white" align="center" width="10%"><strong>발급일</strong></td>
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
