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
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 먼저 선택하세요!" : grseqRowMap.getString("grcodeniknm") + " " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기";



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
	deptDogsListHeadStr += "\n<tr height='25'>";
	deptDogsListHeadStr += "\n	<td bgcolor='#FCFCFA' align=center><b>구분</b></td><td bgcolor='#FCFCFA' align=center><b>합계</b></td>";
	for(int i=0; i < deptList.keySize("dept"); i++){
		
		tmpStr = StringReplace.replaceStr(deptList.getString("deptnm", i), "인천광역시 ", "");
		tmpStr = StringReplace.replaceStr(tmpStr, "인천광역", "");
		deptDogsListHeadStr += "\n	<td bgcolor='#FCFCFA' align=center><b>" + tmpStr + "</b></td>";

		stuInfoTotCnt += deptList.getInt("deptsumCnt", i);
	} //end for
	//교육인원 설명.
	stuInfoDescStr = deptList.getString("deptnm") + "등 " + deptList.keySize("dept") + "개기관 " + stuInfoTotCnt + "명";
	deptDogsListHeadStr += "\n</tr>";

	
	//Body
	for(int i=0; i < deptDogsList.keySize("codenm"); i++){

		String tmpCrossStr = "";
		int deptDogsCrossTotCnt = 0;

		deptDogsListBodyStr += "\n<tr height='25'>";
		deptDogsListBodyStr += "\n	<td bgcolor='#FCFCFA' align=center>"+deptDogsList.getString("codenm", i)+"</td>"; //직급구분명

		for(int j = 0; j < deptList.keySize("dept"); j++){

			deptDogsCrossTotCnt += deptDogsList.getInt("dept"+(j+1), i); //합계 count
			tmpCrossStr += "\n	<td bgcolor='#EFF9EE' align=center>" + deptDogsList.getString("dept"+(j+1), i) + "</td>"; //각구별 인원수.
		}

		deptDogsListBodyStr += "\n	<td bgcolor='#EFF9EE' align=center>" + deptDogsCrossTotCnt + "</td>"; //합계
		deptDogsListBodyStr += tmpCrossStr; //각구별 인원수.

		deptDogsListBodyStr += "\n</tr>";
	}
	if( deptDogsList.keySize("codenm") <= 0 ){
		deptDogsListBodyStr += "\n<tr height='25'><td colspan='2' bgcolor='#EFF9EE' align=center>수강생이 없습니다.</td></tr>";
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
	jikrListHeadStr += "\n<tr height='25'>";
	jikrListHeadStr += "\n	<td bgcolor='#FCFCFA' align=center><b>구분</b></td><td bgcolor='#FCFCFA' align=center><b>합계</b></th>";
	for(int i=0; i < jikListMap.keySize("code"); i++){
		
		jikrListHeadStr += "\n	<td bgcolor='#FCFCFA' align=center><b>" + jikListMap.getString("codenm", i) + "</b></td>";

	} //end for
	jikrListHeadStr += "\n	<td bgcolor='#FCFCFA' align=center><b>기타</b></td>";
	jikrListHeadStr += "\n</tr>";

	
	//Body
	for(int i=0; i < jikrDogsList.keySize("codenm"); i++){

		String tmpCrossStr = "";
		int jikrCrossTotCnt = 0;

		jikrListBodyStr += "\n<tr height='25'>";
		jikrListBodyStr += "\n	<td bgcolor='#FCFCFA' align=center>"+jikrDogsList.getString("codenm", i)+"</td>"; //직급구분명

		for(int j = 0; j < jikListMap.keySize("code"); j++){
			jikrCrossTotCnt += jikrDogsList.getInt("jikr"+(j+1), i); //합계 count
			tmpCrossStr += "\n	<td bgcolor='#EFF9EE' align=center>" + jikrDogsList.getString("jikr"+(j+1), i) + "</td>"; //각구별 인원수.
		}

		jikrListBodyStr += "\n	<td bgcolor='#EFF9EE' align=center>" + (jikrCrossTotCnt + jikrDogsList.getInt("etc", i)) + "</td>"; //합계
		jikrListBodyStr += tmpCrossStr; //각구별 인원수.
		jikrListBodyStr += "\n	<td bgcolor='#EFF9EE' align=center>" + jikrDogsList.getString("etc", i)  + "</td>"; //합계

		jikrListBodyStr += "\n</tr>";
	}
	if( jikrDogsList.keySize("codenm") <= 0 ){
		jikrListBodyStr += "\n<tr height='25'><td colspan='3' bgcolor='#EFF9EE' align=center>수강생이 없습니다.</td></tr>";
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

<%
String toToYear = grseqRowMap.getString("grcodeniknm") + "입교현황분석";
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data");
response.setContentType("application/vnd.ms-excel");
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">










<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" colspan="2">
			<b> <%= grseqNm %> </b>
		</td>
	</tr>
	<tr>
		<td>
			&nbsp;
		</td>
		<td>
	<tr>
		<td height=30 valign=top></td>
	</tr>
	<tr>
		<td height=30 valign=top>
			<font color=000000><b>□ 교육기간 : <%= DateUtil.convertDate6(grseqRowMap.getString("started")) %> ~ <%= DateUtil.convertDate6(grseqRowMap.getString("enddate")) %></b></font>
		</td>
	</tr>
	<tr>
		<td height=30 valign=top>
			<font color=000000><b>□ 교육인원 : <%= stuInfoDescStr %></b></font>
		</td>
	</tr>

	<tr>
		<td bgcolor="E5E5E5">

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">

				<%= deptDogsListHeadStr %>


				<%= deptDogsListBodyStr %>

			</table>

		</td>
	</tr>
	<tr>
		<td>
			&#160;
		</td>
	</tr>
	<tr>
		<td height=20 valign=top>
			<font color=000000><b>□ 직렬별</b></font>
		</td>
	</tr>
	<tr>
		<td bgcolor="E5E5E5">
			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">
				<%= jikrListHeadStr %>


				<%= jikrListBodyStr %>
				
			</table>
		</td>
	</tr>
	<tr>
		<td>
			&nbsp;
		</td>
	</tr>

	<%	if(requestMap.getString("commGrcode").equals("0010000003")){ %>


	<tr>
		<td height=20 valign=top>
			<font color=000000><b>□ 재직기간별 </b></font>
		</td>
	</tr>
	<tr>
		<td bgcolor="E5E5E5">
			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">
				<tr bgcolor="#FCFCFA" height="25">
					<td align=center width=70>
						<b>구 분</b>
					</td>
					<td align=center width=60>
						<b>합계</b>
					</td>
					<td align=center width=60>
						<b>임용전</b>
					</td>
					<td align=center width=45>
						<b>1월이내</b>
					</td>
					<td align=center width=45>
						<b>1월초과<br>3월이내</b>
					</td>
					<td align=center width=45>
						<b>3월초과<br>6월이내</b>
					</td>
					<td align=center width=45>
						<b>6월초과<br>1년이내</b>
					</td>
					<td align=center width=45>
						<b>1년초과<br>2년이내</b>
					</td>
					<td align=center width=45>
						<b>2년초과</b>
					</td>
				</tr>
				<tr bgcolor="#EFF9EE" height="25">
					<td align=center bgcolor="#FCFCFA">
						<b>총계</b>
					</td>
					<td align=center><%= yearRowMap.getString("sum") %></td>
					<td align=center><%= yearRowMap.getString("y0") %></td>
					<td align=center><%= yearRowMap.getString("y2") %></td>
					<td align=center><%= yearRowMap.getString("y3") %></td>
					<td align=center><%= yearRowMap.getString("y4") %></td>
					<td align=center><%= yearRowMap.getString("y5") %></td>
					<td align=center><%= yearRowMap.getString("y6") %></td>
					<td align=center><%= yearRowMap.getString("y7") %></td>
				</tr>
			</table>
		</td>
	</tr>
	<%	}else{ %>

	<tr>
		<td height=20 valign=top>
			<font color=000000><b>□ 현직급 근무년수별 : 평균
					(<%= yearRowMap.getString("avgYear").equals("0") ? "" : yearRowMap.getString("avgYear") %>년) </b></font>
		</td>
	</tr>
	<tr>
		<td bgcolor="E5E5E5">
			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">
				<tr bgcolor="#FCFCFA" height="25">
					<td align=center width=70>
						<b>구 분</b>
					</td>
					<td align=center width=60>
						<b>합계</b>
					</td>
					<td align=center width=60>
						<b>3년미만</b>
					</td>
					<td align=center width=45>
						<b>3년</b>
					</td>
					<td align=center width=45>
						<b>4년</b>
					</td>
					<td align=center width=45>
						<b>5년</b>
					</td>
					<td align=center width=45>
						<b>6년</b>
					</td>
					<td align=center width=45>
						<b>7년</b>
					</td>
					<td align=center width=45>
						<b>8년</b>
					</td>
					<td align=center width=45>
						<b>9년</b>
					</td>
					<td align=center width=60>
						<b>10년이상</b>
					</td>
					<td align=center width="40">
						<b>비 고</b>
					</td>
				</tr>
				<tr bgcolor="#EFF9EE" height="25">
					<td align=center bgcolor="#FCFCFA">
						<b>총계</b>
					</td>
					<td align=center><%= yearRowMap.getString("sum") %></td>
					<td align=center><%= yearRowMap.getString("y2") %></td>
					<td align=center><%= yearRowMap.getString("y3") %></td>
					<td align=center><%= yearRowMap.getString("y4") %></td>
					<td align=center><%= yearRowMap.getString("y5") %></td>
					<td align=center><%= yearRowMap.getString("y6") %></td>
					<td align=center><%= yearRowMap.getString("y7") %></td>
					<td align=center><%= yearRowMap.getString("y8") %></td>
					<td align=center><%= yearRowMap.getString("y9") %></td>
					<td align=center><%= yearRowMap.getString("y10") %></td>
					<td align=center>
						&#160;
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<%	} // end if %>


	<tr>
		<td>
			&#160;
		</td>
	</tr>
	<tr>
		<td>
			&#160;
		</td>
	</tr>
	<tr>
		<td height=20 valign=top>
			<font color=000000><b>□ 연령별 : 평균 (<%= ageRowMap.getString("avgAge").equals("0") ? "" : ageRowMap.getString("avgAge") %>세)</b></font>
		</td>
	</tr>
	<tr>
		<td bgcolor="E5E5E5">
			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">
				<tr bgcolor="#FCFCFA" height="25">
					<td align=center width=70>
						<b>구 분</b>
					</td>
					<td align=center width=60>
						<b>합계</b>
					</td>
					<td align=center width=65>
						<b>25세이하</b>
					</td>
					<td align=center width=65>
						<b>26세<br>~30세</b>
					</td>
					<td align=center width=65>
						<b>31세<br>~35세</b>
					</td>
					<td align=center width=65>
						<b>36세<br>~40세</b>
					</td>
					<td align=center width=65>
						<b>41세<br>~45세</b>
					</td>
					<td align=center width=65>
						<b>46세<br>~50세</b>
					</td>
					<td align=center width=65>
						<b>51세<br>~55세</b>
					</td>
					<td align=center width=65>
						<b>56세이상</b>
					</td>
				</tr>
				<tr bgcolor="#EFF9EE" height="25">
					<td align=center bgcolor="#FCFCFA">
						<b>총계</b>
					</td>
					<td align=center><%= ageRowMap.getString("t") %></td>
					<td align=center><%= ageRowMap.getString("t1") %></td>
					<td align=center><%= ageRowMap.getString("t2") %></td>
					<td align=center><%= ageRowMap.getString("t3") %></td>
					<td align=center><%= ageRowMap.getString("t4") %></td>
					<td align=center><%= ageRowMap.getString("t5") %></td>
					<td align=center><%= ageRowMap.getString("t6") %></td>
					<td align=center><%= ageRowMap.getString("t7") %></td>
					<td align=center><%= ageRowMap.getString("t8") %></td>
				</tr>
				<tr bgcolor="#EFF9EE" height="25">
					<td align=center bgcolor="#FCFCFA">
						<b>남</b>
					</td>
					<td align=center><%= ageRowMap.getString("tm") %></td>
					<td align=center><%= ageRowMap.getString("m1") %></td>
					<td align=center><%= ageRowMap.getString("m2") %></td>
					<td align=center><%= ageRowMap.getString("m3") %></td>
					<td align=center><%= ageRowMap.getString("m4") %></td>
					<td align=center><%= ageRowMap.getString("m5") %></td>
					<td align=center><%= ageRowMap.getString("m6") %></td>
					<td align=center><%= ageRowMap.getString("m7") %></td>
					<td align=center><%= ageRowMap.getString("m8") %></td>
				</tr>
				<tr bgcolor="#EFF9EE" height="25">
					<td align=center bgcolor="#FCFCFA">
						<b>여</b>
					</td>
					<td align=center><%= ageRowMap.getString("tf") %></td>
					<td align=center><%= ageRowMap.getString("f1") %></td>
					<td align=center><%= ageRowMap.getString("f2") %></td>
					<td align=center><%= ageRowMap.getString("f3") %></td>
					<td align=center><%= ageRowMap.getString("f4") %></td>
					<td align=center><%= ageRowMap.getString("f5") %></td>
					<td align=center><%= ageRowMap.getString("f6") %></td>
					<td align=center><%= ageRowMap.getString("f7") %></td>
					<td align=center><%= ageRowMap.getString("f8") %></td>
				</tr>

			</table>
		</td>
	</tr>

	<tr>
		<td>
			&#160;
		</td>
	</tr>
	<tr>
		<td height=20 valign=top>
			<font color=000000><b>□ 학력별</b></font>
		</td>
	</tr>
	<tr>
		<td bgcolor="E5E5E5">
			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">
				<tr bgcolor="#FCFCFA" height="25">
					<td align=center width=70>
						<b>구 분</b>
					</td>
					<td align=center width=60>
						<b>합계</b>
					</td>
					<td align=center width=65>
						<b>고졸미만</b>
					</td>
					<td align=center width=65>
						<b>고졸</b>
					</td>
					<td align=center width=65>
						<b>초대졸</b>
					</td>
					<td align=center width=65>
						<b>대졸</b>
					</td>
					<td align=center width=65>
						<b>석사</b>
					</td>
					<td align=center width=65>
						<b>박사</b>
					</td>
					<td align=center width=65>
						<b>기타</b>
					</td>
				</tr>
				<tr bgcolor="#EFF9EE" height="25">
					<td align=center bgcolor="#FCFCFA">
						<b>총계</b>
					</td>
					<td align=center><%= schoolMap.getInt("sum") %></td>
					<td align=center><%= schoolMap.getInt("06") %></td>
					<td align=center><%= schoolMap.getInt("05") %></td>
					<td align=center><%= schoolMap.getInt("04") %></td>
					<td align=center><%= schoolMap.getInt("03") %></td>
					<td align=center><%= schoolMap.getInt("02") %></td>
					<td align=center><%= schoolMap.getInt("01") %></td>
					<td align=center><%= schoolMap.getInt("07") %></td>
				</tr>
			</table>
		</td>
	</tr>


	<tr>
		<td>
			&#160;
		</td>
	</tr>
	<tr>
		<td height=20 valign=top>
			<font color=000000><b>□ 거주지별</b></font>
		</td>
	</tr>
	<tr>
		<td bgcolor="E5E5E5">
			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">
				<tr bgcolor="#FCFCFA" height="25">
					<td align=center width=70>
						<b>구 분</b>
					</td>
					<td align=center width=60>
						<b>합계</b>
					</td>
					<td align=center>
						<b>중구</b>
					</td>
					<td align=center width=65>
						<b>동구</b>
					</td>
					<td align=center width=65>
						<b>남구</b>
					</td>
					<td align=center width=65>
						<b>연수구</b>
					</td>
					<td align=center width=65>
						<b>남동구</b>
					</td>
					<td align=center width=65>
						<b>부평구</b>
					</td>
					<td align=center width=65>
						<b>계양구</b>
					</td>
					<td align=center width=65>
						<b>서구</b>
					</td>
					<td align=center width=65>
						<b>강화군</b>
					</td>
					<td align=center width=65>
						<b>옹진군</b>
					</td>
					<td align=center width=65>
						<b>기타</b>
					</td>
				</tr>
				<tr bgcolor="#EFF9EE" height="25">
					<td align=center bgcolor="#FCFCFA">
						<b>총계</b>
					</td>
					<td align=center><%= addrMap.getInt("sum") %></td>
					<td align=center><%= addrMap.getInt("a1") %></td>
					<td align=center><%= addrMap.getInt("a2") %></td>
					<td align=center><%= addrMap.getInt("a3") %></td>
					<td align=center><%= addrMap.getInt("a4") %></td>
					<td align=center><%= addrMap.getInt("a5") %></td>
					<td align=center><%= addrMap.getInt("a6") %></td>
					<td align=center><%= addrMap.getInt("a7") %></td>
					<td align=center><%= addrMap.getInt("a8") %></td>
					<td align=center><%= addrMap.getInt("a9") %></td>
					<td align=center><%= addrMap.getInt("a10") %></td>
					<td align=center><%= addrMap.getInt("a11") %></td>
				</tr>
			</table>
		</td>
	</tr>




	<tr>
		<td>
			&#160;
		</td>
	</tr>
</table>























