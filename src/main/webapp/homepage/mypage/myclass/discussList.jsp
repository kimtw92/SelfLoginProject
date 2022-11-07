<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%
String type = (String)request.getAttribute("type");

// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);

//과정기수 상세정보
DataMap grInfoMap = (DataMap)request.getAttribute("GRINFO_DATA");
grInfoMap.setNullToInitialize(true);

// 페이징 필수
FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");


StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";

if(listMap.keySize("seq") > 0){		
	for(int i=0; i < listMap.keySize("seq"); i++){
		
		sbListHtml.append("<tr>");
		sbListHtml.append("	<td class=\"bl0\">"+(pageNum-i)+"</td>");
		int l = Util.getIntValue(listMap.getString("depth",i),0);
		
		sbListHtml.append("	<td class=\"sbj\">");
		
		for (int z=0;z < l ; z ++){
			sbListHtml.append("&nbsp;&nbsp;");
		}
		if ( l > 0){
			sbListHtml.append("<img src=\"/images/"+ skinDir +"/icon/icon_re.gif\">");
		}
		sbListHtml.append(" <a href=\"javascript:onView('"+listMap.getString("seq",i)+"');\">"+StringReplace.subStringPoint(listMap.getString("title",i),23)+"</a></td>");		
		sbListHtml.append("	<td>"+listMap.getString("regdate",i)+"</td>");
		sbListHtml.append("	<td>"+listMap.getString("username",i)+"</td>");				
		sbListHtml.append("	<td>"+listMap.getString("visit",i)+"</td>");
		sbListHtml.append("	<td>");
		if (Util.getIntValue(listMap.getString("groupfileNo",i), 0) > 0){
			sbListHtml.append("<a href=\"javascript:fileDownloadPopup("+listMap.getString("groupfileNo",i)+");\"><img src=\"/images/"+ skinDir+"/icon/icon_fileDwn.gif\" alt=\"한글file 첨부\" /></a>");
		}
		sbListHtml.append(" </td>");
		sbListHtml.append("</tr>");

	}
	
	pageStr = pageNavi.FrontPageStr();				
}else{
	sbListHtml.append("<tr>");
	sbListHtml.append("<td colspan=\"6\">등록된 토론이 없습니다!");
	sbListHtml.append(" </td>");
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
	pform.action = "/mypage/myclass.do?mode=discussList";
	pform.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	pform.action = "/mypage/myclass.do?mode=discussList";
	pform.submit();
}
//리스트
function onView(form){
	$("qu").value = "discussView";
	pform.action = "/mypage/myclass.do?mode=discussView&seq="+form;
	pform.submit();
}
//글쓰기
function goWrite(){
	$("qu").value = "insertDiscuss";
	pform.action = "/mypage/myclass.do?mode=discussWrite";
	pform.submit();
}
//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left1.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual1.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>나의강의실</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; <span>나의강의실</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<div style="margin:1px;">					<!-- ※ 사이버 과정을 <font color="red">95% 이상</font> 수강하신 분은 <font color="red">21일까지 과정평가와 과정설문을 완료</font>하셔야 합니다. <font color="blue">(21일 이후 일괄 이수처리)</font><br />
					※ 교육기간 중에만 학습이 가능하며, 1일 최대 학습분량은 <font color="blue">20차시 이상은 7차시, 20차시 미만은 5차시로 </font>제한합니다.<br />
					※ <b><font color="blue">학습관련 장애</font></b>(진도율 0%인 경우 등) 시  <b><font color="blue">「인터넷 환경설정 필수 조치사항」</font></b> 안내에 따라 조치하여 주시기 바랍니다.(<a href="http://hrd.incheon.go.kr/homepage/support.do?mode=faqView&fno=60" target="_blank"><b>조치방법 보기</b></a>)<br /></div> -->
					※ <font color="red"> 학습기간(매월 1일~21일)내 진도율 95% 이상, 과정평가 및 과정설문 완료 필수</font>(일괄 수료처리 후 매월23일경 수료<br />  결과통보)<br />
					※ <font color="red"> 진도율 올라가지 않는 등</font> 학습장애시  (<a href="http://hrd.incheon.go.kr/homepage/support.do?mode=faqView&fno=63" target="_blank"><font color="blue"><b>「학습관련 장애시 대처방법」</b></font></a>)안내 참고
            <div class="mytab01">
              <ul>
                <li><a href="/mypage/myclass.do?mode=selectCourseList&type=<%=type%>"><img src="/homepage_new/images/M1/tab01.gif" alt="과정리스트"/></a></li>
                <li><a href="/mypage/myclass.do?mode=selectGrnoticeList&type=<%=type%>"><img src="/homepage_new/images/M1/tab02.gif" alt="과정공지"/></a></li>
                <li><a href="/mypage/myclass.do?mode=pollList&type=<%=type%>"><img src="/homepage_new/images/M1/tab03.gif" alt="과정설문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=testView&type=<%=type%>"><img src="/homepage_new/images/M1/tab04.gif" alt="과정평가"/></a></li>
                <li><a href="/mypage/myclass.do?mode=discussList&type=<%=type%>"><img src="/homepage_new/images/M1/tab05_on.gif" alt="과정토론방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=suggestionList&type=<%=type%>"><img src="/homepage_new/images/M1/tab06.gif" alt="과정질문방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=courseInfoDetail&type=<%=type%>"><img src="/homepage_new/images/M1/tab07.gif" alt="교과안내문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=sameClassList&type=<%=type%>"><img src="/homepage_new/images/M1/tab08.gif" alt="동기모임"/></a></li>
              </ul>
              </div>
              <form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden"  id="qu" name="qu" >
<!-- 페이징용 -->
<input type="hidden" id="currPage" name="currPage"	value="<%= requestMap.getString("currPage")%>">
				<div id="content">
						<div class="h15"></div>
			
						<!-- title --> 
						<h4 class="h4Ltxt"><%= grInfoMap.getString("grcodenm") %></h4>
						<!-- //title -->
						<div class="h9"></div>
			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="80" />
							<col width="80" />
							<col width="59" />
							<col width="59" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_no.gif" alt="번호" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_date.gif" alt="작성일" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_wName01.gif" alt="작성자" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_hit.gif" alt="조회" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_addfile03.gif" alt="첨부" /></th>
						</tr>
						</thead>
			
						<tbody>
						<%=sbListHtml.toString() %>
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>
			
						<!-- button -->
						<div class="btnRbtt">			
							<a href="javascript:goWrite();"><img src="/images/<%= skinDir %>/button/btn_write01.gif" alt="글쓰기" /></a>
						</div>
						<!-- //button -->
			
						<!--[s] 페이징 -->
						<div class="paging">
							<%=pageStr %>
						</div>
						<!--//[s] 페이징 -->
			
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
						<div class="space"></div>
					</div>
</form>
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>