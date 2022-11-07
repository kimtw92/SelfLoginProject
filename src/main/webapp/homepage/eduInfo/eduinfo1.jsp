<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 입교안내
// date		: 2008-08-07
// auth 	: kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>



<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<div id="wrapper">
	<div id="dvwhset">
		<div id="dvwh">
		
			<!--[s] header -->
			<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
				<jsp:param name="topMenu" value="2" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="2" />
					<jsp:param name="leftIndex" value="2" />
				</jsp:include>
				<!--[e] left -->



				<!-- contentOut s ===================== -->
				<div id="subContentArear">
					<!-- content image -->
					<div id="contImg"><img src="/images/<%= skinDir %>/sub/img_cont00.gif" alt="" /></div>
					<!-- //content image -->
			
					<!-- title/location -->
					<div id="top_title">
						<h1 id="title"><img src="/images/<%= skinDir %>/title/tit_0001.gif" alt="입교안내" /></h1>
						<div id="location">
						<ul> 
							<li class="home"><a href="">HOME</a></li>
							<li>교육안내</li>
							<li class="on">입교안내</li>
						</ul>
						</div>
					</div>
					<!-- title/location -->
					<div class="spaceTop"></div>
			
					<!-- content s ===================== -->
					<div id="content">
						<h2 class="h2L"><img src="/images/<%= skinDir %>/title/tit_000101.gif" alt="입교신청" /></h2>
						<div class="h9"></div>	
			
			            <div class="rqTxt">
					            교육대상자 선발은 직급, 직렬, 담당직무, 경력 및 건강상태 등을 고려하여 교육훈련<br /> 
					            과정별 교육목적에 적합한 자를 선발함으로서, 미입교 또는 교육 중 퇴교 등 사고가<br />
					            발생되지 철저히 관리하고 있으며,  신규채용자과정은 최근 임용된 자 순, 기타 과정은<br />
					            해당직급 승진후 않도록 장기관 경과한 자를 우선 선발하고 있습니다.
			            </div>
			            <div class="space01"></div>
			
			            <h3 class="h3V">교육신청절차</h3>
			            <div class="h6"></div>	
			            <div class="rGrySet01">
			                <div class="rGry01">
			                    <ol class="depth1">
			                    <li class="no1">
			                    	교육신청자가 교육원 홈페이지에 온라인 수강신청
			                    </li>
			                    <li class="no2"> 
			                    	소속기관의 교육담당자에게 통보
			                    </li>
			                    <li class="no3"> 
			                    	소속기관장의 1차 승인
			                    </li>
			                    <li class="no4"> 
			                    	교육원장의 최종승인
			                    </li>
			                    </ol>
			                </div>
			            </div>
			            <div class="space01"></div>
			
			            <h3 class="h3V">등록 및 입교 안내</h3>
			            <div class="h6"></div>	
			            <h4 class="h4V1">등록시간 <span class="txt_none">: 교육등록 08:30∼09:00 </span></h4>
			            <ul class="depth1">
			            <li>교과운영 : 09:00∼ 17:00(1일 7시간)</li>
			            <li>등록장소 : 인천광역시지방공무원교육원 본관 1층 로비 (서구 심곡로 168)</li>
			            </ul>
			            <div class="space01"></div>
			            
			            <h4 class="h4V1">준비물</h4>
			            <ul class="depth1">
			            <li>공 통 : 학습도구(필기구 및 노트) </li>
			            <li>합숙과정 : 세면도구, 생활용품, 간소복, 운동복, 운동화 등.</li>
			            </ul>
			            <div class="space01"></div>
			
			            <h4 class="h4V1">교육생 생활안내</h4>
			            <ul class="depth1">
			            <li>부득이한 사유로 결강, 결석 외박을 하고자 할 때에는 사전에 교육운영과(☎ 562-5816) 허가 절차 이행</li>
			            <li>교육기간중 명찰패용, 수료시 반납</li>
			            <li>실내체육관 이용시간 : 점심시간:12~14시, 교육종료후:18:00~20:00</li>
			            <li>교육원 셔틀버스 이용안내 : 오전 08시15분 경인교대역 1번출구 앞</li>
			            <li>
					                교육운영 전반에 대한 도움말씀은 담당 과정장에게 해주시거나 교육원<br />
					                홈페이지(http://hrd.incheon.go.kr) 게시판을 이용하여 주시기 바랍니다.
			            </li>
			            </ul> 
			            <div class="space01"></div>
			
			            <h4 class="h4V1">교육생 준수사항</h4>
			            <ul class="depth1">
			            <li>흡연시 흡연구역준수</li>
			            <li>부득이한 사유이외 지각, 결강, 결석금지</li>
			            <li>강의실내 이동전화 전원 off 또는 진동모드 전환</li>
			            <li>교육생 주차구역내 주차</li>
			            <li>차량 요일제(월:1,6번, 화:2,7번, 수:3,8번, 목:4,9번, 금:5,0번) 준수</li>
			            </ul>
			            <div class="space01"></div>
			
			            <h4 class="h4V1">교육생 생활수칙</h4>
			            <ul class="depth1">
			            <li>1급사고 : 퇴교조치 및 소속기관장에 통보 </li>
			            </ul>
			            <div class="h6"></div>	
			            <div class="rGrySet01">
			                <div class="rGry01">
			                    <ol class="depth1">
			                    <li class="no1">
			                    	무단(결석, 결강, 조퇴, 외출, 외박) 행위 
			                    </li>
			                    <li class="no2"> 
			                    	원내에서의 음주, 도박 절도행위
			                    </li>
			                    <li class="no3"> 
			                    	교육원 비품 및 시설물 고의 또는 중대한 과실로 파손, 분실한 경우 (변상조치 병행)
			                    </li>
			                    <li class="no4"> 
			                    	누적감점이 40점 이상인 자
			                    </li>
			                    </ol>
			                </div>
			            </div>
			            <div class="space01"></div>
			
			            <ul class="depth1">
			            <li>2급 사고 : 감점조치</li>
			            </ul>
			            <div class="h6"></div>	
			            <div class="rGrySet01">
			                <div class="rGry01">
			                    <ol class="depth1">
			                    <li class="no1">
			                    	허가에 의한 결석, 결강, 외출, 외박,  행위 
			                    </li>
			                    <li class="no2"> 
			                    	기타 교육생으로서의 품위 위반 행위(감점기준표 참조)  
			                    </li>
			                    </ol>
			                </div>
			            </div>
			            <div class="space01"></div>
			
			            <h4 class="h4V1">감정기준표</h4>
			            <!-- //data -->
			            <table class="dataH05"> 
			            <colgroup>
			            <col width="45" />
			            <col width="*" />
			            <col width="48" />
			            <col width="48" />
			            <col width="48" />
			            <col width="48" />
			            <col width="48" />
			            <col width="48" />
			            <col width="87" />
			            </colgroup>
			
			            <thead>
			            <tr>
			                <th rowspan="2">구분</th>
			                <th rowspan="2">감정사고내용</th>
			                <th rowspan="2">기준</th>
			                <th colspan="5">감정</th>
			                <th rowspan="2">비고</th>
			            </tr>
			            <tr>
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
			                <td class="sbj">단체생활이 지극히 무질서할 때</td>
			                <td class="bg01">1회</td>
			                <td>20</td>
			                <td>15</td>
			                <td>10</td>
			                <td>5</td>
			                <td>3</td>
			                <td class="bg01" rowspan="3">교육생장의확인<br />서첨부(불응시<br />직권감점)</td>
			            </tr>
			            <tr>
			                <td class="sbj">수업태도가 극히 불량할 때</td>
			                <td class="bg01">회</td>
			                <td>20</td>
			                <td>15</td>
			                <td>10</td>
			                <td>5</td>
			                <td>3</td>
			            </tr>
			            <tr>
			                <td class="sbj">본원 지시에 단체적으로<br />불응한 때</td>
			                <td class="bg01">1회</td>
			                <td>20</td>
			                <td>20</td>
			                <td>15</td>
			                <td>10</td>
			                <td>5</td>
			            </tr>
			            <tr>
			                <td rowspan="2">반별<br />감점</td>
			                <td class="sbj">분임별 공용물,사물정돈<br />및 청소불량</td>
			                <td class="bg01">1일</td>
			                <td>10</td>
			                <td>7</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td class="bg01" rowspan="2">사감의사<br />참고</td>
			            </tr>
			            <tr>
			                <td class="sbj">분임별 생활태도 불량</td>
			                <td class="bg01">1일</td>
			                <td>10</td>
			                <td>7</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			            </tr>
			            <tr>
			                <td rowspan="14">개인<br />감점</td>
			                <td class="sbj">대리서명</td>
			                <td class="bg01">1회</td>
			                <td>20</td>
			                <td>10</td>
			                <td>3</td>
			                <td>5</td>
			                <td>5</td>
			                <td class="bg01">사유서첨부</td>
			            </tr>
			            <tr>
			                <td class="sbj">등록지연,지각</td>
			                <td class="bg01">시간당</td>
			                <td>5</td>
			                <td>5</td>
			                <td>10</td>
			                <td>2</td>
			                <td>1</td>
			                <td class="bg01">3시간 이상 퇴교</td>
			            </tr>
			            <tr>
			                <td class="sbj">허가에 의한 결석,외박<br />(합숙시)</td>
			                <td class="bg01">1회</td>
			                <td>20</td>
			                <td>15</td>
			                <td>8</td>
			                <td>8</td>
			                <td>5</td>
			                <td class="bg01"></td>
			            </tr>
			            <tr>
			                <td class="sbj">허가에 의한 결강,외출,<br />외박,조퇴,지각</td>
			                <td class="bg01">시간당</td>
			                <td>15</td>
			                <td>10</td>
			                <td></td>
			                <td>5</td>
			                <td>3</td>
			                <td class="bg01"></td>
			            </tr>
			            <tr>
			                <td class="sbj">점호,구보,체조,청소,체육,<br />봉사활동등 무단불참</td>
			                <td class="bg01">1회</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td class="bg01">고의적인 경우<br /></td>
			            </tr>
			            <tr>
			                <td class="sbj">교관,강사에 대한 태도<br />불손</td>
			                <td class="bg01">1회</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>1</td>
			                <td class="bg01"></td>
			            </tr>
			            <tr>
			                <td class="sbj">관물훼손 및 파괴</td>
			                <td class="bg01">1회</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>1</td>
			                <td class="bg01"></td>
			            </tr>
			            <tr>
			                <td class="sbj">수업태도 불량<br />(잡담,이석 등)</td>
			                <td class="bg01">1회</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>1</td>
			                <td class="bg01"></td>
			            </tr>
			            <tr>
			                <td class="sbj">허가에 의한 외출,외박후<br />정당한 사유없이 지각귀원</td>
			                <td class="bg01">1회</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>1</td>
			                <td class="bg01"></td>
			            </tr>
			            <tr>
			                <td class="sbj">각종 보고서 제출 지연</td>
			                <td class="bg01">1회</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>1</td>
			                <td class="bg01"></td>
			            </tr>
			            <tr>
			                <td class="sbj">용모,복장 불량</td>
			                <td class="bg01">1회</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td>1</td>
			                <td class="bg01"></td>
			            </tr>
			            <tr>
			                <td class="sbj">낙서 및 지정장소외의 흡연</td>
			                <td class="bg01">1회</td>
			                <td>5/td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td>1</td>
			                <td class="bg01"></td>
			            </tr>
			            <tr>
			                <td class="sbj">식당등 시설이용 질서 문란</td>
			                <td class="bg01">1회</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td>1</td>
			                <td class="bg01"></td>
			            </tr>
			            <tr>
			                <td class="sbj">기타 품위유지 위반사항/td>
			                <td class="bg01">1회</td>
			                <td>10</td>
			                <td>5</td>
			                <td>5</td>
			                <td>3</td>
			                <td>2</td>
			                <td class="bg01"></td>
			            </tr>
			            </tbody>
			            </table>
			            <!-- //data -->
			            <div class="h80"></div>	
					</div>
					<!-- //content e ===================== -->
			
				</div>
				<!-- //contentOut e ===================== -->
				
																								
				<div class="spaceBtt"></div>
			</div>			
		</div>
		
		<div id="divQuickMenu" style="position:absolute; top:10; left:89%; width:90px; height:264px; z-index:1">
			<!--[s] quick -->
			<jsp:include page="/commonInc/include/comQuick.jsp" flush="false"/>
			<!--[e] quick -->
		</div>
	</div>
	<!--[s] footer -->
	<jsp:include page="/commonInc/include/comFoot.jsp" flush="false"/>
	<!--[e] footer -->
</div>

</form>
</body>