<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 수강신청조회/승인 리스트
// date : 2008-06-25
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

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

	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//기관 리스트
	DataMap deptList = (DataMap)request.getAttribute("DEPT_LIST_DATA");
	deptList.setNullToInitialize(true);

	//과정기수 정보.
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	//이전기수 수료 리스트
	DataMap finishMemberList = (DataMap)request.getAttribute("FINISHMEMBER_LIST_DATA");
	finishMemberList.setNullToInitialize(true);

	//부서별 인원 정보.
	DataMap deptCntRow = (DataMap)request.getAttribute("DEPT_CNT_ROW_DATA");
	deptCntRow.setNullToInitialize(true);

	//부서별 인원 정보.
	DataMap deptCntList = (DataMap)request.getAttribute("DEPT_CNT_LIST_DATA");
	deptCntList.setNullToInitialize(true);

	int totalCnt = 0;
	int applyCnt1 = 0;
	int applyCnt2 = 0;

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	String tmpStr2 = "";

	String tmpDeptNm = "";
	for(int i=0; i < listMap.keySize("dept"); i++){
		
		totalCnt++; //신청인원 증가

		//기관명.
		if(listMap.getString("dept", i).equals("6280000"))
			tmpDeptNm = listMap.getString("deptnm", i);
		else
			tmpDeptNm = listMap.getString("deptnm", i).replaceAll("인천광역시", "");

		listStr.append("\n<tr bgColor='#FFFFFF' height='25'>");

		if( !tmpStr2.equals(listMap.getString("dept", i)) ){
			tmpStr = deptCntRow.getString(listMap.getString("dept", i));
			listStr.append("\n	<td align='left' class='tableline21' colspan='100%'>&nbsp;" + tmpDeptNm + "(" + tmpStr + "명)</td></tr><tr bgColor='#FFFFFF' height='25'>");
		}

		//번호
		listStr.append("\n	<td align='center' class='tableline11'>" + (i+1) + "</td>");
		//교번
		tmpStr = listMap.getString("eduno", i).equals("0") ? "&nbsp;" : listMap.getString("eduno", i);
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "</td>");
		
		tmpStr2 = "";
		
		//CheckBox
		boolean eduBool = false; //최종 승인 할수 있는 여부
		if( grseqRowMap.getString("endsentUseYn").equals("Y") ){  	//과정 기수의 1차 기관 사용유무가 Y이고
			if( !listMap.getString("deptchk", i).equals("N") ){		//1차 승인이 되어있지 않으면
				eduBool = true; //
				if( listMap.getString("deptchk", i).equals("Y")){
					if( listMap.getString("grchk", i).equals("N") ){
						tmpStr2 = "";
					} else {
						tmpStr2 = "checked";
					}
				}
			} 
		}
		
		
		/*
		for(int j=0; j < finishMemberList.keySize("userno"); j++){
			if( finishMemberList.getString("userno", j).equals(listMap.getString("userno", i)) ){
				if(!finishMemberList.getString("rgrayn", j).equals("Y"))
					tmpStr2 = "disabled";
			} //end if
		} //end for
		*/
		if( listMap.getString("grchk", i).equals("C")) { tmpStr2 = "  disabled "; }
		if( listMap.getString("grchk", i).equals("Y") ) tmpStr2 += "  checked ";
		
		tmpStr = "<input type='checkbox' name=\"chk"+(i+1)+"\"	value='" + listMap.getString("userno", i) + "' " + tmpStr2 + ">";
		tmpStr += "<input type='hidden'  name=\"edu"+(i+1)+"\"	value=\"" + listMap.getString("userno", i) + "\">";
		tmpStr += "<input type='hidden'  name=\"name"+(i+1)+"\" value=\"" + listMap.getString("name", i) + "\">";
		tmpStr += "<input type='hidden'  name=\"dept"+(i+1)+"\" value=\"" + listMap.getString("dept", i) + "\">";
		tmpStr += "<input type='hidden'  name=\"jik"+(i+1)+"\"	value=\"" + listMap.getString("jik", i) + "\">";
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "</td>");

		//이름
		tmpStr = "<a href=\"javascript:go_view('" + listMap.getString("userno", i) + "')\">" + listMap.getString("name", i) + "</a>";
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "</td>");


		//생년월일
		tmpStr = "";
		//listStr.append("\n	<td align='center' class='tableline11'>" + listMap.getString("resno", i) + "&nbsp;</td>");
		
		listStr.append("\n	<td align='center' class='tableline11'>" + listMap.getString("userId", i) + "&nbsp;</td>");
		
		listStr.append("\n	<td align='center' class='tableline11'>" + listMap.getString("birthdate", i) + "&nbsp;</td>");
		
		//1차 승인
		tmpStr = "";
		if( listMap.getString("deptchk", i).equals("Y") )
			applyCnt1++;

		if( listMap.getString("deptchk", i).equals("N"))
			tmpStr = "<font color=red>" + listMap.getString("deptchk", i) + "</font>";
		else
			tmpStr = listMap.getString("deptchk", i);
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "&nbsp;</td>");

		//최종승인
		tmpStr2 = "";
		tmpStr = "";
		if( listMap.getString("grchk", i).equals("Y") )
			applyCnt2++;

		if( listMap.getString("grchk", i).equals("Y"))
			tmpStr = "<font color=blue>" + listMap.getString("grchk", i) + "</font>";
		else if( listMap.getString("grchk", i).equals("N"))
			tmpStr = "<font color=red>" + listMap.getString("grchk", i) + "</font>";
			//tmpStr = "";	//최종승인이 'N'(승인취소)면 비어 있게 수정
		else
			tmpStr = listMap.getString("grchk", i);
		
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "&nbsp;</td>");

		//신청일자
		listStr.append("\n	<td align='center' class='tableline11'>" + listMap.getString("appdate", i) + "</td>");

		//기관
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpDeptNm + "</td>");

		//소속
		if(listMap.getString("deptsub", i).equals(""))
			tmpStr = listMap.getString("deptsub2", i);
		else
			tmpStr = listMap.getString("deptsub", i);
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "</td>");

		//직급
		listStr.append("\n	<td align='center' class='tableline11'>" + listMap.getString("jiknm", i) + "&nbsp;</td>");

		//이전기수 수료여부
		tmpStr = "";
		int tmpCnt = 0;
		
		for(int j=0; j < finishMemberList.keySize("userno"); j++){
			if( finishMemberList.getString("userno", j).equals(listMap.getString("userno", i)) ){
				if(tmpCnt > 0)
					tmpStr += "<br>";
				if(!finishMemberList.getString("rgrayn", j).equals("Y"))
					tmpStr += " <font color='red'>" + finishMemberList.getString("grcodeniknm", j) + "-[" + finishMemberList.getString("grseq", j) + "(" + finishMemberList.getString("rgrayn", j) + ")]<br></font> ";
				else
					tmpStr += " " + finishMemberList.getString("grcodeniknm", j) + "-[" + finishMemberList.getString("grseq", j) + "(" + finishMemberList.getString("rgrayn", j) + ")]<br>";

				tmpCnt++;
			} //end if
		} //end for
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "&nbsp;</td>");

		//전화
		listStr.append("\n	<td align='center' class='tableline11'>" + listMap.getString("hpno", i) + "&nbsp;</td>");

		//정보수정
		tmpStr = "<input type='button' value='수정' class='boardbtn1' onClick=\"javascript:go_modify('"+listMap.getString("userno", i)+"')\">";
		listStr.append("\n	<td align='center' class='tableline21'>" + tmpStr + "</td>");


		listStr.append("\n</tr>");

		tmpStr2 = listMap.getString("dept", i);

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("dept") <= 0){

		listStr.append("<tr bgColor='#FFFFFF'>");
		listStr.append("	<td align='center' class='tableline21' colspan='100%' height='100'>수강신청한 학생이 없습니다.</td>");
		listStr.append("</tr>");

	}


	//부서 리스트.
	String deptStr = "";
	for(int i=0; i < deptList.keySize("dept"); i++){

		tmpStr = ""; tmpStr2 = "";

		if( (i+1)%5 == 1) deptStr += "<tr>"; //5개td중 1번째마다.
			
		if( (i+1) == deptList.keySize("dept") && (deptList.keySize("dept")%5) != 0 )
			tmpStr = "colspan='" + (5-(deptList.keySize("dept")%5)+1) + "'";
		
		if(requestMap.getString("reload").equals("")) //첫로딩이 이면 (그렇지 않으면"GO"들어옴)
			tmpStr2 = "checked";
		else if( requestMap.getString("deptStr").indexOf(deptList.getString("dept", i)) >= 0 )
			tmpStr2 = "checked";

		deptStr += "<td width='20%' "+tmpStr+"><input type='checkbox' name='dept[]' value='" + deptList.getString("dept", i) + "' "+tmpStr2+">" + deptList.getString("replaceDeptnm", i) + "</td>";

		if( (i+1)%5 == 0) deptStr += "</tr>"; //5개td중 마지막 마다.

	}
	//마지막줄의 td가 5개 되지 않았다면 tr닫아줌.
	if( deptList.keySize("dept") > 0  && (deptList.keySize("dept")%5) != 0)
		deptStr += "</tr>";



	//버튼
	String buttonStr = "";
	if(grseqRowMap.getInt("eapplyst1") <= Integer.parseInt(DateUtil.getDateTime()) && grseqRowMap.getInt("endaent") >= Integer.parseInt(DateUtil.getDateTime())){
		buttonStr += "<input type=\"button\" class=\"boardbtn1\" name=\"confirm\" value=\"SMS\" onClick=\"javascript:go_sms()\">&nbsp;";
		
	}
	if(grseqRowMap.getInt("endaent") >= Integer.parseInt(DateUtil.getDateTime())){ //최종 승인일이 지나지 않았으면 승인 및 취소 할수 있음.
		buttonStr += "<input type=\"button\" class=\"boardbtn1\" name=\"confirm\" value=\"승인\" onClick=\"javascript:go_agree()\">&nbsp;";
		buttonStr += "<input type=\"button\" class=\"boardbtn1\" name=\"confirm\" value=\"승인취소\" onClick=\"javascript:go_cancel()\">&nbsp;";
		
	}


	

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
	go_list();
}
//검색
function go_search(){
	go_list();
}
//리스트
function go_list(){

	$("mode").value = "list";

	$("year").value = "";
	$("grcode").value = "";
	$("grseq").value = "";

	pform.action = "/courseMgr/lectureApply.do";
	pform.submit();

}

