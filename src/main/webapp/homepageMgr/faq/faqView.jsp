<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육관련 FAQ 상세페이지
// date : 2008-06-13
// auth : 정 윤철
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
	
	//FAQ ROW데이터
	DataMap rowMap = (DataMap)request.getAttribute("FAQROW_DATA");
	rowMap.setNullToInitialize(true);
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

//리스트
function go_list(){
	
	pform.action = "/homepageMgr/faq.do";
	pform.submit();
}

//로딩시.
onload = function()	{

}

function go_form(qu){
	//폼이동
	$("mode").value="form";
	$("qu").value=qu;
	pform.action = "/homepageMgr/faq.do?mode="+$("mode").value;
	pform.submit();
	
}

function go_delete(){

	if(confirm("삭제 하시겠습니까?")){
		//삭제
		$("mode").value="exec";
		$("qu").value = "deleteFaq";
		pform.action = "/homepageMgr/faq.do?mode="+$("mode").value;
		pform.submit();
	}
}
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">
<!-- fno -->
<input type="hidden" name="fno" 	value="<%=requestMap.getString("fno") %>">
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

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>FAQ 보기</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
				<tr>
					<td>
			 <!---[s] content -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
	
										<tr>
											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>질문유형</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<%=rowMap.getString("codeName") %>
											</td>
										</tr>
										<tr>
											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>Question</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<%=rowMap.getString("question") %>
											</td>
										</tr>
										<tr >
											<td height="28" width="15%" class="tableline11" width="" bgcolor="#E4EDFF" align="center">
												<strong>내 용</strong>
											</td>
											<td colspan="3" class="tableline21">
												<table width="660"  width="" align="center" style="table-layout:fixed">
													<tr>
														<td align="left" colspan="3" width="75%">&nbsp;<%=StringReplace.convertHtmlDecodeNamo(rowMap.getString("htmlContents"))%></td>
													</tr>
												</table>
											</td>
										</tr>
									
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
										<tr>
											<td height="20" colspan="100%">
											</td>
										</tr>
										<tr>
											<td align='right' height="40" colspan="100%">

												<input type=button value='글수정' onClick="go_form('modifyFaq');" class=boardbtn1>
												<input type=button value='글삭제' onClick="go_delete()" class=boardbtn1>
												<input type=button value='목록' onClick="go_list()" class=boardbtn1>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		<!-- space -->
		<table width="100%" height="10"><tr><td></td></tr></table>
		<!--[e] Contents Form  -->
	                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>






