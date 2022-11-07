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
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육지원 &gt; 분야별교육안내 &gt; <span>e-러닝(외국어)</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
              <!--외부사이버교육 시작-->
          <ol class="TabSub">
            <li><a href="/homepage/renewal.do?mode=eduinfo8-1">집합교육</a></li>
            <li><a href="/homepage/renewal.do?mode=eduinfo8-2">e-러닝(전문)</a></li>
            <li class="TabOn last"><a href="/homepage/renewal.do?mode=eduinfo8-3">e-러닝(외국어)</a></li>
          </ol>
		  <div class="h15"></div>
            <h3>e-러닝(외국어)</h3>
              <ul class="list_style3">
                <li>교육과정
                  <ol>
                    <li>동영상 과정 : 9개 언어(영어, 중국어, 일본어, 스페인어, 프랑스어, 독일어, 베트남어, 러시아어, 태국어)</li>
                  </ol>
				  &nbsp;&nbsp;※ 회화, 시험대비, 문법, 청취, 작문, 독해 등 단순 학습<br />
				
				<ol>
				  <li>참여형 언어합습 과정 : 9개 언어<br />
					영어(북미,영국), 중국어, 일본어, 스페인어(라틴아메리카,스페인), 프랑스어, 
					독일어, 필리핀어, 러시아어, 베트남어</li>
				<br/><b>※ 음성인식과 이미지 연상 학습을 통한 참여 학습</b>
				</ol>
                <br />
				<li>교육대상
                  <ol>
                    <li>시, 군·구 공무원 및 공사,공단 직원</li>
                  </ol>
                </li>
				<br />
                <li>교육기간
                  <ol>
                    <li>교육기간 : 2월 ~ 11월</li>
                  </ol>
                </li>
				
				<table border="1" style="text-align:center;margin-left:15px;">
					<tr>
						<td bgcolor="#E6EEF7" width="120px">기수</td>
						<td bgcolor="#E6EEF7" width="200px">수강신청 및 학습기간</td>
					</tr>
					<tr>
						<td>1기</td>
						<td> 02월  ~ 03월31일</td>
					</tr>
					<tr>
						<td>2기</td>
						<td> 04월 ~  05월31일</td>
					</tr>
					<tr>
						<td>3기</td>
						<td> 06월 ~  07월31일</td>
					</tr>
					<tr>
						<td>4기</td>
						<td>08월 ~  09월30일</td>
					</tr>
					<tr>
						<td>5기</td>
						<td>10월 ~  11월30일</td>
					</tr>
				</table>
				<br />
                <li>학습방법
                  <ol>
                    <li>인재개발원 홈페이지 로그인 후 「공무원e-러닝(외국어)센터」 배너 클릭 후 교육과정 선택하여 해당과정 홈페이지로 이동후 강좌를 신청하여 학습을 진행합니다.</li>
                  </ol>
                </li>
				<br />
                <li>수료기준
                  <ol>
                    <li>동영상 과정 : 진도율 70% 이상 + 온라인 학습평가 응시 + 설문</li>
					<li>참여형 언어학습 과정 : 5시간 이상 학습 + 설문</li>
                  </ol>
                </li>
				<br />
                <li>상시학습
                  <ol>
                    <li>동영상 과정 : 수료 강좌 차시의 50% 인정</li>
                    <li>참여형 언어학습 과정 : 학습 시간 100% 인정(기수별 5~40시간)</li>
                  </ol>
                </li>
              </ul>
              <!--집합교육 마감-->
            <!-- //contnet -->
            <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100019" /></jsp:include>
			<div class="h80"></div>
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>