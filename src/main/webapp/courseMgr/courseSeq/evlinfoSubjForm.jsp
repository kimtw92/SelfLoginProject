<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정기수관리 리스트.
// date : 2008-06-10
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

	DataMap evlinfoSubjList = (DataMap) request.getAttribute("evlinfoSubjList");
	evlinfoSubjList.setNullToInitialize(true);
	
	DataMap examM = (DataMap) request.getAttribute("examM");
	examM.setNullToInitialize(true);
	
	DataMap examUnit = (DataMap) request.getAttribute("examUnit");
	examUnit.setNullToInitialize(true);
	
	DataMap examSubject = (DataMap) request.getAttribute("examSubject");
	examSubject.setNullToInitialize(true);
	
	DataMap questionCount = (DataMap) request.getAttribute("questionCount");
	questionCount.setNullToInitialize(true);
	
	DataMap examPaper = (DataMap) request.getAttribute("examPaper");
	examPaper.setNullToInitialize(true);
	
	String mode = requestMap.getString("mode");
	int examMInx = 0;
	String idExam = requestMap.getString("idExam");
	if (idExam.equals("")) {
		idExam = examM.getString("idExam", 0);
	} else {
		for(int i=0; i<examM.keySize("idExam"); i++) {
			if (idExam.equals(examM.getString("idExam",i))) {
				examMInx = i;
				break;
			}
		}
	}
	
	String idSubject = "";
	String title = "";
	String examStart1Date = "";
	String examStart1Time = "";
	String examEnd1Date = "";
	String examEnd1Time = "";
	int limittime = 0;
	String qcntperpage = "";
	if (!mode.equals("newExam")) {
		title = examM.getString("title", examMInx);
		idSubject = examSubject.getString("idSubject");
		examStart1Date = examM.getString("examStart1Date", examMInx);
		examStart1Time = examM.getString("examStart1Time", examMInx);
		examEnd1Date = examM.getString("examEnd1Date", examMInx);
		examEnd1Time = examM.getString("examEnd1Time", examMInx);
		limittime = examSubject.getInt("limittime");
		qcntperpage = examUnit.getString("qcntperpage");
	} else {
		idExam = "";
	}
	
	int oxCnt = 0, choiceCnt = 0, multiAnsCnt = 0;
	int shortAnsCnt = 0, essayCnt = 0;
	String oxDisabled = "", oxReadOnly = "", oxBgColor = "";
	String choiceDisabled = "", choiceReadOnly = "", choiceBgColor = "";
	String multiAnsDisabled = "", multiAnsReadOnly = "", multiAnsBgColor = "";
	String shortAnsDisabled = "", shortAnsReadOnly = "", shortAnsBgColor = "";
	String essayDisabled = "", essayReadOnly = "", essayBgColor = "";
	
	if (questionCount.keySize("idQtype") > 0) {
		for(int i=0; i<=questionCount.keySize("idQtype"); i++) {
			switch (questionCount.getInt("idQtype", i)) {
			case 1:
				oxCnt = questionCount.getInt("qcnt", i);
				break;
			case 2:
				choiceCnt = questionCount.getInt("qcnt", i);
				break;
			case 3:
				multiAnsCnt = questionCount.getInt("qcnt", i);
				break;
			case 4:
				shortAnsCnt = questionCount.getInt("qcnt", i);
				break;
			case 5:
				essayCnt = questionCount.getInt("qcnt", i);
				break;
				default:
					break;
			}
		}
	}
	
	if (oxCnt == 0) {
		oxDisabled = "disabled";
		oxReadOnly = "readonly='readonly'";
		oxBgColor = "background:lightgray;";
	}
	if (choiceCnt == 0) {
		choiceDisabled = "disabled";
		choiceReadOnly = "readonly='readonly'";
		choiceBgColor = "background:lightgray;";
	}
	if (multiAnsCnt == 0) {
		multiAnsDisabled = "disabled";
		multiAnsReadOnly = "readonly='readonly'";
		multiAnsBgColor = "background:lightgray;";
	}
	if (shortAnsCnt == 0) {
		shortAnsDisabled = "disabled";
		shortAnsReadOnly = "readonly='readonly'";
		shortAnsBgColor = "background:lightgray;";
	}
	if (essayCnt == 0) {
		essayDisabled = "disabled";
		essayReadOnly = "readonly='readonly'";
		essayBgColor = "background:lightgray;";
	}
	if (evlinfoSubjList.getInt("juQuestionCnt") <= 0) {
		shortAnsDisabled = "disabled";
		shortAnsReadOnly = "readonly='readonly'";
		shortAnsBgColor = "background:lightgray;";
		
		essayDisabled = "disabled";
		essayReadOnly = "readonly='readonly'";
		essayBgColor = "background:lightgray;";
	}
	if (evlinfoSubjList.getInt("gakQuestionCnt") <= 0) {
		oxDisabled = "disabled";
		oxReadOnly = "readonly='readonly'";
		oxBgColor = "background:lightgray;";
	
		choiceDisabled = "disabled";
		choiceReadOnly = "readonly='readonly'";
		choiceBgColor = "background:lightgray;";
	
		multiAnsDisabled = "disabled";
		multiAnsReadOnly = "readonly='readonly'";
		multiAnsBgColor = "background:lightgray;";
	}
	
	String omr = "";
	String online = "";
	if (examM.getString("onoffType", examMInx).equals("M")) {
		omr = "checked";
	} else {
		online = "checked";
	}
	
	int examSetCount = 0;
	if (!mode.equals("newExam")) {
		examSetCount = examSubject.getInt("setcount");
	}
	StringBuffer sbPreviewPaper = new StringBuffer();
	sbPreviewPaper.append("");
	String sBtnEnable = "";
	if (examSetCount > 0) {
		for(int i=1; i<=examSetCount; i++) {
			sbPreviewPaper.append("<input type='button' id='bntPreviewPaper").append(String.valueOf(i)).append("' name='bntPreviewPaper").append(String.valueOf(i)).append("' value=' ").append(String.valueOf(i)).append(" ' onclick=\"fnPreviewExam('").append(String.valueOf(i)).append("');\">");
		}
		if (examM.getString("ynEnable", examMInx).equals("Y")) {
			sBtnEnable = "<input type='button' id='btnYNEnable' name='btnYNEnable' value='시험 불가능 상태로 만들기' onclick='fnYNEnable(\"N\");'>";
		} else {
			sBtnEnable = "<input type='button' id='btnYNEnable' name='btnYNEnable' value='시험 가능 상태로 만들기' onclick='fnYNEnable(\"Y\");'>";
		}
	}
	
	String hasAns = "";
	if (examM.getInt("ansCnt",examMInx) > 0 && !mode.equals("newExam")) {
		hasAns = "style=\"display:none;\"";
	}
	
	StringBuffer sbListHtml = new StringBuffer();
	sbListHtml.append("");
	if (examM.keySize("idExam") > 0) {
		for(int i=0; i<examM.keySize("idExam"); i++) {
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\"><a href=\"javascript:fnView('").append(examM.getString("idExam", i)).append("');\">").append(examM.getString("idExam", i)).append("</a></td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">").append(examM.getString("title", i)).append("</td>");
			sbListHtml.append("</tr>");
		}
	} else {
		sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
		sbListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">생성된 시험이 없습니다.</td>");		
		sbListHtml.append("</tr>");
	}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

