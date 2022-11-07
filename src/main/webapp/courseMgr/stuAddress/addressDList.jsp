<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 동기 주소록 리스트
// date : 2008-07-09
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

	//간단한 과정 기수 정보
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);


	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	//int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("grcode"); i++){

		listStr.append("\n<tr>");

		//교번
		listStr.append("\n	<td rowspan='2'>" + listMap.getString("eduno", i) + "</td>");

		//사진
		String resnoMdf = new MD5(listMap.getString("resno", i)).asHex();
		String img = "/pds/pic/" + resnoMdf;
		if ( new File( Constants.rootPath + Constants.UPLOAD + "/pic/" + resnoMdf ).isFile() )
			tmpStr = "<img src='" + img + "' width='50' height='50' >";
		else
			tmpStr = "사진없음";
		listStr.append("\n	<td rowspan='2'>" + tmpStr + "</td>");
		

		//이름
		listStr.append("\n	<td width='50' class='bg01'>이름</td>");
		listStr.append("\n	<td><span class='txt_bold'>" + listMap.getString("name", i) + "</td>");

		//기관
		listStr.append("\n	<td width='50' class='bg01'>기관</td>");
		listStr.append("\n	<td>" + listMap.getString("deptnm", i) + "</td>");

		//부서
		listStr.append("\n	<td width='50' class='bg01'>부서</td>");
		listStr.append("\n	<td class='br0'>" + listMap.getString("deptsub", i) + "</td>");


		listStr.append("\n</tr>");

		listStr.append("\n<tr>");

		//직급
		listStr.append("\n	<td width='50' class='bg01'>직급</td>");
		listStr.append("\n	<td>" + listMap.getString("jiknm", i) + "</td>");

		//H.P
		listStr.append("\n	<td width='50' class='bg01'>H.P</td>");
		listStr.append("\n	<td>" + listMap.getString("telno", i) + "</td>");


		//E-mail
		listStr.append("\n	<td width='50' class='bg01'>E-mail</td>");
		listStr.append("\n	<td class='br0'>" + listMap.getString("email", i) + "</td>");


		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("grcode") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' style=\"height:100px\"  class='br0'>동기생 정보가 없습니다.</td>");
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

	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 선택하세요!" : grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기";



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
	$("currPage").value = 1;
	go_list();
}
//검색
function go_search(){

	$("currPage").value = 1;
	go_list();
}
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/stuAddress.do";
	pform.submit();

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
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">
<input type="hidden" name="qu"					value="">

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
								<td colspan="3">
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
							</tr>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>


						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif"> <%= grseqNm %> </h2>
						<!--// subTitle -->
						<div class="h5"></div>


						<!--[s] 리스트  -->
						<div class="datatbl01">

							<table class="datah01">
								<thead>
									<tr>
										<th width="50">교번</th>
										<th width="100">사진</th>
										<th class="br0" colspan="6">세부정보</th>
									</tr>
								</thead>

								<tbody>
									<%= listStr.toString() %>
								</tbody>
							</table>

							<div class="paging">
								<%=pageStr%>		
							</div>

						</div>

						
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
</body>

