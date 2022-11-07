<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%

String type = (String)request.getAttribute("type");

//필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


DataMap popupMap1 = (DataMap)request.getAttribute("COURSE_INFO_POPUP1");
popupMap1.setNullToInitialize(true);

DataMap popupMap2 = (DataMap)request.getAttribute("COURSE_INFO_POPUP2");
popupMap2.setNullToInitialize(true);

//

StringBuffer sumHtml = new StringBuffer();
StringBuffer subSumHtml1 = new StringBuffer();
StringBuffer subSumHtml2 = new StringBuffer();
StringBuffer subSumHtml3 = new StringBuffer();
StringBuffer subDetail1 = new StringBuffer();
StringBuffer subDetail2 = new StringBuffer();
StringBuffer subDetail3 = new StringBuffer();



DataMap sum = (DataMap)request.getAttribute("COURSE_INFO_SUM");
sum.setNullToInitialize(true);

if(sum.keySize("sub1") == 1){
	sumHtml.append("<td><strong>"+sum.getString("sub1",0)+"</strong></td>");
	sumHtml.append("<td><strong>"+sum.getString("sub2",0)+"</strong></td>");
	sumHtml.append("<td><strong>"+sum.getString("sub3",0)+"</strong></td>");
	sumHtml.append("<td>"+sum.getString("sub4",0)+"</td>");
}

DataMap detail = (DataMap)request.getAttribute("COURSE_INFO_DETAIL");
detail.setNullToInitialize(true);		

DataMap subSum1 = (DataMap)request.getAttribute("COURSE_INFO_SUB_SUM1");
subSum1.setNullToInitialize(true);

DataMap subSum2 = (DataMap)request.getAttribute("COURSE_INFO_SUB_SUM2");
subSum2.setNullToInitialize(true);

DataMap subSum3 = (DataMap)request.getAttribute("COURSE_INFO_SUB_SUM3");
subSum3.setNullToInitialize(true);

int rowspan1 = Integer.parseInt(subSum1.getString("rowspan",0)) + 1;
int rowspan2 = Integer.parseInt(subSum2.getString("rowspan",0)) + 1;
int rowspan3 = Integer.parseInt(subSum3.getString("rowspan",0)) + 1;


subSumHtml1.append("<tr>");
subSumHtml1.append("<th class=\"bl0\" rowspan=\""+rowspan1+"\">소양분야</th> ");
subSumHtml1.append("<td>소계</td>");
subSumHtml1.append("<td>"+subSum1.getString("sub1",0)+"</td>");
subSumHtml1.append("<td>"+subSum1.getString("sub2",0)+"</td>");
subSumHtml1.append("<td>"+subSum1.getString("sub3",0)+"</td>");
subSumHtml1.append("<td>"+subSum1.getString("sub4",0)+"</td>");
subSumHtml1.append("</tr>");

for(int i=0; i<detail.keySize("annaeTitle");i++) {
	if(detail.getString("annaeGubun",i).equals("1") ) {
		subDetail1.append("<tr> ");
		subDetail1.append("<td class=\"sbj\">"+detail.getString("annaeTitle",i)+"</td> ");
		subDetail1.append("<td>"+detail.getString("title1Sub1",i)+"</td> ");
		subDetail1.append("<td>"+detail.getString("title1Sub2",i)+"</td> ");
		subDetail1.append("<td>"+detail.getString("title1Sub3",i)+"</td> ");
		subDetail1.append("<td>"+detail.getString("title1Sub4",i)+"</td> ");
		subDetail1.append("</tr>	");	
	}	
}

subSumHtml2.append("<tr>");
subSumHtml2.append("<th class=\"bl0\" rowspan=\""+rowspan2+"\">직무분야</th> ");
subSumHtml2.append("<td>소계</td>");
subSumHtml2.append("<td>"+subSum2.getString("sub1",0)+"</td>");
subSumHtml2.append("<td>"+subSum2.getString("sub2",0)+"</td>");
subSumHtml2.append("<td>"+subSum2.getString("sub3",0)+"</td>");
subSumHtml2.append("<td>"+subSum2.getString("sub4",0)+"</td>");
subSumHtml2.append("</tr>");

for(int i=0; i<detail.keySize("annaeTitle");i++) {
	if(detail.getString("annaeGubun",i).equals("2") ) {
		subDetail2.append("<tr> ");
		subDetail2.append("<td class=\"sbj\">"+detail.getString("annaeTitle",i)+"</td> ");
		subDetail2.append("<td>"+detail.getString("title1Sub1",i)+"</td> ");
		subDetail2.append("<td>"+detail.getString("title1Sub2",i)+"</td> ");
		subDetail2.append("<td>"+detail.getString("title1Sub3",i)+"</td> ");
		subDetail2.append("<td>"+detail.getString("title1Sub4",i)+"</td> ");
		subDetail2.append("</tr>	");	
	}	
}	

subSumHtml3.append("<tr>");
subSumHtml3.append("<th class=\"bl0\" rowspan=\""+rowspan3+"\">행정기타</th> ");
subSumHtml3.append("<td>소계</td>");
subSumHtml3.append("<td>"+subSum3.getString("sub1",0)+"</td>");
subSumHtml3.append("<td>"+subSum3.getString("sub2",0)+"</td>");
subSumHtml3.append("<td>"+subSum3.getString("sub3",0)+"</td>");
subSumHtml3.append("<td>"+subSum3.getString("sub4",0)+"</td>");
subSumHtml3.append("</tr>");	

