<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%


// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);


// 페이징 필수
FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");


StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";

if(listMap.keySize("seq") > 0){		
	for(int i=0; i < listMap.keySize("seq"); i++){
		
		String sample = "";
		if(listMap.getString("seq",i).equals("0")){
			sample = "<font color='red'>샘플</font>";
		}else{
			sample = listMap.getString("seq",i);
		}
		
		sbListHtml.append("<tr>");
		sbListHtml.append("	<td class=\"bl0\">"+sample+"</td>");
		int l = Util.getIntValue(listMap.getString("depth",i),0);
		
		sbListHtml.append("	<td class=\"sbj\">");
		
		for (int z=0;z < l ; z ++){
			sbListHtml.append("&nbsp;&nbsp;");
		}
		if ( l > 0){
			sbListHtml.append("<img alt='re' src=\"/images/"+ skinDir +"/icon/icon_re.gif\">");
		}
		sbListHtml.append(" <a href=\"javascript:onView('"+listMap.getString("seq",i)+"');\">"+StringReplace.subStringPoint(listMap.getString("title",i),23)+"</a></td>");		
		sbListHtml.append("	<td>"+listMap.getString("regdate",i)+"</td>");
		sbListHtml.append("	<td>"+listMap.getString("username",i)+"</td>");				
		sbListHtml.append("	<td>"+listMap.getString("visit",i)+"</td>");
		sbListHtml.append("	<td>");
		if (Util.getIntValue(listMap.getString("groupfileNo",i), 0) > 0){
			sbListHtml.append("<!-- a href=\"javascript:fileDownloadPopup("+listMap.getString("groupfileNo",i)+");\" --><img src=\"/images/"+ skinDir+"/icon/icon_fileDwn.gif\" alt=\"한글file 첨부\" /><!-- /a -->");
		}
		sbListHtml.append(" </td>");
		sbListHtml.append("</tr>");

	}
	
	pageStr = pageNavi.FrontPageStr();				
}else{
	// 리스트가 없을때
	sbListHtml.append("<tr>");
	sbListHtml.append("	<td class=\"bl0\" colspan='6'>등록된 후기가 없습니다.</td>");
	sbListHtml.append("</tr>");
}
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
	pform.action = "/homepage/support.do?mode=epilogueList";
	pform.submit();
}
// 검색
function goSearch(){
	$("currPage").value = "1";
	$("mode").value = "epilogueList";
	pform.action = "/homepage/support.do";
	pform.submit();
}
//상세보기
function onView(form){
	// $("mode").value = "noticeView";
	$("qu").value = "selectBbsBoardview";
	$("boardId").value = "EPILOGUE";
	pform.action = "/homepage/support.do?mode=epilogueView&seq="+form;
	pform.submit();
}
//글쓰기
function goWrite(){
	$("qu").value = "insertBbsBoardForm";
	$("boardId").value = "EPILOGUE";
	pform.action = "/homepage/support.do?mode=epilogueWrite";
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
              <h2>수강후기</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 참여공간 &gt; <span>수강후기</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->

			<form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" id="qu" name="qu">
<input type="hidden" id="boardId" name="boardId">

<!-- 페이징용 -->
<input type="hidden" id="currPage" name="currPage"	value="<%= requestMap.getString("currPage")%>">
						<div id="content">
						<div class="h9"></div>
			
						
			<div class="point_box">
<!-- 				<p class="box_img"><span><img src="/homepage_new/images/common/box_point.gif" alt=""></span></p> -->
				<div class="list">
					수강후기 게시판입니다.
				</div>
			</div>
			<div class="h9"></div>
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="83" />
							<col width="77" />
							<col width="59" />
							<col width="71" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>				
							<th>제목</th>
							<th>작성일</th>
							<th>작성자</th>
							<th>조회</th>
							<th>첨부</th>
						</tr>
						</thead>
							<%= sbListHtml.toString() %>
						<tbody>
						
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>  
						
						<!-- button -->
						<div class="btnRbtt">			
							<a href="javascript:goWrite();"><img src="/images/<%= skinDir %>/button/btn_write01.gif" alt="글쓰기" /></a>
						</div>
			
						<!--[s] 페이징 -->
						<div class="paging">
							<%= pageStr %>		
						</div>
						<!--//[s] 페이징 -->

					</div>

</form>
					<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100014" /></jsp:include>
					<div class="h80"></div>            
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>