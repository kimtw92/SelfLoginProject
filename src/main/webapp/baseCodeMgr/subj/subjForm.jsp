<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 일반과목 등록
// date  : 2008-06-03
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
	
	
	System.out.println("sUform requestMap =========== " + requestMap);

	
	
	
	
	String mode = "";
	if(requestMap.getString("mode").equals("sform")){
		mode = "sInsert";
	}else{
		mode = "sUpdate";
	}
	
	
	System.out.println("requestMap 222 ===========  " + requestMap);
	
	
	
	
	
	String strSubTitle = "일반과목 등록";
	String btnTitle = "등 록";
	String btnDeleteDisplay = " style='display:none' ";
	String delYn = "";
	
	// 업데이트 모드시 값 저장용
	String subj = "";				// 과목코드
	String subject_name = "";		// 과목명 
	String subjgubun = "";			// 과목분류
	String subjtype = "N";			// 과목유형
	String fNew = "Y";				// NEW 표시
	String openedugubun = "N";		// 공개강좌여부
	String useYn = "Y";				// 사용여부
	String orgBookFile = "";		// 부교재 파일명 (저장된 파일명)
	String orgProFile = "";			// 학습프로그램 파일명 (저장된 파일명)
	
	String language = "N";			// 공인어학여부
	String recom_yn = "N";			// 추천과목여부
	String evalutegubun = "";		// 평가유형
	
	String preview = "없음";
	String fileDownByBook = "";
	String fileDownByPro = "";
	
	String downFileDownByBook = "";
	String downFileDownByPro = "";
	
	String limit = "";
	String limitTime = "";
	String lcmsHeight = "";
	String lcmsWidth = "";
	String menuyn = "";
	String menunum = "";
	String devOrg = "";
	String devYear = "";

	String contentMappingStr = ""; //과목에 매핑된 콘텐츠 매핑 정보
	String contentMappingCodeStr = "";

	if(requestMap.getString("mode").equals("sUform")){
		// 수정모드상태임.
		
		strSubTitle = "일반과목 수정";
		btnTitle = "수 정";
		btnDeleteDisplay = "";
		
		DataMap subjRowMap = (DataMap)request.getAttribute("SUBJROW_DATA");
		subjRowMap.setNullToInitialize(true);
		
		if(subjRowMap.keySize("subj") > 0){
			
			subj = subjRowMap.getString("subj");
			subject_name = subjRowMap.getString("subjnm");
			subjgubun = subjRowMap.getString("subjgubun");
			subjtype = subjRowMap.getString("subjtype");
			fNew = subjRowMap.getString("fNew");
			openedugubun = subjRowMap.getString("openedugubun");
			useYn = subjRowMap.getString("useYn");
			language = subjRowMap.getString("language");
			recom_yn = subjRowMap.getString("recomYn");
			evalutegubun = subjRowMap.getString("evalutegubun");
			
			orgBookFile = subjRowMap.getString("bookFilename");
			orgProFile = subjRowMap.getString("proFilename");
			
			devOrg = subjRowMap.getString("devorg");
			devYear = subjRowMap.getString("devyear");
			
			if( subjRowMap.getString("countDelyn").equals("0")){
				delYn = "Y";				
			}
			
			// 맛보기 제공
			if( subjtype.equals("Y") ){
				preview = "<a href=\"javascript:fnSample('" + subj + "');\">보기</a>";	
			}
			
			if(!orgBookFile.equals("")){				
				fileDownByBook = "<br><a href=\"javascript:fnFileDown('1');\">" + orgBookFile + "</a><br><br>";
				
			}
			if(!orgProFile.equals("")){
				fileDownByPro = "<br><a href=\"javascript:fnFileDown('2');\">" + orgProFile + "</a><br><br>";	
			}

			limit = subjRowMap.getString("limit");
			limitTime = subjRowMap.getString("limitTime");
			lcmsHeight = subjRowMap.getString("lcmsHeight");
			lcmsWidth = subjRowMap.getString("lcmsWidth");
			menuyn = subjRowMap.getString("menuyn");
			menunum = subjRowMap.getString("menunum");


		}

		DataMap contentMappingListMap = (DataMap)request.getAttribute("COTENTMAPPING_LIST_DATA");
		contentMappingListMap.setNullToInitialize(true);

		for(int i=0; i < contentMappingListMap.keySize("mappingSeq"); i++){
			contentMappingStr += "[" + contentMappingListMap.getString("dates", i) + "] " + contentMappingListMap.getString("orgTitle", i) + "\n";
			contentMappingCodeStr += contentMappingListMap.getString("orgDir", i) + ",," + contentMappingListMap.getString("orgTitle", i) + "|";
		}
		
	}
	
	
	DataMap lcmsCateMap = (DataMap)request.getAttribute("LCMSIMAGECATE_LIST_DATA");
	lcmsCateMap.setNullToInitialize(true);
		
	String lcmsCateStr = "";
	String tmpStr = "";
	for(int i=0; i < lcmsCateMap.keySize("imgNo"); i++){

		tmpStr = menunum.equals(lcmsCateMap.getString("imgCode", i)) ? "selected" : "";
		lcmsCateStr += "<option value='" + lcmsCateMap.getString("imgCode", i) + "' " + tmpStr + ">" + lcmsCateMap.getString("imgName", i) + "</option>";

	}

	
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript" type="text/JavaScript">



