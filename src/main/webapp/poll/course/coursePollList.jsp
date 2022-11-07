<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 설문관리 - 설문지 관리.
// date : 2008-09-16
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


	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//간단한 과정 기수 정보
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("grcode"); i++){

		listStr.append("\n<tr>");


		//회차
		listStr.append("\n	<td>" + listMap.getString("titleSeq", i) + "</td>");

		//제목
		listStr.append("\n	<td>" + listMap.getString("title", i) + "</td>");

		//실시
		tmpStr = listMap.getString("useYn", i).equals("y") ? "실시" : "미실시";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//미응시
		tmpStr = "<input type='button' value='조회' onclick=\"go_notApply('"+listMap.getString("titleNo", i)+"');\" class='boardbtn1'>";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//구분
		tmpStr = listMap.getString("gubunOnOff", i).equals("off") ? "오프라인" : "온라인";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//설문분석
		tmpStr = "<input type='button' value='설문분석' onclick=\"go_modify('"+listMap.getString("titleNo", i)+"');\" class='boardbtn1'>";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//설문적용기간
		tmpStr = listMap.getString("srdate", i) + "<br>" + listMap.getString("erdate", i);
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//설문실시기간
		tmpStr = listMap.getString("sdate", i) + "<br>" + listMap.getString("edate", i);
		listStr.append("\n	<td>" + tmpStr + "</td>");


		//비고
		tmpStr = "<input type='button' value='수정' onclick=\"go_modify('"+listMap.getString("titleNo", i)+"');\" class='boardbtn1'>";
		tmpStr += "<input type='button' value='삭제' onclick=\"go_delete('"+listMap.getString("titleNo", i)+"');\" class='boardbtn1'>";
		listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");


		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("grcode") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' style=\"height:100px\"  class='br0'>현재 진행중인 설문이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 선택하세요!" : grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기 설문관리";



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

	go_list();
}
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/poll/coursePoll.do";
	pform.submit();

}

//미응시 조회
function go_notApply(titleNo){

	if( $F("grcode") == "" || $F("grseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}

	var mode = "notapply_pop";
	var menuId = $F("menuId");
	var url = "/poll/coursePoll.do?mode=" + mode + "&menuId=" + menuId + "&grcode=" + $F("grcode") + "&grseq=" + $F("grseq") + "&titleNo=" + titleNo;

	popWin(url, "pop_pollNotApply", "700", "600", "1", "");

}


//통합결과보기
function go_resultView(){

	if( $F("grcode") == "" || $F("grseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}

	var mode = "total_result";
	var menuId = $F("menuId");
	var url = "/poll/coursePoll.do?mode=" + mode + "&menuId=" + menuId + "&grcode=" + $F("grcode") + "&grseq=" + $F("grseq");

	popWin(url, "pop_pollResultView", "750", "800", "1", "");

}


//추가
function go_add(){

	if( $F("grcode") == "" || $F("grseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}

	$("titleNo").value = "";

	$("mode").value = "form";
	$("qu").value = "insert";

	pform.action = "/poll/coursePoll.do";
	pform.submit();

}

//수정
function go_modify(titleNo){

	if( $F("grcode") == "" || $F("grseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}

	$("titleNo").value = titleNo;

	$("mode").value = "form";
	$("qu").value = "update";

	pform.action = "/poll/coursePoll.do";
	pform.submit();

}

//삭제
function go_delete(titleNo){

	if( $F("grcode") == "" || $F("grseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}

	if(confirm('삭제 하시겠습니까?')) {

		$("titleNo").value = titleNo;

		$("mode").value = "exec";
		$("qu").value = "all_del";

		pform.action = "/poll/coursePoll.do";
		pform.submit();

	}
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

<form id="pform" name="pform" method="post" >
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">

<input type="hidden" name="qu"					value="">
<input type="hidden" name="titleNo"				value="">

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


 						<table class="btn01">
							<tr>
								<td class="left">
									<h2 class="h2"><img src="/images/bullet003.gif"> <%= grseqNm %> </h2>
								</td>
								<td class="right">
									<input type="button" value="통합결과보기" onclick="go_resultView();" class="boardbtn1">
									<input type="button" value="설문추가" onclick="go_add();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--[s] 리스트  -->

						<table class="datah01">
							<thead>
								<tr>
									<th>회차</th>
									<th>제목</th>
									<th>실시</th>
									<th>미응시</th>
									<th>구분</th>
									<th>설문분석</th>
									<th>설문적용기간</th>
									<th>설문실시기간</th>
									<th class="br0">비고</th>
								</tr>
							</thead>

							<tbody>
								<%= listStr.toString() %>
							</tbody>
						</table>

						<!--//[e] 리스트  -->



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

