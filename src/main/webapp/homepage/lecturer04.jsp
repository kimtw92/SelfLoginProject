<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr"%>
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
			<h2>강사등록</h2>
			<div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 홈페이지 이용안내 &gt; <span>강사등록</span></div>
		</div>
		<div class="contnets">
			<!-- contnet -->
			<div id="content">
				<div class="lecturer_tab01">
					<ul>
						<li><img src='/images/skin4/sub/lecturer_step01.gif'alt="강사신청 1단계"></li>
						<li><img src='/images/skin4/sub/lecturer_step02.gif' alt="강사신청 2단계"></li>
						<li><img src='/images/skin4/sub/lecturer_step03.gif' alt="강사신청 3단계"></li>
						<li><img src='/images/skin4/sub/lecturer_step04_on.gif' alt="강사신청 4단계"></li>
					</ul>
				</div>
				<div class="h30"></div>
				<p class="sub_img_left"><img src="/images/skin4/sub/lecturer_text01.gif" alt="안녕하십니까 인천시 인재개발원니다."></p>
				<p class="mb15">강사등록완료</p>
				<div class="h30"></div>
			</div>
			<!-- //contnet -->
		</div>
	</div>
</div>
<jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>