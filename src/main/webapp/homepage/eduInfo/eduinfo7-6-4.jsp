<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left6.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual6">인재원 소개</div>
            <div class="local">
              <h2>시설현황</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; 시설현황 &gt; <span>시설대관 안내</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			
            <ol class="TabSub">
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6');">시설개요</a></li>
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-2');">층별안내</a></li>
            <!-- li><a href="javascript:fnGoMenu('7','eduinfo7-6-3');">편의시설</a></li -->
            <li class="TabOn"><a href="javascript:fnGoMenu('7','eduinfo7-6-4');">시설대관안내</a></li>
          </ol>
			  <form id="pform" name="pform" method="post">
			  <div id="content">

			 <div class="h15"></div>
			<!-- title --> 
<br/>
			<h3>대관기준</h3>
			<ul class="txtType03">
				<li>
					<span class="dcon">본 시설은 교육ㆍ연구시설로 교육에 지장을 주지 않는 범위 내에서 대관</span>
				</li>
			</ul><br/>

			<h3>대관시설</h3>

			<ul class="txtType03">
				<li>
					<span class="dtt">- 교육시설 :</span>
					<span class="dcon">강의실, 강당&lt;전화예약&gt;</span>
				</li>
				<li>
					<span class="dtt">- 체육시설 :</span>
					<span class="dcon">체육관, 운동장(축구제외), 테니스장</span>
				</li>
				<li>
					<span class="dtt">- 숙박시설 :</span>
					<span class="dcon">생활관(28실 93명 수용)&lt;전화예약&gt;</span>
				</li>
				<li>
					<span class="dtt">- 생활관 부대시설 :</span>
					<span class="dcon">
						세미나실 1실, 분임토의실 6실&lt;전화예약&gt;<br />
					</span>
				</li>
				<li>
					<span class="dtt">※ 무료 : </span>
					<span class="dcon">자료실, 독서실
						<br />
					</span>
				</li>
			</ul>
            <br />    
			<h3>사용료</h3>
			<!-- //title -->
			<div class="h5"></div>
			<!-- data -->
			<table class="dataH07">	
			<colgroup>
				<col width="80" />
				<col width="80" />
				<col width="80" />
				<col width="95" />
				<col width="85" />
				<col width="250" />
			</colgroup>

			<thead>
			<tr>
				<th class="bl0" rowspan="2">시설명</th>
				<th rowspan="2">시설구분</th>
				<th rowspan="2">사용기준</th>
				<th colspan="2">사용료</th>
				<th rowspan="2">비 고</th>
			</tr>
				<th width="95">기준시간전까지</th><th width="85">기준시간<br>초과시</th>
			</thead>
			
			<tbody>
			<tr>
				<td rowspan="2">생활관</td>
				<td>1인실</td>
				<td rowspan="2">1인1박</td>
				<td colspan="2">60,000원</td>
				<td rowspan="5">※ 냉ㆍ난방사용료 별도<br />※ 시설 사용료는 부가가치세 별도</td>
			</tr>
			<tr>
				<td>3,4인실</td>
				<td colspan="2">15,000원</td>
			</tr>
			<tr>
				<td>강    당</td>
				<td>-</td>
				<td>4시간</td>
				<td width="60">70,000원</td>
				<td width="60">1시간당<br>17,500원</td>
			</tr>
			<tr>
				<td rowspan="2">강 의 실</td>
				<td>50석이상</td>
				<td rowspan="2">4시간</td>
				<td width="60">30,000원</td>
				<td width="60">1시간당<br>7,500원</td>
			</tr>
			<tr>
				<td>50석미만</td>
				<td width="60">20,000원</td>
				<td width="60">1시간당<br>5,000원</td>
			</tr>
			<tr>
				<td rowspan="6">체육시설</td>
				<td rowspan="2">운 동 장</td>
				<td >1일</td>
				<td width="60">200,000원</td>
				<td rowspan="2" width="60">1시간당<br>25,000원</td>
				<td rowspan="2">1면 6,400㎡<br />※ 시설 사용료는 부가가치세 별도</td>
			</tr>
			<tr>
				<td>4시간</td>
				<td width="60">100,000원</td>
			</tr>
			<tr>
				
				<td>테니스장</td>
				<td>1면1시간</td>
				<td colspan="2">5,000원</td>
				<td>2면<br />※ 시설 사용료는 부가가치세 별도</td>
			</tr>
			<tr>
				
				<td rowspan="2">체 육 관</td>
				<td>1일</td>
				<td width="60">120,000원</td>
				<td rowspan="2" width="60">1시간당<br>15,000원</td>
				<td rowspan="2">1동 2,760㎡<br />※ 시설 사용료는 부가가치세 별도</td>
			</tr>
			<tr>
				<td>4시간</td>
				<td width="60">60,000원</td>
			</tr>
			</tbody>
			</table>
			<div class="space"></div><br/>
			<h3>사용료 계산</h3>
			<ul class="txtType03">
				<ul>
					<li>- 사용기준시간 미만은 기준시간으로 계산</li> 
					<li>- 사용시간 초과시 1시간당 사용료 가산, 다만 1시간 미만은 1시간으로 보며<br>&nbsp;&nbsp;체육시설의 경우 오전 사용자가 13:00을 초과하여 사용한 때는 1일 사용 기준에 따른 사용료로 계산한다</li> 
					<li>- 체육시설 사용시간</li> 
					<li>&nbsp;&nbsp;ㆍ1일 : 08:00 ~ 17:00</li> 
					<li>&nbsp;&nbsp;ㆍ4시간 : 오전 4시간, 오후 4시간</li> 
					<li>&nbsp;&nbsp;&nbsp;(다만, 테니스장은 08:00 ~ 17:00 중 1시간 단위로 사용할 수 있다.</li> 
					<li>- 냉ㆍ난방사용료 : 에너지사용량 X 요금단가</li> 
				</ul>
			</ul>
			
			<!-- //data --> 
			<div class="space"></div>

			<!-- title --> 
			<div class="h9"></div><br/>
			<h3>신청방법</h3>
			<!-- //title -->
			<div class="h5"></div>
			<ul class="txtType03">
				<li><span class="gry" style="font-weight: bold; font-size: 16px; margin-bottom: 8px;">○ 체육관, 운동장, 테니스장 대관</span></li>
				<li><a target="_blank" href="http://reserve.incheon.go.kr/resve/rent/list.do?srchResveInsttCd=41" style="font-weight: bold; font-size: 14px; color: red;  margin-left:10px; margin-top:5px;">☞  온라인 예약시스템 바로가기</a></li>
				<li><a href="javascript:applydown();" style="font-weight: bold; font-size: 14px; color: red; margin-left:10px; margin-top:5px;">☞ 시설사용허가신청서(양식) 다운로드</a>
				<script>
				function applydown(){
					location.href = "/down/시설대관신청양식.hwp";
				}
				</script>
				</li>
				<li></li>
				<li><span class="gry" style="font-weight: bold; font-size: 16px; margin-bottom: 8px;">○ 생활관, 강당, 강의실 대관</span></li>
				<li><span class="gry"><b>- 신청방법</b> : 전화예약</span></li>
				<li><a href="javascript:applydown();" style="font-weight: bold; font-size: 14px; color: red; margin-left:10px; margin-top:5px;">☞ 시설사용허가신청서(양식) 다운로드</a>
				<script>
				function applydown(){
					location.href = "/down/시설대관신청양식.hwp";
				}
				</script>
				</li>
				<!-- li>※ 운동장의 경우 인터넷 접수에 한함</li -->  
				<li></li>
				<li></li>
				<li><span class="gry">&nbsp;<b>- 신청절차</b></span></li>
					<ul class="txtType03" >
						<li class="org">1. 전화로 시설이용 가능여부 확인</li> 
						<li class="org">2. 대관신청서 작성(방문,유선,팩스,인터넷)</li> 
						<li class="org">3. 시설사용허가(주의사항 안내)</li> 
						<li class="org">4. 사용료 계좌입금</li> 
						<li class="org">5. 대관시설이용(사용후 시설청소)</li>
					</ul>
					<br/>
				<li>
				
					<span class="dttN"><b>- 신청문의</b> :</span>
					<span class="dcon">
						전화 - 교육지원과 시설관리팀 (☎ 032-440-7633) <br />
						FAX - 교육지원과 시설관리팀 (☎ 032-440-8795) 
					</span>
				</li>
			</ul>
			<div class="space"></div>
			<!-- title --> <br/>
			<h3>시설물 대관 신청시 제한사항</h3>
			<!-- //title -->
			<div class="h5"></div>
			<ul class="txtType03">
                <li>- 본 시설물은 공무원 교육시설로 교육일정에 따라 대관 신청 제한 가능</li>
				<li>- 개인별로 1개월에 1회에 한하여 신청가능</li> 
				<li>- 신청시기는 사용예정일로부터 7일 이전에 신청</li> 
				<li>- 시설물 내에서 취사ㆍ음주 흡연 금지</li> 
				<li>- 우천시 운동장, 테니스장 시설을 대관 취소(사용료 전액 반환)</li> 
				<li>- 신청자가 중복될 경우 우선 신청자에게 우선권 부여</li> 
				<li>- 시설물 사용후 발생한 쓰레기는 전량 수거 및 회수</li> 
				<li>- 시설물 사용시 지정된 장소에 주차하여야 하며, 사용료는 사용예정일로부터 7일 이전에 납부</li> 
                <li>- 체육관 이용시 반드시 실내운동화 착용, 불 이행시 입장불가(마루바닥 보호)</li>
			</ul>	
            <div class="space"></div>

			<!-- title --> <br/>
			<h3>시설물 대관 취소</h3>
			<!-- //title -->
			<div class="h5"></div>
			<ul class="txtType03">
				<li>- 이 조례 또는 시설관리상 필요한 지시사항을 위반한 경우</li> 
				<li>- 사용허가 이외의 목적으로 사용하거나 사용료를 납부하지 아니한 경우</li> 
				<li>- 천재지변, 기타 불가항력의 사유로 시설의 사용이 불가능할 경우</li> 
				<li>- 허위 또는 부정한 방법으로 시설 사용허가를 받은 경우</li> 
				<li>- 기타 공익목적 수행상 원장이 필요하다고 인정될 경우</li> 
			</ul>	

			<div class="space"></div>


			<!-- title --> <br/>
			<h3>사용료 반환</h3>
			<!-- //title -->
			<div class="h5"></div>
			<ul class="txtType03">
				<li>- 납부된 사용료는 반환하지 아니하며,</li> 
				<li>- 사용예정일 5일전에 취소하는 경우 : 전액반환</li> 
				<li>- 사용예정일 1일전에 취소하는 경우 : 90% 반환</li> 
			</ul>	

			<div class="space"></div>


		</div>



			  </form>
              <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100038" /></jsp:include>
              <div class="h80"></div>   
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>