<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left6.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual6">인재개발원 소개</div>
            <div class="local">
              <h2>안내동영상</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; <span>안내동영상</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            <div id="content" >
						<div class="space"></div>
						<!-- data -->
						<!-- object id='SeeVideo2003' name='SeeVideo2003' width=380 height=325 classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013' codebase='http://tv.incheon.go.kr/IBService/admin/ActiveX/SVPorsche.cab#version=2,5,33,258'>
							<param name='PortNum' value='5010'>
							<param name='ServerIP' value='media.incheon.go.kr'>
							<param name='ScaleMode' value='0'>
							<param name='CustomLogoOnWhite' value='1'>
							<param name='AccessMode' value='4'>
							<param name='UseFixedServerPort' value='1'>
							<param name='MediaFile' value='시정인재개발원_0722.avi'>
							<param name='AutoPlay' value='1'>
							<param name='CustomLogo' value='/images/media/media_intro.jpg'>
							<param name='CustomLogoOnWhite' value='1'>
							<param name='SkinCodeBase' value='http://tv.incheon.go.kr/Video/incheon_ictv.sbd#Version=2006'>
							<param name='SkinName' value='incheon_ictv'>
							<param name='SkinCodeBase' value='http://tv.incheon.go.kr/IBService/Video/incheon_ictv.sbd#Version=2006'>
							<param name='ShowControl' value='1'>
						</object -->
						<div class="ver01">
							<div class="ver11">
							<object id='SeeVideo2003' name='SeeVideo2003' width="380" height="325" classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013' codebase='http://tv.incheon.go.kr/IBService/admin/ActiveX/SVPorsche.cab#version=2,5,33,258'>
								<param name='PortNum' value='5010'>
								<param name='ServerIP' value='media.incheon.go.kr'>
								<param name='ScaleMode' value='0'>
								<param name='CustomLogoOnWhite' value='1'>
								<param name='AccessMode' value='4'>
								<param name='UseFixedServerPort' value='1'>
								<!--
								시정인재개발원_0722.avi
								-->
								<%
									String movieType = (String)request.getAttribute("movieType");
									String mediaFile = (String)request.getAttribute("mediaFile");
								%>
								<param id='MediaFile' name='MediaFile' value='<%=mediaFile %>'>
								<param name='AutoPlay' value='1'>
								<param name='CustomLogo' value='/images/media/media_intro.jpg'>
								<param name='CustomLogoOnWhite' value='1'>
								<param name='SkinCodeBase' value='http://tv.incheon.go.kr/Video/incheon_ictv.sbd#Version=2006'>
								<param name='SkinName' value='incheon_ictv'>
								<param name='SkinCodeBase' value='http://tv.incheon.go.kr/IBService/Video/incheon_ictv.sbd#Version=2006'>
								<param name='ShowControl' value='1'>
							</object>
							</div>
	
							<div class="ver12">
								<ul class="check">
								  <li><label for="korea"><input type="radio" id="korea" name="selected" class="objCk" checked="checked" value="10" title="선택버튼" <%="4".equals(movieType) ? "checked='checked'":""%> onclick="change_avi('4');"/> 한국어 동영상</label></li>
								  <li><label for="english"><input type="radio" id="english" name="selected" class="objCk" value="7.5" title="선택버튼" onclick="change_avi('1');" <%="1".equals(movieType) ? "checked='checked'":""%>/> 영어 동영상</label></li>
								  <li><label for="janpan"><input type="radio" id="menuScore3" name="selected" class="objCk" value="5" title="선택버튼" onclick="change_avi('2');" <%="2".equals(movieType) ? "checked='checked'":""%>/> 일본어 동영상</label></li>
								  <li><label for="menuScore4"><input type="radio" id="menuScore4" name="selected" class="objCk" value="2.5" title="선택버튼" onclick="change_avi('3');" <%="3".equals(movieType) ? "checked='checked'":""%>/> 중국어 동영상</label></li>
								</ul>
							</div>
						</div>
					</div>
					<script>
						function change_avi(movieType) {
							document.location.href = "/homepage/introduce.do?mode=eduinfo7-8&movieType=" + movieType;
						}
					</script>
					<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100033" /></jsp:include>
					<div class="h80" style="margin-top:50px;"></div>
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>