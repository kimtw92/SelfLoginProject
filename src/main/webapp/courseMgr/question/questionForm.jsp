<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 질문방 등록.
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

	//상세 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);


	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.

	DataMap fileMap = (DataMap)rowMap.get("FILE_GROUP_LIST");
	if(fileMap == null) fileMap = new DataMap();
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
	//파일 정보 END

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/question.do?mode=list";
	pform.submit();

}

//수정
function go_modify(){

	if(NChecker(document.pform) && confirm("수정하시겠습니까?")){

		$("mode").value = "exec";
		$("qu").value = "update";

		pform.action = "/courseMgr/question.do?mode=exec";
		pform.submit();

	}

}

//답변 등록
function go_replyAdd(){

	if( $F("category") == "" ){
		alert("조치사항 분류를 선택해 주십시요!");
		return;
	}
	if( $F("finishYn") == "" ){
		alert("조치사항 답변을 선택해 주십시요");
		return;
	}

	if(NChecker(document.pform) && confirm("등록 하시겠습니까?")){

		$("mode").value = "exec";
		$("qu").value = "reply_insert";

		pform.encoding = "multipart/form-data";
		pform.action = "/courseMgr/question.do?mode=exec";
		pform.submit();
		
	}

}

//답변 수정.
function go_replyModify(){

	if( $F("category") == "" ){
		alert("조치사항 분류를 선택해 주십시요!");
		return;
	}
	if( $F("finishYn") == "" ){
		alert("조치사항 답변을 선택해 주십시요");
		return;
	}

	if(NChecker(document.pform) && confirm("등록 하시겠습니까?")){

		$("mode").value = "exec";
		$("qu").value = "reply_update";

		pform.encoding = "multipart/form-data";
		pform.action = "/courseMgr/question.do?mode=exec";
		pform.submit();

	}

}



//로딩시.
onload = function()	{
	<%= fileStr %>
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
<input type="hidden" name="pno"					value="<%= requestMap.getString("pno") %>">


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

					<%
						//수정
						if(requestMap.getString("qu").equals("update")){
					%>
						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif"> 건의사항 수정 </h2>
						<!--// subTitle -->
						<div class="h5"></div>

						<!-- date -->
						<table  class="dataw01">
							<tr>
								<th width="70">제목</th>
								<td colspan="3">
									<input type="text" class="textfield" name="title" value="<%= rowMap.getString("title") %>" style="width:80%" required="true!건의사항 제목을 입력해 주십시요.">
								</td>
							</tr>
							<tr>
								<th>작성자</th>
								<td>
									<input type="text" class="textfield" name="name" value="<%= rowMap.getString("name") %>" style="width:150px">
								</td>
								<th>일자</th>
								<td>
									<input type="text" class="textfield" name="regdate" value="<%= rowMap.getString("regdate") %>" style="width:60">
									&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar('', 'commStrdate');" style="cursor:hand;">
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3">
									 <textarea class="textarea01" style="width:99%;height:200px;" name="content"><%= rowMap.getString("content") %></textarea>
								</td>
							</tr>
						</table>
						<!-- //date -->

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value=" 수정 "	onclick="go_modify();" class="boardbtn1">
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->


					<%
						}else{ //답변 등록 및 수정.
					%>
<SCRIPT LANGUAGE="JavaScript">
<!--
//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){

}
//-->
</SCRIPT>
<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_COURSE%>'>

						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif"> 조치사항 보기 </h2>
						<!--// subTitle -->
						<div class="h5"></div>

						<!-- date -->
						<table  class="dataw01">
							<tr>
								<th width="70">제목</th>
								<td colspan="3">
									<input type="text" class="textfield" name="title" value="<%= rowMap.getString("title") %>" style="width:80%" required="true!조치사항 제목을 입력해 주십시요.">
								</td>
							</tr>
							<tr>
								<th>분류</th>
								<td>
									<select name="category" class="mr10">
										<option value="">--선택--</option>
										<option value="강사">강사</option>
										<option value="교과정">교과정</option>
										<option value="시설">시설</option>
										<option value="기타">기타</option>
									</select>
								</td>
								<th>답변</th>
								<td>
									<select name="finishYn" class="mr10">
										<option value="">--선택--</option>
										<option value="N">진행중</option>
										<option value="Y">완료</option>
										<option value="D">삭제</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3">
									<textarea class="textarea01" style="width:99%;height:200px;" name="content" required="true!조치사항 내용을 입력해 주십시요."><%= rowMap.getString("content") %></textarea>
								</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td colspan="3">
                                	<jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>
								</td>
							</tr>
						</table>
						<!-- //date -->

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
								<%if(requestMap.getString("qu").equals("reply_insert")){%>
									<input type="button" value="답변 등록"	onclick="go_replyAdd();" class="boardbtn1">
								<%}else if(requestMap.getString("qu").equals("reply_update")){%>
									<input type="button" value="답변 수정"	onclick="go_replyModify();" class="boardbtn1">
								<%}%>
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->


						<script language="javascript">
							$("category").value = "<%= rowMap.getString("category") %>";
							$("finishYn").value = "<%= rowMap.getString("finishYn") %>";
						</script>

					<%
						}
					%>
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

