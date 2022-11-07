<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 메일 / sms 발송
// date : 2008-07-18
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

	//과정 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//페이지 이동
function go_page(page) {
	go_list();
}

//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
	go_list();
}
//검색
function go_search(){
	go_list();
}
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/mail.do";
	pform.submit();

}

//메일 발송
function go_mail(target) {

	if($F("commYear") == "") {
		alert('년도를 선택하세요');
		return;
	}

	if($F("commGrcode") == "") {
		alert('과정을 선택하세요');
		return;
	}

	if($F("commGrseq") == "") {
		alert('과정기수를 선택하세요');
		return;
	}
	var grType = "<%= rowMap.getString("grtype") %>";
	var grSubcd = "<%= rowMap.getString("grsubcd") %>";

	var url = "http://hrd.incheon.go.kr:8090/weom/servlet/servlet.WSOMF044P0?h_grcode=" + $F("commGrcode") + "&h_grseq=" + $F("commGrseq") + "&h_grtype="+grType+"&h_grsubcd="+grSubcd+"&h_target="+ target;

	popWin(url, "pop_sendmail", "800", "600", "1", "");

}

//문자 보내기
function go_sms(qu) {

	if($F("commYear") == "") {
		alert('년도를 선택하세요');
		return;
	}

	if($F("commGrcode") == "") {
		alert('과정을 선택하세요');
		return;
	}

	if($F("commGrseq") == "") {
		alert('과정기수를 선택하세요');
		return;
	}
	var url = "/courseMgr/mail.do?mode=sms_pop&qu="+qu+"&grcode=" + $F("commGrcode") + "&grseq=" + $F("commGrseq");

	popWin(url, "pop_sendSms", "800", "600", "1", "");

}


//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = "grSeq"; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"					value="">

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
			<!-- subTitle
			<div class="tit01">
				<h2 class="h2"><img src="../images/bullet003.gif">과정기수관리 리스트</h2>
			</div>
			// subTitle -->

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
										<select name="commYear" onChange="getCommGrCode('grSeq');" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th width="80">
									과정명
								</th>
								<td>

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
								<td colspan="3">
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
							</tr>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>

						<!-- subTitle -->
						<h2 class="h2"><img src="../images/bullet003.gif"> 과정별메일발송관리 리스트 </h2>
						<!--// subTitle -->
						<div class="h5"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>구분</th>
								<th class="br0">비고</th>
							</tr>
							</thead>

							<tbody>
							<tr>
								<td>입교자대상 메일 발송</td>
								<td class="br0">
									<input type="button" value="메일 발송" onclick="go_mail('A1');" class="boardbtn1">
									<input type="button" value="문자 보내기" onclick="go_sms('enter');" class="boardbtn1">
								</td>
							</tr>
<!-- 							<tr>
								<td>미입교자대상 메일 발송</td>
								<td class="br0">
									<input type="button" value="메일 발송" onclick="go_mail('A6');" class="boardbtn1">
									<input type="button" value="문자 보내기" onclick="go_sms('noenter');" class="boardbtn1">
								</td>
							</tr> -->
							<tr>
								<td>수료자대상 설문 메일 발송</td>
								<td class="br0">
									<input type="button" value="메일 발송" onclick="go_mail('successQuestion');" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<td>수료자대상 메일 발송</td>
								<td class="br0">
									<input type="button" value="메일 발송" onclick="go_mail('A2');" class="boardbtn1">
									<input type="button" value="문자 보내기" onclick="go_sms('success');" class="boardbtn1">
								</td>
							</tr>
<!-- 							<tr>
								<td>미수료자대상 메일 발송</td>
								<td class="br0">
									<input type="button" value="메일 발송" onclick="go_mail('A3');" class="boardbtn1">
									<input type="button" value="문자 보내기" onclick="go_sms('fail');" class="boardbtn1">
								</td>
							</tr> -->
							<tr>
								<td>기관담당자대상 메일 발송</td>
								<td class="br0">
									<input type="button" value="메일 발송" onclick="go_mail('A4');" class="boardbtn1">
									<input type="button" value="문자 보내기" onclick="go_sms('dept');" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<td>강사대상 메일 발송</td>
								<td class="br0">
									<input type="button" value="메일 발송" onclick="go_mail('A5');" class="boardbtn1">
									<input type="button" value="문자 보내기" onclick="go_sms('tutor');" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<td>교육안내(입교자 대상)</td>
								<td class="br0">
									<input type="button" value="문자 보내기" onclick="go_sms('notice');" class="boardbtn1">
								</td>
							</tr>
							</tbody>
						</table>
						<!--//리스트  -->	
						<div class="h5"></div>

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

