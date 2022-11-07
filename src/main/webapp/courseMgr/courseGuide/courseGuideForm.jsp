<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정안내문관리 리스트
// date : 2008-07-08
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


	//과정 안내 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

	//과정 기수 정보
	DataMap grseqMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqMap.setNullToInitialize(true);


	//버튼 영역
	String buttonStr = "";

	if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")){

		if(requestMap.getString("qu").equals("insert")){ //등록
			buttonStr += "<input type='button' value='과정안내문 저장' onclick=\"go_add();\" class='boardbtn1'>";
		}else{ //수정
			buttonStr += "<input type='button' value='과정안내문 수정' onclick=\"go_modify();\" class='boardbtn1'>";
			buttonStr += "<input type='button' value='과정안내문 삭제' onclick=\"go_delete();\" class='boardbtn1'>";
		}
	}


%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
	go_search();
}
//검색
function go_search(){

	$("mode").value = "form";
	$("qu").value = "search";

	pform.action = "/courseMgr/courseGuide.do";
	pform.submit();

}
//리스트
function go_list(){

	$("mode").value = "list";
	$("qu").value = "";

	$("commGrseq").value = "";

	pform.action = "/courseMgr/courseGuide.do";
	pform.submit();

}


//안내문 설정
function go_modify(grcode, grseq, guideTitle){

	if($F("commGrcode") == "" && $F("commGrseq") == ""){
	   alert("과정 및 기수를 선택하세요!");
	   return;
	}
	if($F("guideTitle") == ""){
	   alert("단계명을 선택해 주세요.");
	   return;
	}

	var isPass = false;
	for (var i = 1; i <= 9; i++) {
		if( (i == 1 || i > 5) )
			continue;
		else{
			if( $("guide"+i).checked ){
				isPass = true;
				break;
			}
		}
	}
	if(!isPass){
	   alert("출력안내문을 선택해 주십시요!");
	   return;
	}


	if(NChecker(document.pform) && confirm("수정 하시겠습니까?")){

		$("mode").value = "exec";
		$("qu").value = "update";

		pform.action = "/courseMgr/courseGuide.do";
		pform.submit();

	}

}


//과정 안내문 추가
function go_add(){

	if($F("commGrcode") == "" && $F("commGrseq") == ""){
	   alert("과정 및 기수를 선택하세요!");
	   return;
	}
	if($F("guideTitle") == ""){
	   alert("단계명을 선택해 주세요.");
	   return;
	}

	var isPass = false;
	for (var i = 1; i <= 9; i++) {

		if( (i == 1 || i > 5) )
			continue;
		else{
			if( $("guide"+i).checked ){
				isPass = true;
				break;
			}
		}
	}
	if(!isPass){
	   alert("출력안내문을 선택해 주십시요!");
	   return;
	}

	if(NChecker(document.pform) && confirm("등록 하시겠습니까?")){

		$("mode").value = "exec";
		$("qu").value = "insert";

		pform.action = "/courseMgr/courseGuide.do";
		pform.submit();

	}

}

//과정 삭제.
function go_delete(){

	if($F("commGrcode") == "" && $F("commGrseq") == ""){
	   alert("과정 및 기수를 선택하세요!");
	   return;
	}

	if(confirm("삭제 하시겠습니까?")){

		$("mode").value = "exec";
		$("qu").value = "delete";

		pform.action = "/courseMgr/courseGuide.do";
		pform.submit();

	}

}

