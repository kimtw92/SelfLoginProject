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

// out.println(listMap.keySize("photoNo"));
// 페이징 필수
FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");


StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";

if(listMap.keySize("photoNo") > 0){
	for(int i=0; listMap.keySize("photoNo") > i; i++){
		////sbListHtml.append("<div class=\"photo\"><a href=javascript:popWin(\"/homepage/index.do?mode=showpicture&path="+listMap.getString("imgPath",i)+"\",\"aaa\",\"900\",\"750\",\"yes\",\"yes\") ><img src=\"/pds"+listMap.getString("imgPath", i)+"\" style=\"width:86px;height:63px;\" /></a></div>");
		sbListHtml.append("<div class=\"photo\" ><a href=javascript:popWin(\"/homepage/index.do?mode=showpicture2&photoNo="+listMap.getString("photoNo",i)+"\",\"aaa\",\"900\",\"750\",\"yes\",\"yes\") ><img src=\"/pds"+listMap.getString("imgPath", i)+"\" style=\"width:86px;height:63px;\" alt='"+listMap.getString("wcomments", i)+"' title='"+listMap.getString("wcomments", i)+"'/><br /><br />"+StringReplace.subStringPoint(listMap.getString("wcomments", i), 10)+"</a></div>");
		//photoListHtml.append("<dd><a href=javascript:popWin(\"/homepage/index.do?mode=showpicture&path="+photoListMap.getString("imgPath",i)+"\",\"aaa\",\"900\",\"750\",\"yes\",\"yes\") ><img width=\"57\" height=\"52\" src=\"/pds"+photoListMap.getString("imgPath",i)+"\"/></a></dd>");
		if (i % 3 == 3){
			sbListHtml.append("<div class=\"h15\"></div>");
		}
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
	pform.action = "/homepage/support.do?mode=webzine";
	pform.submit();
}

function go_pop(imgPath, photoNo){

	$("imgPath").value = imgPath;
	$("mode").value = "preview";
	$("photoNo").value = photoNo;
	$("qu").value ="preView";	
	pform.action = "/homepage/support.do";
	var popWindow = popWin('about:blank', 'majorPop11', '900', '750', 'yes', 'yes');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
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
              <h2>포토갤러리</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 참여공간 &gt; <span>포토갤러리</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            <form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" id="imgPath" name="imgPath">
<input type="hidden" id="mode" name="mode">
<input type="hidden" id="photoNo" name="photoNo">
<input type="hidden" id="qu" name="qu">
<input type="hidden" id="boardId" name="boardId">

<!-- 페이징용 -->
<input type="hidden" id="currPage" name="currPage"	value="<%= requestMap.getString("currPage")%>">
					<div id="content">
						<div class="photoGell">				
							<div class="h5"></div>
			
							<!-- data -->
							<%=sbListHtml.toString()%>
							<!-- //data -->
							<div class="h15"></div>
			
							<!--[s] 페이징 -->
							<div class="paging_pt">
								<%=pageStr.toString() %>	
							</div>
							<!--//[e] 페이징 -->
						</div>
			
					</div>
			</form>
			<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100015" /></jsp:include>
			<div class="h80"></div>
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>