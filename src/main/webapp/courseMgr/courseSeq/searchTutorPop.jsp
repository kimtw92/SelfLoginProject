<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 강사 검색 팝업
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
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	//int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");

	String listStr = "";
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr += "<tr bgColor='#FFFFFF' height='18'>";

		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("name", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("resno", i) + "&nbsp;</td>";

		tmpStr = "<input type=\"radio\" name=\"seqman\" value=\"" + listMap.getString("userno", i) + "||" + listMap.getString("name", i) + "\">";
		listStr += "	<td align='center' class='tableline21' >" + tmpStr + "&nbsp;</td>";

	}

	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr += "<tr bgColor='#FFFFFF'>";
		listStr += "	<td align='center' class='tableline21' colspan='100%' height='80'>등록된 강사가 없습니다.</td>";
		listStr += "</tr>";

	}

	//페이징 String
	String pageStr = "";
	if(listMap.keySize("userno") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//페이지 이동
function go_page(page) {
	$("currPage").value = page;

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();
}

function go_list() {

	if(IsValidCharSearch($("searchName").value) == false){
		return false;
	}
	
	$("currPage").value = 1;
	
	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();
}




//강사 클릭시.
function go_submit() {

	var codeField = "<%=requestMap.getString("codeField")%>";
	var nameField = "<%=requestMap.getString("nameField")%>";

	
	var isSelect = false;
	var radioUser = pform.seqman;


	if(radioUser.length == undefined || radioUser.length == 1){
		if(radioUser.checked){
			isSelect = true;
			var value = radioUser.value.split("||");
		}
	}else{
		for( i=0; i < radioUser.length ; i++){
		
			if(radioUser[i].checked == true){
				isSelect = true;
				var value = radioUser[i].value.split("||");
			}
		}

	}


	if(!isSelect){
		alert("강사를 선택해 주세요");
		return;
	}else{
		opener.$(codeField).value = value[0];
		opener.$(nameField).value = value[1];
		self.close();
	}

}



//-->
</script>

<body leftmargin="0" topmargin=0>

<form name="pform" method="post">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>

<input type="hidden" name="codeField"			value='<%=requestMap.getString("codeField")%>'>
<input type="hidden" name="nameField"			value='<%=requestMap.getString("nameField")%>'>

<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>

			<!-- 타이틀영역 -->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">강사 검색</font></td>
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
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height="28" bgcolor="F7F7F7" >
					<td width="25%"align="left" class="tableline11" bgcolor="#FFFFFF">&nbsp;</td>
					<td width="80" align="center" class="tableline11"><strong>이름</strong></td>
					<td width="*" align="left" class="tableline21" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<input type="text" class="textfield" onkeypress="if(event.keyCode==13){go_list();return false;}" name="searchName" value="<%=requestMap.getString("searchName")%>" style="width:60">
						<input type="button" class="boardbtn1" value='검색' onClick="go_list();" >
					</td>
					<td width="15%"align="left" class="tableline11" bgcolor="#FFFFFF">&nbsp;</td>
				</tr>
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
			</table>
			<!-- space --><table width="100%" height="5"><tr><td></td></tr></table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
				<tr height='28' bgcolor="#5071B4">
					<td width="40%" align='center' class="tableline11 white"><strong>강사장명</strong></td>
					<td width="40%" align='center' class="tableline11 white"><strong>주민번호</strong></td>
					<td width="20%" align='center' class="tableline11 white"><strong>선택</strong></td>
				</tr>

				<%= listStr %>

			</table>

			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#ffffff">
					<td align='center'>
						<%=pageStr%>
					</td>
				</tr>
			</table>

			<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
			
			<!--// 본문영역 -->

		</td>
	</tr>
	<tr>
		<td height="30" align="center" nowrap>
			<input type="button" class="boardbtn1" value='등록' onClick="go_submit();">
			<input type="button" class="boardbtn1" value='닫기' onClick="javascript:self.close();">
		</td>
	</tr>
</table>


</form>

</body>
