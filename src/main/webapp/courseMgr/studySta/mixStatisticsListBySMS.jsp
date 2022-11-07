<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사이버학습현황 SMS 발송
// date : 2008-08-21
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

    //발송자 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	String textAreaStr = "{name}님 {grname}과정에 진도율이 미달된 과목이 있습니다.분발 바랍니다.";
	String tmpStr = "";
	String tmpDisableStr = "";
	
	//list
	String listStr = "";
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
		//담당기관
		listStr += "\n	<td>" + listMap.getString("deptnm", i) + "</td>";
		//직급
		listStr += "\n	<td class='br0'>" + listMap.getString("jiknm", i) + "</td>";

		listStr += "\n</tr>";
		
		tmpDisableStr = "";
	}


%>

						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--

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

	if(confirm("발송 하시겠습니까?")){

		$("mode").value = "sms_exec";

		pform.action = "/courseMgr/studySta.do";
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

<input type="hidden" name="qu"					value='mix_sms'>

<input type="hidden" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" name="grseq"				value='<%=requestMap.getString("grseq")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> SMS 발송 - 선택발송</h1>
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
				<textarea class="textarea_sms" name="txtMessage" onKeyUp="javascript:checkShrtMsgLen(this)"  onFocus="javascript:checkShrtMsgLen(this)"><%=textAreaStr%></textarea>
				<div class="txt"><input type="text" style="width:75px;height:16px;font-size:10px;ime-mode:disabled;" onkeydown="NumberCheck();" maxlength="11" id="sms_callback" name="sms_callback" value="0324407684" /><span class="txt_red" id="sp1"></span> / 80 Byte</div>
			</div>
			<!-- //sms  -->
			<div class="h5"></div>

			<!-- 상단 닫기 버튼  -->
			<table class="btn01">
				<tr>
					<td class="left vb"></td>
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
					<th>핸드폰 번호</th>
					<th>담당기관</th>
					<th class="br0">직급</th>
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
