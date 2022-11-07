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
              <h2>이메일 무단수집거부</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 홈페이지 이용안내 &gt; <span>이메일 무단수집거부</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
<div id="content">
            <div class="rGrySet01">
                <div class="rGry01"><map name="go_url">
					<map name="go_url">
					<!-- <area alt="불법스팸대응센터 바로가기" coords="195,77,368,103" href="http://www.spamcop.or.kr/spamcop.html" target="_blank"> -->
					<area alt="불법스팸대응센터 바로가기" coords="195,77,368,103" href="http://spam.kisa.or.kr/integration/main.do" target="_blank">
					</map>
					<img src="../../../images/skin1/sub/img_email.gif" width="539" height="109" border="0" usemap="#go_url" alt="이메일"/></div>
            </div>
            

		
		</div>     
              <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100043" /></jsp:include>
			  <div class="h80"></div>
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>