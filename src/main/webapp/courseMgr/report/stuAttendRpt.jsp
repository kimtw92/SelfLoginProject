<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 출석부출력
// date : 2008-07-07
// auth : LYM
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


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--


//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
	go_list();
}



//검색
function go_search(){

	var grcode = $F("grcode");
	var grseq = $F("grseq");

	if($F("commYear") == ""){
		alert("년도를 선택하세요!");
		return;
	}

	if($F("commGrcode") == ""){
		alert("과정을 선택하세요!");
		return;
	}

	if($F("commGrseq") == ""){
		alert("과정기수를 선택하세요!");
		return;
	}
	
	if($F("commStrdate") == ""){
		alert("시작일자를 선택하세요!");
		return;
	}

	var selday = $F("comm_selday");
	var strdate = $F("commStrdate");

	var aaa = "";
	if(selday == 1) {
		aaa = "1";
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_28_1.jsp?p_grcode=" + grcode + "&p_grseq=" + grseq + "&p_strdate=" + strdate);
	} else if(selday == 2) {
		aaa = "2";
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_28_2.jsp?p_grcode=" + grcode + "&p_grseq=" + grseq + "&p_strdate=" + strdate);
	} else if(selday == 3) {
		aaa = "3";
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_28_3.jsp?p_grcode=" + grcode + "&p_grseq=" + grseq + "&p_strdate=" + strdate);
	} else if(selday == 4) {
		aaa = "4";
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_28_4.jsp?p_grcode=" + grcode + "&p_grseq=" + grseq + "&p_strdate=" + strdate);
	} else if(selday == 5) {
		aaa = "5";
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_28_5.jsp?p_grcode=" + grcode + "&p_grseq=" + grseq + "&p_strdate=" + strdate);
	} else if(selday == 10) {
		aaa = "10";
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_28_10.jsp?p_grcode=" + grcode + "&p_grseq=" + grseq + "&p_strdate=" + strdate);
	} else if(selday == 15) {
		aaa = "15";
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_28_15.jsp?p_grcode=" + grcode + "&p_grseq=" + grseq + "&p_strdate=" + strdate);
	} else if(selday == 30) {
		aaa = "30";
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_28_30.jsp?p_grcode=" + grcode + "&p_grseq=" + grseq + "&p_strdate=" + strdate);
	} else {
		aaa = "etc";
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_28_2.jsp?p_grcode=" + grcode + "&p_grseq=" + grseq + "&p_strdate=" + strdate);
	}

}



//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = ""; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);

}

//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">


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
            <!--[s] 공통 Left Menu  false-->
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
									년도
								</th>
								<td width="20%">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCommGrCode('subj');" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th width="80">
									과정명
								</th>
								<td colspan="3">

									<div id="divCommGrCode" class="commonDivLeft">
										<select name="commGrcode" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>

								</td>
								<td width="100" class="btnr" rowspan="2">
									<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th class="bl0">
									기수명
								</th>
								<td>
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th class="bl0">
									시작일자
								</th>
								<td>
									<input type="text" class="textfield" name="commStrdate" value="<%=requestMap.getString("commStrdate")%>" style="width:60">
									&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'commStrdate');" style="cursor:hand;">
								</td>
								<th class="bl0">
									일자
								</th>
								<td>
									<select name="comm_selday" class="mr10">
										<option value="">** 선택 **</option>
										<option value="1">1일</option>
										<option value="2">2일</option>
										<option value="3">3일</option>
										<option value="4">4일</option>
										<option value="5">5일</option>
										<option value="10">10일</option>
										<option value="15">15일</option>
										<option value="30">30일</option>
									</select>
								</td>
							</tr>

						</table>
						<!--//검색 -->	
						<div class="space01"></div>


						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="right">
									<iframe name="AIREPORT" src="#" width="100%" height="600" frameborder="0" frameborder='0'></iframe>
								</td>
							</tr>
						</table>

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
<script language="JavaScript">
//AI Report
document.write(tagAIGeneratorOcx);
</script>

</body>

