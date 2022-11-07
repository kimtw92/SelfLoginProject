<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 과목코드별 문항관리 문항 등록
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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);
	
	StringBuffer sbTmp = null;
	String subj = rowMap.getString("subj");
	String subjnm = rowMap.getString("subjnm");
	
	DataMap qRowMap = (DataMap)request.getAttribute("QUESTION_DATA");
	qRowMap.setNullToInitialize(true);
	String idQ = qRowMap.getString("idQ");
	
	String btnDeleteDisplay = " style='display:none' ";
	String disabled = "";
	String mode = "";
	if (!idQ.equals("")) {
		disabled = "disabled";
		mode = "sUpdate";
	} else {
		disabled = "";
		mode = "sInsert";
	}
	String[] aryUseYn = new String[2];
	
	aryUseYn[0] = "";
	aryUseYn[1] = "";
	
	if (qRowMap.getString("useYn").equals("Y")) {
		aryUseYn[0] = "checked";
	} else if (qRowMap.getString("useYn").equals("N")) {
		aryUseYn[1] = "checked";
	} else {
		aryUseYn[0] = "checked";
	}
	
	String[] aryDifficulty = new String[6];
	
	aryDifficulty[0] = "";
	aryDifficulty[1] = "";
	aryDifficulty[2] = "";
	aryDifficulty[3] = "";
	aryDifficulty[4] = "";
	aryDifficulty[5] = "";
	
	if (qRowMap.getString("idDifficulty1").equals("0")) {
		aryDifficulty[0] = "checked";
	} else if (qRowMap.getString("idDifficulty1").equals("1")) {
		aryDifficulty[1] = "checked";
	} else if (qRowMap.getString("idDifficulty1").equals("2")) {
		aryDifficulty[2] = "checked";
	} else if (qRowMap.getString("idDifficulty1").equals("3")) {
		aryDifficulty[3] = "checked";
	} else if (qRowMap.getString("idDifficulty1").equals("4")) {
		aryDifficulty[4] = "checked";
	} else if (qRowMap.getString("idDifficulty1").equals("5")) {
		aryDifficulty[5] = "checked";
	} else {
		aryDifficulty[0] = "checked";
	}
	
	String[] aryQType = new String[5];
	
	aryQType[0] = "";
	aryQType[1] = "";
	aryQType[2] = "";
	aryQType[3] = "";
	aryQType[4] = "";
	
	String q = qRowMap.getString("q");
	
	String[] aryExOX = new String[2];
	aryExOX[0] = "";
	aryExOX[1] = "";
	
	String ex21 = "";
	String ex22 = "";
	String ex23 = "";
	String ex24 = "";
	String ex25 = "";
	String ex31 = "";
	String ex32 = "";
	String ex33 = "";
	String ex34 = "";
	String ex35 = "";
	
	String ca4 = "";
	String ca5 = "";
	String explain = qRowMap.getString("explain");
	String hint = qRowMap.getString("hint");
	
	int qType = qRowMap.getInt("idQtype");
	int excount = qRowMap.getInt("excount");
	int cacount = qRowMap.getInt("cacount");
	
	String[] aryExcount2 = new String[4];
	aryExcount2[0] = "";
	aryExcount2[1] = "";
	aryExcount2[2] = "";
	aryExcount2[3] = "";
	
	String[] aryExcount3 = new String[4];
	aryExcount3[0] = "";
	aryExcount3[1] = "";
	aryExcount3[2] = "";
	aryExcount3[3] = "";
	
	String[] ca2 = new String[5];
	ca2[0] = "";
	ca2[1] = "";
	ca2[2] = "";
	ca2[3] = "";
	ca2[4] = "";
	
	String[] ca3 = new String[5];
	ca3[0] = "";
	ca3[1] = "";
	ca3[2] = "";
	ca3[3] = "";
	ca3[4] = "";
	
	String qfile = "";
	String xfile = "";
	String hfile = "";
	
	sbTmp = new StringBuffer();
	sbTmp.append("<a href=\"javascript:fnFileDown('q','").append(qRowMap.getString("qfile")).append("');\">").append(qRowMap.getString("qfile")).append("</a>&nbsp;");
	qfile = sbTmp.toString();
	sbTmp = new StringBuffer();
	sbTmp.append("<a href=\"javascript:fnFileDown('x','").append(qRowMap.getString("xfile")).append("');\">").append(qRowMap.getString("xfile")).append("</a>&nbsp;");
	xfile = sbTmp.toString();
	sbTmp = new StringBuffer();
	sbTmp.append("<a href=\"javascript:fnFileDown('h','").append(qRowMap.getString("hfile")).append("');\">").append(qRowMap.getString("hfile")).append("</a>&nbsp;");
	hfile = sbTmp.toString();
	
	String[] qFileType = new String[3];
	qFileType[0] = "";
	qFileType[1] = "";
	qFileType[2] = "";
	if (qRowMap.getString("qfileTp").equals("I")) {
		qFileType[0] = "checked";
	} else if (qRowMap.getString("qfileTp").equals("A")) {
		qFileType[1] = "checked";
	} else if (qRowMap.getString("qfileTp").equals("V")) {
		qFileType[2] = "checked";
	}
	
	String[] xFileType = new String[3];
	xFileType[0] = "";
	xFileType[1] = "";
	xFileType[2] = "";
	if (qRowMap.getString("xfileTp").equals("I")) {
		xFileType[0] = "checked";
	} else if (qRowMap.getString("xfileTp").equals("A")) {
		xFileType[1] = "checked";
	} else if (qRowMap.getString("xfileTp").equals("V")) {
		xFileType[2] = "checked";
	}
	
	String[] hFileType = new String[3];
	hFileType[0] = "";
	hFileType[1] = "";
	hFileType[2] = "";
	if (qRowMap.getString("hfileTp").equals("I")) {
		hFileType[0] = "checked";
	} else if (qRowMap.getString("hfileTp").equals("A")) {
		hFileType[1] = "checked";
	} else if (qRowMap.getString("hfileTp").equals("V")) {
		hFileType[2] = "checked";
	}
	
	String ex21file = "";
	String ex22file = "";
	String ex23file = "";
	String ex24file = "";
	String ex25file = "";
	String ex31file = "";
	String ex32file = "";
	String ex33file = "";
	String ex34file = "";
	String ex35file = "";
	String ex41file = "";
	String ex51file = "";
	
	String[] ex21FileType = new String[3];
	ex21FileType[0] = "";
	ex21FileType[1] = "";
	ex21FileType[2] = "";
	String[] ex22FileType = new String[3];
	ex22FileType[0] = "";
	ex22FileType[1] = "";
	ex22FileType[2] = "";
	String[] ex23FileType = new String[3];
	ex23FileType[0] = "";
	ex23FileType[1] = "";
	ex23FileType[2] = "";
	String[] ex24FileType = new String[3];
	ex24FileType[0] = "";
	ex24FileType[1] = "";
	ex24FileType[2] = "";
	String[] ex25FileType = new String[3];
	ex25FileType[0] = "";
	ex25FileType[1] = "";
	ex25FileType[2] = "";
	
	String[] ex31FileType = new String[3];
	ex31FileType[0] = "";
	ex31FileType[1] = "";
	ex31FileType[2] = "";
	String[] ex32FileType = new String[3];
	ex32FileType[0] = "";
	ex32FileType[1] = "";
	ex32FileType[2] = "";
	String[] ex33FileType = new String[3];
	ex33FileType[0] = "";
	ex33FileType[1] = "";
	ex33FileType[2] = "";
	String[] ex34FileType = new String[3];
	ex34FileType[0] = "";
	ex34FileType[1] = "";
	ex34FileType[2] = "";
	String[] ex35FileType = new String[3];
	ex35FileType[0] = "";
	ex35FileType[1] = "";
	ex35FileType[2] = "";
	
	String[] ex41FileType = new String[3];
	ex41FileType[0] = "";
	ex41FileType[1] = "";
	ex41FileType[2] = "";
	
	String[] ex51FileType = new String[3];
	ex51FileType[0] = "";
	ex51FileType[1] = "";
	ex51FileType[2] = "";
	
	if (qType == 1) {
		aryQType[0] = "checked";
		if (qRowMap.getString("ca").equals("O")) {
			aryExOX[0] = "checked";
		} else {
			aryExOX[1] = "checked";
		}
	} else if (qType == 2) {
		aryQType[1] = "checked";
		ex21 = qRowMap.getString("ex1");
		ex22 = qRowMap.getString("ex2");
		ex23 = qRowMap.getString("ex3");
		ex24 = qRowMap.getString("ex4");
		ex25 = qRowMap.getString("ex5");
		aryExcount2[excount-2] = "checked";
		ca2[qRowMap.getInt("ca")-1] = "checked";
		
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex1','").append(qRowMap.getString("ex1file")).append("');\">").append(qRowMap.getString("ex1file")).append("</a>&nbsp;");
		ex21file = sbTmp.toString();
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex2','").append(qRowMap.getString("ex2file")).append("');\">").append(qRowMap.getString("ex2file")).append("</a>&nbsp;");
		ex22file = sbTmp.toString();
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex3','").append(qRowMap.getString("ex3file")).append("');\">").append(qRowMap.getString("ex3file")).append("</a>&nbsp;");
		ex23file = sbTmp.toString();
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex4','").append(qRowMap.getString("ex4file")).append("');\">").append(qRowMap.getString("ex4file")).append("</a>&nbsp;");
		ex24file = sbTmp.toString();
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex5','").append(qRowMap.getString("ex5file")).append("');\">").append(qRowMap.getString("ex5file")).append("</a>&nbsp;");
		ex25file = sbTmp.toString();
		if (qRowMap.getString("ex1fileTp").equals("I")) {
			ex21FileType[0] = "checked";
		} else if (qRowMap.getString("ex1fileTp").equals("A")) {
			ex21FileType[1] = "checked";
		} else if (qRowMap.getString("ex1fileTp").equals("V")) {
			ex21FileType[2] = "checked";
		}
		if (qRowMap.getString("ex2fileTp").equals("I")) {
			ex22FileType[0] = "checked";
		} else if (qRowMap.getString("ex2fileTp").equals("A")) {
			ex22FileType[1] = "checked";
		} else if (qRowMap.getString("ex2fileTp").equals("V")) {
			ex22FileType[2] = "checked";
		}
		if (qRowMap.getString("ex3fileTp").equals("I")) {
			ex23FileType[0] = "checked";
		} else if (qRowMap.getString("ex3fileTp").equals("A")) {
			ex23FileType[1] = "checked";
		} else if (qRowMap.getString("ex3fileTp").equals("V")) {
			ex23FileType[2] = "checked";
		}
		if (qRowMap.getString("ex4fileTp").equals("I")) {
			ex24FileType[0] = "checked";
		} else if (qRowMap.getString("ex4fileTp").equals("A")) {
			ex24FileType[1] = "checked";
		} else if (qRowMap.getString("ex4fileTp").equals("V")) {
			ex24FileType[2] = "checked";
		}
		if (qRowMap.getString("ex5fileTp").equals("I")) {
			ex25FileType[0] = "checked";
		} else if (qRowMap.getString("ex5fileTp").equals("A")) {
			ex25FileType[1] = "checked";
		} else if (qRowMap.getString("ex5fileTp").equals("V")) {
			ex25FileType[2] = "checked";
		}
	} else if (qType == 3) {
		aryQType[2] = "checked";
		ex31 = qRowMap.getString("ex1");
		ex32 = qRowMap.getString("ex2");
		ex33 = qRowMap.getString("ex3");
		ex34 = qRowMap.getString("ex4");
		ex35 = qRowMap.getString("ex5");
		aryExcount3[excount-2] = "checked";
		String ca = qRowMap.getString("ca");
		for(int i=0; i<ca.length(); i++) {
			char ch = ca.charAt(i);
			if (ch == '1' || ch == '2' || ch == '3' || ch == '4' || ch == '5') {
				ca3[Integer.parseInt(String.valueOf(ch))-1] = "checked='checked'";
			}
		}
		
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex1','").append(qRowMap.getString("ex1file")).append("');\">").append(qRowMap.getString("ex1file")).append("</a>&nbsp;");
		ex31file = sbTmp.toString();
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex2','").append(qRowMap.getString("ex2file")).append("');\">").append(qRowMap.getString("ex2file")).append("</a>&nbsp;");
		ex32file = sbTmp.toString();
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex3','").append(qRowMap.getString("ex3file")).append("');\">").append(qRowMap.getString("ex3file")).append("</a>&nbsp;");
		ex33file = sbTmp.toString();
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex4','").append(qRowMap.getString("ex4file")).append("');\">").append(qRowMap.getString("ex4file")).append("</a>&nbsp;");
		ex34file = sbTmp.toString();
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex5','").append(qRowMap.getString("ex5file")).append("');\">").append(qRowMap.getString("ex5file")).append("</a>&nbsp;");
		ex35file = sbTmp.toString();
		if (qRowMap.getString("ex1fileTp").equals("I")) {
			ex31FileType[0] = "checked";
		} else if (qRowMap.getString("ex1fileTp").equals("A")) {
			ex31FileType[1] = "checked";
		} else if (qRowMap.getString("ex1fileTp").equals("V")) {
			ex31FileType[2] = "checked";
		}
		if (qRowMap.getString("ex2fileTp").equals("I")) {
			ex32FileType[0] = "checked";
		} else if (qRowMap.getString("ex2fileTp").equals("A")) {
			ex32FileType[1] = "checked";
		} else if (qRowMap.getString("ex2fileTp").equals("V")) {
			ex32FileType[2] = "checked";
		}
		if (qRowMap.getString("ex3fileTp").equals("I")) {
			ex33FileType[0] = "checked";
		} else if (qRowMap.getString("ex3fileTp").equals("A")) {
			ex33FileType[1] = "checked";
		} else if (qRowMap.getString("ex3fileTp").equals("V")) {
			ex33FileType[2] = "checked";
		}
		if (qRowMap.getString("ex4fileTp").equals("I")) {
			ex34FileType[0] = "checked";
		} else if (qRowMap.getString("ex4fileTp").equals("A")) {
			ex34FileType[1] = "checked";
		} else if (qRowMap.getString("ex4fileTp").equals("V")) {
			ex34FileType[2] = "checked";
		}
		if (qRowMap.getString("ex5fileTp").equals("I")) {
			ex35FileType[0] = "checked";
		} else if (qRowMap.getString("ex5fileTp").equals("A")) {
			ex35FileType[1] = "checked";
		} else if (qRowMap.getString("ex5fileTp").equals("V")) {
			ex35FileType[2] = "checked";
		}
	} else if (qType == 4) {
		aryQType[3] = "checked";
		ca4 = qRowMap.getString("ca");
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex1','").append(qRowMap.getString("ex1file")).append("');\">").append(qRowMap.getString("ex1file")).append("</a>&nbsp;");
		ex41file = sbTmp.toString();
		if (qRowMap.getString("ex1fileTp").equals("I")) {
			ex41FileType[0] = "checked";
		} else if (qRowMap.getString("ex1fileTp").equals("A")) {
			ex41FileType[1] = "checked";
		} else if (qRowMap.getString("ex1fileTp").equals("V")) {
			ex41FileType[2] = "checked";
		}
	} else if (qType == 5) {
		aryQType[4] = "checked";
		ca5 = qRowMap.getString("ca");
		sbTmp = new StringBuffer();
		sbTmp.append("<a href=\"javascript:fnFileDown('ex1','").append(qRowMap.getString("ex1file")).append("');\">").append(qRowMap.getString("ex1file")).append("</a>&nbsp;");
		ex51file = sbTmp.toString();
		if (qRowMap.getString("ex1fileTp").equals("I")) {
			ex51FileType[0] = "checked";
		} else if (qRowMap.getString("ex1fileTp").equals("A")) {
			ex51FileType[1] = "checked";
		} else if (qRowMap.getString("ex1fileTp").equals("V")) {
			ex51FileType[2] = "checked";
		}
	} else {
		aryQType[1] = "checked";
		aryExcount2[3] = "checked";
	}
	
	System.out.println("qfile="+qfile);
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
function fnCheck() {
	var qType = 0;
	var ca = 0;
	if ($("question").value == "") {
		alert("문제를 입력하세요.");
		$("question").focus();
		return false;
	}
	
	qType = fnqTypeRadioCheck() + 1;
	if (qType == 1) {
		if ($("exOXO").checked == false && $("exOXX").checked == false) {
			alert("정답 체크를 하십시요!");
			$("exOXO").focus();
			return false;
		}
	} else if (qType == 2 || qType == 3) {
		for(var i=1; i<=fnExcountRadioCheck(qType); i++) {
			if ($("ex"+qType+""+i).value == "") {
				alert("보기 "+i+"번을 입력하지 않았습니다.");
				$("ex"+qType+""+i).focus();
				return false;
			}
		}
		
		ca = fnCaRadioCheck(qType);
		if (ca == 0) {
			alert("정답 체크를 하십시요!");
			$("ca"+qType+"1").focus();
			return false;
		}
	} else if (qType == 4 || qType == 5) {
		if ($("ca"+qType).value == "") {
			alert("정답을 입력하십시오!");
			$("ca"+qType).focus();
			return false;
		}
	}
	
	return true;
}

