<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 안내 미리보기 팝업
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


    //수료이력 리스트
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true); 

	//과정 기수 정보.
	DataMap grseqMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqMap.setNullToInitialize(true);

	//과목 코드
	String subj = (String)request.getAttribute("SUBJ_STRING");


	String rowStr = "";
	String tmpStr = "";
	/*
	if( rowMap.getString("guide1").equals("Y") )
		rowStr += "<a title='교육계획' href=\"javascript:go_report(1);\">① 교육계획</a> <br><br>";
	if( rowMap.getString("guide2").equals("Y") )
		rowStr += "<a title='교과목 편성시간 및 강사' href=\"javascript:go_report(2);\">② 교과목 편성시간 및 강사</a> <br><br>";
	if( rowMap.getString("guide3").equals("Y") ){
		
		tmpStr += "<select name='weekNo' style='font:11px'>";
		for(int i = 1; i <= grseqMap.getInt("weekCnt") ; i++)
			tmpStr += "<option value='" + i + "'>" + i + "주차</option>";
		tmpStr += "</select>";

		rowStr += "<a title='교육시간표' href=\"javascript:go_report(3);\">③ 교육시간표</a> " + tmpStr + "<br><br>";
	}
	if( rowMap.getString("guide4").equals("Y") )
		rowStr += "<a title='교육생(입교자)현황' href=\"javascript:go_report(4);\">④ 교육생(입교자)현황</a> <br><br>";
	if( rowMap.getString("guide5").equals("Y") )
		rowStr += "<a title='교육생(입교자)명단' href=\"javascript:go_report(5);\">⑤ 교육생(입교자)명단</a> <br><br>";
	if( rowMap.getString("guide6").equals("Y") )
		rowStr += "<a title='교육훈련평가' href=\"javascript:go_report(6);\">⑥ 교육훈련평가</a> <br><br>";
	if( rowMap.getString("guide7").equals("Y") )
		rowStr += "<a title='분임별 지도교수 및 교육생 현황' href=\"javascript:go_report(7);\">⑦ 분임별 지도교수 및 교육생 현황</a> <br><br>";
	if( rowMap.getString("guide8").equals("Y") )
		rowStr += "<a title='교육생 학생수칙규정(감점기준표)' href=\"javascript:go_report(8);\">⑧ 교육생 학생수칙규정(감점기준표)</a> <br><br>";
	if( rowMap.getString("guide9").equals("Y") )
		rowStr += "<a title='악보이미지' href=\"javascript:go_report(9);\">⑨ 악보이미지</a>";
	*/

	if( rowMap.getString("guide2").equals("Y") )
		rowStr += "<a title='교과목 편성시간 및 강사' href=\"javascript:go_report(2);\">① 교과목 편성시간 및 강사</a> <br><br>";

	if( rowMap.getString("guide3").equals("Y") ){
		
		tmpStr += "<select name='weekNo' style='font:11px'>";
		for(int i = 1; i <= grseqMap.getInt("weekCnt") ; i++)
			tmpStr += "<option value='" + i + "'>" + i + "주차</option>";
		tmpStr += "</select>";

		rowStr += "<a title='교육시간표' href=\"javascript:go_report(3);\">② 교육시간표</a> " + tmpStr + "<br><br>";
	}

	if( rowMap.getString("guide4").equals("Y") )
		rowStr += "<a title='교육생(입교자)현황' href=\"javascript:go_report(4);\">③ 교육생(입교자)현황</a> <br><br>";

	if( rowMap.getString("guide5").equals("Y") )
		rowStr += "<a title='교육생(입교자)명단' href=\"javascript:go_report(5);\">④ 교육생(입교자)명단</a> <br><br>";

	String grcodenm = grseqMap.getString("grcodeniknm") + " " + StringReplace.subString(grseqMap.getString("grseq"), 4, 6) + "기";

%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--

//수정하기.
function go_report(report_no)	{
	
	params = 'init_mode=view';
	var grcode = "<%= requestMap.getString("grcode") %>";
	var grseq = "<%= requestMap.getString("grseq") %>";
	var subj = "<%= subj %>";

	
	var grcodenm = "<%= grcodenm %> ";
	switch(report_no) {

		case 1:
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_33.jsp?p_grcode="+grcode+"&p_grseq="+grseq);
			break;
		case 2:
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_34.jsp?p_grcode="+grcode+"&p_grseq="+grseq);
			break;
		case 3:
			var week_cnt  = $F("weekNo");
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_19.jsp?p_grcode1="+grcode+"&p_grseq1="+grseq+"&p_week1=" + week_cnt + "&p_type1=M&p_limit1=&p_tmtitle1="+grcodenm+"&p_clroom1=&p_tmcnt=1");
			break;
		case 4:
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_35.jsp?p_grcode="+grcode+"&p_grseq="+grseq);
			break;
		case 5:
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_36.jsp?p_grcode="+grcode+"&p_grseq="+grseq + "&p_dept=");
			break;
		case 6:
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_49.jsp?p_grcode="+grcode+"&p_grseq="+grseq);
			break;
		case 7:
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_37.jsp?p_grcode="+grcode+"&p_grseq="+grseq + "&p_subj=" + subj);
			break;
		case 8:
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_38.jsp");
			params = 'init_mode=view';
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_39.jsp");
			break;
		case 9:
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_40.jsp");
		break;


	}

}





//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 과정안내문 미리보기</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<!-- 타이틀영역 -->
			<div class="tit">
				<h2 class="h2"><img src="/images/bullet003.gif" /> 과정 안내문 리스트</h2>
			</div>
			<!--// 타이틀영역 -->


			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694">
					<td height="2" ></td>
				</tr>
				<tr height='28' bgcolor="#5071B4">
					<td width="100%" align='center' class="tableline21 white">
						<strong><%= grcodenm %></strong>
					</td>
				</tr>
				<tr height='130' bgcolor="#5071B4">
					<td align='left' class='tableline21' bgColor='#FFFFFF' style="padding-left:20px">
						<%= rowStr %>
					</td>
				</tr>
			</table>

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="javascript:window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>

</form>
<script language="JavaScript">
  document.write(tagAIGeneratorOcx);
</script>

</body>
