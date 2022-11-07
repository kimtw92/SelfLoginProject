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
          <div class="sub_visual6">인재개발원 소개</div>
            <div class="local">
              <h2>시설현황</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; 시설현황 &gt; <span>시설개요</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<ol class="TabSub">
            <li class="TabOn"><a href="javascript:fnGoMenu('7','eduinfo7-6');">시설개요</a></li>
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-2');">층별안내</a></li>
            <!-- li><a href="javascript:fnGoMenu('7','eduinfo7-6-3');">편의시설</a></li -->
            <li class="last"><a href="javascript:fnGoMenu('7','eduinfo7-6-4');">시설대관안내</a></li>
           <!-- <li><a href="javascript:fnGoMenu('7','reservation');"  onclick="alert('1. 시설 대여 안내 [신청 절차] 확인 바랍니다. \n - 유선상 예약가능 여부 확인 필요 (☏ 032-440-7632) \n\n2. 예약 후 [최종 승인]이 되어야 시설 사용이 가능합니다. \n - 유선상 미확인 신청시 최종 승인 불가 할수 있음 \n\n ※ 본 시설은 교육시설로서 교육(시,군구 행사 포함) 일정 \n및 교육에 지장없는 범위 내에서 시민에게 개방하고 있어 \n타 대관시설에 비해 제약이 있을 수 있습니다.');">시설대여신청</a></li>
            <li><a href="javascript:fnGoMenu('7','reservationConfirm');">시설대여예약확인</a></li>
            <li class="last"><a href="javascript:fnGoMenu('7','reservationSurvey');">시설대여설문</a></li> --> 
          </ol>
            
			  <form id="pform" name="pform" method="post">
			  <div id="content">
            <div class="h15"></div>

            <h3>본관</h3>
            <br/>
			<table class="dataH07"> 
            <colgroup>
            <col width="" />
            <col width="" />
            <col width="" />
            <col width="" />
            </colgroup>

            <thead>
            <tr>
                <th class="t04">강당</th>
                <th class="t04">강의실</th>
                <th class="t04">전산실습실</th>
                <th class="t04">자료실</th>
                <th class="t04">독서실</th>
            </thead>
            <tbody>
            <tr>
                <td>1실(476석)</td>
                <td>5실<br/>(90석*2실, 50석*2실, 40석*1실)</td>
                <td>2실(50석*2실)</td>
                <td>14,000여권소장<br/>(139㎡)</td>
                <td>48석<br/>(139㎡)</td>
            </tr>
            </tbody>
            </table>
<br/>  

			<p style="font-size: 1.0em; font-weight: bold;"> ※ 자료실 이용 안내<p>
			<p>&nbsp;&nbsp; - 신분증 제시하고 회원등록 한자에 대하여 1회 3권이내 대출</p>
			<p>&nbsp;&nbsp; - 대출기간 : 7일 이내(1회에 한해 7일 연장 가능)</p>
  
<br/>
            <h3>양지관</h3>
<br/>  
			<table class="dataH07"> 
            <colgroup>
            <col width="150" />
            <col width="471" />
            </colgroup>

            <thead>
            <tr>
                <th class="t04">양지관</th>
            </thead>

            <tbody>
            <tr>
                <td class="sbj">ㆍ객실 : 28실, 93명 수용(1인실 3개, 3인실 10개, 4인실 14개, 장애인실(4인) 1개)<br/>
				ㆍ세미나실 : 1실 (40석)<br/>
				ㆍ분임토의실 : 2실 (15석)</td>
            </tr>
            </tbody>
            </table>

            <div class="h25"></div>



            <!-- title --> 
			<h3>시설배치도</h3>
            <!-- //title -->
            <div class="h15"></div>
			<!-- 조직도image -->
			<img src="/images/<%= skinDir %>/sub/img_eqPlan.gif" usemap="#Map1" alt="" />
			<!-- //조직도image --> 

		</div>


			  </form>
              <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100038" /></jsp:include>
              <div class="h80"></div>        
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>