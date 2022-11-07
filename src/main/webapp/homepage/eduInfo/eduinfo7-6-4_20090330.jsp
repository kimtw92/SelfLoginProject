<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 
// date		: 2008-08-28
// auth 	: 양정환
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
				<jsp:param name="topMenu" value="7" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="6" />
					<jsp:param name="leftIndex" value="6" />
					<jsp:param name="leftSubIndex" value="4" />
				</jsp:include>
				<!--[e] left -->
				

	<!-- contentOut s ===================== -->
	<div id="subContentArear">
		<!-- content image -->
		<div id="contImg"><img src="/images/skin1/sub/img_cont05.gif" alt="개발원소개" /></div>
		<!-- //content image -->

		<!-- title/location -->
		<div id="top_title">
			<h1 id="title"><img src="/images/skin1/title/tit_0506.gif" alt="시설현황" /></h1>
			<div id="location">
			<ul> 
				<li class="home"><a href="">HOME</a></li>
				<li>개발원소개</li>
				<li class="on">시설현황</li>
			</ul>
			</div>
		</div>
		<!-- title/location -->
		<div class="spaceTop"></div>

		<!-- content s ===================== -->
		<div id="content">
			<!-- title --> 
			<h2 class="h2Ltxt"><img src="/images/skin1/title/tit_050601.gif" alt="시설대여안내" /></h2>
			<!-- //title -->
			<div class="space"></div>

			<!-- title --> 
			<h3 class="h3hyp"><img src="/images/skin1/title/tit_05060101.gif" alt="대여시설" /></h3>
			<!-- //title -->
			<div class="h9"></div>
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

			<!-- title --> 
			<h3 class="h3hyp"><img src="/images/skin1/title/tit_05060102.gif" alt="이용범위" /></h3>
			<!-- //title -->
			<div class="h9"></div>
			<ul class="txtType03">
				<li class="org">유료</li> 
				<li class="org">숙박시설, 부대시설 : 인천시청, 시산하기관 및 공공단체</li> 
				<li class="org">체육시설, 교육시설 : 일반시민, 인천시청, 시산하기관 및 공공단체</li> 
				<li class="org">무료</li> 
				<li class="org">도서실, 독서실, 족구장 (학생 외 일반시민에 한함) </li>
			</ul>
			<div class="space"></div>

			<!-- title --> 
			<h3 class="h3hyp"><img src="/images/skin1/title/tit_05060103.gif" alt="이용요금" /></h3>
			<!-- //title -->
			<div class="h9"></div>
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
				<td class="left" rowspan="7">
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
				<td>4,000원</td>
			</tr>
			</tbody>
			</table>
			<!-- //data --> 
			<div class="space"></div>

			<!-- title --> 
			<h3 class="h3hyp"><img src="/images/skin1/title/tit_05060104.gif" alt="신청방법" /></h3>
			<!-- //title -->
			<div class="h9"></div>
			<ul class="txtType03">
				<li>시 홈페이지(공익 시설개방시스템), 방문 또는 공문 접수</li> 
				<li><a href="/down/apply.hwp" class="blu">시설대여신청양식 다운로드</a> <span class="gry">(click 하세요)</span></li>
				<li>
					<span class="dttN">신청문의 :</span>
					<span class="dcon">
						전화-서무과 관리팀 (☎032-440-7632) <br />
						FAX - 서무과 관리팀 (☎ 032-440-7629) 
					</span>
				</li>
			</ul>	
			<div class="space"></div>
			<!-- title --> 
			<h3 class="h3hyp"><img src="/images/skin1/title/tit_05060105.gif" alt="사용료 반환" /></h3>
			<!-- //title -->
			<div class="h9"></div>
			<ul class="txtType03">
				<li>납부된 사용료는 반환하지 아니하며,</li> 
				<li>취소일이 사용예정일로부터 7일 이상 - 납부된 사용료의 20% 공제 금액</li> 
				<li>취소일이 사용예정일로부터 7일 미만 - 납부된 사용료의 50% 공제 금액</li> 
			</ul>	

			<div class="space"></div>

			<img src="/images/skin1/sub/txt_txtInfo01.gif" class="ml15" alt="시설대여 담당 : 서무과 관리팀 032-440-7632" />

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