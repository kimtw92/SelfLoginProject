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
              <h2>교육생숙지사항</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육지원 &gt; <span>교육생숙지사항</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            <div id="content">
				<div class="rGrySet01">
					<div class="rGry02">
						<img src="../../../images/skin4/sub/notice11.gif" alt="인천광역시 인재개발원 교육생숙지사항입니다. 교육내용 숙지 및 학습내용을 알려드립니다. 원하시는 내용을 아래에서 다운받아보실수 있습니다."/>
					</div>
				</div>	
				<br/><br/>
				<table class="dataH12"> 
					<colgroup>
							<col width="170" />
							<col width="270" />
							<col width="231" />
					</colgroup>

					<thead>
					<tr>
						<th class="t01">제목</th>
						<th class="t01" style="width:300px">내용</th>
						<th class="t01">다운로드</th>
					</tr>
					</thead>

					<tbody>
					<tr>
						<td class="cbj">교육훈련계획</td>
						<td class="sbj">1. 교육훈련계획 총괄<br/>
								2. 월별교육일정<br/>
								3. 기본교육 <br/>
								4. 전문교육<br/>
								5. 기타교육</td>
						<td><a href="/down/2022_eduplan_1.hwp" class="ht11">교육훈련 계획 및 일정표 다운받기</a></td>
					</tr>
					<tr>
						<td class="cbj">교육인정시간 기준</td>
						<td class="sbj">
							1) 연간 의무이수시간 완화(80H → 60H)<br/>
							2) 교윤훈련부서주관 집함교육은 인사과의 교육명령에 의한 실적만 해당<br/>
							3) 필수역량학습, 기관지정학습은 해당 직급에서 각 1회 의무 이수</td>
						<td><a href="/down/2022_eduplan_2.hwp" class="ht11">교육인정시간 기준 다운받기</a></td>
					</tr>
					<tr>
					<!-- Test -->
						<td class="cbj">사이버교육 운영지침</td>
						<td class="sbj">
							공무원 사이버교육 운영의 내실화를 도모하기 위해 필요한 사항을 규정함</td>
						<td><a href="/down/03.hwp" class="ht11">사이버교육 운영지침 다운받기</a></td>
					</tr>
					<tr>
						<td class="cbj">사이버교육 운영계획</td>
						<td class="sbj">
							1. 공무원 사이버 전문 교육<br/>
							2. 공무원 사이버 외국어 교육</td>
						<td><a href="/down/2022_eduplan_11.hwp" class="ht11">공무원 e-러닝(전문) 운영계획(안) 다운받기</a><br/>
						<a href="/down/2022_eduplan_22.hwp" class="ht11">공무원 e-러닝(외국어) 운영계획(안) 다운받기</a></td>
					</tr>
					</tbody>
					</table>

			</div>

              <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100029" /></jsp:include>
			<div class="h80"></div>		  
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>