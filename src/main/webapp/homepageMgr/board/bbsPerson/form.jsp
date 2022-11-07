<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	//게시판 기본정보
	DataMap personDataMap = (DataMap)request.getAttribute("PERSON_DATA");
//	DataMap personMap = personDataMap.getString(null);
	personDataMap.setNullToInitialize(true);

%>


<%-- <%@ include file="/commonInc/include/commonImport.jsp" %> --%>
<%-- <%@ include file="/commonInc/include/comInclude.jsp" %> --%>

<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

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
		
		$("mode").value = "personExec";
		$("qu").value = "insert";
		pform.action = "/homepageMgr/board/bbs.do?mode=personExec";
		pform.submit();
	}
}

//수정
function go_save(qu){
	var title = document.getElementById("title");
	var content = document.getElementById("content");
	var username = document.getElementById("username");
	var passwd = document.getElementById("passwd");
	
	if(title.value == "" || title.value == " "){
		alert("제목을 입력하세요");
		title.focus();
		return;
	}

    if(content.value == "" || content.value == " ") {
		alert("내용을 입력하세요");
		content.focus();
		return;
	}
    if(username.value == "" || username.value == " ") {
		alert("이름을 입력하세요");
		username.focus();
		return;
	}
    if(passwd.value == "" || passwd.value == " ") {
		alert("비밀번호를 입력하세요");
		passwd.focus();
		return;
	}
    if(passwd.value == "" || passwd.value == " ") {
		alert("비밀번호를 입력하세요");
		passwd.focus();
		return;
	}
	if(qu.equals("insert")){
		if(!confirm("등록 하시겠습니까?")){
			return;
		}
	} else if(qu.equals("select")){
		if(!confirm("수정 하시겠습니까?")){
			return;
		}
	}
	console.log("진행... ");

	$("mode").value = "bbsBoardExec";
	$("qu").value = qu;
	pform.action = "/homepage/person.do?mode=personExec";
	pform.submit();
	
}


//리스트
function go_list(){
	pform.action = "/homepage/person.do?mode=personlist";
	pform.submit();
}

//로딩시.
onload = function()	{
	var mode = "<%=requestMap.getString("mode")%>";
	var qu = "<%=requestMap.getString("qu")%>";
	
	var idmode = document.getElementById("mode");
	idmode.value = mode;
	var idqu = document.getElementById("qu");
	idqu.value = qu;
	
	if ( qu == "select") {
		var title = document.getElementById("title");
		title.value = "<%=(null == personDataMap) ? "" : personDataMap.getString("title", 0)%>";
		var username = document.getElementById("username");
		username.value = "<%=(null == personDataMap) ? "" : personDataMap.getString("username", 0)%>";
		var content = document.getElementById("content");
		content.value = "<%=(null == personDataMap) ? "" : personDataMap.getString("content", 0)%>";
		var phone = document.getElementById("phone");
		phone.value = "<%=(null == personDataMap) ? "" : personDataMap.getString("phone", 0)%>";
		var seq = document.getElementById("seq");
		seq.value = "<%=(null == personDataMap) ? "" : personDataMap.getString("seq", 0)%>";
		var passwd = document.getElementById("passwd");
		passwd.value = "<%=(null == personDataMap) ? "" : personDataMap.getString("passwd", 0)%>";
	}
		
		
}


</script>

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="">
	<input type="hidden" name="qu" id="qu">
	<!-- 시퀀스값 -->
	<input type="hidden" name="seq" id="seq">
	<input type="hidden" name="remoteIp" id="remoteIp">
	
	<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
	
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	    
	    <tr>
	        <td colspan="2" valign="top" class="leftMenuBg">
				<!--[s] 타이틀 -->
				
				<!--[e] 타이틀 -->
				<!--[s] subTitle -->
				<table width="100%" height="10"><tr><td></td></tr></table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
					<tr>
						<td height="20">
							<strong style="padding-left:20px;font-size:14px;">감사장에 바란다.</strong>
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
												<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="100px;">
													<strong>제목</strong>
												</td>
												<td  style="padding-left:10px" class="tableline21" align="left">
													<input type="text" id="title" name="title" style="width:100%;">
												</td>
											</tr>
											<tr>
												<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="100px;">
													<strong>내용</strong>
												</td>
												<td  style="padding-left:10px" class="tableline21" align="left">
													<textarea rows="10" id="content" name="content" style="width:100%;">
													</textarea>
												</td>
											</tr>
											<tr>
												<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="100px;">
													<strong>이름</strong>
												</td>
												<td style="padding-left:10px" class="tableline21">
													<input type="text" id="username" name="username" style="width:100%;">
												</td>
											</tr>
											<tr>
												<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="100px;">
													<strong>연락처</strong>
												</td>
												<td  style="padding-left:10px" class="tableline21" align="left">
													<input type="text" id="phone" name="phone" style="width:100%;">
												</td>
											</tr>
											<tr>
												<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="100px;">
													<strong>비밀번호<br/><span style="color:red;">(4자리숫자)</span></strong>
												</td>
												<td  style="padding-left:10px" class="tableline21" align="left">
													<input type="text" id="passwd" name="passwd" style="width:100%;">
												</td>
											</tr>
											<tr>
												<td align='right' height="40" colspan="100%">
													<input type=button value='저장' onClick="go_save('<%= requestMap.getString("qu") %>');" class=boardbtn1>
													<input type=button value='리스트 ' onClick="go_list();" class=boardbtn1>
											  </td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>	
	        </td>
	    </tr>
	</table>
</form>
</body>






