<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : SMS 발송
// date : 2008-07-18
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

    //문자 보낼 사람
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 


	String tmpStr = "";

	//list
	String listStr = "";
	String titleStr = ""; //Title
	String textAreaStr = "";
	String smsPhone = "";

	if(requestMap.getString("qu").equals("updatePasswd")){
		titleStr = "임시비밀번호";
		textAreaStr = requestMap.getString("txtMessage") + " 임시패스워드입니다. [인천인재개발원]";
		smsPhone = requestMap.getString("smsPhone");
	}


	String tmpDisableStr = "";
	
	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr += "\n<tr>";

		//번호
		listStr += "\n	<td>" + (i+1) + "</td>";
		
		if( listMap.getString("hp", i).equals("") || listMap.getString("hp", i).equals("--") )
			tmpDisableStr = " disabled ";
		
		//checkBox
		tmpStr = "<input type='checkbox' class='chk_01' name='userno[]' value=\"" + listMap.getString("userno", i) + "\" " + tmpDisableStr + "> "+ listMap.getString("name", i);
		listStr += "\n	<td>" + tmpStr + "</td>";
		
		//HP
		listStr += "\n	<td>" + listMap.getString("hp", i) + "</td>";		

		listStr += "\n</tr>";
		// tmpDisableStr 초기화
		tmpDisableStr = "";
	}


%>

						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--



//전체 선택
function chkAllcheck() {
	var obj = document.getElementsByName("userno[]");
	if($("checkAll").checked) {
		for(i = 0; i < obj.length; i++)
			obj[i].checked = true; 
	}else {
		for(i = 0; i < obj.length; i++)
			obj[i].checked = false;
	}
}

function NumberCheck()
{
	if((event.keyCode<96)||(event.keyCode>105)) {
		if((event.keyCode<48)||(event.keyCode>57))
		{
			if(event.keyCode != 8){
				event.returnValue=false;
			}
		}
	}
}

// SMS 발송
function go_send() {

	// 체크한 갯수
	var total = 0;
	var obj = document.getElementsByName("userno[]");
	for(i = 0; i < obj.length; i++) {
		if(obj[i].checked) 
			total++; 
	}
	if(total <= 0){
		alert("선택이 되지 않았습니다.");
		return;
	}
	if($("sms_callback").value == "") {
		alert("보내는 사람을 입력하세요.");
		$("sms_callback").focus();
		return;
	}
	if(confirm("발송 하시겠습니까?")){
		$("mode").value = "sms_exec";
		pform.action = "/courseMgr/mail.do";
		pform.submit();
	}
}

onload = function()	{

	try{
		$("txtMessage").focus();
	}catch(e){}
}

//-->
</script>
<script language="javascript" src="/courseMgr/mail/sms.js"></script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>
<input type="hidden" name="txtMessage"			value='<%=requestMap.getString("txtMessage")%>'>
<input type="hidden" name="smsPhone"			value='<%=requestMap.getString("smsPhone")%>'>
<input type="hidden" name="userno"				value='<%=requestMap.getString("userno")%>'>
<input type="hidden" name="name"				value='<%=requestMap.getString("name")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> SMS 발송 - <%= titleStr %></h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">
			<!-- sms  -->
			<div class="smsset01">
				<div class="iconset">
					<img src="/images/sms_icon01.gif" class="icon1" />
					<img src="/images/sms_icon02.gif" />
				</div>
				<!-- onKeyUp="javascript:checkShrtMsgLen(this)"  onFocus="javascript:checkShrtMsgLen(this)" -->
				<textarea class="textarea_sms" name="txtMessage"  disabled="disabled"><%=textAreaStr%></textarea>
				<div class="txt"><input type="text" style="width:75px;height:16px;font-size:10px;ime-mode:disabled;" onkeydown="NumberCheck();" maxlength="11" id="sms_callback" name="sms_callback" value="0324407684" disabled="disabled"/>&nbsp;<span class="txt_red" id="sp1"></span> / 80 Byte</div>
			</div>
			<!-- //sms  -->
			<div class="h5"></div>

			<!-- 상단 닫기 버튼  -->
			<table class="btn01">
				<tr>
					<td class="left vb">* 수신거부자 제외</td>
					<td class="right" style="padding-right:10px;">
						<input type="button" value="SMS 발송" onclick="go_send();" class="boardbtn1">
						<input type="button" value="닫기" onclick="window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 상단 닫기 버튼  -->
			<div class="h10"></div>

			<!-- 리스트  -->
			<table class="datah01">
				<thead>
				<tr>
					<th width="60">번호</th>
					<th>
						<input type="checkbox" class="chk_01" name="checkAll" onClick="chkAllcheck();">
						이름
					</th>
					<th class="br0">핸드폰 번호</th>
				</tr>
				</thead>

				<tbody>
					<%= listStr %>
				</tbody>
			</table>
			<!-- //리스트  -->
		</td>
	</tr>
</table>

</form>

</body>
