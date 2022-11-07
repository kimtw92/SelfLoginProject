<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 인터넷 설문 미리보기
// date : 2008-09-23
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

		if( !listMap.getString("subjnm", i).equals("") ){
			
			listStr.append("\n<div class='space01'></div>");
			listStr.append("\n<div class='space01'></div>");
			listStr.append("\n<div class='poll_q'>");
			listStr.append("\n	<dl class='q_no'>");
			listStr.append("\n		<dd><font color='CC6600'>과목명 : " + listMap.getString("subjnm", i) + "</font></dd>");
			listStr.append("\n	</dl>");
			listStr.append("\n</div>");
		}

		listStr.append("\n<div class='poll_q'>");
		listStr.append("\n	<dl class='q_no'>");
		listStr.append("\n		<dt>질문"+(i+1)+"</dt>");
		listStr.append("\n		<dd>" + listMap.getString("question", i) + "</dd>");
		listStr.append("\n	</dl>");
		listStr.append("\n</div>");

		//보기 리스트 START
		DataMap sampList = (DataMap)listMap.get("SAMP_LIST_DATA", i);
		if(sampList == null) sampList = new DataMap();
		sampList.setNullToInitialize(true); 
		if(sampList.keySize("answerNo") > 0){

			listStr.append("\n<ul class='poll_a'>");

			for(int j=0; j < sampList.keySize("answerNo"); j++){
				
				listStr.append("\n<li>");
				
				if(sampList.getInt("answerKind", j) == 1){
					
					if(listMap.getInt("prevAnswerNo", i) > 0){
						if(listMap.getInt("prevAnswerNo", i) == sampList.getInt("answerNo", j))
							tmpStr = " onclick=\"showRelative_Question('"+i+"')\"";
						else
							tmpStr = " onclick=\"hideRelative_Question('"+i+"')\"";
					}else
						tmpStr = "";
					listStr.append("\n<input type='radio' name='poll_"+i+"' value=\""+sampList.getInt("answerNo", j)+"\" "+tmpStr+">" + sampList.getString("answer", j));

				}else if(sampList.getInt("answerKind", j) == 2){
					listStr.append("\n<input type='radio' name='poll_"+i+"' value=\""+sampList.getInt("answerNo", j)+"\">");
					listStr.append( sampList.getString("answer", j) );
					listStr.append("<input type='text' name=\"poll_"+i+"_text\" value=''>");
				}else if(sampList.getInt("answerKind", j) == 3){
					listStr.append("\n<input type='checkbox' name='poll_"+i+"' value=\""+sampList.getInt("answerNo", j)+"\">");
					listStr.append( sampList.getString("answer", j) );
				}else if(sampList.getInt("answerKind", j) == 4){
					listStr.append("<input type='text' name=\"poll_"+i+"_text\" value=''>");
				}
				
				listStr.append("\n</li>");

			}

			listStr.append("\n</ul>");
		}
		//보기 리시트 END

		//관련 설문 START
		DataMap checkPoll = (DataMap)listMap.get("PREV_POLL_LIST_DATA", i);
		if(checkPoll == null) checkPoll = new DataMap();
		checkPoll.setNullToInitialize(true);
		
		if( checkPoll.keySize("questionNo") > 0 ){
			
			listStr.append("\n<div id=\"poll_"+i+"_QLayer\" style='display:none'>");

			listStr.append("\n<div class='poll_q'>");
			listStr.append("\n	<dl class='q_no'>");
			listStr.append("\n		<dt>질문"+(i+1)+"-1</dt>");
			listStr.append("\n		<dd>" + checkPoll.getString("question") + "</dd>");
			listStr.append("\n	</dl>");
			listStr.append("\n</div>");
			
			DataMap prevSamp = (DataMap)checkPoll.get("PREV_SAMP_LIST_DATA");
			if(prevSamp == null) prevSamp = new DataMap();
			prevSamp.setNullToInitialize(true);
			
			if(prevSamp.keySize("questionNo") > 0 ){
				
				listStr.append("\n<ul class='poll_a'>");
				for(int j=0; j < prevSamp.keySize("questionNo"); j++){
					
					listStr.append("\n<li>");
					
					if(prevSamp.getInt("answerKind", j) == 1){
						
						listStr.append("\n<input type='radio' name='poll_"+i+"_1' value=\""+prevSamp.getInt("answerNo", j)+"\" >" + prevSamp.getString("answer", j));
					
					}else if(prevSamp.getInt("answerKind", j) == 2){
						
						listStr.append("\n<input type='radio' name='poll_"+i+"_1' value=\""+prevSamp.getInt("answerNo", j)+"\">");
						listStr.append( prevSamp.getString("answer", j) );
						listStr.append("<input type='text' name=\"poll_"+i+"_text_1\" value=''>");
						
					}else if(prevSamp.getInt("answerKind", j) == 3)
						listStr.append("\n<input type='checkbox' name='poll_"+i+"_1' value=\""+prevSamp.getInt("answerNo", j)+"\">" + prevSamp.getString("answer", j));
					else if(prevSamp.getInt("answerKind", j) == 4)
						listStr.append("<input type='text' name='poll_"+i+"_text_1' value=''>");
					
					listStr.append("\n</li>");
					
				}
				listStr.append("\n</ul>");
				
			}

			listStr.append("\n</div>");
		}

		//관련 질문 END
		
	}//END FOR


