<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 퇴교자 명단 입력
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


	//간단한 과정 기수 정보
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr>");


		//소속기관
		listStr.append("\n	<td>" + listMap.getString("deptnm", i) + "</td>");

		//이름
		listStr.append("\n	<td>" + listMap.getString("name", i) + "</td>");

		//주민등록번호.
		tmpStr = "<input type='radio' class='chk_01' name='userno' value=\"" + listMap.getString("userno", i) + "\">";
		listStr.append("\n	<td class='br0'>" + tmpStr + listMap.getString("resno", i) + "</td>");

		listStr.append("\n</tr>");

	} //end for listMap.keySize("userno")


	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' height='100' class='br0'>대상자가 없습니다</td>");
		listStr.append("\n</tr>");

	}


	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 선택하세요!" : grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기";

%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//새로고침.
function go_reload(){

	$("mode").value = "form";
	$("searchName").value = "";

	pform.action = "/courseMgr/stuOut.do";
	pform.submit();
}

function go_search(){

	if($F("searchName") == ""){
		alert("이름을 입력하세요.");
		return;
	}
	if(IsValidCharSearch($F("searchName"))){
		$("mode").value = "form";

		pform.action = "/courseMgr/stuOut.do";
		pform.submit();
	}

}
//리스트
function go_list(){

	$("mode").value = "list";
	$("qu").value = "";

	pform.action = "/courseMgr/stuOut.do";
	pform.submit();

}


//입력
function go_add(){


	if($F("grcode") == "" || $F("grseq") == ""){
		alert("과정 또는 과정 기수가 선택 되지 않았습니다. 리스트에서 선택해 주시기 바랍니다.");
		return;
	}
	

	if(!go_commonCheckedCheck(pform.userno)){
		alert("퇴교 대상자를 선택하세요!");
		return;
	}

	if(!go_commonCheckedCheck(pform.ckind)){
		alert("퇴교 구분을 선택하세요!");
		return;
	}


	if( NChecker(document.pform) && confirm("퇴교처리하시겠습니까?") ){

		$("mode").value = "exec";
		$("qu").value = "out";

		pform.action = "/courseMgr/stuOut.do";
		pform.submit();

	}


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

<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">

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
						<!-- subText -->
						<div class="tit01" style="padding-left:0;">
							<%= grseqNm %>
						</div>
						<!-- // subText -->						
						<div class="h10"></div>

						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif"> 직권 퇴교 대상자 입력 </h2>
						<!-- // subTitle -->
						<div class="h5"></div>

						<!-- date -->
						<table  class="dataw01">
							<tr>
								<th width="90" style="background:#F7F7F7">이 름</th>
								<td>
									<input type="text" class="textfield" name="searchName" value="<%= requestMap.getString("searchName") %>" style="width:100px" />
									<input type="button" value="조회" onclick="go_search();return false;" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //date -->
						<div class="space01"></div>            

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>소속기관</th>
								<th>성명</th>
								<th class="br0">주민등록번호</th>
							</tr>
							</thead>

							<tbody>
							<%= listStr %>
							</tbody>
						</table>
						<!-- //리스트  -->
						<div class="space01"></div> 

						<div>
							<div>
								퇴교구분 :
								<input type="radio" class="chk_01" name="ckind" id="label1" value="2" /><label for="label1">자퇴</label>
								<input type="radio" class="chk_01" name="ckind" id="label2" value="3" /><label for="label2">미등록</label>
								<input type="radio" class="chk_01" name="ckind" id="label3" value="4" /><label for="label3">교육취소</label>
							</div>
							<textarea class="textarea01" style="width:100%;" name="reason" required="true!퇴교사유를 입력하세요!"></textarea>
						</div>

						<ul class="coment01">
						  <li>퇴교사유를 입력하신 후, 해당 교육생의 주민등록번호를 선택하세요. </li>
						</ul>

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<% if( listMap.keySize("userno") > 0){ %>
									<input type="button" value="저장" onclick="go_add();" class="boardbtn1">
									<% } %>
									<input type="button" value="새로고침" onclick="go_reload();" class="boardbtn1">
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->
						<div class="space01"></div>

						
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

