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

LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");

StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";

if(listMap.keySize("seq") > 0){		
	for(int i=0; i < listMap.keySize("seq"); i++){
		
		sbListHtml.append("<tr>");
		sbListHtml.append("	<td class=\"bl0\">"+listMap.getString("seq",i)+"</td>");
		int l = Util.getIntValue(listMap.getString("depth",i),0);
		
		sbListHtml.append("	<td class=\"sbj\">");
		
		for (int z=0;z < l ; z ++){
			sbListHtml.append("&nbsp;&nbsp;");
		}
		if ( l > 0){
			sbListHtml.append("<img src=\"/images/"+ skinDir +"/icon/icon_re.gif\">");
		}
		sbListHtml.append(" <a href=\"javascript:onView('"+listMap.getString("seq",i)+"');\">"+listMap.getString("title",i)+"</a></td>");		
		sbListHtml.append("	<td>");
		if (Util.getIntValue(listMap.getString("groupfileNo",i), 0) > 0){
			sbListHtml.append("<a href=\"javascript:isfileDownloadPopup("+listMap.getString("groupfileNo",i)+");\"><img src=\"/images/"+ skinDir+"/icon/icon_fileDwn.gif\" alt=\"한글file 첨부\" /></a>");
		}
		sbListHtml.append(" </td>");
		sbListHtml.append("</tr>");

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
	$("mode").value = "lawsList";
	pform.action = "/homepage/introduce.do";
	pform.submit();
}
// 검색
function goSearch(){
	$("currPage").value = "1";
	$("mode").value = "lawsList";
	pform.action = "/homepage/support.do";
	pform.submit();
}
//상세보기
function onView(form){

if(<%=loginInfo.isLogin()%> == true) {
		
	// $("mode").value = "noticeView";
	$("qu").value = "selectBbsBoardview";
	$("boardId").value = "LAWS";
	pform.action = "/homepage/introduce.do?mode=lawsView&seq="+form;
	pform.submit();
	} else {
		alert("로그인후 사용하실수 있습니다.");
	}

}


function isfileDownloadPopup(groupno) {
if(<%=loginInfo.isLogin()%> == true) {
		fileDownloadPopup(groupno);
	} else {
		alert("로그인후 사용하실수 있습니다.");
	}
}

//글쓰기
function goWrite(){
	$("qu").value = "insertBbsBoardForm";
	$("boardId").value = "LAWS";
	$("mode").value = "lawsView";
	pform.action = "/homepage/introduce.do";
	pform.submit();
}
//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left6.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual6.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>법률/조례</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; 법률/조례 &gt; <span>공무원</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" id="mode" name="mode"		value="<%= requestMap.getString("mode") %>">
<input type="hidden" id="qu" name="qu">
<input type="hidden" id="boardId" name="boardId">

<!-- 페이징용 -->
<input type="hidden" id="currPage" name="currPage"	value="<%= requestMap.getString("currPage")%>">
				<div id="content">
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="62" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>
							<th>제목</th>
							<th>첨부</th>
						</tr>
						</thead>
			
						<tbody>
						<%= sbListHtml.toString() %>
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
						<div class="space"></div>
						
						<div class="bttSearch">
							<select name="key">
								<option value="" <%if(requestMap.getString("key").equals("")){out.print("selected");} %>>선택</option>
								<option value="title" <%if(requestMap.getString("key").equals("title")){out.print("selected");} %>>제목</option>
								<option value="content" <%if(requestMap.getString("key").equals("content")){out.print("selected");} %>>내용</option>
								<option value="username" <%if(requestMap.getString("key").equals("username")){out.print("selected");} %>>작성자</option>
							</select>
							<input type="text" value="<%=requestMap.getString("search") %>" name="search" class="input01 w160" style="" />
							<a href="javascript:goSearch();"><img src="/images/<%= skinDir %>/button/btn_search01.gif" class="sch01" alt="검색" border="0" /></a>	
						</div>
					</div>

			</form>
			<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100037" /></jsp:include>
			<div class="h80"></div>

            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>