function fnqTypeRadioCheck() {
	for(var i=0; i<5; i++) {
		if ($("qType"+i).checked == true) {
			return i;
		}
	}
}

function fnCaRadioCheck(qType) {
	for(var i=1; i<=5; i++) {
		if ($("ca"+qType+i).checked == true) {
			return i;
		}
	}
	return 0;
}

function fnExcountRadioCheck(qType) {
	for(var i=2; i<=5; i++) {
		if ($("excount"+qType+i).checked == true) {
			return i;
		}
	}
	return 0;
}

function fnSave(mode) {
	if (fnCheck()) {
		var param = "";
		if (mode == 'sUpdate') {
			param = "&qType=";
			var inx = fnqTypeRadioCheck() + 1;
			param = param + inx;
		} else {
			param = "";
		}
		$("mode").value = mode;
		pform.action = "questionMgr.do?mode="+$("mode").value + param;
		pform.submit();
	}
}

function fnQuestionList(subj) {
	var param = "";
	param = param + "?mode=questionList";
	param = param + "&subj=" + subj;
	
	pform.action = "questionMgr.do" + param;
	pform.submit();
}

function fnExControl(qType) {
	if (qType == 0) qType = 2;
	
	for(var i=1; i<=5; i++) {
		var trExId = "trEx" + i;
		var trExCountId = "trExCount" + i;
		if (i == qType) {
			document.getElementById(trExId).style.display = "block";
			document.getElementById(trExCountId).style.display = "block";
		} else {
			document.getElementById(trExId).style.display = "none";
			document.getElementById(trExCountId).style.display = "none";
		}
	}
	
	if (qType == 2 || qType == 3) {
		if (fnExcountRadioCheck(qType) == 0) {
			$("excount"+qType+5).checked = true;
		}
	}
}

