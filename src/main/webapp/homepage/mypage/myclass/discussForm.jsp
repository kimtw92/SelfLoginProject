<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
	//리스트 데이터
	DataMap memMap = (DataMap)request.getAttribute("MEMBER_DATA");
	memMap.setNullToInitialize(true);
	
	DataMap rowMap = (DataMap)request.getAttribute("BOARDVIEW_DATA");
	rowMap.setNullToInitialize(true);
	
	//과정기수 상세정보
	DataMap grInfoMap = (DataMap)request.getAttribute("GRINFO_DATA");
	grInfoMap.setNullToInitialize(true);
	
	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.
	try {
		DataMap fileMap = (DataMap)rowMap.get("FILE_GROUP_LIST");

		if(fileMap == null)
			fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
		for(int i=0; i < fileMap.keySize("groupfileNo"); i++){

			if(fileMap.getInt("groupfileNo", i)==0){
				continue;
			}
			
			tmpStr = fileMap.getString("groupfileNo", i) + "#" + fileMap.getString("fileNo", i); 
// 			fileStr += "document.InnoDS.AddTempFile('" + fileMap.getString("fileName", i) + "', " + fileMap.getInt("fileSize", i) + ", '" + tmpStr + "');";
// 			fileStr += "g_ExistFiles['" + tmpStr + "'] = false;";

            fileStr += "var input"+i+" = document.createElement('input');\n";
			fileStr += "input"+i+".value='"+fileMap.getString("fileName", i)+"';\n";
			fileStr += "input"+i+".setAttribute('fileNo', '"+tmpStr+"');\n";
			fileStr += "input"+i+".name='existFile';\n";
			fileStr += "multi_selector.addListRow(input"+i+");\n\n";

		}	
	} catch(Exception e) {
	}

%>

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
		
		$("mode").value = "discussExec";
		$("qu").value = "insertDiscuss";
		tx_editor_form.action = "/mypage/myclass.do?mode=discussExec";
		tx_editor_form.submit();

	}
}

//수정
function go_save(qu){
	
 	var contents = getContents();
	
	$("content").value = contents; //나모 폼 체크를하기 위해 값을 가져온다.
	
	var keywordCheck = false;
	keywordCheck = SearchKeyword();
	if(!keywordCheck) { 
		return;
	}

	if($("title").value == "" || $("title").value == " "){
		alert("제목을 입력하세요");
		$("title").focus()
		return;
	}
    if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
		alert("내용을 입력하세요");
		return;
	}
    
	<%if(requestMap.getString("qu").equals("insertDiscuss") || requestMap.getString("qu").equals("insertReplyDiscuss") ){%>
	if(confirm("등록 하시겠습니까?")){
			
	<%} else if(requestMap.getString("qu").equals("modifyDiscuss")){%>
	if(confirm("수정 하시겠습니까?")){
		
	<%} %>
		$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
		$("mode").value = "discussExec";
		// $("qu").value = ;
		tx_editor_form.action = "/mypage/myclass.do?mode=discussExec";
		tx_editor_form.submit();
	}
}

//리스트
function go_list(){
	$("mode").value = "discussList";
	tx_editor_form.action = "/mypage/myclass.do";
	tx_editor_form.submit();
}

//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){
<%-- 	<%= fileStr %> --%>
}

//로딩시.
onload = function()	{
	$("title").focus();
	<%= fileStr %>
}


</script>
<script language="JavaScript" type="text/JavaScript">
// <!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	$("mode").value = "discussList";
	tx_editor_form.action = "/mypage/myclass.do?mode=discussList";
	tx_editor_form.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	$("mode").value = "discussList";
	tx_editor_form.action = "/mypage/myclass.do?mode=discussList";
	tx_editor_form.submit();
}

