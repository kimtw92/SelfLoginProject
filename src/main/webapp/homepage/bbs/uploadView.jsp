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

	if("UPLOAD".equals(boardId)) { 
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

	pform.action = "/homepage/support.do?mode=uploadbbsList";
	pform.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	pform.action = "/homepage/support.do?mode=uploadbbsList";
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
		$("boardId").value = "UPLOAD";
		pform.action = "/homepage/support.do?mode=uploadExec";
		pform.submit();
	}
}

function setModify(){
	$("qu").value = "modifyBbsBoard";
	$("boardId").value = "UPLOAD";
	pform.action = "/homepage/support.do?mode=uploadModify";
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
              <h2>신임인재평가</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 참여공간 &gt; <span>신임인재평가</span></div>
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
			
			<div class="point_box">
				<p class="box_img"><span><img src="/homepage_new/images/common/box_point.gif" alt=""></span></p>
				<div class="list">
					이곳은 인천광역시인재개발원의 <strong>신임인재양성과정 과제평가 제출을 위한 게시판</strong>입니다. 기타 문의사항은 아래 담당자에게 연락하시기 바랍니다. <br /> <br />
					신임인재양성과정 <strong>평가담당자</strong>(인재기획과) : <strong>440-7652</strong><br />
					신임인재양성과정 <strong>교육담당자</strong>(인재양성과) : <strong>440-7673</strong><br /><br />
					※ 본 게시판의 운영목적과 상이한 내용(타인비방, 욕설, 광고, 본 게시판의 취지와 전혀 무관한 내용 등)은 사전동의 없이 삭제될 수 있습니다.<br />
				</div>
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
							<a href="javascript:setModify();"><img src="/images/<%= skinDir %>/button/btn_revision.gif" alt="리스트" /></a>
							<!-- a href="javascript:setDelete();"><img src="/images/<%= skinDir %>/button/btn_delete02.gif" alt="삭제" /></a -->
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