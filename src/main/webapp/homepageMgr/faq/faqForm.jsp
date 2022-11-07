<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : FAQ글 수정 등록 폼
// date : 2008-06-05
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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	//FAQ ROW데이터
	DataMap rowMap = (DataMap)request.getAttribute("FAQROW_DATA");
	rowMap.setNullToInitialize(true);
	
	//FAQ유형 데이터
	DataMap faqListMap = (DataMap)request.getAttribute("FAQLIST_DATA");
	faqListMap.setNullToInitialize(true);	
	
	
	//FAQ유형 셀렉박스
	StringBuffer option = new StringBuffer();
	
	if(faqListMap.keySize() > 0){
		for(int i=0; faqListMap.keySize() > i; i++){
			option.append("<option value=\""+faqListMap.getString("minorCode",i)+"\">"+faqListMap.getString("scodeName",i)+"</option>");
		}
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript" type="text/JavaScript">

//등록, 수정
function go_save(qu){

		if($("selectType").value == "" ){
			alert("질문유형을 선택하십시오.");
			return false;
		}
		
	 	var contents = getContents();
		$("content").value = trim(contents); 

	    if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
			alert("내용을 입력하세요");
			return;
		}
	    
		<%if(requestMap.getString("qu").equals("insertFaq")){%>
			if(confirm("등록 하시겠습니까?")){
			
		<%} else if(requestMap.getString("qu").equals("modifyFaq")){%>
		if(confirm("수정 하시겠습니까?")){
		
		<%} %>
		
		$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
	
		$("mode").value = "exec";
		$("qu").value = qu;
		pform.action = "/homepageMgr/faq.do?mode=exec";
		pform.submit();
	}
}
	
//리스트
function go_list(){
	$("question").value = "";
	pform.action = "/homepageMgr/faq.do";
	pform.submit();
	
}

//로딩시.
onload = function()	{

}
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu">
<!-- 보더아이디 -->
<input type="hidden" name="boardId" value="<%=requestMap.getString("boardId")%>">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">
<!-- 유저 넘버 -->
<input type="hidden" name="wuserno" 	value="<%=memberInfo.getSessNo() %>">
<!-- fno-->
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
												<select name="selectType"><option value="">==질문유형==</option><%=option.toString() %></select>
											</td>
										</tr>
										<tr>
											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>Question</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<textarea name="question" style="width:100%;height:50;word-break:break-all;"><%=rowMap.getString("question") %></textarea>
												
											</td>
										</tr>
										<tr>
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="15%">
												<strong>내 용</strong>
											</td>
											<td class="tableline21" align="left">
												<!-- Namo Web Editor용 Contents -->
												<!-- 수정 컨텐츠 -->
													<input type="hidden" name="content" id="content" value="<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("htmlContents"))%>">
												
													<!-- 스마트 에디터 -->
													<jsp:include page="/se2/SE2.jsp" flush="true" >
														<jsp:param name="contents" value='<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("htmlContents"))%>'/>
													</jsp:include>

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

												<input type=button value='저장' onClick="go_save('<%=requestMap.getString("qu") %>');" class=boardbtn1>
												<input type=button value='리스트 ' onClick="go_list()" class=boardbtn1>
												
											
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


<script language="JavaScript" type="text/JavaScript">
	//검색 조건 셀렉티드
	var codeId = "<%=rowMap.getString("codeId")%>";
	codeIdLen = $("selectType").options.length
	
	for(var i=0; i < codeIdLen; i++) {
		if($("selectType").options[i].value == codeId){
			$("selectType").selectedIndex = i;
		 }
 	 }
</script>




