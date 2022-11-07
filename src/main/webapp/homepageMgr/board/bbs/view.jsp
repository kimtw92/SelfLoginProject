<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사용자 게시판 상세 글보기 
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
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("BOARDROW_DATA");
	listMap.setNullToInitialize(true);
	
	//게시판 권한 
	DataMap authRowMap = (DataMap)request.getAttribute("BOARD_AUTHROW_DATA");
	authRowMap.setNullToInitialize(true);

	//게시판 기본정보
	DataMap managerRowMap = (DataMap)request.getAttribute("BOARD_MANAGERROW_DATA");
	managerRowMap.setNullToInitialize(true);

	StringBuffer replyButton = new StringBuffer();
	
	//if(((String)(session.getAttribute("sess_userid"))).equals("rkdtnsgml") || managerRowMap.getString("luserno").equals(memberInfo.getSessNo()) && authRowMap.getString("boardWrite").equals("Y")){
	//	replyButton.append("<input type=button value=' 답글' onClick=\"go_reply();\" class=boardbtn1>");			
	//}
	
	if( ( (String)(session.getAttribute("sess_userid"))).equals("rkdtnsgml") || authRowMap.getString("boardWrite").equals("Y")){
		replyButton.append("<input type=button value='답글' onClick=\"go_reply();\" class=boardbtn1>");
			
	}
	
	

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

function go_modify(){
	$("mode").value = "bbsBoardForm";
	$("qu").value = "modifyBbsBoard";
	pform.action = "/homepageMgr/board/bbs.do";
	pform.submit();
	
}

//리스트
function go_list(){
	
	pform.action = "/homepageMgr/board/bbs.do?mode=bbsBoardList";
	pform.submit();
}

//삭제
function go_delete(){
	
	if(confirm("삭제 하시겠습니까?")){
		$("mode").value = "bbsBoardExec";
		$("qu").value = "deleteBbsBoard";
		pform.action = "/homepageMgr/board/bbs.do";
		pform.submit();
	}
}
//리플
function go_reply(){
	$("mode").value = "bbsBoardForm";
	$("qu").value = "insertReplyBbsBoard";
	pform.action = "/homepageMgr/board/bbs.do";
	pform.submit();
}
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode" value="bbsBoardList">
<input type="hidden" name="qu">
<!-- 보더아이디 -->
<input type="hidden" name="boardId" value="<%=requestMap.getString("boardId")%>">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">
<!-- 보더네임 -->
<input type="hidden" name="boardName" value="<%=requestMap.getString("boardName") %>">
<!-- 현재 권한 -->
<input type="hidden" name="sessClass" value="<%=memberInfo.getSessClass()  %>">
<!-- 글넘버 -->
<input type="hidden" name="seq" value="<%=requestMap.getString("seq") %>">
<!-- 글넘버 -->
<input type="hidden" name="step" value="<%=listMap.getString("step") %>">

<!-- 검색어 -->
<input type="hidden" name="selectText" value="<%=requestMap.getString("selectText") %>">
<input type="hidden" name="currPage" value="<%=requestMap.getString("currPage") %>">
<!-- 수정 삭제시 기본 키값으로 게시판 아이디를 가지고 간다. -->
<input type="hidden" name="boardId">
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong><%=requestMap.getString("boardName") %> 게시판</strong>
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
											<td width="50%">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td  align="center" width="100" height="28" class="tableline11" bgcolor="#E4EDFF" >
															<strong>제목</strong>
														</td>
														<td style="padding-left:10px" width="" class="tableline21">
															<%=listMap.getString("title") %>
														</td>
													</tr>
												</table>
											</td>
											<td width="50%">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>													
														<td height="28" width="100" align="center" class="tableline11" bgcolor="#E4EDFF" align="center">
															<strong>조회수</strong>
														</td>
														<td style="padding-left:10px" width="" class="tableline21">
															<%=listMap.getString("visit") %>
															
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr >
											<td width="50%">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>										
														<td height="28" width="100" class="tableline11" bgcolor="#E4EDFF" align="center">
															<strong>작성자</strong>
														</td>
														<td style="padding-left:10px" class="tableline21">
															<%=listMap.getString("username") %> (<%=listMap.getString("userId") %>)
														</td>
													</tr>
												</table>
											</td>
											<td width="50%">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>										
														<td height="28" width="100" class="tableline11" bgcolor="#E4EDFF" align="center">
															<strong>작성일</strong>
														</td>
														<td style="padding-left:10px" class="tableline21">
															<%=listMap.getString("regdate") %>
														</td>
													</tr>
												</table>
											</td>
										</tr>
