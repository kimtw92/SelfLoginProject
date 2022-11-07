<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육생(입교자) 조회
// date : 2008-07-01
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
	//PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	//int pageNum = (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	int totalCnt = 0; //pageNavi.getTotalCnt();


	//간단한 과정 기수 정보
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	//기관 리스트
	DataMap deptListMap = (DataMap)request.getAttribute("DEPT_LIST_DATA");
	deptListMap.setNullToInitialize(true);

	//기관담당자 일경우 기관명
	String deptnmStr = (String)request.getAttribute("DEPTNM_STRING_DATA");

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr>");


		//교번
		listStr.append("\n	<td>" + listMap.getString("eduno", i) + "</td>");

		//CheckBox
		tmpStr = "<input type='checkbox' name=\"userno[]\"	value='" + listMap.getString("userno", i) + "'>";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//아이디
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");

		//기관
		listStr.append("\n	<td>" + listMap.getString("deptnm", i) + "</td>");

		//소속
		listStr.append("\n	<td>" + listMap.getString("deptsub", i) + "</td>");

		//직급
		listStr.append("\n	<td>" + listMap.getString("jiknm", i) + "</td>");

		//이름
		listStr.append("\n	<td>" + listMap.getString("name", i) + "</td>");

		//전화
		listStr.append("\n	<td>" + listMap.getString("hp", i) + "</td>");

		//성별
		listStr.append("\n	<td>" + listMap.getString("sex", i) + "</td>");

		//나이
		listStr.append("\n	<td>" + listMap.getString("age", i) + "</td>");

		//수정
		tmpStr = "<input type='button' value='수정' class='boardbtn1' onclick=\"go_modify('" + listMap.getString("userno", i) + "');\" >";
		listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");


		listStr.append("\n</tr>");
		totalCnt ++;
	} //end for listMap.keySize("userno")



	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' style=\"height:100px\" class='br0'>검색된 학생이 없습니다</td>");
		listStr.append("\n</tr>");

	}

	//페이징 String
	/*
	String pageStr = "";
	if(listMap.keySize("userno") > 0){
		pageStr += "<div class='paging'>";
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
		pageStr += "</div>";
	}
    */
	//기관 리스트.
	String deptSelStr = "";
	for(int i=0; i < deptListMap.keySize("dept"); i++){
		if(i == 0)
			deptSelStr += "<select name='dept' class='mr10'><option value=''>전체조회</option>";
		tmpStr = requestMap.getString("dept").equals(deptListMap.getString("dept", i)) ? "selected" : "";
		deptSelStr += "<option value=\"" + deptListMap.getString("dept", i) + "\" " + tmpStr + ">" + deptListMap.getString("deptnm", i) + "</option>";
	}
	if( !deptSelStr.equals("") )
		deptSelStr += "</select>";



	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 선택하세요!" : grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기 교육생 명단";

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
	$("currPage").value = "1";
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

	pform.action = "/courseMgr/stuEnter.do";
	pform.submit();

}



//수정
function go_modify(userno){


	var mode = "app_form";
	var menuId = $F("menuId");

	var grcode = $F("grcode");
	var grseq = $F("grseq");


	var url = "/courseMgr/stuEnter.do?mode=" + mode + "&menuId=" + menuId + "&grcode=" + grcode + "&grseq=" + grseq + "&userno=" + userno;

	popWin(url, "pop_studentHistView", "420", "300", "0", "");

}

function listSelectAll(){

	var obj = document.getElementsByName("userno[]");
	
	for(i=0;i<obj.length;i++){

		obj[i].checked = ($("checkAll").checked);
	
	}
}


//교번 부여
function go_eduNo(year, grcode, grseq, grcodenm){


	if(grcode == "" || grseq == ""){
	   alert("과정과 기수를 선택하세요!");
	   return;
	}

	if(confirm(grcodenm+'['+grseq+'기수]의 교번을 부여하시겠습니까?\n교번을 부여하게 되면 이전에 부여되었던 교번은 삭제됩니다.') == true){

		var objAjax = new Object();
		objAjax.url = "/courseMgr/lectureApply.do";
		objAjax.pars = "mode=ajax_exec&qu=eduno"+"&year="+ year +"&grcode="+ grcode + "&grseq=" + grseq;
		objAjax.aSync = true; 
		objAjax.targetDiv = "";
		objAjax.successMsg = "교번이 재부여되었습니다.";
		objAjax.successFunc = "go_search();";

		//alert("1");
		go_ajaxCommonObj(objAjax); //Ajax 통신.

	}
}