//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left1.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual1.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>나의강의실</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; <span>나의강의실</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			
            <div class="mytab01">
              <ul>
                <li><a href="javascript:fnGoMenu('1','selectCourseList')"><img src="/homepage_new/images/M1/tab01.gif" alt="과정리스트"/></a></li>
                <li><a href="javascript:fnGoMenu('1','selectGrnoticeList')""><img src="/homepage_new/images/M1/tab02.gif" alt="과정공지"/></a></li>
                <li><a href="javascript:fnGoMenu('1','pollList')""><img src="/homepage_new/images/M1/tab03.gif" alt="과정설문"/></a></li>
                <li><a href="javascript:fnGoMenu('1','testView')""><img src="/homepage_new/images/M1/tab04.gif" alt="과정평가"/></a></li>
                <li><a href="javascript:fnGoMenu('1','discussList')""><img src="/homepage_new/images/M1/tab05_on.gif" alt="과정토론방"/></a></li>
                <li><a href="javascript:fnGoMenu('1','suggestionList')""><img src="/homepage_new/images/M1/tab06.gif" alt="과정질문방"/></a></li>
                <li><a href="javascript:fnGoMenu('1','courseInfoDetail')""><img src="/homepage_new/images/M1/tab07.gif" alt="교과안내문"/></a></li>
                <li><a href="javascript:fnGoMenu('1','sameClassList')""><img src="/homepage_new/images/M1/tab08.gif" alt="동기모임"/></a></li>
              </ul>
              </div>
              <form id="tx_editor_form" name="tx_editor_form" method="post" enctype="multipart/form-data">
<input type="hidden" id="mode" name="mode"	value="">
<input type="hidden" id="qu"   name="qu" 	value="<%=requestMap.getString("qu")%>">
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

<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_HOMEPAGE%>'>
<div id="contents">
						<div class="h15"></div>
			
						<!-- title --> 
						<h4 class="h4Ltxt"><%= grInfoMap.getString("grcodenm") %></h4>
						<!-- //title -->
						<div class="h9"></div>
			
						<!-- view -->
						<table class="bView01">
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<td colspan="3">
								<input type="text" id="title" name="title" onkeypress="if(event.keyCode==13){go_save('<%=requestMap.getString("qu") %>');return false;}" value="<%=rowMap.getString("title") %>" class="input02 w489" />
							</td>
						</tr>
						<input type="hidden" name="sessNo" value="<%=memberInfo.getSessNo() %>">
						<input type="hidden" name="sessName" value="<%=memberInfo.getSessName() %>">
						<tr>
							<td class="bl0 edt" colspan="4">
								<%
									String content = "";
									try {
										content = StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"));
									} catch(Exception e) {
									}
								%>
								<!-- 스마트 에디터 -->
								<jsp:include page="/se2/SE2.jsp" flush="true" >
									<jsp:param name="contents" value="<%=content%>"/>
								</jsp:include>
							</td>
						</tr>
						<tr>
							<td class="bl0 edt" colspan="4">
								<%if(requestMap.getString("qu").equals("insertReplyDiscuss")){ %>
								<!-- Namo Web Editor용 Contents -->
								<!-- 답글 컨텐츠 -->
									<input type="hidden" name="content" id="content" value="<br><br>----------------------------------------------------------<br><%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>">
								<%} else { %>
								<!-- 수정 컨텐츠 -->
									<input type="hidden" name="content" id="content" value="<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>">
								<%} %>
								
							</td>
						</tr>
						<tr>
							<td class="bl0 edt" colspan="4">
                                <jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>

							</td>
						</tr>	

						</table>	
						<!-- //view -->
			
						<!-- button -->
						<div class="btnRbtt">
							<a href="javascript:go_save('<%=requestMap.getString("qu") %>');"><img src="/images/<%= skinDir %>/button/btn_save01.gif" alt="저장" /></a>
							<a href="javascript:go_list()"><img src="/images/<%= skinDir %>/button/btn_list02.gif" alt="리스트" /></a>
						</div>
						<!-- //button -->
						<div class="space"></div>
					</div>

</form>
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>
    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>