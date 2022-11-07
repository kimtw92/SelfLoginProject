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
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육지원 &gt; 분야별교육안내 &gt; <span>집합교육</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
              <!--집합교육 시작-->
          <ol class="TabSub">
            <li class="TabOn"><a href="/homepage/renewal.do?mode=eduinfo8-1">집합교육</a></li>
            <li><a href="/homepage/renewal.do?mode=eduinfo8-2">e-러닝(전문)</a></li>
            <li class="last"><a href="/homepage/renewal.do?mode=eduinfo8-3">e-러닝(외국어)</a></li>
          </ol>
			
			<div class="h15"></div>
            <h3>집합교육</h3>

              <ul class="list_style3">
                <li>교육훈련 계획안내
                  <ol>
                    <li>교육훈련계획은 전년도 12월말에 수립되어 다음년도 1월말 인재개발원 홈페이지 교육공지란에 안내되고 공문으로도 통보됩니다.</li>
                  </ol>
                </li>
                <li>수강신청 안내(교육시작 3주전)
                  <ol>
                    <li>교육참여 희망자는 매월 교육시작 3주전에 인재개발원홈페이지(hrd.incheon.go.kr)에 접속하고 회원 등록(기회원 등록자는 불필요)한 후 신청</li>
                  </ol>
                </li>
                <li>1차승인(교육시작 3주전+2일 )
                  <ol>
                    <li>개별적으로 수강신청을 하고 나면 시 본청 및 사업소 직원은 부서교육담당자가 인원 등을 고려하여 1차승인을 하고, 자치구 직원은 자치구 교육담당부서에서 1차승인을 합니다.</li>
                    <li>1차승인이 완료되면 인재개발원 홈페이지(마이페이지)에서 수강신청 상황이 진행중으로 표시되어 교육신청자는 확인할 수 있습니다.</li>
                  </ol>
                </li>
                <li>2차 승인(교육시작 3주전+3일 )
                  <ol>
                    <li>1차승인을 하고 나면 인재개발원 과정담당자는 교육대상, 기관별 안배 등을 고려하여 2차승인을 해주고 교육대상자를 확정하게 됩니다. 2차승인도 1차승인과 동일하게 홈페이지(마이페이지)에 표시되므로 교육신청자는 확인할 수 있습니다.</li>
                  </ol>
                </li>
                <li>입교
                  <ol>
                    <li>교육시작 당일 8시50분까지 출석부에 서명하시고 지급된 명찰은 교육기간 중 항상 패용해 주시기 바랍니다. 인재개발원에 오시는 방법은 홈페이지 『인재개발원 소개』의 찾아오시는 길을 참고하시기 바랍니다.</li>
                  </ol>
                </li>
                <li>수료처리 및 통보
                  <ol>
                    <li>모든과정에 대하여 근태을 평가하며, 수료기준에 위배된 사항이 없으면 최종성적 60점 이상 취득한 교육생은 과정종료시 수료처리하며, 성적 및 수료사실 등은 공문을 통해 과정종료 후 10일이내 해당 기관에 통보합니다.</li>
                  </ol>
                </li>
              </ul>
              <!--집합교육 마감-->
              <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100017" /></jsp:include>
              <!-- //contnet -->
			  <div class="h80"></div>
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>