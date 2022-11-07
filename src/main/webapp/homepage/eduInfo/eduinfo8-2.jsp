<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
     <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left5.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual5">교육지원</div>
            <div class="local">
              <h2>분야별교육안내</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육지원 &gt; 분야별교육안내 &gt; <span>e-러닝(전문)</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
              <!--전문사이버교육 시작-->
          <ol class="TabSub">
            <li><a href="/homepage/renewal.do?mode=eduinfo8-1">집합교육</a></li>
            <li class="TabOn"><a href="/homepage/renewal.do?mode=eduinfo8-2">e-러닝(전문)</a></li>
            <li class="last"><a href="/homepage/renewal.do?mode=eduinfo8-3">e-러닝(외국어)</a></li>
          </ol>
		  <div class="h15"></div>
            <h3>e-러닝(전문)</h3>

              <ul class="list_style3">
                <li>교육안내
                  <ol>
                    <li>2019년부터 e-러닝(전문)은 인천시 나라배움터 사이트에서 학습가능</li>
                   <li><a href="http://incheon.nhi.go.kr/"><font color="blue">나라배움터 학습 사이트 바로가기 : incheon.nhi.go.kr</font></a></li>
                  </ol>
                </li><br/>
                <li>교육대상
                  <ol>
                    <li>시, 군·구 공무원(공무직 포함)</li>
                  </ol>
               </li><br/>
                <li>교육기간
                  <ol>
                    <li>교육운영 : 2월 ~ 11월 (10기)</li>
                    <li>수강신청 : 매월 1일 ~ 25일 (수강신청 즉시 학습)</li>
                    <li>학습기간 : 매월 1일 ~ 말일</li>
                  </ol>
                 </li><br/>
                <li>학습방법
                  <ol>
                    <li>인천시 나라배움터 사이트 접속 (<a href="http://incheon.nhi.go.kr/"><font color="blue">incheon.nhi.go.kr</font></a>),교육신청 후 나의강의실에서 학습</li>

                  </ol>
                </li><br/>
                <li>수료기준
                  <ol>
                    <li>진도율 95%이상, 과정평가 60점 이상 (미평가 과정은 진도율로 수료처리)</li>
                    <li>e-러닝(전문) 과정종료 후 7일 이내에 교육생 소속기관으로 통보</li>
                  </ol>
                </li><br/>
                <li>상시학습
                  <ol>
                    <li>실제 교육시간 인정(학습시간 체크 가능)</li>
                  </ol>
                </li>
              </ul>
              <!--집합교육 마감-->
            <!-- //contnet -->
            <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100018" /></jsp:include>
			<div class="h80"></div>
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>