function fnExDControll(exNo, exCount) {
	if (exCount == 0) exCount = 5;
	
	for(var i=1; i<=5; i++) {
		var divId = "divEx" + exNo + i;
		if (i <= exCount) {
			document.getElementById(divId).style.display = "block";
		} else {
			document.getElementById(divId).style.display = "none";
		}
	}
}

function fnFileDown(fileType, downname){
	if (fileType == "q") {
		$("downFileName").value = $F("qfileD");
	} else if (fileType == "ex1") {
		$("downFileName").value = $F("ex1fileD");
	} else if (fileType == "ex2") {
		$("downFileName").value = $F("ex2fileD");
	} else if (fileType == "ex3") {
		$("downFileName").value = $F("ex3fileD");
	} else if (fileType == "ex4") {
		$("downFileName").value = $F("ex4fileD");
	} else if (fileType == "ex5") {
		$("downFileName").value = $F("ex5fileD");
	} else if (fileType == "x") {
		$("downFileName").value = $F("xfileD");
	} else if (fileType == "h") {
		$("downFileName").value = $F("hfileD");
	}
	
	var fn = $F("downFileName");
	var path = $F("downPath");
	
	location.href = "/Down/Download?downFileName=" + fn + "&downPath=" + path + "&downname=" + downname;
}
</script>

