<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사활용실적
// date  : 2008-07-21
// auth  : kang
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
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	int count = listMap.keySize("userno");	
	if(count > 0){		
		String trColor = "";
		for(int i=0; i < listMap.keySize("userno"); i++){
			if((i%2)==0) {
				trColor = "bgcolor=\"ffcc00\"";
			} else {
				trColor = "bgcolor=\"#cccccc\"";
			}
			sbListHtml.append("<tr "+trColor+">");
			sbListHtml.append("	<td><a href=\"#\" onclick=\"go_popView('"+listMap.getString("userno", i)+"');\">" + listMap.getString("name", i) + "</a></td>");
			sbListHtml.append("	<td>" + listMap.getString("indate", i) + "</td>");
			sbListHtml.append("	<td>" + listMap.getString("tlevel", i) + "</td>");
			sbListHtml.append("	<td>" + listMap.getString("job", i) + "</td>");
			sbListHtml.append("	<td>" + listMap.getString("tposition", i) + "</td>");
			sbListHtml.append("</tr>");
		}
	} else {
			sbListHtml.append("<tr>");
			sbListHtml.append("	<td colspan=\"5\" class=\"br0\">검색된 데이타가 없습니다.</td>");
			sbListHtml.append("</tr>");
	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="javascript" src="/commonInc/js/rowspan.js"></script>

<script language="JavaScript">
<!--

// 검색
function fnSearch(){
	if(NChecker($("pform"))){
		$("mode").value = "tutorMemberList";
		pform.action = "/tutorMgr/stati.do";
		pform.submit();
	}
}

function fnExcel(){
	if(NChecker($("pform"))){
		$("mode").value = "tutorMemberListExcel";
		pform.action = "/tutorMgr/stati.do";
		pform.submit();
	}
}
//강사정보 팝업
function go_popView(userno){
 
	var url = "/tutorMgr/tclass.do";
	url += "?mode=infoPop";
	url += "&userno=" + userno;
	pwinpop = popWin(url,"infoPop","800","700","yes","no");
 
}
//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">



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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>년도별 강사등록 명부</strong>
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
								<th width="80" class="bl0">
									기간
								</th>
								<td width="100">
									<select id="year" name="year">
									<% 
										int startDate = requestMap.getInt("startDate");
										int endDate = requestMap.getInt("endDate");
										int year = requestMap.getInt("year");
										
										for(int i = startDate; i < endDate ; i++ ) {
									%>
										<option value="<%=i%>" <%= (year == i) ? "selected='selected'":""%>><%=i%></option>
									<%
										} 
									%>
									
									</select>
								</td>
								<td width="130" class="btnr">
									<input type="button" value="검색" onclick="fnSearch();" class="boardbtn1">
									<input type="button" value="EXCEL" onclick="fnExcel();" class="boardbtn1">
								</td>								
							</tr>
						</table>
						<!--//검색 -->
						<div class="space01"></div>
						<!--[s] 리스트  -->
						<table class="datah01" id="dataList">
							<thead>
							<tr>
								<th colspan="5" style="color:yellow;"><%=year%>년도 총 <%=count%> 명</th>
							</tr>
							<tr>
								<th>성명</th>
								<th>신규등록강사</th>
								<th>등급</th>
								<th>직업군</th>
								<th>소속</th>
							</tr>
							</thead>
							<tbody>							
							<%= sbListHtml.toString() %>			
							</tbody>
						</table>
						<!--//[e] 리스트  -->
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

