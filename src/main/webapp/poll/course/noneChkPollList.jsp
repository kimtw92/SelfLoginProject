<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 설문관리 - 미응시자 관리
// date : 2008-09-23
// auth : 정윤철
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


	//바디영역 html 데이터
	StringBuffer html = new StringBuffer();
	
	if(listMap.keySize("titleNo") > 0){
		for(int i =0; i < listMap.keySize("titleNo"); i++){
			html.append("<tr>");
			html.append("	<td>"+listMap.getString("titleSeq", i)+"</td>");
			html.append("	<td>"+listMap.getString("title", i)+"</td>");
			html.append("	<td>"+(listMap.getString("useYn", i).equals("Y") ? "실시" : "미실시")+"</td>");
			html.append("	<td>"+(listMap.getString("gubunOnOff", i).equals("on") ? "온라인" : "오프라인")+"</td>");
			html.append("	<td>"+listMap.getString("srdate", i)+"<br>"+listMap.getString("erdate", i)+"</td>");
			html.append("	<td>"+listMap.getString("sdate", i)+"<br>"+listMap.getString("edate", i)+"</td>");
			html.append("	<td class=\"br0\"><input type=\"button\" onclick=\"go_sms('"+listMap.getString("grcode", i)+"', '"+listMap.getString("grseq", i)+"', '"+listMap.getString("titleNo", i)+"')\" class=\"boardbtn1\" value=\"문자 보내기\"></td>");
			html.append("</tr>");
			
		}
		
	}else{
		html.append("<tr>");
		html.append("<td class=\"br0\" colspan=\"100%\" style=\"height:100px\">검색된 설문이 없습니다.</td>");
		html.append("</tr>");
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

	go_list();
}

//미응시자 SMS팝업
function go_sms(grcode, grseq, titleNo){

	var mode = "noneChkPollSmsList";
	var menuId = $F("menuId");
	var url = "/poll/coursePoll.do?mode=" + mode + "&menuId=" + menuId + "&grcode=" + grcode + "&grseq=" + grseq + "&titleNo=" + titleNo;

	popWin(url, "pop_pollSMS", "700", "600", "1", "");

}

//리스트
function go_list(){

	$("mode").value = "noneChkPollList";

	pform.action = "/poll/coursePoll.do";
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

<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">

<input type="hidden" name="qu"					value="">
<input type="hidden" name="titleNo"				value="">

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
						<!--[s] 리스트  -->

						<table class="datah01">
							<thead>
								<tr>
									<th>회차</th>
									<th>제목</th>
									<th>실시</th>
									<th>구분</th>
									<th>설문적용기간</th>
									<th>설문실시기간</th>
									<th class="br0">비고</th>
								</tr>
							</thead>

							<tbody>
								<%=html.toString() %>
							</tbody>
						</table>

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

