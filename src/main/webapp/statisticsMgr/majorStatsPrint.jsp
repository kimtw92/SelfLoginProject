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
	
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	if(listMap.keySize("gubunnm") > 0){		
		for(int i=0; i < listMap.keySize("gubunnm"); i++){
			
			sbListHtml.append("<tr>");
			
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
	
// <p style="page-break-before:always">
	
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

function printWindow() {
	pform.factory.printing.header = "머릿글로 출력되는 부분입니다."
	pform.factory.printing.footer = "바닥글로 출력되는 부분입니다."
	pform.factory.printing.portrait = false;
	pform.factory.printing.leftMargin = 1.0;
	pform.factory.printing.topMargin = 1.0;
	pform.factory.printing.rightMargin = 1.0;
	pform.factory.printing.bottomMargin = 1.0;
	pform.factory.printing.Print(false, window)
}

function fnView(){
	pform.factory.printing.Preview()
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


<!-- MeadCo Security Manager -->
<object style="display:none" 
	classid="clsid:5445be81-b796-11d2-b931-002018654e2e" 
	codebase="http://www.meadroid.com/scriptx/ScriptX.cab#Version=6,1,432,1">
</object>

<!-- MeadCo ScriptX -->
<object id="factory" style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"></object>


	<button onclick="fnView();">aaaaaaa</button>

	<div class="h10"></div>
	<!--[s] Contents Form  -->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
		<tr>
			<td>						
				<div class="space01"></div>

				<!-- 검색  -->
				<table class="search01">
					<tr>								
						<td width="150" class="btnr">
							<input type="button" value="출력" onclick="printWindow();" class="boardbtn1" />
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
                          <%= sbListHtml.toString() %>
                          <%= sbListHtml.toString() %>
                          <%= sbListHtml.toString() %>
                          <%= sbListHtml.toString() %>
                          <%= sbListHtml.toString() %>
                          <%= sbListHtml.toString() %>
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
			

</form>
</body>