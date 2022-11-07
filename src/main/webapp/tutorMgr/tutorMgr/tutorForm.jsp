<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사 등록, 수정
// date  : 2008-06-20
// auth  : kang
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
	
	
	
	
	// 회원데이터
	DataMap memberDamoMap = (DataMap)request.getAttribute("MEMBERDAMO_ROW");
	if(memberDamoMap == null) memberDamoMap = new DataMap();
	memberDamoMap.setNullToInitialize(true);
	
	// 강사데이터
	DataMap tutorDamoMap = (DataMap)request.getAttribute("TUTORDAMO_ROW");
	if(tutorDamoMap == null) tutorDamoMap = new DataMap();
	tutorDamoMap.setNullToInitialize(true);
	
	
	
	
	String tmpSelected = "";
	
	// 강사등급
	StringBuffer sbTutorLevelHtml = new StringBuffer();
	DataMap tutorLevelMap = (DataMap)request.getAttribute("TUTOR_LEVEL_LIST");
	if(tutorLevelMap == null) tutorLevelMap = new DataMap();
	tutorLevelMap.setNullToInitialize(true);
	
	sbTutorLevelHtml.append("<select name=\"tlevel\" id=\"tlevel\" style=\"width:120px\" >");
	sbTutorLevelHtml.append("	<option value=\"\">**선택하세요**</option>");
	if(tutorLevelMap.keySize("tlevel") > 0){
		for(int i=0; i < tutorLevelMap.keySize("tlevel"); i++){
			
			if(tutorDamoMap.getString("tlevel").equals( tutorLevelMap.getString("tlevel",i) ) ){
				tmpSelected = "selected";
			}else{
				tmpSelected = "";
			}
			
			sbTutorLevelHtml.append("<option value=\"" + tutorLevelMap.getString("tlevel",i) + "\" " + tmpSelected + " >" + tutorLevelMap.getString("levelName",i) + "</option> ");
			
		}
	}else{
		sbTutorLevelHtml.append("	<option value=\"\">등록된 등급없음</option>");
	}
	sbTutorLevelHtml.append("</select>");
	
	
	
	// 강사 담당분야
	StringBuffer sbTutorGubunHtml = new StringBuffer();
	DataMap tutorGubunMap = (DataMap)request.getAttribute("TUTOR_GUBUN_LIST");
	if(tutorGubunMap == null) tutorGubunMap = new DataMap();
	tutorGubunMap.setNullToInitialize(true);
	
	sbTutorGubunHtml.append("<select name=\"gubun\" id=\"gubun\" style=\"width:120px\" >");
	sbTutorGubunHtml.append("	<option value=\"\">**선택하세요**</option>");
	
	if(tutorGubunMap.keySize("gubun") > 0){
		for(int i=0; i < tutorGubunMap.keySize("gubun"); i++){
			
			if(tutorDamoMap.getString("gubun").equals( tutorGubunMap.getString("gubun",i) ) ){
				tmpSelected = "selected";
			}else{
				tmpSelected = "";
			}
			
			sbTutorGubunHtml.append("<option value=\"" + tutorGubunMap.getString("gubun",i) + "\" " + tmpSelected + " >" + tutorGubunMap.getString("gubunnm",i) + "</option> ");
		}
	}else{
		sbTutorGubunHtml.append("	<option value=\"\">등록된 분야없음</option>");
	}
	sbTutorGubunHtml.append("</select>");
	
	
	String type = (String)request.getAttribute("TYPE");
	
	
	
	
	// 각종 전화번호
	String[] aryHomeTel = new String[3];
	String[] aryHp = new String[3];
	//String[] aryOfficeTel = new String[3];
	String[] aryOfficeTel = new String[4];
	String[] aryFax = new String[3];
	
	for(int i=0; i < 3; i++){
		aryHomeTel[i] = "";
		aryHp[i] = "";
		//aryOfficeTel[i] = "";
		aryFax[i] = "";
	}
	
	for(int j=0; j < 4; j++) {
		aryOfficeTel[j] = "";	
	}
	
	int stCount = 0;	
	StringTokenizer stHomeTel = new StringTokenizer(memberDamoMap.getString("homeTel"), "-" );
	StringTokenizer stHp = new StringTokenizer(memberDamoMap.getString("hp"), "-" );
	StringTokenizer stOfficeTel = new StringTokenizer(memberDamoMap.getString("officeTel"), "-" );
	StringTokenizer stFax = new StringTokenizer(tutorDamoMap.getString("fax"), "-" );

	stCount = stHomeTel.countTokens();		
	for(int i=0; i < stCount; i++){
		aryHomeTel[i] = stHomeTel.nextToken();		
	}
	
	stCount = stHp.countTokens();		
	for(int i=0; i < stCount; i++){
		aryHp[i] = stHp.nextToken();		
	}
	
	stCount = stOfficeTel.countTokens();		
	for(int i=0; i < stCount; i++){
		aryOfficeTel[i] = stOfficeTel.nextToken();		
	}
	
	stCount = stFax.countTokens();		
	for(int i=0; i < stCount; i++){
		aryFax[i] = stFax.nextToken();		
	}
	

	
	
	// 학력
	DataMap historyMap1 = (DataMap)request.getAttribute("TUTOR_HISTORY1");
	if(historyMap1 == null) historyMap1 = new DataMap();
	historyMap1.setNullToInitialize(true);
	
	String[] aryHistory1 = new String[3];
	for(int i=0; i < 3; i++){
		aryHistory1[i] = "";
	}
	if(historyMap1.keySize("ocinfo") > 0){
		for(int i=0; i < historyMap1.keySize("ocinfo"); i++){
			aryHistory1[i] = historyMap1.getString("ocinfo");
		}
	}
	
	
	
	// 전공분야
	DataMap historyMap2 = (DataMap)request.getAttribute("TUTOR_HISTORY2");
	if(historyMap2 == null) historyMap2 = new DataMap();
	historyMap2.setNullToInitialize(true);
		
	StringBuilder sbHistory2 = new StringBuilder();
	int countByHistory2 = 0;
	
	if(historyMap2.keySize("ocinfo") > 0){
		
		countByHistory2 = historyMap2.keySize("ocinfo");
		
		for(int i=0; i < historyMap2.keySize("ocinfo"); i++){
			sbHistory2.append("<input type=\"text\" name=\"ocinfo2\" id=\"ocinfo2_" + i + "\" style=\"width:350px\" class=\"textfield\" value=\"" + historyMap2.getString("ocinfo",i) + "\"  ><br>");
		}
		
	}else{
		
		countByHistory2 = 3;
		
		sbHistory2.append("<input type=\"text\" name=\"ocinfo2\" id=\"ocinfo2_0\" style=\"width:350px\" class=\"textfield\"><br>");
		sbHistory2.append("<input type=\"text\" name=\"ocinfo2\" id=\"ocinfo2_1\" style=\"width:350px\" class=\"textfield\"><br>");
		sbHistory2.append("<input type=\"text\" name=\"ocinfo2\" id=\"ocinfo2_2\" style=\"width:350px\" class=\"textfield\"><br>");
	}
	
	
	
	// 경력사항
	DataMap historyMap3 = (DataMap)request.getAttribute("TUTOR_HISTORY3");
	if(historyMap3 == null) historyMap3 = new DataMap();
	historyMap3.setNullToInitialize(true);
	
	StringBuilder sbHistory3 = new StringBuilder();
	int countByHistory3 = 0;
	
	if(historyMap3.keySize("ocinfo") > 0){
		
		countByHistory3 = historyMap3.keySize("ocinfo");
		
		for(int i=0; i < historyMap3.keySize("ocinfo"); i++){
			sbHistory3.append("<input type=\"text\" name=\"ocinfo3\" id=\"ocinfo3_" + i + "\" style=\"width:350px\" class=\"textfield\" maxlength=\"1000\" value=\"" + historyMap3.getString("ocinfo",i) + "\"  ><br>");
		}
		
	}else{
		
		countByHistory3 = 3;
		
		sbHistory3.append("<input type=\"text\" name=\"ocinfo3\" id=\"ocinfo3_0\" style=\"width:350px\" class=\"textfield\" maxlength=\"1000\" ><br>");
		sbHistory3.append("<input type=\"text\" name=\"ocinfo3\" id=\"ocinfo3_1\" style=\"width:350px\" class=\"textfield\" maxlength=\"1000\" ><br>");
		sbHistory3.append("<input type=\"text\" name=\"ocinfo3\" id=\"ocinfo3_2\" style=\"width:350px\" class=\"textfield\" maxlength=\"1000\" ><br>");
	}
	
	
	
	
	// 저서 및 주요논문
	DataMap historyMap4 = (DataMap)request.getAttribute("TUTOR_HISTORY4");
	if(historyMap4 == null) historyMap4 = new DataMap();
	historyMap4.setNullToInitialize(true);
	
	StringBuilder sbHistory4 = new StringBuilder();
	int countByHistory4 = 0;
	
	if(historyMap4.keySize("ocinfo") > 0){
		
		countByHistory4 = historyMap4.keySize("ocinfo");
		
		for(int i=0; i < historyMap4.keySize("ocinfo"); i++){
			sbHistory4.append("<input type=\"text\" name=\"ocinfo4\" id=\"ocinfo4_" + i + "\" style=\"width:350px\" class=\"textfield\" maxlength=\"1000\" value=\"" + historyMap4.getString("ocinfo",i) + "\"  ><br>");
		}
		
	}else{
		
		countByHistory4 = 3;
				sbHistory4.append("<input type=\"text\" name=\"ocinfo4\" id=\"ocinfo4_0\" style=\"width:350px\" class=\"textfield\" maxlength=\"1000\" ><br>");
		sbHistory4.append("<input type=\"text\" name=\"ocinfo4\" id=\"ocinfo4_1\" style=\"width:350px\" class=\"textfield\" maxlength=\"1000\" ><br>");
		sbHistory4.append("<input type=\"text\" name=\"ocinfo4\" id=\"ocinfo4_2\" style=\"width:350px\" class=\"textfield\" maxlength=\"1000\" ><br>");
	}
	

	
	// 버튼 및 읽기전용 구분
	String displayBtnResno = "";
	String stateReadonly = "";
	
	if(type.equals("3")){
		displayBtnResno = "style='display:none'";
		stateReadonly = "readonly";
	}
	
	
	// 강사사진
	ut.lib.util.MD5 md5 = new MD5( memberDamoMap.getString("resno") );
	String sysFileName = md5.asHex();
	String fileDir = Constants.rootPath + Constants.UPLOAD + Constants.NAMOUPLOAD_PIC + sysFileName;		
	java.io.File file = new java.io.File(fileDir);
	String picImg = "";
	if( file.isFile() ){
		picImg = "/pds/pic/" + sysFileName;
	}

	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; 

	try {
	
		DataMap fileMap = (DataMap)tutorDamoMap.get("FILE_GROUP_LIST");
	
		if(fileMap == null)
			fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
	
		for(int i=0; i < fileMap.keySize("groupfileNo"); i++){
	
			if(fileMap.getInt("groupfileNo", i)==0){
				continue;
			}
			
			tmpStr = fileMap.getString("groupfileNo", i) + "#" + fileMap.getString("fileNo", i); 
// 			fileStr += "document.InnoDS.AddTempFile('" + fileMap.getString("fileName", i) + "', " + fileMap.getInt("fileSize", i) + ", '" + tmpStr + "');";
// 			fileStr += "g_ExistFiles['" + tmpStr + "'] = false;";

            fileStr += "var input"+i+" = document.createElement('input');\n";
			fileStr += "input"+i+".value='"+fileMap.getString("fileName", i)+"';\n";
			fileStr += "input"+i+".setAttribute('fileNo', '"+tmpStr+"');\n";
			fileStr += "input"+i+".name='existFile';\n";
			fileStr += "multi_selector.addListRow(input"+i+");\n\n";
	
		}
	} catch(Exception e) {
	
	}	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--

