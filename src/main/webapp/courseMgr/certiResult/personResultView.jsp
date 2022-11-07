<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%   
// prgnm : 개인별수료이력조회 상세보기
// date : 2008-07-16
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

	
	String tmpStr = "";	
	
	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr>");
		
		//과정
		listStr.append("\n	<td>" + listMap.getString("grcodeniknm", i) + "</td>");
		
		//기수
		tmpStr = StringReplace.subString(listMap.getString("grseq", i), 0, 4) + "년 " + StringReplace.subString(listMap.getString("grseq", i), 4, 6) + "기";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//총학습일
		tmpStr = listMap.getString("started1", i) + "~" + listMap.getString("enddate1", i);
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//총학습일
		listStr.append("\n	<td>" + listMap.getString("tdate", i) + "</td>");

		//기관명
		listStr.append("\n	<td>" + listMap.getString("rdeptnm", i) + "</td>");
		
		//기관명
		listStr.append("\n	<td>" + listMap.getString("rjiknm", i) + "</td>");
		
		//점수
		listStr.append("\n	<td>" + Double.parseDouble(listMap.getString("paccept", i)) + "</td>");
		
		//이수시간
		listStr.append("\n	<td>" + listMap.getString("grtime", i) + "</td>");
		
		//수료구분
		tmpStr = "";
		if(listMap.getString("rgrayn", i).equals("X")){
			if(Double.parseDouble(listMap.getString("paccept", i)) >= 60)
				tmpStr = "수료";
			else if(Double.parseDouble(listMap.getString("paccept", i)) >= 0 && Double.parseDouble(listMap.getString("paccept", i)) < 60)
				tmpStr = "미수료";
			else
				tmpStr = "";
		}else
			tmpStr = listMap.getString("rgrayn", i);
		String userResult = tmpStr;
		listStr.append("\n	<td>" + userResult + "</td>");
		
		//수료번호
		listStr.append("\n	<td>" + listMap.getString("rno", i) + "</td>");
	
		//수료증
		if(userResult.equals("수료") && !listMap.getString("rno", i).equals(""))
			tmpStr = "<input type=\"button\" value=\"출력\" onclick=\"go_print('"+listMap.getString("grcode", i)+"', '"+listMap.getString("grseq", i)+"', '"+listMap.getString("userno", i)+"');return false;\" class=\"boardbtn1\">";
		else
			tmpStr = "";
		listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");

		listStr.append("\n</tr>");
	
	
	} //end for 

	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' class='br0' style='height:100px'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
	go_list();
}
//검색
function go_search(){

	if($F("searchName") == ""){
		alert("검색어를 입력하세요.");
		return;
	}
	if(IsValidCharSearch($F("searchName"))){
		go_list();
	}

}
//리스트
function go_list(){

	$("mode").value = "person_list";

	pform.action = "/courseMgr/certiResult.do";
	pform.submit();

}
//수료증 출력
function go_print(grcode, grseq, userno){

	var url = "/courseMgr/certiResult.do?mode=certi_html&grcode=" + grcode + "&grseq=" + grseq + "&chkUserno[]="+userno;
	popWin(url, "pop_ResultDocHtml", "1024", "1050", "1", "0");

}

//로딩시.
onload = function()	{

}

function go_formChk(){

	go_search();
}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" onSubmit="go_formChk();return false;">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"					value="">

<input type="hidden" name="userno"				value="">
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
								<th width="80">
									<strong>성명</strong>
								</th>
								<td>
									<input type='text' name='searchName' style='width:100' class="font1" value="<%=requestMap.getString("searchName")%>">
								</td>
								<td width="120" class="btnr">
									<input type="button" value="조회" onclick="go_search();return false;" class="boardbtn1">
									<!-- <input type="button" value="EXCEL" onclick="go_excel();" class="boardbtn1"> -->
								</td>
							</tr>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>

						
						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>과정</th>
								<th>기수</th>
								<th>교육기간</th>
								<th>총학습일</th>
								<th>기관명</th>
								<th>직급</th>
								<th>점수</th>
								<th>이수시간</th>
								<th>수료구분</th>
								<th>수료번호</th>
								<th class="br0">수료증</th>
							</tr>
							</thead>

							<tbody>
							<%= listStr.toString() %>
							</tbody>
						</table>


						<!--//[e] 리스트  -->



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

