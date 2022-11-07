<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 입교 현황 분석
// date : 2008-09-24
// auth : 정윤철
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

function newSetPrintSettings() {
  try {
		factory.printing.header = ""; // Header에 들어갈 문장
		factory.printing.footer = ""; // Footer에 들어갈 문장
		factory.printing.portrait = true // true 면 가로인쇄, false 면 세로 인쇄
		factory.printing.leftMargin = 1.0 // 왼쪽 여백 사이즈
		factory.printing.topMargin = 10.0 // 위 여백 사이즈
		factory.printing.rightMargin = 1.0 // 오른쪽 여백 사이즈
		factory.printing.bottomMargin = 1.0 // 아래 여백 사이즈
		factory.printing.paperSource = "Manual feed"; // 종이 Feed 방식
	}catch (e)
	{
    	//alert('출력중 에러가 발생 하였습니다.');
    	return;
	}
}

function SetPrintSettings() {
	try {
		factory.printing.header = ""; // Header에 들어갈 문장
		factory.printing.footer = ""; // Footer에 들어갈 문장
		factory.printing.portrait = true // true 면 가로인쇄, false 면 세로 인쇄
		factory.printing.leftMargin = 0.0 // 왼쪽 여백 사이즈
		factory.printing.topMargin = 5.0 // 위 여백 사이즈
		factory.printing.rightMargin = 0.0 // 오른쪽 여백 사이즈
		factory.printing.bottomMargin = 5.0 // 아래 여백 사이즈
	//	factory.printing.SetMarginMeasure(2); // 테두리 여백 사이즈 단위를 인치로 설정합니다.
	//	factory.printing.printer = factory.printing.DefaultPrinter(); // 프린트 할 프린터 이름
	//	factory.printing.paperSize = "A4"; // 용지 사이즈
	//	factory.printing.paperSource = "Manual feed"; // 종이 Feed 방식
	//	factory.printing.collate = true; // 순서대로 출력하기
	//	factory.printing.copies = 1; // 인쇄할 매수
	//	factory.printing.SetPageRange(false, 1, 1); // True로 설정하고 1, 3이면 1페이지에서 3페이지까지 출력
	}catch (e)
	{
    	alert('출력중 에러가 발생 하였습니다.');
    	return;
	}
}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<script language="JavaScript">
<!--
//Scriptx Obj
com_printManager1();
com_printManager2();
com_printManager3();
//-->
</script>

<!--[s] Contents Form  -->
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
	<tr>
		<td>
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
<!--[ 코딩 끝 ] ------------------------------------------------------------------------------------------------------>
<SCRIPT LANGUAGE="JavaScript">
<!--
newSetPrintSettings();
//factory.printing.Preview();
factory.printing.Print(true, window);
//-->
</SCRIPT>