<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 명강의 동영상관리 리스트
// date  : 2008-08-06
// auth  : 정윤철
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
	
	StringBuffer html = new StringBuffer();
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("seq") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	if(listMap.keySize("seq") > 0){
		
		for(int i =0; i < listMap.keySize("seq"); i++){
			String imageurl = Constants.UPLOAD + listMap.getString("filePath", i);
			html.append("\n	<tr>");
			html.append("\n	<td>"+(pageNum - i)+"</td>");
			html.append("\n	<td>"+listMap.getString("luserName")+"</a></td>");
			html.append("\n	<td> <a href=\"javascript:go_modify('"+listMap.getString("seq", i)+"')\">" +StringReplace.subStringPoint(listMap.getString("title", i), 10));
			
			html.append("\n	</a></td>");
			html.append("\n	<td style=\"text-align:left;padding-left:10px\">" +StringReplace.subStringPoint(listMap.getString("url", i), 60) + "</td>");
			
			if(!listMap.getString("groupfileNo", i).equals("-1")){
				html.append("<td class=\"tableline11\"> <img width=\"57\" height=\"52\" src='/"+imageurl+"'></td>");	
			
			}else{
				html.append("<td class=\"tableline11\" height=\"52\">&nbsp;</td>");
				
			}
			
			html.append("\n	<td class=\"br0\" >");
			html.append("\n	<input type=\"button\" value=\"미리보기\" class=\"boardbtn1\" onclick=\"go_view('"+listMap.getString("url", i)+"','"+listMap.getString("gubun", i)+"');\" class=\"boardbtn1\">");
			html.append("\n	</td>");			
			html.append("\n	</tr>");
		}
	}else{
		html.append("\n	<tr>");
		html.append("\n	<td colspan=\"100%\" class=\"br0\" style=\"height:100px;\">등록된 데이터가 없습니다.</td>");
		html.append("\n	</tr>");		
	}
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//리스트
function go_list(){
	pform.action = "/homepageMgr/moveLect.do";
	pform.submit();
}

//저장모드폼 이동
function go_insert(){
	$("mode").value = "form";
	$("qu").value = "insert";
	pform.action = "/homepageMgr/moveLect.do";
	pform.submit();

}

//수정모드폼 이동
function go_modify(seq){
	$("mode").value = "form";
	$("qu").value = "modify";
	$("seq").value = seq;
	pform.action = "/homepageMgr/moveLect.do";
	pform.submit();

}
//미리보기
function go_view(url, gubun){
	//$("mode").value = "preview";
	//$("url").value=url;
	//pform.action = "/homepageMgr/moveLect.do";
	//var popWindow = popWin('about:blank', 'majorPop11', '520', '420', 'no', 'no');
	//pform.target = "majorPop11";
	//pform.submit();
	//pform.target = "";
	if(gubun == '1'){
		location.href = url;
	}else{
		window.open(url, '', 'width=430, height=440');
	}
	
}





//검색
function go_search(){
	if(IsValidCharSearch($("title").value) == false){
		return false;
	}
	$("currPage").value = "";
	pform.action = "/homepageMgr/moveLect.do";
	pform.submit();
}

//로딩시.
onload = function()	{

}


//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value="<%=requestMap.getString("currPage")%>">
<input type="hidden" name="qu"		value="">
<input type="hidden" name="seq"		value="">
<input type="hidden" name="url"		value="">

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
			<div class="h10"></div>

			
			<!--[e] 타이틀 -->
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<table class="search01">
							<tr>
								<th class="bl0">
									제목검색
								</th>
								<td>
									<input type="text" class="textfield" name="title" onkeypress="if(event.keyCode==13){go_search();return false;}" value="<%=requestMap.getString("title") %>"/>
								</td>
								<td align="right" class="btnr" width="100">
									<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
									<input type="button" value="등록" onclick="go_insert();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<div class="h10"></div>
						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th width="60" >번호</th>
								<th width="100">성명</th>
								<th width="200">제목</th>
								<th>경로</th>
								<th width="100">썸네일 <br>이미지</th>
								<th class="br0" width="100">미리 보기</th>
							</tr>
							</thead>

							<tbody>
								<%=html.toString() %>
							</tbody>
						</table>
						<!--//리스트  -->
						<div class="h10"></div>
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
							<tr>
								<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
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