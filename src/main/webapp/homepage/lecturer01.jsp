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
						<li><img src='/images/skin4/sub/lecturer_step01_on.gif'alt="강사신청 1단계"></li>
						<li><img src='/images/skin4/sub/lecturer_step02.gif' alt="강사신청 2단계"></li>
						<li><img src='/images/skin4/sub/lecturer_step03.gif' alt="강사신청 3단계"></li>
						<li><img src='/images/skin4/sub/lecturer_step04.gif' alt="강사신청 4단계"></li>
					</ul>
				</div>
				<div class="h30"></div>
				<p class="sub_img_left"><img src="/images/skin4/sub/lecturer_text01.gif" alt="안녕하십니까 인천시 인재개발원니다."></p>
				<p class="mb15">인천시 인재개발원에서는 전문행정인 양성에 기여할 <em>유능한 일반 강사 분을 찾고</em> 있습니다.<br/>
				<em>경력, 출강현황 등 개인 프로필을 등록</em>하시면 자체 심사를 거쳐 출강 강사 POOL 구성 시 반영도록 하겠습니다.</p>
				<p class="mb15">인천시 직원을 대상으로 교육을 운영함으로써 인천시 인재양성을 위한 교육훈련 목표 달성에 기여하고자 합니다.<br/>
				유능한 일반 강사 분들의 적극적인 참여와 등록 환영합니다.</p>
				<div class="h30"></div>
				<p class="sub_img"><a href="javascript:goPage();"><img src="/images/skin4/sub/btn_lecturer01.gif" alt="강사등록입력"></a></p>
			</div>
            <!-- //contnet -->
          </div>
        </div>
	</div>
	<form id="pform" name="pform" method="post" action="/homepage/lecturer.do">
		<input type="hidden" name="mode"		value='lecturer2' />
	</form>
    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>
<script language = "javascript"> 
	function goPage() {
		$("pform").submit();
	}
</script>