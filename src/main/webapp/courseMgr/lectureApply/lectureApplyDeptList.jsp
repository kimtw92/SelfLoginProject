<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 수강신청조회/승인 리스트 (기관 담당자)
// date : 2008-09-04
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

	//수강신청 인원 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	
	
	//과정기수 정보.
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	//기관  정보.
	DataMap deptRowMap = (DataMap)request.getAttribute("DEPT_ROW_DATA");
	deptRowMap.setNullToInitialize(true);
	
	//기관  정보.
	DataMap finishMemberList = (DataMap)request.getAttribute("FINISHMEMBER_LIST_DATA");
	finishMemberList.setNullToInitialize(true);
	

	int totalCnt = 0;
	int applyCnt1 = 0;

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	

	String tmpDeptNm = "";
	
	boolean eduBool = false; //교육기간인자 확인.
	String eduCheckBox = "disabled"; //CheckBox Disable유무
	
	if( grseqRowMap.getString("endsentUseYn").equals("Y")  //과정 기수의 1차 기관 사용유무가 Y이고
			&& grseqRowMap.getInt("eapplyst1") < Integer.parseInt(DateUtil.getDateTime()) //현재 날짜가 수강신청일 보다 크고,
			&& Integer.parseInt(DateUtil.getDateTime()) <= grseqRowMap.getInt("endsent")){ //1차 승인 마감일 미만 일경우.
		eduCheckBox = "";
		eduBool = true;
	}
	
	for(int i=0; i < listMap.keySize("dept"); i++){

		totalCnt++;

		//checkBox
		if( eduBool && !listMap.getString("grchk", i).equals("Y") ) //수강기간이 승인처리 할수 있고 유저의 최종승인이 되어있지 않으면
			eduCheckBox = "";
		else
			eduCheckBox = "disabled";
		tmpStr = "<input type='checkbox' name=\"chk"+(i+1)+"\"	value='" + listMap.getString("userno", i) + "' " + eduCheckBox + ">";
		tmpStr += "<input type='hidden'  name=\"edu"+(i+1)+"\"	value=\"" + listMap.getString("userno", i) + "\">";
		listStr.append("\n	<td>" + tmpStr + "</td>");
		
		//번호
		listStr.append("\n	<td>" + (i+1) + "</td>");
		
		//성명
		tmpStr = "<a href=\"javascript:go_view('" + listMap.getString("userno", i) + "')\">" + listMap.getString("name", i) + "</a>";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//1차 승인
		tmpStr = "";
		if( listMap.getString("deptchk", i).equals("Y") )
			applyCnt1++;

		if( listMap.getString("deptchk", i).equals("N"))
			tmpStr = "<font color=red>" + listMap.getString("deptchk", i) + "</font>";
		else
			tmpStr = listMap.getString("deptchk", i);
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//신청일자
		listStr.append("\n	<td>" + listMap.getString("appdate", i) + "</td>");

		//기관명.
		if(listMap.getString("dept", i).equals("6280000"))
			tmpDeptNm = listMap.getString("deptnm", i);
		else
			tmpDeptNm = listMap.getString("deptnm", i).replaceAll("인천광역시", "");
		listStr.append("\n	<td>" + tmpDeptNm + "</td>");

		//소속
		listStr.append("\n	<td>" + listMap.getString("deptsub", i) + "</td>");

		//직급
		listStr.append("\n	<td>" + listMap.getString("jiknm", i) + "</td>");

		//동일과정 수료이력
		//listStr.append("\n	<td>" + listMap.getString("resultseq", i) + "</td>");
		
		
		
		//이전기수 수료여부
		listStr.append("\n	<td>");
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
		listStr.append(tmpStr);
		listStr.append("</td>");
		
		
		
		//전화
		listStr.append("\n	<td class='br0' >" + listMap.getString("telno", i) + "</td>");

		listStr.append("\n</tr>");


	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("<tr bgColor='#FFFFFF'>");
		listStr.append("	<td class='br0' colspan='100%' style='height:100px'>수강신청한 학생이 없습니다.</td>");
		listStr.append("</tr>");

	}


	//버튼
	String buttonStr = "";
	if(eduBool){ //승인 및 보류가 가능하면.
		buttonStr += "<input type=\"button\" class=\"boardbtn1\" name=\"confirm\" value=\"1차승인\" onClick=\"javascript:go_agree()\">&nbsp;";
		buttonStr += "<input type=\"button\" class=\"boardbtn1\" name=\"confirm\" value=\"승인보류\" onClick=\"javascript:go_cancel()\">&nbsp;";
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

	$("mode").value = "dept_list";
	$("qu").value = "";

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


//리스트 checkBox
function listSelectAll() {
	
	for (var i = 1; i <= <%= listMap.keySize("dept") %>; i++) {
		$("chk"+i).checked = $("checkAll").checked;
	}
}


//1차 승인
function go_agree(){

	if(confirm('선택한 교육생을 승인 하시겠습니까?')) {

		$("mode").value = "exec";
		$("qu").value = "dept_agree";

		pform.action = "/courseMgr/lectureApply.do";
		pform.submit();

	}
}


//1차 승인보류
function go_cancel(){

	if(confirm('사이버교육 시작 후 승인취소를 하시면 학습이력이 삭제됩니다. \n\n 선택한 교육생을 보류처리하시겠습니까?')) {

		$("mode").value = "exec";
		$("qu").value = "dept_cancel";

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
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"					value="<%= requestMap.getString("qu") %>">

<input type="hidden" name="applyCnt"			value="<%= listMap.keySize("dept") %>">
<input type="hidden" name="reload"				value="GO">

<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">


<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap="nowrap"><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>수강신청 리스트</strong>
					</td>
				</tr>
			</table>
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
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9" colspan="3">
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" style="width:100px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
							</tr>														
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->
						
						<div class="space01"></div>

						<!-- subTitle -->
						<div class="tit01" style="padding-left:0;">
							<strong>과정기수:</strong><%= grseqRowMap.getString("grcodeniknm") %>
							<strong>기관:</strong><%= deptRowMap.getString("deptnm") %><br>
							<span class="mr10"><strong>수강신청일:</strong> (<%= DateUtil.convertDate1(grseqRowMap.getString("eapplyst1"))%> ~ {<%= DateUtil.convertDate1(grseqRowMap.getString("eapplyed1"))%>) </span>
							<span class="mr10"><strong>1차승인마감일:</strong> <%= DateUtil.convertDate1(grseqRowMap.getString("endsent"))%> </span><br>
							수강신청기간이 아닐 경우 승인할 수 없습니다. 전체선택/취소하실 경우 아래의 체크 박스를 선택하세요. 
						</div>

						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr height="28">
								<td width="100%" align="left">
									<span class="mr10"><strong>정원:</strong> <%= Util.getValue(grseqRowMap.getString("tseat"), "0") %>명 </span>
									<span class="mr10"><strong>신청인원:</strong> <%= totalCnt %>명 </span>
									<span class="mr10"><strong>1차승인인원:</strong> <%= applyCnt1 %>명 </span>
								</td>
							</tr>
						</table>


						<div class="tit02" style="padding-left:0;">

						</div>
						<!-- // subTitle -->						
						<div class="h5"></div>


						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="left">
									<%= buttonStr %>
								</td>
							</tr>
						</table>

						<table class="datah01">
							<thead>
							<tr>
								<th style="width:20px;">
									<input type="checkbox" name="checkAll" class="chk_01" onClick="listSelectAll()" <%= !eduBool ? "disabled" : ""%>>
								</th>
								<th>번호</th>
								<th>성명</th>
								<th>1차<br />승인</th>
								<th>신청일자</th>
								<th>기관</th>
								<th>소속</th>
								<th>직급</th>
								<!-- <th>동일과정<br>수료이력</th> -->
								<th>이전기수<br>수료여부</th>
								<th class="br0">전화</th>
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

