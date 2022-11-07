<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%

//필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);
String isSync = (String)request.getAttribute("USERIDSYNC");

// 보드 뷰 
DataMap viewMap = (DataMap)request.getAttribute("BOARDVIEW_DATA");
requestMap.setNullToInitialize(true);

StringBuffer innerHtml = new StringBuffer();

if (viewMap.getInt("groupfileNo") > 0){
	
	DataMap fileGroup = (DataMap)viewMap.get("FILE_GROUP_LIST");
	
	if (fileGroup.keySize("groupfileNo") > 0){
		
		for(int i=0,l=fileGroup.keySize("groupfileNo");i<l;i++){
			
			String fileName =  fileGroup.getString("fileName",i); 
			String extName = fileName.substring(fileName.indexOf(".")+1,fileName.length());
			
			if (!extName.equals("hwp") && !extName.equals("jpg")){
				extName = "fileDwn";
			}
			// 권한없음으로 나와서 임시로 처리함
			if (extName.equals("hwp")){
				extName = "han";
			}
						
			innerHtml.append("<a href=\"javascript:fileDownload('"+fileGroup.getInt("groupfileNo",i)+"', '"+fileGroup.getString("fileNo",i)+"');\">");
			innerHtml.append("<img src=\"/images/"+ skinDir +"/icon/icon_"+extName+".gif\" /><span class=\"vp2\">"+fileGroup.getString("fileName", i)+"</span>");
			innerHtml.append("</a>&nbsp;");
			//if ( i != 0 && i%4 == 0){
			//	innerHtml.append("<br />");
			//}
		}
	}
	
}

%>

<script language="JavaScript" type="text/JavaScript">
<!--
<%
	String boardId = (String)request.getAttribute("boardId");
	String s_userno = requestMap.getString("userno");
	String isAdminYn = requestMap.getString("isAdminYn");

	if("QNA".equals(boardId)) { 
%>
	window.onload = ischeck() ;
	
	function ischeck() {
	
		var isAdminYn = '<%=isAdminYn%>';
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

	/* if(s_userno == "null" || s_userno == null || s_userno == "") {
		alert("로그인후 이용 가능합니다.");
		history.back(-1);
		return;
	}
	
	if ( isSynck  ) {
		alert('작성자만 볼 수 있습니다.');
		history.back(-1);
		return;
	}
	
	if(s_userno != topuserno) {
		if(isAdminYn != "Y") {
			alert("." + isAdminYn+"작성자만 볼수 있습니다.");
			history.back(-1);
			return;
		}
	} */
<% } %>

function setReWrite(){
	$("qu").value = "insertReplyBbsBoard";
	$("boardId").value = "BBS";
	pform.action = "/homepage/support.do?mode=freeBoardReWrite";
	pform.submit();
}

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){

	pform.action = "/homepage/support.do?mode=requestList";
	pform.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	pform.action = "/homepage/support.do?mode=requestList";
	pform.submit();
}

function setDelete(){
	if($F("passwd") == "" || $F("passwd") == " ") {
		alert("비밀번호를 입력하세요");
		$("passwd").focus();
		return;
	}
	if(confirm("삭제 하시겠습니까?")) {
		$("qu").value = "deleteBbsBoard";
		$("boardId").value = "QNA";
		pform.action = "/homepage/support.do?mode=requestExec";
		pform.submit();
	}
}

function setModify(){
	$("qu").value = "modifyBbsBoard";
	$("boardId").value = "QNA";
	pform.action = "/homepage/support.do?mode=requestModify";
	pform.submit();
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
			<form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" id="seq" name="seq"		value="<%= requestMap.getString("seq") %>">
<input type="hidden" id="qu" name="qu">
<input type="hidden" id="boardId" name="boardId">
					<div id="content">
						<div class="h9"></div>
			
						<div class="qnaTxtSet02">
							<h5><img src="/images/<%= skinDir %>/title/tit_qna0101.gif" alt="상담 대상 업무 및 유의 사항" /></h5>
							<ul class="qnaTxt">
								<li><img src="/images/<%= skinDir %>/sub/txt_qna01.gif" alt="인천공역시 인재개발원에서 처리하는 업무
			(교육관련,시설개발관련)" /></li>
								<li><img src="/images/<%= skinDir %>/sub/txt_qna02.gif" alt="무분별한 광고 및 각종 비방성 게시물의 등록을 차단하고 시민들의 의문사항을 보다 정확하게 접수/답변을 해드리기 위해 실명제로 운영되오니 이용에 
			착오없으시기 바랍니다." /></li>
								<li><img src="/images/<%= skinDir %>/sub/txt_qna03.gif" alt="동일한 내용의 제보 또는 문의를 정당한 사유없이 3회이상 반복하여 제출할 경우 종결처리할 수 있습니다." /></li>
							</ul>
							<h5><img src="/images/<%= skinDir %>/title/tit_qna0102.gif" alt="상담 처리 기한" /></h5>
							<ul class="qnaTxt">
								<li><img src="/images/<%= skinDir %>/sub/txt_qna04.gif" alt="일반 문의는 접수 후 7일, 관련 법령 해석이 요구되는 문의는 접수 후 14일 이내에 처리됩니다." /></li>
							</ul>
						</div>
			
						<!-- view -->
						<table class="bView01" oncontextmenu="return false" onselectstart="return false" ondragstart="return false" >	
						<tr>
							<th class="bl0" width="75"><img src="/images/<%= skinDir %>/table/th_wName01.gif" alt="작성자" /></th>
							<td width="320"><%=viewMap.getString("username", 0) %></td>
							<th width="75"><img src="/images/<%= skinDir %>/table/th_date.gif" alt="작성일" /></th>
							<td width="100"><%=viewMap.getString("regdate", 0) %></td>
						</tr>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<td colspan="3">
								<%=viewMap.getString("title", 0) %>
							</td>
						</tr>
						<!-- tr>
							<th class="bl0">패스워드</th>
							<td colspan="3">
								<input type="password" id="passwd" name="passwd" class="input02 w160" value="" />
							</td>
						</tr -->
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_addfile01.gif" alt="첨부파일" /></th>
							<td colspan="3">
								<%=innerHtml.toString() %>
							</td>
						</tr>
						
						<tr>
							<td class="bl0 cont" colspan="4">
							<%=StringReplace.convertHtmlDecodeNamo(viewMap.getString("content", 0))%>
							</td>
						</tr>
						</table>	
						<!-- //view -->
			
						<!-- button -->
						<div class="btnRbtt">
							<%if(requestMap.getString("userno").equals("A000000000000")){%>
							<a href="javascript:setReWrite();"><img src="/images/<%= skinDir %>/button/btn_answer.gif" alt="답글"/></a>
							<%}%>
							<a href="javascript:setModify();"><img src="/images/<%= skinDir %>/button/btn_revision.gif" alt="수정" /></a>
							<a href="javascript:setDelete();"><img src="/images/<%= skinDir %>/button/btn_delete02.gif" alt="삭제" /></a>
							<a href="javascript:fnList();"><img src="/images/<%= skinDir %>/button/btn_list02.gif" alt="리스트" /></a>	
						</div>
						<!-- //button -->
						<div class="h80"></div>
					</div>

</form>
            
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>