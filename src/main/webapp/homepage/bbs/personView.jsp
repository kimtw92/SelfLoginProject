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

// 보드 뷰 
DataMap viewMap = (DataMap)request.getAttribute("BOARDVIEW_DATA");
requestMap.setNullToInitialize(true);

StringBuffer innerHtml = new StringBuffer();


%>

<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){

	pform.action = "/homepage/support.do?mode=personList";
	pform.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	pform.action = "/homepage/support.do?mode=personList";
	pform.submit();
}

function setDelete(){
	
	if(confirm("삭제 하시겠습니까?")) {
		$("qu").value = "deleteBbs";
		pform.action = "/homepage/support.do?mode=personExec";
		pform.submit();
	}
}

function setModify(){
	$("qu").value = "modifyBbs";
	pform.action = "/homepage/support.do?mode=personModify";
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
              <h2>감사반장에 바란다</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 참여공간 &gt; <span>감사반장에 바란다</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<form id="pform" name="pform" method="post">
<!-- 필수 -->
			<input type="hidden" id="seq" name="seq"		value="<%= requestMap.getString("seq") %>">
			<input type="hidden" id="qu" name="qu">
			<input type="hidden" id="username" name="username" value="<%=viewMap.getString("username", 0) %>">
			<input type="hidden" id="phone" name="phone" value="<%=viewMap.getString("phone", 0) %>">
					<div id="content">
						<div class="h9"></div>
			
						<div class="qnaTxtSet02" style="padding:40px 0 0 96px;">
							<div class="list">
								인천광역시인재개발원 종합감사와 관련하여 시민의 입장에서 바라는 감사의 방향 및 건의사항과 위법·부당하게 업무를 처리하거나 금품·향응을 요구하는 공무원 또는 칭찬하고 싶은 공무원이 있으시면 제보하여 주시기 바랍니다.
								<br/><br/>아울러, 적극행정 과정에서 발생한 절차상 하자 등에 대한 불이익 처분은 면책코자 하오니 해당 사항이 있는 경우 신청·상담하여 주시기 바랍니다.
							</div>
						</div>
			
						<!-- view -->
						<table class="bView01">	
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
							<td class="bl0 cont" colspan="4">
							<%=StringReplace.convertHtmlDecodeNamo(viewMap.getString("content", 0))%>
							</td>
						</tr>
						</table>	
						<!-- //view -->
			
						<!-- button -->
						<div class="btnRbtt">
							<a href="javascript:setModify();"><img src="/images/<%= skinDir %>/button/btn_revision.gif" alt="리스트" /></a>
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