<script for="window" event="onload">
fnExControl(<%=qType %>);
fnExDControll(<%=qType %>, <%=excount %>);
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode" 		id="mode"		value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="subj"		id="subj"		value="<%= subj %>">
<input type="hidden" name="subjnm"		id="subjnm"		value="<%= subjnm %>">
<input type="hidden" name="idQ"			id="idQ"		value="<%= idQ %>">
<input type="hidden" name="idQtype"		id="idQtype"	value="<%= qType %>">
<input type="hidden" name="excount"		id="excount"	value="<%= excount %>">

<!-- 과목 리스트 검색결과 유지 -->
<input type="hidden" name="s_subjIndexSeq" value="<%= requestMap.getString("s_subjIndexSeq") %>">
<input type="hidden" name="s_indexSeq">
<input type="hidden" name="s_subjUseYn" value="<%= requestMap.getString("s_subjUseYn") %>">
<input type="hidden" name="s_subType" value="<%= requestMap.getString("s_subType") %>">
<input type="hidden" name="s_subjSearchTxt" value="<%= requestMap.getString("s_subjSearchTxt") %>">
<!-- 과목 리스트 페이징 유지 -->
<input type="hidden" name="subjCurrPage" id="subjCurrPage" value="<%= requestMap.getString("subjCurrPage")%>">

<!-- 검색 -->
<input type="hidden" name="s_difficulty" value="<%= requestMap.getString("s_difficulty") %>">
<input type="hidden" name="s_useYn" value="<%= requestMap.getString("s_useYn") %>">
<input type="hidden" name="s_qType" value="<%= requestMap.getString("s_qType") %>">

<!-- 페이징 -->
<input type="hidden" name="currPage" id="currPage" value="<%= requestMap.getString("currPage")%>">

<input type="hidden" name="UPLOAD_DIR"	id="UPLOAD_DIR"	value="<%= Constants.UPLOADDIR_Q%>">

<!-- 파일 다운로드용 -->
<input type="hidden" name="qfileD" 		id="qfileD"		value="<%=qRowMap.getString("qfileRn") %>" />
<input type="hidden" name="ex1fileD"	id="ex1fileD"	value="<%=qRowMap.getString("ex1fileRn") %>" />
<input type="hidden" name="ex2fileD"	id="ex2fileD"	value="<%=qRowMap.getString("ex2fileRn") %>" />
<input type="hidden" name="ex3fileD"	id="ex3fileD"	value="<%=qRowMap.getString("ex3fileRn") %>" />
<input type="hidden" name="ex4fileD"	id="ex4fileD"	value="<%=qRowMap.getString("ex4fileRn") %>" />
<input type="hidden" name="ex5fileD"	id="ex5fileD"	value="<%=qRowMap.getString("ex5fileRn") %>" />
<input type="hidden" name="xfileD" 		id="xfileD"		value="<%=qRowMap.getString("xfileRn") %>" />
<input type="hidden" name="hfileD" 		id="hfileD"		value="<%=qRowMap.getString("hfileRn") %>" />

