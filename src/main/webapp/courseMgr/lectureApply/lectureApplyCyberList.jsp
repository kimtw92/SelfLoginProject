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
	int totalCnt = 0;
	int applyCnt1 = 0;
	int applyCnt2 = 0;

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	String tmpStr2 = "";

	String tmpDeptNm = "";
	for(int i=0; i < listMap.keySize("dept"); i++){

		totalCnt++;
		//기관명.
		if(listMap.getString("dept", i).equals("6280000"))
			tmpDeptNm = listMap.getString("deptnm", i);
		else
			tmpDeptNm = listMap.getString("deptnm", i).replaceAll("인천광역시", "");

		listStr.append("\n<tr>");

		if( !tmpStr2.equals(listMap.getString("dept", i)) ){
			tmpStr = deptCntRow.getString(listMap.getString("dept", i));
			listStr.append("\n	<td colspan='100%' style='text-align:left' class='br0'> &nbsp;" + tmpDeptNm + "(" + tmpStr + "명)</td></tr><tr>");
		}

		//번호
		listStr.append("\n	<td>" + (i+1) + "</td>");
		//과정명
		listStr.append("\n	<td>" + listMap.getString("grcodenm", i) + "</td>");
		//교번
		tmpStr = listMap.getString("eduno", i).equals("0") ? "&nbsp;" : listMap.getString("eduno", i);
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//CheckBox
		tmpStr2 = "";
		if( listMap.getString("deptchk", i).equals("N") || listMap.getString("grchk", i).equals("C"))
			tmpStr2 = "disabled";
		if( listMap.getString("grchk", i).equals("Y"))
			tmpStr2 += "  checked ";
		tmpStr = "<input type='checkbox' class=\"chk_01\"  name=\"chk"+(i+1)+"\"	value='" + listMap.getString("userno", i) + "' " + tmpStr2 + ">";
		tmpStr += "<input type='hidden'  name=\"edu"+(i+1)+"\"	value=\"" + listMap.getString("userno", i) + "\">";
		tmpStr += "<input type='hidden'  name=\"name"+(i+1)+"\" value=\"" + listMap.getString("name", i) + "\">";
		tmpStr += "<input type='hidden'  name=\"dept"+(i+1)+"\" value=\"" + listMap.getString("dept", i) + "\">";
		tmpStr += "<input type='hidden'  name=\"jik"+(i+1)+"\"	value=\"" + listMap.getString("jik", i) + "\">";
		tmpStr += "<input type='hidden'  name=\"grcode"+(i+1)+"\"	value=\"" + listMap.getString("grcode", i) + "\">";
		listStr.append("\n	<td align='center' class='tableline11'>" + tmpStr + "</td>");

		//이름
		tmpStr = "<a href=\"javascript:go_view('" + listMap.getString("userno", i) + "')\">" + listMap.getString("name", i) + "</a>";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//생년월일
		tmpStr = "";
		listStr.append("\n	<td>" + listMap.getString("resno", i) + "&nbsp;</td>");

		//1차 승인
		if( listMap.getString("deptchk", i).equals("Y") )
			applyCnt1++;
		tmpStr = "";
		if( listMap.getString("deptchk", i).equals("N"))
			tmpStr = "<font color=red>" + listMap.getString("deptchk", i) + "</font>";
		else
			tmpStr = listMap.getString("deptchk", i);
		listStr.append("\n	<td>" + tmpStr + "&nbsp;</td>");

		//최종승인
		if( listMap.getString("grchk", i).equals("Y") )
			applyCnt2++;
		tmpStr2 = "";
		tmpStr = "";
		if( listMap.getString("grchk", i).equals("Y"))
			tmpStr = "<font color=blue>" + listMap.getString("grchk", i) + "</font>";
		else if( listMap.getString("grchk", i).equals("N"))
			tmpStr = "<font color=red>" + listMap.getString("grchk", i) + "</font>";
		else
			tmpStr = listMap.getString("grchk", i);
		listStr.append("\n	<td>" + tmpStr + "&nbsp;</td>");

		//신청일자
		listStr.append("\n	<td>" + listMap.getString("appdate", i) + "</td>");

		//기관
		listStr.append("\n	<td>" + tmpDeptNm + "</td>");

		//소속
		if(listMap.getString("deptsub", i).equals(""))
			tmpStr = listMap.getString("deptsub2", i);
		else
			tmpStr = listMap.getString("deptsub", i);
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//직급
		listStr.append("\n	<td>" + listMap.getString("jiknm", i) + "&nbsp;</td>");

		//이전기수 수료여부
		tmpStr = "";
		int tmpCnt = 0;
		for(int j=0; j < finishMemberList.keySize("userno"); j++){
			if( finishMemberList.getString("userno", j).equals(listMap.getString("userno", i)) ){
				if(tmpCnt > 0)
					tmpStr += "<br>";
				if(!finishMemberList.getString("rgrayn", j).equals("Y"))
					tmpStr += " <font color='red'>(" + finishMemberList.getString("grseq", j) + ") " + finishMemberList.getString("grcodeniknm", j) + " (" + finishMemberList.getString("rgrayn", j) + ")</font> ";
				else
					tmpStr += " (" + finishMemberList.getString("grseq", j) + ") " + finishMemberList.getString("grcodeniknm", j) + " (" + finishMemberList.getString("rgrayn", j) + ") ";

				tmpCnt++;
			} //end if
		} //end for
		listStr.append("\n	<td>" + tmpStr + "&nbsp;</td>");

		//전화
		listStr.append("\n	<td>" + listMap.getString("hpno", i) + "&nbsp;</td>");

		//정보수정
		tmpStr = "<input type='button' value='수정' class='boardbtn1' onClick=\"javascript:go_modify('"+listMap.getString("userno", i)+"', '"+listMap.getString("grcode", i)+"')\">";
		listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");


		listStr.append("\n</tr>");

		tmpStr2 = listMap.getString("dept", i);

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("dept") <= 0){

		listStr.append("<tr bgColor='#FFFFFF'>");
		listStr.append("	<td style='height:100px;'  class=\"br0\" colspan='100%'>수강신청한 학생이 없습니다.</td>");
		listStr.append("</tr>");

	}


	//부서 리스트.
	String deptStr = "";
	for(int i=0; i < deptList.keySize("dept"); i++){

		tmpStr2 = "";
		
		if(requestMap.getString("reload").equals("")) //첫로딩이 이면 (그렇지 않으면"GO"들어옴)
			tmpStr2 = "checked";
		else if( requestMap.getString("deptStr").indexOf(deptList.getString("dept", i)) >= 0 )
			tmpStr2 = "checked";

		deptStr += "<li><input type='checkbox' name='dept[]' value='" + deptList.getString("dept", i) + "' "+tmpStr2+">" + deptList.getString("replaceDeptnm", i) + "</li>";


	}


	//버튼
	String buttonStr = "";
	if(grseqRowMap.getInt("eapplyst1") <= Integer.parseInt(DateUtil.getDateTime()) && grseqRowMap.getInt("endaent") >= Integer.parseInt(DateUtil.getDateTime())){
		buttonStr += "<input type=\"button\" class=\"boardbtn1\" name=\"confirm\" value=\"SMS\" onClick=\"javascript:go_sms()\">&nbsp;";
		
	}
	if(grseqRowMap.getInt("endaent") >= Integer.parseInt(DateUtil.getDateTime())){
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

	$("mode").value = "cyber_list";

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
//회원정보 수정에 과정코드는 필수라 수정함.
function go_modify(userno, grcode) {

	var mode = "stu_form";
	//var grcode = "<%//= requestMap.getString("commGrcode") %>";
	var grseq  = "<%= requestMap.getString("commGrseq") %>";
	var menuId = $F("menuId");
	var url    = "/courseMgr/lectureApply.do?mode=" + mode + "&menuId=" + menuId + "&userno=" + userno + "&grcode=" + grcode + "&grseq=" + grseq;

	popWin(url, "pop_studentEditForm", "500", "250", "0", "");

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
function go_eduNo(year, grcode, grseq){


	if(grseq == ""){
	   alert("기수를 선택하세요!");
	   return;
	}

	if(  confirm("승인된 수강생의 교번을 부여하시겠습니까?\n교번을 부여하게 되면 이전에 부여되었던 교번은 삭제됩니다.") ){

		var objAjax = new Object();
		objAjax.url = "/courseMgr/lectureApply.do";
		objAjax.pars = "mode=ajax_exec&qu=cyber_eduno" + "&year=" + year + "&grcode=" + grcode + "&grseq=" + grseq;
		objAjax.aSync = true; 
		objAjax.targetDiv = "";
		objAjax.successMsg = "처리되었습니다.";
		objAjax.successFunc = "go_reload();";

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
		$("qu").value = "cyber_agree";

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
		$("qu").value = "cyber_cancel";

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
	var reloading = ""; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCyberCommOnloadGrSeq(reloading, commYear, commGrSeq);
	getCyberCommOnloadGrCode(reloading, commYear, commGrCode, commGrSeq);
	
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
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과정기수관리 리스트</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									년도
								</th>
								<td width="20%">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCyberCommGrSeq('grCode');" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th>
									기수명
								</th>
								<td>
									<div id="divCyberCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>

								<td width="100" class="btnr" rowspan="2">
									<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th width="80" class="bl0">
									과정명
								</th>
								<td width="35%">
									<div id="divCyberCommGrCode" class="commonDivLeft">
										<select id="commGrcode" name="commGrcode" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th>
									부서전체선택
								</th>
								<td>
									<input type='checkbox' name='all_mark' onClick="chkAllDept();" checked >전체선택
								</td>
							</tr>
						</table>
						<!--//검색 -->
						<div class="space01"></div>


						<!-- subTitle -->
						<div class="tit01" style="padding-left:0;">
							<span class="mr10"><strong>수강신청일:</strong> {<%= DateUtil.convertDate1(grseqRowMap.getString("eapplyst1"))%> ~ <%= DateUtil.convertDate1(grseqRowMap.getString("eapplyed1"))%>} </span>
							<span class="mr10"><strong>1차승인마감일:</strong> <%= DateUtil.convertDate1(grseqRowMap.getString("endsent"))%> </span>
							<span class="mr10"><strong>최종승인마감일:</strong> <%= DateUtil.convertDate1(grseqRowMap.getString("endaent"))%> </span>
						</div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr height="28">
								<td width="100%" align="left">
									<span class="mr10"><strong>신청인원:</strong> <%= totalCnt %>명 </span>
									<span class="mr10"><strong>1차승인인원:</strong> <%= applyCnt1 %>명 </span>
									<span class="mr10"><strong>2차승인인원:</strong> <%= applyCnt2 %>명 </span>
								</td>
							</tr>
						</table>
						<!-- // subTitle -->						
						<div class="h5"></div>



						<!-- 부서목록 -->
						<table class="tab01">
							<tr>
								<td>
									<ul class="hl02">
										<%= deptStr %>
									</ul>
								</td>
						</table>

						<div class="space01"></div>
						<!-- [s] 상단 추가, 새로고침 버튼  -->
						<table class="btn01">
							<tr>
								<td class="left">
									<input type="button" value="조회"		class="boardbtn1" onclick="go_search();">
									<input type="button" value="교번부여"	class="boardbtn1" onclick="go_eduNo('<%=requestMap.getString("commYear")%>', '<%=requestMap.getString("commGrcode")%>', '<%=requestMap.getString("commGrseq")%>');">
									<%= buttonStr %>
								</td>
							</tr>
						</table>
						<!-- //[e] 상단 추가, 새로고침 버튼  -->

						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th>과정명</th>
								<th>교번</th>
								<th style="width:20px;">
									<input type="checkbox" name="checkAll" class="chk_01" onClick="listSelectAll()">
								</th>
								<th>이름</th>
								<th>생년월일</th>
								<th>1차<br />승인</th>
								<th>최종<br />승인</th>
								<th>신청일자</th>
								<th>기관</th>
								<th>소속</th>
								<th>직급</th>
								<th>이전기수<br />수료여부</th>
								<th>전화</th>
								<th class="br0">정보<br />수정</th>
							</tr>
							</thead>

							<tbody>
								<%= listStr.toString() %>
							</tbody>
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

