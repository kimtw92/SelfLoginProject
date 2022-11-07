<%@ page language="java"  pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천사이버교육센터(시민포털)에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script>

	function confirmSetPassword() {

		if($F('smsNum').length < 5) {
			alert('인증번호 형식이 잘못 입력되었습니다.');
			return;
		}
		
		if($F('pwd') == "" || $F('pwdcheck') == "") {
			alert('패스워드를 입력해 주십시오.');
			return;
		}
	
		if($F('pwd') != $F('pwdcheck')) {
			alert('패스워드가 일치하지 않습니다.');
			return;
		}

		if($F('pwd').length < 6) {
			alert('패스워드는 6자 이상입니다.');
			return;
		}		
		
		if($F('smsNum') == '<%=session.getAttribute("smsNumber")%>') {
			//alert("패스워드가 성공적으로 변경되었습니다.");
			
			var url="login.do";
			var pars = "mode=updatePasswordAjax&pw="+$F('pwd')+"&id=<%=(String)session.getAttribute("id") %>";

			var request = new Ajax.Request (
			url,
			{
				method:"post",
				parameters : pars,
				onSuccess : successProcess,
				onFailure : failProcess
			}	
			);	
			

		}else {
			alert("인증번호를 다시 입력해 주세요.");
		}
	}

	function successProcess(request) {
		var response = request.responseText;

		if(response == 'YES') {
			alert('패스워드가 변경되었습니다.');
			window.opener.document.getElementById('pwd').value=$F('pwd');
			window.opener.fnLogin();
			self.close();
		}else {
			alert('에러가 발생하였습니다.\n다시 시도해 주십시오.');
		}
	}

	function failProcess() {
		alert("에러가 발생하였습니다.\n관리자에게 문의 주시기 바랍니다.");
	}	
	
</script>

</head>

<!-- popup size 400x300 -->
<body style="background:#fff;">
<div class="pwtop">
	<h1 class="h1"><img src="/images/skin1/common/pw_t02.gif" alt="개인정보 확인" /></h1>
</div>
<div class="pwcontents">
	<!-- data -->
	<div class="pwInDeta01">
		<dl>
			<dt><img src="/images/skin1/common/pw_st01.gif" alt="아이디" /></dt>
			<dd>
				<%=(String)session.getAttribute("id") %>
			</dd>
		</dl>
		<dl>
			<dt><img src="/images/skin1/common/pw_st04.gif" alt="인증번호" /></dt>
			<dd>
				<input type="text" value="" name="smsNum" id="smsNum" class="input01 w159" />
			</dd>
		</dl>
		<dl>
			<dt><img src="/images/skin1/common/pw_st05.gif" alt="신규비밀번호" /></dt>
			<dd>
				<input type="password" value="" name="pwd" id="pwd" class="input01 w159" />
			</dd>
		</dl>
		<dl>
			<dt><img src="/images/skin1/common/pw_st06.gif" alt="비밀번호확인" /></dt>
			<dd>
				<input type="password" value="" name="pwdcheck" id="pwdcheck" class="input01 w159" />
			</dd>
		</dl>		
	</div>
	<!-- //data -->
	<div class="space02"></div>

	<!-- data -->
	<div class="InCons">
		<dl>
			<dt><img src="/images/skin1/common/pw_st08.gif" alt="휴대폰" title="휴대폰으로 발송된 6자리 인증번호와 새로 사용하실 비밀번호를 입력합니다. 입력하신 후에 ‘비밀번호 변경 확인’을 클릭하시면 비밀번호가 적용되며 자동 로그인 됩니다." /></dt>
		</dl>
	</div>
	<!-- //data -->

	<!-- button -->
	<div class="btnC">
		<a href="javascript:confirmSetPassword();"><img src="/images/skin1/common/pw_sbtn02.gif" alt="패스워드 변경 확인" /></a>
	</div>	
	<!-- //button -->
</div>

</body>
</html>