//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){


}

var ocinfo2 = <%= countByHistory2 %>;
var ocinfo3 = <%= countByHistory3 %>;
var ocinfo4 = <%= countByHistory4 %>;

// 전공분야, 경력사항, 저서 항목 추가
function addTextBox(objId) {

	var tdObj = $(objId);
	
	switch(objId){
		case "dyBox2":
			tdObj.innerHTML += "<br><input type=\"text\" name=\"ocinfo2\" id=\"ocinfo2_" + ocinfo2 + "\" style=\"width:350px\" class=\"textfield\">";
			ocinfo2++;
			break;
			
		case "dyBox3":
			tdObj.innerHTML += "<br><input type=\"text\" name=\"ocinfo3\" id=\"ocinfo3_" + ocinfo3 + "\" style=\"width:350px\" class=\"textfield\">";
			ocinfo3++;
			break;
			
		case "dyBox4":
			tdObj.innerHTML += "<br><input type=\"text\" name=\"ocinfo4\" id=\"ocinfo4_" + ocinfo4 + "\" style=\"width:350px\" class=\"textfield\">";
			ocinfo4++;
			break;
	}
}

// 강사회원검색팝업
function fnSearchTutorPop(){

	var url = "tutor.do";
	url += "?mode=searchTutorPop";
	
	pwinpop = popWin(url,"cPop","600","500","yes","yes");

}

