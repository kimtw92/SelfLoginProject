<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%   
// prgnm : 과정이수 처리
// date : 2008-07-12
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

	
	//과정기수 정보.
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);
	
	//리스트
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

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
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/complete.do";
	pform.submit();

}

//실행
function go_exec(qu){

	if ($F("grcode") == "" || $F("grseq") == "") {
		alert('과정 또는 기수를 선택하세요.');
		return;
	}
	
	switch(qu) {
	
		case  "act1" :
		
			if( confirm('전체과목을 임시이수처리 하시겠습니까?')){
			
				$("mode").value = "exec";
				$("qu").value = qu;
				pform.action = "/courseMgr/complete.do";
				pform.target ="EXEC_IFRAME";
				$(document.body).startWaiting('bigWaiting');
				pform.submit();
				pform.target ="";

			}
			
		break;
		
		case  "act2" :
			if( confirm('전체과목을 이수처리 하시겠습니까?')){
			
				$("mode").value = "exec";
				$("qu").value = qu;
				pform.action = "/courseMgr/complete.do";
				pform.target ="EXEC_IFRAME";
				$(document.body).startWaiting('bigWaiting');
				pform.submit();
				pform.target ="";
				
			}
		break;
		
		case  "act3" :
			if( confirm('전체과목을 이수처리 완결 취소를하시겠습니까?')){
			
				$("mode").value = "exec";
				$("qu").value = qu;
				pform.action = "/courseMgr/complete.do";
				pform.target ="EXEC_IFRAME";
				$(document.body).startWaiting('bigWaiting');
				pform.submit();
				pform.target ="";
				
			}
		break;
		
		case  "act4" :
			if( confirm('수료임시처리 하시겠습니까?')){
			
				$("mode").value = "exec";
				$("qu").value = qu;
				pform.action = "/courseMgr/complete.do";
				pform.target ="EXEC_IFRAME";
				$(document.body).startWaiting('bigWaiting');
				pform.submit();
				pform.target ="";
				
			}
		break;
		
		case  "act5" :
			if( confirm('수료처리 하시겠습니까?')){
			
				$("mode").value = "exec";
				$("qu").value = "act4";
				$("closing").value = "Y";
				
				pform.action = "/courseMgr/complete.do";
				pform.target ="EXEC_IFRAME";
				$(document.body).startWaiting('bigWaiting');
				pform.submit();

				pform.target ="";
				$("closing").value = "";
				
			}
		break;
		
		case  "act6" :
			if( confirm('수료처리 완결취소를 하시겠습니까?')){
			
				$("mode").value = "exec";
				$("qu").value = qu;
				pform.action = "/courseMgr/complete.do";
				pform.target ="EXEC_IFRAME";
				$(document.body).startWaiting('bigWaiting');
				pform.submit();
				pform.target ="";
				
			}
		break;
	}
	
}




//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, subj)
	var reloading = "grSeq"; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);

}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"					value="">

<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">

