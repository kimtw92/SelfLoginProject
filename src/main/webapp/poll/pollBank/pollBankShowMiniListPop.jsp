<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 관련질문 검색
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

	//설문 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	//list
	StringBuffer listStr = new StringBuffer();
	String sampStr = "";
	String tmpStr = "";
	String tmpStr2 = "";

	for(int i=0; i < listMap.keySize("questionNo"); i++){

		sampStr = ""; tmpStr2 = "";

		listStr.append("\n<tr>");

		//번호
		listStr.append("\n	<td>" + listMap.getString("questionNo", i) + "</td>");


		sampStr += "\n<tr id=\"div_" + listMap.getString("questionNo", i) + "\" style='display:none'>";
		sampStr += "\n	<td>&nbsp;</td>";
		sampStr += "\n	<td>";

		//설문내용
		if( listMap.getInt("answerKind", i) == 1 && listMap.getInt("isRef", i) == 0 ){ //객관식이고 다른 설문에서 참고하지 않고 있다면
			tmpStr = "<span class='txt_blue txt_bold'>(O)</span>";

			//보기 리스트 START
			DataMap sampList = (DataMap)listMap.get("BANK_SAMP_LIST", i);
			if(sampList == null) sampList = new DataMap();
			sampList.setNullToInitialize(true);

			sampStr += "<table width='100%' style=\"border-right:0px solid #FFFFFF;border-bottom:0px solid #FFFFFF;\"><tbody>";

			for(int k=0; k < sampList.keySize("answerNo"); k++){
				
				sampStr += "<tr><td class='br0 left' style=\"border-right:0px solid #FFFFFF;border-bottom:0px solid #FFFFFF;\">";
				tmpStr2 = "<input type='radio' onClick=\"go_chkAnswer(this,'"+listMap.getString("questionNo", i)+"', '"+sampList.getInt("answerNo", k)+"', '"+listMap.getString("question", i)+"', '" + sampList.getString("answer", k) + "');\" name='lym_"+listMap.getString("questionNo", i)+"' value='"+sampList.getInt("answerNo", k)+"'>";

				sampStr += tmpStr2 + sampList.getString("answer", k);
				sampStr += "</td></tr>";
				
			}
			sampStr += "</tbody></table>";
			//보기 리스트 END


		}else{

			tmpStr = "<span class='txt_red txt_bold'>(X)</span>";
			if( listMap.getInt("answerKind", i) != 1 )
				sampStr += "radio로만 구성 되어야 이전문제 선택이 가능 합니다.";
			else if(listMap.getInt("isRef", i) > 0)
				sampStr += "이미 다른 문제에서 참조 하였습니다.";
		}
		sampStr += "\n	</td>";
		sampStr += "\n</tr>";

		listStr.append("\n	<td class='br0 left'><a href=\"javascript:go_showAnswerList("+listMap.getString("questionNo", i)+");\" >" + tmpStr + listMap.getString("question", i) + "</td>");

		listStr.append("\n</tr>" + sampStr);

	}//END FOR

%>

						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--

// 함수설명 : 보기 래이어 한개만 보이게 하고 나머지는 닫기
function go_chkAnswer(obj, question_num, answer_no, question_text, samp_text){

	if ( confirm('이전문제로 선택 하시겠습니까?') ){

		with(opener.document.pform){

			questionCheckedNo.value = question_num;
			sampCheckedNo.value		= answer_no;
			tempQuestionNo.value	= question_num;
			tempSampNo.value		= answer_no;
			checkedQuestion.value	= question_text;
			checkedSamp.value		= samp_text;

		}

		opener.$("nowque").style.display = 'none';
		opener.$("prevque").style.display = '';
		opener.$("checkedNoDel").checked = false;

		window.close();

	} else {
		obj.checked = false;
	}

}

// 함수설명 : 보기 래이어 한개만 보이게 하고 나머지는 닫기
function go_showAnswerList(no){
	var frm = document.all;
	for( i = 0 ; i < frm.length; i ++){
		if ( frm[i].id.substr(0, 4) == "div_" )
			frm[i].style.display = 'none';
	}

	$("div_"+no).style.display = '';
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

<input type="hidden" name="questionNo"			value='<%=requestMap.getString("questionNo")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 관련 설문 검색</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<!--설문-->
			<table class="datah01">
				<thead>
				<tr>
					<th width="60">번호</th>
					<th class="br0">설문내용</th>
				</tr>
				</thead>

				<tbody>
				<%= listStr.toString() %>
				</tbody>
			</table>

			<!--//설문-->
			<div class="space01"></div>

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