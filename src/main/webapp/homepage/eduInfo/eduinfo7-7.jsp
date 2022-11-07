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
              <h2>찾아오시는길</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 홈페이지 이용안내 &gt; <span>찾아오시는길</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            <div id="content">
			<!-- title --> 
			<h3>안내지도</h3>
			<!-- //title -->
			<div class="h9"></div>
			<!-- data -->
			
			
			<img src="http://hrd.incheon.go.kr/images/map_10.jpg" alt="안내지도" />
			<!-- <iframe width="670px" height="441"  src ="http://map.naver.com/?menu=location&mapMode=0&lat=37.5405558&lng=126.6794486&dlevel=11&rpanel=n-f&enc=b64" frameborder=0> </iframe> -->
			
			<!-- <table cellpadding="0" cellspacing="0" width="670"> <tr> <td style="border:1px solid #cecece;"><a href="http://map.naver.com/?menu=location&mapMode=0&lat=37.5417041&lng=126.6812698&dlevel=10&rpanel=n-f&enc=b64" target="_blank"><img src="http://prt.map.naver.com/mashupmap/print?key=p1468312584872_-1708523940" width="670" height="441" alt="지도 크게 보기" title="지도 크게 보기" border="0" style="vertical-align:top;"/></a></td> </tr> <tr> <td>  <table cellpadding="0" cellspacing="0" width="100%">  <tr>  
			<td height="30" bgcolor="#f9f9f9" align="left" style="padding-left:9px; border-left:1px solid #cecece; border-bottom:1px solid #cecece;">   <span style="font-family: tahoma; font-size: 11px; color:#666;">2016.7.12</span>&nbsp;<span style="font-size: 11px; color:#e5e5e5;">|</span>&nbsp;<a style="font-family: dotum,sans-serif; font-size: 11px; color:#666; text-decoration: none; letter-spacing: -1px;" href="http://map.naver.com/?menu=location&mapMode=0&lat=37.5417041&lng=126.6812698&dlevel=10&rpanel=n-f&enc=b64" target="_blank">지도 크게 보기</a>  </td>  <td width="98" bgcolor="#f9f9f9" align="right" style="text-align:right; padding-right:9px; border-right:1px solid #cecece; border-bottom:1px solid #cecece;">   <span style="float:right;"><span style="font-size:9px; font-family:Verdana, sans-serif; color:#444;">&copy;&nbsp;</span>&nbsp;<a style="font-family:tahoma; font-size:9px; font-weight:bold; color:#2db400; text-decoration:none;" href="http://www.nhncorp.com" target="_blank">NAVER Corp.</a></span>  </td>  </tr>  </table> 
			</td> </tr>  </table> -->
			
			
			
			<!-- //data --> 
			<div class="space"></div>
			<br/>
			<!-- title --> 
			<h3>교통안내</h3>
			<!-- //title -->
			<div class="h9"></div>
			<!-- data -->
			<table class="dataW04">
				<tr>
					<th width="120" class="t03">주소</th>
					<td colspan="2">22711 인천광역시 서구 심곡로 98</td>
				</tr>
				<tr>
					<th rowspan="11" class="t03">교통편</th>
					<td class="cent" rowspan="3">버스</td>
					<td>
						<h6 class="con6">인재개발원앞 하차</h3>
						<ul class="txtL">
							<li>1번 왕길동기점  ~ 인천성모병원</li>
							<li>66번 안동포기점 ~ 송정역</li>
							<li>84번 석남동 차고지 ~ 구정슈퍼앞</li>
							<li>595번 청라우미린 ~ 검암역</li>
						</ul>
					</td>
				</tr>
				<tr>
					<td>
						<h6 class="con6">서인천농협 하차</h3>
						<ul class="txtL">							
							<li>592번 신영자동차 ~ 간석오거리역</li>
							<li>595번 청라우미린 ~ 검암역</li>
						</ul>
					</td> 
				</tr>
				<tr>
					<td>
						<h6 class="con6">인재개발원 입구 하차</h3>
						<ul class="txtL">
							<li>1번 왕길동기점  ~ 인천성모병원</li>
							<li>66번 안돋포기점 ~ 송정역</li>
							<li>84번 석남동 차고지 ~ 구정슈퍼앞</li>
							<li>592번 신영자동차 ~ 간석오거리역</li>
							<li>595번 청라우미린 ~ 검암역</li>
							
						</ul>
					</td>
				</tr>
				
				<tr>
					<td class="cent">지하철</td>
					<td>
						<ul class="txtL">
						    <li>인천지하철 2호선 <font color="blue">서구청역 2번 출구</font>에서 도보로 450m 이동</li>
							<li>인천지하철 1호선 부평구청역 8번 출구에서 1번 버스 이용</li>
						</ul>
					</td>
				</tr>
			
				<tr>
					<td class="cent" rowspan="2">자가용</td>
					<td>
						<h6 class="con6">경인고속도로를 이용할 경우</h3>
						<ul class="txtL">
							<li>서인천 IC에서 김포, 강화방향 -> 심곡4거리 우회전 -> 인재개발원</li>
						</ul>
					</td>
				</tr>
				<tr>
					<td>
						<h6 class="con6">외곽순환도로를 이용할 경우</h3>
						<ul class="txtL">
							<li>1. 계양 IC 에서 공항방향 -> 공촌3거리 좌회전 -> 인재개발원</li>
							<li>2. 서운분기점에서 경인고속도로 이용</li>
						</ul>   
					</td>
				</tr>
			</table>
			<!-- //data --> 
			<br/>
			<div class="space"></div>

			<!-- title --> 
			<h3>교육생주차안내</h3>
			<!-- //title -->
			<div class="h9"></div>

			<ul class="info01">
				<li>교육생의 편의를 위하여 주차장 총 128면으로 주차장 이용 편의를 제공하고 있습니다.</li>
				<!-- <li>최근 교육생이 많아 주차장이 매우 혼잡합니다.
					되도록이면 교육원 셔틀버스나 교육생간의 카풀을 이용하시기 바랍니다.</li> -->
			</ul>   


			<div class="h80"></div>
		</div>
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>