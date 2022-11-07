<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
 <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/login/main_login.jsp" flush="false"/>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual1.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>회원가입</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; <span>회원가입</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
              <form id="pform" name="pform" method="post">             
			<div id="subContentArear">
							<div class="spaceTop"></div>
					
							<!-- content s ===================== -->
							<div id="content">
								<p style="margin-bottom: 10px;"><font style="font-size:1.5em;">※ 회원가입시 익스플로러 상단 ‘도구>팝업차단>팝업차단끄기’ 해주세요</font></p>								
								<a href="/homepage/support.do?mode=noticeView&boardId=NOTICE&seq=306">
									<font style="color: blue; font-size:1.5em; margin: 0px 0px 0px 7px;"> - 회원가입 등 웹사이트 오류시 조치방법 안내</font>
								</a>
								<!-- data -->
								<div class="dSchSet01">
								<div class="dSch" style="height:180px;">									
									<font size="4" style="color:#2d85bb;"><b>귀하는 공무원(소방 및 공사.공단 포함) 이십니까?</b></font><br /><br />
									<!-- img src="/images/<%= skinDir %>/sub/txt_que01.gif" class="mb13" alt="귀하는 공무원이십니까?" /><br / -->
									<%-- <font size="3" style="color:black;"><b>(교육청 및 산하기관 타 자치단체 공무원 제외)</b></font><br /><br />
									<img src="/images/<%= skinDir %>/sub/txt_que02.gif" alt="공무원이시면 [예]버튼을 클릭하시고, 공무원이 아니시면 [아니오]버튼을 클릭하세요." /> <br /> --%>

									<!-- button -->
									<div class="btn"> 
										<a href="#">
											<img src="/images/<%= skinDir %>/button/btn_yes02.gif" onClick="window.open('/homepage/join.do?mode=joinstep2', 'pop', 'width=642, height=536, scrollbars=yes');" class="btnL" alt="예" />
										</a>
										<a href="http://www.cyber.incheon.kr/">
											<img src="/images/<%= skinDir %>/button/btn_no01.gif" alt="아니요" />
										</a>
									</div>
									<!-- //button -->
								</div>
								</div>
								<!-- //data -->
							</div>
							<!-- //content e ===================== -->
			
						</div>
			  </form>
	
	<form name="regForm" action="/homepage/join.do">
		<input type="hidden" name="mode">
		
		<!-- 회원가입 타입을 지정하기 위한 값 -->
		<input type="hidden" id="regtype"name="regtype"/>
	
		<input type="hidden" name="username"/>
		
		<!-- regtype : 1 주민등록번호 실명인증 -->
		<input type="hidden" name="ssn1"/>
		
		<!-- regtype : 2 i-Pin 실명인증 -->
		<input type="hidden" id="dupinfo" name="dupinfo"/>
		<input type="hidden" id="virtualno" name="virtualno"/>
		<input type="hidden" id="age" name="age"/>
		<input type="hidden" id="birthdate" name="birthdate"/>
		<input type="hidden" id="nationalinfo" name="nationalinfo"/>
		<input type="hidden" id="authinfo" name="authinfo"/>
	</form>
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>    


    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>