<%

//게시판아이디가 카풀, 법률/조례, 게시판관리, 게시판권한관리중 하나이면 전화번호, 주소 조회하지 않는다.
if(!"CARPOOL".equals(requestMap.getString("boardId")) && !"LAWS".equals(requestMap.getString("boardId")) && !"MNGER".equals(requestMap.getString("boardId")) && !"MNGER_AUTH".equals(requestMap.getString("boardId"))) {

%>										
										<tr>
											<td width="50%">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>										
														<td height="28" width="100" class="tableline11" bgcolor="#E4EDFF" align="center">
															<strong>전화번호</strong>
														</td>
														<td style="padding-left:10px" class="tableline21">
															&nbsp;<%=listMap.getString("phone") %>
														</td>
													</tr>
												</table>
											</td>
											<td width="50%">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>										
														<td height="28" width="100" class="tableline11" bgcolor="#E4EDFF" align="center">
															<strong>이메일</strong>
														</td>
														<td style="padding-left:10px" class="tableline21">
															&nbsp;<%=listMap.getString("email") %>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="100%">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td height="28" width="100" class="tableline11" width="" bgcolor="#E4EDFF" align="center">
															<strong>주 소</strong>
														</td>
														<td colspan="3" class="tableline21">
															<table width=""  width="" align="center" style="table-layout:fixed">
																<tr>
																	<td align="left" colspan="3" width="75%">
																		&nbsp;<%=listMap.getString("post1") %> <%=listMap.getString("post2") %> <%=listMap.getString("addr") %>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										
<% } %>										
										<tr>
											<td colspan="100%">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td height="28" width="100" class="tableline11" width="" bgcolor="#E4EDFF" align="center">
															<strong>내 용</strong>
														</td>
														<td colspan="3" class="tableline21">
															<table width=""  width="" align="center" style="table-layout:fixed">
																<tr>
																	<td align="left" colspan="3" width="75%">&nbsp;<%=StringReplace.convertHtmlDecodeNamo(listMap.getString("content"))%></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										<tr>
											<td colspan = "100%">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td height="28" width="100" class="tableline11" bgcolor="#E4EDFF" align="center">
															<strong>첨부 파일</strong>
														</td>
														<td style="padding-left:10px" class="tableline21" colspan="3">
														<%if(authRowMap.getString("boardDownload").equals("Y") ){ %>
															<%=(!listMap.getString("groupfileNo").equals("-1") ?  "<a href='javascript:fileDownloadPopup("+listMap.getString("groupfileNo")+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : "&nbsp;" )%>
														<%}else{ %>
														<%=(!listMap.getString("groupfileNo").equals("-1") ?  "<img src=/images/compressed.gif border=0 valign='middle'>" : "&nbsp;" )%>
														<%} %>
														</td>
													</tr>
												</table>
											</td>
										</tr>										
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
										<tr>
											<td height="10" colspan="100%">
											</td>
										</tr>
										<tr>
											<td align='right' height="40" colspan="100%">
											<%if(listMap.getString("wuserno").equals(memberInfo.getSessNo()) || (memberInfo.getSessName().equals("guest") && authRowMap.getString("boardWrite").equals("Y")) ||  !memberInfo.getSessName().equals("guest") && authRowMap.getString("boardWrite").equals("Y")){ %>
												<input type=button value=' 글수정 ' onClick="go_modify();" class=boardbtn1>
													
												<%if(authRowMap.getString("boardDelete").equals("Y")){ %>
													<input type=button value=' 글삭제 ' onClick="go_delete();" class=boardbtn1>
												<%}%>
											<%} %>
											<%=replyButton.toString() %>
												<input type=button value=' 목록 ' onClick="go_list()" class=boardbtn1>
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






