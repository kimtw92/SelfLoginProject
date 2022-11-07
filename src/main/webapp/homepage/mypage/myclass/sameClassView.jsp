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

if(listMap.keySize("grseq") > 0){
	String eduno = "";		
	for(int i=0; i < listMap.keySize("grseq"); i++){
		eduno = "";
		eduno = "0".equals(listMap.getString("eduno",i)) ? "미부여":listMap.getString("eduno",i);
		sbListHtml.append(" <tr>\n");
		//sbListHtml.append(" 	<td class=\"bl0 cent\" rowspan=\"2\">"+((i+1)+(requestMap.getInt("currPage") -1)*10)+"</td>\n");
		sbListHtml.append(" 	<td class=\"bl0 cent\" rowspan=\"2\">"+ eduno +"</td>\n");
		sbListHtml.append(" 	<td class=\"cent\" rowspan=\"2\"><img src=\"/images/"+ skinDir+"/sub/img_pNone.gif\" alt=\"profile 사진\" /></td>\n");
		sbListHtml.append(" 	<th>이름</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("name",i)+"</td>\n");
		sbListHtml.append(" 	<th>기관</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("deptnm",i)+"</td>\n");
		sbListHtml.append(" 	<th>부서</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("deptsub",i)+"</td>\n");
		sbListHtml.append(" </tr>\n");
		sbListHtml.append(" <tr>\n");
		sbListHtml.append(" 	<th>직급</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("jiknm",i)+"</td>\n");
		sbListHtml.append(" 	<th>Phone</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("telno",i)+"</td>\n");
		sbListHtml.append(" 	<th>E-mail</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("email",i)+"</td>\n");
		sbListHtml.append(" </tr>\n");
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

// 검색
function fnList(){
	pform.action = "/mypage/myclass.do?mode=sameClassView";
	pform.submit();
}
//상세보기
function onView(form){
	// $("mode").value = "noticeView";
	$("qu").value = "selectBbsBoardview";
	$("boardId").value = "DATA";
	pform.action = "/homepage/support.do?mode=programView&seq="+form;
	pform.submit();
}
//글쓰기
function goWrite(){
	$("qu").value = "insertBbsBoardForm";
	$("boardId").value = "DATA";
	pform.action = "/homepage/support.do?mode=programList";
	pform.submit();
}

function go_Print(grcode, grseq, currPage){
	var url = "/mypage/myclass.do";
	url += "?mode=sameClassPrint";
	url += "&grcode="+grcode;
	url += "&grseq="+grseq;
	url += "&currPage="+currPage;
	pwinpop = popWin(url,"printPop","620","430","yes","yes");

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
			</div>		
            <div class="mytab01">
              <ul>
                <li><a href="javascript:fnGoMenu('1','selectCourseList')"><img src="/homepage_new/images/M1/tab01.gif" alt="과정리스트"/></a></li>
                <li><a href="javascript:fnGoMenu('1','selectGrnoticeList')""><img src="/homepage_new/images/M1/tab02.gif" alt="과정공지"/></a></li>
                <li><a href="javascript:fnGoMenu('1','pollList')""><img src="/homepage_new/images/M1/tab03.gif" alt="과정설문"/></a></li>
                <li><a href="javascript:fnGoMenu('1','testView')""><img src="/homepage_new/images/M1/tab04.gif" alt="과정평가"/></a></li>
                <li><a href="javascript:fnGoMenu('1','discussList')""><img src="/homepage_new/images/M1/tab05.gif" alt="과정토론방"/></a></li>
                <li><a href="javascript:fnGoMenu('1','suggestionList')""><img src="/homepage_new/images/M1/tab06.gif" alt="과정질문방"/></a></li>
                <li><a href="javascript:fnGoMenu('1','courseInfoDetail')""><img src="/homepage_new/images/M1/tab07.gif" alt="교과안내문"/></a></li>
                <li><a href="javascript:fnGoMenu('1','sameClassList')""><img src="/homepage_new/images/M1/tab08_on.gif" alt="동기모임"/></a></li>
              </ul>
              </div>
              <form id="pform" name="pform" id="pform" method="post">
<!-- 필수 -->
<input type="hidden" name="qu" id="qu">
<input type="hidden" name="boardId" id="boardId">
<!-- 페이징용 -->
<input type="hidden" name="currPage" id="currPage"	value="<%= requestMap.getString("currPage")%>">
				<div id="content">
						<!-- title --> 
						<table width="100%">
							<tr>
								<td align="right"  width="100%"><a href="javascript:go_Print('<%=requestMap.getString("grcode") %>', '<%=requestMap.getString("grseq") %>', '<%=requestMap.getString("currPage") %>')"><img src="/images/<%= skinDir %>/icon/icon_print02.gif" alt="작성자" /></a></td>
                            </tr>
						</table>
						<!-- //title -->
						
						<div class="h9"></div>
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="44" />
							<col width="121" />
							<col width="44" />
							<col width="121" />
							<col width="44" />
							<col width="121" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_scNo.gif" alt="교번" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_photo.gif" alt="사진" /></th>
							<th colspan="6"><img src="/images/<%= skinDir %>/table/th_deAddr.gif" alt="세부주소" /></th>
						</tr>
						</thead>
			
						<tbody class="detail">
						<%=sbListHtml.toString() %>
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>                
			
						<!--[s] 페이징 -->
						<div class="paging">
							<%=pageStr.toString() %>
						</div>
						<!--//[s] 페이징 -->
			
						<div class="space"></div>
					</div>
</form>
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>