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

	//FAQ ROW데이터
	DataMap rowMap = (DataMap)request.getAttribute("FAQROW_DATA");
	rowMap.setNullToInitialize(true);
	
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
	pform.action = "/homepage/support.do?mode=faqList";
	pform.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	$("mode").value = "educationDataList";
	pform.action = "/homepage/support.do";
	pform.submit();
}
//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left5.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual5.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>자주하는질문</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육지원 &gt; <span>자주하는질문</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
<div id="content">
						<!-- data -->
						<table class="dataW02">
							<tr>
								<th width="70" class="bl0"><img src='/images/<%=skinDir %>/table/th_div.gif' alt="분류"></th>
								<td width="140"><%=rowMap.getString("codeName") %></td>
								<th width="100"><img src='/images/<%=skinDir %>/table/th_date.gif' alt="작성일"></th>
								<td width="120"><%=rowMap.getString("regdate") %></td>
								<th width="100"><img src='/images/<%=skinDir %>/table/th_hit.gif' alt="조회수"></th>
								<td width="94"><%=rowMap.getString("visit") %></td>
							</tr>
							<tr>
								<th class="bl0"><img src='/images/<%=skinDir %>/table/th_sbj.gif' alt="제목"></th>
								<td class="" colspan="5"><%=rowMap.getString("question") %></td>
							</tr>
							<tr>
								<td class="cont" colspan="6">
								<%=StringReplace.convertHtmlDecode(rowMap.getString("htmlContents"))%>
								</td>
							</tr>
						</table>
						<!-- //data -->
			
						<!-- button -->
						<div class="btnRbtt01">
							<a href="javascript:fnList();"><img src="/images/<%=skinDir %>/button/btn_list.gif" alt="목록으로" /></a>
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