<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%@ page import="gov.mogaha.gpin.sp.util.StringUtil "%>
<%
	String userid = StringUtil.nvl((String)request.getAttribute("userid"), "");
	String question = StringUtil.nvl((String)request.getAttribute("question"), "");
%>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<script>window.name="mother"</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
 
<script language="JavaScript" type="text/JavaScript">
	window.onload = idCheck;
	var userid = "<%=userid%>";
	function idCheck() {
		if(userid.replace(/ /g,'') == "") {
			alert("검색된데이타가없습니다.");
			history.go(-1);
			return;
		}
	}
	function checkAnswer() {
		if($F("userid").replace(/ /g,'') == "") {
			alert("검색할 데이타가 업습니다.");
			history.go(-1);
			return;
		}
		$("f_question").submit();
	}
</script>
    <div id="subContainer">
    <div class="subNavi_area">
      <jsp:include page="/login/main_login.jsp" flush="false"/>   
      </div>
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual1.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>아이디/비밀번호 찾기</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; <span>아이디/비밀번호 찾기</span></div>
            </div>
			
			<div class="h80"></div>
			<form id="f_question" name="f_question" method="post" action="/homepage/renewal.do?mode=member05">
			<input type="hidden" id="userid" name="userid" value="<%=userid%>"/>
			<div id="content">
				<!-- data -->
				<div class="dSchSet02">
				<div class="dSch">
					<dl>
		                <dt> 질문 확인</dt>
		                <dd>
							&nbsp;&nbsp;
		                    <input type="text" id="question" name="question" class="input01 w158" style="width:400px;" readonly="readonly" value="<%=question%>"/>
		                </dd>
		            </dl>

					<div class="line02"></div>

					<dl>
		                <dt> 답변 확인</dt>
		                <dd>
		                	&nbsp;&nbsp;
		                    <input type="text" id="answer" name="answer" class="input01 w158" style="width:400px;"/>
		                </dd>
		            </dl>
				</div>
			</div>

			<div class="btn_c02">
				<input type="image" src="/images/skin1/button/btn_submit05.gif" alt="확인" />
			</div>
			</form>
			<!-- //data -->
		</div>
		<div class="h80"></div>

            <!-- //contnet -->
          </div>
        </div>    
    </div>
    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>