%>



						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--
//관련글 보이기
function showRelative_Question(num)	{

	var Qlayer_name = 'poll_'+num+'_QLayer';
	$(Qlayer_name).style.display='block';
}
//관련글 숨기기
function hideRelative_Question(num)	{

	var Qlayer_name = 'poll_'+num+'_QLayer';
	$(Qlayer_name).style.display='none';
}

function go_submit(){

	if( go_inputCheck() && confirm('등록 하시겠습니까?') ) {

		$("mode").value = "etc_exec";
		$("qu").value = "www_preview";

		pform.action = "/poll/coursePoll.do";
		pform.submit();
	}

	//document.forms['f'].submit();
}

function go_inputCheck(){
	//문제 갯수.
	//var qArray = new Array(<%//= listMap.keySize("questionNo") %>);
	var isBool = true;
<%
	String outStr = "";
	for(int i=0; i < listMap.keySize("questionNo"); i++){
		
		DataMap sampList = (DataMap)listMap.get("SAMP_LIST_DATA", i);
		if(sampList == null) sampList = new DataMap();
		sampList.setNullToInitialize(true); 
		
		if(sampList.keySize("answerNo") > 0){
			
			int qtype = sampList.getInt("answerKind");
			if(qtype == 1 || qtype == 2){ //radio
				if (requestMap.getString("titleNo") == "7827" && (i > 13 && i < 32)){
					out.print("");
				} else if(requestMap.getString("titleNo") == "7934" && (i > 7 && i < 14)) {
					out.print("");
				} else if(requestMap.getString("titleNo") == "7929" && (i > 75 && i < 82)) {
					out.print("");
				} else {
					out.print("isBool = go_checkQtype1('"+i+"');");
					out.print("if(isBool){ alert(\""+(i+1)+"\"+\"번째 답변을 입력해주세요.\" ); return false;}");
				}
			}else if(qtype == 3){ //checkBox
				out.print("isBool = go_checkQtype3('"+i+"', "+listMap.getInt("checkboxCheckedNo", i)+");");
				out.print("if(isBool){ alert('"+(i+1)+"'+'번째 답변의 최소 선택 갯수는 "+listMap.getInt("checkboxCheckedNo", i)+"개이상 선택하셔야 합니다' ); return false;}");
			}else if(qtype == 4){ //주관식
				out.print("isBool = go_checkQtype4('"+i+"');");
				out.print("if(isBool){ alert('"+(i+1)+"'+'번째 관련답변을 입력해 주십시요' ); return false;}");
			}
		}


		//관련 설문 START
		DataMap checkPoll = (DataMap)listMap.get("PREV_POLL_LIST_DATA", i);
		if(checkPoll == null) checkPoll = new DataMap();
		checkPoll.setNullToInitialize(true);
		
		if( checkPoll.keySize("questionNo") > 0 ){
			
			DataMap prevSamp = (DataMap)checkPoll.get("PREV_SAMP_LIST_DATA", i);
			if(prevSamp == null) prevSamp = new DataMap();
			prevSamp.setNullToInitialize(true);
			
			if(prevSamp.keySize("questionNo") > 0 ){
				
				int qtype = prevSamp.getInt("answerKind");
				if(qtype == 1 || qtype == 2){ //radio
					if (requestMap.getString("titleNo") == "7827" && (i > 13 && i < 32)){
					} else if(requestMap.getString("titleNo") == "7934" && (i > 7 && i < 14)){
					} else if(requestMap.getString("titleNo") == "7929" && (i > 75 && i < 82)) {
					} else {
						out.print("isBool = go_checkQtype1('"+i+"');");
						out.print("if(isBool){ alert(\""+(i+1)+"\"+\"번째 답변을 입력해주세요.\" ); return false;}");
					}
				}else if(qtype == 3){ //checkBox
					out.print("isBool = go_checkRelativeQtype3('"+i+"', "+listMap.getInt("checkboxCheckedNo", i)+");");
					out.print("if(isBool){ alert('"+(i+1)+"'+'번째 답변의 최소 선택 갯수는 "+listMap.getInt("checkboxCheckedNo", i)+"개이상 선택하셔야 합니다' ); return false;}");
				}else if(qtype == 4){ //주관식
					out.print("isBool = go_checkRelativeQtype4('"+i+"');");
					out.print("if(isBool){ alert('"+(i+1)+"'+'번째 관련답변을 입력해 주십시요' ); return false;}");
				}
				
			}

		}



	}
%>

	//if( qArray
	return true;
}

