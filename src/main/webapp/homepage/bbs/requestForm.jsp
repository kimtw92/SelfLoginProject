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
	String isSync = (String)request.getAttribute("USERIDSYNC");

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
<%
String boardId = (String)request.getAttribute("boardId");
String s_userno = requestMap.getString("userno");
String isAdminYn = requestMap.getString("isAdminYn");

if("QNA".equals(boardId)) { 
%>
window.onload = ischeck() ;

function ischeck() {

	var isSync = '<%=isSync%>';
	
	if (isSync == "C") {
		alert("로그인후 이용 가능합니다.");
		history.back(-1);
		return;
		
	} else if (isSync == "N") {
		alert("작성자만 볼 수 있습니다." );
		history.back(-1);
		return;
		
	}
}

<% } %>
	function go_save(qu){
// 	$("content").value = Editor.getContent(); //나모 폼 체크를하기 위해 값을 가져온다.
	var contents = getContents(); // naver 에디터에서 컨텐츠를 가지고 온다.
	
	var keywordCheck = false;
	keywordCheck = SearchKeyword();
	if(!keywordCheck) { 
		return;
	}

	if($F("title") == "" || $F("title") == " "){
		alert("제목을 입력하세요");
		$("title").focus()
		return;
	}
	if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
		alert("내용을 입력하세요");
		return;
	}
	<%if(requestMap.getString("guest").length() > 0 || memberInfo.getSessName().equals("")){ %>
	if($F("passwd") == "" || $F("passwd") == " "){
		alert("비밀번호를 입력하세요");
		$("passwd").focus();
		return;
	}
	<%}%>
	<%if(requestMap.getString("qu").equals("insertBbsBoardForm") || requestMap.getString("qu").equals("insertReplyBbsBoard") ){%>
	if(confirm("등록 하시겠습니까?")){
			
	<%} else if(requestMap.getString("qu").equals("modifyBbsBoard")){%>
	if(confirm("수정 하시겠습니까?")){
		
	<%} %>
		$("boardId").value = "QNA";
// 		$("content").value = Editor.getContent(); // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
		$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
		$("mode").value = "requestExec";
		tx_editor_form.action = "/homepage/support.do?mode="+$("mode").value;
		tx_editor_form.submit();
	}
}

//리스트
function go_list(){
	$("mode").value = "requestList";
	tx_editor_form.action = "/homepage/support.do?mode=requestList";
	tx_editor_form.submit();
}

//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){

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
	$("mode").value = "requestList";
	tx_editor_form.action = "/homepage/support.do?mode=requestList";
	tx_editor_form.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	$("mode").value = "requestList";
	tx_editor_form.action = "/homepage/support.do?mode=requestList";
	tx_editor_form.submit();
}

//우편번호 검색
function searchZip(){

	var url = "/search/searchZip.do";
	url += "?mode=form";
	url += "&zipCodeName1=tx_editor_form.homePost1";
	url += "&zipCodeName2=tx_editor_form.homePost2";
	url += "&zipAddr=tx_editor_form.homeAddr";
	pwinpop = popWin(url,"cPop","400","250","yes","yes");

}
//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left4.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual4">참여공간</div>
            <div class="local">
              <h2>묻고답하기</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 참여공간 &gt; <span>묻고답하기</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<form id="tx_editor_form" name="tx_editor_form" method="post" enctype="multipart/form-data">
<input type="hidden" id="mode" name="mode" value="">
<input type="hidden" id="qu" name="qu" value="<%=requestMap.getString("qu")%>">
<!-- 보더아이디 -->
<input type="hidden" id="boardId" name="boardId"  value="<%=requestMap.getString("boardId")%>">
<!-- 메뉴아이디 -->
<input type="hidden" id="menuId" name="menuId" 	value="<%=requestMap.getString("menuId") %>">
<!-- 시퀀스값 -->
<input type="hidden" id="seq" name="seq" 	value="<%=requestMap.getString("seq") %>">
<!-- 현재 사용자 권한 -->
<input type="hidden" id="sessClass"  name="sessClass" 	value="<%=requestMap.getString("sessClass") %>">
<!-- depth값 -->

