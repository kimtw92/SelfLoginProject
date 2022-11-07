<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정기수관리 회원 검색, 학생장, 부학생장 조회 팝업.
// date : 2008-06-13
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       


    //request 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	String listStr = "";
	String tmpStr = "";
	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr += "<tr bgColor='#FFFFFF' height='28'>";

		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("userno", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("name", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("deptsub", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("mjiknm", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("eduno", i) + "&nbsp;</td>";


		if(requestMap.getString("masGubun").equals("M")){ //학생장 검색이라면

			if(listMap.getString("stumas", i).equals("M")){
				tmpStr = " <a href=\"javascript:go_stuMasExec('"+listMap.getString("userno", i)+"', 'delete');\">삭제</a> ";
			}else if(listMap.getString("stumas", i).equals("S")){
				tmpStr = "부학생장 ";
			}else{
				tmpStr = " <a href=\"javascript:go_stuMasExec('"+listMap.getString("userno", i)+"', 'insert');\">추가</a> ";
			}

		}else{ //부학생장 검색이라면.

			if(listMap.getString("stumas", i).equals("M")){
				tmpStr = "학생장 ";
			}else if(listMap.getString("stumas", i).equals("S")){
				tmpStr = " <a href=\"javascript:go_stuMasExec('"+listMap.getString("userno", i)+"', 'delete');\">삭제</a> ";
			}else{
				tmpStr = " <a href=\"javascript:go_stuMasExec('"+listMap.getString("userno", i)+"', 'insert');\">추가</a> ";
			}

		}
		listStr += "	<td align='center' class='tableline11' >" + tmpStr + "</td>";

		listStr += "</tr>";

	}

	if( listMap.keySize("userno") <= 0){

		listStr += "<tr bgColor='#FFFFFF'>";
		listStr += "	<td align='center' class='tableline11' colspan='100%' height='100'>수강신청된 회원이 없습니다.</td>";
		listStr += "</tr>";

	}


%>

						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--

//추가, 삭제 실행.
function go_stuMasExec(userno, qu)	{

	$("userno").value = userno;

	$("mode").value = "stumas_exec";
	$("qu").value = qu;

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();

}

function go_search()	{

	$("mode").value = "search_stumas";

	if(!IsValidCharSearch($F("searchName"))){
		return;
	}

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();

}
//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">


<input type="hidden" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" name="grseq"				value='<%=requestMap.getString("grseq")%>'>
<input type="hidden" name="masGubun"			value='<%=requestMap.getString("masGubun")%>'>
<input type="hidden" name="title"				value='<%=requestMap.getString("title")%>'>


<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>
<input type="hidden" name="userno"				value=''>

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!-- 타이틀영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px"><%=requestMap.getString("title")%></font></td>
				</tr>
			</table>
			<!-- /타이틀영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" valign="top">
			<!-- 본문영역-->


			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height="28" bgcolor="F7F7F7" >
					<td width="25%"align="left" class="tableline11" bgcolor="#FFFFFF">&nbsp;</td>
					<td width="80" align="center" class="tableline11"><strong>이름</strong></td>
					<td width="*" align="left" class="tableline21" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<input type="text" class="textfield" name="searchName" value="<%=requestMap.getString("searchName")%>" style="width:60">
						<input type="button" class="boardbtn1" value='검색' onClick="go_search();" >
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
					<td width="20%" align='center' class="tableline11 white"><strong>유저코드</strong></td>
					<td width="10%" align='center' class="tableline11 white"><strong>이름</strong></td>
					<td width="23%" align='center' class="tableline11 white"><strong>소속</strong></td>
					<td width="23%" align='center' class="tableline11 white"><strong>직급</strong></td>
					<td width="10%" align='center' class="tableline11 white"><strong>교번</strong></td>
					<td width="12%" align='center' class="tableline11 white"><strong>기능</strong></td>
				</tr>

				<%= listStr %>

			</table>


			<!-- /본문영역-->
		</td>
	</tr>
	<tr>
		<td height="50" align="center" nowrap><!-- 닫기 --><a href="javascript:window.close();"><img src="/images/btn_popclose.gif" width="54" height="28" border="0"></a></td>
	</tr>
</table>

</form>
</body>
