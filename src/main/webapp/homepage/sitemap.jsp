<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left7.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual7">홈페이지 이용안내</div>
            <div class="local">
              <h2>사이트맵</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 홈페이지 이용안내 &gt; <span>사이트맵</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<div id="content">
            <div class="h30"></div>

            <!--  -->
            <div class="stmapSet03">
                <div class="stmapT01">
                    <img src="/images/skin4/title/tit_s01.gif" alt="마이페이지" />
                    <ul class="dapth1">
                        <li><a href="javascript:fnGoMenu(1,'main')">나의강의실</a></li>
                        <li><a href="javascript:fnGoMenu(4,'attendList')">교육신청 및 취소</a></li>
                        <li><a href="javascript:fnGoMenu(1,'completionList')">수료내역</a></li>
						<li><a href="javascript:fnGoMenu(1,'myquestion')">개인정보</a></li>
						<li><a href="javascript:fnGoMenu(1,'memberout')">회원탈퇴</a></li>
                    </ul>
                </div>
            </div>
            <!-- // -->

            <!--  -->
            <div class="stmapSet03">
                <div class="stmapT01">
                    <img src="/images/skin4/title/tit_s02.gif" alt="교육과정" />
                    <ul class="dapth1">
                        <li><a href="javascript:fnGoMenu(2,'eduinfo2-1')">입교안내</a></li>
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-2')">교육훈련체계</a></li>
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-3')">연간교육일정</a></li>
						<li><a href="javascript:fnGoMenu(2,'eduinfo3-1')">집합교육</a></li>
						<li><a href="javascript:fnGoMenu(2,'eduinfo3-4')">사이버교육</a></li>
<!-- 						<li><a href="javascript:fnGoMenu(2,'webzine')">공개강의</a></li> -->
                    </ul>
                </div>
            </div>
            <!-- // -->

            <!--  -->
            <div class="stmapSet04">
                <div class="stmapT01">
                    <img src="/images/skin4/title/tit_s03.gif" alt="교육신청" />
                    <ul class="dapth1">
                        <li><a href="javascript:fnGoMenu(4,'attendList')">교육신청 및 취소</a></li>
                    </ul>
                </div>
            </div>
            <!-- // -->
            <div class="h15"></div>

			<!--  -->
            <div class="stmapSet13">
                <div class="stmapT01">
                    <img src="/images/skin4/title/tit_s04.gif" alt="참여공간" />
                    <ul class="dapth1">
                        <li><a href="javascript:fnGoMenu(5,'requestList')">묻고답하기</a></li>   
                    </ul>
                </div>
            </div>
            <!-- // -->

            <!--  -->
            <div class="stmapSet13">
                <div class="stmapT01">
                    <img src="/images/skin4/title/tit_s05.gif" alt="교육지원" />
                    <ul class="dapth1">
                        <li><a href="/homepage/renewal.do?mode=eduinfo8-1">분야별교육안내</a></li>
						<li><a href="javascript:fnGoMenu(5,'faqList')">자주하는질문</a></li>
						<li><a href="javascript:fnGoMenu(5,'educationDataList')">자료실</a></li>
						<li><a href="/homepage/renewal.do?mode=eduinfotel">과정별 안내전화</a></li>
						<li><a href="/homepage/renewal.do?mode=readingList">교육생숙지사항</a></li>
						<li><a href="javascript:fnGoMenu(7,'eduinfo7-4')">식단표</a></li>
                    </ul>
                </div>
            </div>
            <!-- // -->

            <!--  -->
            <div class="stmapSet14">
                <div class="stmapT01">
                    <img src="/images/skin4/title/tit_s06.gif" alt="인재개발원 소개" />
                    <ul class="dapth1">
                        <li><a href="javascript:fnGoMenu(7,'eduinfo7-1')">인사말</a></li>
						<li><a href="/homepage/renewal.do?mode=introduction02">비젼 및 목표</a></li>
						<!-- li><a href="javascript:fnGoMenu(6,'eduinfo6-1')">안내동영상</a></li -->
						<li><a href="javascript:fnGoMenu(7,'eduinfo7-2')">연혁</a></li>
						<li><a href="javascript:fnGoMenu(7,'eduinfo7-3')">조직 및 업무</a></li>
						<li><a href="javascript:fnGoMenu(5,'noticeList')">인재개발원 알림</a></li>
						<li><a href="javascript:fnGoMenu(7,'lawsList')">법률/조례</a></li>
						<li><a href="javascript:fnGoMenu(7,'eduinfo7-6')">시설현황</a></li>
                    </ul>
                </div>
            </div>
            <!-- // -->
            <div class="h15"></div>

            <!--  -->
            <div class="stmapSet05">
                <div class="stmapT02">
                    <div class="tt05"><img src="/images/skin4/title/tit_s07.gif" alt="홈페이지 이용안내" /></div>
                    <ul class="dapth1">
                        <li class="stm1"><a href="/homepage/introduce.do?mode=eduinfo7-7">찾아오시는 길</a></li>
                        <li class="stm2"><a href="/homepage/index.do?mode=worktel">업무별연락처</a></li>
                        <li class="stm3"><a href="/homepage/index.do?mode=policy">개인보호정책</a></li>
						<li class="stm4"><a href="/homepage/index.do?mode=spam">이메일 무단수집거부</a></li>
						<li class="stm5"><a href="/homepage/index.do?mode=sitemap">사이트맵</a></li>
                    </ul>
                </div>
            </div>
            <!-- // -->
		</div>


			<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100042" /></jsp:include>
            <div class="h80"></div>
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>