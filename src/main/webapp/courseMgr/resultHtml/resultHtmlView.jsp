<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 수료증 HTML 관리
// date : 2008-08-25
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


	//개인공지 상세 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

	String content = "";
	if(rowMap.getString("no").equals("")){
		content = "등록된 수료증이 없습니다.";
	}else{
		content = rowMap.getString("content");
	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--




//수정
function go_modify(){

	$("mode").value = "form";
	$("qu").value = "update";

	pform.action = "/courseMgr/resultHtml.do";
	pform.submit();

}

//삭제
function go_reset(){

	if(confirm("시스템의 초기값으로 하시겠습니까?")){

		$("mode").value = "exec";
		$("qu").value = "reset";
		pform.action = "/courseMgr/resultHtml.do";
		pform.submit();

	}


}
 

//로딩시.
onload = function()	{


}

//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" name="no"					value='<%=rowMap.getString("no")%>'>

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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->


<!--[ 코딩 시작 ] ------------------------------------------------------------------------------------------------------>
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif" alt="" /> 수료증 HTML 보기</h2>
						<!-- // subTitle -->
						<div class="h5"></div>

						<!-- date -->
						<div class="datatbl02" style="text-align:center">
							<%= StringReplace.convertHtmlDecodeNamo( content ) %>
						</div>
						<!-- //date -->

						<!-- 검색 -->
						<table class="btn01" style="clear:both;">
							<tr>
								 <td class="right">
								<%if(!rowMap.getString("no").equals("")){%>
									<input type="button" value="수정"		onclick="go_modify();" class="boardbtn1">
									<input type="button" value="시스템 초기값으로 수정" onclick="go_reset();" class="boardbtn1">
								<%}else{%>
									<input type="button" value="시스템 초기값으로 등록" onclick="go_reset();" class="boardbtn1">
								<%}%>
								</td>
							</tr>
						</table>
						<!-- //검색  -->
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