// 강사회원검색한 후 정보 가져오기
function fnSearchTutorPopByReLoad(type, userno){
	
	$("type").value = type;
	$("userno").value = userno;
	
	pform.action = "tutor.do?mode=regForm";
	pform.submit();
	
}


// 주민번호, 유저id 중복체크
function fnCheckResNo(ptype){

	var resno = $F("resno");
	var userId = $F("userId");

	var url = "tutor.do";
	var pars = "mode=checkResId";
	
	pars += "&ptype=" + ptype;
	
	switch(ptype){
		case "resno":
			pars += "&searchTxt=" + resno;
			
			if(resno.trim() == ""){
				alert("주민등록번호를 입력하세요.");
				$("resno").focus();
				return;
			}
			if(resno.trim().length != 13){
				alert("주민등록번호의 자리수가 맞지 않습니다.");
				$("resno").focus();
				return;
			}
			if(realJuminCheck($F("resno")) == false){
				$("resno").focus();
				return;
			}
			
			break;
		case "userId":
			pars += "&searchTxt=" + userId;
			
			if(userId.trim() == ""){
				alert("아이디를 입력하세요.");
				$("userId").focus();
				return;
			}
			if(isErrorID_Char($F("userId")) == true){
				$("userId").focus();		
				return;
			}
			if(isErrorID_Word($F("userId")) == true){
				$("userId").focus();
				return;
			}
			break;
	}
	
	
	var myAjax = new Ajax.Request(			
		url, 
		{
			method: "post", 
			parameters: pars,
			onLoading : function(){					
			},
			onSuccess : function(originalRequest){
				
				var retValue = originalRequest.responseText.trim();
				
				switch(retValue){
					case "ok":
						alert("사용할 수 있습니다.");
						if(ptype == "resno"){
							$("chkResno").value = "Y";
						}else{
							$("chkUserId").value = "Y";
						}
						break;
					case "dup":
						alert("중복된 값이 있습니다.");
						if(ptype == "resno"){
							$("resno").value = "";
							$("chkResno").value = "";
						}else{
							$("userId").value = "";
							$("chkUserId").value = "";
						}
						break;
					default:
						break;
				}
			
			},
			onFailure : function(){
				alert("자료를 가져오는데 실패했습니다.");
			}
		}
	);
}



