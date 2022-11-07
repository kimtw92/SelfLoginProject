<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 퇴교자 명단 상세정보
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

	//퇴교자 상세 정보.
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);


	//간단한 과정 기수 정보
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);


	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 선택하세요!" : grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기";

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--


//리스트
function go_list(){

	$("mode").value = "list";
	$("userno").value = "";
	$("qu").value = "";

	pform.action = "/courseMgr/stuOut.do";
	pform.submit();

}


//복원
function go_return(){

	if( confirm("복원하시겠습니까?") ){

		$("mode").value = "exec";
		$("qu").value = "return";

		pform.action = "/courseMgr/stuOut.do";
		pform.submit();

	}


}

//삭제.
function go_delete(){


	if( confirm("삭제하시겠습니까?") ){
		$("mode").value = "exec";
		$("qu").value = "delete";

		pform.action = "/courseMgr/stuOut.do";
		pform.submit();
	}


}


//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">

<input type="hidden" name="qu"					value="<%= requestMap.getString("qu") %>">
<input type="hidden" name="userno"				value="<%= requestMap.getString("userno") %>">

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

			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- tab menu -->
						<div class="tit01" style="padding-left:0;">
							<strong><%= grseqNm %></strong>  
						</div>
						<!-- //tab menu -->
						<div class="space01"></div>


						<!-- date -->
						<table  class="dataw01">
							<tr>
								<th width="25%">이름</th>
								<td><%= rowMap.getString("name") %></td>
							</tr>
							<tr>
								<th>주민등록번호</th>
								<td><%= rowMap.getString("resno") %></td>
							</tr>
							<tr>
								<th>소속기관</th>
								<td><%= rowMap.getString("deptnm") %></td>
							</tr>
							<tr>
								<th>직 급</th>
								<td><%= rowMap.getString("jiknm") %></td>
							</tr>
							<tr>
								<th>퇴교 사유</th>
								<td><%= rowMap.getString("reason") %></td>
							</tr>
						</table>
						<!-- //date -->

						<ul class="coment01">
						  <li>[복원]을 선택하시면 해당 교육생이 재입교 처리됩니다. </li>
						</ul>

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value=" 복원 " onclick="go_return();" class="boardbtn1">
									<input type="button" value=" 삭제 " onclick="go_delete();" class="boardbtn1">
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
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