//수강생 이력 정보 조회
function go_view(userno){

	var mode = "hist_view";
	var menuId = $F("menuId");
	var url = "/courseMgr/lectureApply.do?mode=" + mode + "&menuId=" + menuId + "&userno=" + userno;

	popWin(url, "pop_studentHistView", "820", "300", "1", "");

}


//회원 정보 수정.
function go_modify(userno){

	var mode = "stu_form";
	var grcode = "<%= requestMap.getString("commGrcode") %>";
	var grseq = "<%= requestMap.getString("commGrseq") %>";
	var menuId = $F("menuId");
	var url = "/courseMgr/lectureApply.do?mode=" + mode + "&menuId=" + menuId + "&userno=" + userno + "&grcode=" + grcode + "&grseq=" + grseq;

	popWin(url, "pop_studentEditForm", "500", "280", "0", "");

}


//부서전체 선택 클릭시.
function chkAllDept() {

	var chkobj = document.getElementsByName("dept[]");

	for(i=0; i < chkobj.length; i++){
		chkobj[i].checked = $("all_mark").checked;
	}

}

//리스트 checkBox
function listSelectAll() {
	
	for (var i = 1; i <= <%= listMap.keySize("dept") %>; i++) {
		$("chk"+i).checked = $("checkAll").checked;
	}
}

