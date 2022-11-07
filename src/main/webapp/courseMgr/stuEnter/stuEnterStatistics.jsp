<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 입교 현황 분석
// date : 2008-07-02
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


	//간단한 과정 기수 정보
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);


	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 먼저 선택하세요!" : grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기";



	//부서 리스트
	DataMap deptList = (DataMap)request.getAttribute("DEPT_LIST_DATA");
	deptList.setNullToInitialize(true);

	//기관/계급명 CROSS 통계
	DataMap deptDogsList = (DataMap)request.getAttribute("DEPTDOGS_LIST_DATA");
	deptDogsList.setNullToInitialize(true);

	String tmpStr = "";
	String checkClassStr = "";

	//교육인원 설명.
	String stuInfoDescStr = "";
	int stuInfoTotCnt = 0;


	/** 교육인원 START */
	//기관/계급명 CROSS 통계
	String deptDogsListHeadStr = "";
	String deptDogsListBodyStr = "";

	//Hearder
	deptDogsListHeadStr += "\n<tr>";
	deptDogsListHeadStr += "\n	<th>구분</th><th>합계</th>";
	for(int i=0; i < deptList.keySize("dept"); i++){
		
		if( i == (deptList.keySize("dept")-1))
			checkClassStr = "class='br0'";
		else
			checkClassStr = "";
		
		tmpStr = StringReplace.replaceStr(deptList.getString("deptnm", i), "인천광역시 ", "");
		tmpStr = StringReplace.replaceStr(tmpStr, "인천광역", "");
		deptDogsListHeadStr += "\n	<th "+checkClassStr+">" + tmpStr + "</th>";

		stuInfoTotCnt += deptList.getInt("deptsumCnt", i);
	} //end for
	//교육인원 설명.
	stuInfoDescStr = deptList.getString("deptnm") + "등 " + deptList.keySize("dept") + "개기관 " + stuInfoTotCnt + "명";
	deptDogsListHeadStr += "\n</tr>";

	
	//Body
	for(int i=0; i < deptDogsList.keySize("codenm"); i++){

		String tmpCrossStr = "";
		int deptDogsCrossTotCnt = 0;

		deptDogsListBodyStr += "\n<tr>";
		deptDogsListBodyStr += "\n	<td>"+deptDogsList.getString("codenm", i)+"</td>"; //직급구분명

		for(int j = 0; j < deptList.keySize("dept"); j++){
			deptDogsCrossTotCnt += deptDogsList.getInt("dept"+(j+1), i); //합계 count

			if( j == (deptList.keySize("dept") -1))
				checkClassStr = "class='br0'";
			else
				checkClassStr = "";
			tmpCrossStr += "\n	<td "+checkClassStr+">" + deptDogsList.getString("dept"+(j+1), i) + "</td>"; //각구별 인원수.
		}

		deptDogsListBodyStr += "\n	<td>" + deptDogsCrossTotCnt + "</td>"; //합계
		deptDogsListBodyStr += tmpCrossStr; //각구별 인원수.

		deptDogsListBodyStr += "\n</tr>";
	}
	if( deptDogsList.keySize("codenm") <= 0 ){
		deptDogsListBodyStr += "\n<tr><td colspan='100%' class='br0'>수강생이 없습니다.</td></tr>";
	}
	/** 교육인원 END */




	//직렬
	DataMap jikListMap = (DataMap)request.getAttribute("JIKR_LIST_DATA");
	jikListMap.setNullToInitialize(true);

	//직렬/계급명 CROSS 통계
	DataMap jikrDogsList = (DataMap)request.getAttribute("JIKRDOGS_LIST_DATA");
	jikrDogsList.setNullToInitialize(true);



	/** 직렬별 START */
	//기관/계급명 CROSS 통계
	String jikrListHeadStr = "";
	String jikrListBodyStr = "";

	//Hearder
	jikrListHeadStr += "\n<tr>";
	jikrListHeadStr += "\n	<th>구분</th><th>합계</th>";
	for(int i=0; i < jikListMap.keySize("code"); i++){
		
		if( i == (jikListMap.keySize("code")-1))
			checkClassStr = "class='br0'";
		else
			checkClassStr = "";
		
		jikrListHeadStr += "\n	<th "+checkClassStr+">" + jikListMap.getString("codenm", i) + "</th>";

	} //end for
	jikrListHeadStr += "\n	<th class='br0'>기타</th>";
	jikrListHeadStr += "\n</tr>";

	
	//Body
	for(int i=0; i < jikrDogsList.keySize("codenm"); i++){

		String tmpCrossStr = "";
		int jikrCrossTotCnt = 0;

		jikrListBodyStr += "\n<tr>";
		jikrListBodyStr += "\n	<td>"+jikrDogsList.getString("codenm", i)+"</td>"; //직급구분명

		for(int j = 0; j < jikListMap.keySize("code"); j++){
			jikrCrossTotCnt += jikrDogsList.getInt("jikr"+(j+1), i); //합계 count
			tmpCrossStr += "\n	<td>" + jikrDogsList.getString("jikr"+(j+1), i) + "</td>"; //각구별 인원수.
		}

		jikrListBodyStr += "\n	<td>" + (jikrCrossTotCnt + jikrDogsList.getInt("etc", i)) + "</td>"; //합계
		jikrListBodyStr += tmpCrossStr; //각구별 인원수.
		jikrListBodyStr += "\n	<td class='br0'>" + jikrDogsList.getString("etc", i)  + "</td>"; //합계

		jikrListBodyStr += "\n</tr>";
	}
	if( jikrDogsList.keySize("codenm") <= 0 ){
		jikrListBodyStr += "\n<tr><td colspan='100%' class='br0'>수강생이 없습니다.</td></tr>";
	}
	/** 직렬별 END */


	//년도별
	DataMap yearRowMap = (DataMap)request.getAttribute("YEAR_ROW_DATA");
	yearRowMap.setNullToInitialize(true);

	//연령별
	DataMap ageRowMap = (DataMap)request.getAttribute("AGE_ROW_DATA");
	ageRowMap.setNullToInitialize(true);


	//학력별
	DataMap schoolMap = (DataMap)request.getAttribute("SCHOOL_ROW_DATA");
	schoolMap.setNullToInitialize(true);

	//거주지별
	DataMap addrMap = (DataMap)request.getAttribute("ADDR_ROW_DATA");
	addrMap.setNullToInitialize(true);


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

	$("mode").value = "statistics";

	pform.action = "/courseMgr/stuEnter.do";
	pform.submit();

}


