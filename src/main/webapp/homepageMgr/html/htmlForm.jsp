<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : html관리폼
// date : 2008-06-23
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
	
	//Html관리 ROW데이터
	DataMap rowMap = (DataMap)request.getAttribute("ROWMAP_DATA");
	rowMap.setNullToInitialize(true);
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript" type="text/JavaScript">

function go_insert(){
	var str_data = $("htmlId").value;
	//영문 숫자 체크
	if(str_data != "" || str_data != null){	
		for(i=0;i<str_data.length;i++){
			if(str_data.charCodeAt(i) < 48 && str_data.charCodeAt(i) > 57 
			   && str_data.charCodeAt(i) < 97 && str_data.charCodeAt(i) > 122
			   || str_data.charCodeAt(i) < 65 && str_data.charCodeAt(i) > 90){
				alert("유요한 아이디 이름이 아닙니다. 영문자와 숫자로 4자리 이상 20자리 이하로 작업해 주십시오.");
				$("htmlId").focus();
				return false;
				break;
			}
		}
	}
	
	//게시판아이디가 4글자이상인지 체크
	if(str_data.length < 4 || str_data.length > 20){
		alert("유요한 아이디 이름이 아닙니다. 영문자와 숫자로 4자리 이상 20자리 이하로 작업해 주십시오.");
		$("htmlId").focus();
		return false;
	}
	
	if($("htmlGubun").value == "2" && $("uploadFile").value ==""){
		alert("Html파일을 업로드 하십시오.");
		return false;
	}
	
	if(NChecker(document.pform)){
		 	var contents = getContents();
			$("content").value = trim(contents); 
	
		    if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
				alert("내용을 입력하세요");
				return;
			}
			
			if(confirm("등록 하시겠습니까?")){
			
			$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
		
			$("mode").value = "exec";
			$("qu").value = "insert";
			pform.action = "/homepageMgr/html.do?mode=exec";
			pform.submit();
		}
	}
}

//업로드파일 서식 다운로드
function goUploadFileDown(){
  location.href='/homepageMgr/html/html_upload.zip';
}

//수정
function go_modify(){
		
	 	var contents = getContents();
		$("content").value = trim(contents); 
	
	    if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
			alert("내용을 입력하세요");
			return;
		}
		
		if(confirm("수정 하시겠습니까?")){
		
		$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
	
		$("mode").value = "exec";
		$("qu").value = "modify";
		pform.action = "/homepageMgr/html.do?mode=exec";
		pform.submit();
	}

}
	
//리스트
function go_list(){
	$("mode").value="list";
	pform.action = "/homepageMgr/html.do?mode=list";
	pform.submit();
}

function changeDisplay(value){
	if(value == "1"){
		 document.getElementById("view1").style.display = "";
	 	 document.getElementById("view2").style.display = "none";
	}else{
		document.getElementById("view1").style.display = "none";
		document.getElementById("view2").style.display = "";
	}	
		
}

//로딩시.
onload = function()	{
var htmlGubun = "<%=rowMap.getString("htmlGubun") %>";
	if(htmlGubun == "1"){
		document.getElementById("gubun1").checked == true;
	}else if(htmlGubun == "2"){
		document.getElementById("gubun2").checked == true;
	}else{
		document.getElementById("gubun1").checked == true;	
	}
	
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
<!-- 유저 넘버 -->
<input type="hidden" name="wuserno" 	value="<%=memberInfo.getSessNo() %>">
<!-- 수정모드일시 값을 가진다.-->
<%if(requestMap.getString("qu").equals("modify")){ %>
<input type="hidden" name="htmlId" 	value="<%=requestMap.getString("htmlId") %>">
<%} %>
<!-- 수정모드일시 전페이지의 페이징값과 검색값을 가지고 있는다. 수정 후 목록을 눌렀을때 해당페이지 다시 보이기 -->
<input type="hidden" name="currPage" 	value="<%=requestMap.getString("currPage") %>">
<input type="hidden" name="selectValue" 	value="<%=requestMap.getString("selectValue") %>">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong><%=rowMap.getString("htmlId") %> <%=requestMap.getString("qu").equals("modify") ? "수정" : "등록"%></strong>
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
												<strong>작성자</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<%=memberInfo.getSessName() %>
											</td>
										</tr>
										<tr>
											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>Html ID</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<%if(requestMap.getString("qu").equals("insert")){%>
													<input type="text" name="htmlId" required="true!Html ID를 입력하세요.">
												<%}else{out.print(rowMap.getString("htmlId"));} %>
											</td>
										</tr>
										<tr>
											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>Html 제목</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input value="<%=rowMap.getString("htmlTitle")%>" required="true!Html 제목을 입력하세요." name="htmlTitle" type="text">
											</td>
										</tr>
										<tr>

											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>메뉴 ID</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" value="<%=rowMap.getString("menuid")%>" required="true!메뉴 ID를 입렵하세요." name="menuid">
											</td>
										</tr>
										<tr>
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF"><strong>Html 구분</strong></td>
											<td><input type="radio" name="htmlGubun" onclick="changeDisplay('1')" value="1" id="gubun1" checked>직접입력 <input type="radio" name="htmlGubun" id="gubun2" value="2" onclick="changeDisplay('2')">html 업로드</td>
										</tr>
											<tr id="view1">
												<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="15%">
													<strong>html 내용</strong>
												</td>
												
												<td class="tableline21" align="left">
													<!-- Namo Web Editor용 Contents -->
													<!-- 수정 컨텐츠 -->
														<input type="hidden" name="content" id="content" value="<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("htmlContent"))%>">
													
														<!-- 스마트 에디터 -->
														<jsp:include page="/se2/SE2.jsp" flush="true" >
															<jsp:param name="contents" value="<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("htmlContent"))%>"/>
														</jsp:include>
												</td>
												
											</tr>
											<tr id="view2" style="display:none">
												<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="15%">
													<strong>html파일 업로드</strong>
												</td>
												<td class="tableline21" align="left">
												  ※ Html 작성규칙을 따르셔야 합니다. <br>
												  ※ 이미지를 포함하여 Zip파일로 업로드 하시기 바랍니다<input type="button" onclick="goUploadFileDown();" class='boardbtn1' value="샘플받기"><br>
												  <input type="file" name="uploadFile" size="30">
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
												<%if(requestMap.getString("qu").equals("insert")){ %>
													<input type=button value='등록' onClick="go_insert('insert');" class=boardbtn1>
												<%}else{ %>
													<input type=button value='수정' onClick="go_modify('modify');" class=boardbtn1>
												<%} %>												
												<input type=button value=' 리스트 ' onClick="go_list();" class=boardbtn1>
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