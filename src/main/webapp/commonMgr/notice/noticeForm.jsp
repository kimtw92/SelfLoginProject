<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시스템관리자 > 시스템관리 > 홈페이지 관리 > 개인공지 관리 등록/수정.
// date : 2008-05-23
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//공통 권한 체크박스
	DataMap chkAuth=(DataMap)request.getAttribute("chk_auth");
	chkAuth.setNullToInitialize(true);
	
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
	
	//수정시 선택된 학생 또는 그룹 출력
	String optionStr="";
	String selectedStr="";
	DataMap selectedGroup= null;
	if(requestMap.getString("qu").equals("update")){
		if(rowMap.getString("notiGubun").equals("P")){
			DataMap optionMap = (DataMap)rowMap.get("optionMap");
			optionMap.setNullToInitialize(true);				
			for(int i=0;i<optionMap.keySize("name");i++){
				optionStr += "<option value='"+optionMap.getString("no",i)+"'>"+optionMap.getString("name",i)+"</option>";
			}
		}else{
			selectedGroup =(DataMap)rowMap.get("selectedGroup");
			selectedGroup.setNullToInitialize(true);
			selectedStr +="<script language='javascript'>";
			for(int i=0;i<selectedGroup.keySize("group");i++){
				selectedStr +="setcheckboxs('noti_group[]',"+selectedGroup.getString("group",i)+");";				
			}
			selectedStr +="</script>";
		}
	}		
	
	//공통 권한 체크박스
	String checkAuth="";
	if(chkAuth != null){
		for(int i=0;i<chkAuth.keySize("auth");i++){			
			if(!checkAuth.equals("")){
				checkAuth += "&nbsp;, &nbsp;";
			}			
			checkAuth += "<input type='checkbox' name='noti_group[]' value='"+chkAuth.getString("auth",i)+"'>"+chkAuth.getString("auth_name",i);	
		}
	}
	
	String qu=requestMap.getString("qu");	
	
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
	//파일 정보 END
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--
	//등록
	function go_add(){
		var list  = document.getElementById('noti_part[]');
		//----------------------------------------------------------------------------
		// 추가된 학생을 전부 선택한다.
		//----------------------------------------------------------------------------
		for(var i=0; i<list.length; i++) {
			if(list[i]&&!list[i].selected) list[i].selected = true;
		}

		var contents = getContents(); // naver 에디터에서 컨텐츠를 가지고 온다.
		
		$("content").value = trim(contents); 
	
		if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
			alert("내용을 입력하세요");
			return;
		}
	
	
		if(confirm("등록 하시겠습니까?")){
	
			$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
			
			$("mode").value = "exec";
			$("qu").value = "insert";
			pform.action = "/commonMgr/notice.do?mode=exec";
			pform.submit();
	
		}
	
	}

	//수정
	function go_modify(){
		var list  = document.getElementById('noti_part[]');
		//----------------------------------------------------------------------------
		// 추가된 학생을 전부 선택한다.
		//----------------------------------------------------------------------------
		for(var i=0; i<list.length; i++) {
			if(list[i]&&!list[i].selected) list[i].selected = true;
		}
	
		var contents = getContents(); // naver 에디터에서 컨텐츠를 가지고 온다.
		
		$("content").value = trim(contents); 
	
		if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
			alert("내용을 입력하세요");
			return;
		}
	
		if(confirm("수정 하시겠습니까?")){
	
			$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
	
			$("mode").value = "exec";
			$("qu").value = "update";
			pform.action = "/commonMgr/notice.do?mode=exec";
			pform.submit();
	
		}
	
	}

	function initiate(){
		var qu="<%=qu%>";
		var gubun="<%=rowMap.getString("notiGubun")%>";
		if(qu == "insert"){
			document.getElementById("sel_G").style.visibility="hidden";
		  	document.getElementById("sel_G").style.display="none";
		}else if(qu == "update"){		
			if(gubun == "P"){
				setVisible("sel_G", "hidden");
				setVisible("sel_P", "visible");
			}else{
				setVisible("sel_G", "visible");
				setVisible("sel_P", "hidden");
			}
		}	
			
	}
	
	//리스트
	function go_list(){
	
		$("mode").value = "list";
	
		pform.action = "/commonMgr/notice.do";
		pform.submit();
	
	}
	
	//개인공지시 검색 List에서 선택 삭제.
	function selectListDelete() {
	
	  var list  = $('noti_part[]');
	  if(list.selectedIndex > -1) {
	    list.options.remove(list.selectedIndex);
	  } else {
	    alert('삭제할 항목을 선택하세요');
	  }
	
	}
	
	//개인공지시 대상자 검색
	function go_searchPopup(){
		var url = "/commonMgr/notice.do?mode=searchPerson&searchKey=&searchValue=&searchText=";
		window.open(url, "goSearchPopup", "width=800, height=700,scrollbars=yes");
	}
	
	function setVisible(obj, type) {
		document.getElementById(obj).style.visibility = type;
		if(type == "hidden") {
			document.getElementById(obj).style.display="none";
		} else {
			document.getElementById(obj).style.display="";
		}
	}
	
	//수정시 inno에 기존 파일 넣은 변수 및 함수.
	var g_ExistFiles = new Array();
	function OnInnoDSLoad(){
	
	
	}
	
	//수정시 각 selectBox선택하도록
	function OnloadScript(){
		<%=rowMap.getString("js_str")%>
	}
	//로딩시.
	onload = function()	{
		initiate();
		<%= fileStr %>
	}

	function setcheckboxs(objname,value){
		var form  = eval("document.all['"+objname+"']");
	
		for(var i=0; i < form.length; i++){
			if(!form[i].checked) {
				if(form[i].value == value) form[i].checked = true;
			}
		}
	}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" action="/commonMgr/notice.do" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="searchKey"			value='<%=requestMap.getString("searchKey")%>'>
