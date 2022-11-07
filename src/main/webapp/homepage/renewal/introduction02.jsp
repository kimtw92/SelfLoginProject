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
              <h2>비전 및 목표</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; <span>비전 및 목표</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
              <!-- 조직 및 업무 시작 -->
              <h3>비전 및 목표</h3>
                  <img src="/homepage_new/images/contents/ct_008.gif" alt="비전 및 목표">

	<!-- 조직 및 업무 마감 -->
			<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100032" /></jsp:include>
            <!-- //contnet -->
			<div class="h80"></div>
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>