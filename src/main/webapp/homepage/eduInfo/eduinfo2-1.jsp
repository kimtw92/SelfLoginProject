<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left2.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual2">교육과정</div>
            <div class="local">
              <h2>입교안내</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육과정 &gt; <span>입교안내</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
              <!--입교안내 시작-->
			<div class="point_box">
				<p class="box_img"><span><img src="/homepage_new/images/common/box_point.gif" alt=""></span></p>
				<div class="list">
					<p>
                    교육대상자 선발은 직급, 직렬, 담당직무, 경력 및 건강상태 등을 고려하여 교육훈련
과정별 교육목적에 적합한 자를 선발함으로서, 미입교 또는 교육 중 퇴교 등 사고가
발생되지 않도록 철저히 관리하고 있으며, 신규채용자과정은 최근 임용자 순, 기타 과정은
해당직급 승진후 장기간 경과한 자를 우선 선발하고 있습니다.                    
                    </p>
				</div>
			</div>
			<div class="h25"></div>
            <h3>교육신청절차</h3>
              <ul class="list_style3">
                <li>교육신청자가 인재개발원 홈페이지에 온라인 수강신청</li>
                <li>소속기관의 교육담당자에게 통보</li>
                <li>소속기관장의 1차 승인</li>
                <li>인재개발원장의 최종승인</li>
              </ul>
			  <div class="h9"></div>
            <h3>등록 및 입교 안내</h3>
              <ul class="list_style3">
                <li>등록시간 : 교육등록 08:40∼08:50
                  <ol>
                    <li>교과운영 : 09:00∼17:00(1일 7시간)</li>
                    <li>등록장소 : 인천광역시인재개발원 본관 1층 로비</li>
                  </ol>
                </li>
                <li>준비물
                  <ol>
                    <li>공 통 : 학습도구(필기구 및 노트)</li>
                    <li>합숙과정 : 세면도구, 생활용품, 간소복, 운동복, 운동화 등.</li>
                  </ol>
                </li>
                <li>교육생 생활안내
                  <ol>
                    <li>부득이한 사유로 결강, 결석 외박을 하고자 할 때에는 사전에 해당 교육과정 운영담당자에게 허가 절차 이행</li>
                    <li>교육기간중 명찰패용, 수료시 반납</li>
                    <!-- <li>실내체육관 이용시간 : 점심시간, 교육종료후(17:00~20:00)</li>
                    <li>인재개발원 셔틀버스 이용안내 : 오전 08시30분 경인교대역 1번출구 앞</li> -->
                    <li>교육운영 전반에 대한 도움말씀은 담당 과정장에게 해주시거나 인재개발원 홈페이지(http://hrd.incheon.go.kr) 게시판을 이용하여 주시기 바랍니다.</li>
                  </ol>
                </li>
                <li>교육생 준수사항
                  <ol>
                    <li>교육훈련 계획에 정한 시간까지 등록</li>
                    <li>건물내 흡연 금지</li>
                    <li>강의실내 이동전화 전원 off 또는 진동모드 전환</li>
                    <li>교육생 주차구역내 주차</li>
                  </ol>
                </li>
                <li>교육생 기본수칙 위반시 제재사항
                  <ol>
                    <li>1급사고 : 퇴교조치 및 소속기관장에 통보
                      <div class="point_box">
                        <ul class="list">
                          <li>무단(결석, 결강, 조퇴, 외출, 외박) 행위</li>
                          <li>원내에서의 음주, 도박 절도행위</li>
                          <li>인재개발원 비품 및 시설물 고의 또는 중대한 과실로 파손, 분실한 경우 (변상조치 병행)</li>
                          <li>근태 누적감점이 40점 초과인 자</li>
                          <li>결석 허가일수를 초과한 경우</li>
                          <li>기타 정당한 지시 불이행 행위</li>
                        </ul>
                      </div>
                    </li>

                    <li>2급 사고 : 감점조치(감점기준표 참고)
                      <div class="point_box">
                        <ul class="list">
                          <li>허가에 의한 결석, 결강, 외출, 외박, 조퇴 행위</li>
                          <li>인재개발원 비품 및 시설을 부주의한 과실로 파손, 분실한 경우(변상조치 병행)</li>
                          <li>기타 교육생으로서의 품위 위반 행위</li>
                        </ul>
                      </div>
                    </li>

                    <li>감점기준표
                    <table class="table_st3" style="width:100%;"> 
			            <thead>
			            <tr>
			                <th rowspan="2">구분</th>
			                <th rowspan="2">감점사고내용</th>
			                <th rowspan="2">기준</th>
			                <th colspan="7">감점</th>
			                <th rowspan="2">비고</th>
			            </tr>
			            <tr>
			                <th>2일<br />이하</th>
			                <th>3일<br />이하</th>
			                <th>5일<br />이하</th>
			                <th>2주<br />이하</th>
			                <th>4주<br />이하</th>
			                <th>12주<br />이하</th>
							<th>12주<br />초과</th>
			            </tr>
			            </thead>
			
			            <tbody>
			            <tr>
			                <td rowspan="3">단체<br />감점</td>
			                <td class="left">1. 단체생활이 극히 무질서할 때</td>
			                <td>1회</td>
			                <td>20</td>
							<td>20</td>
			                <td>20</td>
			                <td>15</td>
			                <td>10</td>
			                <td>5</td>
			                <td>3</td>
			                <td rowspan="3">교육생대표의<br />확인서첨부<br />(불응시<br />직권감점)</td>
			            </tr>
			            <tr>
			                <td class="left">2. 전반의 수업태도가 극히 불량한 때</td>
			                <td>1회</td>
			                <td>20</td>
							<td>20</td>
			                <td>20</td>
			                <td>15</td>
			                <td>10</td>
			                <td>5</td>
			                <td>3</td>
			            </tr>
			            <tr>
			                <td class="left">3. 본원 지시에 단체적으로<br />&nbsp;&nbsp;&nbsp; 불응한 때</td>
			                <td>1회</td>
			                <td>20</td>
							<td>20</td>
			                <td>20</td>
			                <td>20</td>
			                <td>15</td>
			                <td>10</td>
			                <td>5</td>
			            </tr>
			            <tr>
			                <td rowspan="2">반별<br />감점</td>
			                <td class="left">1. 분임별 공용물,사물정돈<br />&nbsp;&nbsp;&nbsp; 및 청소불량</td>
			                <td>1일</td>
			                <td>12</td>
							<td>10</td>
			                <td>10</td>
			                <td>7</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td rowspan="2">생활지도교수<br />의사 참고</td>
			            </tr>
			            <tr>
			                <td class="left">2. 분임별 생활태도 불량</td>
			                <td>1일</td>
							<td>12</td>
			                <td>10</td>
			                <td>10</td>
			                <td>7</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			            </tr>
			            <tr>
			                <td rowspan="14">개인<br />감점</td>
			                <td class="left">1. 대리서명</td>
			                <td>1회</td>
			                <td>20</td>
			                <td>20</td>
							<td>20</td>
			                <td>10</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td rowspan="14">사유서 또는<br />증빙서 첨부<br /><!-- <br />4시간 이상은<br />퇴교
<br /><br />고의성인<br />경우 퇴교 -->
</td>
			            </tr>
			            <tr>
			                <td class="left">2. 등록지연,지각</td>
			                <td>시간당</td>
							<td>20</td>
			                <td>15</td>
			                <td>15</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td>1</td>
			            </tr>
			            <tr>
			                <td class="left">3. 허가에 의한 결석,외박<br />&nbsp;&nbsp;&nbsp; (합숙시)</td>
			                <td>1회</td>
			                <td>허가<br/>제외</td>
							<td>허가<br/>제외</td>
			                <td>허가<br/>제외</td>
			                <td>20</td>
			                <td>12</td>
			                <td>10</td>
			                <td>3</td>
			            </tr>
			            <tr>
			                <td class="left">4. 허가에 의한 결강,외출,<br />&nbsp;&nbsp;&nbsp; (결강, 외박,조퇴,지각)</td>
			                <td>시간당</td>
							<td>20</td>
			                <td>12</td>
			                <td>10</td>
			                <td>3</td>
			                <td>2</td>
			                <td>1</td>
			                <td>1</td>
			            </tr>
			            <tr>
			                <td class="left">5. 점호,구보,체조,청소,체육,<br />&nbsp;&nbsp;&nbsp; 봉사활동등 무단불참</td>
			                <td>1회</td>
			                <td>10</td>
							<td>10</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			            </tr>
			            <tr>
			                <td class="left">6. 교수, 강사, 직원에 대한 태도<br />&nbsp;&nbsp;&nbsp; 불손태도</td>
			                <td>1회</td>
			                <td>10</td>
							<td>10</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>1</td>
			            </tr>
			            <tr>
			                <td class="left">7. 관물훼손 및 파괴</td>
			                <td>1회</td>
			                <td>10</td>
							<td>10</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>1</td>
			            </tr>
			            <tr>
			                <td class="left">8. 수업태도 불량<br />&nbsp;&nbsp;&nbsp; (잡담,이석 등)</td>
			                <td>1회</td>
			                <td>10</td>
			                <td>10</td>
							<td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>1</td>
			            </tr>
			            <tr>
			                <td class="left">9. 허가에 의한 외출,외박후<br />&nbsp;&nbsp;&nbsp; 정당한 사유없이 지각귀원</td>
			                <td>1회</td>
			                <td>10</td>
			                <td>10</td>
							<td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>1</td>
			            </tr>
			            <tr>
			                <td class="left">10. 각종 보고서 제출 지연</td>
			                <td>1회</td>
			                <td>10</td>
			                <td>10</td>
							<td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>1</td>
			            </tr>
			            <tr>
			                <td class="left">11. 용모,복장 불량</td>
			                <td>1회</td>
			                <td>5</td>
							<td>5</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td>1</td>
			            </tr>
			            <tr>
			                <td class="left">12. 낙서 및 지정장소외의 흡연</td>
			                <td>1회</td>
							<td>5</td>
			                <td>5</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td>1</td>
			            </tr>
			            <tr>
			                <td class="left">13. 식당등 시설이용 질서 문란</td>
			                <td>1회</td>
							<td>5</td>
			                <td>5</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td>1</td>
			            </tr>
			            <tr>
			                <td class="left">14. 기타 품위유지 위반사항</td>
			                <td>1회</td>
			                <td>10</td>
							<td>10</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			            </tr>
			            </tbody>
			            </table><br />
							<b>[참 고]</b><br />
							1. 1시간미만은  1시간으로 간주하되. 폭설 등 천재지변으로 인한 경우에는 무감점 처리한다.<br />
							2. 동시에 감점내용이 2개 이상인 경우 그 중 높은 것을 적용한다. 

                    
                    </li>
                  </ol>
                </li>
              </ul>
			  <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100000" /></jsp:include>
			  <div class="h80"></div>
			  
              <!--입교안내 마감-->
            <!-- //contnet -->
          </div>
        </div>
    </div>
    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>