//SMS 발송
function go_sendSms(){

	if( $F("grcode") == "" || $F("grseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}

	var obj = document.getElementsByName("userno[]");
	var isPass = false;
	for(i=0;i<obj.length;i++){
		if(obj[i].checked){
			isPass = true;
			break;
		}
	}

	if(!isPass){
		alert("발송할 수강생을 선택하세요!");
		return;
	}

	popWin("", "pop_sendSms", "800", "600", "1", "");

	
	$("mode").value = "sms_list";
	$("qu").value = "";

	pform.action = "/courseMgr/stuEnter.do";
	pform.target = "pop_sendSms";
	pform.submit();
	pform.target = "";

}



//엑셀 출력하기.
function go_excel(){

	if( $F("commGrcode") == "" || $F("commGrseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}

	$("mode").value = "list_excel";
	$("qu").value = "";

	pform.action = "/courseMgr/stuEnter.do";
	pform.submit();

}


//출력
function go_print(){

	var grcode = $F("grcode");
	var grseq = $F("grseq");
	var dapcode = "";
	var dept = "";
	if( "<%= memberInfo.getSessClass()%>" != "<%= Constants.ADMIN_SESS_CLASS_ADMIN %>" 
			&& "<%= memberInfo.getSessClass()%>" != "<%= Constants.ADMIN_SESS_CLASS_COURSE %>" 
			&& "<%= memberInfo.getSessClass()%>" != "<%= Constants.ADMIN_SESS_CLASS_COURSEMAN %>" ) {
		dept = "<%= memberInfo.getSessDept()%>";
		dapcode = '<%= (String)session.getAttribute("sess_ldapcode")%>';
	}
	
	if(grcode == "" || grseq == ""){
		alert("과정과 기수를 선택하세요!");
		return;
	}
	// iframe을 사용하지 않고 바로 팝업으로 리포팅을 띄울 경우
	popAI('http://<%= Constants.AIREPORT_URL %>/report/report_36.jsp?p_grcode=' + grcode+'&p_grseq=' + grseq+'&p_dept=' + dept + '&p_dapcode=' + dapcode);
}



//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = ""; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);

}

//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="qu"					value="">
<input type="hidden" name="userno"				value="">

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">

<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">


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
										<select name="commYear" onChange="getCommGrCode('subj');" class="mr10">
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


						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif"> <%= grseqNm %> </h2>
						<!--// subTitle -->
						<div class="h5"></div>

						<div class="tit0101">
							기관 <%= deptnmStr %> <%= deptSelStr %>
							<span class="txt99">교육생 : <%= totalCnt %>명</span>
						</div>

						<div class="txtr">
							<input type="button" value="SMS발송" onclick="go_sendSms();" class="boardbtn1">
							<%
							//시스템관리자, 과정운영자, 과정장 이라면
							if( memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN) 
								|| memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSE) 
								|| memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSEMAN) ) {
							%>
							<input type="button" value="조회" onclick="go_search();" class="boardbtn1">
							<input type="button" value="교번재부여" onclick="go_eduNo('<%=requestMap.getString("commYear")%>', '<%=requestMap.getString("commGrcode")%>', '<%=requestMap.getString("commGrseq")%>', '<%= grseqRowMap.getString("grcodeniknm") %>');" class="boardbtn1">
							<%
							}//end if
							%>
						</div>
						<div class="h5"></div>

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>교번</th>
								<th>
									<input type="checkbox" name="checkAll" onClick="listSelectAll()">
								</th>
								<th>아이디</th>
								<th>기관</th>
								<th>소속</th>
								<th>직급</th>
								<th>성명</th>
								<th>전화</th>
								<th>성별</th>
								<th>나이</th>
								<th class="br0">수정</th>
							</tr>
							</thead>

							<tbody>
							<%= listStr.toString() %>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	
            
						<div class="h5"></div>

						<!--[s] 페이징 -->
						<% // pageStr%>
						<!--//[s] 페이징 -->

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="출력" onclick="go_print();" class="boardbtn1">
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