//SMS 발송
function go_sms(){

	popWin("", "pop_sendSms", "800", "600", "1", "");

	
	$("year").value		= "<%= requestMap.getString("commYear") %>";
	$("grcode").value	= "<%= requestMap.getString("commGrcode") %>";
	$("grseq").value	= "<%= requestMap.getString("commGrseq") %>";

	$("mode").value = "sms_list";
	$("qu").value = "";

	pform.action = "/courseMgr/lectureApply.do";
	pform.target = "pop_sendSms";
	pform.submit();
	pform.target = "";

}

//교번 부여
function go_eduNo(year, grcode, grseq, grcodenm){


	if(grcode == "" || grseq == ""){
	   alert("과정과 기수를 선택하세요!");
	   return;
	}

	if(confirm(grcodenm+'['+grseq+'기수]의 교번을 부여하시겠습니까?\n교번을 부여하게 되면 이전에 부여되었던 교번은 삭제됩니다.') == true){

		var objAjax = new Object();
		objAjax.url = "/courseMgr/lectureApply.do";
		objAjax.pars = "mode=ajax_exec&qu=eduno"+"&year="+ year +"&grcode="+ grcode + "&grseq=" + grseq;
		objAjax.aSync = true; 
		objAjax.targetDiv = "";
		objAjax.successMsg = "처리되었습니다.";
		objAjax.successFunc = "go_reload();";

		//alert("1");
		go_ajaxCommonObj(objAjax); //Ajax 통신.

	}
}


