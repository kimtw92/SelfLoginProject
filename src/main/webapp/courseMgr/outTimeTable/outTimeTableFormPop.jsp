<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 외부 강사 시간표 등록 및 수정.
// date : 2008-09-11
// auth : 이용문
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       


    //시간표 등록 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true); 


	//교시 정보 및 사용가능 정보
	DataMap gosiMap = (DataMap)request.getAttribute("GOSI_LIST_DATA");
	gosiMap.setNullToInitialize(true);

	//강의실 정보
	DataMap classMap = (DataMap)request.getAttribute("CLASS_ROW_DATA");
	classMap.setNullToInitialize(true);


	String tmpStr = "";
	String tmpName = "";
	String tmpScriptStr = "";
	String gosiStr = "";
	
	for(int i=0; i < gosiMap.keySize("gosinum"); i++){

		tmpStr = "";
		
		if( gosiMap.getString("checkYn", i).equals("Y") )
			tmpStr = " checked ";
		
		if( gosiMap.getString("useYn", i).equals("Y") )
			tmpStr += " disabled ";
		
		tmpScriptStr = "onMouseOver=\"go_showHelp("+(i+1)+", true, "+gosiMap.keySize("gosinum")+")\"";
		tmpName = "<span "+tmpScriptStr+" >"+gosiMap.getString("gosinum", i)+"</span>";
		tmpName += "<div id=\"d_gosi"+(i+1)+"\" onMouseOut=\"go_showHelp("+(i+1)+", false)\" class='textHelp'>"+gosiMap.getString("term", i)+"</div>";

		gosiStr += "<input type='checkbox' class='chk_01' name='studytime' value=\"" + gosiMap.getString("gosinum", i) + "\" " + tmpScriptStr+ tmpStr + " >"+tmpName+"&nbsp;&nbsp;&nbsp;&nbsp;";

	}

%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<style type="text/css">
<!--
DIV.textHelp {
visibility: hidden; position: absolute;
width: 120; height: 20;
border: black 1px solid; 
background-color: white;
color: #FC0; font: bold 11pt
}
-->
</style>
<script language="JavaScript">
<!--


//등록
function go_add(){

	if(!go_commonCheckedCheck(pform.studytime)){
		alert("등록할 교시를 선택해주세요.");
		return;
	}

	if( $F("contents") == "" ){
		alert("내용을 입력해주세요.");
		return;
	}

	if( confirm("등록 하시겠습니까?") ){

		$("mode").value = "exec";
		$("qu").value = "insert";

		pform.action = "/courseMgr/outTimeTable.do";
		pform.submit();

	}

}

//수정
function go_modify(){

	if(!go_commonCheckedCheck(pform.studytime)){
		alert("등록할 교시를 선택해주세요.");
		return;
	}

	if( $F("contents") == "" ){
		alert("내용을 입력해주세요.");
		return;
	}

	if( confirm("수정 하시겠습니까?") ){

		$("mode").value = "exec";
		$("qu").value = "update";

		pform.action = "/courseMgr/outTimeTable.do";
		pform.submit();

	}

}

//삭제
function go_delete(){


	if( confirm("삭제 하시겠습니까?") ){

		$("mode").value = "exec";
		$("qu").value = "delete";

		pform.action = "/courseMgr/outTimeTable.do";
		pform.submit();

	}

}

//풍선 도움말 
function go_showHelp(objNo, show, tCount) {

	var divName = "d_gosi";
	var obj = $(divName + objNo);

	if (show) {

		for(i=1;i <= tCount;i++) //초기화
			$(divName + i).style.visibility = 'hidden';

		obj.style.pixelLeft = event.x; //이벤트가 발생된 가로축
		obj.style.pixelTop = event.y; //이벤트가 발생된 세로축
		obj.style.visibility = 'visible'; //객체를 보여줍니다.
	} else 
		obj.style.visibility = 'hidden'; //false인 경우 객체를 보이지 않게 합니다.
}

//-->
</script>

<body>

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" name="searchDate"			value="<%=requestMap.getString("searchDate")%>">

<input type="hidden" name="classNo"				value='<%=requestMap.getString("classNo")%>'>
<input type="hidden" name="studydate"			value='<%=requestMap.getString("studydate")%>'>
<input type="hidden" name="seq"					value='<%=requestMap.getString("seq")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 외부강사 시간표</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">
			<!-- date -->
			<table  class="dataw01">
				<tr>
					<th width="20%">강의실</th>
					<td><%= classMap.getString("classroomName") %></td>
				</tr>
				<tr>
					<th width="20%">교시</th>
					<td><%= gosiStr %></td>
				</tr>

				<tr>
					<th width="20%">내용</th>
					<td><textarea name="contents" class="textarea" cols="60" rows="3"><%= rowMap.getString("contents") %></textarea></td>
				</tr>

			</table>
			<!-- //date -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
					<%if(requestMap.getString("qu").equals("insert")){%>
						<input type="button" class="boardbtn1" value='등록' onClick="go_add();">
					<%}else if(requestMap.getString("qu").equals("update")){%>
						<input type="button" class="boardbtn1" value='수정' onClick="go_modify();" >
						<input type="button" class="boardbtn1" value='삭제' onClick="go_delete();" >
					<%}%>
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
