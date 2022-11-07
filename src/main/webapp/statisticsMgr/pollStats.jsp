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
	
	
	String commYear = requestMap.getString("commYear");
	String commGrCode = requestMap.getString("commGrcode");
	String commGrSeq = requestMap.getString("commGrseq");
	String searchQuestion = requestMap.getString("searchQuestion");
	String searchType = Util.getValue(requestMap.getString("searchType"),"1");
	
	
	// 문항선택 셀렉트 박스
	StringBuffer sbQHtml = new StringBuffer();
	DataMap questionMap = (DataMap)request.getAttribute("QUESTION_DATA");
	if(questionMap == null) questionMap = new DataMap();
	questionMap.setNullToInitialize(true);
	
	sbQHtml.append("<select name=\"searchQuestion\" class=\"mr10\" style=\"width:250px\">");
	sbQHtml.append("<option value=\"\">**선택하세요**</option>");
			
	if(questionMap.keySize("question") > 0){		
		for(int i=0; i < questionMap.keySize("question"); i++){
			sbQHtml.append("<option value=\"" + questionMap.getString("question", i) + "\" " + (searchQuestion.equals(questionMap.getString("question", i)) ? "selected":"") +  " >" + questionMap.getString("question", i) + "</option>");
		}
	}
	
	sbQHtml.append("</select>");
	
	
	
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String tmpQuestion = "";
	String bgColor = "";
	String textAlignLeft = "";
	
	if(listMap.keySize("question") > 0){		
		for(int i=0; i < listMap.keySize("question"); i++){
			
			
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";
				textAlignLeft = "";
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "bgcolor=\"ffcc00\"";
				textAlignLeft = "";
			}else{
				bgColor = "";
				
				textAlignLeft = "style=\"text-align:left\"";
			}
			
			
			
			// 다르면 타이틀 태그를 넣는다.
			if(!tmpQuestion.equals(listMap.getString("question",i))){
				sbListHtml.append("<table class=\"datah01\">");
				sbListHtml.append("<thead>");
				sbListHtml.append("	<tr>");
				sbListHtml.append("		<th rowspan=\"3\" width=\"250\">과정명</th>");
				sbListHtml.append("		<th colspan=\"11\" style=\"text-align:left\">&nbsp;" + listMap.getString("question",i) + "</th>");
				sbListHtml.append("		<th class=\"br0\" rowspan=\"3\" width=\"60\">비고</th>");
				sbListHtml.append("	</tr>");
				sbListHtml.append("	<tr>");
				sbListHtml.append("		<th rowspan=\"2\" width=\"80\">총응답수</th>");
				sbListHtml.append("		<th colspan=\"2\">매우 양호</th>");
				sbListHtml.append("		<th colspan=\"2\">비교적 양호</th>");
				sbListHtml.append("		<th colspan=\"2\">보통</th>");
				sbListHtml.append("		<th colspan=\"2\">다소미흡</th>");
				sbListHtml.append("		<th colspan=\"2\">매우미흡</th>");
				sbListHtml.append("	</tr>");
				sbListHtml.append("	<tr>");
				sbListHtml.append("		<th width=\"60\">인원</th>");
				sbListHtml.append("		<th width=\"60\">비율</th>");
				sbListHtml.append("		<th width=\"60\">인원</th>");
				sbListHtml.append("		<th width=\"60\">비율</th>");
				sbListHtml.append("		<th width=\"60\">인원</th>");
				sbListHtml.append("		<th width=\"60\">비율</th>");
				sbListHtml.append("		<th width=\"60\">인원</th>");
				sbListHtml.append("		<th width=\"60\">비율</th>");
				sbListHtml.append("		<th width=\"60\">인원</th>");
				sbListHtml.append("		<th width=\"60\">비율</th>");
				sbListHtml.append("	</tr>");
				sbListHtml.append("</thead>");
				sbListHtml.append("<tbody>");
			}
									
			if(i==0){								
				
				sbListHtml.append("<tr " + bgColor + ">");
				sbListHtml.append("	<td>" + listMap.getString("grnm",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("ansNo",i)) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num1",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num1Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num2",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num2Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num3",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num3Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num4",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num4Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num5",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num5Avg",i) + "</td>");
				sbListHtml.append("	<td class=\"br0\"></td>");
				sbListHtml.append("</tr>");
								
				tmpQuestion = listMap.getString("question",i);
				
			}else{
				
				sbListHtml.append("<tr " + bgColor + ">");
				sbListHtml.append("	<td  " + textAlignLeft + ">&nbsp;" + listMap.getString("grnm",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("ansNo",i)) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num1",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num1Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num2",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num2Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num3",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num3Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num4",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num4Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num5",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num5Avg",i) + "</td>");
				sbListHtml.append("	<td class=\"br0\" ></td>");
				sbListHtml.append("</tr>");
				
				if(i < listMap.keySize("question")){
					
					if( !listMap.getString("question",i).equals(listMap.getString("question",i+1)) ){
						sbListHtml.append("	</tbody>");
						sbListHtml.append("</table>");
						sbListHtml.append("<br><br>");
					}
					
					tmpQuestion = listMap.getString("question",i);
					
				}else{
					sbListHtml.append("	</tbody>");
					sbListHtml.append("</table>");
					sbListHtml.append("<br><br>");
				}				
			}															
		}
	}else{
		sbListHtml.append("<table class=\"datah01\">");
		sbListHtml.append("<tr><td style=\"height:100px\">결과가 없습니다.</td></tr>");
		sbListHtml.append("</table>");
	}
	
	//기수 셀렉트박스 만들기
	Calendar cal = Calendar.getInstance();
	int year = cal.get(java.util.Calendar.YEAR);
	
	StringBuffer selGrseq = new StringBuffer();
	
	for(int j=1; j < 9; j++) {
		selGrseq.append("<option value=\""+year+"0"+j+"\">0"+j+"기</option>");
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

// 검색
function fnSearch(){
	$("mode").value = "poll";
	$("searchYn").value = "Y";
	pform.action = "/statisMgr/stats.do";
	pform.submit();
	$("searchYn").value = "";
}

// 엑셀출력
function fnExcel(){
	$("mode").value = "pollExcel";
	$("searchYn").value = "Y";
	pform.action = "/statisMgr/stats.do";
	pform.submit();
	$("searchYn").value = "";
}


//-->
</script>
<script for="window" event="onload">
<!--

	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	var reloading = ""; 

	getCommYear(commYear);														// 년도
	getCommOnloadGrCode(reloading, commYear, commGrCode);						// 과정
	 getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);				// 기수
	

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="searchYn"	id="searchYn">


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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>과정별 설문 통계</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- tab -->						
						<jsp:include page="topMenu.jsp" flush="false">
							<jsp:param name="tabIndex" value="6" />
						</jsp:include>
						<!-- //tab -->
						<div class="space01"></div>

						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									년도
								</th>
								<td width="20%">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCommGrCode('subj');" style="width:100px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th width="80">
									과정명
								</th>
								<td>
									<div id="divCommGrCode" class="commonDivLeft">
										<select name="commGrcode" style="width:250px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<td width="130" class="btnr" rowspan="3">
									<input type="button" value="조회" onclick="fnSearch();" class="boardbtn1">
									<input type="button" value="엑셀출력" onclick="fnExcel();" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th class="bl0">
									기수명
								</th>
								<td>
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" style="width:100px;font-size:12px">
											<option value="">**선택하세요**</option>
											<!-- 
											<option value="200901">01</option>
											<option value="200902">02</option>
											<option value="200903">03</option>
											<option value="200904">04</option>
											<option value="200905">05</option>
											<option value="200906">06</option>
											<option value="200907">07</option>
											<option value="200908">08</option>
											<option value="200909">09</option>
											-->
											<%= selGrseq.toString() %>
										</select>
									</div>
								</td>
								<th>
									문항선택  
								</th>
								<td>
									<%= sbQHtml.toString() %>
								</td>
							</tr>
							<tr>
								<th width="80" class="bl0">
									구분
								</th>
								<td colspan="3">
									<input type="radio" name="searchType" value="1" id="searchType_1" <%= searchType.equals("1") ? "checked" : "" %> >
									<label for="searchType_1">과정기수별</label>

                                    <input type="radio" name="searchType" value="2" id="searchType_2" <%= searchType.equals("2") ? "checked" : "" %> >
									<label for="searchType_2">과정별</label>
								</td>
							</tr>
								
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 리스트  -->
						<%= sbListHtml.toString() %>
						
						<!-- 
						<table class="datah01">
							<thead>
							<tr>
								<th rowspan="3">과정명</th>
								<th colspan="11">3일이하-4) 교육원 직원들의 친절도에 대한 의견은?</th>
								<th class="br0" rowspan="3">비고</th>
							</tr>
							<tr>
								<th rowspan="2">총응답수</th>
								<th colspan="2">매우 양호</th>								
								<th colspan="2">비교적 양호</th>
								<th colspan="2">보통</th>
								<th colspan="2">다소미흡</th>
								<th colspan="2">매우미흡</th>
							</tr>
							<tr>
								<th>인원</th>
								<th>비율</th>
								<th>인원</th>
								<th>비율</th>
								<th>인원</th>
								<th>비율</th>
								<th>인원</th>
								<th>비율</th>
								<th>인원</th>
								<th>비율</th>
							</tr>							
							</thead>
							<tbody>							
							<tr>
								<td class="bg01">ㅁㅁ</td>
                                <td class="bg01">954</td>
                                <td class="bg01">293</td>
								<td class="bg01">474</td>
								<td class="bg01">165</td>
								<td class="bg01">13</td>
								<td class="bg01">1</td>								
								<td class="bg01">954</td>
								<td class="bg01">954</td>
								<td class="bg01">954</td>
								<td class="bg01">954</td>
								<td class="bg01">954</td>
                                <td class="br0 bg01"></td>
							</tr>							
							</tbody>
						</table>
						-->
						
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