//checkBox 전체 선택시
function go_checkAll(){
	
	for (var i = 1; i <= 9; i++) {
		if( (i == 1 || i > 5) )
			continue;
		else
			$("guide"+i).checked = $("checkAll").checked;
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

	//단계 selected
	$("guideTitle").value = "<%= requestMap.getString("guideTitle") %>";
}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">
<input type="hidden" name="qu"					value="<%= requestMap.getString("qu") %>">


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


<!--[ 코딩 시작 ] ------------------------------------------------------------------------------------------------------>
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>


						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									년도
								</th>
								<td width="20%">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCommGrCode('grSeq');" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th width="80">
									과정명
								</th>
								<td>

									<div id="divCommGrCode" class="commonDivLeft">
										<select name="commGrcode" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>

								</td>
								<td width="100" class="btnr" rowspan="2">
									<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th class="bl0">
									기수명
								</th>
								<td>
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th class="bl0">
									단계명
								</th>
								<td>
									<select name="guideTitle" class="mr10" onChange="go_reload();">
										<option value="">** 단계선택 **</option>
										<option value="1단계">1단계</option>
										<option value="2단계">2단계</option>
										<option value="3단계">3단계</option>
										<option value="4단계">4단계</option>
										<option value="5단계">5단계</option>
										<option value="6단계">6단계</option>
										<option value="7단계">7단계</option>
										<option value="8단계">8단계</option>
										<option value="9단계">9단계</option>
										<option value="10단계">10단계</option>
									</select>
								</td>
							</tr>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>


						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif"> 과정안내문 등록/수정 </h2>
						<!--// subTitle -->
						<div class="h5"></div>





						<!-- date -->
						<table  class="dataw01">
						<%
							//등록시
							if(requestMap.getString("qu").equals("insert")){
						%>
							<tr>
								<th width="20%">날짜 선택</th>
								<td>
									<input type="text" class="textfield" name="gustrDate" value="<%= grseqMap.getString("started") %>" style="width:100px" readonly required="true!과정시작일을 입력해 주십시요.">
									&nbsp;<img src="/images/icon_calen.gif" onclick="fnPopupCalendar('', 'gustrDate');" style="cursor:hand;"/>
									~
									<input type="text" class="textfield" name="guendDate" value="<%= grseqMap.getString("enddate") %>" style="width:100px" readonly required="true!과정종료일을 입력해 주십시요.">
									&nbsp;<img src="/images/icon_calen.gif" onclick="fnPopupCalendar('', 'guendDate');" style="cursor:hand;" />
								</td>
							</tr>
						<%
							//수정시
							}else{
						%>
							<tr>
								<th colspan="2">※ 수정모드에서는 날짜와 출력안내문만 수정이 가능합니다.</th>
							</tr>
							<tr>
								<th width="20%">날짜 선택</th>
								<td>
									<input type="text" class="textfield" name="gustrDate" value="<%= rowMap.getString("gustrDate") %>" style="width:60" readonly required="true!과정시작일을 입력해 주십시요.">
									&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'gustrDate');" style="cursor:hand;">
									~
									<input type="text" class="textfield" name="guendDate" value="<%= rowMap.getString("guendDate") %>" style="width:60" readonly required="true!과정종료일을 입력해 주십시요.">
									&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'guendDate');" style="cursor:hand;">
								</td>
							</tr>
						<%
							} //end if
						%>
							<tr>
								<th>출력 안내문 선택<br />
									<input type="checkbox" class="chk_01" name="checkAll" id="checkAll" onClick="go_checkAll();" value="Y" ><span class="txt_normal"><label for="checkAll">전체선택</label></span>
								</th>
								<td>
									<ul class="coment01">
										<!-- <li>
											<input type="checkbox" class="chk_01" name="guide1" id="guide1" value="Y" <%//= rowMap.getString("guide1").equals("Y") ? "checked" : ""%>>
											<label for="guide1">① 교육계획</label>
										</li> -->
										<li>
											<input type="checkbox" class="chk_01" name="guide2" id="guide2" value="Y" <%= rowMap.getString("guide2").equals("Y") ? "checked" : ""%>>
											<label for="guide2">① 교과목 편성시간 및 강사</label>
										</li>
										<li>
											<input type="checkbox" class="chk_01" name="guide3" id="guide3" value="Y" <%= rowMap.getString("guide3").equals("Y") ? "checked" : ""%>>
											<label for="guide3">② 교육시간표</label>
										</li>
										<li>
											<input type="checkbox" class="chk_01" name="guide4" id="guide4" value="Y" <%= rowMap.getString("guide4").equals("Y") ? "checked" : ""%>>
											<label for="guide4">③ 교육생(입교생)현황</label>
										</li>
										<li>
											<input type="checkbox" class="chk_01" name="guide5" id="guide5" value="Y" <%= rowMap.getString("guide5").equals("Y") ? "checked" : ""%>>
											<label for="guide5">④ 교육생(입교자)명단</label>
										</li>
										<!-- <li>
											<input type="checkbox" class="chk_01" name="guide6" id="guide6" value="Y" <%//= rowMap.getString("guide6").equals("Y") ? "checked" : ""%>>
											<label for="guide6">⑥ 교육훈련평가</label>
										</li>
										<li>
											<input type="checkbox" class="chk_01" name="guide7" id="guide7" value="Y" <%//= rowMap.getString("guide7").equals("Y") ? "checked" : ""%>>
											<label for="guide7">⑦ 분임별 지도교수 및 교육생훈련</label>
										</li>
										<li>
											<input type="checkbox" class="chk_01" name="guide8" id="guide8" value="Y" <%//= rowMap.getString("guide8").equals("Y") ? "checked" : ""%>>
											<label for="guide8">⑧ 교육생 학생수칙규정(감점기준표)</label>
										</li>
										<li>
											<input type="checkbox" class="chk_01" name="guide9" id="guide9" value="Y" <%//= rowMap.getString("guide9").equals("Y") ? "checked" : ""%>>
											<label for="guide9">⑨ 악보이미지</label>
										</li> -->
									</ul>
								</td>
							</tr>
						</table>
						<!-- //date -->

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<%= buttonStr %>
									<input type="button" value="목록" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->
						<div class="space01"></div> 
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

</body>

