<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시간표 - 교과목 편성시간 및 강사
// date : 2008-08-01
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       


	//과정기수 정보.
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

    //과목분류별 건수
	DataMap subjGubunCntMap = (DataMap)request.getAttribute("COUNT_LIST_DATA");
	subjGubunCntMap.setNullToInitialize(true);


    //과목 구분 리스트.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 


	String tmpStr = "";
	String listStr = "";
	
	int subjCnt = 0; //구분별 과목 갯수
	int totalCnt = 0; //소계
	for(int i=0; i < listMap.keySize("gubun"); i++){

		subjCnt = 0;
		totalCnt = 0;

		for(int k=0; k < subjGubunCntMap.keySize("subjgubun"); k++){
			if( subjGubunCntMap.getString("subjgubun", k).equals(listMap.getString("gubun", i)) ){
				subjCnt = subjGubunCntMap.getInt("subjcnt", k);
				totalCnt = subjGubunCntMap.getInt("tottime", k);
				break;
			}
		}

		listStr += "\n<tr>";

		//소양분야
		tmpStr = listMap.getString("gubunnm", i)+ "<br>총" + subjCnt + "과목";
		listStr += "\n	<td align='center' width='15%' rowspan='2'>" + tmpStr + "</td>";

		//소계
		listStr += "\n	<td align='center' width='45%'>소계</td>";

		//시간
		listStr += "\n	<td align='center'>" + totalCnt + "</td>";

		//소속
		listStr += "\n	<td align='center'></td>";

		//성명
		listStr += "\n	<td align='center'></td>";

		//비고
		listStr += "\n	<td align='center'></td>";

		DataMap subjListMap = (DataMap)listMap.get("SUBJGUBUN_LIST_DATA", i);
		if(subjListMap == null) subjListMap = new DataMap();
		subjListMap.setNullToInitialize(true);


		String subjnm = "";
		String tutor = "";
		String subjtime = "";

		for(int k=0; k < subjListMap.keySize("subj"); k++){

			subjnm += subjListMap.getString("subjnm", k) + "<br>";
			tutor += subjListMap.getString("name", k) + "<br>";

			if( subjListMap.getString("subjnm", k).equals("SUB1000026") )
				subjtime += "(0.5)<br>";
			else
				subjtime += subjListMap.getString("tottime", k) + "<br>";
		}

		listStr += "\n</tr>";
		listStr += "\n<tr>";

		//소계
		listStr += "\n	<td align='center' width='45%'>" + subjnm + "</td>";

		//시간
		listStr += "\n	<td align='center'>" + subjtime + "</td>";

		//소속
		listStr += "\n	<td align='center'></td>";

		//성명
		listStr += "\n	<td align='center'>" + tutor + "</td>";

		//비고
		listStr += "\n	<td align='center'></td>";


		listStr += "\n</tr>";
			

	}


	String grseqNm = grseqRowMap.getString("grcodeniknm") + " - " + StringReplace.subString(grseqRowMap.getString("grseq"), 0, 4) + "년 " + StringReplace.subString(grseqRowMap.getString("grseq"), 4, 6) + "기";


%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--


//-->
</script>


<body>

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" name="grseq"				value='<%=requestMap.getString("grseq")%>'>


<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 교과목 편성시간 및 강사</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">
			<!-- date -->
			<table  class="dataw01">
				<tr>
					<th colspan="100%" class="br0"><strong><%= grseqNm %></strong></th>
				</tr>
				<tr>
					<th width="60%" colspan="2">교과목</th>
					<th width="10%" align="center">시간</th>
					<th width="20%" colspan="2" align="center">강사</th>
					<th width="10%" align="center" class="br0">비고</th>
				</tr>
				<tr>
					<td width="60%" colspan="2" align="center">계</td>
					<td width="10%" align="center">시간</td>
					<td width="10%" align="center">소속</td>
					<td width="10%" align="center">성명</td>
					<td width="10%" align="center">비고</td>
				</tr>

				<%= listStr %>

			</table>
			<!-- //date -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>
</form>

</body>