//승인
function go_agree(){

	if(confirm('선택한 교육생을 승인 하시겠습니까?')) {

		$("year").value		= "<%= requestMap.getString("commYear") %>";
		$("grcode").value	= "<%= requestMap.getString("commGrcode") %>";
		$("grseq").value	= "<%= requestMap.getString("commGrseq") %>";

		$("mode").value = "exec";
		$("qu").value = "agree";

		pform.action = "/courseMgr/lectureApply.do";
		pform.submit();

	}
}


//승인취소
function go_cancel(){

	if(confirm('사이버교육 시작 후 승인취소를 하시면 학습이력이 삭제됩니다. \n\n 선택한 교육생을 보류처리하시겠습니까?')) {

		$("year").value		= "<%= requestMap.getString("commYear") %>";
		$("grcode").value	= "<%= requestMap.getString("commGrcode") %>";
		$("grseq").value	= "<%= requestMap.getString("commGrseq") %>";

		$("mode").value = "exec";
		$("qu").value = "cancel";

		pform.action = "/courseMgr/lectureApply.do";
		pform.submit();

	}
}


//로딩시.
onload = function()	{


	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = "grSeq"; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);



}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"					value="<%= requestMap.getString("qu") %>">

<input type="hidden" name="deptStr"				value="<%= requestMap.getString("deptStr") %>">
<input type="hidden" name="applyCnt"			value="<%= listMap.keySize("dept") %>">
<input type="hidden" name="reload"				value="GO">

<input type="hidden" name="year"				value="">
<input type="hidden" name="grcode"				value="">
<input type="hidden" name="grseq"				value="">


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
			<!-- space --><!-- <table width="100%" height="10"><tr><td></td></tr></table> -->