function fnInit() {
	var param = "";
	param = param + "?commGrcode="+$("grcode").value;
	param = param + "&commGrseq="+$("grseq").value;
	pform.action = "/courseMgr/courseSeq.do"+param;
	pform.submit();
}

function fnList() {
	$("mode").value = "list";
	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();
}

function fnSave() {
	if (fnCheck()) {
		$("mode").value = "saveExamInfo";
		pform.action = "/courseMgr/courseSeq.do";
		pform.submit();
	}
}

function fnCheck() {
	if ($("title").value == "") {
		alert("시험제목을 입력해야 합니다.");
		$("title").focus();
		return false;
	}
	
	if ($("examStart1Date").value == "") {
		alert("응시 기간을 입력해야 합니다.");
		$("examStart1Date").focus();
		return fasle;
	}
	
	if ($("examEnd1Date").value == "") {
		alert("응시 기간을 입력해야 합니다.");
		$("examEnd1Date").focus();
		return fasle;
	}
	
	var qCnt = Number($("juQuestionCnt").value) + Number($("gakQuestionCnt").value);
	
	if (!(Number($("totalCnt").value) == qCnt)) {
		alert("입력한 문항 수("+$("totalCnt").value+")와 출제문항 수("+qCnt+")가 동일하지 않습니다.");
		return false;
	}
	
	return true;
}