// 저장
function fnSave(){

	if(NChecker($("pform"))){

		
		var tmp_subjtype = "";
		if( Form.Element.getValue("subjtype_N") != null ){
			tmp_subjtype = Form.Element.getValue("subjtype_N");
		}else if( Form.Element.getValue("subjtype_Y") != null ){
			tmp_subjtype = Form.Element.getValue("subjtype_Y");
		}else if( Form.Element.getValue("subjtype_S") != null ){
			tmp_subjtype = "N";
		}else if( Form.Element.getValue("subjtype_M") != null ) {
			tmp_subjtype = Form.Element.getValue("subjtype_M");
		}
		
		$("evalutegubun").value = tmp_subjtype;

		$("mode").value = "<%= mode %>";
		
		pform.action="/baseCodeMgr/subj.do?mode="+$("mode").value;
		pform.submit();
	}
}

// 삭제
function fnDelete(){
	
	<%	if(delYn.equals("Y")){ 
			if( btnDeleteDisplay.equals("") ){ 
	%>
		var msg = "삭제하시겠습니까 ?\n\n※ 해당 과목에 강의가 개설되어 있으면 삭제할 수 없습니다.";
		if(confirm(msg)){
			$("mode").value = "delete";
			pform.action="/baseCodeMgr/subj.do?mode="+$("mode").value;
			pform.submit();
		}
	<%
			}
		}else{
			out.println("alert('해당 과목에 강의가 개설되어 있으면 삭제할 수 없습니다.');");
		}
	%>	
	
}

// 취소
function fnCancel(){
	$("mode").value = "list";
	pform.action="/baseCodeMgr/subj.do?mode="+$("mode").value;
	pform.submit();
}

// 맛보기 (이후에 category.js 로 이동시켜야 함)
function fnSample(subj){
	//alert(subj);
	//alert("맛보기 팝업.. LCMS 관계로 미완성");
}

function fnFileDown(ptype){
	
	if(ptype == "1"){
		$("downFileName").value = $F("orgBookFile");
	}else{
		$("downFileName").value = $F("orgProFile");
	}
	
	var fn = $F("downFileName");
	var path = $F("downPath");
	
	fnGoFileDown(fn, path, "<%= Constants.UPLOAD %>");
	
}

//과목유형 클릭시
function go_clickCyber(values) {
	var scormMappingDiv = $("ID_scormMapping");
	var scormMappingDiv2 = $("ID_scormMapping2");
	if (values == "Y" || values == "M") {
		if(values =="Y") {
			scormMappingDiv2.style.display = "block";
		} else {
			scormMappingDiv2.style.display = "none";
		}
		scormMappingDiv.style.display = "block";
	} else {
		scormMappingDiv2.style.display = "none";
		scormMappingDiv.style.display = "none";
	}
}

//컨텐츠 매핑
function go_contentMapping() {
	var mode = "";
	var name = "";
	var width  = "";
	 
	if($("subjtype_M").checked && "<%=mode%>" == "sInsert")	{	//동영상
		mode = "contentMappingMov";	
		name = "pop_contentMappingMov";
		width = "400";
	} else if($("subjtype_M").checked && "<%=mode%>" == "sUpdate") {
		mode = "contentMappingMovU";	
		name = "pop_contentMappingMovU";
		width = "400";
	} else {						//사이버
		mode = "contentMapping";
		name = "pop_contentMapping";
		width = "800";
	}
	
	var subj = $F("subj");
	var url = "/baseCodeMgr/subj.do?mode=" + mode + "&subj=" + subj;

	//popWin(url, pop_name, width, height, scroll, status);
	popWin(url, name, width, "450", "0", "0");

}


</script>

<script for="window" event="onload">
	$("subjgubun").value = "<%= subjgubun %>";

	go_clickCyber('<%= subjtype %>');
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">


<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode" 		id="mode"		value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="sel_gubun"	id="sel_gubun"	value="S">
<input type="hidden" name="app_gubun"	id="app_gubun"	value="M">
<input type="hidden" name="UPLOAD_DIR"	id="UPLOAD_DIR"	value="<%= Constants.NAMOUPLOAD_SUBJDATA%>">
<input type="hidden" name="RENAME_YN"	id="RENAME_YN"	value="N">

