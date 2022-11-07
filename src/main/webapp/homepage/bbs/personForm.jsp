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

	DataMap rowMap = (DataMap)request.getAttribute("BOARDVIEW_DATA");
	rowMap.setNullToInitialize(true);
	
%>

<script language="JavaScript" type="text/JavaScript">
	function go_save(qu){
// 	$("content").value = Editor.getContent(); //나모 폼 체크를하기 위해 값을 가져온다.
	var contents = getContents(); // naver 에디터에서 컨텐츠를 가지고 온다.
	
	var keywordCheck = false;
	keywordCheck = SearchKeyword();
	if(!keywordCheck) { 
		return;
	}
	
	if($("username").value == ""){
		alert("성명을 입력하세요.");
		tx_editor_form.username.focus();
		return ;
	}
	
	if($("phone").value == ""){
		alert("휴대전화를 입력하세요.");
		tx_editor_form.phone.focus();
		return ;
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
	
	<%if(requestMap.getString("qu").equals("insertBbs") ){%>
	if(confirm("등록 하시겠습니까?")){
			
	<%} else if(requestMap.getString("qu").equals("modifyBbs")){%>
	if(confirm("수정 하시겠습니까?")){
		
	<%} %>
// 		$("boardId").value = "PERSON";
// 		$("qu").value = "insertBbs";
		$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
		$("mode").value = "personExec";
		tx_editor_form.action = "/homepage/support.do?mode="+$("mode").value;
		tx_editor_form.submit();
	}
}

//리스트
function go_list(){
	
	if($("username").value == "" && $("phone").value == ""){
		alert("자신이 쓴 글을 보기 위해서는 글 쓴 당시의 성명과 휴대전화를 입력하셔야 합니다.");
	}
	
	if($("username").value == ""){
		alert("성명을 입력하세요.");
		tx_editor_form.username.focus();
		return ;
	}
	
	if($("phone").value == ""){
		alert("휴대전화를 입력하세요.");
		tx_editor_form.phone.focus();
		return ;
	}
	
	$("mode").value = "personList";
	tx_editor_form.action = "/homepage/support.do?mode=personList";
	tx_editor_form.submit();
}

//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){

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
              <h2>감사반장에 바란다</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 참여공간 &gt; <span>감사반장에 바란다</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<form id="tx_editor_form" name="tx_editor_form" method="post">
				<input type="hidden" id="mode" name="mode" value="">
				<!-- 시퀀스값 -->
				<input type="hidden" id="seq" name="seq" 	value="<%=requestMap.getString("seq") %>">
				<input type="hidden" id="qu" name="qu" 	value="<%=requestMap.getString("qu")%>">
				<input type="hidden" id="currPage" name="currPage" value="<%=requestMap.getString("currPage") %>">
			<div id="contents">
						<div class="h9"></div>
			
						<div class="qnaTxtSet02" style="padding:40px 0 0 96px;">
						<br/>
							<h5> 
								인천광역시인재개발원 종합감사와 관련하여 시민의 입장에서 바라는 감사의 방향 및 건의사항과 위법·부당하게 업무를 처리하거나 금품·향응을 요구하는 공무원 또는 칭찬하고 싶은 공무원이 있으시면 제보하여 주시기 바랍니다.
								<br/><br/>아울러, 적극행정 과정에서 발생한 절차상 하자 등에 대한 불이익 처분은 면책코자 하오니 해당 사항이 있는 경우 신청·상담하여 주시기 바랍니다.
							</h5>
						</div>
			
						<!-- view -->
						<table class="bView01">
						<tr>
							<th class="bl0" width="75">성명</th>
							<td width="200"><input type="text" id="username" name="username" value="<%=rowMap.getString("username") %>" class="input02 w160" /></td>
							<th width="75">휴대전화</th>
							<td width="*"><input type="text" id="phone" name="phone" class="input02 w160" value="<%=rowMap.getString("phone") %>" />&nbsp;<b>( - 없이 입력하세요.)</b></td>
						</tr>
						<tr>
							<th class="bl0"><img src="/images/<%=skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<td colspan="3">
								<input type="text" id="title" name="title" onkeypress="if(event.keyCode==13){go_save('<%=requestMap.getString("qu")%>');return false;}" value="<%=rowMap.getString("title") %>" class="input02 w489" />
							</td>
						</tr>
						<tr>
							<td class="bl0 edt" colspan="4">
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
								<input type="hidden" name="content" id="content" value="">
							</td>
						</tr>
						</table>	
						<!-- //view -->
			
						<!-- button -->
						<div class="btnRbtt">
							<a href="javascript:go_save('<%=requestMap.getString("qu")%>');"><img src="/images/<%=skinDir %>/button/btn_save01.gif" alt="저장" /></a>
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