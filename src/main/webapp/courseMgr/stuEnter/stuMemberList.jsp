<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육생(입교자) 조회
// date : 2008-07-01
// auth : LYM
/**********************************************************************/
// 사용자 수정요청에 의한 수
// prgnm : 교육생(입교자) 조회
// date : 2008-09-23
// auth : 정 윤철
/**********************************************************************/
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

	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");

	if(listMap == null){
		listMap = new DataMap();
	}
	listMap.setNullToInitialize(true);
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int totalCnt = pageNavi.getTotalCnt();
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.

	for(int i = 0; i < listMap.keySize("userno"); i++){
		listStr.append("<tr>");
		listStr.append("	<td>"+listMap.getString("name", i)+"</td>");
		listStr.append("	<td>"+listMap.getString("userId", i)+"</td>");
		listStr.append("	<td>"+listMap.getString("deptnm", i)+"</td>");
		listStr.append("	<td>"+listMap.getString("grcodenm", i)+"</td>");
		listStr.append("	<td>"+listMap.getString("started", i)+" <br>~ "+ listMap.getString("enddate", i)+"</td>");
		listStr.append("	<td>"+listMap.getString("homeTel", i)+"</td>");
		listStr.append("	<td class=\"br0\">"+listMap.getString("hp", i)+"</td>");
		listStr.append("</tr>");
	}
	
	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' style=\"height:100px\" class='br0'>검색된 학생이 없습니다</td>");
		listStr.append("\n</tr>");

	}

	//페이징 String
	String pageStr = "";
	if(listMap.keySize("userno") > 0){
		pageStr += "<div class='paging'>";
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
		pageStr += "</div>";
	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//검색
function go_search(){
	$("currPage").value = "1";
	$("qu").vaue = "search";
	if(IsValidCharSearch($("name").value) == false){
		
		return false;
	}
	
	if($("date1").value == ""){
		alert("시작일자를 입력 하십시오.");
		return false
	}
	
	if($("date2").value == ""){
		alert("마지막일자를 입력 하십시오.");
		return false
	}	
	
	if($("date1").value > $("date2").value){
		alert("시작일자가 마지막 일자보다 큽니다. 다시 검색 하여주십시오.");
		return false
	}
	
	go_list();

}

//리스트
function go_list(){

	$("mode").value = "stuMemberList";

	pform.action = "/courseMgr/stuEnter.do";
	pform.submit();

}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="qu"					value="">
<input type="hidden" name="userno"				value="">

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">

<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">


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



			<div class="h10"></div>

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>

						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									이름
								</th>
								<td width="20%">
									<input type="text" class="textfield" maxlength="8" onkeypress="if(event.keyCode==13){go_search();return false;}" name="name" value="<%=requestMap.getString("name") %>">
								</td>
								<th width="80">
									기간
								</th>
								<td>
									<input type="text" class="textfield" name="date1" value="<%=requestMap.getString("date1")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','date1');" src="../images/icon_calen.gif" alt="" />
									~
									<input type="text" class="textfield" name="date2" value="<%=requestMap.getString("date2")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','date2');" src="../images/icon_calen.gif" alt="" />
								</td>
								<td width="100" class="btnr">
									<input type="button" onClick="go_search();" value="조회" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>
						
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td height="30"> 총 인원  : <%=NumConv.setComma(totalCnt) %></td>
							</tr>
						</table>
							
						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>이름</th>
								<th>아이디</th>
								<th>기관</th>
								<th>과정명</th>
								<th>교육기간</th>
								<th>전화번호</th>
								<th class="br0">핸드폰</th>
							</tr>
							</thead>

							<tbody>
							<%= listStr.toString() %>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	
            
						<div class="h5"></div>

						<!--[s] 페이징 -->
						<%=pageStr%>
						<!--//[s] 페이징 -->
					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>
<!--[ 코딩 끝 ] ------------------------------------------------------------------------------------------------------>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

