<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정안내문관리 리스트
// date : 2008-07-07
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


	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("grcode"); i++){

		listStr.append("\n<tr>");

		//No
		listStr.append("\n	<td>" + (pageNum+i+1) + "</td>");

		//과정명
		listStr.append("\n	<td>" + listMap.getString("grcodenm", i) + "</td>");

		//기수
		tmpStr = StringReplace.subString(listMap.getString("grseq", i), 0, 4) + "년 " + StringReplace.subString(listMap.getString("grseq", i), 4, 6) + "기";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//기간
		listStr.append("\n	<td>" + listMap.getString("gustrDate", i) + " ~ " + listMap.getString("guendDate", i) + "</td>");

		//단게명
		listStr.append("\n	<td>" + listMap.getString("guideTitle", i) + "</td>");

		tmpStr = "";
		//선택항목
		/*
		if( listMap.getString("guide1", i).equals("Y") )
			tmpStr += "<a title='교육계획'>①</a> ";
		if( listMap.getString("guide2", i).equals("Y") )
			tmpStr += "<a title='교과목 편성시간 및 강사'>②</a> ";
		if( listMap.getString("guide3", i).equals("Y") )
			tmpStr += "<a title='교육시간표'>③</a> ";
		if( listMap.getString("guide4", i).equals("Y") )
			tmpStr += "<a title='교육생(입교자)현황'>④</a> ";
		if( listMap.getString("guide5", i).equals("Y") )
			tmpStr += "<a title='교육생(입교자)명단'>⑤</a> ";
		if( listMap.getString("guide6", i).equals("Y") )
			tmpStr += "<a title='교육훈련평가'>⑥</a> ";
		if( listMap.getString("guide7", i).equals("Y") )
			tmpStr += "<a title='분임별 지도교수 및 교육생 현황'>⑦</a> ";
		if( listMap.getString("guide8", i).equals("Y") )
			tmpStr += "<a title='교육생 학생수칙규정(감점기준표)'>⑧</a> ";
		if( listMap.getString("guide9", i).equals("Y") )
			tmpStr += "<a title='악보이미지'>⑨</a> ";
		*/
		if( listMap.getString("guide2", i).equals("Y") )
			tmpStr += "<a title='교과목 편성시간 및 강사'>①</a> ";
		if( listMap.getString("guide3", i).equals("Y") )
			tmpStr += "<a title='교육시간표'>②</a> ";
		if( listMap.getString("guide4", i).equals("Y") )
			tmpStr += "<a title='교육생(입교자)현황'>③</a> ";
		if( listMap.getString("guide5", i).equals("Y") )
			tmpStr += "<a title='교육생(입교자)명단'>④</a> ";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//미리보기
		tmpStr = "<input type='button' value='미리보기' class='boardbtn1' onClick=\"javascript:go_preview('"+listMap.getString("grcode", i)+"', '"+listMap.getString("grseq", i)+"', '"+listMap.getString("guideTitle", i)+"')\">";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//설정
		tmpStr = "<input type='button' value='설정' class='boardbtn1' onClick=\"javascript:go_modify('"+listMap.getString("grcode", i)+"', '"+listMap.getString("grseq", i)+"', '"+listMap.getString("guideTitle", i)+"')\">";
		listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");

		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")





	//row가 없으면.
	if( listMap.keySize("grcode") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' height='100' class='br0'>등록된 과정안내문이 없습니다.</td>");
		listStr.append("\n</tr>");

	}


	//페이징 String
	String pageStr = "";
	if(listMap.keySize("grcode") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
	go_list();
}
//검색
function go_search(){
	$("currPage").value = "1";
	go_list();
}
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/courseGuide.do";
	pform.submit();

}


//미리보기 버튼 클릭.
function go_preview(grcode, grseq, guideTitle){

	var menuId = $F("menuId");
	var mode = "preview";

	var url = "/courseMgr/courseGuide.do?mode=" + mode + "&menuId=" + menuId + "&grcode=" + grcode + "&grseq=" + grseq + "&guideTitle=" + guideTitle;

	//popWin(url, "pop_guidePreview", "500", "400", "1", "");
	popWin(url, "pop_guidePreview", "1000", "700", "1", "");

}

//안내문 설정
function go_modify(grcode, grseq, guideTitle){


	$("mode").value = "form";
	$("qu").value = "update";

	$("guideTitle").value = guideTitle;
	$("commGrcode").value = grcode;
	$("commGrseq").value = grseq;

	pform.action = "/courseMgr/courseGuide.do";
	pform.submit();

}


//과정 안내문 추가
function go_add(){

	if($F("commYear") == "" && $F("commGrcode") == ""){
	   alert("년도와 과정을 선택하세요!");
	   return;
	}

	$("mode").value = "form";
	$("qu").value = "insert";

	$("guideTitle").value = "";
	$("commGrseq").value = "";

	pform.action = "/courseMgr/courseGuide.do";
	pform.submit();

}



//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = ""; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);

}

//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">
<input type="hidden" name="qu"					value="">

<input type="hidden" name="guideTitle"			value="">
<input type="hidden" name="commGrseq"			value="">

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
										<select name="commYear" onChange="getCommGrCode('');" class="mr10">
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
								<td width="100" class="btnr">
									<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>

						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif"> 과목안내문 리스트 </h2>
						<!--// subTitle -->
						<div class="h5"></div>

						<div class="infoset" style="width:615px;">
							<div class="left"><h3 class="h3" >※ 참고사항 :</h3></div>
							<div class="right">
								<ul class="coment01">
									<li>① 교과목 편성시간 및 강사, ②교육시간표  ③ 교육생(입교자)현황 </li>
									<li>④ 교육생(입교자)명단</li>
								</ul>
							</div>
						</div>
						<div class="h5"></div>

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
								<tr>
									<th>No</th>
									<th>과정명</th>
									<th>기수</th>
									<th>기간</th>
									<th>단계명</th>
									<th>선택항목</th>
									<th>미리보기</th>
									<th class="br0">설정</th>
								</tr>
							</thead>

							<tbody>
								<%= listStr %>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	

						<div class="paging">
							<%=pageStr%>
						</div>

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="과정안내문 추가" onclick="go_add();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  --> 
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