//우편번호 검색
function searchZip(post1, post2, addr){

	var url = "/search/searchZip.do";
	url += "?mode=form";
	url += "&zipCodeName1=pform." + post1;
	url += "&zipCodeName2=pform." + post2;
	url += "&zipAddr=pform." + addr;
	
	pwinpop = popWin(url,"cPop","400","250","yes","yes");

}

// 과목 선택 팝업
function fnSubjPop(obj){

	var url = "tutor.do";
	url += "?mode=searchSubjPop";
	url += "&obj=" + obj;
	
	pwinpop = popWin(url,"cPop","500","400","yes","yes");

}

// 저장
function fnSave(){

	if(NChecker($("pform"))){
	
		if( "<%= type %>" == "1" ){
			
			if( !$("chk_foreigner").checked ){
				if(realJuminCheck($F("resno")) == false){
					$("resno").focus();
					return;
				}
			}else{
				$("chkResno").value = 'Y';
			}
			
			if( $F("chkResno") != "Y" ){
				alert("주민번호 중복체크를 하세요.");
				return;
			}
			//if( $F("chkUserId") != "Y" ){
			//	alert("아이디 중복체크를 하세요.");
			//	return;
			//}

			//alert("1");
		}
		
		
		if($F("email").trim() != ""){		
			if(checkEmail($F("email").trim()) == false){
				return;
			}
		}
		//alert("2");
		if(isErrorID_Char($F("userId")) == true){		
			return;
		}
		if($F("name") == ""){
			alert("성명을 입력해주세요.");
			return;
		}
		//if(isErrorID_Word($F("userId")) == true){
		//	return;
		//}
		//alert("3");
		
		$("d_ocinfo1").value = fnReturnOcinfo("ocinfo1");
		$("d_ocinfo2").value = fnReturnOcinfo("ocinfo2");
		$("d_ocinfo3").value = fnReturnOcinfo("ocinfo3");
		$("d_ocinfo4").value = fnReturnOcinfo("ocinfo4");
		
		
		if(confirm("저장하시겠습니까 ?")){		
			$("mode").value = "saveTutorForm";
			pform.action = "tutor.do?mode=saveTutorForm";
			pform.submit();

		}
	
	}

}
function fnReturnOcinfo(objname){

	var i=0;
	var tmp = "";
	var tmpi = 0;
	var tmpObj = "";
	var tmpData = "";
		
	for(i=0; i < pform.elements.length; i++){
		
		if(pform.elements[i].name == objname){
			
			tmp = pform.elements[i].id.split("_");
			tmpObj = objname + "_" + tmp[1];
			
			if(tmpi == 0){
				tmpData = $F(tmpObj).trim();
			}else{
				tmpData += "|#|" + $F(tmpObj).trim();
			}
			tmpi++;
		}
	}
	
	return tmpData;

}

