<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%@ page import="gov.mogaha.gpin.sp.util.StringUtil "%>
<%
	String userid = StringUtil.nvl((String)request.getAttribute("userid"), "");
	String userno = StringUtil.nvl((String)request.getAttribute("userno"), "");
	String email = StringUtil.nvl((String)request.getAttribute("email"), "");
	String hp = StringUtil.nvl((String)request.getAttribute("hp"), "");
	String mode = StringUtil.nvl((String)request.getAttribute("mode"), "");
%>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<script>window.name="mother"</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
 
<script language="JavaScript" type="text/JavaScript">
	window.onload = idCheck;
	var userid = "<%=userid%>";
	var mode = "<%=mode%>";
	function idCheck() {
		if(userid.replace(/ /g,'') == "") {
			if(alert("회원 정보가 틀립니다. 관리자에게 문의하시기 바랍니다")){
				//document.location.href = "/homepage/join.do?mode=joinstep1";
				return;
			}
			if(mode.indexOf("ipinFindPw") != -1) {
				document.location.href = "/homepage/renewal.do?mode=member01";
				return;
			} else {
				history.go(-1);
				return;
			}
		}
		$("joinUsMtSet03").style.display = "block";
	}


	function sendEmailSuccess(request) {
		var response = request.responseText;
		var email = $F('pw_email');
		if(response.indexOf('Y') != -1) {
			alert("["+email+"] <- 메일을 성공적으로 발송하였습니다. 확인시 페이지가 이동됩니다.");
			document.location.replace("/");
		}else {
			alert("메일 발송이 실패하였습니다.");
		}
	}

	function sendEmailFailure() {
		alert("메일을 발송이 실패하였습니다.");
	}
	
	// findpwajax.jsp에서 쓰임
	function sendHp() {
		var url="/homepage/join.do";
		var hp = $F('pw_hp');
		var userno = $F('userno');

		if(hp == "") {
			alert("입력된 휴대폰 번호가 없습니다.");
			return;
		}
		if(userno == "") {
			alert("선택된 유저가 없습니다.");
			return;
		}
		var pars = "mode=sendsms&hp="+hp+"&userno="+userno;
		
		var request = new Ajax.Request (
		url,
		{
			method:"post",
			parameters : pars,
			onSuccess : sendHpSuccess,
			onFailure : sendHpFailure
		}	
		);
	}

	function sendHpSuccess(request){
		var response = request.responseText;
		var hp = $F('pw_hp');
		if(response.indexOf('Y') != -1) {
			alert("["+hp+"] <- 문자메시지를 성공적으로 발송하였습니다. 확인시 페이지가 이동됩니다.");
			document.location.replace("/");
		}else {
			alert("문자메시지 발송을 실패하였습니다.");
		}	
	}	

	function sendHpFailure(){
		alert("문자메시지 발송을 실패하였습니다.");
	}

	function goQuestion() {
		if($F("userid").replace(/ /g,"") == "") {
			alert("검색된 사용자가없습니다.");
			return;
		}
		$("f_pwArea").submit();
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
            <div class="contnets">
            <!-- contnet -->
				<div class="joinUsMtSet03" id="joinUsMtSet03" style="display:none;">
					<div class="joinUsMt03">
						<div class="pw01">
						<img src="/images/skin1/sub/pw01.gif" alt="비밀번호 재발급" /> <span>아래 방법 중 하나의 인증수단을 선택해서 비밀번호를 재발급 받으시기 바랍니다.</span>
						</div>

						<div class="pw02">
						<dl>
							<dt>질문/답변으로 찾기</dt>
							<dd>회원가입시 입력하신<br/>
							질문과 답변으로 찾습니다.</dd>
						</dl>
						<form id="f_pwArea" name="f_pwArea" method="post" action="/homepage/renewal.do?mode=member04">
						<input type="hidden" id="userid" name="userid" value="<%=userid%>"/>
						<input type="hidden" id="userno" name="userno" value="<%=userno%>"/>
						<input class="btn_pw01" type="image" src="/images/skin1/button/btn_submit06.gif" alt="확인" />
						</form>
						</div>
						<div class="pw03">
							<dl>
								<dt>등록된 연락처 인증</dt>
								<dd>재발급받기를 선택하시면 등록된 연락처로 비밀번호가 발송됩니다.</dd>
							</dl>
							<ul>
								<li>
									<span>휴대폰 번호</span> <span id="pw_hp_area">
									<input type="text" id="pw_hp" name="pw_hp" style="width:100px;" readonly="readonly" value="<%=hp%>"/></span>
									<span class="m04"><a href="javascript:sendHp();"><img src="/images/skin1/button/btn_pw01.gif" alt="재발급 받기"/></a></span>
								</li>
							</ul>
							<div class="h15"></div>
							<!-- dl>
							<dt>등록된 연락처 인증</dt>
							<dd>재발급받기를 선택하시면 등록된 연락처로 비밀번호가 발송됩니다.</dd>
							</dl -->

							</ul>
							<!-- div class="tx03"><img src="/images/skin1/sub/pw_tel02.gif" alt="032-440-7673" /></div -->
						</div>
					</div>		
				</div>
            <!-- //contnet -->
          </div>
        </div>    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>