<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="../inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
     <jsp:include page="/login/main_login.jsp" flush="false"/>
   
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual1">홈페이지 이용안내</div>
            <div class="local">
              <h2>회원가입</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; <span>회원가입</span></div>
            </div>

            <div class="contnets">
            <!-- contnet -->
			<div id="content">
			
				<!-- data -->
				<div class="dSchSet02">
				<div class="dSch">
					<dl>
		                <dt> 새로운 비밀번호</dt>
		                <dd>
		                    <input type="text" id="username" name="username" class="input01 w158" /> 영문 숫자를 포함하여 6~20자리로 입력하셔야 합니다.
		                </dd>
		            </dl>

					<div class="line02"></div>

					<dl>
		                <dt> 비밀번호 확인</dt>
		                <dd>

		                	&nbsp;&nbsp;
		                    <input type="text" id="username" name="username" class="input01 w158" /> 입력하신 비밀번호를 다시 한번 입력해 주세요.
		                </dd>
		            </dl>
				</div>
				</div>

				<div class="btn_c02">
				<input type="image" src="/images/skin1/button/btn_submit05.gif" alt="확인" />
				</div>

				<!-- //data -->



		</div>
		<div class="h80"></div>
            <!-- //contnet -->
          </div>

        </div>
    
    
    </div>

     <jsp:include page="../inc/footer.jsp" flush="true" ></jsp:include>