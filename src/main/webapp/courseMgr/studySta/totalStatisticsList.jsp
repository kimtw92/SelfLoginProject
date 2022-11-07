<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 전체학습현황 엑셀다운로드
// date : 2008-07-25
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

	//수강생 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//과목 리스트
	DataMap subjListMap = (DataMap)request.getAttribute("SUBJ_LIST_DATA");
	subjListMap.setNullToInitialize(true);

	//수강생의 과목별 점수 리스트
	DataMap subjStuPointListMap = (DataMap)request.getAttribute("STUPOINT_LIST_DATA");
	subjStuPointListMap.setNullToInitialize(true);


	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	int tmpInt = 0;
	double tmpDouble = 0;

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr>");

		//번호
		listStr.append("\n	<td>" + (i+1) + "</td>");

		//성명
		listStr.append("\n	<td>" + listMap.getString("name", i) + "</td>");

		//ID
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");

		//기관
		if( listMap.getString("deptnm", i).equals("6280000") )
			tmpStr = listMap.getString("deptnm", i);
		else
			tmpStr = listMap.getString("deptnm", i).replace("인천광역시", "");
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//직급
		listStr.append("\n	<td>" + listMap.getString("jiknm", i) + "</td>");


		//과목별 점수.
		tmpDouble = 0;
		for(int j=0; j < subjListMap.keySize("subj"); j++){

			tmpInt = 0;
			for(int k=0; k < subjStuPointListMap.keySize("subj"); k++){

				//수강생이 같고 과목 정보가 같으면
				if( listMap.getString("userno", i).equals(subjStuPointListMap.getString("userno", k)) && subjListMap.getString("subj", j).equals(subjStuPointListMap.getString("subj", k)) ){
					listStr.append("\n	<td >" + subjStuPointListMap.getString("subjTotpoint", k) + "</td>");
					tmpDouble += HandleNumber.toDouble(subjStuPointListMap.getString("subjTotpoint", k));
					tmpInt++;
					break;
				}
			}
			//수강생 과목별  정보가 없으면 0
			if(tmpInt == 0)
				listStr.append("\n	<td >0</td>");
		}

		if( !memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) ){
			//총점 과목의 합 + 특수 점수(과대 및 부대등)
			tmpDouble += HandleNumber.toDouble(listMap.getString("addpoint", i));
			listStr.append("\n	<td >" + HandleNumber.getCommaPointNumber(tmpDouble) + "</td>");
            listStr.append("\n	<td >" + HandleNumber.toDouble(listMap.getString("avreport", i)) + "</td>");
			listStr.append("\n	<td >" + HandleNumber.toDouble(listMap.getString("stuTotpoint", i)) + "</td>");
           
		}


		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' style=\"height:100px\" class='br0'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

	String subjListStr = "";
	for(int i=0; i < subjListMap.keySize("subj"); i++)
		subjListStr += "<th >" + subjListMap.getString("lecnm", i) + "</th>";


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//페이지 이동
function go_page(page) {
	go_list();
}

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

	$("mode").value = "total_list";

	pform.action = "/courseMgr/studySta.do";
	pform.submit();

}

//엑셀 출력
function go_excel(){

	if( $F("commGrcode") == "" ){
		alert("과정을 먼저 선택해 주세요.");
		return;
	}

	if( $F("commGrseq") == "" ){
		alert("기수를 먼저 선택해 주세요.");
		return;
	}

	$("mode").value = "total_excel";
	$("qu").value = "";

	pform.action = "/courseMgr/studySta.do";
	pform.submit();

}


//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	var commYear	= "<%= requestMap.getString("commYear") %>";
	var commGrCode	= "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq	= "<%= requestMap.getString("commGrseq") %>";
	var commSubj	= "<%= requestMap.getString("commSubj") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, subj)
	var reloading = "grSeq"; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);
	getCommOnloadSubj(reloading, commYear, commGrCode, commGrSeq, commSubj);	// 과목

}


//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
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

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>

						<!-- tab menu -->
						<div class="tabmenu" style="width:100%;">
							<ul class="tabset">
								<a href="javascript:fnGoStudyStaSubjByAdmin();"><li style="cursor:hand;">과목별 학습현황 </li></a>
								<li class="on">전체 학습현황</li>
							<%if( memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN) ){%>
								<a href="javascript:fnGoStudyStaCyberByAdmin();"><li style="cursor:hand;">사이버 학습현황</li></a>
								<a href="javascript:fnGoStudyStaMixByAdmin();"><li style="cursor:hand;">혼합교육 학습현황</li></a>
								<a href="javascript:fnGoStudyStaOnlineByAdmin();"><li style="cursor:hand;">온라인평가현황</li></a>
							<%}%>
							</ul>
						</div>
						<!-- //tab menu -->
						<div class="space01"></div>

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
									<input type="button" value="EXCEL" onclick="go_excel();" class="boardbtn1">
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


						<!--[s] 리스트  -->
						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th>성명</th>
								<th>ID</th>
								<th>기관</th>
								<th>직급</th>
								<%= subjListStr %>
							<%if( !memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) ){%>
								<th class="br0">총점</th>
								<th class="br0">과제점수</th>
								<th class="br0">과제합</th>
							<%}%>
							</tr>
							</thead>

							<tbody>
								<%= listStr.toString() %>
							</tbody>
						</table>
						<!--//리스트  -->	

						<div class="space01"></div>



					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>



				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

