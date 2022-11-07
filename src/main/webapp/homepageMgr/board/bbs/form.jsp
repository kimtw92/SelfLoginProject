<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사용자 게시판 글 수정
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
	DataMap rowMap = (DataMap)request.getAttribute("BOARDROW_DATA");
	rowMap.setNullToInitialize(true);
	
	//게시판 권한 
	DataMap authRowMap = (DataMap)request.getAttribute("BOARD_AUTHROW_DATA");
	authRowMap.setNullToInitialize(true);

	//게시판 기본정보
	DataMap managerRowMap = (DataMap)request.getAttribute("BOARD_MANAGERROW_DATA");
	authRowMap.setNullToInitialize(true);
	
	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.

	DataMap fileMap = (DataMap)rowMap.get("FILE_GROUP_LIST");

	if(fileMap == null)
		fileMap = new DataMap();
	fileMap.setNullToInitialize(true);

	for(int i=0; i < fileMap.keySize("groupfileNo"); i++){

		if(fileMap.getInt("groupfileNo", i)==0){
			continue;
		}
		
		tmpStr = fileMap.getString("groupfileNo", i) + "#" + fileMap.getString("fileNo", i); 
// 		fileStr += "document.InnoDS.AddTempFile('" + fileMap.getString("fileName", i) + "', " + fileMap.getInt("fileSize", i) + ", '" + tmpStr + "');";
// 		fileStr += "g_ExistFiles['" + tmpStr + "'] = false;";

        fileStr += "var input"+i+" = document.createElement('input');\n";
		fileStr += "input"+i+".value='"+fileMap.getString("fileName", i)+"';\n";
		fileStr += "input"+i+".setAttribute('fileNo', '"+tmpStr+"');\n";
		fileStr += "input"+i+".name='existFile';\n";
		fileStr += "multi_selector.addListRow(input"+i+");\n\n";

	}	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">


//등록
function go_add(){


 	var contents = getContents();
	$("content").value = trim(contents); 

    if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
		alert("내용을 입력하세요");
		return;
	}


	if(confirm("등록 하시겠습니까?")){

		$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
		
		$("mode").value = "bbsExec";
		$("qu").value = "insert";
		pform.action = "/homepageMgr/board/bbs.do?mode=bbsExec";
		pform.submit();

	}

}

//수정
function go_save(qu){
 	var contents = getContents();
	$("content").value = trim(contents); 

	
	if($F("title") == "" || $F("title") == " "){
		alert("제목을 입력하세요");
		$("title").focus()
		return;
	}

    if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
		alert("내용을 입력하세요");
		return;
	}
		<%if(requestMap.getString("qu").equals("insertBbsBoardForm") || requestMap.getString("qu").equals("insertReplyBbsBoard") ){%>
			if(confirm("등록 하시겠습니까?")){
			
		<%} else if(requestMap.getString("qu").equals("modifyBbsBoard")){%>
		if(confirm("수정 하시겠습니까?")){
		
		<%} %>
		
		$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다

		$("mode").value = "bbsBoardExec";
		$("qu").value = qu;
		pform.action = "/homepageMgr/board/bbs.do?mode=bbsBoardExec";
		pform.submit();

	}

}

//리스트
function go_list(){
	
	pform.action = "/homepageMgr/board/bbs.do?mode=bbsBoardList";
	pform.submit();
}

//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){


}

//로딩시.
onload = function()	{
	<%= fileStr %>

}


</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode" value="bbsBoardList">
<input type="hidden" name="qu">
<!-- 보더아이디 -->
<input type="hidden" name="boardId" value="<%=requestMap.getString("boardId")%>">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">
<!-- 시퀀스값 -->
<input type="hidden" name="seq" 	value="<%=requestMap.getString("seq") %>">
<!-- 현재 사용자 권한 -->
<input type="hidden" name="sessClass" 	value="<%=requestMap.getString("sessClass") %>">
<!-- depth값 -->

<input type="hidden" name="depth" 	value="<%=rowMap.getString("depth") %>">
<!-- setp -->
<input type="hidden" name="step" 	value="<%=rowMap.getString("step") %>">
<!-- 보더네임 -->
<input type="hidden" name="boardName" value="<%=requestMap.getString("boardName") %>">
<!-- 검색어 -->
<input type="hidden" name="selectText" value="<%=requestMap.getString("selectText") %>">
<input type="hidden" name="currPage" value="<%=requestMap.getString("currPage") %>">
<!-- 수정 삭제시 기본 키값으로 게시판 아이디를 가지고 간다. -->
<input type="hidden" name="boardId" >

<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_HOMEPAGE%>'>

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong><%=requestMap.getString("boardNmame") %> <%=requestMap.getString("boardName")%> 글 <%=requestMap.getString("qu").equals("bbsBoardModefy") ? "수정" : "등록"%></strong>
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
										<%if(memberInfo.getSessName().equals("guest") || memberInfo.getSessName().equals("")){ %>
										 <tr>
										 	<td colspan="100%">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td class="tableline31"style="padding:0 0 0 30" bgcolor="#E4EDFF" width='15%'><strong>작성자</strong></td>
														<td class="boardline22" style="padding:3 5 3 5" width='35%'><input name="username" type="text" class="textfield" style="width=200" value="<%=requestMap.getString("name") %>"></td>
														<td bgcolor="#E4EDFF" class="tableline22" style="padding:3 5 3 5" width='15%'><div align="center">패스워드</div></td>
														<td class="boardline22" style="padding:3 5 3 5" width='35%'><input name="passwd" type="password" class="textfield" style="width=100" value="<%=requestMap.getString("passwd") %>"></td>
													</tr>
												</table>
											</td>
										</tr>
										<%}else{ %>
										<input type="hidden" name="sessNo" value="<%=memberInfo.getSessNo() %>">
										<input type="hidden" name="sessName" value="<%=memberInfo.getSessName() %>">
										<%} %>
										<tr>
											<td  align="center" width="100" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>제목</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" size="100" onkeypress="if(event.keyCode==13){go_save('<%=requestMap.getString("qu") %>');return false;}" name="title" value="<%=rowMap.getString("title") %>">
											</td>
										</tr>
										<tr>
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="">
												<strong>내 용</strong>
											</td>
											<td class="tableline21" align="left">
												<%if(requestMap.getString("qu").equals("insertReplyBbsBoard")){ %>
												<!-- Namo Web Editor용 Contents -->
												<!-- 답글 컨텐츠 -->
													<input type="hidden" name="content" id="content" value="<br><br>----------------------------------------------------------<br><%=StringReplace.convertHtmlEncode(rowMap.getString("content"))%>">
												<%} else { %>
												<!-- 수정 컨텐츠 -->
													<input type="hidden" name="content" id="content" value="<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>">
												<%} %>
												
												<!-- 스마트 에디터 -->
												<jsp:include page="/se2/SE2.jsp" flush="true" >
													<jsp:param name="contents" value='<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>'/>
												</jsp:include>

											</td>
										</tr>
										<tr >
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="">
												<strong>첨부 파일</strong>
											</td>
											<td class="tableline21" align="left">&nbsp;

                                				<jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>

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