<input type="hidden" name="closing"				value="">

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
								<td width="100" class="btnr" rowspan="4">
									<input type="button" value="검색" onclick="go_search();return false;" class="boardbtn1">
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
						</table>
						<!--//검색 -->	
						<div class="space01"></div>

						
						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th width="190">처리구분</th>
								<th width="70">선택</th>
								<th width="" class="br0">설명</th>
							</tr>
							</thead>

							<tbody>
							<tr>
								<td class="bg01 left">① 전체과목 <span class="txt_blue">임시이수처리</span></td>
								<td>
								<% if(rowMap.getString("subjSeqCloseChkByAll").equals("Y") ){ %>
									<input type="button"  class="boardbtn1_blue" value="완료" onclick="javascript:alert('임시이수처리가 완료 되었습니다.');" class="boardbtn1">
								<% }else{ %>
									<input type="button" value="실행" onclick="go_exec('act1');" class="boardbtn1">
								<% } %>
								</td>
								<td class="br0 left">전체과목에 대한 점수통계를 생성합니다.</td>
							</tr>
							<tr>
								<td class="bg01 left">② 전체과목 <span class="txt_blue">이수처리 완료</span></td>
								<td>
								<% if(rowMap.getString("subjSeqCloseYn").equals("Y") ){ %>
									<input type="button"  class="boardbtn1_red" value="완료" onclick="javascript:alert('이수처리 완료 되었습니다.');" class="boardbtn1">
								<% }else{ %>
									<input type="button" value="실행" onclick="go_exec('act2');" class="boardbtn1">
								<% } %>
								</td>
								<td class="br0 left">통계정보에 의거하여 전체과목을 이수처리 합니다.</td>
							</tr>
						<% if(memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN) ){ %>
							<tr>
								<td class="bg01 left">③ <span class="txt_blue">수료임시처리</span></td>
								<td>
								<% if(rowMap.getString("grseqCloseYesCh").equals("Y") ){ %>
									<input type="button"  class="boardbtn1_blue" value="완료" onclick="javascript:alert('수료임시처리가 완료 되었습니다.');" class="boardbtn1">
								<% }else{ %>
									<input type="button" value="실행" onclick="go_exec('act4');" class="boardbtn1">
								<% } %>
								</td>
								<td class="br0 left">과정, 기수에 대한 성적순위를 생성합니다.</td>
							</tr>
							<tr>
								<td class="bg01 left">④  <span class="txt_blue">수료처리완결</span></td>
								<td>
								
								<% if(rowMap.getString("grseqCloseYn").equals("Y") ){ %>
									<input type="button" class="boardbtn1_red" value="완료" onclick="javascript:alert('수료처리 완료 되었습니다.');" class="boardbtn1">
								<% }else{ %>
									<input type="button" value="실행" onclick="go_exec('act5');" class="boardbtn1">
								<% } %>
								</td>
								<td class="br0 left">과정, 기수에 대한 수료처리 합니다.</td>
							</tr>
						<% }else if(memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSE) ){ %>
							<tr>
								<td class="bg01 left">③ <span class="txt_blue">수료처리완결</span></td>
								<td>
								<% if(rowMap.getString("grseqCloseYn").equals("Y") ){ %>
									<input type="button" class="boardbtn1_red" value="완료" onclick="javascript:alert('수료처리 완료 되었습니다.');" class="boardbtn1">
								<% }else{ %>
									<input type="button" value="실행" onclick="go_exec('act5');" class="boardbtn1">
								<% } %>
								</td>
								<td class="br0 left">과정, 기수에 대한 수료처리 합니다.</td>
							</tr>
						<% }else{ %>
							<tr>
								<td class="bg01 left">③ <span class="txt_blue">수료임시처리</span></td>
								<td>
									<input type="button" value="실행" onclick="go_exec('act4');" class="boardbtn1">
								</td>
								<td class="br0 left">과정, 기수에 대한 성적순위를 생성합니다.</td>
							</tr>
						<% } %>
							</tbody>
						</table>
						<!--//리스트  -->

						<div class="space01"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th width="190">취소처리구분</th>
								<th width="70">선택</th>
								<th width="" class="br0">설명</th>
							</tr>
							</thead>

							<tbody>
							<tr>
								<td class="bg01 left">⑤ 전체과목 이수처리 완결 취소</td>
								<td>
									<input type="button" value="실행" onclick="go_exec('act3');" class="boardbtn1">
								</td>
								<td class="br0 left">과목별 점수가 수정된 경우 전체과목 이수 취소후에 ①, ②번을 실행하세요.</td>
							</tr>
							<tr>
								<td class="bg01 left">⑥ 수료처리완결취소</td>
								<td>
									<input type="button" value="실행" onclick="go_exec('act6');" class="boardbtn1">
								</td>
								<td class="br0 left">선택한 과정기수의 수료처리가 오류가 있을 경우 수료취소 후에 ①,②,③,④번을 실행하세요.</td>
							</tr>
							</tbody>
						</table>
						<!--//리스트  -->
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
<iframe style="display:none" name="EXEC_IFRAME"></iframe>
</body>

