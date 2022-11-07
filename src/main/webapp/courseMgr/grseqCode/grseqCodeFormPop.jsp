<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 기수코드 관리 등록 / 수정 폼.
// date : 2008-06-23
// auth : Lym
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%!
//뒷자리 두자리를 시간형태로 변경해주는 메소드.
private String hourSubString(String str){
	
	
	if(str == null || str.equals("")){
		return "00";
	}

	String returnValue = "00";
	try{

		returnValue = str.substring( str.length()-2 );

	}catch(Exception e){
		returnValue = "00";
	}

	return returnValue;
}
%>

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//과목 정보 Row
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);


	String tmpStr = "";

	//수강신청 종료일이 00 이면 하루 전날 23으로 셋팅.
	tmpStr = rowMap.getString("eapplyed");
	if(hourSubString(tmpStr).equals("00")) {
		rowMap.setString("eapplyed", rowMap.getString("preeapplyed"));
	}


	//수강신청일시작
	String eapplysthStr = ""; 
	tmpStr = rowMap.getString("eapplyst");
	tmpStr = hourSubString(tmpStr);

	for(int i=0; i < 24; i++)
		eapplysthStr += "<option value='" + Util.plusZero(i) + "' " + (tmpStr.equals(Util.plusZero(i)) ? "selected" : "")+ " >" + Util.plusZero(i) + "</option>";
	

	//수강신청일끝
	String eapplyedhStr = ""; 
	tmpStr = rowMap.getString("eapplyed");
	tmpStr = hourSubString(tmpStr);
	for(int i=1; i <= 24; i++)
		eapplyedhStr += "<option value='" + Util.plusZero(i) + "' " + ( tmpStr.equals(Util.plusZero(i)) ? "selected" : "" )+ " >" + Util.plusZero(i) + "</option>";

	//타이틀 및 버튼 이름.
	String modeName = "";
	if(requestMap.getString("qu").equals("insert"))
		modeName = "등록";
	else
		modeName = "수정";
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//등록
function go_add(){

	if(NChecker(document.pform)){

		if( confirm("등록 하시겠습니까?") ){

			$("mode").value = "exec";
			$("qu").value = "insert";

			pform.action = "/courseMgr/grseqCode.do";
			pform.submit();

		}
	}

}

//수정
function go_modify(){

	if(NChecker(document.pform)){

		if( confirm("수정하시겠습니까?") ){

			$("mode").value = "exec";
			$("qu").value = "update";

			pform.action = "/courseMgr/grseqCode.do";
			pform.submit();

		}
	}

}


//페이지 로딩시.
onload = function(){


}

//-->
</script>

<body leftmargin="0" topmargin="0">

<form name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">

<input type="hidden" name="year"				value="<%=requestMap.getString("year")%>">
<input type="hidden" name="seq"					value="<%=requestMap.getString("seq")%>">

<!-- 삭제 된 항목 -->
<input type="hidden" name="grPoint"				value="<%=rowMap.getString("grPoint")%>">

