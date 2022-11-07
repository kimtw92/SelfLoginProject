<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 게시판 관리 폼
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
	
	//게시판 기본정보 데이터
	DataMap defaultMap = (DataMap)request.getAttribute("DEFAULTBOARD_DATA");
	defaultMap.setNullToInitialize(true);
	
	//게시판 권한  데이터
	DataMap authBoardMap = (DataMap)request.getAttribute("AUTHBOARD_DATA");
	authBoardMap.setNullToInitialize(true);
	
	//권한명
	DataMap gadminNmMap = (DataMap)request.getAttribute("GADMINBOARD_DATA");
	gadminNmMap.setNullToInitialize(true);
	

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
//게시판 수정, 등록
function go_save(){
	if(confirm("저장 하시겠습니까?")){
		$("mode").value="exec";
		$("qu").value="<%=requestMap.getString("qu")%>";
		pform.action = "/homepageMgr/board.do";
		
		pform.submit();
	}
}
//게시판삭제
function del_board(qu){
	if(confirm("삭제 하시겠습니까?")){
		$("mode").value="exec";
		$("qu").value=qu;
		pform.action = "/homepageMgr/board.do";
		pform.submit();
	}
}

function go_list(){
	pform.action = "/homepageMgr/board.do";
	pform.submit();
}

//게시판명 영문숫자체크
function str_chk(){

	//게시판아이디
	var str_data = $("boardId").value;
	
	var qu ="<%=requestMap.getString("qu")%>";
	//게시판명
	var boardName = $("boardName").value;
	
	//게시판 아이디 체크
	if(str_data == "" || str_data == null){
		alert("게시판 아이디를 입력해 주십시오.");
		return false;
	}
	
	if(qu == "insertBoard"){
	
		//영문 숫자 체크
		if(str_data != "" || str_data != null){	
			for(i=0;i<str_data.length;i++){
				if(str_data.charCodeAt(i) < 48 && str_data.charCodeAt(i) > 57 
				   && str_data.charCodeAt(i) < 97 && str_data.charCodeAt(i) > 122
				   || str_data.charCodeAt(i) < 65 && str_data.charCodeAt(i) > 90){
					alert("유요한 아이디 이름이 아닙니다. 영문자와 숫자로 4자리 이상 20자리 이하로 작업해 주십시오.");
					return false;break
				}
			}
		}
	
		//게시판아이디가 4글자이상인지 체크
		if(str_data.length < 4 || str_data.length > 20){
			alert("유요한 아이디 이름이 아닙니다. 영문자와 숫자로 4자리 이상 20자리 이하로 작업해 주십시오.");
			return false;
		}
	}
	//게시판명 체크
	if(boardName == "" || boardName == null){
		alert("게시판 명을 입력해 주십시오.");
		return false;
	}
	
	//파일다운 옵션 체크
	if(pform.fileYn[0].checked == false && pform.fileYn[1].checked == false){
		alert("파일다운 옵션을 선택하세요.");
		return false;
	}	
	
	//답글 옵션 체크
	if(pform.replyYn[0].checked == false && pform.replyYn[1].checked == false){
		alert("답글 옵션을 선택하세요.");
		return false;
	}
	
	//본문보기 옵션 체크	
	if(pform.contlinkYn[0].checked == false && pform.contlinkYn[1].checked == false){
		alert("본문보기 옵션을 선택하세요.");
		return false;
	}		
	
	go_save();  
}



</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input name="mode"		type="hidden">
<input name="qu" 		type="hidden">
<input name="menuId" 	type="hidden" value="<%=requestMap.getString("menuId") %>">