<input type="hidden" name="downFileName" 	id="downFileName">
<input type="hidden" name="downPath" 		id="downPath"		value="<%= Constants.UPLOADDIR_Q%>">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap="nowrap"><a href="/"><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></a></td>
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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>과목코드별 문항관리 문항등록</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
					
						<br>
						<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#D6DBE5">
							<tr bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>과목명</strong></td>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10"><%= subjnm %></td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>Q_ID</strong></td>
								<td width="40%" class="tableline21" align="left" style="padding:0 0 0 10"><%= idQ %></td>
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>사용여부</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="use_yn" value="Y" id="use_y" <%= aryUseYn[0] %> >&nbsp;<label for="use_y">사용</label>&nbsp;
									<input type="radio" name="use_yn" value="N" id="use_n" <%= aryUseYn[1] %> >&nbsp;<label for="use_n">미사용</label>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>문제유형</strong></td>
								<td width="40%" class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="qType" value="1" id="qType0" <%= aryQType[0] %> <%=disabled %> onclick="fnExControl(1);">&nbsp;<label for="qType0">OX형</label>&nbsp;
									<input type="radio" name="qType" value="2" id="qType1" <%= aryQType[1] %> <%=disabled %> onclick="fnExControl(2);">&nbsp;<label for="qType1">선다형</label>
									<input type="radio" name="qType" value="3" id="qType2" <%= aryQType[2] %> <%=disabled %> onclick="fnExControl(3);">&nbsp;<label for="qType2">복수 답안형</label>&nbsp;
									<input type="radio" name="qType" value="4" id="qType3" <%= aryQType[3] %> <%=disabled %> onclick="fnExControl(4);">&nbsp;<label for="qType3">단답형</label>
									<input type="radio" name="qType" value="5" id="qType4" <%= aryQType[4] %> <%=disabled %> onclick="fnExControl(5);">&nbsp;<label for="qType4">논술형</label>
								</td>
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>난이도</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="difficulty" value="0" id="difficulty0" <%= aryDifficulty[0] %> >&nbsp;<label for="difficulty0">없음</label>&nbsp;
									<input type="radio" name="difficulty" value="1" id="difficulty1" <%= aryDifficulty[1] %> >&nbsp;<label for="difficulty1">최상</label>
									<input type="radio" name="difficulty" value="2" id="difficulty2" <%= aryDifficulty[2] %> >&nbsp;<label for="difficulty2">상</label>&nbsp;
									<input type="radio" name="difficulty" value="3" id="difficulty3" <%= aryDifficulty[3] %> >&nbsp;<label for="difficulty3">중</label>
									<input type="radio" name="difficulty" value="4" id="difficulty4" <%= aryDifficulty[4] %> >&nbsp;<label for="difficulty4">하</label>&nbsp;
									<input type="radio" name="difficulty" value="5" id="difficulty5" <%= aryDifficulty[5] %> >&nbsp;<label for="difficulty5">최하</label>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>문항</strong></td>
								<td colspan="3" class="tableline21" align="center" style="padding:1 0 0 0">
									<textarea name="question" id='question' class="textfield" rows="10" style="height:75px;width:99%"><%= q %></textarea>
									<br/>
									<table width="99%">
										<tr width="99%">
											<td width="99%" align="right">
												<%=qfile %>
												<input type="radio" name="qFileType" id="qFileTypeImage" value="I" <%=qFileType[0] %>>&nbsp;<label for="qFileTypeImage">Image</label>&nbsp;
												<input type="radio" name="qFileType" id="qFileTypeAudio" value="A" <%=qFileType[1] %>>&nbsp;<label for="qFileTypeAudio">Audio</label>&nbsp;
												<input type="radio" name="qFileType" id="qFileTypeVideo" value="V" <%=qFileType[2] %>>&nbsp;<label for="qFileTypeVideo">Video</label>&nbsp;
												<input type="file" name="qfile" id="qfile" class="finput" style="width:50%;">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr id="trExCount1" bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>보기수</strong></td>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">&nbsp;2&nbsp;</td>
							</tr>
							<tr id="trEx1" bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>보기</strong></td>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="exOX" id="exOXO" value="O" <%=aryExOX[0] %>>&nbsp;<label for="exOXO">O</label>&nbsp;
									<input type="radio" name="exOX" id="exOXX" value="X" <%=aryExOX[1] %>>&nbsp;<label for="exOXX">X</label>
								</td>
							</tr>
							<tr id="trExCount2" bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>보기수</strong></td>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="excount2" value="2" id="excount22" onclick="fnExDControll(2, 2);" <%= aryExcount2[0] %> <%=disabled %>>&nbsp;<label for="excount22">2</label>&nbsp;
									<input type="radio" name="excount2" value="3" id="excount23" onclick="fnExDControll(2, 3);" <%= aryExcount2[1] %> <%=disabled %>>&nbsp;<label for="excount23">3</label>&nbsp;
									<input type="radio" name="excount2" value="4" id="excount24" onclick="fnExDControll(2, 4);" <%= aryExcount2[2] %> <%=disabled %>>&nbsp;<label for="excount24">4</label>&nbsp;
									<input type="radio" name="excount2" value="5" id="excount25" onclick="fnExDControll(2, 5);" <%= aryExcount2[3] %> <%=disabled %>>&nbsp;<label for="excount25">5</label>
								</td>
							</tr>
							<tr id="trEx2" bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>보기</strong></td>
								<td colspan="3" class="tableline21" align="center" style="padding:1 0 0 0">
									<div id="divEx21">
										<input type="radio" name="ca2" value="1" id="ca21" <%=ca2[0] %>>
										<textarea name="ex21" id='ex21' class="textfield" rows="2" style="height:38px;width:97%"><%= ex21 %></textarea>
										<br/>
										<table width="99%">
											<tr width="99%">
												<td width="99%" align="right">
													<%=ex21file %>
													<input type="radio" name="ex21FileType" id="ex21FileTypeImage" value="I" <%=ex21FileType[0] %>>&nbsp;<label for="ex21FileTypeImage">Image</label>&nbsp;
													<input type="radio" name="ex21FileType" id="ex21FileTypeAudio" value="A" <%=ex21FileType[1] %>>&nbsp;<label for="ex21FileTypeAudio">Audio</label>&nbsp;
													<input type="radio" name="ex21FileType" id="ex21FileTypeVideo" value="V" <%=ex21FileType[2] %>>&nbsp;<label for="ex21FileTypeVideo">Video</label>&nbsp;
													<input type="file" name="ex21file" id="ex21file" class="finput" style="width:50%;">
												</td>
											</tr>
										</table>
									</div>
									<div id="divEx22">
										<input type="radio" name="ca2" value="2" id="ca22" <%=ca2[1] %>>
										<textarea name="ex22" id='ex22' class="textfield" rows="2" style="height:38px;width:97%"><%= ex22 %></textarea>
										<br/>
										<table width="99%">
											<tr width="99%">
												<td width="99%" align="right">
													<%=ex22file %>
													<input type="radio" name="ex22FileType" id="ex22FileTypeImage" value="I" <%=ex22FileType[0] %>>&nbsp;<label for="ex22FileTypeImage">Image</label>&nbsp;
													<input type="radio" name="ex22FileType" id="ex22FileTypeAudio" value="A" <%=ex22FileType[1] %>>&nbsp;<label for="ex22FileTypeAudio">Audio</label>&nbsp;
													<input type="radio" name="ex22FileType" id="ex22FileTypeVideo" value="V" <%=ex22FileType[2] %>>&nbsp;<label for="ex22FileTypeVideo">Video</label>&nbsp;
													<input type="file" name="ex22file" id="ex22file" class="finput" style="width:50%;">
												</td>
											</tr>
										</table>
									</div>
									<div id="divEx23">
										<input type="radio" name="ca2" value="3" id="ca23" <%=ca2[2] %>>
										<textarea name="ex23" id='ex23' class="textfield" rrows="2" style="height:38px;width:97%"><%= ex23 %></textarea>
										<br/>
										<table width="99%">
											<tr width="99%">
												<td width="99%" align="right">
													<%=ex23file %>
													<input type="radio" name="ex23FileType" id="ex23FileTypeImage" value="I" <%=ex23FileType[0] %>>&nbsp;<label for="ex23FileTypeImage">Image</label>&nbsp;
													<input type="radio" name="ex23FileType" id="ex23FileTypeAudio" value="A" <%=ex23FileType[1] %>>&nbsp;<label for="ex23FileTypeAudio">Audio</label>&nbsp;
													<input type="radio" name="ex23FileType" id="ex23FileTypeVideo" value="V" <%=ex23FileType[2] %>>&nbsp;<label for="ex23FileTypeVideo">Video</label>&nbsp;
													<input type="file" name="ex23file" id="ex23file" class="finput" style="width:50%;">
												</td>
											</tr>
										</table>
									</div>
									<div id="divEx24">
										<input type="radio" name="ca2" value="4" id="ca24" <%=ca2[3] %>>
										<textarea name="ex24" id='ex24' class="textfield" rows="2" style="height:38px;width:97%"><%= ex24 %></textarea>
										<br/>
										<table width="99%">
											<tr width="99%">
												<td width="99%" align="right">
													<%=ex24file %>
													<input type="radio" name="ex24FileType" id="ex24FileTypeImage" value="I" <%=ex24FileType[0] %>>&nbsp;<label for="ex24FileTypeImage">Image</label>&nbsp;
													<input type="radio" name="ex24FileType" id="ex24FileTypeAudio" value="A" <%=ex24FileType[1] %>>&nbsp;<label for="ex24FileTypeAudio">Audio</label>&nbsp;
													<input type="radio" name="ex24FileType" id="ex24FileTypeVideo" value="V" <%=ex24FileType[2] %>>&nbsp;<label for="ex24FileTypeVideo">Video</label>&nbsp;
													<input type="file" name="ex24file" id="ex24file" class="finput" style="width:50%;">
												</td>
											</tr>
										</table>
									</div>
									<div id="divEx25">
										<input type="radio" name="ca2" value="5" id="ca25" <%=ca2[4] %>>
										<textarea name="ex25" id='ex25' class="textfield" rows="2" style="height:38px;width:97%"><%= ex25 %></textarea>
										<br/>
										<table width="99%">
											<tr width="99%">
												<td width="99%" align="right">
													<%=ex25file %>
													<input type="radio" name="ex25FileType" id="ex25FileTypeImage" value="I" <%=ex25FileType[0] %>>&nbsp;<label for="ex25FileTypeImage">Image</label>&nbsp;
													<input type="radio" name="ex25FileType" id="ex25FileTypeAudio" value="A" <%=ex25FileType[1] %>>&nbsp;<label for="ex25FileTypeAudio">Audio</label>&nbsp;
													<input type="radio" name="ex25FileType" id="ex25FileTypeVideo" value="V" <%=ex25FileType[2] %>>&nbsp;<label for="ex25FileTypeVideo">Video</label>&nbsp;
													<input type="file" name="ex25file" id="ex25file" class="finput" style="width:50%;">
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
							<tr id="trExCount3" bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>보기수</strong></td>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="excount3" value="2" id="excount32" onclick="fnExDControll(3, 2);" <%= aryExcount3[0] %> <%=disabled %>>&nbsp;<label for="excount32">2</label>&nbsp;
									<input type="radio" name="excount3" value="3" id="excount33" onclick="fnExDControll(3, 3);" <%= aryExcount3[1] %> <%=disabled %>>&nbsp;<label for="excount33">3</label>&nbsp;
									<input type="radio" name="excount3" value="4" id="excount34" onclick="fnExDControll(3, 4);" <%= aryExcount3[2] %> <%=disabled %>>&nbsp;<label for="excount34">4</label>&nbsp;
									<input type="radio" name="excount3" value="5" id="excount35" onclick="fnExDControll(3, 5);" <%= aryExcount3[3] %> <%=disabled %>>&nbsp;<label for="excount35">5</label>
								</td>
							</tr>
							<tr id="trEx3" bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>보기</strong></td>
								<td colspan="3" class="tableline21" align="center" style="padding:1 0 0 0">
									<div id="divEx31">
										<input type="checkbox" name="ca3[]" value="1" id="ca31" <%=ca3[0] %> >
										<textarea name="ex31" id='ex31' class="textfield" rows="2" style="height:38px;width:97%"><%= ex31 %></textarea>
										<br/>
										<table width="99%">
											<tr width="99%">
												<td width="99%" align="right">
													<%=ex31file %>
													<input type="radio" name="ex31FileType" id="ex31FileTypeImage" value="I" <%=ex31FileType[0] %>>&nbsp;<label for="ex31FileTypeImage">Image</label>&nbsp;
													<input type="radio" name="ex31FileType" id="ex31FileTypeAudio" value="A" <%=ex31FileType[1] %>>&nbsp;<label for="ex31FileTypeAudio">Audio</label>&nbsp;
													<input type="radio" name="ex31FileType" id="ex31FileTypeVideo" value="V" <%=ex31FileType[2] %>>&nbsp;<label for="ex31FileTypeVideo">Video</label>&nbsp;
													<input type="file" name="ex31file" id="ex31file" class="finput" style="width:50%;">
												</td>
											</tr>
										</table>
									</div>
									<div id="divEx32">
										<input type="checkbox" name="ca3[]" value="2" id="ca32" <%=ca3[1] %> >
										<textarea name="ex32" id='ex32' class="textfield" rows="2" style="height:38px;width:97%"><%= ex32 %></textarea>
										<br/>
										<table width="99%">
											<tr width="99%">
												<td width="99%" align="right">
													<%=ex32file %>
													<input type="radio" name="ex32FileType" id="ex32FileTypeImage" value="I" <%=ex32FileType[0] %>>&nbsp;<label for="ex32FileTypeImage">Image</label>&nbsp;
													<input type="radio" name="ex32FileType" id="ex32FileTypeAudio" value="A" <%=ex32FileType[1] %>>&nbsp;<label for="ex32FileTypeAudio">Audio</label>&nbsp;
													<input type="radio" name="ex32FileType" id="ex32FileTypeVideo" value="V" <%=ex32FileType[2] %>>&nbsp;<label for="ex32FileTypeVideo">Video</label>&nbsp;
													<input type="file" name="ex32file" id="ex32file" class="finput" style="width:50%;">
												</td>
											</tr>
										</table>
									</div>
									<div id="divEx33">
										<input type="checkbox" name="ca3[]" value="3" id="ca33" <%=ca3[2] %> >
										<textarea name="ex33" id='ex33' class="textfield" rows="2" style="height:38px;width:97%"><%= ex33 %></textarea>
										<br/>
										<table width="99%">
											<tr width="99%">
												<td width="99%" align="right">
													<%=ex33file %>
													<input type="radio" name="ex33FileType" id="ex33FileTypeImage" value="I" <%=ex33FileType[0] %>>&nbsp;<label for="ex33FileTypeImage">Image</label>&nbsp;
													<input type="radio" name="ex33FileType" id="ex33FileTypeAudio" value="A" <%=ex33FileType[1] %>>&nbsp;<label for="ex33FileTypeAudio">Audio</label>&nbsp;
													<input type="radio" name="ex33FileType" id="ex33FileTypeVideo" value="V" <%=ex33FileType[2] %>>&nbsp;<label for="ex33FileTypeVideo">Video</label>&nbsp;
													<input type="file" name="ex33file" id="ex33file" class="finput" style="width:50%;">
												</td>
											</tr>
										</table>
									</div>
									<div id="divEx34">
										<input type="checkbox" name="ca3[]" value="4" id="ca34" <%=ca3[3] %> >
										<textarea name="ex34" id='ex34' class="textfield" rows="2" style="height:38px;width:97%"><%= ex34 %></textarea>
										<br/>
										<table width="99%">
											<tr width="99%">
												<td width="99%" align="right">
													<%=ex34file %>
													<input type="radio" name="ex34FileType" id="ex34FileTypeImage" value="I" <%=ex31FileType[0] %>>&nbsp;<label for="ex34FileTypeImage">Image</label>&nbsp;
													<input type="radio" name="ex34FileType" id="ex34FileTypeAudio" value="A" <%=ex34FileType[1] %>>&nbsp;<label for="ex34FileTypeAudio">Audio</label>&nbsp;
													<input type="radio" name="ex34FileType" id="ex34FileTypeVideo" value="V" <%=ex34FileType[2] %>>&nbsp;<label for="ex34FileTypeVideo">Video</label>&nbsp;
													<input type="file" name="ex34file" id="ex34file" class="finput" style="width:50%;">
												</td>
											</tr>
										</table>
									</div>
									<div id="divEx35">
										<input type="checkbox" name="ca3[]" value="5" id="ca35" <%=ca3[4] %> >
										<textarea name="ex35" id='ex35' class="textfield" rows="2" style="height:38px;width:97%"><%= ex35 %></textarea>
										<br/>
										<table width="99%">
											<tr width="99%">
												<td width="99%" align="right">
													<%=ex35file %>
													<input type="radio" name="ex35FileType" id="ex35FileTypeImage" value="I" <%=ex35FileType[0] %>>&nbsp;<label for="ex35FileTypeImage">Image</label>&nbsp;
													<input type="radio" name="ex35FileType" id="ex35FileTypeAudio" value="A" <%=ex35FileType[1] %>>&nbsp;<label for="ex35FileTypeAudio">Audio</label>&nbsp;
													<input type="radio" name="ex35FileType" id="ex35FileTypeVideo" value="V" <%=ex35FileType[2] %>>&nbsp;<label for="ex35FileTypeVideo">Video</label>&nbsp;
													<input type="file" name="ex35file" id="ex35file" class="finput" style="width:50%;">
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
							<tr id="trExCount4" bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>보기수</strong></td>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">&nbsp;&nbsp;</td>
							</tr>
							<tr id="trEx4" bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>정답</strong></td>
								<td colspan="3" class="tableline21" align="center" style="padding:1 0 0 0">
									<textarea name="ca4" id='ca4' class="textfield" rows="10" style="height:100px;width:99%"></textarea>
									<br/>
									<table width="99%">
										<tr width="99%">
											<td width="99%" align="right">
												<%=ex41file %>
												<input type="radio" name="ex41FileType" id="ex41FileTypeImage" value="I" <%=ex41FileType[0] %>>&nbsp;<label for="ex41FileTypeImage">Image</label>&nbsp;
												<input type="radio" name="ex41FileType" id="ex41FileTypeAudio" value="A" <%=ex41FileType[1] %>>&nbsp;<label for="ex41FileTypeAudio">Audio</label>&nbsp;
												<input type="radio" name="ex41FileType" id="ex41FileTypeVideo" value="V" <%=ex41FileType[2] %>>&nbsp;<label for="ex41FileTypeVideo">Video</label>&nbsp;
												<input type="file" name="ex41file" id="ex41file" class="finput" style="width:50%;">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr id="trExCount5" bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>보기수</strong></td>
								<td colspan="3" class="tableline21" align="left" style="padding:0 0 0 10">&nbsp;&nbsp;</td>
							</tr>
							<tr id="trEx5" bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>정답</strong></td>
								<td colspan="3" class="tableline21" align="center" style="padding:1 0 0 0">
									<textarea name="ca5" id='ca5' class="textfield" rows="4" style="height:100px;width:99%"></textarea>
									<br/>
									<table width="99%">
										<tr width="99%">
											<td width="99%" align="right">
												<%=ex51file %>
												<input type="radio" name="ex51FileType" id="ex51FileTypeImage" value="I" <%=ex51FileType[0] %>>&nbsp;<label for="ex51FileTypeImage">Image</label>&nbsp;
												<input type="radio" name="ex51FileType" id="ex51FileTypeAudio" value="A" <%=ex51FileType[1] %>>&nbsp;<label for="ex51FileTypeAudio">Audio</label>&nbsp;
												<input type="radio" name="ex51FileType" id="ex51FileTypeVideo" value="V" <%=ex51FileType[2] %>>&nbsp;<label for="ex51FileTypeVideo">Video</label>&nbsp;
												<input type="file" name="ex51file" id="ex51file" class="finput" style="width:50%;">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>해설</strong></td>
								<td colspan="3" class="tableline21" align="center" style="padding:1 0 0 0">
									<textarea name="explain" id='explain' class="textfield" rows="10" style="height:100px;width:99%"><%= explain %></textarea>
									<br/>
									<table width="99%">
										<tr width="99%">
											<td width="99%" align="right">
												<%=xfile %>
												<input type="radio" name="xFileType" id="xFileTypeImage" value="I" <%=xFileType[0] %>>&nbsp;<label for="xFileTypeImage">Image</label>&nbsp;
												<input type="radio" name="xFileType" id="xFileTypeAudio" value="A" <%=xFileType[1] %>>&nbsp;<label for="xFileTypeAudio">Audio</label>&nbsp;
												<input type="radio" name="xFileType" id="xFileTypeVideo" value="V" <%=xFileType[2] %>>&nbsp;<label for="xFileTypeVideo">Video</label>&nbsp;
												<input type="file" name="xfile" id="xfile" class="finput" style="width:50%;">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="10%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>힌트</strong></td>
								<td colspan="3" class="tableline21" align="center" style="padding:1 0 0 0">
									<textarea name="hint" id='hint' class="textfield" rows="10" style="height:100px;width:99%"><%= hint %></textarea>
									<br/>
									<table width="99%">
										<tr width="99%">
											<td width="99%" align="right">
												<%=hfile %>
												<input type="radio" name="hFileType" id="hFileTypeImage" value="I" <%=hFileType[0] %>>&nbsp;<label for="hFileTypeImage">Image</label>&nbsp;
												<input type="radio" name="hFileType" id="hFileTypeAudio" value="A" <%=hFileType[1] %>>&nbsp;<label for="hFileTypeAudio">Audio</label>&nbsp;
												<input type="radio" name="hFileType" id="hFileTypeVideo" value="V" <%=hFileType[2] %>>&nbsp;<label for="hFileTypeVideo">Video</label>&nbsp;
												<input type="file" name="hfile" id="hfile" class="finput" style="width:50%;">
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						
						
						<!--[s] 하단 버튼  -->
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="center">
									<input type="button" value="이전" onclick="fnQuestionList();"   class="boardbtn1" >&nbsp;
									<input type="button" value="저장" onclick="fnSave('<%=mode %>');" class="boardbtn1" >&nbsp;
									<input type="button" value="삭제" onclick="fnDelete()" class="boardbtn1" <%= btnDeleteDisplay %> >
								</td>
							</tr>
							<tr><td height="5"></td></tr>
						</table>
						<!--[e] 하단 버튼  -->
						
					
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<iframe id="download" name="download" height="0px" frameborder="0"></iframe>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>