<input type="hidden" id="depth"  name="depth" 	value="<%=rowMap.getString("depth") %>">
<!-- setp -->
<input type="hidden" id="step" name="step" 	value="<%=rowMap.getString("step") %>">
<!-- 보더네임 -->
<input type="hidden" id="boardName" name="boardName" value="<%=requestMap.getString("boardName") %>">
<!-- 검색어 -->
<input type="hidden" id="selectText" name="selectText" value="<%=requestMap.getString("selectText") %>">
<input type="hidden" id="currPage" name="currPage" value="<%=requestMap.getString("currPage") %>">

<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_HOMEPAGE%>'>
			<div id="contents">
						<div class="h9"></div>
			
						<div class="qnaTxtSet02">
							<h5><img src="/images/<%=skinDir %>/title/tit_qna0101.gif" alt="상담 대상 업무 및 유의 사항" /></h5>
							<ul class="qnaTxt">
								<li><img src="/images/<%=skinDir %>/sub/txt_qna01.gif" alt="인천공역시 인재개발원에서 처리하는 업무
			(교육관련,시설개발관련)" /></li>
								<li><img src="/images/<%=skinDir %>/sub/txt_qna02.gif" alt="무분별한 광고 및 각종 비방성 게시물의 등록을 차단하고 시민들의 의문사항을 보다 정확하게 접수/답변을 해드리기 위해 실명제로 운영되오니 이용에 
			착오없으시기 바랍니다." /></li>
								<li><img src="/images/<%=skinDir %>/sub/txt_qna03.gif" alt="동일한 내용의 제보 또는 문의를 정당한 사유없이 3회이상 반복하여 제출할 경우 종결처리할 수 있습니다." /></li>
							</ul>
							<h5><img src="/images/<%=skinDir %>/title/tit_qna0102.gif" alt="상담 처리 기한" /></h5>
							<ul class="qnaTxt">
								<li><img src="/images/<%=skinDir %>/sub/txt_qna04.gif" alt="일반 문의는 접수 후 7일, 관련 법령 해석이 요구되는 문의는 접수 후 14일 이내에 처리됩니다." /></li>
							</ul>
						</div>
			
						<!-- view -->
						<table class="bView01" oncontextmenu="return false" onselectstart="return false" ondragstart="return false" >	
						<%if(requestMap.getString("guest").length() > 0 || memberInfo.getSessName().equals("")){ %>
						<tr>
							<th class="bl0" width="75">이름</th>
							<td width="200"><input type="text" id="username" name="username" value="<%=requestMap.getString("guest") %>" class="input02 w160" readonly="readonly" /></td>
							<th width="75">비밀번호</th>
							<td width="*"><input type="password" id="passwd" name="passwd" class="input02 w160" value="" /></td>
						</tr>
						<%}else{ %>
						<input type="hidden" id="sessNo" name="sessNo" value="<%=memberInfo.getSessNo() %>">
						<input type="hidden" id="sessName" name="sessName" value="<%=memberInfo.getSessName() %>">
						<%} %>
						<tr>
							<th class="bl0"><img src="/images/<%=skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<td colspan="3">
								<input type="text" id="title" name="title" onkeypress="if(event.keyCode==13){go_save('<%=requestMap.getString("qu") %>');return false;}" value="<%=rowMap.getString("title") %>" class="input02 w489" />
							</td>
						</tr>
						<tr>
							<td class="bl0 edt" colspan="4" oncontextmenu="return false" onselectstart="return false" ondragstart="return false" >	
							
								<%
									String content = "";
									try {
										content = StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"));
									} catch(Exception e) {
									}
								%>
								<jsp:include page="/se2/SE2.jsp" flush="true" >
									<jsp:param name="contents" value="<%=content%>"/>
								</jsp:include>
								
							</td>
						</tr>
						<tr>
							<td class="bl0 edt" colspan="4">
								<%if(requestMap.getString("qu").equals("insertReplyBbsBoard")){ %>
								<!-- 답글 컨텐츠 -->
									<input type="hidden" name="content" id="content" value="<br><br>----------------------------------------------------------<br><%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>">
								<%} else { %>
								<!-- 수정 컨텐츠 -->
									<input type="hidden" name="content" id="content" value="<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>">
								<%} %>
							</td>
						</tr>
						<%-- <tr>
							<td class="bl0 edt" colspan="4">
								<jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>

							</td>
						</tr> --%>	
						
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
</form>
            
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>
    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>