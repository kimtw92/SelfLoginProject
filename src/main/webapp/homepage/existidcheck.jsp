<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script>
	function existid(){
		if($F('ssn1').length != 6) {
			alert("주민등록번호 앞자리는 6자입니다.");
			return;
		}else if($F('ssn2').length != 7) {
			alert("주민등록번호 뒷자리는 7자입니다.");
			return;
		}else if($F('ssn2').substr(0,1)!=1 && $F('ssn2').substr(0,1)!=2) {
			alert("잘못된 주민등록번호 형식입니다.");
			return;
		}		
		document.existidform.submit();		
	}
</script>

<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
<form name="existidform">	
<input type="hidden" name="mode" value="existidyn">
<div class="top">
	<h1 class="h1">아이디/패스워드 찾기</h1>
</div>
<div class="contents">
    <!-- text -->
	<div class="textSet01" style="width:372px;">
		주민번호를 입력하시면 기존의 아이디를 확인하실수 있습니다. 
	</div>
	<!-- //text -->
    <div class="h10"></div>

	<!-- search -->
	<div class="popBoxWrap">
		<div class="drBoxTop">
            <dl>
                <dt><img src="/images/skin1/common/txt_no.gif" class="vm2" alt="주민등록번호" /></dt>
                <dd>
                    <input type="text" value="" name="ssn1" class="input01 w69" /> -
                    <input type="password" value="" name="ssn2" class="input01 w69" /> 
					<a href="javascript:existid();">
			        <img src="/images/skin1/button/btn_search04.gif" class="vm3" alt="검색" />
					</a>
                </dd>
            </dl>
		</div>
	</div>
	<!-- //search -->

	<!-- button -->
	<div class="btnC" style="width:372px;">
		<a href="javascript:self.close();"><img src="/images/skin1/button/btn_close01.gif" alt="닫기" /></a>		
	</div>	
	<!-- //button -->
</div>
</form>