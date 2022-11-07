<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 입교안내
// date		: 2008-08-07
// auth 	: kang
%>

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
	
	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.

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
		
		$("mode").value = "readExec";
		$("qu").value = "insert";
		pform.action = "/homepage/support.do?mode=readExec";
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
		$("boardId").value = "READING";
		$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
		$("mode").value = "readExec";
		// $("qu").value = ;
		pform.action = "/homepage/support.do?mode=readExec";
		pform.submit();
	}
}

//리스트
function go_list(){
	$("mode").value = "readList";
	pform.action = "/homepage/support.do?mode=readList";
	pform.submit();
}

//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){

<%-- 	<%= fileStr %> --%>

}

//로딩시.
onload = function()	{
	$("title").focus();
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
	$("mode").value = "readList";
	pform.action = "/homepage/support.do?mode=readList";
	pform.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	$("mode").value = "readList";
	pform.action = "/homepage/support.do?mode=readList";
	pform.submit();
}

//우편번호 검색
function searchZip(){

	var url = "/search/searchZip.do";
	url += "?mode=form";
	url += "&zipCodeName1=pform.homePost1";
	url += "&zipCodeName2=pform.homePost2";
	url += "&zipAddr=pform.homeAddr";
	pwinpop = popWin(url,"cPop","400","250","yes","yes");

}
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu" value="<%=requestMap.getString("qu")%>">
<!-- 보더아이디 -->
<input type="hidden" name="boardId"  value="<%=requestMap.getString("boardId")%>">
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

<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_HOMEPAGE%>'>

<div id="wrapper">
	<div id="dvwhset">
		<div id="dvwh">
		
			<!--[s] header -->
			<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
				<jsp:param name="topMenu" value="5" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="4" />
					<jsp:param name="leftIndex" value="1" />
					<jsp:param name="leftSubIndex" value="5" />
				</jsp:include>
				<!--[e] left -->

				<!-- contentOut s ===================== -->
				<div id="subContentArear">
					<!-- content image -->
					<div id="contImg"><div id="contImg"><img src="/images/<%= skinDir %>/sub/img_cont03.gif" alt="학습지원" /></div></div>
					<!-- //content image -->
			
					<!-- title/location -->
					<div id="top_title">
						<h1 id="title_"></h1>
						<div id="location">
						<ul> 
							<li class="home"><a href="">HOME</a></li>
							<li>열린광장</li>
							<li class="on">독서감상문</li>
						</ul>
						</div>
					</div>
					<!-- title/location -->
					<div class="spaceTop"></div>
			
					<!-- content s ===================== -->
					<div id="contents">
						<!-- title --> 
						<h2 class="h2L" style="height:30px">독서감상문</h2>
						<!--div class="txtR">(<span class="txt_org">*</span> 필수입력사항)</div-->
						<!-- //title -->
						<div class="h9"></div>
			
			
						<!-- view -->
						<table class="bView01">
						<%if(requestMap.getString("guest").length() > 0 || memberInfo.getSessName().equals("")){ %>
						<tr>
							<th class="bl0" width="75">이름</th>
							<td width="200"><input type="username" name="username" value="<%=requestMap.getString("guest") %>"/></td>
							<th width="75">비밀번호</th>
							<td width="*"><input type="password" value="" name="passwd" class="input02 w160" /></td>
						</tr>
						<%}else{ %>
						<input type="hidden" name="sessNo" value="<%=memberInfo.getSessNo() %>">
						<input type="hidden" name="sessName" value="<%=memberInfo.getSessName() %>">
						<%} %>
						<tr>
							<th class="bl0"><img src="/images/<%=skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<td colspan="3">
								<input type="text" name="title" onkeypress="if(event.keyCode==13){go_save('<%=requestMap.getString("qu") %>');return false;}" value="<%=rowMap.getString("title") %>" class="input02 w489" />
							</td>
						</tr>
						<!-- tr>
							<th class="bl0" width="75"><img src="/images/<%=skinDir %>/table/th_tell01.gif" alt="전화번호" /></th>
							<td width="200"><input type="text" value="<%=Util.divideMPhone(memMap.getString("homeTel"))[0] %>" name="homeTel_1" class="input02 w32" /> - <input type="text" value="<%=Util.divideMPhone(memMap.getString("homeTel"))[1] %>" name="homeTel_2" class="input02 w32" /> - <input type="text" value="<%=Util.divideMPhone(memMap.getString("homeTel"))[2] %>" name="homeTel_3" class="input02 w32" /></td>
							<th width="75"><img src="/images/<%=skinDir %>/table/th_email01.gif" alt="E-mail" /></th>
							<td width="*"><input type="text" value="<%=memMap.getString("email") %>" name="email" class="input02 w160" /></td>
						</tr>
						<tr>
							<th class="bl0"><img src="/images/<%=skinDir %>/table/th_zipcord01.gif" alt="우편번호" /></th>
							<td colspan="3"><input type="text" value="<%=memMap.getString("homePost1") %>" name="homePost1" class="input02 w32" /> - <input type="text" value="<%=memMap.getString("homePost2") %>" name="homePost2" class="input02 w32" /> &nbsp;<a href="javascript:searchZip();">(검 색)</a></td>
						</tr>
						<tr>
							<th class="bl0"><img src="/images/<%=skinDir %>/table/th_adrres01.gif" alt="주소" /></th>
							<td colspan="3"><input type="text" value="<%=memMap.getString("homeAddr") %>" name="homeAddr" class="input02 w489" /></td>
						</tr> -->
						
						<tr>
							<td class="bl0 edt" colspan="4">
								<%if(requestMap.getString("qu").equals("insertReplyBbsBoard")){ %>
								<!-- Namo Web Editor용 Contents -->
								<!-- 답글 컨텐츠 -->
									<input type="hidden" name="content" id="content" value="<br><br>----------------------------------------------------------<br><%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>">
								<%} else { %>
								<!-- 수정 컨텐츠 -->
									<input type="hidden" name="content" id="content" value="<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>">
								<%} %>
								
								<!-- 스마트 에디터 -->
								<jsp:include page="/se2/SE2.jsp" flush="true" >
									<jsp:param name="contents" value="<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>"/>
								</jsp:include>
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
							<a href="javascript:go_save('<%=requestMap.getString("qu") %>');"><img src="/images/<%=skinDir %>/button/btn_save01.gif" alt="저장" /></a>
							<a href="javascript:go_list()"><img src="/images/<%=skinDir %>/button/btn_list02.gif" alt="리스트" /></a>
						</div>
						<!-- //button -->
						<div class="space"></div>
					</div>
					<!-- //content e ===================== -->
			
				</div>
				<!-- //contentOut e ===================== -->

				<div class="spaceBtt"></div>
			</div>			
		</div>
		
		<div id="divQuickMenu" style="position:absolute; top:10; left:89%; width:90px; height:264px; z-index:1">
			<!--[s] quick -->
			<jsp:include page="/commonInc/include/comQuick.jsp" flush="false"/>
			<!--[e] quick -->
		</div>
	</div>
	<!--[s] footer -->
	<jsp:include page="/commonInc/include/comFoot.jsp" flush="false"/>
	<!--[e] footer -->
</div>

</form>
</body>	