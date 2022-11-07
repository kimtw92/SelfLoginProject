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
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; 시설현황 &gt; <span>시설대여 안내</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			
            <ol class="TabSub">
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6');">시설개요</a></li>
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-2');">층별안내</a></li>
            <!-- li class="TabOn"><a href="javascript:fnGoMenu('7','eduinfo7-6-3');">편의시설</a></li -->
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-4');">시설대여안내</a></li>
            <li><a href="javascript:fnGoMenu('7','reservation');"  onclick="alert('1. 시설 대여 안내 [신청 절차] 확인 바랍니다. \n - 유선상 예약가능 여부 확인 필요 (☏ 032-440-7632) \n\n2. 예약 후 [최종 승인]이 되어야 시설 사용이 가능합니다. \n - 유선상 미확인 신청시 최종 승인 불가 할수 있음 \n\n ※ 본 시설은 교육시설로서 교육(시,군구 행사 포함) 일정 \n및 교육에 지장없는 범위 내에서 시민에게 개방하고 있어 \n타 대관시설에 비해 제약이 있을 수 있습니다.');">시설대여신청</a></li>
            <li class="last"><a href="javascript:fnGoMenu('7','reservationConfirm');">시설대여예약확인</a></li>
          </ol>
			  <form id="pform" name="pform" method="post">
			  <div id="content">

			 <div class="h15"></div>
			<!-- title --> 
			<h3>대여시설</h3>
			<!-- //title -->
			<div class="h5"></div>
			<ul class="txtType03">
				<li>
					<span class="dtt">교육시설 :</span>
					<span class="dcon">강의실</span>
				</li>
				<li>
					<span class="dtt">체육시설 :</span>
					<span class="dcon">체육관, 잔디구장, 족구장, 테니스장</span>
				</li>
				<li>
					<span class="dtt">숙박시설 :</span>
					<span class="dcon">양지관(28실 93명 수용)</span>
				</li>
				<li>
					<span class="dtt">양지관 부대시설 :</span>
					<span class="dcon">
						세미나실 1실, 분임토의실 4실, 회의실 1실<br />
					</span>
				</li>
			</ul>
			<div class="space"></div>
			<div class="h9"></div>

			<!-- title --> 
			<h3>신청기간 : 연중</h3>
			<!-- //title -->
			<div class="h5"></div>
			<ul class="txtType03">
				<li class="org">제외대상</li> 
				<li class="org">- 잔디구장 : 매년 5월 ~ 10월</li> 
				<li class="org">- 체 육 관 : 매년 2월 ~ 11월</li> 
			</ul>
			<div class="space"></div>

			<!-- title --> 
			<h3>이용범위</h3>
			<!-- //title -->
			<div class="h5"></div>
			<ul class="txtType03">
				<li class="org2">유료</li> 
				<li class="org">숙박시설, 부대시설 : 인천시청, 시산하기관 및 공공단체</li> 
				<li class="org">체육시설, 교육시설 : 일반시민, 인천시청, 시산하기관 및 공공단체</li> 
				<br/>
				<li class="org2">무료</li> 
				<li class="org">자료실, 독서실, 족구장 (학생 외 일반시민에 한함) </li>
			</ul>
			<div class="space"></div>

			<!-- title --> 
			<h3>이용요금</h3>
			<!-- //title -->
			<div class="h5"></div>
			<!-- data -->
			<table class="dataH07">	
			<colgroup>
				<col width="80" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="250" />
			</colgroup>

			<thead>
			<tr>
				<th class="bl0">시설명</th>
				<th>시설구분</th>
				<th>사용기준</th>
				<th>사용료</th>
				<th>비 고</th>
			</tr>
			</thead>

			<tbody>
			<tr>
				<td rowspan="4">양지관</td>
				<td>1인 : 1실</td>
				<td rowspan="2">1실 1박(1실당)</td>
				<td>60,000원</td>
				<td class="left" rowspan="11">
					<ul class="txtType03">
						<li><br />※ 3,4인은 합숙을 원칙으로 함</li>
						<li><br />☎ 관리팀 032-440-7632</li>
					</ul>
				</td>
			</tr>
			<tr>
				<td>2인 : 1실</td>
				<td>40,000원</td>
			</tr>
			<tr>
				<td>3인 : 1실</td>
				<td rowspan="2">1실 1박(1인당)</td>
				<td>10,000원</td>
			</tr>
			<tr>
				<td>4인 : 1실</td>
				<td>10,000원</td>
			</tr>
			<tr>
				<td rowspan="2">강의실</td>
				<td>100석</td>
				<td rowspan="2">4시간</td>
				<td>30,000원</td>
			</tr>
			<tr>
				<td>50석이하</td>
				<td>20,000원</td>
			</tr>
			<tr>
				<td>테니스장</td>
				<td>2면</td>
				<td>1인 4시간</td>
				<td>2,000원</td>
			</tr>
			<tr>
				<td rowspan="2">잔디구장</td>
				<td rowspan="2"></td>
				<td>1인 1박</td>
				<td>100,000원</td>	
			</tr>
			<tr>
				<td>1인 4시간</td>
				<td>40,000원</td>	
			</tr>
			<tr>
				<td rowspan="2">체육관</td>
				<td rowspan="2"></td>
				<td>1인 1박</td>
				<td>100,000원</td>	
			</tr>
			<tr>
				<td>1인 4시간</td>
				<td>40,000원</td>
			</tr>			
			</tbody>
			</table>
			<!-- //data --> 
			<div class="space"></div>

			<!-- title --> 
			<div class="h9"></div>
			<h3>신청방법</h3>
			<!-- //title -->
			<div class="h5"></div>
			<ul class="txtType03">
			<li><span class="gry">○ 신청방법 : 방문, 유선, 팩스</span></li>
				<li><a href="/down/apply.hwp" class="blu">시설대여신청양식 다운로드</a> <span class="gry">(click 하세요)</span></li>
				<li>※ 잔디구장, 테니스장의 경우 인터넷 접수에 한함</li> 
				<br/>
				<li><span class="gry">○ 신청절차</span></li>
					<ul class="txtType04">
						<li class="org">1. 전화로 시설이용(가능여부 확인)</li> 
						<li class="org">2. 대관신청서 작성(방문, 유선,팩스)</li> 
						<li class="org">3. 시설사용승인(주의사항 안내)</li> 
						<li class="org">4. 사용료 계좌입금</li> 
						<li class="org">5. 승인서 교부</li> 
						<li class="org">6. 대관시설이용(사용후 시설청소)</li>
					</ul>
					<br/>
				<li>
				
					<span class="dttN">○ 신청문의 :</span>
					<span class="dcon">
						전화 - 교육지원과 관리팀 (☎032-440-7632) <br />
						FAX - 교육지원과 관리팀 (☎ 032-440-8795) 
					</span>
				</li>
			</ul>
			<div class="space"></div>
			<!-- title --> 
			<h3>시설물 대여 신청시 제한사항</h3>
			<!-- //title -->
			<div class="h5"></div>
			<ul class="txtType03">
				<li>ㆍ개인별로 1개월에 1회에 한하여 신청가능</li> 
				<li>ㆍ신청시기는 신청일로부터 다음달 말일까지로 제한됨 (신청접수 : 매월 1일 09:00부터)</li> 
				<li>ㆍ시설물 내에서 취사ㆍ음주 금지</li> 
				<li>ㆍ우천시 사용이 취소됨 (사용료 전액 반환)</li> 
				<li>ㆍ신청자가 중복될 경우 우선 신청자에게 우선권 부여</li> 

			</ul>	
			<div class="space"></div>
			<!-- title --> 
			<h3>사용료 반환</h3>
			<!-- //title -->
			<div class="h5"></div>
			<ul class="txtType03">
				<li>납부된 사용료는 반환하지 아니하며,</li> 
				<li>사용예정일 5일전에 취소하는 경우 : 전액반환</li> 
				<li>사용예정일 1일전에 취소하는 경우 : 90% 반환</li> 
			</ul>	

			<div class="space"></div>

			<img src="/images/skin1/sub/txt_txtInfo01.gif" class="ml15" alt="시설대여 담당 : 서무과 관리팀 032-440-7632" />

		</div>



			  </form>
              <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100038" /></jsp:include>
              <div class="h80"></div>   
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>