<input type="hidden" name="subj"		id="subj"		value="<%= subj %>">

<!-- 이전 검색결과 유지 -->
<input type="hidden" name="s_indexSeq" 	id="s_indexSeq"	value="<%= requestMap.getString("s_indexSeq") %>">
<input type="hidden" name="s_useYn" 	id="s_useYn"	value="<%= requestMap.getString("s_useYn") %>">
<input type="hidden" name="s_subType" 	id="s_subType"	value="<%= requestMap.getString("s_subType") %>">
<input type="hidden" name="s_searchTxt" id="s_searchTxt"	value="<%= requestMap.getString("s_searchTxt") %>">

<!-- 이전 페이징 유지 -->
<input type="hidden" name="currPage" 	id="currPage"	value="<%= requestMap.getString("currPage")%>">


<!-- 제거된 object -->
<input type="hidden" name="evalutegubun" 	id="evalutegubun" 	value="<%= evalutegubun %>">	<!-- 평가유형 -->
<input type="hidden" name="language" 		id="language" 		value="<%= language %>"> 		<!-- 공인어학여부 -->
<input type="hidden" name="recom_yn" 		id="recom_yn" 		value="<%= recom_yn %>"> 		<!-- 추천과목여부 -->

<!-- 저장된 파일명 -->
<input type="hidden" name="orgBookFile" 	id="orgBookFile"	value="<%= orgBookFile %>">
<input type="hidden" name="orgProFile" 		id="orgProFile"		value="<%= orgProFile %>">