<input type="hidden" name="searchValue"			value='<%=requestMap.getString("searchValue")%>'>

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>
<input type="hidden" name="seq"					value='<%=requestMap.getString("seq")%>'>

<input type="hidden" name="username"				value='<%=memberInfo.getSessName() %>'>

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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->


			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#D6DBE5">

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" width="15%" align="center"><strong>작성자</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;<%=memberInfo.getSessName()%></td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>제목</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;
												<input type="text" class="textfield" name="title" value="<%=rowMap.getString("title")%>" style="width:50%">
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>구분</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;
												<input type="radio" class="textfield" name="notiGubun" id="notiGubun1" value="P" onClick="setVisible('sel_G', 'hidden');setVisible('sel_P', 'visible');" <%=!rowMap.getString("notiGubun").equals("G") ? "checked" : ""%>><label for="grgubun1">개인공지</label>
												<input type="radio" class="textfield" name="notiGubun" id="notiGubun2" value="G" onClick="setVisible('sel_P', 'hidden');setVisible('sel_G', 'visible');" <%=rowMap.getString("notiGubun").equals("G") ? "checked" : ""%>><label for="grgubun2">그룹공지</label>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" id="sel_P">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>검색</strong></td>
											<td class="tableline21" align="left" width="75%">
												&nbsp;***공지대상을 추가하세요***<br>
												<select name="noti_part[]" size=10 style="width:20%" multiple="multiple">
													<%=optionStr%>
												</select>&nbsp;&nbsp;
												<input type='button' value="선택삭제" class="boardbtn1" onClick="selectListDelete()">
												<input type='button' value="대상검색" class="boardbtn1" onClick="go_searchPopup();">											
											</td>
										</tr>
										<tr bgcolor="#FFFFFF" id="sel_G">
											<td  height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>대상선택</strong></td>
											<td>
												<%=checkAuth %>
											</td>
										</tr>										
										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>내용</strong></td>
											<td class="tableline21" align="left" width="75%">
												<input type="hidden" name="content" id="content" value='<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>'>												<!-- Namo Web Editor 사용시 Include 필요함. -->
												<jsp:include page="/se2/SE2.jsp" flush="true" >
													<jsp:param name="contents" value='<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>'/>
												</jsp:include>

											</td>
										</tr>
										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>첨부파일</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;
                                				<jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>

											</td>
										</tr>



									</table>


								</td>
							</tr>

						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="right">
								<%if(requestMap.getString("qu").equals("insert")){%>
									<input type="button" class="boardbtn1" value=' 등록 ' onClick="go_add();">
								<%}else if(requestMap.getString("qu").equals("update")){%>
									<input type="button" class="boardbtn1" value=' 수정 ' onClick="go_modify();" >
								<%}%>
									<input type="button" class="boardbtn1" value='리스트' onClick="go_list();" >
								</td>
							</tr>
						</table>

						<!---[e] content -->
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->

			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
<%=selectedStr %>
</body>