for(int i=0; i<detail.keySize("annaeTitle");i++) {
	if(detail.getString("annaeGubun",i).equals("3") ) {
		subDetail3.append("<tr> ");
		subDetail3.append("<td class=\"sbj\">"+detail.getString("annaeTitle",i)+"</td> ");
		subDetail3.append("<td>"+detail.getString("title1Sub1",i)+"</td> ");
		subDetail3.append("<td>"+detail.getString("title1Sub2",i)+"</td> ");
		subDetail3.append("<td>"+detail.getString("title1Sub3",i)+"</td> ");
		subDetail3.append("<td>"+detail.getString("title1Sub4",i)+"</td> ");
		subDetail3.append("</tr>	");	
	}	
}	
	
%>

<script language="JavaScript" type="text/JavaScript">
<!--

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
                <li><a href="/mypage/myclass.do?mode=discussList&type=<%=type%>"><img src="/homepage_new/images/M1/tab05.gif" alt="과정토론방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=suggestionList&type=<%=type%>"><img src="/homepage_new/images/M1/tab06.gif" alt="과정질문방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=courseInfoDetail&type=<%=type%>"><img src="/homepage_new/images/M1/tab07_on.gif" alt="교과안내문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=sameClassList&type=<%=type%>"><img src="/homepage_new/images/M1/tab08.gif" alt="동기모임"/></a></li>
              </ul>
              </div>
              <form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden"  name="qu" >
<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
					<div id="content">
						<div class="h9"></div>
			
						<!-- data -->
						<table class="dataW02">
							<tr>
								<th width="83" class="bl0">과정분류</th>
								<td width="196"><%=popupMap1.getString("mcodeName",0) %>교육</td>
								<th width="83">상세분류</th>
								<td width="196"><%=popupMap1.getString("scodeName",0) %>교육</td>
							</tr>
							<tr>
								<th width="83" class="bl0">과정명</th>
								<td colspan="3"><%=popupMap1.getString("grcodenm",0) %></td>
							</tr>
							<tr>
								<th width="83" class="bl0">교육목표</th>
								<td colspan="3">
									<%=Util.N2Br(popupMap2.getString("goal",0)) %>
								</td>
							</tr>
							<tr>
								<th width="83" class="bl0">교육대상</th>
								<td colspan="3"><%=Util.N2Br(popupMap2.getString("target",0)) %></td>
							</tr>
							<tr>
								<th width="83" class="bl0">교육인원</th>
								<td colspan="3"><%=Util.N2Br(popupMap2.getString("inwon",0)) %></td>
							</tr>
							<tr>
								<th width="83" class="bl0">교육기간</th>
								<td colspan="3"><%=Util.N2Br(popupMap2.getString("gigan",0)) %></td>
							</tr>
							<tr>
								<th width="83" class="bl0">과정운영</th>
								<td colspan="3"><%=Util.N2Br(popupMap2.getString("yunyoung",0)) %></td>
							</tr>
							<tr>
								<th width="83" class="bl0">교육편성</th>
								<td class="outDate" colspan="3">
								<!-- inData -->
								<table class="inData">
									<tr>
										<th class="bl0" rowspan="2">구분</th>
										<th class="in" rowspan="2">계</th>
										<th class="in" rowspan="2">소양분야</th>
										<th class="in" colspan="3">직무분야</th>
										<th class="in" rowspan="2">행정및기타</th>
									</tr>
									<tr>
										<th class="in">소계</th>
										<th class="in">직무공통</th>
										<th class="in">직무전문</th>
									</tr>
									<tr>
										<td class="bl0">시간</td>
										<td class="in"><%=popupMap2.getString("sigange",0) %></td>
										<td class="in"><%=popupMap2.getString("sibunya",0) %></td>
										<td class="in"><%=popupMap2.getString("sisoge",0) %></td>
										<td class="in"><%=popupMap2.getString("sicommon",0) %></td>
										<td class="in"><%=popupMap2.getString("sijunmun",0) %></td>
										<td class="in"><%=popupMap2.getString("sietc",0) %></td>
									</tr>
									<tr>
										<td class="bl0">비율</td>
										<td class="in"><%=popupMap2.getString("rategange",0) %></td>
										<td class="in"><%=popupMap2.getString("ratebunya",0) %></td>
										<td class="in"><%=popupMap2.getString("ratesoge",0) %></td>
										<td class="in"><%=popupMap2.getString("ratecommon",0) %></td>
										<td class="in"><%=popupMap2.getString("ratejunmun",0) %></td>
										<td class="in"><%=popupMap2.getString("rateetc",0) %></td>
									</tr>
								</table>
								<!-- //inData -->
								</td>
							</tr>
						</table>
						<!-- //data -->
						<div class="space01"></div>
			
						<!-- data -->
						<table class="dataH03">	
						<colgroup>
							<col width="70" />
							<col width="*" />
							<col width="69" />
							<col width="69" />
							<col width="69" />
							<col width="47" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0" rowspan="2">구분</th>
							<th rowspan="2">과목</th>
							<th colspan="3">시간</th>
							<th rowspan="2">비고</th>
						</tr>
						<tr>
							<th>계</th>
							<th>강의</th>
							<th>참여식</th>
						</tr>
						</thead>
			
						<tbody>
						<tr>
							<td class="bl0" colspan="2">합계</td>
							<%=sumHtml %>
						</tr>
						<%=subSumHtml1 %>
						<%=subDetail1 %>
						<%=subSumHtml2 %>
						<%=subDetail2 %>
						<%=subSumHtml3 %>
						<%=subDetail3%>
						</tbody>
						</table>
						<!-- //data -->
			
						<div class="space"></div>
					</div>
</form>
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>