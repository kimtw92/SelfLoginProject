<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 년도별 과정 내용 복사.
// date : 2008-06-19
// auth : Lym
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//복사할 기수 리스트
	DataMap copyGrseqList = (DataMap)request.getAttribute("GRSEQ_LIST_DATA");
	copyGrseqList.setNullToInitialize(true);

	//과정 기수 정보.
	DataMap grseqMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqMap.setNullToInitialize(true);

	//과목리스트
	DataMap subjList = (DataMap)request.getAttribute("SUBJ_LIST_DATA");
	subjList.setNullToInitialize(true);

	//복사할 기수의 과목
	DataMap copySubjList = (DataMap)request.getAttribute("COPYSUBJ_LIST_DATA");
	copySubjList.setNullToInitialize(true);


	String selGrseqStr = ""; //기수 String
	String subjListStr = ""; //기수 과목 String
	String copySubjListStr = ""; //복사할 기수 과목 String
	
	//String tmpStr = "";

	for(int i=0; i < copyGrseqList.keySize("grseq"); i++){

		selGrseqStr += "<option value=\"" + copyGrseqList.getString("grseq", i) + "\">" + copyGrseqList.getString("grseq", i) + "</option>";

	}

	//사용중인 과목리스트
	for(int i=0; i < subjList.keySize("subj"); i++){
		subjListStr += "&nbsp;" + subjList.getString("lecnm", i) + "<br>";

	}


	//참조할 과목리스트
	for(int i=0; i < copySubjList.keySize("subj"); i++){
		if(copySubjList.getString("subjMode", i).equals("1")){
			copySubjListStr += "&nbsp;<strong>V</strong>&nbsp;&nbsp;";
		}else{
			copySubjListStr += "<input type='checkbox' name='subj' value='" + copySubjList.getString("subj", i) + "'>";
		}
		copySubjListStr += "&nbsp;" + copySubjList.getString("lecnm", i) + "<br>";

	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//이전 기수select Box 선택시.
function go_reload(){

	$("mode").value = "copy_subj";

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();

}

//복사하기.
function go_copy(){


	var chkBox = pform.subj;

	if(chkBox.length == undefined || chkBox.length == 1){
		if(chkBox.checked){
			isSelect = true;
		}
	}else{
		for( i=0; i < chkBox.length ; i++){
		
			if(chkBox[i].checked == true){
				isSelect = true;
			}
		}
	}


	if(!isSelect){
		alert("과목을 하나이상 선택해 주세요");
		return;
	}else{

		$("mode").value = "subj_exec";
		$("qu").value = "insert_copy";

		pform.action = "/courseMgr/courseSeq.do";
		pform.submit();

		//opener.location.href = "/courseMgr/courseSeq.do";
		//self.close();
	}

}






//페이지 로딩시.
onload = function(){

	var copyGrseqCnt = "<%= copyGrseqList.keySize("grseq") %>";
	if(copyGrseqCnt <= 0){
		alert("복사할 기수가 없습니다.");
		self.close();
	}

	//참조할 기수 selected
	var copyGrseq = "<%= requestMap.getString("copyGrseq") %>";
	$("copyGrseq").value = copyGrseq;
}
//-->
</script>

<body leftmargin="0" topmargin=0>

<form name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="qu"					value="">

<input type="hidden" name="grcode"				value="<%=requestMap.getString("grcode")%>">
<input type="hidden" name="grseq"				value="<%=requestMap.getString("grseq")%>">


<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>

			<!-- 타이틀영역 -->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">년도별 과정내용복사</font></td>
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
				<tr height='30' bgcolor="#5071B4">
					<td width="25%" align='center' class="tableline11 white"><strong>참조할<br>이전기수</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<select name="copyGrseq" onChange="go_reload(this.value);">
							<%= selGrseqStr %>
						</select>
					</td>
				</tr>

				<tr height='50' bgColor='#5071B4'>
					<td align='center' class="tableline11 white"><strong>참조할<br>과목리스트</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>
						<%= copySubjListStr %>&nbsp;
					</td>
				</tr>

				<tr height='50' bgColor='#5071B4'>
					<td align='center' class="tableline11 white"><strong>사용중인<br>과목리스트</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>
						<%= subjListStr %>
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