<!-- 파일 다운로드용 -->
<input type="hidden" name="downFileName" 	id="downFileName">
<input type="hidden" name="downPath" 		id="downPath"		value="<%= Constants.NAMOUPLOAD_SUBJDATA%>">


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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong><%= strSubTitle %></strong>
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
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>과목명</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="text" name="subject_name" id="subject_name" class="textfield" size="80" required="true!과목명이 없습니다." maxchar="45!글자수가 많습니다." value="<%= subject_name %>">
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>과목분류</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<select name="subjgubun" style="font-size:9pt">
										<option value="">기타</option>	
										<option value="01">소양분야</option>
										<option value="02">직무분야</option>
										<option value="03">행정및기타</option>
									</select>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>과목유형</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="subjtype" id="subjtype_N" value="N" <%= subjtype.equals("N") ? "checked" : "" %> onclick="javascript:go_clickCyber('N');">&nbsp;<label for="subjtype_N">집합</label>&nbsp;
									<input type="radio" name="subjtype" id="subjtype_Y" value="Y" <%= subjtype.equals("Y") ? "checked" : "" %> onclick="javascript:go_clickCyber('Y');">&nbsp;<label for="subjtype_Y" >사이버</label>&nbsp;
									<input type="radio" name="subjtype" id="subjtype_S" value="S" <%= subjtype.equals("S") ? "checked" : "" %> onclick="javascript:go_clickCyber('S');">&nbsp;<label for="subjtype_S" >특수</label>
									<input type="radio" name="subjtype" id="subjtype_M" value="M" <%= subjtype.equals("M") ? "checked" : "" %> onclick="javascript:go_clickCyber('M');">&nbsp;<label for="subjtype_M" >동영상</label>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td colspan="2" align="left">
									<DIV id="ID_scormMapping" style="display:none;">
										<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">										
											<tr>
												<td width="15%" align="center" height="24" class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>매핑정보</strong></td>
												<td class="tableline21" align="left" style="padding:0 0 0 10">
													
													<textarea name="scormMappingName" id='scormMappingName' class="textfield" rows="10" style="height:100px;width:80%" readonly="readonly"><%= contentMappingStr %></textarea>
													<input type="hidden" name="oldSubjtype" id="oldSubjtype" value="<%= subjtype %>">
													<input type="hidden" name="oldArrayOrgDir" id="oldArrayOrgDir" value="<%= contentMappingCodeStr %>">
													<input type="hidden" name="arrayOrgDir" id="arrayOrgDir" value="<%= contentMappingCodeStr %>">
													<input type="button" value="콘텐츠매핑" onclick="go_contentMapping();" class="boardbtn1" >
												</td>
											</tr>
											<tr>
												<td width="15%" align="center" height="24" class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>학습창템플릿</strong></td>
												<td class="tableline21" align="left" style="padding:0 0 0 10">
													<select name="menunum">
														<%= lcmsCateStr %>
													</select>
												</td>
											</tr>
											<tr>
												<td width="15%" align="center" height="24" class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>학습제한</strong></td>
												<td class="tableline21" align="left" style="padding:0 0 0 10">
													1일차시제한 <input type="text" name="limit" class="textfield" size="10" onkeyDown="go_commNumCheck()" value="<%= limit %>" maxlength="2">차시(0:제한없음), &nbsp;
													시간제한 <input type="text" name="limitTime" class="textfield" size="10" onkeyDown="go_commNumCheck()" value="<%= limitTime %>" maxlength="4">분(0:제한없음)
												</td>
											</tr>
											<tr>
												<td width="15%" align="center" height="24" class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>학습창 설정</strong></td>
												<td class="tableline21" align="left" style="padding:0 0 0 10">
													높이 <input type="text" name="lcmsHeight" class="textfield" size="10" onkeyDown="go_commNumCheck()" value="<%= lcmsHeight %>" maxlength="4">&nbsp;&nbsp;&nbsp;
													너비 <input type="text" name="lcmsWidth" class="textfield" size="10" onkeyDown="go_commNumCheck()" value="<%= lcmsWidth %>" maxlength="4">
												</td>
											</tr>
											<tr>
												<td width="15%" align="center" height="24" class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>학습창 메뉴</strong></td>
												<td class="tableline21" align="left" style="padding:0 0 0 10">
													<input type="radio" name="menuyn" id="menuy" value="Y" <%= menuyn.equals("Y") ? "checked" : "" %> >&nbsp;<label for="menuy">Yes</label>&nbsp;
													<input type="radio" name="menuyn" id="menun" value="N" <%= !menuyn.equals("Y") ? "checked" : "" %> >&nbsp;<label for="menun">No</label>
												</td>
											</tr>
											<tr bgcolor="#FFFFFF">
											<td colspan="2" align="left">
												<DIV id="ID_scormMapping2" style="display:none;">
													<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">										
														<tr>
															<td width="15%" align="center" height="24" class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>개발기관</strong></td>
															<td class="tableline21" align="left" style="padding:0 0 0 10">
																<input type="text" name="devorg" id="devorg" maxlength="30" value="<%= devOrg %>" />
															</td>
														</tr>
														<tr>
														<td width="15%" align="center" height="24" class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>개발년도</strong></td>
														<td class="tableline21" align="left" style="padding:0 0 0 10">
															<input type="text" name="devyear" id="devyear" maxlength="8" value="<%= devYear %>" style="ime-mode:disabled;"/> ex) 20110501
														</td>
													</tr>
													</table>
												</DIV>
											</td>
										</tr>
											<tr bgcolor="#FFFFFF">
												<td colspan="2" align="left">
													<DIV id="ID_scormMapping2" style="display:none;">
														<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">										
															<tr>
																<td width="15%" align="center" height="24" class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>매핑정보</strong></td>
																<td class="tableline21" align="left" style="padding:0 0 0 10">
																	<input type="text" name="oldSubjtype1" id="oldSubjtype">
																	<input type="text" name="oldArrayOrgDir1" id="oldArrayOrgDir">
																</td>
															</tr>
														</table>
													</DIV>
												</td>
										</table>
									</DIV>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>New표시</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="f_new" id="f_new_Y" value="Y" <%= fNew.equals("Y") ? "checked" : "" %> >&nbsp;<label for="f_new_Y">Yes</label>&nbsp;
									<input type="radio" name="f_new" id="f_new_N" value="N" <%= fNew.equals("N") ? "checked" : "" %> >&nbsp;<label for="f_new_N">No</label>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>맛보기제공</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<%= preview %>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>공개강좌여부</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="openedugubun" id="openedugubun_Y" value="Y" <%= openedugubun.equals("Y") ? "checked" : "" %> >&nbsp;<label for="openedugubun_Y">Yes</label>&nbsp;
									<input type="radio" name="openedugubun" id="openedugubun_N" value="N" <%= openedugubun.equals("N") ? "checked" : "" %> >&nbsp;<label for="openedugubun_N">No</label>								
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>사용여부</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="use_yn" id="use_y" value="Y" <%= useYn.equals("Y") ? "checked" : "" %> >&nbsp;<label for="use_y">Yes</label>&nbsp;
									<input type="radio" name="use_yn" id="use_n" value="N" <%= useYn.equals("N") ? "checked" : "" %> >&nbsp;<label for="use_n">No</label>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>부교재</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<%= fileDownByBook %>
									<input type="file" name="bookFileNm" id="bookFileNm" class="textfield" style="width:50%;">
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>학습프로그램</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<%= fileDownByPro %>
									<input type="file" name="proFileNm" id="proFileNm" class="textfield" style="width:50%;">
								</td>
							</tr>
							
						</table>
						
						
						<!--[s] 하단 버튼  -->
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="center">
									<input type="button" value="<%= btnTitle %>" onclick="fnSave();"   class="boardbtn1" >&nbsp;
									<input type="button" value="삭 제" onclick="fnDelete();" class="boardbtn1" <%= btnDeleteDisplay %> >&nbsp;
									<input type="button" value="취 소" onclick="fnCancel()"  class="boardbtn1" >
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




