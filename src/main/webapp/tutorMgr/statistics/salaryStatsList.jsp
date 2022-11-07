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
	
	
	String sType = Util.getValue(requestMap.getString("sType"),"1");
	String yearMonthFrom = Util.getValue(requestMap.getString("yearMonthFrom"),(String)request.getAttribute("DATE_FROM"));
	String yearMonthTo = Util.getValue(requestMap.getString("yearMonthTo"),(String)request.getAttribute("DATE_TO"));
	
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String bgColor = "";
	
	if(listMap.keySize("pflag") > 0){		
		for(int i=0; i < listMap.keySize("pflag"); i++){
			
			
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";				
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "bgcolor=\"ffcc00\"";
			}else{
				bgColor = "";
			}
			
			sbListHtml.append("<tr " + bgColor + "  >");
			if(listMap.getString("pflag",i).equals("C")){
				sbListHtml.append("	<td>" + listMap.getString("gubunnm", i) + "</td>");
				sbListHtml.append("	<td>" + listMap.getString("grcodenm", i) + "</td>");
			}else{
				
				sbListHtml.append("	<td ><b>" + listMap.getString("gubunnm", i) + "</b></td>");
				sbListHtml.append("	<td ></td>");
			}

			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("stuCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("grseqCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("tutorTotalCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("total1", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("aCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("a1Cnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("aTotalCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("bCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("c1Cnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("c2Cnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("cTotalCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("dCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("zCnt", i)) + "</td>");
			sbListHtml.append("	<td class=\"br0\"></td>");
			sbListHtml.append("</tr>");
			
			
		}
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
		$("mode").value = "list";
		pform.action = "/tutorMgr/stati.do";
		pform.submit();
	}
}

function fnExcel(){
	if(NChecker($("pform"))){
		$("mode").value = "excel";
		pform.action = "/tutorMgr/stati.do";
		pform.submit();
	}
}

//-->
</script>
<script for="window" event="onload">
<!--
cellMergeChk($("dataList"), 3, 0);		//첫번째 td 처리
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강사활용실적</strong>
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
								<td width="200">
									<input type="text" class="textfield" name="yearMonthFrom" id="yearMonthFrom" value="<%= yearMonthFrom %>" maxlength="6" style="width:60px" required="true!기간이 없습니다." dataform="num!숫자만 입력해야 합니다."  />
									~
									<input type="text" class="textfield" name="yearMonthTo" id="yearMonthTo" value="<%= yearMonthTo %>" maxlength="6" style="width:60px" required="true!기간이 없습니다." dataform="num!숫자만 입력해야 합니다." />
								</td>
								<th width="80">검색조건</th>
								<td>
									<input type="radio" class="chk_01" name="sType" id="sType_1" value="1" 	<%= sType.equals("1") ? "checked" : "" %> /><label for="sType_1">인원 </label>
									<input type="radio" class="chk_01" name="sType" id="sType_2" value="2"	<%= sType.equals("2") ? "checked" : "" %> /><label for="sType_2">시간 </label>
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
								<th rowspan="3">구분</th>
								<th rowspan="3">과정명</th>
								<th rowspan="3">교육<br />인원</th>
								<th rowspan="3">기수</th>
								<th rowspan="3">총강의시간<br />
									(①+②+③+⑤)
								</th>
								<th colspan="9">외래강사</th>
								<th rowspan="3">자체<br />교관<br />(⑤)</th>
								<th class="br0" rowspan="3">비고</th>
							</tr>
							<tr>
								<th rowspan="2">소계<br />(①+②+<br />③)</th>
								<th colspan="3">A급</th>
								<th rowspan="2">B급(②)</th>

								<th colspan="3">C급</th>
								<th rowspan="2">D급<br />보조<br />(④) </th>
							</tr>
							<tr>
								<th>특A</th>
								<th>A</th>
								<th>소계<br />(①)</th>
								<th>C1</th>
								<th>C2</th>
								<th>소계<br />(③)</th>
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