<!-- 세션넘버 -->
<input type=hidden name=userno value='<%=requestMap.getString("sessNo") %>'>
<!-- 게시판생성당시 유저 넘버 -->
<input type=hidden name=username value='<%=requestMap.getString("sessName") %>'>

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
			<table>
				<tr>
					<td height="50">&nbsp;※ 권한설명 (<B>읽기</B>:읽기, <B>쓰기</B>:글쓰기및자신의글수정삭제, <B>삭제</B>:쓰기+남의글삭제가능, <B>다운로드</B>:첨부파일다운로드)</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>신규 게시판 <%=requestMap.getString("qu").equals("insertBoard") ? "등록" : "수정" %></strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                        <!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						
						 <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="">

							<tr bgcolor="#375694">
								<td height="2" colspan="100%"></td>
							</tr>
							<tr bgcolor="F7F7F7">
								<td width="100%" colspan="100%">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="">
										<tr>
											<td height="28" class="tableline11 " bgcolor="E4EDFF" align="center" width="100">
												<strong>게시판ID</strong>
											</td>
											<td class="tableline21" style="padding-left:10px;" colspan='2' bgcolor="#FFFFFF">
												<input type="text" name="boardId" value="<%=defaultMap.getString("boardId") %>" <%=requestMap.getString("qu").equals("modifyBoardForm") ? "readonly" : "" %> class="textfield" size="60">
										
											</td>
										</tr>
									
										<tr bgcolor="F7F7F7">
											<td height="28" align="center" class="tableline11" bgcolor="E4EDFF">
												<strong>게시판명</strong>
											</td>
											<td class="tableline21" colspan='3' style="padding-left:10px;" bgcolor="#FFFFFF">
												<input type="text" name="boardName" value="<%=defaultMap.getString("boardName") %>" class="textfield" size="60">
										
											</td>
										</tr>
										
										<tr bgcolor="F7F7F7" >
											<td height="28" align="center" class="tableline11 " bgcolor="E4EDFF">
												<strong>메뉴ID</strong>
											</td>
											<td class="tableline21" style="padding-left:10px;" colspan='3' bgcolor="#FFFFFF">
												<input type="text" name="menuid" value="<%=defaultMap.getString("menuid") %>" class="textfield" size="20">
												<br>※ 사용자 화면의 메뉴 위치 ID를 입력한다. (ex: top메뉴위치(1단)-left메뉴위치(2단)-left하위메뉴위치(3단))
											
											</td>
										</tr>
									</table>
								</td>
							</tr>
							
							<tr bgcolor="E4EDFF">
								<td colspan="100%">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="">
										<tr>
											<td height="28" align="center" class="tableline11" width="100" bgcolor="E4EDFF" rowspan='3'>
												<strong>옵션설정</strong>
											</td>
											<td height="28" align="center" width="100" class="tableline11" bgcolor="E4EDFF">
												<strong>파일다운</strong>
											</td>
											<td height="28" class="tableline21"  style="padding-left:10px;"  width="" align="left" bgcolor="#FFFFFF">
												<input type="radio" name="fileYn" value="Y" <%=defaultMap.getString("fileYn").equals("Y") ? "checked" : ""%>>예&nbsp;&nbsp;&nbsp;
												<input type="radio" name="fileYn" value="N" <%=defaultMap.getString("fileYn").equals("N") ? "checked" : ""%>>아니오
											</td>
										</tr>
										<tr bgcolor="F7F7F7">
											<td height="28" align="center" width="100" class="tableline11 " bgcolor="E4EDFF">
												<strong>답글허용</strong>
											</td>
											<td height="28" class="tableline21"  style="padding-left:10px;"  bgcolor="#FFFFFF">
												<input type="radio" name="replyYn" value="Y" <%=defaultMap.getString("replyYn").equals("Y") ? "checked" : ""%>>예&nbsp;&nbsp;&nbsp;
												<input type="radio" name="replyYn" value="N" <%=defaultMap.getString("replyYn").equals("N") ? "checked" : ""%>>아니오
											</td>
										</tr>
										<tr bgcolor="F7F7F7">
											<td height="28" align="center" width="100" class="tableline11 " bgcolor="E4EDFF">
												<strong>본문보기</strong>
											</td>
											<td height="28" class="tableline21"  style="padding-left:10px;"  bgcolor="#FFFFFF">
												<input type="radio" name="contlinkYn" value="Y" <%=defaultMap.getString("contlinkYn").equals("Y") ? "checked" : ""%>>예&nbsp;&nbsp;&nbsp;
												<input type="radio" name="contlinkYn" value="N" <%=defaultMap.getString("contlinkYn").equals("N") ? "checked" : ""%>>아니오
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="100%" width="100%">
									<table cellspacing="0" style="padding:0 0 0 0" bgcolor="" border="0" width="100%" cellpadding="0">
										<tr bgcolor="F7F7F7">
											<td height="28" width="100" align="center" class="tableline11 " bgcolor="E4EDFF" rowspan='0'>
												<strong>권한설정</strong>
											</td>
											<td colspan = "3" width="" style="padding:0 0 0 0">
												<table cellspacing="0" style="padding:0 0 0 0" bgcolor="" border="0" width="100%" cellpadding="0">
													<%for(int i= 0; i < gadminNmMap.keySize(); i++){ %>
										
													<tr>
														<td height="28" width="100" align="center" class="tableline11 " bgcolor="E4EDFF">
															<strong><%=gadminNmMap.getString("gadminnm",i) %></strong>
															<input type="hidden" name="gadmin" value="<%=gadminNmMap.getString("gadmin",i) %>">
														</td>
														<%
														for(int j=0; j < gadminNmMap.keySize(); j++){
															if(requestMap.getString("qu").equals("modifyBoard")){
																//리스트 갯수 체크
																int cnt = 0;
																
																if(gadminNmMap.getString("gadmin",i).equals(authBoardMap.getString("boardGrade",j)) ){ %>
																
																<td height="28" class="tableline21"  style="padding-left:10px;"  bgcolor="#FFFFFF">
																	<input type="checkbox" name="boardRead<%=i %>" value="Y" <%=!authBoardMap.getString("boardRead",j).equals("Y") ? "" : "checked"%>>읽기&nbsp;&nbsp;
																	<input type="checkbox" name="boardWrite<%=i %>" value="Y" <%=!authBoardMap.getString("boardWrite",j).equals("Y") ? "" : "checked"%>>쓰기&nbsp;&nbsp;
																	<input type="checkbox" name="boardDelete<%=i %>" value="Y" <%=!authBoardMap.getString("boardDelete",j).equals("Y") ? "" : "checked"%>>삭제&nbsp;&nbsp;
																	<input type="checkbox" name="boardDownload<%=i %>" value="Y" <%=!authBoardMap.getString("boardDownload",j).equals("Y") ? "" : "checked"%>>다운로드
																</td>
																<%		
																		cnt = 1;
																		break; 
																	}else if(gadminNmMap.keySize() == (j+1) && cnt == 0){
																		%>
																			<td height="28" class="tableline21"  style="padding-left:10px;"  bgcolor="#FFFFFF">
																				<input type="checkbox" name="boardRead<%=i %>" value="Y" >읽기&nbsp;&nbsp;
																				<input type="checkbox" name="boardWrite<%=i %>" value="Y" >쓰기&nbsp;&nbsp;
																				<input type="checkbox" name="boardDelete<%=i %>" value="Y" >삭제&nbsp;&nbsp;
																				<input type="checkbox" name="boardDownload<%=i %>" value="Y" >다운로드
																			</td>
																		<%
																		cnt = 1;
																		break; 
																	}
																}else{
																	
																%>
																
																<td height="28" class="tableline21"  style="padding-left:10px;"  bgcolor="#FFFFFF">
																	<input type="checkbox" name="boardRead<%=i %>" value="Y" >읽기&nbsp;&nbsp;
																	<input type="checkbox" name="boardWrite<%=i %>" value="Y" >쓰기&nbsp;&nbsp;
																	<input type="checkbox" name="boardDelete<%=i %>" value="Y" >삭제&nbsp;&nbsp;
																	<input type="checkbox" name="boardDownload<%=i %>" value="Y" >다운로드
																</td>
																
																<%
																break; 
																}
															}//권한 설정 [e]%>
													</tr>
														<% } %>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>

							<tr>
								<td width="100%" colspan="100%">
									<table cellspacing="0" style="padding:0 0 0 0" bgcolor="" border="0" width="100%" cellpadding="0">
										<tr>
											<td height="28" align="center"  class="tableline11" width="100" bgcolor="E4EDFF">
												<strong>사용여부</strong>
											</td>
											<td height="28"  style="padding-left:10px;"  class="tableline21" colspan='3' bgcolor="#FFFFFF">
												<input type="radio" name="useYn" value="Y" <%=defaultMap.getString("useYn").equals("Y") ? "checked" : ""%>>예&nbsp;&nbsp;&nbsp;
												<input type="radio" name="useYn" value="N" <%=!defaultMap.getString("useYn").equals("Y") ? "checked" : ""%>>아니오
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr bgcolor="#375694">
								<td height="2" colspan="100%"></td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
								
							<tr>
								<td align='center' height="40">
									<%if(!requestMap.getString("qu").equals("insertBoardForm")){ %>
									<%if(memberInfo.getSessNo().equals(defaultMap.getString("luserno") )){%>
									<input type='button' name='' value='삭제' class="boardbtn1" onClick="del_board('deleteBoard');">
									<%}
									}%>
									<input type="button" onclick="str_chk()" value="저장" class="boardbtn1">
									<input type="button" name="go_list()" value="리스트" onClick="go_list()" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!---[e] content -->
					</td>
				</tr>
			</table>
			<table width="100%"><tr><td height="50"></td></tr></table>
			<!--[e] Contents Form  -->
				                           
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>






