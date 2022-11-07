<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 강의실 검색 팝업
// date : 2008-06-16
// auth : Lym
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//강의실 리스트.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	String listStr = "";
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("classroomNo"); i++){

		listStr += "<tr bgColor='#FFFFFF' height='18'>";

		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("classroomNo", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("classroomFloor", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("classroomMember", i) + "&nbsp;</td>";

		tmpStr = "<a href=\"javascript:go_click('"+ listMap.getString("classroomNo", i) + "', '"+ listMap.getString("classroomName", i) +"');\">" + listMap.getString("classroomName", i) + "</a>";
		listStr += "	<td align='center' class='tableline21' >" + tmpStr + "&nbsp;</td>";
		listStr += "</tr>";
	}

	//row가 없으면.
	if( listMap.keySize("classroomNo") <= 0){

		listStr += "<tr bgColor='#FFFFFF'>";
		listStr += "	<td align='center' class='tableline11' colspan='100%' height='80'>등록된 강의실이 없습니다.</td>";
		listStr += "</tr>";

	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//강의실 클릭시.
function go_click(roomCode, roomName) {

	var codeField = "<%=requestMap.getString("codeField")%>";
	var nameField = "<%=requestMap.getString("nameField")%>";
	var isClose = "<%=requestMap.getString("isclose")%>";

	var openerCode = opener.$(codeField);
	openerCode.value = roomCode;

	if(nameField != ""){
		opener.$(nameField).value = roomName;
	}
	
	if(isClose == "true"){
		window.close();
	}

}

//-->
</script>

<body leftmargin="0" topmargin=0>

<form name="pform">

<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>

			<!-- 타이틀영역 -->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">강의실 검색(시간표)</font></td>
				</tr>
			</table>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td height="100%" style="background:#FFFFFF URL(/images/bg_pop.gif) repeat-x; padding:20px; line-height:18px" valign="top">
			
			<!--// 본문영역 -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
				<tr height='28' bgcolor="#5071B4">
					<td width="15%" align='center' class="tableline11 white"><strong>코드명</strong></td>
					<td width="10%" align='center' class="tableline11 white"><strong>위치</strong></td>
					<td width="15%" align='center' class="tableline11 white"><strong>반인원</strong></td>
					<td width="*" align='center' class="tableline11 white"><strong>강의실명칭</strong></td>
				</tr>

				<%= listStr %>

			</table>

			<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
			
			<!--// 본문영역 -->

		</td>
	</tr>
	<tr>
		<td height="30" align="center" nowrap>
			<a href="#" onclick="window.close()"><!-- 닫기 --><img src="/images/btn_popclose.gif" width="54" height="28" border="0"></a>
		</td>
	</tr>
</table>


</form>

</body>