function fnPreviewExam(nrSet) {
	var mode = "previewExam";
	var idExam = $("idExam").value;
	var idSubject = $("idSubject").value;
	var url = "/courseMgr/courseSeq.do?mode=" + mode + "&idExam=" + idExam + "&idSubject=" + idSubject + "&nrSet=" + nrSet;

	popWin(url, "previewExam", "600", "400", "1", "");
}

function fnPopupCalendar(frm, obj){
	// 현재 obj에 있는 날짜
	var oDate = $F(obj);

	result = window.showModalDialog("/commonInc/jsp/calendar.jsp?oDate="+oDate, "calendar", "dialogWidth:256px; dialogHeight:280px; center:yes; status:no;");

	if (result == -1 || result == null || result == ""){
		return;
	}
	
	if(result == "delete"){
		result = "";
	}
    // alert(result.length);
	//if(result.length == 8){
	//	result = result.substring(0,4)+'-'+result.substring(4,6)+'-'+ result.substring(6,8);
	//}
	// alert(result);
	try{
		eval(frm+"."+obj+".value = '"+result+"';");		
	}catch(e){
		$(obj).value = result;
	}

}

function fnYNEnable(yn) {
	var param = "?ynEnable=" + yn;
	$("mode").value = "updateYnEnable";
	pform.action = "/courseMgr/courseSeq.do" + param;
	pform.submit();
}

function fnNewExam() {
	$("mode").value = "newExam";
	var param = "";
	param = param + "?commGrcode="+$("grcode").value;
	param = param + "&commGrseq="+$("grseq").value;
	pform.action = "/courseMgr/courseSeq.do"+param;
	pform.submit();
}

function fnAllChk(objname){
	var obj = document.getElementsByName(objname);
	for(var i=0; i<obj.length; i++) {
		obj[i].checked = !(obj[i].checked);
	}
}

function fnDelete() {
	$("mode").value = "deleteExam";
	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();
}

function fnView(idExam) {
	var param = "";
	param = param + "?" + "idExam=" + idExam;
	param = param + "&" + "commGrcode=" + $("grcode").value;
	param = param + "&" + "commGrseq=" + $("grseq").value;
	
	pform.action = "/courseMgr/courseSeq.do"+param;
	pform.submit();
}

function buildOptionSetcount(cnt){
	var selectObj = document.getElementById('selExamCount');
	selectObj.options.length = 0;

	for(var i=1; i<=cnt; i++){
		var opt = document.createElement('option');
		opt.text = i;
		opt.value = i;
		selectObj.options.add(opt);
	}
	
	selectObj.selectedIndex = Number($("examSetCount").value) - 1;	
}

function onclick_radio_onOff(radio){
	switch(radio.value){
	case 'M':
		buildOptionSetcount(3);
		break;
	case 'O':
		buildOptionSetcount(10);
		break;
	}
}

function sumScore(){
	var oxCnt = document.getElementById("oxCnt");
	var choiceCnt = document.getElementById("choiceCnt");
	var multiAnsCnt = document.getElementById("multiAnsCnt");
	var shortAnsCnt = document.getElementById("shortAnsCnt");
	var essayCnt = document.getElementById("essayCnt");
	var totalCnt = document.getElementById("totalCnt");
	
	var oxWeight = document.getElementById("oxWeight");
	var choiceWeight = document.getElementById("choiceWeight");
	var multiAnsWeight = document.getElementById("multiAnsWeight");
	var shortAnsWeight = document.getElementById("shortAnsWeight");
	var essayWeight = document.getElementById("essayWeight");
	
	var oxCalc = document.getElementById("oxCalc");
	var choiceCalc = document.getElementById("choiceCalc");
	var multiAnsCalc = document.getElementById("multiAnsCalc");
	var shortAnsCalc = document.getElementById("shortAnsCalc");
	var essayCalc = document.getElementById("essayCalc");
	var totalCalc = document.getElementById("totalCalc");
	
	calc(oxCnt, oxWeight, oxCalc, '*');
	calc(choiceCnt, choiceWeight, choiceCalc, '*');
	calc(multiAnsCnt, multiAnsWeight, multiAnsCalc, '*');
	calc(shortAnsCnt, shortAnsWeight, shortAnsCalc, '*');
	calc(essayCnt, essayWeight, essayCalc, '*');
	
	totalCnt.value = 0;
	totalCalc.value = 0;
	calc(oxCnt, totalCnt, totalCnt, '+');
	calc(choiceCnt, totalCnt, totalCnt, '+');
	calc(multiAnsCnt, totalCnt, totalCnt, '+');
	calc(shortAnsCnt, totalCnt, totalCnt, '+');
	calc(essayCnt, totalCnt, totalCnt, '+');
	
	calc(oxCalc, totalCalc, totalCalc, '+');
	calc(choiceCalc, totalCalc, totalCalc, '+');
	calc(multiAnsCalc, totalCalc, totalCalc, '+');
	calc(shortAnsCalc, totalCalc, totalCalc, '+');
	calc(essayCalc, totalCalc, totalCalc, '+');
	
	var juQuestionCnt = document.getElementById("juQuestionCnt");
	var gakQuestionCnt = document.getElementById("gakQuestionCnt");
	var qCnt = Number(juQuestionCnt.value) + Number(gakQuestionCnt.value);
	if (Number(totalCnt.value) > qCnt) {
		alert("입력한 문항 수("+totalCnt.value+")가 출제문항 수("+qCnt+")보다 많습니다.");
	}
}

