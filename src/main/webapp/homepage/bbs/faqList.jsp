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

	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//FAQ유형 데이터
	DataMap faqListMap = (DataMap)request.getAttribute("FAQLIST_DATA");
	faqListMap.setNullToInitialize(true);	

	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize() > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	//컨텐츠
	StringBuffer html = new StringBuffer();
	
	if(listMap.keySize("fno") > 0 ){
		for(int i=0; listMap.keySize("fno") > i; i++){
			html.append("<tr>");
			html.append("<td class=\"bl0\">"+(pageNum -i)+"</td>");
			html.append("<td>"+listMap.getString("codeName",i)+"</td>");
			html.append("<td class=\"sbj\"><a href=\"javascript:go_view('"+listMap.getString("fno",i)+"');\">"+listMap.getString("question",i)+"</a></td>");
			html.append("<td>"+listMap.getString("visit",i)+"</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("	<td colspan=\"100%\" height=\"300\" align=\"center\"> 등록된 글이 없습니다. </td>");
		html.append("</tr>");
		
	}
	
	//FAQ유형 셀렉박스
	StringBuffer option = new StringBuffer();
	
	if(faqListMap.keySize() > 0){
		for(int i=0; faqListMap.keySize() > i; i++){
			option.append("<option value=\""+faqListMap.getString("minorCode",i)+"\"");
			if(requestMap.getString("selectType").equals(faqListMap.getString("minorCode",i))){
				option.append(" selected");
			}
			option.append(" >"+faqListMap.getString("scodeName",i)+"</option>");
		}
	}
	
%>
<script language="JavaScript" type="text/JavaScript">
<!--


//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

function go_view(fno){
	pform.action = "/homepage/support.do?mode=faqView&fno="+fno;
	pform.submit();
}

//리스트
function go_list(){
	pform.action = "/homepage/support.do?mode=faqList";
	pform.submit();
}

function go_search(){
	$("mode").value="faqList";
	$("qu").value="List";
	pform.action = "/homepage/support.do";
	pform.submit();
}

function go_menu(form){
	$("selectType").value=form;
	$("mode").value="faqList";
	$("qu").value="List";
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
<input type="hidden" name="mode" id = "mode">
<input type="hidden" name="qu" id="qu">
<input type="hidden" name="menuId" 	id="menuId"			value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"	id="currPage"		value='<%=requestMap.getString("currPage")%>'>

<!-- 글넘버 -->
<input type="hidden" name="fno" id="fno">
<!-- faq사용여부 -->
<input type="hidden" name="useYn" id="useYn">
				<div id="content">
						<!-- search -->
						<div class="search01">
							<span class="shHd">
								<img src="/images/<%= skinDir %>/sub/txt_faqSrch.gif" class="mr7" alt="FAQ검색" /><img src="/images/<%= skinDir %>/sub/txt_spd.gif" alt="정확하고 빠른검색으로 
				시간을 절약하세요" />
							</span>
							<span class="shHd01"><img src="/images/<%= skinDir %>/sub/txt_dvde.gif" alt="분류" />
							<select style="width:95px;" name="selectType" id = "selectType" title="질문선택">
								<option value="">==질문유형==</option>
								<%=option %>
							</select>
							<img src="/images/<%= skinDir %>/sub/txt_schWd.gif" alt="검색어" />
							<input onkeypress="if(event.keyCode==13){go_search();return false;}" type="text" name="question" value="<%=requestMap.getString("question") %>" class="input01 w124" title="입력">
							<a href="javascript:go_search();"><img src="/images/<%= skinDir %>/button/btn_search01.gif" class="sch01" alt="검색" /></a></span>
						</div>
						<!-- //search -->
			
						<!-- 탭 -->
						<ol class="TabSub">
            				<li <%if(requestMap.getString("selectType").equals("")){%>class="TabOn"<%} %> ><a href="javascript:go_menu('');">전체</a></li>
            				<li <%if(requestMap.getString("selectType").equals("01")){%>class="TabOn"<%} %> ><a href="javascript:go_menu('01');">회원관련</a></li>
            				<li <%if(requestMap.getString("selectType").equals("02")){%>class="TabOn"<%} %> ><a href="javascript:go_menu('02');">수강신청관련</a></li>
            				<li <%if(requestMap.getString("selectType").equals("03")){%>class="TabOn"<%} %> ><a href="javascript:go_menu('03');">학습관련</a></li>
            				<li <%if(requestMap.getString("selectType").equals("04")){%>class="TabOn"<%} %> ><a href="javascript:go_menu('04');">홈페이지이용</a></li>
            				<li <%if(requestMap.getString("selectType").equals("05")){%>class="TabOn"<%} %> ><a href="javascript:go_menu('05');">장애관련</a></li>
            				<li <%if(requestMap.getString("selectType").equals("06")){%>class="TabOn"<%} %> ><a href="javascript:go_menu('06');">과제/시험관련</a></li>
            				<li class=" <%if(requestMap.getString("selectType").equals("07")){%>TabOn<%} %>  last"><a href="javascript:go_menu('07');">기타문의</a></li>
          				</ol>
						<!-- //탭 -->
			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="121" />
							<col width="*" />
							<col width="104" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>
							<th>제목</th>
							<th>분류</th>
							<th>조회수</th>
						</tr>
						</thead>
			
						<tbody>
							<%=html.toString() %>
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>              
			
						<!--[s] 페이징 -->
						<div class="paging">
							<%=pageStr %>		
						</div>
						<!--//[s] 페이징 -->
						<div class="BtmLine01"></div>
					</div>
					</form>
					<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100021" /></jsp:include>
					<div class="h80"></div>		
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>