// 사진등록
function fnImgUploadPop(){
	
	var url = "tutor.do";
	url += "?mode=imgUploadForm";
	url += "&resno=" + $F("resno");
	
	pwinpop = popWin(url,"cPop","450","540","yes","yes");	
}

// 사진등록후 페이지 리로드
function fnReload(){
	$("mode").value = "categoty";
	pform.action = "tutor.do?mode=categoty";
	pform.submit();
}

// 이전
function fnCancel(){
	$("mode").value = "categoty";
	pform.action = "tutor.do?mode=categoty";
	pform.submit();
}

//-->
</script>
<script for="window" event="onload">
<!--
<%= fileStr %>
	$("job").value = "<%= tutorDamoMap.getString("job") %>";

//-->
</script>
	<script type="text/javascript">
		function goPopup(mode){
			var pop = window.open("/popup/jusoPopup.jsp?mode="+mode,"pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
		}

		function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
				document.pform.newAddr1.value = roadAddrPart1;
				document.pform.newAddr2.value = roadAddrPart2 +" "+ addrDetail;
				document.pform.newHomePost.value = zipNo;
		}
		function jusoCallBack1(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
				document.pform.homeAddr.value = roadAddrPart1 + roadAddrPart2 +" "+ addrDetail;
				document.pform.homePost1.value = zipNo;
				document.pform.homePost2.value = "";
		}
		function jusoCallBack2(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
				document.pform.officeAddr.value = roadAddrPart1 + roadAddrPart2 +" "+ addrDetail;
				document.pform.officePost1.value = zipNo;
				document.pform.officePost2.value = "";
		}				
	</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="chkResno"	id="chkResno"	>
<input type="hidden" name="chkUserId"	id="chkUserId"	>
<input type="hidden" name="type"		id="type"		value="<%= type %>" >
<input type="hidden" name="userno"		id="userno"		value="<%= memberDamoMap.getString("userno") %>" >

<!-- 학력, 전공분야, 경력사항, 저서 저장용 데이타  -->
<input type="hidden" name="d_ocinfo1"		id="d_ocinfo1"	>
<input type="hidden" name="d_ocinfo2"		id="d_ocinfo2"	>
<input type="hidden" name="d_ocinfo3"		id="d_ocinfo3"	>
<input type="hidden" name="d_ocinfo4"		id="d_ocinfo4"	>

<!-- 이전 검색조건  -->
<input type="hidden" name="searchTutorGubun"	id="searchTutorGubun"	value="<%= requestMap.getString("searchTutorGubun")%>">
<input type="hidden" name="searchJob"			id="searchJob"			value="<%= requestMap.getString("searchJob")%>">
<input type="hidden" name="searchAddr"			id="searchAddr"			value="<%= requestMap.getString("searchAddr")%>">
<input type="hidden" name="searchBirth"			id="searchBirth"		value="<%= requestMap.getString("searchBirth")%>">
<input type="hidden" name="searchTutorLevel"	id="searchTutorLevel"	value="<%= requestMap.getString("searchTutorLevel")%>">
<input type="hidden" name="searchSchool"		id="searchSchool"		value="<%= requestMap.getString("searchSchool")%>">
<input type="hidden" name="searchSubjNm"		id="searchSubjNm"		value="<%= requestMap.getString("searchSubjNm")%>">
<input type="hidden" name="searchTname"			id="searchTname"		value="<%= requestMap.getString("searchTname")%>">
<input type="hidden" name="currPage" 			id="currPage"			value="<%= requestMap.getString("currPage")%>">

