<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 String httpVersion = request.getProtocol();
 if(httpVersion.equals("HTTP/1.0")){ 
    response.setDateHeader("Expires", 0); 
    response.setHeader("Pragma", "no-cache"); 
 } 
 else if(httpVersion.equals("HTTP/1.1")){ 
    response.setHeader("Cache-Control", "no-cache"); 
 }
%>


<%  
// prgnm : 과정 질문방 상세보기.
// date : 2008-07-09
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

	String tmpStr = "";

	//질문 상세 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

	//파일 정보
	String rowFileStr = "";
	DataMap fileMap = (DataMap)rowMap.get("FILE_GROUP_LIST");
	if(fileMap == null) fileMap = new DataMap();
	fileMap.setNullToInitialize(true);
	
	for(int i=0; i < fileMap.keySize("groupfileNo"); i++){
		if(!rowFileStr.equals(""))
			rowFileStr += "<br><br>";

		tmpStr = "javascript:fileDownload(" + fileMap.getInt("groupfileNo", i) + ", " + fileMap.getInt("fileNo", i) + ");";
		rowFileStr += "<a href=\"" + tmpStr + "\"><b>" + fileMap.getString("fileName", i) + "</b></a>";
	}


	//답변 상세 정보. 
	DataMap replyMap = (DataMap)request.getAttribute("REPLY_ROW_DATA");
	replyMap.setNullToInitialize(true);

	//답변파일 정보
	String replyFileStr = "";
	DataMap replyFileMap = (DataMap)replyMap.get("FILE_GROUP_LIST");
	if(replyFileMap == null) replyFileMap = new DataMap();
	replyFileMap.setNullToInitialize(true);
	
	for(int i=0; i < replyFileMap.keySize("groupfileNo"); i++){
		if(!replyFileStr.equals(""))
			replyFileStr += "<br><br>";

		tmpStr = "javascript:fileDownload(" + replyFileMap.getInt("groupfileNo", i) + ", " + replyFileMap.getInt("fileNo", i) + ");";
		replyFileStr += "<a href=\"" + tmpStr + "\"><b>" + replyFileMap.getString("fileName", i) + "</b></a>";
	}



%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/question.do";
	pform.submit();

}

//수정
function go_modify(){

	$("mode").value = "form";
	$("qu").value = "update";

	pform.action = "/courseMgr/question.do";
	pform.submit();

}

//답변 등록
function go_replyAdd(){

	$("mode").value = "form";
	$("qu").value = "reply_insert";

	pform.action = "/courseMgr/question.do";
	pform.submit();

}

//답변 수정.
function go_replyModify(no){

	$("mode").value = "form";
	$("qu").value = "reply_update";
	$("no").value = no;

	pform.action = "/courseMgr/question.do";
	pform.submit();

}

//질문 및 답변 삭제
function go_delete(no, depth, groupfile_no){

	$("mode").value  = "exec";
	$("qu").value    = "delete";
	$("no").value    = no;
	$("depth").value = depth;
	$("groupfile_no").value = groupfile_no;

	pform.action = "/courseMgr/question.do";
	pform.submit();

}


//로딩시.
onload = function()	{

}


//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">
<input type="hidden" name="qu"					value="">

<input type="hidden" name="grcode"				value="<%= requestMap.getString("grcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("grseq") %>">

<input type="hidden" name="no"					value="<%= requestMap.getString("no") %>">
<input type="hidden" name="pno"					value="<%= requestMap.getString("no") %>">
<input type="hidden" name="depth"				value="">
<input type="hidden" name="groupfile_no"		value="">

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
            <% // = navigationStr %>       
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td rowspan="3" width="6" style="background:#FFFFFF URL(/images/bg_navi.gif) repeat-y" nowrap></td>
					<td height="1" bgcolor="#E3E3E3"></td>
				</tr>
				<tr>
					<td bgcolor="#F5F5F5" height="33" align="right" class="font1" style="padding-right:10px">
						<%
							if (!"".equals(navigationMap.getString("navigation"))){
						%>
								<a href="<%=memberInfo.getSessCurrentAuthHome()%>">HOME</a><%=navigationMap.getString("navigation")%>
						<%
							}else{
						%>
								HOME
						<%
							}
						%>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#E3E3E3"></td></tr>
			</table>
    
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
						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif"> 건의사항 보기 </h2>
						<!--// subTitle -->
						<div class="h5"></div>

						<!-- date -->
						<table  class="dataw01">
							<tr>
								<th width="70">제목</th>
								<td colspan="3">
									<%= rowMap.getString("title") %>
								</td>
							</tr>
							<tr>
								<th>작성자</th>
								<td>
									<%= rowMap.getString("name") %> (<%= rowMap.getString("userId") %>)
								</td>
								<th>일자</th>
								<td>
									<%= rowMap.getString("regdate") %>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3" style="height:200px" valign="top">
									<%=StringReplace.convertHtmlDecode(rowMap.getString("content")) %>
								</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td colspan="3" >
									<%= rowFileStr %>
								</td>
							</tr>
						</table>
						<!-- //date -->
						
						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<%if(replyMap.getString("no").equals("")) {%>
									<input type="button" value="답변 등록"	onclick="go_replyAdd();" class="boardbtn1">
									<%}%>
									<input type="button" value="수정 "	onclick="go_modify();" class="boardbtn1">
									<input type="button" value="삭제 "	onclick="go_delete(<%= rowMap.getInt("no") %>, <%= rowMap.getInt("depth") %>, <%= rowMap.getInt("groupfileNo") %>);" class="boardbtn1" title="질문 및 첨부파일을 삭제합니다.">
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->

						<% 
						if(!replyMap.getString("no").equals("")) {
						%>
						<div class="space01"></div>


						<!-- subTitle -->
						<h2 class="h2"><img src="../images/bullet003.gif"> 조치사항 보기 </h2>
						<!--// subTitle -->
						<div class="h5"></div>

						<!-- date -->
						<table  class="dataw01">
						  <tr>
							<th width="70">제목</th>
							<td colspan="3">
								<%= replyMap.getString("title") %>
							</td>
						  </tr>
						  <tr>
							<th>분류</th>
							<td>
								<%= replyMap.getString("category") %>
							</td>
							<th>답변</th>
							<td>
								<%
									if( replyMap.getString("finishYn").equals("Y")) out.print("완료");
									else if( replyMap.getString("finishYn").equals("D")) out.print("삭제");
									else out.print("진행중");
								%>
							</td>
						  </tr>
						  <tr>
							<th>내용</th>
							<td colspan="3" style="height:150px" valign="top">
								<%= StringReplace.convertHtmlBr(replyMap.getString("content")) %>
							</td>
						  </tr>
						  <tr>
							<th>첨부파일</th>
							<td colspan="3">
								<%= replyFileStr %>
							</td>
						  </tr>
						</table>
						<!-- //date -->

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="답변 수정"	onclick="go_replyModify(<%= replyMap.getInt("no") %>);" class="boardbtn1">
									<input type="button" value="답변 삭제"	onclick="go_delete(<%= replyMap.getInt("no") %>, <%= replyMap.getInt("depth") %>, <%= replyMap.getInt("groupfileNo") %>);" class="boardbtn1" title="답변 및 첨부파일을 삭제합니다.">
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->
						<% 
						} // end if
						%>
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

