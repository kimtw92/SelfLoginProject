<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 토론방 등록/수정
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

	//Button
	String buttonStr = "";
	if(requestMap.getString("qu").equals("insert"))
		buttonStr = "<input type='button' value=' 등록 '	onclick=\"go_add();\" class='boardbtn1'>";
	else if(requestMap.getString("qu").equals("update"))
		buttonStr = "<input type='button' value=' 수정 '	onclick=\"go_modify();\" class='boardbtn1'>";
	else if(requestMap.getString("qu").equals("reply"))
		buttonStr = "<input type='button' value='답변 등록'	onclick=\"go_reply();\" class='boardbtn1'>";
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/discuss.do";
	pform.submit();

}


//등록
function go_add(){

	var contents = getContents();
	$("content").value = trim(contents); //나모 폼 체크를하기 위해 값을 가져온다.

    if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
		alert("내용을 입력하세요");
		return;
	}


	if(NChecker(document.pform) && confirm("등록 하시겠습니까?")){

		$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다

		$("mode").value = "exec";
		$("qu").value = "insert";

		pform.action = "/courseMgr/discuss.do?mode=exec";
		pform.submit();

	}

}


//수정
function go_modify(){

	var contents = getContents();
	$("content").value = trim(contents); 

	if($F("content") == "" || $F("content") == " "){
		alert("내용을 입력하세요");
		return;
	}


	if(NChecker(document.pform) && confirm("수정 하시겠습니까?")){

		$("content").value = contents; 
		$("mode").value = "exec";
		$("qu").value = "update";

		pform.action = "/courseMgr/discuss.do?mode=exec";
		pform.submit();

	}

}

//답변 등록
function go_reply(){

	var contents = getContents();
	$("content").value = trim(contents); 

	if($F("content") == "" || $F("content") == " "){
		alert("내용을 입력하세요");
		return;
	}


	if(NChecker(document.pform) && confirm("등록 하시겠습니까?")){

		$("content").value = contents;

		$("mode").value = "exec";
		$("qu").value = "reply";

		pform.action = "/courseMgr/discuss.do?mode=exec";
		pform.submit();

	}

}




//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){


}


//로딩시.
onload = function()	{
	<%= fileStr %>
}



//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">
<input type="hidden" name="qu"					value="">
<input type="hidden" name="searchKey"			value='<%=requestMap.getString("searchKey")%>'>
<input type="hidden" name="searchValue"			value='<%=requestMap.getString("searchValue")%>'>

<input type="hidden" name="grcode"				value="<%= requestMap.getString("grcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("grseq") %>">

<input type="hidden" name="seq"					value="<%= requestMap.getString("seq") %>">
<input type="hidden" name="pseq"				value="<%= requestMap.getString("seq") %>">


<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_COURSE%>'>


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


						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif"> 과정토론방관리 </h2>
						<!--// subTitle -->
						<div class="h5"></div>

						<!-- date -->
						<table  class="dataw01">
							<tr>
								<th width="70">제목</th>
								<td>
									<input type="text" class="textfield" name="title" value="<%= rowMap.getString("title") %>" style="width:80%" required="true!제목을 입력해 주십시요.">
								</td>
							</tr>
							<% if( !requestMap.getString("qu").equals("reply")){ %>
							<tr>
								<th width="70">상위글여부</th>
								<td>
									<input type="radio" class="chk_01" name="topRank" id="topRank1" value="Y" <%=rowMap.getString("topRank").equals(rowMap.getString("seq")) ? "checked" : ""%>><label for="topRank1">사용</label>
									<input type="radio" class="chk_01" name="topRank" id="topRank2" value="N" <%=!rowMap.getString("topRank").equals(rowMap.getString("seq")) ? "checked" : ""%>><label for="topRank2">미사용</label>
								</td>
							</tr>
							<% } %>
							<tr>
								<th>내용</th>
								<td>
<!-- 									SE2 컨텐츠가 담길 요소 -->
									<input type="hidden" name="content" id="content" value='<%= StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>'>

<!-- 								SE2 -->
								<jsp:include page="/se2/SE2.jsp" flush="true" >
									<jsp:param name="contents" value='<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>'/>
								</jsp:include>

								</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td>
                                	<jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>
								</td>
							</tr>
						</table>
						<!-- //date -->

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<%= buttonStr %>
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->


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
