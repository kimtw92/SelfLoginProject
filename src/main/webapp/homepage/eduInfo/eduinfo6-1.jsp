<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>

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

	
	if(listMap.keySize("ebookTitle") > 0){		
		for(int i=0; i < listMap.keySize("ebookTitle"); i++){
			
			sbListHtml.append("<div class=\"ebook\">");
			sbListHtml.append("	<dl>");
			sbListHtml.append("		<dt><a href=\"" + listMap.getString("ebookLink", i) + "\" target=\"_blank\">" + listMap.getString("ebookTitle", i) + "</a></dt>");
			sbListHtml.append("		<dd alt='page' class=\"img\"><a href=\"" + listMap.getString("ebookLink", i) + "\" target=\"_blank\"><img src=\"/" + Constants.UPLOAD + listMap.getString("imgPath", i) + "\" onerror=\"this.src='/images/logo_flyincheon.gif';\"  style=\"width:92px;height:109px;\" alt='log'/></a></dd>");
			sbListHtml.append("		<dd class=\"list\">");
			sbListHtml.append("			<ul>");
			sbListHtml.append("				<li>컨텐츠 분류 : " + listMap.getString("ebookAuth", i) + "</li>");
			sbListHtml.append("				<li>제작 일시 : " + listMap.getString("regDate", i) + "</li>");
			sbListHtml.append("				<li>총 페이지수 : " + Util.moneyFormValue(listMap.getString("ebookPage", i)) + " page</li>");
			sbListHtml.append("			</ul>");
			sbListHtml.append("		</dd>");
			sbListHtml.append("	</dl>");
			sbListHtml.append("</div>");

			if(listMap.getString("rowIndex", i).equals("0")){
				sbListHtml.append("<div class=\"h28\"></div>");
			}						
		}
		
		pageStr = pageNavi.FrontPageStr();
		
	}else{
		// 리스트가 없을때		
		sbListHtml.append("<table width=\"100%\">");
		sbListHtml.append("	<tr><td align=\"center\" height=\"100\"><b>등록된 Ebook 이 없습니다.</b></td></tr>");
		sbListHtml.append("</table>");
	}


%>

<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>


<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	document.getElementById("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	document.getElementById("mode").value = "<%= requestMap.getString("mode") %>";
	pform.action = "/homepage/ebook.do";
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
              <h2> E-book</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 참여공간 &gt; <span>E-book</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<form id="pform" name="pform" method="post">

<!-- 필수 -->
<input type="hidden" name="mode"	id="mode"	value="<%= requestMap.getString("mode") %>">

<!-- 페이징용 -->
<input type="hidden" name="currPage" id="currPage"	value="<%= requestMap.getString("currPage")%>">
<div id="content">					
						<%= sbListHtml.toString() %>						
					</div>
					
					<!--[s] 페이징 -->
					<div class="paging">
						<%= pageStr %>
					</div>
					<!--//[s] 페이징 -->
					<div class="space"></div>
</form>
            <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100016" /></jsp:include>
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>