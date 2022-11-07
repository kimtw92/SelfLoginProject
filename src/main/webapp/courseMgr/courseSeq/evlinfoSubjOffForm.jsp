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
	
	DataMap evalSubjInfo = (DataMap) request.getAttribute("evalSubjInfo");
	evalSubjInfo.setNullToInitialize(true);
	
	DataMap examM = (DataMap) request.getAttribute("examM");
	examM.setNullToInitialize(true);
	
	DataMap examUnit = (DataMap) request.getAttribute("examUnit");
	examUnit.setNullToInitialize(true);
	
	DataMap examSubject = (DataMap) request.getAttribute("examSubject");
	examSubject.setNullToInitialize(true);
	
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
	
	String examTitle = "";
	int qcount = 0;
	int setcount = 0;
	String setcountString = "";
	double allotting = 0;
	String idSubject = "";
	if (!mode.equals("newOffExam")) {
		examTitle = examM.getString("title", examMInx);
		qcount = examSubject.getInt("qcount");
		setcount = examSubject.getInt("setcount");
		allotting = examSubject.getInt("allotting");
		idSubject = examSubject.getString("idSubject");
	} else {
		idExam = "";
	}
	
	String readOnly = "";
	StringBuffer sbPreviewPaper = new StringBuffer();
	sbPreviewPaper.append("");
	switch(setcount) {
	case 1:
		readOnly = "readonly='readonly' style='background:lightgray;'";
		sbPreviewPaper.append("<input type='button' id='bntPreviewPaperA' name='bntPreviewPaperA' value=' A ' onclick=\"fnPreviewExam('1');\">");
		setcountString = sbPreviewPaper.toString();
		break;
	case 2:
		readOnly = "readonly='readonly' style='background:lightgray;'";
		sbPreviewPaper.append("<input type='button' id='bntPreviewPaperA' name='bntPreviewPaperA' value=' A ' onclick=\"fnPreviewExam('1');\">");
		sbPreviewPaper.append("<input type='button' id='bntPreviewPaperB' name='bntPreviewPaperB' value=' B ' onclick=\"fnPreviewExam('2');\">");
		setcountString = sbPreviewPaper.toString();
		break;
	case 3:
		readOnly = "readonly='readonly' style='background:lightgray;'";
		sbPreviewPaper.append("<input type='button' id='bntPreviewPaperA' name='bntPreviewPaperA' value=' A ' onclick=\"fnPreviewExam('1');\">");
		sbPreviewPaper.append("<input type='button' id='bntPreviewPaperB' name='bntPreviewPaperB' value=' B ' onclick=\"fnPreviewExam('2');\">");
		sbPreviewPaper.append("<input type='button' id='bntPreviewPaperC' name='bntPreviewPaperC' value=' C ' onclick=\"fnPreviewExam('3');\">");
		setcountString = sbPreviewPaper.toString();
		break;
		default:
			setcountString = "";
			break;
	}
	
	String hasAns = "";
	if (examM.getInt("ansCnt",examMInx) > 0 && !mode.equals("newOffExam")) {
		hasAns = "style=\"display:none;\"";
	}
	
	String noButton = "";
	String noButtonMsg = "";
	if (evalSubjInfo.keySize("subj") == 0) {
		noButton ="style=\"display:none;\"";
		noButtonMsg = "평가항목으로 입력된 과목이 없는 경우 시험지 생성이 불가능합니다.";
		hasAns = "";
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
	
	StringBuffer sbTmp = new StringBuffer();
	sbTmp.append("<a href=\"javascript:fnFileDown('").append(examSubject.getString("afile")).append("');\">").append(examSubject.getString("afile")).append("</a>&nbsp;");
	String afile = sbTmp.toString();
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

function fnInit() {
	var param = "";
	param = param + "?mode="+$("mode").value;
	param = param + "&commGrcode="+$("grcode").value;
	param = param + "&commGrseq="+$("grseq").value;
	pform.action = "/courseMgr/courseSeq.do"+param;
	pform.submit();
}

function fnList() {
	$("mode").value = "list";
	pform.action = "/courseMgr/courseSeq.do?mode="+$("mode").value;
	pform.submit();
}

function fnSave() {
	if (fnCheck()) {
		$("mode").value = "saveAns";
		pform.action = "/courseMgr/courseSeq.do?mode="+$("mode").value;
		pform.submit();
	}
}

function fnCheck(){
	if ($("setcount").value == "3") {
		alert("더이상 시험 유형을 추가할 수 없습니다.");
		return false;
	}
	
	if ($("title").value == "") {
		alert("시험 제목을 입력하세요.");
		$("title").focus();
		return false;
	}
	
	if ($("qcount").value == "") {
		alert("문항 수를 입력하세요.");
		$("qcount").focus();
		return false;
	}
	
	if (Number($("qcount").value) < 1) {
		alert("문항 수를 잘못 입력했습니다.");
		$("qcount").focus();
		return false;
	}
	
	if ($("allotting").value == "") {
		alert("배점을 입력하세요.");
		$("allotting").focus();
		return false;
	}
	
	if ($("file").value == "") {
		alert("정답파일을 선택하세요.");
		$("file").focus();
		return false;
	}
	
	return true;
}

function fnDelete() {
	$("mode").value = "deleteOffExam";
	pform.action = "/courseMgr/courseSeq.do?mode="+$("mode").value;
	pform.submit();
}

function fnDownload() {
	$("mode").value = "downloadForm";
	pform.action = "/courseMgr/courseSeq.do?mode="+$("mode").value;
	pform.submit();
}

function fnView(idExam) {
	$("idExam").value = idExam;
	var param = "";
	param = param + "?" + "mode=" + $("mode").value;
	param = param + "&" + "idExam=" + $("idExam").value;
	param = param + "&" + "commGrcode=" + $("grcode").value;
	param = param + "&" + "commGrseq=" + $("grseq").value;
	
	pform.action = "/courseMgr/courseSeq.do"+param;
	pform.submit();
}

function fnNewExam() {
	$("mode").value = "newOffExam";
	var param = "";
	param = param + "?mode=" + $("mode").value;
	param = param + "&commGrcode="+$("grcode").value;
	param = param + "&commGrseq="+$("grseq").value;
	pform.action = "/courseMgr/courseSeq.do"+param;
	pform.submit();
}

function fnPreviewExam(nrSet) {
	var mode = "previewOffExam";
	var idExam = $("idExam").value;
	var idSubject = $("idSubject").value;
	var url = "/courseMgr/courseSeq.do?mode=" + mode + "&idExam=" + idExam + "&idSubject=" + idSubject + "&nrSet=" + nrSet;

	popWin(url, "previewOffExam", "600", "400", "1", "");
}

function fnFileDown(downname){
	$("downFileName").value = $F("afileD");
	
	var fn = $F("downFileName");
	var path = $F("downPath");
	
	location.href = "/Down/Download?downFileName=" + fn + "&downPath=" + path + "&downname=" + downname;
}
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="menuId"	value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"	value="<%=mode %>">

<input type="hidden" name="grcode"	value="<%=requestMap.getString("grcode")%>">
<input type="hidden" name="grseq"	value="<%=requestMap.getString("grseq")%>">
<input type="hidden" name="subj"	value="<%=requestMap.getString("subj")%>">
<input type="hidden" name="subjnm"	value="<%=evlinfoSubjList.getString("lecnm")%>">
<input type="hidden" name="year"	value="<%=requestMap.getString("year")%>">

<input type="hidden" name="idExam" value="<%=idExam %>" />
<input type="hidden" name="idSubject"	value="<%=idSubject %>">
<input type="hidden" name="setcount"	value="<%=setcount %>">

<input type="hidden" name="UPLOAD_DIR" value="<%=Constants.UPLOADDIR_Q%>">

<input type="hidden" name="downFileName" 	id="downFileName">
<input type="hidden" name="downPath" 		id="downPath"		value="<%= Constants.UPLOADDIR_Q%>">
<input type="hidden" name="afileD" 			id="afileD"			value="<%=examSubject.getString("afileRn") %>" />
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
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									과정명
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<%=evlinfoSubjList.getString("grcodenm") %>
								</td>
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									과목명
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<%=evlinfoSubjList.getString("lecnm") %>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									시험제목
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input name="title" id="title" type="text" value="<%=examTitle %>" class="textfield" >
								</td>
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									문항 수
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<label><input name="qcount" id="qcount" type="number" style="text-align:right" value="<%=qcount %>" <%=readOnly %>/> 문항</label>
								</td>
							</tr>
							<tr height="28" bgcolor="#FFFFFF">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									총점
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<label><input name="allotting" id="allotting" type="number" style="text-align:right" value="<%=allotting %>" <%=readOnly %>/> 점</label>
								</td>
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									시험지 수
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<%=setcount %> 개 <%=sbPreviewPaper.toString() %>
								</td>
							</tr>
							<tr height="28" bgcolor="#FFFFFF">
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									정답파일
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="file" name="file" id="file" class="finput" style="width:100%;" class="boardbtn1">
								</td>
								<th width="150" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF">
									첨부파일
								</th>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<%=afile %> <input type="file" name="afile" id="afile" class="finput" style="width:70%;" class="boardbtn1">
								</td>
							</tr>
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						
						<!--[s] 하단 버튼  -->
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="right">
									<%=noButtonMsg %>
									<input type="button" value="이전" onclick="fnList();" class="boardbtn1" >
									<input type="button" value="저장" onclick="fnSave();" class="boardbtn1" <%=hasAns%> <%=noButton %>>
									<input type="button" value="시험추가" onclick="fnNewExam();" class="boardbtn1" <%=noButton %>>
									<input type="button" value="시험삭제" onclick="fnDelete();" class="boardbtn1" <%=hasAns%> <%=noButton %>>
									<input type="button" value="초기화" onclick="fnInit();" class="boardbtn1" <%=noButton %>>
									<input type="button" value="서식 다운로드" onclick="fnDownload();" class="boardbtn1" <%=noButton %>>
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