function calc(a, b, r, y){
	switch (y) {
	case '+':
		r.value = +a.value+(+b.value);
		break;
	case '*':
		r.value = +a.value*(+b.value);
		break;

	default:
		break;
	}
}

window.onload = function(){
	if ($("onoffM").checked) {
		onclick_radio_onOff($("onoffM"));
	} else {
		onclick_radio_onOff($("onoffO"));
	}
	sumScore();
}
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"		value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"		value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="grcode"		value="<%=requestMap.getString("grcode")%>">
<input type="hidden" name="grseq"		value="<%=evlinfoSubjList.getString("grseq")%>">
<input type="hidden" name="subj"		value="<%=requestMap.getString("subj")%>">
<input type="hidden" name="year"		value="<%=requestMap.getString("year")%>">
<input type="hidden" name="ptype"		value="<%=requestMap.getString("ptype")%>">
<input type="hidden" name="cboAuth"		value="<%=requestMap.getString("cboAuth")%>">
<input type="hidden" name="qu"			value="<%=requestMap.getString("qu")%>">

<input type="hidden" name="idExam"	value="<%=idExam%>">
<input type="hidden" name="idSubject"	value="<%=idSubject%>">
<input type="hidden" name="examSetCount" value="<%=examSetCount%>">

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
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsTable">
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
						<!--[s] 폼 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr bgcolor="#FFFFFF" height="28">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">과목명</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10"><%=evlinfoSubjList.getString("lecnm") %></td>
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">시험제목</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input name="title" type="text" value="<%=title %>" class="textfield" style="width: 300px;">
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									평가정보
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<%=evlinfoSubjList.getString("ptypenm") %>
									/
									<%=evlinfoSubjList.getString("questionCnt") %> 문항
									/
									<%=evlinfoSubjList.getString("totalScore") %> 점
								</td>
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									OMR / ONLINE
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<label><input name="onoff" id="onoffM" type="radio" value="M" onclick="onclick_radio_onOff(this)" <%=omr %>> OMR</label>
									<label><input name="onoff" id="onoffO" type="radio" value="O" onclick="onclick_radio_onOff(this)" <%=online %>> ONLINE</label>
								</td>
							</tr>
							<tr height="28" bgcolor="#FFFFFF">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									응시 기간
								</th>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">
									<input name="examStart1Date" type="text" class="textfield" value="<%=examStart1Date %>" style="width:60; text-align: center;">
									&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'examStart1Date');" style="cursor:hand;">
									YYYYMMDD
									<input name="examStart1Time" type="time" class="textfield" value="<%=examStart1Time.equals("") ? "000001" : examStart1Time %>" style="width:60; text-align: center;">
									HHMMSS 부터,
									<input name="examEnd1Date" type="text" class="textfield" value="<%=examEnd1Date %>" style="width:60; text-align: center;">
									&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'examEnd1Date');" style="cursor:hand;">
									YYYYMMDD
									<input name="examEnd1Time" type="time" class="textfield" value="<%=examEnd1Time.equals("") ? "235959" : examEnd1Time %>" style="width:60; text-align: center;">
									HHMMSS 까지
								</td>
							</tr>
							<tr height="28" bgcolor="#FFFFFF">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									제한시간
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input name="limittime" type="number" class="textfield" value="<%=limittime / 60%>" style="width:150px;"> 분
								</td>
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									페이지당  출력문항
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<label><input name="qcntperpage" value="1" type="radio" <%=qcntperpage.equals("1") ? "checked" : ""%>> 1</label>
									<label><input name="qcntperpage" value="3" type="radio" <%=qcntperpage.equals("3") ? "checked" : ""%>> 3</label>
									<label><input name="qcntperpage" value="5" type="radio" <%=qcntperpage.equals("5") ? "checked" : ""%>> 5</label>
									<label><input name="qcntperpage" value="10" type="radio" <%=qcntperpage.equals("10") ? "checked" : ""%>> 10</label>
								</td>
							</tr>
							<tr height="28" bgcolor="#FFFFFF">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									평가항목정보
								</th>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">
								<input type="hidden" id="juQuestionCnt" name="juQuestionCnt" value="<%=evlinfoSubjList.getInt("juQuestionCnt") %>" />
								<input type="hidden" id="juWeight" name="juWeight" value="<%=evlinfoSubjList.getInt("juWeight") %>" />
								<input type="hidden" id="gakQuestionCnt" name="gakQuestionCnt" value="<%=evlinfoSubjList.getInt("gakQuestionCnt") %>" />
								<input type="hidden" id="gakWeight" name="gakWeight" value="<%=evlinfoSubjList.getInt("gakWeight") %>" />
									출제문항 수 :  주관식 - <%=evlinfoSubjList.getInt("juQuestionCnt") %>문항,  문제당 배점 : <%=evlinfoSubjList.getString("juWeight") %>점
														/ 객관식 - <%=evlinfoSubjList.getInt("gakQuestionCnt") %>문항,  문제당 배점 : <%=evlinfoSubjList.getString("gakWeight") %>점
								</td>
							</tr>
							<tr height="28" bgcolor="#FFFFFF">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									평가구성
								</th>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">
									<table>
										<tr>
											<td><input name="qtype[]" value="1" type="checkbox" <%=oxDisabled %> <%=oxCnt > 0 ? "checked" : "" %>> OX형(<%=oxCnt %>),</td>
											<td align="right">출제문항 :</td>
											<td><input name="oxCnt" id="oxCnt" type="number" class="textfield"  style="width:30;text-align:right;<%=oxBgColor %>" <%=oxReadOnly %> value="<%=examSubject.getInt("oxCnt") %>" onkeyup="sumScore();"></td>
											<td>X 배점</td>
											<td><input name="oxWeight" id="oxWeight" type="number" class="textfield"  style="width:30;text-align:right;background:lightgray;" readonly="readonly" value="<%=evlinfoSubjList.getString("gakWeight") %>"></td>
											<td>:</td>
											<td><input name="oxCalc" id="oxCalc" type="number" class="textfield"  style="width:30;text-align:right;background:lightgray;" readonly="readonly"></td>
										</tr>
										<tr>
											<td><input name="qtype[]" value="2" type="checkbox" <%=choiceDisabled %> <%=choiceCnt > 0 ? "checked" : "" %>> 선다형(<%=choiceCnt %>),</td>
											<td align="right">출제문항 :</td>
											<td><input name="choiceCnt" id="choiceCnt" type="number" class="textfield"  style="width:30;text-align:right;<%=choiceBgColor %>" <%=choiceReadOnly %> value="<%=examSubject.getInt("choiceCnt") %>" onkeyup="sumScore();"></td>
											<td>X 배점</td>
											<td><input name="choiceWeight" id="choiceWeight" type="number" class="textfield"  style="width:30;text-align:right;background:lightgray;" readonly="readonly" value="<%=evlinfoSubjList.getString("gakWeight") %>"></td>
											<td>:</td>
											<td><input name="choiceCalc" id="choiceCalc" type="number" class="textfield"  style="width:30;text-align:right;background:lightgray;" readonly="readonly"></td>
										</tr>
										<tr>
											<td><input name="qtype[]" value="3" type="checkbox" <%=multiAnsDisabled %> <%=multiAnsCnt > 0 ? "checked" : "" %>> 복수 답안형(<%=multiAnsCnt %>),</td>
											<td align="right">출제문항 :</td>
											<td><input name="multiAnsCnt" id="multiAnsCnt" type="number" class="textfield"  style="width:30;text-align:right;<%=multiAnsBgColor %>" <%=multiAnsReadOnly %> value="<%=examSubject.getInt("multiAnsCnt") %>" onkeyup="sumScore();"></td>
											<td>X 배점</td>
											<td><input name="multiAnsWeight" id="multiAnsWeight" type="number" class="textfield"  style="width:30;text-align:right;background:lightgray;" readonly="readonly" value="<%=evlinfoSubjList.getString("gakWeight") %>"></td>
											<td>:</td>
											<td><input name="multiAnsCalc" id="multiAnsCalc" type="number" class="textfield"  style="width:30;text-align:right;background:lightgray;" readonly="readonly"></td>
										</tr>
										<tr>
											<td><input name="qtype[]" value="4" type="checkbox" <%=shortAnsDisabled %> <%=shortAnsCnt > 0 ? "checked" : "" %>> 단답형(<%=shortAnsCnt %>),</td>
											<td align="right">출제문항 :</td>
											<td><input name="shortAnsCnt" id="shortAnsCnt" type="number" class="textfield"  style="width:30;text-align:right;<%=shortAnsBgColor %>" <%=shortAnsReadOnly %> value="<%=examSubject.getInt("shortAnsCnt") %>" onkeyup="sumScore();"></td>
											<td>X 배점</td>
											<td><input name="shortAnsWeight" id="shortAnsWeight" type="number" class="textfield"  style="width:30;text-align:right;background:lightgray;" readonly="readonly" value="<%=evlinfoSubjList.getString("juWeight") %>"></td>
											<td>:</td>
											<td><input name="shortAnsCalc" id="shortAnsCalc" type="number" class="textfield"  style="width:30;text-align:right;background:lightgray;" readonly="readonly"></td>
										</tr>
										<tr>
											<td><input name="qtype[]" value="5" type="checkbox" <%=essayDisabled %> <%=essayCnt > 0 ? "checked" : "" %>> 논술형(<%=essayCnt %>),</td>
											<td align="right">출제문항 :</td>
											<td><input name="essayCnt" id="essayCnt" type="number" class="textfield"  style="width:30;text-align:right;<%=essayBgColor %>" <%=essayReadOnly %> value="<%=examSubject.getInt("essayCnt") %>" onkeyup="sumScore();"></td>
											<td>X 배점</td>
											<td><input name="essayWeight" id="essayWeight" type="number" class="textfield"  style="width:30;text-align:right;background:lightgray;" readonly="readonly" value="<%=evlinfoSubjList.getString("juWeight") %>"></td>
											<td>:</td>
											<td><input name="essayCalc" id="essayCalc" type="number" class="textfield"  style="width:30;text-align:right;background:lightgray;" readonly="readonly"></td>
										</tr>
										<tr>
											<td></td>
											<td align="right">총 출제문항 :</td>
											<td><input id="totalCnt" name="totalCnt" type="number" class="textfield" style="width:30;text-align:right;background:lightgray;" readonly="readonly"></td>
											<td></td>
											<td></td>
											<td></td>
											<td><input id="totalCalc" name="totalCalc" type="number" class="textfield" style="width:30;text-align:right;background:lightgray;" readonly="readonly"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr height="28" bgcolor="#FFFFFF">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									출제순서
								</th>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">
									<label><input name="idRandomtype" type="radio" checked="checked" value="YQ"> 순서섞기</label>
									<!-- label><input name="idRandomtype" type="radio" value="NN"> 문항고유번호</label -->
								</td>
							</tr>
							<tr height="28" bgcolor="#FFFFFF">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									시험지 수
								</th>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">
									<%=sbPreviewPaper.toString() %>
									<select id="selExamCount" name="selExamCount">
										<option>1</option>
										<option>2</option>
										<option>3</option>
									</select>
									<%=sBtnEnable %>
								</td>
							</tr>
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						
						<!--[s] 하단 버튼  -->
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="right">
									<input type="button" value="이전" onclick="fnList();" class="boardbtn1" >
									<input type="button" value="저장" onclick="fnSave();" class="boardbtn1" <%=hasAns%>>
									<input type="button" value="시험추가" onclick="fnNewExam();" class="boardbtn1" >
									<input type="button" value="시험삭제" onclick="fnDelete();" class="boardbtn1" <%=hasAns%>>
									<input type="button" value="초기화" onclick="fnInit();" class="boardbtn1" >
								</td>
							</tr>
							<tr><td height="5"></td></tr>
						</table>
						<!--[e] 하단 버튼  -->
                        
                        <!--[s] 리스트  -->
						<br><%=idExam %>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height='28' bgcolor="#5071B4">
								<td align="center" class="tableline11 white"><strong>ID_EXAM</strong></td>
								<td align="center" class="tableline11 white"><strong>시험제목</strong></td>
							</tr>
							
							<%= sbListHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>															
						<!--[e] 리스트  -->
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