<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>

			<!-- 타이틀영역 -->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">기수코드 <%= modeName %>하기</font></td>
				</tr>
			</table>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td valign="top" style="background:#FFFFFF URL(/images/bg_pop.gif) repeat-x; padding:20px; line-height:18px" >
			
			<!--// 본문영역 -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
				<tr height='28' bgcolor="#5071B4">
					<td width="30%" align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>년도</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<%= requestMap.getString("year") %>
					</td>
				</tr>

				<tr height='28' bgcolor="#5071B4">
					<td width="25%" align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>기수</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<%= requestMap.getString("seq") %>
					</td>
				</tr>


				<tr height='28' bgColor='#5071B4'>
					<td align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>수강신청시작일</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<input type="text" class="textfield" readonly name="eapplyst" value="<%=StringReplace.subString(rowMap.getString("eapplyst"), 0, 8)%>" style="width:60" required="true!수강신청 시작일을 입력해주세요.">
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'eapplyst');" style="cursor:hand;">&nbsp;

						<select name='eapplysth'>
							<%=eapplysthStr%>
						</select>시
					</td>
				</tr>

				<tr height='28' bgColor='#5071B4'>
					<td align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>수강신청종료일 </strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<input type="text" readonly class="textfield" name="eapplyed" value="<%=StringReplace.subString(rowMap.getString("eapplyed"), 0, 8)%>" style="width:60">
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'eapplyed');" style="cursor:hand;" required="true!수강신청 종료일을 입력해주세요.">&nbsp;
						<select name='eapplyedh'>
							<%=eapplyedhStr%>
						</select>시
					</td>
				</tr>

				<tr height='28' bgColor='#5071B4'>
					<td align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>1차기관 승인마감일 </strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<input type="text" readonly class="textfield" name="endsent" value="<%=rowMap.getString("endsent")%>" style="width:60">
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'endsent');" style="cursor:hand;" required="true!1차 기관 승인마감일을 입력해주세요.">
					</td>
				</tr>

				<tr height='28' bgColor='#5071B4'>
					<td align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>최종승인마감일</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<input type="text" readonly class="textfield" name="endaent" value="<%=rowMap.getString("endaent")%>" style="width:60" required="true!최종승인마감일을 입력해주세요.">
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'endaent');" style="cursor:hand;">
					</td>
				</tr>

				<tr height='28' bgColor='#5071B4'>
					<td align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>교육시작일</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<input type="text" readonly class="textfield" name="started" value="<%=rowMap.getString("started")%>" style="width:60" required="true!과정수강 시작일을 입력해주세요.">
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'started');" style="cursor:hand;">
					</td>
				</tr>
				<tr height='28' bgColor='#5071B4'>
					<td align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>교육종료일</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<input type="text" readonly class="textfield" name="enddate" value="<%=rowMap.getString("enddate")%>" style="width:60" required="true!과정수강 종료일을 입력해주세요.">
						&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'enddate');" style="cursor:hand;">
					</td>
				</tr>
				<tr height='28' bgColor='#5071B4'>
					<td align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>총학습기간</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<input type="text" class="textfield" name="tdate" maxlength="5" value="<%=rowMap.getString("tdate")%>" style="width:60" dataform="num!총학습기간을 숫자로 입력해주세요."> 일
					</td>
				</tr>
				<tr height='28' bgColor='#5071B4'>
					<td align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>정원</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<input type="text" class="textfield" name="person" value="<%=rowMap.getString("person")%>" style="width:60" required="true!정원을 입력해주세요." dataform="num!정원을 숫자로 입력해주세요." maxlength="3"> 명
					</td>
				</tr>
				<tr height='28' bgColor='#5071B4'>
					<td align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>수료기준점수</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<input type="text" class="textfield" name="rpgrad" maxlength="5" value="<%=rowMap.getString("rpgrad")%>" style="width:60" required="true!수료기준점수를 입력해주세요." dataform="num!수료기준점수를 숫자로 입력해주세요." > 점
					</td>
				</tr>
				<tr height='28' bgColor='#5071B4'>
					<td align='center' class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>이수시간</strong></td>
					<td class='tableline11' bgColor='#FFFFFF'>&nbsp;
						<input type="text" class="textfield" name="completeTime" maxlength="5" value="<%=rowMap.getString("completeTime")%>" style="width:60" dataform="num!이수시간을 숫자로 입력해주세요.">시간
					</td>
				</tr>

				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
			</table>
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr height='28' >
					<td align="center">
					<%	if(requestMap.getString("qu").equals("insert")){%>
						<input type="button" class="boardbtn1" value='등록' onClick="go_add();">
					<%	}else if(requestMap.getString("qu").equals("update")){ %>
						<input type="button" class="boardbtn1" value='수정' onClick="go_modify();">
					<%	} %>
						<input type="button" class="boardbtn1" value='닫기' onClick="javascript:self.close();">
					</td>
				</tr>
			</table>

			<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
			
			<!--// 본문영역 -->

		</td>
	</tr>
	<tr>
		<td height="20" align="center" nowrap>

		</td>
	</tr>
</table>


</form>

</body>
