<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 설문 관리 - 통합결과 관리.
// date : 2008-09-26
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

	//간단한 과정 기수 정보
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

    //설문(공통) 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

    //설문 과목 리스트
	DataMap subjListMap = (DataMap)request.getAttribute("SUBJ_LIST_DATA");
	subjListMap.setNullToInitialize(true); 

	//list
	StringBuffer listStr = new StringBuffer();
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("questionNo"); i++){

		listStr.append("\n<table class='datah01 bb0' style='width:690'>");

		listStr.append("\n	<colgroup>");
		listStr.append("\n		<col width='55' />");
		listStr.append("\n		<col width='350' />");
		listStr.append("\n		<col width='60' />");
		listStr.append("\n		<col width='55' />");
		listStr.append("\n		<col width='158' />");
		listStr.append("\n	</colgroup>");


		listStr.append("	<thead> \n");
		listStr.append("	<tr> \n");
		listStr.append("		<th>설문"+listMap.getInt("questionNo", i)+"</th> \n");
		listStr.append("		<th class=\"left\" colspan=\"2\">" + listMap.getString("question", i) + "</th> \n");
		listStr.append("		<th class=\"br0\" colspan=\"2\">객관식</th> \n");
		listStr.append("	</tr> \n");
		listStr.append("	<tr> \n");
		listStr.append("		<th class=\"bg01\">문항</th> \n");
		listStr.append("		<th class=\"bg01\">지문</th> \n");
		listStr.append("		<th class=\"bg01\">응답자수</th> \n");
		listStr.append("		<th class=\"br0 bg01\" colspan=\"2\">비율</th> \n");
		listStr.append("	</tr> \n");
		listStr.append("	</thead> \n");

		listStr.append("\n	<tbody>");


		//보기 1
		listStr.append("	<tr> \n");
		listStr.append("		<td style='height:30px'>1</td> \n");
		listStr.append("		<td class='left'>매우만족</td> \n");
		listStr.append("		<td>"+listMap.getInt("ans1", i)+"</td> \n");
		listStr.append("		<td>" + HandleNumber.getCommaZeroDeleteNumber(listMap.getString("ans1Rat", i)) + " %</td> \n");
		
		//그래프 START
		listStr.append("		<td class='br0' rowspan='5'> \n");
		listStr.append("			<ul class=\"graphset01\"> \n");
		listStr.append("				<li class=\"graph\"> \n");
		listStr.append("					<ul class=\"imgset\"> \n");
		listStr.append("						<li><img src=\"/images/bg_graph.gif\" width='20' height='" + HandleNumber.getCommaZeroDeleteNumber(listMap.getString("ans1Rat", i)) + "' /></li>\n");
		listStr.append("						<li><img src=\"/images/bg_graph.gif\" width='20' height='" + HandleNumber.getCommaZeroDeleteNumber(listMap.getString("ans2Rat", i)) + "' /></li>\n");
		listStr.append("						<li><img src=\"/images/bg_graph.gif\" width='20' height='" + HandleNumber.getCommaZeroDeleteNumber(listMap.getString("ans3Rat", i)) + "' /></li>\n");
		listStr.append("						<li><img src=\"/images/bg_graph.gif\" width='20' height='" + HandleNumber.getCommaZeroDeleteNumber(listMap.getString("ans4Rat", i)) + "' /></li>\n");
		listStr.append("						<li><img src=\"/images/bg_graph.gif\" width='20' height='" + HandleNumber.getCommaZeroDeleteNumber(listMap.getString("ans5Rat", i)) + "' /></li>\n");
		listStr.append("					</ul> \n");
		listStr.append("				</li> \n");
		listStr.append("				<li class=\"no\"> \n");
		listStr.append("					<ul class='txtset'> \n");
		listStr.append("						<li><img src=\"/images/no1.gif\" /></li>\n");
		listStr.append("						<li><img src=\"/images/no2.gif\" /></li>\n");
		listStr.append("						<li><img src=\"/images/no3.gif\" /></li>\n");
		listStr.append("						<li><img src=\"/images/no4.gif\" /></li>\n");
		listStr.append("						<li><img src=\"/images/no5.gif\" /></li>\n");
		listStr.append("					</ul> \n");
		listStr.append("				</li> \n");
		listStr.append("			</ul> \n");
		listStr.append("		</td> \n");
		//그래프 END

		listStr.append("	</tr> \n");


		//보기 2
		listStr.append("	<tr> \n");
		listStr.append("		<td style='height:30px'>2</td> \n");
		listStr.append("		<td class='left'>대체로만족</td> \n");
		listStr.append("		<td>"+listMap.getInt("ans2", i)+"</td> \n");
		listStr.append("		<td>" + HandleNumber.getCommaZeroDeleteNumber(listMap.getString("ans2Rat", i)) + " %</td> \n");
		listStr.append("	</tr> \n");

		//보기 3
		listStr.append("	<tr> \n");
		listStr.append("		<td style='height:30px'>3</td> \n");
		listStr.append("		<td class='left'>보통</td> \n");
		listStr.append("		<td>"+listMap.getInt("ans3", i)+"</td> \n");
		listStr.append("		<td>" + HandleNumber.getCommaZeroDeleteNumber(listMap.getString("ans3Rat", i)) + " %</td> \n");
		listStr.append("	</tr> \n");

		//보기 4
		listStr.append("	<tr> \n");
		listStr.append("		<td style='height:30px'>4</td> \n");
		listStr.append("		<td class='left'>불만족</td> \n");
		listStr.append("		<td>"+listMap.getInt("ans4", i)+"</td> \n");
		listStr.append("		<td>" + HandleNumber.getCommaZeroDeleteNumber(listMap.getString("ans4Rat", i)) + " %</td> \n");
		listStr.append("	</tr> \n");

		//보기 5
		listStr.append("	<tr> \n");
		listStr.append("		<td style='height:30px'>5</td> \n");
		listStr.append("		<td class='left'>매우 불만족</td> \n");
		listStr.append("		<td>"+listMap.getInt("ans5", i)+"</td> \n");
		listStr.append("		<td>" + HandleNumber.getCommaZeroDeleteNumber(listMap.getString("ans5Rat", i)) + " %</td> \n");
		listStr.append("	</tr> \n");

		listStr.append("\n</table>");
		listStr.append("\n<div class='space01'></div>");
	}

	//과목 - 강사별 설문.
	for(int i=0; i < subjListMap.keySize("questionNo"); i++){

		listStr.append("\n<h2 class='h2'>[" + subjListMap.getString("tuserName", i) + "-" + subjListMap.getString("subjnm", i) + "]</h2>");
		listStr.append("\n<div class='h5'></div>");
			

		listStr.append("\n<table class='datah01 bb0' style='width:690'>");

		//보기 리시트 START
		DataMap sampList = (DataMap)subjListMap.get("SAMP_LIST_DATA", i);
		if(sampList == null) sampList = new DataMap();
		sampList.setNullToInitialize(true); 


		listStr.append("\n	<colgroup>");
		listStr.append("\n		<col width='55' />");
		listStr.append("\n		<col width='350' />");
		listStr.append("\n		<col width='60' />");
		listStr.append("\n		<col width='55' />");
		listStr.append("\n		<col width='158' />");
		listStr.append("\n	</colgroup>");


		listStr.append("	<thead> \n");
		listStr.append("	<tr> \n");
		listStr.append("		<th>설문</th> \n");
		listStr.append("		<th class=\"left\" colspan=\"2\">" + subjListMap.getString("question", i) + "</th> \n");
		listStr.append("		<th class=\"br0\" colspan=\"2\">객관식</th> \n");
		listStr.append("	</tr> \n");
		listStr.append("	<tr> \n");
		listStr.append("		<th class=\"bg01\">문항</th> \n");
		listStr.append("		<th class=\"bg01\">지문</th> \n");
		listStr.append("		<th class=\"bg01\">응답자수</th> \n");
		listStr.append("		<th class=\"br0 bg01\" colspan=\"2\">비율</th> \n");
		listStr.append("	</tr> \n");
		listStr.append("	</thead> \n");

		listStr.append("\n	<tbody>");


		for(int k=0; k < sampList.keySize("questionNo"); k++){


			listStr.append("	<tr> \n");
			listStr.append("		<td style='height:30px'>"+(k+1)+"</td> \n");
			listStr.append("		<td>" + sampList.getString("answer", k) + "</td> \n");
			listStr.append("		<td>" + subjListMap.getInt("ans"+(k+1), i) + "</td> \n");
			listStr.append("		<td>" + HandleNumber.getCommaZeroDeleteNumber(subjListMap.getString("ans"+(k+1)+ "Rat", i)) + " %</td> \n");



			if( sampList.keySize("questionNo") > 0 && k == 0){
				listStr.append("		<td class='br0' rowspan='"+sampList.keySize("questionNo")+"'> \n");
				listStr.append("			<ul class=\"graphset01\"> \n");
				listStr.append("				<li class=\"graph\"> \n");
				listStr.append("					<ul class=\"imgset\"> \n");
				int tAnswerCnt = 0;

				for(int kk=0; kk < sampList.keySize("questionNo"); kk++){
					
					String ttt = HandleNumber.getCommaZeroDeleteNumber(subjListMap.getString("ans"+(kk+1)+ "Rat", i));
					listStr.append("						<li><img src=\"/images/bg_graph.gif\" width=\"20\" height=\""+ttt+"\" /></li>\n");
				}


				listStr.append("					</ul> \n");
				listStr.append("				</li> \n");
				listStr.append("				<li class=\"no\"> \n");
				listStr.append("					<ul class='txtset'> \n");

				for(int kk=0; kk < sampList.keySize("questionNo"); kk++)
					listStr.append("						<li><img src=\"/images/no"+(kk+1)+".gif\" /></li>\n");

				listStr.append("					</ul> \n");
				listStr.append("				</li> \n");
				listStr.append("			</ul> \n");
				listStr.append("		</td> \n");

			}

			listStr.append("	</tr> \n");

		}

		//보기 리스트 END

		listStr.append("\n</tbody>");

		listStr.append("\n</table>");
		listStr.append("\n<div class='space01'></div>");


	}//END FOR

%>



						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--

//주관식 답변 보기
function go_answerTxtView(titleNo, setNo, questionNo){

	var mode = "poll_result_answer";
	var menuId = $F("menuId");
	var url = "/poll/coursePoll.do?mode=" + mode + "&menuId=" + menuId + "&titleNo=" + titleNo + "&setNo=" + setNo + "&questionNo=" + questionNo;

	popWin(url, "pop_answerTxtView", "500", "500", "1", "");
}



onload = function()	{

}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" name="titleNo"				value='<%=requestMap.getString("titleNo")%>'>
<input type="hidden" name="setNo"				value='<%=requestMap.getString("setNo")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> <%= grseqRowMap.getString("grcodeniknm") %> 통합 결과</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<%= listStr.toString() %>


			<!-- 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="window.close();" class="boardbtn1">
						<input type="button" value="프린트" onclick="print();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 닫기 버튼  -->
			<div class="h10"></div>


		</td>
	</tr>
</table>

</form>

</body>