<!-- 			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과정기수관리 리스트</strong>
					</td>
				</tr>
			</table> -->
			<!--// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!--[s] 검색 -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td width="80" align="center" class="tableline11"><strong>년 도</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCommGrCode('subj');" style="width:100px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>					
								</td>
								<td width="80" align="center" class="tableline11"><strong>과 정</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommGrCode" class="commonDivLeft">
										<select name="commGrcode" style="width:250px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<td rowspan="2" bgcolor="#FFFFFF" width="100" align="center">
									<input type="button" value="검 색" onclick="go_search();" class="boardbtn1">
								</td>
							</tr>
							<tr height="28" bgcolor="F7F7F7">
								<td align="center" class="tableline11"><strong>기 수</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" style="width:100px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<td align="center" class="tableline11"><strong>부서전체선택</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<input type='checkbox' name='all_mark' onClick="chkAllDept();" checked >전체선택
								</td>
							</tr>														
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->
						
						<div class="space01"></div>

						<!-- subTitle -->
						<div class="tit01" style="padding-left:0;">
							<span class="mr10"><strong>수강신청일:</strong> (<%= DateUtil.convertDate1(grseqRowMap.getString("eapplyst1"))%> ~ <%= DateUtil.convertDate1(grseqRowMap.getString("eapplyed1"))%>) </span>
							<span class="mr10"><strong>1차승인마감일:</strong> <%= DateUtil.convertDate1(grseqRowMap.getString("endsent"))%> </span>
							<span class="mr10"><strong>최종승인마감일:</strong> <%= DateUtil.convertDate1(grseqRowMap.getString("endaent"))%> </span>
						</div><br><br>
						<div class="tit01" style="padding-left:0;">
							<span class="mr10"><strong>정원:</strong> <%= Util.getValue(grseqRowMap.getString("tseat"), "0") %>명 </span>
							<span class="mr10"><strong>신청인원:</strong> <%= totalCnt %>명 </span>
							<span class="mr10"><strong>1차승인인원:</strong> <%= applyCnt1 %>명 </span>
							<span class="mr10"><strong>2차승인인원:</strong> <%= applyCnt2 %>명 </span>
						</div>
						<!-- // subTitle -->						
						<div class="h5"></div>



						<!-- 부서목록 -->
						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<%= deptStr %>
						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="left">
									<input type="button" value="조회"		class="boardbtn1" onclick="go_search();">&nbsp;
									<input type="button" value="교번부여"	class="boardbtn1" onclick="go_eduNo('<%=requestMap.getString("commYear")%>', '<%=requestMap.getString("commGrcode")%>', '<%=requestMap.getString("commGrseq")%>', '<%= grseqRowMap.getString("grcodeniknm") %>');">&nbsp;
									<%= buttonStr %>
								</td>
							</tr>
						</table>

						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="100%"></td>
										</tr>
										<tr height='35' bgcolor="#5071B4">
											<td width="6%" align='center' class="tableline11 white">
												<strong>번호</strong>
											</td>
											<td width="6%" align='center' class="tableline11 white">
												<strong>교번</strong>
											</td>
											<td width="3%" align='center' class="tableline11 white">
												<input type="checkbox" name="checkAll" onClick="listSelectAll()">
											</td>
											<td width="7%" align='center' class="tableline11 white">
												<strong>이름</strong>
											</td>
											<td width="7%" align='center' class="tableline11 white">
												<strong>아이디</strong>
											</td>											
											<td width="7%" align='center' class="tableline11 white">
												<strong>생년월일</strong>
											</td>
											<td width="6%" align='center' class="tableline11 white" >
												<strong>1차<br>승인</strong>
											</td>
											<td width="6%" align='center' class="tableline11 white" >
												<strong>최종<br>승인</strong>
											</td>
											<td width="8%" align='center' class="tableline11 white" >
												<strong>신청일자</strong>
											</td>
											<td width="7%" align='center' class="tableline11 white">
												<strong>기관</strong>
											</td>
											<td width="8%" align='center' class="tableline11 white">
												<strong>소속</strong>
											</td>
											<td width="10%" align='center' class="tableline11 white">
												<strong>직급</strong>
											</td>
											<td width="*%" align='center' class="tableline11 white">
												<strong>이전기수<br>수료여부</strong>
											</td>
											<td width="8%" align='center' class="tableline11 white">
												<strong>전화</strong>
											</td>
											<td width="4%" align='center' class="tableline21 white">
												<strong>정보<br>수정</strong>
											</td>
										</tr>

										<%= listStr.toString() %>

									</table>
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
</body>