/******** 이상 없으면 False 값으로 반환 됨. **************/
function go_checkQtype1(no){
	return !go_commonCheckedCheck(eval("pform.poll_"+no));
}
function go_checkQtype3(no, limit){

	//checkBox 버튼 선택 되었는지 확인.
	var obj = eval("pform.poll_"+no);
	
	var isBool = false;
	var isCnt = 0;

	if(obj.length == undefined || obj.length == 1){
		if(obj.checked)
			isCnt++;
	}else{
		for( i=0; i < obj.length ; i++){
			if(obj[i].checked == true)
				isCnt++;
		}
	}

	if(isCnt < limit)
		return true;
	else
		return false;

}
function go_checkQtype4(no){ //주관식

	if($F("poll_"+no+"_text") == "")
		return true;
	else
		return false;
}
function go_checkRelativeQtype1(no){
	return !go_commonCheckedCheck(eval("pform.poll_"+no+"_1"));
}
function go_checkRelativeQtype3(no, limit){

	//checkBox 버튼 선택 되었는지 확인.
	var obj = eval("pform.poll_"+no+"_1");
	
	var isBool = false;
	var isCnt = 0;

	if(obj.length == undefined || obj.length == 1){
		if(obj.checked)
			isCnt++;
	}else{
		for( i=0; i < obj.length ; i++){
			if(obj[i].checked == true)
				isCnt++;
		}
	}

	if(isCnt < limit)
		return true;
	else
		return false;

}
function go_checkRelativeQtype4(no){ //주관식

	if($F("poll_"+no+"_text_1") == "")
		return true;
	else
		return false;
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

			<!--설문-->
			<div class="pollset">

				<%= listStr.toString() %>

			</div>
			<!--//설문-->
			<div class="space01"></div>

			<!-- 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="확인" onclick="go_submit();" class="boardbtn1">
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