<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 설문관리 - 등록/수정 폼
// date : 2008-09-17
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<%!
	/**
	 * 공통으로 사용하는 시간 리스트 (0~23시)
	 * @param String selectStr
	 * @param String gubun : start: 시작시간, end: 종료시간
	 */
	private String getHourStr(String selectStr, String gubun){

		String tmpStr2 = "";
		String returnValue = "";
		
		//시간 정보 있을때
		if(selectStr != "") {
			for(int i=0; i < 24; i++){
				if(selectStr.equals(Util.plusZero(i))) {
					tmpStr2 = "selected";
				} else {
					tmpStr2 = "";
				}
				returnValue += "<option value=\""+Util.plusZero(i)+"\" "+tmpStr2+">"+Util.plusZero(i)+"</option>";
			}
			
		//시간 정보 없을때 23시 59분으로 셋팅
		} else {
			for(int i=0; i<24; i++){
				//시작시간
				if("start".equals(gubun)) {
					if("00".equals(Util.plusZero(i))) {
						tmpStr2 = "selected";
					} else {
						tmpStr2 = "";
					}
				//종료시간
				} else {
					if("23".equals(Util.plusZero(i))) {
						tmpStr2 = "selected";
					} else {
						tmpStr2 = "";
					}
				}
				
				returnValue += "<option value=\""+Util.plusZero(i)+"\" "+tmpStr2+">"+Util.plusZero(i)+"</option>";
			}	
		}
		return returnValue;
	}

	/**
	 * 공통으로 사용하는 분 리스트 (0~59분)
	 * @param String selectStr
	 * @param String gubun : start: 시작 분, end: 종료 분
	 */
	private String getMinStr(String selectStr, String gubun){
		String tmpStr2 = "";
		String returnValue = "";
		
		//분 정보 있을때
		if(selectStr != "") {
			for(int i=0; i < 60; i++){
				if(selectStr.equals(Util.plusZero(i))) {
					tmpStr2 = "selected";
				} else {
					tmpStr2 = "";
				}
				returnValue += "<option value=\""+Util.plusZero(i)+"\" "+tmpStr2+">"+Util.plusZero(i)+"</option>";
			}
		
		//분 정보 없을때 23시 59분으로 셋팅
		} else {
			//시작 분
			if("start".equals(gubun)) {
				for(int i=0; i < 60; i++){
					if("00".equals(Util.plusZero(i))) {
						tmpStr2 = "selected";
					} else {
						tmpStr2 = "";
					}
					returnValue += "<option value=\""+Util.plusZero(i)+"\" "+tmpStr2+">"+Util.plusZero(i)+"</option>";
				}
			//종료 분
			} else {
				for(int i=0; i < 60; i++){
					if("59".equals(Util.plusZero(i))) {
						tmpStr2 = "selected";
					} else {
						tmpStr2 = "";
					}
					returnValue += "<option value=\""+Util.plusZero(i)+"\" "+tmpStr2+">"+Util.plusZero(i)+"</option>";
				}	
			}
			
		}
		return returnValue;
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

	//설문지 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

	//세트 리스트
	DataMap setListMap = (DataMap)request.getAttribute("SET_LIST_DATA");
	setListMap.setNullToInitialize(true);
	
	//일반 과목 리스트
	DataMap normalSubjList = (DataMap)request.getAttribute("SUBJ_LIST_DATA");
	normalSubjList.setNullToInitialize(true);

	//필수 과목 리스트
	DataMap needPollMap = (DataMap)request.getAttribute("NEED_POLL_LIST_DATA");
	needPollMap.setNullToInitialize(true);

	//공통 과목 리스트
	DataMap commPollMap = (DataMap)request.getAttribute("COMM_POLL_LIST_DATA");
	commPollMap.setNullToInitialize(true);

	//과목 과목 리스트
	DataMap subjPollMap = (DataMap)request.getAttribute("SUBJ_POLL_LIST_DATA");
	subjPollMap.setNullToInitialize(true);

	//과목 과목 리스트
	String chioceSubjSelStr = (String)request.getAttribute("CHIOCE_SUBJ_OPTION_STRING");


	//간단한 과정 기수 정보
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	StringBuffer setListStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < setListMap.keySize("titleNo"); i++){

		setListStr.append("\n<tr>");

		//세트번호
		setListStr.append("\n	<td>" + (i+1) + "</td>");

		//선택된과목
		setListStr.append("\n	<td>" + Util.getValue(setListMap.getString("subjnm", i), "과목항목에 대한 설문이 없습니다.") + "</td>");

		//강사설문
		tmpStr = "<input type='button' value='설문출력' onclick=\"go_tutorPollExcel('"+setListMap.getString("titleNo", i)+"', '"+setListMap.getString("setNo", i)+"');\" class='boardbtn1' /><br>";
		tmpStr += "<input type='button' value='분석출력' onclick=\"go_tutorResultExcel('"+setListMap.getString("titleNo", i)+"', '"+setListMap.getString("setNo", i)+"');\" class='boardbtn1' />";
		setListStr.append("\n	<td>" + tmpStr + "</td>");
		
		//전체분석출력
		tmpStr = "<input type='button' value='분석출력' onclick=\"go_pollAI('"+setListMap.getString("titleNo", i)+"', '"+setListMap.getString("setNo", i)+"', 'total');\" class='boardbtn1' />";
		setListStr.append("\n	<td>" + tmpStr + "</td>");
		
		//공통설문인쇄
		tmpStr = "<input type='button' value='출력하기' onclick=\"go_pollAI('"+setListMap.getString("titleNo", i)+"', '"+setListMap.getString("setNo", i)+"', 'comm');\" class='boardbtn1' />";
		setListStr.append("\n	<td>" + tmpStr + "</td>");
		
		//인터넷 설문
		tmpStr = "<input type='button' value='미리보기' onclick=\"go_internetPreview('"+setListMap.getString("titleNo", i)+"', '"+setListMap.getString("setNo", i)+"');\" class='boardbtn1' />";
		setListStr.append("\n	<td>" + tmpStr + "</td>");
		
		//설문 분석
		tmpStr = "<input type='button' value='미리보기' onclick=\"go_pollPreview('"+setListMap.getString("titleNo", i)+"', '"+setListMap.getString("setNo", i)+"');\" class='boardbtn1' /><br>";
		tmpStr += "<input type='button' value='분석출력' onclick=\"go_pollAI('"+setListMap.getString("titleNo", i)+"', '"+setListMap.getString("setNo", i)+"', 'poll');\" class='boardbtn1' />";
		setListStr.append("\n	<td>" + tmpStr + "</td>");
		
		//삭제
		tmpStr = "<input type='button' value='삭제' onclick=\"go_deleteSet('"+setListMap.getString("titleNo", i)+"', '"+setListMap.getString("setNo", i)+"');\" class='boardbtn1' />";
		setListStr.append("\n	<td class='br0'>" + tmpStr + "</td>");
		
	
		setListStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( setListMap.keySize("titleNo") <= 0){

		setListStr.append("\n<tr>");
		setListStr.append("\n	<td colspan='100%' style=\"height:50px\"  class='br0'>작성된 설문 세트가 없습니다.</td>");
		setListStr.append("\n</tr>");

	}


	//일반 과목 selectBox
	String commSubjStr = "";
	for(int i=0; i < normalSubjList.keySize("subj"); i++)
		commSubjStr += "<option VALUE='"+normalSubjList.getString("subj", i)+"'>"+normalSubjList.getString("lecnm", i)+"</option>";

	// 필수 selectBox
	String needPollStr = "";
	for(int i=0; i < needPollMap.keySize("questionNo"); i++)
		needPollStr += "<option VALUE='"+needPollMap.getString("questionNo", i)+"'>"+needPollMap.getString("question", i)+"</option>";

	//공통 과목 selectBox
	String commPollStr = "";
	for(int i=0; i < commPollMap.keySize("questionNo"); i++)
		commPollStr += "<option VALUE='"+commPollMap.getString("questionNo", i)+"'>"+commPollMap.getString("question", i)+"</option>";

	//과목 selectBox
	String subjPollStr = "";
	//if( !grseqRowMap.getString("fCyber").equals("Y") ) {
		for(int i=0; i < subjPollMap.keySize("questionNo"); i++)
			subjPollStr += "<option VALUE='"+subjPollMap.getString("questionNo", i)+"'>"+subjPollMap.getString("question", i)+"</option>";
	//}

	

	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 선택하세요!" : grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기";

	String timeHourStr = "";
	for(int i=0; i<23; i++){
		timeHourStr += "<option value=\""+Util.plusZero(i)+"\">"+Util.plusZero(i)+"</option>";
	}

	String timeMinStr = "";
	for(int i=0; i<60; i++){
		timeMinStr += "<option value=\""+Util.plusZero(i)+"\">"+Util.plusZero(i)+"</option>";
	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//리스트
function go_list(){

	var mode = "<%= requestMap.getString("isCyber").equals("Y") ? "cyber_list" : "list" %>"
	$("mode").value = mode;

	pform.action = "/poll/coursePoll.do";
	pform.submit();

}

//설문 안내문 넣기
function go_pollGuide(){

	if( $F("grcode") == "" || $F("grseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}

	var mode = "guide_list";
	var menuId = $F("menuId");
	var url = "/poll/coursePoll.do?mode=" + mode + "&menuId=" + menuId + "&grcode=" + $F("grcode") + "&grseq=" + $F("grseq");

	popWin(url, "pop_pollGuide", "600", "600", "1", "");

}

//인터넷 설문 미리보기
function go_internetPreview(titleNo, setNo){

	var mode = "www_poll_preview";
	var menuId = $F("menuId");
	var url = "/poll/coursePoll.do?mode=" + mode + "&menuId=" + menuId + "&titleNo=" + titleNo + "&setNo=" + setNo;

	popWin(url, "pop_internetPreview", "600", "600", "1", "");

}
//설문 분석 미리보기
function go_pollPreview(titleNo, setNo){

	var mode = "poll_result_preview";
	var menuId = $F("menuId");
	var url = "/poll/coursePoll.do?mode=" + mode + "&menuId=" + menuId + "&titleNo=" + titleNo + "&setNo=" + setNo;

	popWin(url, "pop_pollPreview", "750", "600", "1", "");

}


//셋트 구성시 선택한 과목 및 설문 Hidden에 넣기.
function updatepolllist(frm, r_formName, added_listName) {
	//alert([frm, r_formName, added_listName]);
	var selRight = document.forms[frm].elements[r_formName];
	var addedArray = new Array(selRight.options.length);

	for (var i = 0; i < selRight.options.length; i++) {
		addedArray[i] = selRight.options[i].value;
	}
	//alert(addedArray);
	document.forms[frm].elements[added_listName].value = addedArray;
}


//설문 설정 및 세트 까지 등록시 
function go_setPoll(){

	updatepolllist('pform','commsubjRightSelect','commsubjAddedList');
	updatepolllist('pform','selectsubjRightSelect','selectAddedList');
	updatepolllist('pform','rightSelect','needAddedList');
	updatepolllist('pform','rightSelect1','commAddedList');
	updatepolllist('pform','rightSelect2','subjAddedList');

	if( confirm('설문세트를 구성 하시겠습니까?') ) {

		$("mode").value = "exec";
		$("qu").value = "update";
		$("setOn").value = 'on';

		pform.action = "/poll/coursePoll.do";
		pform.submit();
	}
}

//설문 설정만  등록시
function go_onlyPoll(){

	if( go_inputCheck() && confirm('설문을 작성 하시겠습니까?') ) {

		$("mode").value = "exec";
		$("setOn").value = 'off';

		pform.action = "/poll/coursePoll.do";
		pform.submit();
	}

}

//등록 및 수정시 체크.
function go_inputCheck(){

	if( NChecker(document.pform) ) {

		if( $F("startDate") == "" ){
			alert("설문적용 시작기간을 입력해주십시요!");
			return false;
		}
		if( $F("endDate") == "" ){
			alert("설문적용 종료기간을 입력해주십시요!");
			return false;
		}

		if( $F("startPeriod") == "" ){
			alert("설문실시 시작기간을 입력해주십시요!");
			return false;
		}
		if( $F("endPeriod") == "" ){
			alert("설문실시 종료기간을 입력해주십시요!");
			return false;
		}
		if(!go_commonCheckedCheck(pform.questionCommGubun)){
			alert("설문구분을 선택해주세요!");
			return false;
		}
		if(!go_commonCheckedCheck(pform.gubunOnOff)){
			alert("온/오프라인 구분을 선택해주세요!");
			return false;
		}

		if(!go_commonCheckedCheck(pform.useYn)){
			alert("설문 실시 여부를 선택해주세요!");
			return false;
		}



		return true;
	}else
		return false;

}


// 설문 셋트 삭제
function go_deleteSet(titleNo, setNo){

	if(confirm('세트를 삭제 하시겠습니까?\n관련정보가 모두 삭제됩니다.')) {

		$("titleNo").value = titleNo;
		$("setNo").value = setNo;

		$("mode").value = "exec";
		$("qu").value = "set_delete";


		pform.action = "/poll/coursePoll.do";
		pform.submit();
	}

}



//설문 세트 구성
function go_setDivView(){

	for(i=1;i<7;i++){
		$("sel_"+i).style.display = 'block';
	}
	$('sel_7').style.display = 'none';
	$("setOn").value = 'on';
}

//강사설문 - 설문출력
function go_tutorPollExcel(titleNo, setNo){

	$("titleNo").value = titleNo;
	$("setNo").value = setNo;

	$("mode").value = "tutor_poll_excel";

	pform.action = "/poll/coursePoll.do";
	pform.submit();

}

//강사설문 - 분석출력
function go_tutorResultExcel(titleNo, setNo){

	$("titleNo").value = titleNo;
	$("setNo").value = setNo;

	$("mode").value = "tutor_result_excel";

	pform.action = "/poll/coursePoll.do";
	pform.submit();

}

//AI
function go_pollAI(titleNo, setNo, mode){

	if( mode == "total"){

		popAI("http://<%= Constants.AIREPORT_URL %>/report/report_89.jsp?p_grcode=" + $F("grcode") + "&p_grseq=" + $F("grseq") + "&p_title_no=" + titleNo + "&p_set_no=" + setNo);
	}else if( mode == "comm"){

		popAI("http://<%= Constants.AIREPORT_URL %>/report/report_87.jsp?p_grcode=" + $F("grcode") + "&p_grseq=" + $F("grseq") + "&p_title_no=" + titleNo + "&p_set_no=" + setNo);

	}else if( mode == "poll"){

		popAI("http://<%= Constants.AIREPORT_URL %>/report/report_88.jsp?p_grcode=" + $F("grcode") + "&p_grseq=" + $F("grseq") + "&p_title_no=" + titleNo + "&p_set_no=" + setNo);

	}

}



var removedList = new Array();
var addedList = new Array();

function moveToRight(frm, l_formName, r_formName, only) {
	var selLeft = document.forms[frm].elements[l_formName].options;
	var selRight = document.forms[frm].elements[r_formName].options;
	if (selLeft.selectedIndex < 0) {
		alert("추가할 설문항목을 선택하세요.");
		return;
	}

	if(only == 'on'){
			if(selRight.length > 0){
				alert("1개만 입력이 가능합니다");
				return;
				selectcolor(frm, l_formName, r_formName);
			}
			if(selLeft[0].value == 'A000000000'){
				alert('선택과목이 존재하지 않습니다');
				return;
			}
		}

	for (var i=0;i<selLeft.length;i++){

			if (selLeft[i].selected){
			var found_in_right = false;
			for (var j=0;j<selRight.length;j++){
				if (selLeft[i].value==selRight[j].value){
					found_in_right = true;
					break;
				}
			}
			if (!found_in_right){

				if(only == 'on'){
						if(selRight.length > 0){
						return;
						}
				}

				var newOpt = document.createElement("OPTION");
				newOpt.text = selLeft[i].text;
				newOpt.value = selLeft[i].value;
				selRight.add(newOpt);
				if (!removedList[selLeft[i].value]) {
					addedList[selLeft[i].value] = true;
				}
				delete removedList[selLeft[i].value];
			}
		}
	}
	selectcolor(frm,l_formName,r_formName);
}

function moveToLeft(frm,l_formName,r_formName) {
	var selRight = document.forms[frm].elements[r_formName].options;
	if (selRight.selectedIndex < 0) {
		alert("제거할 설문을 선택하세요.");
		return;
	}
	for (var i=0;i<selRight.length;i++){
		if (selRight[i].selected){
			removedList[selRight[i].value] = true;
			if (!addedList[selRight[i].value]) {
				delete addedList[selRight[i].value];
			}
			document.forms[frm].elements[r_formName].remove(i);
			i--;
		}
	}
	selectcolor(frm,l_formName,r_formName);
}


function selectcolor(frm,l_formName,r_formName){
	var n1=document.forms[frm].elements[r_formName].options.length;
	var n2=document.forms[frm].elements[l_formName].options.length;
	for (var j=0;j<n2;j++){
		document.forms[frm].elements[l_formName].options[j].style.color='black';
	}
	for (var i=0;i<n1;i++){
		for (var j=0;j<n2;j++){
			if (document.forms[frm].elements[l_formName].options[j].value==document.forms[frm].elements[r_formName].options[i].value){
				document.forms[frm].elements[l_formName].options[j].style.color='#ffcc00';
				break;
			}
		}
	}
}

function moveVertically(type,frm,l_formName,r_formName) {

	var selRight = document.forms[frm].elements[r_formName];
	var index = selRight.selectedIndex;

	if (type == "U") {
		if(index > 0) {
			swap(selRight, index, index - 1);
		}
	} else if (type == "D") {
		if(index < selRight.options.length-1) {
			swap(selRight, index, index + 1);
		}
	} else if (type == "T") {
		for (var i = index; i > 0; i--) {
			swap(selRight, i, i - 1);
		}
	} else if (type == "B") {
		for (var i = index; i < selRight.options.length - 1; i++) {
			swap(selRight, i, i + 1);
		}
	}
	selectcolor(frm,l_formName,r_formName);
}

function swap(selectedOption, index, targetIndex) {
	var onetext = selectedOption.options[targetIndex].text;
	var onevalue = selectedOption.options[targetIndex].value;

	selectedOption.options[targetIndex].text= selectedOption.options[index].text;
	selectedOption.options[targetIndex].value	= selectedOption.options[index].value;
	selectedOption.options[index].text = onetext;
	selectedOption.options[index].value = onevalue;
	selectedOption.options.selectedIndex = targetIndex;

	selectedOption.options[targetIndex].selected = true;

}


//로딩시.
onload = function()	{

}


//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"					value="<%= requestMap.getString("qu") %>">

<input type="hidden" name="grcode"				value="<%= requestMap.getString("grcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("grseq") %>">
<input type="hidden" name="titleNo"				value="<%= requestMap.getString("titleNo") %>">
<input type="hidden" name="isCyber"				value="<%= requestMap.getString("isCyber") %>">

<input type="hidden" name="setOn"				value="">
<input type="hidden" name="guideNo"				value="">
<input type="hidden" name="setNo"				value="">

<input type="hidden" name="commsubjAddedList"			value="">
<input type="hidden" name="selectAddedList"				value="">
<input type="hidden" name="needAddedList"				value="">
<input type="hidden" name="commAddedList"				value="">
<input type="hidden" name="subjAddedList"				value="">

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




			<div class="h10"></div>
			<!-- subTitle
			<div class="tit01">
				<h2 class="h2"><img src="../images/bullet003.gif">과정기수관리 리스트</h2>
			</div>
			// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>

						<!-- subTitle -->
						<h2 class="h2"><img src="../images/bullet003.gif"> <%= grseqNm %> 설문관리</h2>
						<!-- // subTitle -->
						<div class="h5"></div>

						<!--[s] 검색 -->
						<table class="search01">
							<tr>
								<th>설문 제목</th>
								<td class="br0">
									<input type="text" class="textfield" name="title" value="<%= rowMap.getString("title") %>" style="width:320px;" required="true!설문제목 을 입력해주십시요." />
									<input type="button" value="설문 안내문 넣기" onclick="go_pollGuide();" class="boardbtn1" >
								</td>
							</tr>
							<tr>
								<th>설문 실시기간<br />
									<span class="txt_99">(실제로 적용하는 기간)</span></th>
								<td class="br0">
									<input type="text" class="textfield" name="startDate" value="<%= rowMap.getString("sdate") %>" readonly style="width:100px" />
									<img src="../images/icon_calen.gif" alt="" style="cursor:hand;" onclick="fnPopupCalendar('', 'startDate');" />
									<select name="startHh">
										<%= getHourStr(rowMap.getString("sdateHh"), "start") %>
									</select>시
									<select name="startMm">
										<%= getMinStr(rowMap.getString("sdateMm"), "start") %>
									</select>분
									  ~
									<input type="text" class="textfield" name="endDate" value="<%= rowMap.getString("edate") %>" readonly style="width:100px" />
									<img src="../images/icon_calen.gif" alt="" style="cursor:hand;" onclick="fnPopupCalendar('', 'endDate');" />
									<select name="endHh">
										<%= getHourStr(rowMap.getString("edateHh"), "end") %>
									</select>시
									<select name="endMm">
										<%= getMinStr(rowMap.getString("edateMm"), "end") %>
									</select>분
								</td>
							</tr>
							<tr>
								<th>설문 교육기간</th>
								<td class="br0">
									<input type="text" class="textfield" name="startPeriod" value="<%= rowMap.getString("speriod") %>" readonly style="width:100px" />
									<img src="../images/icon_calen.gif" alt="" style="cursor:hand;" onclick="fnPopupCalendar('', 'startPeriod');" />
									<select name="startPeriodHh">
										<%= getHourStr(rowMap.getString("speriodHh"), "start") %>
									</select>시
									<select name="startPeriodMm">
										<%= getMinStr(rowMap.getString("speriodMm"), "start") %>
									</select>분
									  ~
									<input type="text" class="textfield" name="endPeriod" value="<%= rowMap.getString("eperiod") %>" readonly style="width:100px" />
									<img src="../images/icon_calen.gif" alt="" style="cursor:hand;" onclick="fnPopupCalendar('', 'endPeriod');" />
									<select name="endPeriodHh">
										<%= getHourStr(rowMap.getString("eperiodHh"), "end") %>
									</select>시
									<select name="endPeriodMm">
										<%= getMinStr(rowMap.getString("eperiodMm"), "end") %>
									</select>분
								</td>
							</tr>
							<tr>
								<th>설문 구분</th>
								<td class="br0">
									<input type="radio" name="questionCommGubun" value="3" id="questionCommGubun1" <%= rowMap.getString("questionCommGubun").equals("3") ? "checked" : "" %>>
									<label for="questionCommGubun1">3일이하 </label>
									<input type="radio" name="questionCommGubun" value="5" id="questionCommGubun2" <%= rowMap.getString("questionCommGubun").equals("5") ? "checked" : "" %>>
									<label for="questionCommGubun2">5일이상 </label>
									<input type="radio" name="questionCommGubun" value="4" id="questionCommGubun3" <%= rowMap.getString("questionCommGubun").equals("4") ? "checked" : "" %>>
									<label for="questionCommGubun3">사이버 </label>
									<input type="radio" name="questionCommGubun" value="0" id="questionCommGubun4" <%= rowMap.getString("questionCommGubun").equals("0") ? "checked" : "" %>>
									<label for="questionCommGubun4">기타 </label>
								</td>
							</tr>
							<tr>
								<th>온/오프라인 구분</th>
								<td class="br0">
									<input type="radio" name="gubunOnOff" value="on" id="gubunOnOff1" <%= rowMap.getString("gubunOnOff").equals("on") ? "checked" : "" %>>
									<label for="gubunOnOff1">온라인 </label>
									<input type="radio" name="gubunOnOff" value="off" id="gubunOnOff2" <%= rowMap.getString("gubunOnOff").equals("off") ? "checked" : "" %>>
									<label for="gubunOnOff2">오프라인 </label>
								</td>
							</tr>
							<tr>
								<th>설문 실시 여부 </th>
								<td class="br0">
									<input type="radio" name="useYn" value="y" id="useY" <%= rowMap.getString("useYn").equals("y") ? "checked" : "" %>>
									<label for="useY">사용함 </label>
									<input type="radio" name="useYn" value="n" id="useN" <%= rowMap.getString("useYn").equals("n") ? "checked" : "" %>>
									<label for="useN">사용안함 </label>
								</td>
							</tr>
						</table>
						<!--//[e] 검색 -->
						<div class="space01"></div>

						<!-- 선택 과목 선택 -->
						<div class="selectset" id="sel_1" style='display:none'>
							<!--left-->
							<div class="leftboxset">
								<div class="tit">
									<h3 class="h3">
										<img src="../images/bullet004.gif">  선택 과목 선택 
									</h3>
								</div>
								<select multiple name='selectsubjLeftSelect' size='10' tabindex=1 style='width:100%; height:100px;' >
									<%= chioceSubjSelStr %>
								</select>

							</div>
							<!--//left-->

							<!--center-->
							<div class="btnset01">
								<input type="button" value="추가" onclick="moveToRight('pform','selectsubjLeftSelect','selectsubjRightSelect','on');" class="boardbtn1" /><br />
								<input type="button" value="제거" onclick="moveToLeft('pform','selectsubjLeftSelect','selectsubjRightSelect')" class="boardbtn1" />
							</div>
							<!--//center-->

							<!--right-->
							<div class="rightboxset" style="float:left;width:45%;">
								<div class="tit">
									<h3 class="h3">
										<img src="../images/bullet004.gif"> 추가된 선택과목 
									</h3>
								</div>
								<select multiple name='selectsubjRightSelect' size='10' tabindex=1 style='width:100%; height:100px;' >

									

								</select>
							</div>
							<!--//right-->
							
							<div class="space01"></div>
						</div>
						<!-- //선택 과목 선택 -->


						<!-- 일반 과목 선택 -->
						<div class="selectset" id=sel_2 style='display:none'>
							<!--left-->
							<div class="leftboxset">
								<div class="tit">
									<h3 class="h3">
										<img src="../images/bullet004.gif">  일반 과목 선택 
									</h3>
								</div>
								<select multiple name='commsubjLeftSelect' size='10' tabindex=1 style='width:100%; height:200px;' >

									<%= commSubjStr %>

								</select>

							</div>
							<!--//left-->

							<!--center-->
							<div class="btnset02">
								<input type="button" value="추가" onclick="moveToRight('pform','commsubjLeftSelect','commsubjRightSelect');" class="boardbtn1" /><br />
								<input type="button" value="제거" onclick="moveToLeft('pform','commsubjLeftSelect','commsubjRightSelect');" class="boardbtn1" />
							</div>
							<!--//center-->

							<!--right-->
							<div class="rightboxset" style="float:left;width:45%;">

								<div class="tit">
									<h3 class="h3">
										<img src="../images/bullet004.gif">  추가된 선택과목
									</h3>
								</div>

								<select multiple name='commsubjRightSelect' size='10' tabindex=1 style='width:100%; height:200px;' >

									<%= commSubjStr %>

								</select>

								<div class="btn">
									<input type="button" value="맨위로" onclick="moveVertically('T','pform','commsubjLeftSelect','commsubjRightSelect')" class="boardbtn1" />
									<input type="button" value="위로" onclick="moveVertically('U','pform', 'commsubjLeftSelect','commsubjRightSelect')" class="boardbtn1" />
									<input type="button" value="아래로" onclick="moveVertically('D','pform', 'commsubjLeftSelect','commsubjRightSelect')" class="boardbtn1" />
									<input type="button" value="맨아래로" onclick="moveVertically('B','pform', 'commsubjLeftSelect','commsubjRightSelect');" class="boardbtn1" />
								</div>
							</div>
							<!--//right-->
							
							<div class="space01"></div>
						</div>
						<!-- //일반 과목 선택 -->


						<!-- 작성된 설문 필수항목 목록  -->
						<div class="selectset" id=sel_3 style='display:none'>
							<!--left-->
							<div class="leftboxset">
								<div class="tit">
									<h3 class="h3">
										<img src="../images/bullet004.gif">  작성된 설문 필수항목 목록  
									</h3>
								</div>
								<select multiple name='leftSelect' size='10' tabindex=1 style='width:100%; height:100px;' >
									<%= needPollStr %>
								</select>
							</div>
							<!--//left-->

							<!--center-->
							<div class="btnset01">
								<!-- input type="button" value="추가" onclick="alert('필수 항목입니다');return false;" class="boardbtn1" /><br />
								<input type="button" value="제거" onclick="alert('필수 항목입니다');return false;" class="boardbtn1" / -->
								<input type="button" value="추가" onclick="moveToRight('pform','leftSelect','rightSelect')" class="boardbtn1" /><br />
								<input type="button" value="제거" onclick="moveToLeft('pform','leftSelect','rightSelect')" class="boardbtn1" />
							</div>
							<!--//center-->

							<!--right-->
							<div class="rightboxset" style="float:left;width:45%;">
								<div class="tit">
									<h3 class="h3">
										<img src="../images/bullet004.gif"> 선택된 필수입력 사항
									</h3>
								</div>
								<select multiple name='rightSelect' size='10' tabindex=1 style='width:100%; height:100px;' >
									<%
										if (!rowMap.getString("questionCommGubun").equals("4")){
											out.print(needPollStr);
										}
									%>
								</select>
								<div class="btn">
									<input type="button" value="맨위로" onclick="moveVertically('T','pform','leftSelect','rightSelect');" class="boardbtn1" />
									<input type="button" value="위로"	onclick="moveVertically('U','pform','leftSelect','rightSelect');" class="boardbtn1" />
									<input type="button" value="아래로" onclick="moveVertically('D','pform','leftSelect','rightSelect');" class="boardbtn1" />
									<input type="button" value="맨아래로" onclick="moveVertically('B','pform','leftSelect','rightSelect');" class="boardbtn1" />
								</div>
							</div>
							<!--//right-->
							
							<div class="space01"></div>
						</div>
						<!-- //작성된 설문 필수항목 목록  -->


						<!-- 작성된 설문 공통항목 목록  -->
						<div class="selectset" id=sel_4 style='display:none'>
							<!--left-->
							<div class="leftboxset">
								<div class="tit">
									<h3 class="h3">
										<img src="../images/bullet004.gif">  작성된 설문 공통항목 목록  
									</h3>
								</div>
								<select multiple name='leftSelect1' size='10' tabindex=1 style='width:100%; height:200px;' ondblclick="moveToRight('pform','leftSelect1','rightSelect1');">
									<%= commPollStr %>
								</select>
							</div>
							<!--//left-->

							<!--center-->
							<div class="btnset02">
								<input type="button" value="추가" onclick="moveToRight('pform','leftSelect1','rightSelect1')" class="boardbtn1" /><br />
								<input type="button" value="제거" onclick="moveToLeft('pform','leftSelect1','rightSelect1')" class="boardbtn1" />
							</div>
							<!--//center-->

							<!--right-->
							<div class="rightboxset" style="float:left;width:45%;">
								<div class="tit">
									<h3 class="h3">
										<img src="../images/bullet004.gif">  선택된 공통설문항목 편집
									</h3>
								</div>

								<select multiple name='rightSelect1' size='10' tabindex=1 style='width:100%; height:200px;' ondblclick="moveToLeft('pform','leftSelect1','rightSelect1');">
								<%
										if (rowMap.getString("questionCommGubun").equals("4")){
											out.print(commPollStr);
										}
								 %>
								</select>

								<div class="btn">
									<input type="button" value="맨위로" onclick="moveVertically('T','pform','leftSelect1','rightSelect1');" class="boardbtn1" />
									<input type="button" value="위로" onclick="moveVertically('U','pform','leftSelect1','rightSelect1');" class="boardbtn1" />
									<input type="button" value="아래로" onclick="moveVertically('D','pform','leftSelect1','rightSelect1');" class="boardbtn1" />
									<input type="button" value="맨아래로" onclick="moveVertically('B','pform','leftSelect1','rightSelect1');" class="boardbtn1" />
								</div>
							</div>
							<!--//right-->
							
							<div class="space01"></div>
						</div>
						<!-- //작성된 설문 공통항목 목록  -->


						<!-- 작성된 설문 과목항목 목록  -->
						<div class="selectset" id=sel_5 style='display:none'>
							<!--left-->
							<div class="leftboxset">
								<div class="tit">
									<h3 class="h3">
										<img src="../images/bullet004.gif"> 작성된 설문 과목항목 목록   
									</h3>
								</div>
								<select multiple name='leftSelect2' size='10' tabindex=1 style='width:100%; height:100px;' ondblclick="moveToRight('pform','leftSelect2','rightSelect2');">
									<%= subjPollStr %>
								</select>
							</div>
							<!--//left-->

							<!--center-->
							<div class="btnset01">
								<input type="button" value="추가" onclick="moveToRight('pform','leftSelect2','rightSelect2');" class="boardbtn1" /><br />
								<input type="button" value="제거" onclick="moveToLeft('pform','leftSelect2','rightSelect2');" class="boardbtn1" />
							</div>
							<!--//center-->

							<!--right-->
							<div class="rightboxset" style="float:left;width:45%;">
								<div class="tit">
									<h3 class="h3">
										<img src="../images/bullet004.gif"> 선택된 과목설문 항목 편집
									</h3>
								</div>

								<select multiple name='rightSelect2' size='10' tabindex=5 style='width:100%; height:100px;' ondblclick="moveToLeft('pform','leftSelect2','rightSelect2');">
									<%= subjPollStr %>
								</select>

								<div class="btn">
									<input type="button" value="맨위로" onclick="moveVertically('T','pform','leftSelect2','rightSelect2');" class="boardbtn1" />
									<input type="button" value="위로" onclick="moveVertically('U','pform','leftSelect2','rightSelect2');" class="boardbtn1" />
									<input type="button" value="아래로" onclick="moveVertically('D','pform','leftSelect2','rightSelect2');" class="boardbtn1" />
									<input type="button" value="맨아래로" onclick="moveVertically('B','pform','leftSelect2','rightSelect2');" class="boardbtn1" />
								</div>
							</div>
							<!--//right-->
							
							<div class="space01"></div>
						</div>
						<!-- //작성된 설문 과목항목 목록   -->


						<div class="gray_tline"></div>

						<!-- 버튼  -->
						<table class="btn01" id=sel_6 style='display:none'>
							<tr>
								<td class="center">
									<input type="button" value="설문설정 및 세트구성 완료" onclick="go_setPoll();" class="boardbtn1" title="설문설정 및 세트정보까지 등록합니다." />
									<input type="button" value="설문설정 완료" onclick="go_onlyPoll();" class='boardbtn1' title="설문설정만 등록합니다." />
									<input type="button" value="리스트" onclick="go_list();" class='boardbtn1' title="설문지관리 리스트로 이동" />
								</td>
							</tr>
						</table>
						<table class="btn01" id=sel_7>
							<tr>
								<td class="left">
									<input type="button" value="설문 설정 완료" onclick="go_onlyPoll();" class="boardbtn1" />
									<% if(requestMap.getString("qu").equals("update")){ %>
										<input type="button" value="설문 세트 구성하기" onclick="go_setDivView();" class='boardbtn1' />
									<% } %>
									<input type="button" value="리스트" onclick="go_list();" class='boardbtn1' />
								</td>
							</tr>
						</table>
						<!-- //버튼  -->
						<div class="space01"></div>

						<!-- subTitle -->
						<h3 class="h3">
							<img src="../images/bullet004.gif"> 작성된 설문 세트
						</h3>
						<!--// subTitle -->
						<div class="h5"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>세트번호</th>
								<th>선택된과목</th>
								<th>강사설문</th>
								<th>전체분석출력</th>
								<th>공통설문인쇄</th>
								<th>인터넷 설문</th>
								<th>설문분석</th>
								<th class="br0">삭제</th>
							</tr>
							</thead>

							<tbody>
							<%= setListStr.toString() %>
							</tbody>
						</table>
						<!--//리스트  -->

						<!--//[e] 리스트  -->



					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>

<!--[ 코딩 끝 ] ------------------------------------------------------------------------------------------------------>


        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>

<script language="JavaScript">
//AI Report
document.write(tagAIGeneratorOcx);
</script>

</body>