//엑셀 출력하기.
function go_excel(){

	if( $F("commGrcode") == "" || $F("commGrseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}

	$("mode").value = "statistics_excel";
	$("qu").value = "";

	pform.action = "/courseMgr/stuEnter.do";
	pform.submit();

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

//수료증 HTML
function go_htmlView() {

	popWin("", "pop_ResultDocHtml", "1024", "1050", "1", "0");
	
	if($("commYear").value == ""){
		alert("년도를 선택 하세요");
		return false;
		
	}else if($("commGrcode").value == ""){
		alert("과정명을  선택 하세요");
		return false;
		
	}else if($("commGrseq").value == ""){
		alert("기수를 선택 하세요");
		return false;
	}
	
	
	$("mode").value = "statistics_print";
	$("qu").value = "";

	pform.target = "pop_ResultDocHtml";
	pform.action = "/courseMgr/stuEnter.do";
	pform.submit();
	
	pform.target = "";

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
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
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
								<td>

									<div id="divCommGrCode" class="commonDivLeft">
										<select name="commGrcode" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>

								</td>
								<td width="100" class="btnr" rowspan="2">
									<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
									<input type="button" value="출력" onclick="go_htmlView();" class="boardbtn1">
									<input type="button" value="EXCEL" onclick="go_excel();" class="boardbtn1">
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
						<h2 class="h2"><img src="/images/bullet003.gif"> <%= grseqNm %> </h2>
						<!--// subTitle -->
						 <div class="space01"></div>

						<!-- subTitle -->
						<h3 class="h3"><img src="/images/bullet004.gif"> 교육기간 : <span class="txt_66 txt_normal"><%= DateUtil.convertDate6(grseqRowMap.getString("started")) %> ~ <%= DateUtil.convertDate6(grseqRowMap.getString("enddate")) %></span></h3>
						<!--// subTitle  -->
						<div class="h5"></div>

						<div class="space01"></div>

						<!-- subTitle -->
						<h3 class="h3"><img src="/images/bullet004.gif"> 교육인원 : <span class="txt_66 txt_normal"><%= stuInfoDescStr %></span></h3>
						<!--// subTitle -->

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
								<%= deptDogsListHeadStr %>
							</thead>

							<tbody>
								<%= deptDogsListBodyStr %>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	
						<div class="space01"></div>

						<!-- subTitle -->
						<h3 class="h3"><img src="/images/bullet004.gif"> 직렬별</h3>
						<!--// subTitle -->
            

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
								<%= jikrListHeadStr %>
							</thead>

							<tbody>
							<tr>
								<%= jikrListBodyStr %>
							</tr>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	
						<div class="space01"></div>

						<%
						if(requestMap.getString("commGrcode").equals("0010000003")){
						%>
						<!-- subTitle -->
						<h3 class="h3"><img src="/images/bullet004.gif"> 재직기간별 </h3>
						<!--// subTitle -->

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>구분</th>
								<th>합계</th>
								<th>임용전</th>
								<th>1월이내</th>
								<th>1월초과<br>3월이내</th>
								<th>3월초과<br>6월이내</th>
								<th>6월초과<br>1년이내</th>
								<th>1년초과<br>2년이내</th>
								<th class="br0">2년초과</th>
							</tr>
							</thead>

							<tbody>
							<tr>
								<td class="bg01">총계</td>
								<td><%= yearRowMap.getString("sum") %></td>
								<td><%= yearRowMap.getString("y0") %></td>
								<td><%= yearRowMap.getString("y2") %></td>
								<td><%= yearRowMap.getString("y3") %></td>
								<td><%= yearRowMap.getString("y4") %></td>
								<td><%= yearRowMap.getString("y5") %></td>
								<td><%= yearRowMap.getString("y6") %></td>
								<td class="br0"><%= yearRowMap.getString("y7") %></td>
							</tr>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	
						<div class="space01"></div>
						<%
						}else{
						%>
						<!-- subTitle -->
						<h3 class="h3"><img src="/images/bullet004.gif"> 현직급 근무년수별 : <span class="txt_66 txt_normal">평균 (<%= yearRowMap.getString("avgYear").equals("0") ? "" : yearRowMap.getString("avgYear") %>년)</span></h3>
						<!--// subTitle -->

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>구분</th>
								<th>합계</th>
								<th>1년미만</th>
								<th>2년</th>
								<th>3년</th>
								<th>4년</th>
								<th>5년</th>
								<th>6년</th>
								<th>7년</th>
								<th>8년</th>
								<th>9년이상</th>
								<th class="br0">비고</th>
							</tr>
							</thead>

							<tbody>
							<tr>
								<td class="bg01">총계</td>
								<td><%= yearRowMap.getString("sum") %></td>
								<td><%= yearRowMap.getString("y2") %></td>
								<td><%= yearRowMap.getString("y3") %></td>
								<td><%= yearRowMap.getString("y4") %></td>
								<td><%= yearRowMap.getString("y5") %></td>
								<td><%= yearRowMap.getString("y6") %></td>
								<td><%= yearRowMap.getString("y7") %></td>
								<td><%= yearRowMap.getString("y8") %></td>
								<td><%= yearRowMap.getString("y9") %></td>
								<td><%= yearRowMap.getString("y10") %></td>
								<td class="br0">&nbsp;</td>
							</tr>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	
						<div class="space01"></div>
						<%
						}
						%>
						 <!-- subTitle -->
						<h3 class="h3"><img src="/images/bullet004.gif"> 연령별 : <span class="txt_66 txt_normal">평균 (<%= ageRowMap.getString("avgAge").equals("0") ? "" : ageRowMap.getString("avgAge") %>세)</span></h3>
						<!--// subTitle -->

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>구분</th>
								<th>합계</th>
								<th>25세이하</th>
								<th>26세~30세</th>
								<th>31세~35세</th>
								<th>36세~40세</th>
								<th>41세~45세</th>
								<th>46세~50세</th>
								<th>51세~55세</th>
								<th class="br0">56세이상</th>
							</tr>
							</thead>

							<tbody>
							<tr>
								<td class="bg01">총계</td>
								<td><%= ageRowMap.getString("t") %></td>
								<td><%= ageRowMap.getString("t1") %></td>
								<td><%= ageRowMap.getString("t2") %></td>
								<td><%= ageRowMap.getString("t3") %></td>
								<td><%= ageRowMap.getString("t4") %></td>
								<td><%= ageRowMap.getString("t5") %></td>
								<td><%= ageRowMap.getString("t6") %></td>
								<td><%= ageRowMap.getString("t7") %></td>
								<td class="br0"><%= ageRowMap.getString("t8") %></td>
							</tr>
							<tr>
								<td class="bg01">남</td>
								<td><%= ageRowMap.getString("tm") %></td>
								<td><%= ageRowMap.getString("m1") %></td>
								<td><%= ageRowMap.getString("m2") %></td>
								<td><%= ageRowMap.getString("m3") %></td>
								<td><%= ageRowMap.getString("m4") %></td>
								<td><%= ageRowMap.getString("m5") %></td>
								<td><%= ageRowMap.getString("m6") %></td>
								<td><%= ageRowMap.getString("m7") %></td>
								<td class="br0"><%= ageRowMap.getString("m8") %></td>
							</tr>
							<tr>
								<td class="bg01">여</td>
								<td><%= ageRowMap.getString("tf") %></td>
								<td><%= ageRowMap.getString("f1") %></td>
								<td><%= ageRowMap.getString("f2") %></td>
								<td><%= ageRowMap.getString("f3") %></td>
								<td><%= ageRowMap.getString("f4") %></td>
								<td><%= ageRowMap.getString("f5") %></td>
								<td><%= ageRowMap.getString("f6") %></td>
								<td><%= ageRowMap.getString("f7") %></td>
								<td class="br0"><%= ageRowMap.getString("f8") %></td>
							</tr>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	
						<div class="space01"></div>

						<!-- subTitle -->
						<h3 class="h3"><img src="/images/bullet004.gif"> 학력별</h3>
						<!--// subTitle -->

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>구분</th>
								<th>합계</th>
								<th>고졸미만</th>
								<th>고졸</th>
								<th>초대졸</th>
								<th>대졸</th>
								<th>석사</th>
								<th>박사</th>
								<th class="br0">기타</th>
							</tr>
							</thead>

							<tbody>
							<tr>
								<td class="bg01">총계</td>
								<td><%= schoolMap.getInt("sum") %></td>
								<td><%= schoolMap.getInt("06") %></td>
								<td><%= schoolMap.getInt("05") %></td>
								<td><%= schoolMap.getInt("04") %></td>
								<td><%= schoolMap.getInt("03") %></td>
								<td><%= schoolMap.getInt("02") %></td>
								<td><%= schoolMap.getInt("01") %></td>
								<td class="br0"><%= schoolMap.getInt("07") %></td>
							</tr>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	
						<div class="space01"></div>

						<!-- subTitle -->
						<h3 class="h3"><img src="/images/bullet004.gif"> 거주지별</h3>
						<!--// subTitle -->

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>구분</th>
								<th>합계</th>
								<th>중구</th>
								<th>동구</th>
								<th>남구</th>
								<th>연수구</th>
								<th>남동구</th>
								<th>부평구</th>
								<th>계양구</th>
								<th>서구</th>
								<th>강화군</th>
								<th>옹진군</th>
								<th class="br0">기타</th>
							</tr>
							</thead>

							<tbody>
							<tr>
								<td class="bg01">총계</td>
								<td><%= addrMap.getInt("sum") %></td>
								<td><%= addrMap.getInt("a1") %></td>
								<td><%= addrMap.getInt("a2") %></td>
								<td><%= addrMap.getInt("a3") %></td>
								<td><%= addrMap.getInt("a4") %></td>
								<td><%= addrMap.getInt("a5") %></td>
								<td><%= addrMap.getInt("a6") %></td>
								<td><%= addrMap.getInt("a7") %></td>
								<td><%= addrMap.getInt("a8") %></td>
								<td><%= addrMap.getInt("a9") %></td>
								<td><%= addrMap.getInt("a10") %></td>
								<td class="br0"><%= addrMap.getInt("a11") %></td>
							</tr>
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

