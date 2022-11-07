<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<%

	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("OPEN_COURSE_LIST");
	listMap.setNullToInitialize(true);
	
	
	// 페이징 필수
	FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	
	StringBuffer sbListHtml = new StringBuffer();
	
	String pageStr = "";
	
	int number = 1;
	
	if(listMap.keySize("subj") > 0){		

		for(int i=0; i < listMap.keySize("subj"); i++){
			
			sbListHtml.append("<tr>  ");
			sbListHtml.append("<td class=\"bl0\">"+((number++)+((requestMap.getInt("currPage")-1)*requestMap.getInt("rowSize")))+"</td> ");
			sbListHtml.append("<td class=\"sbj\"><a href=\"javascript:goView('"+listMap.getString("subj", i)+"','"+listMap.getString("subjnm", i)+"');\">"+listMap.getString("subjnm", i)+"</a></td> ");
			sbListHtml.append("<td><a href=\"javascript:goView('"+listMap.getString("subj", i)+"','"+listMap.getString("subjnm", i)+"');\"><img src=\"/images/"+skinDir+"/button/btn_listview.gif\" alt=\"목록보기\" /></a></td> ");
			sbListHtml.append("</tr> ");
			
		}
		
		pageStr = pageNavi.FrontPageStr();				
	}else{
		// 리스트가 없을때
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
	$("mode").value = "opencourse";
	pform.action = "/homepage/support.do";
	pform.submit();
}


//-->

function goView(subj, subjnm) {
	var encodesubjnm = encodeURIComponent(subjnm); 
	url = "/homepage/support.do?mode=opencourseview&subj="+subj+"&subjnm="+encodesubjnm;
	location.href=url;
}

</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left2.jsp" flush="true" ></jsp:include>
    
      </div>
    	<form id="pform" name="pform" method="post">
        <div id="contnets_area">
          <div class="sub_visual2">교육과정</div>
            <div class="local">
              <h2>공개강의</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육과정 &gt; <span>공개강의</span></div>
            </div>
            <div class="contnets">
            <div class="bttSearch02">
			                   과목명 검색 : 
							<input type="text" value="<%=requestMap.getString("search") %>" id="search" name="search" class="input01 w160" style="" />
							<a href="javascript:fnList()"><img src="/images/<%=skinDir %>/button/btn_search01.gif" class="sch01" alt="검색" border="0" /></a>	
						</div>
						<div class="space"></div>
            <!-- contnet -->
		

<!-- 필수 -->
<input type="hidden" id="mode" name="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 페이징용 -->
<input type="hidden" id="currPage" name="currPage"	value="<%= requestMap.getString("currPage")%>">
						<div id="content">
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="90" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>
							<th>과목명</th>
							<th>강의목록</th>
						</tr>
						</thead>
			
						<tbody>
						<%=sbListHtml %>
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>              
			
						<!--[s] 페이징 -->
						<div class="paging">
							<%= pageStr %>	
						</div>
						<!--//[s] 페이징 -->
						<div class="BtmLine01"></div>
					
					</div>
				</form>
				<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100012" /></jsp:include>
				<div class="h80"></div>
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>