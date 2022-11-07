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
 
<script language="JavaScript" type="text/JavaScript">
	window.onload = idCheck;
	var userid = "";
	var mode = "";
	function idCheck() {
		/* if(userid.replace(/ /g,'') == "") {
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
		} */
		//$("joinUsMtSet03").style.display = "block";
	}
	function sendEmail() {
		var email = $F('pw_email');
		var userno = $F('userno');
		var format = /^[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+)*@[0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*$/;
		if (email.search(format) != -1) {

		}else{
			alert("올바른 이메일 형식이 아닙니다.");
			return;
		}
		
		var url="/homepage/join.do";
		
		var pars = "mode=sendemail&email="+email+"&userno="+userno;
		
		var request = new Ajax.Request (
			url,
			{
				method:"post", 
				parameters : pars,
				onSuccess : sendEmailSuccess,
				onFailure : sendEmailFailure
			}	
		);
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
		var hp = $("#pw_hp").val();
		var username = $("#pw_name").val();
		
		if(hp == "") {
			alert("입력된 휴대폰 번호가 없습니다.");
			return;
		}
		
		if(username == "") {
			alert("선택된 유저가 없습니다.");
			return;
		} 
		
		var pars = "mode=sendpasswordsms&hp="+hp+"&username="+username;
		
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
		var hp = $("#pw_hp").val();
		if(response.indexOf('Y') != -1) {
			alert("["+hp+"] <- 문자메시지를 성공적으로 발송하였습니다. 확인시 페이지가 이동됩니다.");
			//document.location.replace("/");
			self.close();
		}else if(response.indexOf('F') != -1) {
			
			alert("핸드폰 번호 혹은 이름이 일치하지 않습니다 \r\n연락처) 032-440-7684 으로 문의하세요");			
		}
		else {
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
        <div id="contnets_area">
            <div class="contnets">
            <!-- contnet -->
				<div class="joinUsMtSet03" id="joinUsMtSet03" >
					<div class="joinUsMt03">
						<div class="pw01">
						<img src="/images/skin1/sub/pw01.gif" alt="비밀번호 재발급" /> <span> 로그인 정보 5회 잘못 입력하셨습니다.</span>
						</div>

						<div class="pw02">
						<dl>
							<dt></dt>
							<dd>회원가입시 입력하신<br/>
							핸드폰 번호를  이용하여  <br/>
							비밀번호를 부여 받습니다.</dd>
						</dl>
						<form id="f_pwArea" name="f_pwArea" method="post" action="/homepage/renewal.do?mode=member04">
						<!-- <input type="hidden" id="userid" name="userid" value=""/>
						<input type="hidden" id="userno" name="userno" value=""/>
						<input class="btn_pw01" type="image" src="/images/skin1/button/btn_submit06.gif" alt="확인" /> -->
						</form>
						</div>
						<div class="pw03">
							<dl>
								<dt>등록된 연락처 인증</dt>
								<dd>재발급받기를 선택하시면 임시 비밀번호가 발송됩니다.</dd>
							</dl>
							<ul>
								<li>
									<span>이   름</span> <span id="pw_name_area">
									<input type="text" id="pw_name" name="pw_name" style="width:100px;" value=""/></span>									
								</li>
								
								<li>
									<span>휴대폰 번호</span> <span id="pw_hp_area">
									<input type="text" id="pw_hp" name="pw_hp" style="width:100px;"  value=""/></span>
									<span class="m04"><a href="javascript:sendHp();"><img src="/images/skin1/button/btn_pw01.gif" alt="재발급 받기"/></a></span>
								</li>
								<%-- <li>
									<span class="m01">이메일</span> <span id="pw_email_area">
									<input type="text" id="pw_email" name="pw_email" style="width:100px;" readonly="readonly" value="<%=email%>"/></span>
									<span class="m04"><a href="javascript:sendEmail();"><img src="/images/skin1/button/btn_pw01.gif" alt="재발급 받기"/></a></span>
								</li> --%>
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

