<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정기수관리 개설과정추가.
// date : 2008-05-21
// auth : LYM
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

//신청제한대한 checked
private String getApplyLimit(String value, String chkValue){
	if( value == null || value.equals("") || value.length() == 0 )
		return "";

	if( value.indexOf(chkValue) > -1 )
		return "checked";
	else
		return "";
}
private String getApplyLimitAll(String value){
	if( value == null || value.equals("") || value.length() == 0 )
		return "";

	if( value.indexOf("1") > -1 && value.indexOf("2") > -1 && value.indexOf("3") > -1)
		return "checked";
	else
		return "";
}




%>
<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
 

 	//과정기수 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

	//과정 정보
	DataMap grcodeRowMap = (DataMap)request.getAttribute("GRCODE_ROW_DATA");
	grcodeRowMap.setNullToInitialize(true);

	//과정기수에 속한 회장,부회장 정보
	DataMap grStuMasListMap = (DataMap)request.getAttribute("STUMAS_LIST_DATA");
	grStuMasListMap.setNullToInitialize(true);


	//
	String tmpStr = "";

	//수강신청 종료일이 00 이면 하루 전날 23으로 셋팅.
	tmpStr = rowMap.getString("eapplyed");
	if(tmpStr.length()==10 && hourSubString(tmpStr).equals("00")) {
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
	if( !rowMap.getString("eapplyed2").equals("") && rowMap.getString("eapplyed2").length() == 4 )
		tmpStr = rowMap.getString("eapplyed2").substring(2,4);
	else
		tmpStr = "";
	if(tmpStr.equals("59")){
		tmpStr = "24";
	}else{
		tmpStr = hourSubString(rowMap.getString("eapplyed"));
	}
	
	
	for(int i=1; i <= 24; i++)
		eapplyedhStr += "<option value='" + Util.plusZero(i) + "' " + ( tmpStr.equals(Util.plusZero(i)) ? "selected" : "" )+ " >" + Util.plusZero(i) + "</option>";

	//학생장, 부학생장
	String grStuMasS = "";
	String grStuMasCodeS = "";
	String grStuMasM = "";
	String grStuMasCodeM = "";

	for(int i=0; i < grStuMasListMap.keySize("userno"); i++){

		if(grStuMasListMap.getString("masGubun", i).equals("S")){

			if(!grStuMasCodeS.equals("")){
				grStuMasS += ",";
				grStuMasCodeS += ",";
			}
			grStuMasS += grStuMasListMap.getString("name", i) + "[" + grStuMasListMap.getString("deptnm", i) + "/" + grStuMasListMap.getString("mjiknm", i);
			grStuMasCodeS += grStuMasListMap.getString("userno", i);

		}else if(grStuMasListMap.getString("masGubun", i).equals("M")){

			if(!grStuMasCodeM.equals("")){
				grStuMasM += ",";
				grStuMasCodeM += ",";
			}
			grStuMasM += grStuMasListMap.getString("name", i) + "[" + grStuMasListMap.getString("deptnm", i) + "/" + grStuMasListMap.getString("mjiknm", i);
			grStuMasCodeM += grStuMasListMap.getString("userno", i);

		}

	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//목록으로 
function go_list(){

	$("mode").value = "list";
	$("qu").value = "";

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();
}




//수정
function go_modify(){

	if(NChecker(document.pform)){

		var grcodeniknm = '<%=rowMap.getString("grcodeniknm")%>';
		if(grcodeniknm.indexOf("e-") != -1) {
			if( $F("eapplyst") > $F("eapplyed") ){
				alert("수강신청마감일이 수강신청시작이보다 빨라서 등록할수 없습니다.");
				return;
			} else if( $F("rpgrad") < 0 || $F("rpgrad") > 100 ){
				alert("수료기준점수를 숫자로 0~100점 사이로 입력해주세요.");
				return;
			}
		} else {
			if( $F("eapplyst") > $F("eapplyed") ){
				alert("수강신청마감일이 수강신청시작이보다 빨라서 등록할수 없습니다.");
				return;
			} else if( $F("eapplyed") > $F("endsent") ){
				alert("1차 기관 승인마감일이 수강신청종료이보다 빨라서 등록할수 없습니다.");
				return;
			}else if( $F("endsent") > $F("endaent") ){
				alert("최종 승인마감일이 1차기관승인마감일보다 빨라서 등록할수 없습니다.");
				return;
			}else if( $F("endaent") > $F("started") ){
				alert("과정수강 시작일이 최종승인마감일보다 빨라서 등록할수 없습니다.");
				return;
			}else if( $F("started") > $F("enddate") ){
				alert("과정수강 종료일이 과정수강시작일보다 빨라서 등록할수 없습니다.");
				return;
	
			}else if( $F("started") > $F("enddate") ){
				alert("과정수강 종료일이 과정수강시작일보다 빨라서 등록할수 없습니다.");
				return;
			} else if( $F("rpgrad") < 0 || $F("rpgrad") > 100 ){
				alert("수료기준점수를 숫자로 0~100점 사이로 입력해주세요.");
				return;
			}
		}

		if( confirm("수정하시겠습니까?") ){

			$("mode").value = "exec";
			$("qu").value = "update";

			pform.action = "/courseMgr/courseSeq.do";
			pform.submit();

		}
	}

}

//삭제.
function go_delete() {

	if( confirm("삭제하시겠습니까?") ){

		$("mode").value = "exec";
		$("qu").value = "delete";

		pform.action = "/courseMgr/courseSeq.do";
		pform.submit();

	}
}

//학생장, 부학생장 검색.
function go_findStuMasMember(title, masGubun, name)	{

	var grcode = $F("grcode");
	var grseq = $F("grseq");
	var mode = "search_stumas";
	var url = "/courseMgr/courseSeq.do?title=" + title + "&mode=" + mode + "&grcode=" + grcode + "&grseq=" + grseq + "&masGubun=" + masGubun + "&name=" + name;

	popWin(url, "pop_findmember", "500", "500", "1","");
}

//강사 찾기
function go_findTutor(codeField, nameField)	{

	var grcode = $F("grcode");
	var grseq = $F("grseq");
	var mode = "search_tutor";
	var url = "/courseMgr/courseSeq.do?mode=" + mode + "&grcode=" + grcode + "&grseq=" + grseq + "&codeField=" + codeField + "&nameField=" + nameField;

	popWin(url, "pop_findTutor", "500", "500", "1", "");
}


//학생장, 부학생장 검색후 결과 보여주는 함수.
function set_returnStuMas(masGubun, returnCode, returnName){
	
	if(masGubun == "M"){
		$("grStuMasCodeM").value = returnCode;
		$("grStuMasM").value = returnName;
	}else{
		$("grStuMasCodeS").value = returnCode;
		$("grStuMasS").value = returnName;
	}

}

//로딩시.
onload = function()	{

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="year"				value="<%=requestMap.getString("year")%>">
<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">

<input type="hidden" name="grcode"				value="<%=rowMap.getString("grcode")%>">
<input type="hidden" name="grseq"				value="<%=rowMap.getString("grseq")%>">

<!-- 삭제 된 항목 -->
<input type="hidden" name="mexampropose"	value="<%=rowMap.getString("mexampropose")%>">
<input type="hidden" name="lexampropose"	value="<%=rowMap.getString("lexampropose")%>"> 
<!--  input type="hidden" name="tdate"			value="<%=rowMap.getString("tdate")%>" --> 
<input type="hidden" name="grPoint"			value="<%=rowMap.getString("grPoint")%>">
<input type="hidden" name="fCyber"			value="<%=rowMap.getString("fCyber")%>">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>            
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->

			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과정기수관리 기수 정보 관리</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->


						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<!-- line --><table width="100%" height="2" cellspacing="0" cellpadding="0" bgcolor="#5378B9"><tr><td></td></tr></table>
									<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#D6DBE5">

										<tr bgcolor="#FFFFFF">
											<td width="100%" height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center" colspan="4"><strong><%=rowMap.getString("grcodeniknm")%></strong></td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td width="18%" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>과정분류</strong></td>
											<td class="tableline21" align="left" width="32%" >&nbsp;<%=grcodeRowMap.getString("mcodeName")%></td>
											<td width="18%" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center" ><strong>과정상세분류</strong></td>
											<td class="tableline21" align="left" width="32%" >&nbsp;<%=grcodeRowMap.getString("codeDesc")%></td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong><font color='#FF0000'>*</font>별칭</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="grcodeniknm" maxlength="50" value="<%=rowMap.getString("grcodeniknm")%>" style="width:35%" required="true!별칭을 입력해주세요.">
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>사용여부</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="radio" class="chk_01" name="useYn" id="label1" value="Y" <%=rowMap.getString("useYn").equals("Y") ? "checked" : ""%>><label for="label1">Yes</label>
												<input type="radio" class="chk_01" name="useYn" id="label2" value="N" <%=!rowMap.getString("useYn").equals("Y") ? "checked" : ""%>><label for="label2">No</label>
											</td>
<!-- 											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>사이버교육전용</strong></td>
											<td class="tableline21" align="left">&nbsp;
												<input type="radio" class="chk_01" name="fCyber" id="fCyber1" value="Y" <%//=rowMap.getString("fCyber").equals("Y") ? "checked" : ""%>><label for="fCyber1">Yes</label>
												<input type="radio" class="chk_01" name="fCyber" id="fCyber2" value="N" <%//=!rowMap.getString("fCyber").equals("Y") ? "checked" : ""%>><label for="fCyber2">No</label>
											</td> -->
										</tr>


										<tr bgcolor="#FFFFFF"height="28">
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong><font color='#FF0000'>*</font>수강신청일</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" readonly name="eapplyst" value="<%=StringReplace.subString(rowMap.getString("eapplyst"), 0, 8)%>" style="width:60" required="true!수강신청 시작일을 입력해주세요.">
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'eapplyst');" style="cursor:hand;">&nbsp;

												<select name='eapplysth'>
													<%=eapplysthStr%>
												</select>시 &nbsp; ~ &nbsp;


												<input type="text" class="textfield" readonly name="eapplyed" value="<%=StringReplace.subString(rowMap.getString("eapplyed"), 0, 8)%>" style="width:60">
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'eapplyed');" style="cursor:hand;" required="true!수강신청 종료일을 입력해주세요.">&nbsp;
												<select name='eapplyedh'>
													<%=eapplyedhStr%>
												</select>시
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td  class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong><font color='#FF0000'>*</font>1차 기관 승인마감일</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" readonly class="textfield" name="endsent" value="<%=rowMap.getString("endsent")%>" style="width:60">
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'endsent');" style="cursor:hand;" required="true!1차 기관 승인마감일을 입력해주세요.">
												&nbsp;&nbsp;
												<input type="checkbox" readonly class="chk_01" name="endsentUseYn" id="endsentUseYn" value="Y" <%=rowMap.getString("endsentUseYn").equals("Y") ? "checked" : ""%>><label for="endsentUseYn">사용유무</label>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td  class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong><font color='#FF0000'>*</font>최종승인마감일</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" readonly class="textfield" name="endaent" value="<%=rowMap.getString("endaent")%>" style="width:60" required="true!최종승인마감일을 입력해주세요.">
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'endaent');" style="cursor:hand;">
												&nbsp;&nbsp;
												<input type="hidden" name="endaentUseYn" id="endaentUseYn" value="Y">
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td  class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong><font color='#FF0000'>*</font>과정수강일</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" readonly class="textfield" name="started" value="<%=rowMap.getString("started")%>" style="width:60" required="true!과정수강 시작일을 입력해주세요.">
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'started');" style="cursor:hand;">

												&nbsp; ~ &nbsp;
												<input type="text" readonly class="textfield" name="enddate" value="<%=rowMap.getString("enddate")%>" style="width:60" required="true!과정수강 종료일을 입력해주세요.">
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'enddate');" style="cursor:hand;">
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td  class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>평가일정</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" readonly class="textfield" name="newSexampropose" value="<%=rowMap.getString("newSexampropose")%>" style="width:60">
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'newSexampropose');" style="cursor:hand;">
												&nbsp; ~ &nbsp;
												<input type="text" readonly class="textfield" name="newEexampropose" value="<%=rowMap.getString("newEexampropose")%>" style="width:60">
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'newEexampropose');" style="cursor:hand;">
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td  class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>설문일정</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" readonly class="textfield" name="questionSdate" value="<%=rowMap.getString("questionSdate")%>" style="width:60">
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'questionSdate');" style="cursor:hand;">
												&nbsp; ~ &nbsp;
												<input type="text" readonly class="textfield" name="questionEdate" value="<%=rowMap.getString("questionEdate")%>" style="width:60">
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'questionEdate');" style="cursor:hand;">
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>인사행정연계여부</strong></td>
											<td class="tableline21" align="left" >&nbsp;
												<input type="radio" class="chk_01" name="peoplesystemYn" id="peoplesystemYn1" value="Y" <%=rowMap.getString("peoplesystemYn").equals("Y") ? "checked" : ""%>><label for="peoplesystemYn1">Yes</label>
												<input type="radio" class="chk_01" name="peoplesystemYn" id="peoplesystemYn2" value="N" <%=!rowMap.getString("peoplesystemYn").equals("Y") ? "checked" : ""%>><label for="peoplesystemYn2">No</label>
											</td>
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong><font color='#FF0000'>*</font>정원</strong></td>
											<td class="tableline21" align="left">&nbsp;
												<input type="text" class="textfield" name="tseat" value="<%=rowMap.getString("tseat")%>" maxlength="5" style="width:60" required="true!정원을 입력해주세요." dataform="num!정원을 숫자로 입력해주세요."> 명
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td  class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong><font color='#FF0000'>*</font>수료기준점수</strong></td>
											<td class="tableline21" align="left" >&nbsp;
												<input type="text" class="textfield" name="rpgrad" value="<%=rowMap.getString("rpgrad")%>" style="width:60" required="true!수료기준점수를 입력해주세요." dataform="num!수료기준점수를 숫자로 입력해주세요." maxlength="3"> 점
											</td>
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>과정시간</strong></td>
											<td class="tableline21" align="left">&nbsp;
												<input type="text" class="textfield" name="tdate" value="<%=rowMap.getString("tdate")%>" maxlength="5" style="width:60" required="true!시간을 입력해주세요." dataform="num!시간을 숫자로 입력해주세요."> 시간
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td  class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>학생장</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="grStuMasM" value="<%=grStuMasM%>" style="width:80%" readonly>
												<INPUT TYPE="hidden" name='grStuMasCodeM'>
												<a href="javascript:go_findStuMasMember('학생장', 'M', 'grstumas_m');"><strong>[변경]</strong></a>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td  class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>부학생장</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="grStuMasS" value="<%=grStuMasS%>" style="width:80%" readonly>
												<input type="hidden" name='grStuMasCodeS'>
												<a href="javascript:go_findStuMasMember('부학생장', 'S', 'grstumas_s');"><strong>[변경]</strong></a>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>강의실 지정</strong></td>
											<td class="tableline21" align="left" >&nbsp;
												<input type="text" class="textfield" name="classroomName" value="<%=rowMap.getString("classroomName")%>" style="width:60%" readonly>
												<input type="hidden" name='classroomNo' value="<%=rowMap.getString("classroomNo")%>">
												<input type="button" class="boardbtn1" value='검색' onClick="com_findClassroom('classroomNo', 'classroomName', 'classRoom', 'true');">
											</td>
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>선발고사 승인옵션</strong></td>
											<td class="tableline21" align="left">&nbsp;
												<input type="radio" class="chk_01" name="startexamYn" id="startexamYn1" value="Y" <%=rowMap.getString("startexamYn").equals("Y") ? "checked" : ""%>><label for="startexamYn1">Yes</label>
												<input type="radio" class="chk_01" name="startexamYn" id="startexamYn2" value="N" <%=!rowMap.getString("startexamYn").equals("Y") ? "checked" : ""%>><label for="startexamYn2">No</label>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>강사 지정</strong></td>
											<td class="tableline21" align="left" >&nbsp;
												<input type="text" class="textfield" name="grseqman" value="<%=rowMap.getString("grseqman")%>" style="width:60%" readonly>
												<input type="hidden" name='grseqmanUserno' value="<%=rowMap.getString("grseqmanUserno")%>">
												<input type="button" class="boardbtn1" value='검색' onClick="go_findTutor('grseqmanUserno', 'grseqman');">
											</td>
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육생 자료가 없는 인원</strong></td>
											<td class="tableline21" align="left">&nbsp;
												<input type="text" class="textfield" name="studentNodata" value="<%=rowMap.getString("studentNodata")%>" style="width:60" dataform="num!교육생 자료가 없는 인원을 숫자로 입력해주세요." maxlength="3"> 명
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>신청제한 대상</strong></td>
											<td class="tableline21" align="left" colspan='3'>&nbsp;
												<input type="checkbox" readonly class="chk_01" name="applyLimitAll" id="applyLimitAll1" value="" onclick="go_applyLimitAllChk();" <%= getApplyLimitAll(rowMap.getString("applyLimit")) %>><label for="applyLimitAll1">전체</label> &nbsp;
												<input type="checkbox" readonly class="chk_01" name="applyLimit" id="applyLimit1" value="1" onclick="go_applyLimitChk();" <%= getApplyLimit(rowMap.getString("applyLimit"), "1") %>><label for="applyLimit1">일반직</label> &nbsp;
												<input type="checkbox" readonly class="chk_01" name="applyLimit" id="applyLimit2" value="2" onclick="go_applyLimitChk();" <%= getApplyLimit(rowMap.getString("applyLimit"), "2") %>><label for="applyLimit2">공사공단</label> &nbsp;
												<input type="checkbox" readonly class="chk_01" name="applyLimit" id="applyLimit3" value="3" onclick="go_applyLimitChk();" <%= getApplyLimit(rowMap.getString("applyLimit"), "3") %>><label for="applyLimit3">소방직</label>

											</td>
										</tr>

									</table>
									<!-- line --><table width="100%" height="2" cellspacing="0" cellpadding="0" bgcolor="#5378B9"><tr><td></td></tr></table>
								</td>
							</tr>
						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="center">
									<input type="button" class="boardbtn1" value=' 수정 ' onClick="go_modify();" >
									<input type="button" class="boardbtn1" value=' 삭제 ' onClick="go_delete();">
									<input type="button" class="boardbtn1" value='취소' onClick="javascript:pform.reset();">
									<input type="button" class="boardbtn1" value='목록' onClick="go_list();">
								</td>
							</tr>
						</table>

						<!---[e] content -->
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->

			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
<SCRIPT LANGUAGE="JavaScript">
<!--
//신청제한대상 모두 체크
function go_applyLimitAllChk(){    
  
	var obj = document.getElementsByName("applyLimit");
	if ($("applyLimitAll").checked == true){
		for(i=0; i < obj.length; i++){
			obj[i].checked = true;
		}
	}else{
		for(i=0; i < obj.length; i++){
			obj[i].checked = false;
		}
	}
}

function go_applyLimitChk(){

	var obj = document.getElementsByName("applyLimit");
	var sum = 0;
	for(i=0; i<obj.length; i++)
		if (obj[i].checked==true)
		  sum = sum + 1;

	if (sum == 3)
		$("applyLimitAll").checked = true;
	else
		$("applyLimitAll").checked = false;

}
//-->
</SCRIPT>
</body>

