<%@ page language="java"  pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천광역시 인재개발원에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script>

	function confirmPersonalInfo(){

		if($F('id').length < 6) {
			alert('아이디를 입력하여 주세요.');
			return;
		}		
		
		if($F('email').length < 1) {
			alert('메일을 입력해주세요.');
			return;
		}

		if($F('hp1').length < 1) {
			alert('받으실 핸드폰 번호를 입력해 주세요.');
			return;
		}

		if($F('hp2').length < 1) {
			alert('받으실 핸드폰 번호를 입력해 주세요.');
			return;
		}

		if($F('hp3').length < 1) {
			alert('받으실 핸드폰 번호를 입력해 주세요.');
			return;
		}

		
		var url="login.do";
		
		var pars = "mode=checkPersonalInfoAjax&id="+$F('id')+"&email="+$F('email')+"&hp="+$F('hp1')+"-"+$F('hp2')+"-"+$F('hp3');
		
		var request = new Ajax.Request (
		url,
		{
			method:"post",
			parameters : pars,
			onSuccess : successProcess,
			onFailure : failProcess
		}	
		);		
	}
	
	function successProcess(request) {
		var response = request.responseText;

		if(response == 'YES') {
			alert("입력하신 핸드폰으로 인증번호가 발송되었습니다.");
			location.href="login.do?mode=setpasswordstep3";
		}else {
			alert("일치하는 회원정보가 없습니다.\n다시 검색해 주십시오.");
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
			<dt>아이디 :</dt>
			<dd>
				<input type="text" value="" name="id" id="id" class="input01 w159" />
			</dd>
		</dl>
		<dl>
			<dt>이메일 :</dt>
			<dd>
				<input type="text" value="" name="email" id="email" maxlength="40" class="input01 w159"/>
			</dd>
		</dl>
		<dl>
			<dt>휴대전화 :</dt>
			<dd>
				<input type="text" value="" name="hp1" id="hp1" maxlength="3" class="input01 w40" />-<input type="text" value="" name="hp2" id="hp2" maxlength="4" class="input01 w40"/>-<input type="text" value="" name="hp3" id="hp3" maxlength="4" class="input01 w40" />
			</dd>
		</dl>		
	</div>
	<!-- //data -->
	<div class="space02"></div>

	<!-- data -->
	<div class="InCons">
		<dl>
			<dt><img src="/images/skin1/common/pw_st07.gif" alt="개인아이디와 비밀번호" title="개인 아이디와 비밀번호 및 휴대폰 번호를 입력하신 후에 아래 ‘휴대폰으로 인증번호 전송’ 버튼을 클릭하시면 본인의 휴대폰으로 인증번호가 전송됩니다." /></dt>
		</dl>
	</div>
	<!-- //data -->

	<!-- button -->
	<div class="btnC">
		<a href="javascript:confirmPersonalInfo();"><img src="/images/skin1/common/pw_sbtn01.gif" alt="휴대폰으로 인증번호 전송" /></a>
	</div>
	<!-- //button -->
</div>

</body>
</html>
