<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 분야별 통계
// date  : 2008-07-22
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
	
	
	String dept = "";
	if( memberInfo.getSessClass().equals("3")){
		dept = memberInfo.getSessDept();
	}
	
	
	String yearMonthFrom = Util.getValue(requestMap.getString("yearMonthFrom"),(String)request.getAttribute("DATE_FROM"));
	String yearMonthTo = Util.getValue(requestMap.getString("yearMonthTo"),(String)request.getAttribute("DATE_TO"));
	
	String bgColor = "";
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	if(listMap.keySize("gubunnm") > 0){		
		for(int i=0; i < listMap.keySize("gubunnm"); i++){
			
			// tr 배경색
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";			
			}else{
				bgColor = "";
			}
			
			
			sbListHtml.append("<tr " + bgColor + " >");
			
			sbListHtml.append("	<td>" + listMap.getString("gubunnm", i) + "</td>");			
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("grcodeCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("grseqCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("planInwon", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("grseqCount", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("male", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("female", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("resuInwon", i)) + "</td>");
			sbListHtml.append("	<td>" + listMap.getString("rate", i) + "</td>");
			sbListHtml.append("	<td class=\"br0\"></td>");
						
			sbListHtml.append("</tr>");
		}	
	}
	
	
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<script language="JavaScript">
<!--

// 검색
function fnSearch(){
	if(NChecker($("pform"))){
		$("mode").value = "major";
		pform.action = "/statisMgr/stats.do";
		pform.submit();
	}
}

// AI 리포트
function fnPrint(){
	if(NChecker($("pform"))){
		popAI("http://<%= Constants.AIREPORT_URL %>/report/report_4.jsp?p_startmonth=" + $F("yearMonthFrom") + "&p_endmonth=" + $F("yearMonthTo") + "&p_dept=<%= dept%>" );		
	}
}

// 엑셀출력
function fnExcel(){
	if(NChecker($("pform"))){
		$("mode").value = "majorExcel";
		pform.action = "/statisMgr/stats.do";
		pform.submit();
	}
}


//-->
</script>
<script for="window" event="onload">
<!--

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>분야별 통계</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!-- tab -->						
						<jsp:include page="topMenu.jsp" flush="false">
							<jsp:param name="tabIndex" value="0" />
						</jsp:include>
						<!-- //tab -->
						
						<div class="space01"></div>

						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									검색기간
								</th>
								<td>
									<input type="text" class="textfield" name="yearMonthFrom" id="yearMonthFrom" maxlength="6" value="<%= yearMonthFrom %>" style="width:60px" required="true!기간이 없습니다." dataform="num!숫자만 입력해야 합니다."  />
                                    ~
                                    <input type="text" class="textfield" name="yearMonthTo" id="yearMonthTo" maxlength="6" value="<%= yearMonthTo %>" style="width:60px" required="true!기간이 없습니다." dataform="num!숫자만 입력해야 합니다."  />
								</td>
								<td width="150" class="btnr">
									<input type="button" value="조회" onclick="fnSearch();" class="boardbtn1" />
									<input type="button" value="엑셀출력" onclick="fnExcel();" class="boardbtn1" />
								</td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th rowspan="3">구분</th>
								<th rowspan="3">과정수</th>
								<th rowspan="3">기수</th>
								<th colspan="6">교육인원</th>
								<th class="br0" rowspan="3">비고</th>
							</tr>
                            <tr>
								<th rowspan="2">계획</th>
								<th colspan="4">실적</th>
								<th rowspan="2">비율(%)</th>
							</tr>
							<tr>
								<th>횟수</th>
								<th>남</th>
								<th>여</th>
								<th>합계</th>
							</tr>
							</thead>

							<tbody>
							
                            <%= sbListHtml.toString() %>
                            
							</tbody>
						</table>
						<!--//리스트  -->	
						<div class="h5"></div>            						
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

<script language="JavaScript">
    document.write(tagAIGeneratorOcx);
</script>
