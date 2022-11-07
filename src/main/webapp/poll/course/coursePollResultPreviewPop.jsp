<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 설문 관리 - 설문 분석 미리보기
// date : 2008-09-24
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

    //설문 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true); 

    //발송자 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	//list
	StringBuffer listStr = new StringBuffer();
	String tmpStr = "";
	for(int i=0; i < listMap.keySize("questionNo"); i++){


		listStr.append("\n<table class='datah01 bb0' style='width:690'>");

		//보기 리시트 START
		DataMap sampList = (DataMap)listMap.get("SAMP_LIST_DATA", i);
		if(sampList == null) sampList = new DataMap();
		sampList.setNullToInitialize(true); 

		int qtype = 0;
		for(int k=0; k < sampList.keySize("questionNo"); k++)
			qtype = sampList.getInt("answerKind", k);



		if(sampList.keySize("answerNo") > 0){


			if( qtype == 4){ //주관식일경우


				listStr.append("\n	<colgroup>");
				listStr.append("\n		<col width='55' />");
				listStr.append("\n		<col width='410' />");
				listStr.append("\n		<col width='213' />");
				listStr.append("\n	</colgroup>");

				listStr.append("\n	<thead>");
				listStr.append("\n	<tr>");
				listStr.append("\n		<th>설문"+(i+1)+"</th>");
				listStr.append("\n		<th class='left'>" + listMap.getString("question", i) + "</th>");
				listStr.append("\n		<th class='br0'>");
				listStr.append("\n			주관식");
				tmpStr = "<a href=\"javascript:go_answerTxtView("+listMap.getString("titleNo", i)+", "+listMap.getString("setNo", i)+", "+listMap.getString("questionNo", i)+");\" >";
				listStr.append("\n			"+tmpStr+"<img src=\"../images/btn_board_view.gif\" style=\"vertical-align:-5px;\" alt='보기' /></a>");
				listStr.append("\n		</th>");
				listStr.append("\n	</tr>");
				listStr.append("\n	<tr>");
				listStr.append("\n		<th class='bg01'>No</th>");
				listStr.append("\n		<th class='br0 bg01' colspan='2'>답변</th>");
				listStr.append("\n	</tr>");
				listStr.append("\n	</thead>");


				listStr.append("\n	<tbody>");

				//보기 결과 
				DataMap answerMap = (DataMap)listMap.get("SAMP_ANSWER_MAP_DATA", i);
				if(answerMap == null) answerMap = new DataMap();
				answerMap.setNullToInitialize(true); 

				for(int k=0; k < answerMap.keySize("questionNo"); k++){

					listStr.append("\n	<tr>");
					listStr.append("\n		<td>"+(k+1)+"</td>");
					listStr.append("\n		<td class='left' colspan='2'>"+answerMap.getString("answerTxt", k)+"</td>");
					listStr.append("\n	</tr>");
				}

				//주관식 반복
				listStr.append("\n	</tbody>");




			}else{ //그렇지 않을경우.

				listStr.append("\n	<colgroup>");
				listStr.append("\n		<col width='55' />");
				listStr.append("\n		<col width='350' />");
				listStr.append("\n		<col width='60' />");
				listStr.append("\n		<col width='55' />");
				listStr.append("\n		<col width='158' />");
				listStr.append("\n	</colgroup>");


				listStr.append("	<thead> \n");
				listStr.append("	<tr> \n");
				listStr.append("		<th>설문"+(i+1)+"</th> \n");
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


				//보기 결과 
				DataMap answerMap = (DataMap)listMap.get("SAMP_ANSWER_MAP_DATA", i);
				if(answerMap == null) answerMap = new DataMap();
				answerMap.setNullToInitialize(true); 

				int tAnswerCnt = answerMap.getInt("totalAnswerCnt");

				for(int k=0; k < sampList.keySize("questionNo"); k++){


					listStr.append("	<tr> \n");
					listStr.append("		<td style='height:30px'>"+sampList.getInt("answerNo", k)+"</td> \n");
					listStr.append("		<td>"+sampList.getString("answer", k)+"</td> \n");
					listStr.append("		<td>"+answerMap.getInt("answerCnt", k)+"</td> \n");
					listStr.append("		<td>" + HandleNumber.getCommaZeroDeleteNumber("" +  ( ((double)answerMap.getInt("answerCnt", k)) / tAnswerCnt) *100 ) + " %</td> \n");



					if( sampList.keySize("questionNo") > 0 && k == 0){
						listStr.append("		<td class='br0' rowspan='"+sampList.keySize("questionNo")+"'> \n");
						listStr.append("			<ul class=\"graphset01\"> \n");
						listStr.append("				<li class=\"graph\"> \n");
						listStr.append("					<ul class=\"imgset\"> \n");

						for(int kk=0; kk < sampList.keySize("questionNo"); kk++){
							
							if(tAnswerCnt == 0)
								tAnswerCnt = 1;
							String ttt = HandleNumber.getCommaZeroDeleteNumber(""+ ( ((double)answerMap.getInt("answerCnt", kk)) / tAnswerCnt) *100 );
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

				listStr.append("\n</tbody>");

			}

		}


		listStr.append("\n</table>");
		listStr.append("\n<div class='space01'></div>");


		//보기 리스트 END



		//관련 설문 START
		DataMap checkPoll = (DataMap)listMap.get("PREV_POLL_LIST_DATA", i);
		if(checkPoll == null) checkPoll = new DataMap();
		checkPoll.setNullToInitialize(true);
		
		if( checkPoll.keySize("questionNo") > 0 ){
			
			listStr.append("\n<table class='datah01 bb0' style='width:690'>");

			//이전 설문의 보기
			DataMap prevSamp = (DataMap)checkPoll.get("PREV_SAMP_LIST_DATA");
			if(prevSamp == null) prevSamp = new DataMap();
			prevSamp.setNullToInitialize(true);

			int qtypePrev = 0;
			for(int k=0; k < prevSamp.keySize("questionNo"); k++)
				qtypePrev = prevSamp.getInt("answerKind", k);

			if(prevSamp.keySize("answerNo") > 0){

				if( qtypePrev == 4){ //주관식일경우

					listStr.append("\n	<colgroup>");
					listStr.append("\n		<col width='55' />");
					listStr.append("\n		<col width='410' />");
					listStr.append("\n		<col width='213' />");
					listStr.append("\n	</colgroup>");

					listStr.append("\n	<thead>");
					listStr.append("\n	<tr>");
					listStr.append("\n		<th>설문"+(i+1)+"</th>");
					listStr.append("\n		<th class='left'>" + checkPoll.getString("question") + "-1</th>");
					listStr.append("\n		<th class='br0'>");
					listStr.append("\n			주관식");
					tmpStr = "<a href=\"javascript:go_answerTxtView("+checkPoll.getString("titleNo")+", "+checkPoll.getString("setNo")+", "+checkPoll.getString("questionNo")+");\" >";
					listStr.append("\n			"+tmpStr+"<img src=\"../images/btn_board_view.gif\" style=\"vertical-align:-5px;\" alt='보기' /></a>");
					listStr.append("\n		</th>");
					listStr.append("\n	</tr>");
					listStr.append("\n	<tr>");
					listStr.append("\n		<th class='bg01'>No</th>");
					listStr.append("\n		<th class='br0 bg01' colspan='2'>답변</th>");
					listStr.append("\n	</tr>");
					listStr.append("\n	</thead>");


					listStr.append("\n	<tbody>");

					//이전 설문의 보기 결과 
					DataMap answerMapPrev = (DataMap)checkPoll.get("PREV_SAMP_ANSWER_MAP_DATA");
					if(answerMapPrev == null) answerMapPrev = new DataMap();
					answerMapPrev.setNullToInitialize(true); 

					for(int k=0; k < answerMapPrev.keySize("questionNo"); k++){

						listStr.append("\n	<tr>");
						listStr.append("\n		<td>"+(k+1)+"</td>");
						listStr.append("\n		<td class='left' colspan='2'>"+answerMapPrev.getString("answerTxt", k)+"</td>");
						listStr.append("\n	</tr>");
					}

					//주관식 반복
					listStr.append("\n	</tbody>");


				}else{ //그렇지 않을경우. (주관식이 아닌경우)

					listStr.append("\n	<colgroup>");
					listStr.append("\n		<col width='55' />");
					listStr.append("\n		<col width='350' />");
					listStr.append("\n		<col width='60' />");
					listStr.append("\n		<col width='55' />");
					listStr.append("\n		<col width='158' />");
					listStr.append("\n	</colgroup>");

					listStr.append("	<thead> \n");
					listStr.append("	<tr> \n");
					listStr.append("		<th>설문"+(i+1)+"</th> \n");
					listStr.append("		<th class=\"left\" colspan=\"2\">" + checkPoll.getString("question") + "</th> \n");
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


					//이전 설문의 보기 결과 
					DataMap answerMapPrev = (DataMap)checkPoll.get("PREV_SAMP_ANSWER_MAP_DATA");
					if(answerMapPrev == null) answerMapPrev = new DataMap();
					answerMapPrev.setNullToInitialize(true);  

					int tAnswerCnt = answerMapPrev.getInt("totalAnswerCnt");

					for(int k=0; k < prevSamp.keySize("questionNo"); k++){


						listStr.append("	<tr> \n");
						listStr.append("		<td style='height:30px'>"+prevSamp.getInt("answerNo", k)+"</td> \n");
						listStr.append("		<td>"+prevSamp.getString("answer", k)+"</td> \n");
						listStr.append("		<td>"+answerMapPrev.getInt("answerCnt", k)+"</td> \n");
						listStr.append("		<td>" + HandleNumber.getCommaZeroDeleteNumber("" +  ( ((double)answerMapPrev.getInt("answerCnt", k)) / tAnswerCnt) *100 ) + " %</td> \n");



						if( prevSamp.keySize("questionNo") > 0 && k == 0){
							listStr.append("		<td class='br0' rowspan='"+prevSamp.keySize("questionNo")+"'> \n");
							listStr.append("			<ul class=\"graphset01\"> \n");
							listStr.append("				<li class=\"graph\"> \n");
							listStr.append("					<ul class=\"imgset\"> \n");

							for(int kk=0; kk < prevSamp.keySize("questionNo"); kk++){
								
								if(tAnswerCnt == 0)
									tAnswerCnt = 1;
								String ttt = HandleNumber.getCommaZeroDeleteNumber(""+ ( ((double)answerMapPrev.getInt("answerCnt", kk)) / tAnswerCnt) *100 );
								listStr.append("						<li><img src=\"/images/bg_graph.gif\" width=\"20\" height=\""+ttt+"\" /></li>\n");
							}


							listStr.append("					</ul> \n");
							listStr.append("				</li> \n");
							listStr.append("				<li class=\"no\"> \n");
							listStr.append("					<ul class='txtset'> \n");

							for(int kk=0; kk < prevSamp.keySize("questionNo"); kk++)
								listStr.append("						<li><img src=\"/images/no"+(kk+1)+".gif\" /></li>\n");

							listStr.append("					</ul> \n");
							listStr.append("				</li> \n");
							listStr.append("			</ul> \n");
							listStr.append("		</td> \n");

						}

						listStr.append("	</tr> \n");


					}

					listStr.append("\n</tbody>");

				} // end else if


			} // end prevSamp

			listStr.append("\n</table>");
			listStr.append("\n<div class='space01'></div>");

		} //if checkPoll

		//관련 질문 END
		


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
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> <%= rowMap.getString("title") %></h1>
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