<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 이전기수 정보 복사
// date : 2008-07-22
// auth : Lym
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//과정 기수 정보.
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	//과목리스트
	String prevGrseq = (String)request.getAttribute("PREV_GRSEQ_STRING");

	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm") + " - " + StringReplace.subString(grseqRowMap.getString("grseq"), 0, 4) + "년 " + StringReplace.subString(grseqRowMap.getString("grseq"), 4, 6) + "기";

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//복사하기.
function go_copy(){

	var isSelect = false;
	var chkBox = pform.copyGubun;

	for( i=1; i <= 4 ; i++)
		if($("copyGubun"+i).checked == true)
			isSelect = true;

	if(!isSelect){
		alert("복사 항목을 하나이상 선택해 주세요");
		return;
	}else{

		if(confirm("정보를 복사하시겠습니까?")){
			$("mode").value = "copy_exec";
			$("qu").value = "grseq";

			pform.action = "/courseMgr/courseSeq.do";
			pform.submit();
		}

	}

}

function go_chkClick(gubun){

	if(gubun == "grseq"){
		if($("radio1").checked){
			$("started").disabled = false;
			$("enddate").disabled = false;
			$("copyGubun2").disabled = false;

			if($("copyGubun2").checked){
				$("copyGubun3").disabled = false;
				$("copyGubun4").disabled = false;
			}
		}else{
			$("started").disabled = true;
			$("enddate").disabled = true;
			$("copyGubun2").disabled = true;
			$("copyGubun3").disabled = true;
			$("copyGubun4").disabled = true;
		}
	}else if(gubun == "subj"){
		if($("radio2").checked){
			$("copyGubun3").disabled = false;
			$("copyGubun4").disabled = false;
		}else{
			$("copyGubun3").disabled = true;
			$("copyGubun4").disabled = true;
		}
	}else if(gubun == "eval"){

		if($("radio3").checked){
			$("newSexampropose").disabled = false;
			$("newEexampropose").disabled = false;
		}else{
			$("newSexampropose").disabled = true;
			$("newEexampropose").disabled = true;
		}

	}else if(gubun == "inq"){

		if($("radio4").checked){
			$("questionSdate").disabled = false;
			$("questionEdate").disabled = false;
		}else{
			$("questionSdate").disabled = true;
			$("questionEdate").disabled = true;
		}

	}


}
//페이지 로딩시.
onload = function(){

	var prevGrseq = "<%= prevGrseq %>";
	if(prevGrseq == ""){
		alert("이전 기수가 존재 하지 않습니다.");
		window.close();
	}
}

//-->
</script>


<body>

<form name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"					value="">

<input type="hidden" name="grcode"				value="<%= requestMap.getString("grcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("grseq") %>">

<input type="hidden" name="prevGrseq"			value="<%= prevGrseq %>">


<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>

			<!-- 타이틀영역 -->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">이전기수 정보 복사</font></td>
				</tr>
			</table>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td height="100%" style="background:#FFFFFF URL(/images/bg_pop.gif) repeat-x; padding:20px; line-height:18px" valign="top">
			
			<!--// 본문영역 -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>

			<!-- 타이틀영역 -->
			<div class="tit">
				<h2 class="h2"><img src="/images/bullet003.gif" /> <%= grseqNm %></h2>
			</div>
			<!--// 타이틀영역 -->	

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
				<tr height='30' bgcolor="#5071B4">
					<td width="25%" align='center' class="tableline11 white"><strong>참조할<br>이전기수</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<%= StringReplace.subString(prevGrseq, 0, 4) + "년 " + StringReplace.subString(prevGrseq, 4, 6) + "기" %>
					</td>
				</tr>

				<tr height='50' bgColor='#5071B4'>
					<td align='center' class="tableline11 white"><strong>복사 항목</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>
						<input type="checkbox" class="chk_01" name="copyGubun1" id="radio1" value="grseq" onClick="go_chkClick(this.value);"><label for="radio1">과정기수내용 복사</label>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;교육일정
						<input type="text" class="textfield" name="started" style="width:60" readonly disabled>
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'started');" style="cursor:hand;"> ~ 
						<input type="text" class="textfield" name="enddate" style="width:60" readonly disabled>
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'enddate');" style="cursor:hand;">
						<br>
						<input type="checkbox" class="chk_01" name="copyGubun2" id="radio2" value="subj" onClick="go_chkClick(this.value);" disabled><label for="radio2">과목정보복사</label>
						<br>
						<input type="checkbox" class="chk_01" name="copyGubun3" id="radio3" value="eval" onClick="go_chkClick(this.value);" disabled><label for="radio3">평가복사</label>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;평가일정
						<input type="text" class="textfield" name="newSexampropose" style="width:60" readonly disabled>
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'newSexampropose');" style="cursor:hand;"> ~ 
						<input type="text" class="textfield" name="newEexampropose" style="width:60" readonly disabled>
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'newEexampropose');" style="cursor:hand;">
						<br>
						<input type="checkbox" class="chk_01" name="copyGubun4" id="radio4" value="inq" onClick="go_chkClick(this.value);" disabled><label for="radio4">설문복사</label>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;설문일정
						<input type="text" class="textfield" name="questionSdate" style="width:60" readonly disabled>
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'questionSdate');" style="cursor:hand;"> ~ 
						<input type="text" class="textfield" name="questionEdate" style="width:60" readonly disabled>
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'questionEdate');" style="cursor:hand;">
					</td>
				</tr>


				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
			</table>

			<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
			
			<!--// 본문영역 -->

		</td>
	</tr>
	<tr>
		<td height="30" align="center" nowrap>
			<input type="button" class="boardbtn1" value='복사' onClick="go_copy();">
			<input type="button" class="boardbtn1" value='닫기' onClick="javascript:self.close();">
		</td>
	</tr>
</table>

</form>

</body>