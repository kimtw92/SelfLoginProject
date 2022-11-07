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

System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
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
		
		sbListHtml.append("<tr>");
		sbListHtml.append("	<td class=\"bl0\">"+listMap.getString("seq",i)+"</td>");
		sbListHtml.append("	<td class=\"sbj\">");
		sbListHtml.append(" <a href=\"javascript:onView('"+listMap.getString("seq",i)+"');\">"+StringReplace.subStringPoint(listMap.getString("title",i),23)+"</a></td>");		
		sbListHtml.append("	<td>"+listMap.getString("regdate",i)+"</td>");
		sbListHtml.append("	<td>"+listMap.getString("username",i)+"</td>");				
		sbListHtml.append("</tr>");

	}
	
	pageStr = pageNavi.FrontPageStr();				
}else{
	// 리스트가 없을때
	sbListHtml.append("<tr>");
	sbListHtml.append("	<td class=\"bl0\" colspan='4'>등록된 글이 없습니다.</td>");
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
	pform.action = "/homepage/support.do?mode=peersonList";
	pform.submit();
}
// 검색
function goSearch(){
	$("currPage").value = "1";
	$("mode").value = "peersonList";
	pform.action = "/homepage/support.do";
	pform.submit();
}
//상세보기
function onView(form){
	// $("mode").value = "noticeView";
	$("qu").value = "selectBbsview";
	pform.action = "/homepage/support.do?mode=personView&seq="+form;
	pform.submit();
}
//글쓰기
function goWrite(){
	$("qu").value = "insertBbs";
	pform.action = "/homepage/support.do?mode=personForm";
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
<input type="hidden" id="qu" name="qu">
<input type="hidden" id="boardId" name="boardId">

<!-- 페이징용 -->
<input type="hidden" id="currPage" name="currPage"	value="<%= requestMap.getString("currPage")%>">
						<div id="content">
						<div class="h9"></div>
			
						
			<div class="point_box">
				<p class="box_img"><span><img src="/homepage_new/images/common/box_point.gif" alt=""></span></p>
				<div class="list">
					인천광역시인재개발원 종합감사와 관련하여 시민의 입장에서 바라는 감사의 방향 및 건의사항과 위법·부당하게 업무를 처리하거나 금품·향응을 요구하는 공무원 또는 칭찬하고 싶은 공무원이 있으시면 제보하여 주시기 바랍니다.
					<br/><br/>아울러, 적극행정 과정에서 발생한 절차상 하자 등에 대한 불이익 처분은 면책코자 하오니 해당 사항이 있는 경우 신청·상담하여 주시기 바랍니다.
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
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>				
							<th>제목</th>
							<th>작성일</th>
							<th>작성자</th>
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