<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_HOMEPAGE%>'>

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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			
			<!--[s] subTitle -->
			<div class="h10"></div>
			<div class="tit01">
				<h2 class="h2"><img src="/images/bullet003.gif">강사등록</h2>
			</div>
			<div class="h5"></div>
			<!--[e] subTitle -->
      		
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>

						<br>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td>“ * ”가 붙은 것은 필수입력항목입니다.<br><br>
									※ 강사로 등록하기 위해서는 반드시 회원가입이 선행되어야 합니다. 
								</td>
							</tr>
						</table>
					
					
						<br>
						<table class="dataw01">
							<tr>
								<th width="17%">주민등록번호 *</th>
								<td colspan="3">
									<input type="text" name="resno" id="resno" size="14" maxlength="13" class="textfield"  value="<%= memberDamoMap.getString("resno") %>" <%= stateReadonly %> dataform="num!숫자만 입력해야 합니다." >
									<input type="button" value="중복체크" class="boardbtn1" onclick="fnCheckResNo('resno');" <%= displayBtnResno %> >
									<input type="button" value="회원검색" class="boardbtn1" onclick="fnSearchTutorPop();"    <%= displayBtnResno %> >									
									<input type="checkbox" name="chk_foreigner" id="chk_foreigner" value="Y"><font color="red"><b>(체크시 주민번호 체크무시)</b></font>
								</td>
							</tr>
							<tr>
								<th>아이디</th>
								<td colspan="3">
									<input type="text" name="userId" id="userId" size="14" maxlength="12" class="textfield"  value="<%= memberDamoMap.getString("userId") %>" <%= stateReadonly %> >
									<input type="button" value="중복체크" class="boardbtn1" onclick="fnCheckResNo('userId');"  <%= displayBtnResno %> >
								</td>
							</tr>
							<tr>
								<th>사진등록</th>
								<td colspan="3">
									<img src="<%= picImg.equals("") ? "/images/photo_blank.gif" : picImg %>" id ="previewTd" width="95" height="100">									
									<input type="button" value="사진등록" class="boardbtn1" onclick="fnImgUploadPop();">
								</td>
							</tr>
							<tr>
								<th>이름(한글)*</th>
								<td><input type="text" name="name" id="name" size="14" class="textfield" value="<%= memberDamoMap.getString("name") %>" maxlength="20" ></td>
								<th width="17%">이름(한자)</th>
								<td ><input type="text" name="cname" id="cname" size="14" class="textfield" value="<%= tutorDamoMap.getString("cname") %>" maxlength="20" ></td>
							</tr>
							<tr>
								<th>은행명</th>
								<td><input type="text" name="bankname" id="bankname" size="25" class="textfield" value="<%= tutorDamoMap.getString("bankname") %>" maxlength="50"  ></td>
								<th>계좌번호</th>
								<td><input type="text" name="bankno" id="bankno" size="25" class="textfield" value="<%= tutorDamoMap.getString("bankno") %>" maxlength="30" ></td>
							</tr>							
							<tr>
								<th>등급</th>
								<td>
									<%= sbTutorLevelHtml.toString() %>
									<select name="gruCode" id="gruCode">
										<option value="" selected>**선택하세요**</option>
									</select>
								</td>
								<th>담당분야</th>
								<td>
									<%= sbTutorGubunHtml.toString() %>
								</td>
							</tr>
							<tr>
								<th>직업</th>
								<td colspan="3">
									<select name="job" id="job" style="width:120px">
										<option value="">**선택하세요**</option>
										<option value="교수">교수</option>
										<option value="본청 공무원">본청 공무원</option>
										<option value="군구 공무원">군구 공무원</option>
										<option value="중앙/타시도 공무원">중앙/타시도 공무원</option>
										<option value="유관기관">유관기관</option>
										<option value="기타">기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>
									새주소 우편번호</span>
								</th>
								<td colspan="3">
									<input type="text" title="새주소 우편번호" id="newHomePost" name="newHomePost" maxlength="7" style="width:70px" class="textfield" readonly value="<%= memberDamoMap.getString("newhomepost") %>"/>
									<a href="javascript:goPopup();"><img src="/images/skin1/button/btn_search02.gif" class="vm2" alt="검색"/></a>
								</td>
							</tr>
							<tr>
								<th>
									새 주 소</span>
								</th>
								<td colspan="3">
									<input type="text" title="새주소1" id="newAddr1" name="newAddr1" class="input02 w382" value="<%= memberDamoMap.getString("newaddr1") %>"/>
									<input type="text" title="새주소2" id="newAddr2" name="newAddr2" class="input02 w382" value="<%= memberDamoMap.getString("newaddr2") %>"/>
								</td>
							</tr>	
							<tr>
								<th>자택주소</th>
								<td colspan="3">
									<% if("".equals(memberDamoMap.getString("homePost2"))) { %>
										<input type="text" name="homePost1" id="homePost1" maxlength="7" style="width:70px" class="textfield" value="<%= memberDamoMap.getString("homePost1") + memberDamoMap.getString("homePost2") %>" readonly>
										<input type="hidden" name="homePost2" id="homePost2" maxlength="7" style="width:70px" class="textfield" value="">	
									<% } else { %>
										<input type="text" name="homePost1" id="homePost1" maxlength="7" style="width:70px" class="textfield" value="<%= memberDamoMap.getString("homePost1")%>" readonly>
										<input type="text" name="homePost2" id="homePost2" maxlength="7" style="width:70px" class="textfield" value="<%= memberDamoMap.getString("homePost2")%>" readonly>
									<% } %>									
									<a href="javascript:goPopup(1);"><img src="/images/skin1/button/btn_search02.gif" class="vm2" alt="검색"/></a>
									<br>
									<input type="text" name="homeAddr" id="homeAddr" style="width:500px" class="textfield" value="<%= memberDamoMap.getString("homeAddr") %>" maxlength="100" readonly>									
								</td>
							</tr>
							<tr>
								<th>집전화</th>
								<td>
									<input type="text" name="homeTel1" id="homeTel1" maxlength="4" style="width:30px" class="textfield" value="<%= aryHomeTel[0] %>" dataform="num!숫자만 입력해야 합니다." > -
									<input type="text" name="homeTel2" id="homeTel2" maxlength="4" style="width:30px" class="textfield" value="<%= aryHomeTel[1] %>" dataform="num!숫자만 입력해야 합니다." > -
									<input type="text" name="homeTel3" id="homeTel3" maxlength="4" style="width:30px" class="textfield" value="<%= aryHomeTel[2] %>" dataform="num!숫자만 입력해야 합니다." >
								</td>
								<th>휴대폰</th>
								<td>
									<input type="text" name="hp1" id="hp1" maxlength="4" style="width:30px" class="textfield" value="<%= aryHp[0] %>" dataform="num!숫자만 입력해야 합니다." > -
									<input type="text" name="hp2" id="hp2" maxlength="4" style="width:30px" class="textfield" value="<%= aryHp[1] %>" dataform="num!숫자만 입력해야 합니다." > -
									<input type="text" name="hp3" id="hp3" maxlength="4" style="width:30px" class="textfield" value="<%= aryHp[2] %>" dataform="num!숫자만 입력해야 합니다." >
								</td>
							</tr>
							<tr>
								<th>사무실주소</th> 
								<td colspan="3">
									<% if("".equals(memberDamoMap.getString("officePost2"))) { %>
										<input type="text" name="officePost1" id="officePost1" maxlength="7" style="width:70px" class="textfield" value="<%= memberDamoMap.getString("officePost1") + memberDamoMap.getString("officePost2")%>" readonly>	
										<input type="hidden" name="officePost2" id="officePost2" maxlength="7" style="width:70px" class="textfield" value="">
									<% } else { %>
										<input type="text" name="officePost1" id="officePost1" maxlength="7" style="width:70px" class="textfield" value="<%= memberDamoMap.getString("officePost1")%>" readonly>
										<input type="text" name="officePost2" id="officePost2" maxlength="7" style="width:70px" class="textfield" value="<%= memberDamoMap.getString("officePost2")%>" readonly>
									<% } %>								
									
									 
									<a href="javascript:goPopup(2);"><img src="/images/skin1/button/btn_search02.gif" class="vm2" alt="검색"/></a>
									<br>
									<input type="text" name="officeAddr" id="officeAddr" style="width:500px" class="textfield" value="<%= memberDamoMap.getString("officeAddr") %>" maxlength="100" readonly>
								</td>
							</tr>
							<tr>
								<th>직장전화</th>
								<td>
									<input type="text" name="officeTel1" id="officeTel1" maxlength="4" style="width:30px" class="textfield" value="<%= aryOfficeTel[0] %>" dataform="num!숫자만 입력해야 합니다." > -
									<input type="text" name="officeTel2" id="officeTel2" maxlength="4" style="width:30px" class="textfield" value="<%= aryOfficeTel[1] %>" dataform="num!숫자만 입력해야 합니다." > -
									<input type="text" name="officeTel3" id="officeTel3" maxlength="4" style="width:30px" class="textfield" value="<%= aryOfficeTel[2] %>" dataform="num!숫자만 입력해야 합니다." >
								</td>
								<th>팩스번호</th>
								<td>
									<input type="text" name="fax1" id="fax1" maxlength="4" style="width:30px" class="textfield" value="<%= aryFax[0] %>" dataform="num!숫자만 입력해야 합니다." > -
									<input type="text" name="fax2" id="fax2" maxlength="4" style="width:30px" class="textfield" value="<%= aryFax[0] %>" dataform="num!숫자만 입력해야 합니다." > -
									<input type="text" name="fax3" id="fax3" maxlength="4" style="width:30px" class="textfield" value="<%= aryFax[0] %>" dataform="num!숫자만 입력해야 합니다." >
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td colspan="3"><input type="text" name="email" id="email" style="width:250px" class="textfield" value="<%= memberDamoMap.getString("email") %>" maxlength="100" ></td>
							</tr>
							<tr>
								<th>소속</th>
								<td><input type="text" name="tposition" id="tposition" style="width:180px" class="textfield" value="<%= tutorDamoMap.getString("tposition") %>" maxlength="100" ></td>
								<th>직위</th>
								<td><input type="text" name="jikwi" id="jikwi" style="width:180px" class="textfield" value="<%= memberDamoMap.getString("jikwi") %>" maxlength="100" ></td>
							</tr>
							<tr>
								<th>학력</th>
								<td colspan="3">
									<input type="text" name="ocinfo1" id="ocinfo1_0" style="width:350px" class="textfield" maxlength="1000" value="<%= aryHistory1[0] %>" ><br>
									<input type="text" name="ocinfo1" id="ocinfo1_1" style="width:350px" class="textfield" maxlength="1000" value="<%= aryHistory1[1] %>" ><br>
									<input type="text" name="ocinfo1" id="ocinfo1_2" style="width:350px" class="textfield" maxlength="1000" value="<%= aryHistory1[2] %>" >
								</td>
							</tr>
							<tr>
								<th>
									전공분야<br><br>
									<input type="button" value="추 가" class="boardbtn1" onclick="addTextBox('dyBox2');">
								</th>
								<td colspan="3" id="dyBox2">
									<%= sbHistory2.toString() %>									
								</td>
							</tr>
							<tr>
								<th>
									경력사항<br><br>
									<input type="button" value="추 가" class="boardbtn1" onclick="addTextBox('dyBox3');">
								</th>
								<td colspan="3" id="dyBox3">
									<%= sbHistory3.toString() %>									
								</td>
							</tr>
							<tr>
								<th>
									저서 및 주요논문<br><br>
									<input type="button" value="추 가" class="boardbtn1" onclick="addTextBox('dyBox4');">
								</th>
								<td colspan="3" id="dyBox4">
									<%= sbHistory4.toString() %>
								</td>
							</tr>
							<tr>
								<th>강의과목</th>
								<td colspan="3">
									<input type="text" name="subj1" id="subj1" style="width:100px" class="textfield" value="<%= tutorDamoMap.getString("subj1") %>"   readonly>
									<input type="button" value="과목선택" class="boardbtn1" onclick="fnSubjPop('subj1');">
									<input type="button" value="지우기" class="boardbtn1" onclick="$('subj1').value='';">
									<br>
									
									<input type="text" name="subj2" id="subj2" style="width:100px" class="textfield" value="<%= tutorDamoMap.getString("subj2") %>" readonly>
									<input type="button" value="과목선택" class="boardbtn1" onclick="fnSubjPop('subj2');">
									<input type="button" value="지우기" class="boardbtn1" onclick="$('subj2').value='';">
									<br>
									
									<input type="text" name="subj3" id="subj3" style="width:100px" class="textfield" value="<%= tutorDamoMap.getString("subj3") %>" readonly>
									<input type="button" value="과목선택" class="boardbtn1" onclick="fnSubjPop('subj3');">
									<input type="button" value="지우기" class="boardbtn1" onclick="$('subj3').value='';">
									<br>
									
									<input type="text" name="subj4" id="subj4" style="width:100px" class="textfield" value="<%= tutorDamoMap.getString("subj4") %>" readonly>
									<input type="button" value="과목선택" class="boardbtn1" onclick="fnSubjPop('subj4');">
									<input type="button" value="지우기" class="boardbtn1" onclick="$('subj4').value='';">
									<br>
									
									<input type="text" name="subj5" id="subj5" style="width:100px" class="textfield" value="<%= tutorDamoMap.getString("subj5") %>" readonly>
									<input type="button" value="과목선택" class="boardbtn1" onclick="fnSubjPop('subj5');">
									<input type="button" value="지우기" class="boardbtn1" onclick="$('subj5').value='';">
									<br>
									
									<input type="text" name="subj6" id="subj6" style="width:100px" class="textfield" value="<%= tutorDamoMap.getString("subj6") %>" readonly>
									<input type="button" value="과목선택" class="boardbtn1" onclick="fnSubjPop('subj6');">
									<input type="button" value="지우기" class="boardbtn1" onclick="$('subj6').value='';">
									<br>
									
									<input type="text" name="subj7" id="subj7" style="width:100px" class="textfield" value="<%= tutorDamoMap.getString("subj7") %>" readonly>
									<input type="button" value="과목선택" class="boardbtn1" onclick="fnSubjPop('subj7');">
									<input type="button" value="지우기" class="boardbtn1" onclick="$('subj7').value='';">
									<br>																		
								</td>
							</tr>
							<tr>
								<th>강사소개서</th>
								<td>
                                	<jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>						
								</td>
							</tr>					
						</table>
						
						<br>
						<table class="btn01" style="clear:both;">
							<tr>
								<td align="center">
									<input type="button" value="저 장" onclick="fnSave();" class="boardbtn1">
									<input type="button" value="이 전" onclick="fnCancel();" class="boardbtn1">
								</td>
							</tr>
						</table>						
					
						<br><br><br>
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>

