<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr"%>
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
<script>
	function changeMode(mode) {
		if(mode == "ipin") {
			$("view_jumin").style.display = "none";
			$("view_ipin").style.display = "";
		} else {
			$("view_jumin").style.display = "";
			$("view_ipin").style.display = "none";
		}
	}

	function encodeName(str){
		var s0, i, s, u;
		s0 = "";                // encoded str
		for (i = 0; i < str.length; i++){   // scan the source
			s = str.charAt(i);
			u = str.charCodeAt(i);          // get unicode of the char
			if (s == " "){s0 += "+";}       // SP should be converted to "+"
			else {
				if ( u == 0x2a || u == 0x2d || u == 0x2e || u == 0x5f || ((u >= 0x30) && (u <= 0x39)) || ((u >= 0x41) && (u <= 0x5a)) || ((u >= 0x61) && (u <= 0x7a))){       // check for escape
					s0 = s0 + s;            // don't escape
				}
				else {                  // escape
					if ((u >= 0x0) && (u <= 0x7f)){     // single byte format
						s = "0"+u.toString(16);
						s0 += "%"+ s.substr(s.length-2);
					}
					else if (u > 0x1fffff){     // quaternary byte format (extended)
						s0 += "%" + (0xf0 + ((u & 0x1c0000) >> 18)).toString(16);
						s0 += "%" + (0x80 + ((u & 0x3f000) >> 12)).toString(16);
						s0 += "%" + (0x80 + ((u & 0xfc0) >> 6)).toString(16);
						s0 += "%" + (0x80 + (u & 0x3f)).toString(16);
					}
					else if (u > 0x7ff){        // triple byte format
						s0 += "%" + (0xe0 + ((u & 0xf000) >> 12)).toString(16);
						s0 += "%" + (0x80 + ((u & 0xfc0) >> 6)).toString(16);
						s0 += "%" + (0x80 + (u & 0x3f)).toString(16);
					}
					else {                      // double byte format
						s0 += "%" + (0xc0 + ((u & 0x7c0) >> 6)).toString(16);
						s0 += "%" + (0x80 + (u & 0x3f)).toString(16);
					}
				}
			}
		}
		//alert(s0);
		//document.getElementById("username").value = s0;
	
		return s0;
	}

	// 2011.01.14 - woni82
	// i-Pin 인증 후 데이터가 넘어올때 데이터 타입이 틀리므로 변경하여 원래 형태로 변경해줌. - 이름
	function decodeName(str){
		var s0, i, j, s, ss, u, n, f;
		s0 = "";                // decoded str
		for (i = 0; i < str.length; i++){   // scan the source str
			s = str.charAt(i);
			if (s == "+"){
				s0 += " ";
			}// "+" should be changed to SP
			else {
				if (s != "%"){
					s0 += s;
				}     // add an unescaped char
				else{               // escape sequence decoding
					u = 0;          // unicode of the character
					f = 1;          // escape flag, zero means end of this sequence
					while (true) {
						ss = "";        // local str to parse as int
							for (j = 0; j < 2; j++ ) {  // get two maximum hex characters for parse
								sss = str.charAt(++i);
								if (((sss >= "0") && (sss <= "9")) || ((sss >= "a") && (sss <= "f"))  || ((sss >= "A") && (sss <= "F"))) {
									ss += sss;      // if hex, add the hex character
								} else {
									--i; 
									break;
								}    // not a hex char., exit the loop
							}
						n = parseInt(ss, 16);           // parse the hex str as byte
						if (n <= 0x7f){
							u = n; 
							f = 1;
						}   // single byte format
						if ((n >= 0xc0) && (n <= 0xdf)){
							u = n & 0x1f; 
							f = 2;
						}   // double byte format
						if ((n >= 0xe0) && (n <= 0xef)){
							u = n & 0x0f; 
							f = 3;
						}   // triple byte format
						if ((n >= 0xf0) && (n <= 0xf7)){
							u = n & 0x07; 
							f = 4;
						}   // quaternary byte format (extended)
						if ((n >= 0x80) && (n <= 0xbf)){
							u = (u << 6) + (n & 0x3f); 
							--f;
						}         // not a first, shift and add 6 lower bits
						if (f <= 1){
							break;
						}         // end of the utf byte sequence
						if (str.charAt(i + 1) == "%"){
							 i++ ;
						}                   // test for the next shift byte
						else {
							break;
						}                   // abnormal, format error
					}
				s0 += String.fromCharCode(u);           // add the escaped character
				}
			}
		}
		
		document.getElementById("username").value = s0;		
		return s0;
	}

	//아이핀으로 실명 인증하기 
	function gPinAuthId() {
		wWidth = 360;
		wHight = 120;
		wX = (window.screen.width - wWidth) / 2;
		wY = (window.screen.height - wHight) / 2;
		var w = window.open("../G-PIN/Sample-AuthRequest.jsp?gpinAuthRetPage=lecturer", "gPinLoginWin", "directories=no,toolbar=no,left=200,top=100,width="+wWidth+",height="+wHight);
	}

	// 이전 주민등록번호 실명 
	// 주민등록번호를 이용한 실명인증시 사용되는 부분
	function authCheck() {
		if($F('username') =='') {
			alert("이름을 입력해 주십시오.");
			$('username').focus();
			return;
		}else if($F('username').length < 2){
			alert("이름은 2자 이상입니다.");
			$('username').focus();
			return;
		}else if($F('ssn1').length != 6) {
			alert("주민등록번호 앞자리는 6자입니다.");
			$('ssn1').focus();
			return;
		}else if($F('ssn2').length != 7) {
			alert("주민등록번호 뒷자리는 7자입니다.");
			$('ssn2').focus();
			return;
		}else if($F('ssn2').substr(0,1)!=1 && $F('ssn2').substr(0,1)!=2) {
			alert("잘못된 주민등록번호 형식입니다.");
			$('ssn1').focus();
			return;
		}else {
			
		}		
		var url="support.do";
		var pars = "mode=authCheckAjax3&name="+$F('username')+"&resno="+$F('ssn1')+$F('ssn2');
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
		if(response.indexOf("YES") != -1) {
			alert('실명확인되었습니다.');
			$("pform").submit();		
		}else if(response.indexOf("UNDER") != -1) {
			alert("14세 미만은 신청 하실수 없습니다.");
		}else if(response.indexOf("CHECKNOPASS") != -1) {
			alert("실명 인증 실패 주민번호 이름을 확인해주세요.");
		}else if(response.indexOf("REJOIN") != -1) {
			alert("이미 가입되어 있는 주민등록번호 입니다.");
		}else {
			alert("실명확인이 실패하였습니다.\n다시 입력해 주십시오.");
		}
	}

	function failProcess() {
		alert("에러가 발생하였습니다.");
	}
</script>
<form id="pform" name="pform" method="post" action="/homepage/lecturer.do">
	<input type="hidden" name="mode"		value='lecturer3' />
</form>
<div id="contnets_area">
  <div class="sub_visual7">홈페이지 이용안내</div>
	<div class="local">
	  <h2>강사등록</h2>
		<div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 홈페이지 이용안내 &gt; <span>강사등록</span></div>
	</div>
	<div class="contnets">
	<!-- contnet -->
	<div id="content">
		<div class="lecturer_tab01">
			<ul>
				<li><img src='/images/skin4/sub/lecturer_step01.gif'alt="강사신청 1단계"></li>
				<li><img src='/images/skin4/sub/lecturer_step02_on.gif' alt="강사신청 2단계"></li>
				<li><img src='/images/skin4/sub/lecturer_step03.gif' alt="강사신청 3단계"></li>
				<li><img src='/images/skin4/sub/lecturer_step04.gif' alt="강사신청 4단계"></li>
			</ul>
		</div>
		<div class="h30"></div>
		<p class="mb15">인천시 인재개발원은 회원님의 명백한 동의 없이 회원의 정보를 공개 또는 제3자에게 제공되지 않으며,<br/>이용약관과 개인정보 보호정잭의 규정에 따라 철저하게 보호됩니다.<br/>다음의 실명확인을 통하여 기존 강사 등록여부를 확인합니다. 감사합니다.</p>
		<div class="h30"></div>
			<div id="realname">
				<fieldset>
					<input type="radio" id="mode1" name="mode" checked="checked" onclick="changeMode('jumin')"/> 주민번호 인증
					<input type="radio" id="mode2" name="mode" onclick="changeMode('ipin')"/> i-pin 인증
					<br />
					<br />
					<legend>실명확인</legend>
					<dl id="view_jumin">
						<dd>
							<label for="txtName">
								<img src="/images/skin4/sub/label_name.gif" alt="이름" />
							</label>
							<input id="username" name="username" type="text"/>
						</dd>
						<dd>
						<label for="txtRegno1" style="padding-right:10px;">
							<img src="/images/skin4/sub/label_idnum.gif" alt="주민등록번호" />
						</label>
						<input id="ssn1" name="ssn1"  maxlength="6" value="" type="text" /><span> -</span>
						<input id="ssn2" name="ssn2" maxlength="7" value="" type="password" />
						</dd>
						<dd><a href="javascript:authCheck();"><img src="/images/skin4/sub/btn_lecturer02.gif" id="imgbtnConfirm" valign="bottom" alt="실명확인" /></a></dd>
					</dl>
					<dl id="view_ipin" style="display:none;">
						<dd>
							<input type="image" src="/images/skin1/button/btn_ipin01.gif" alt="공공아이핀인증" onclick="gPinAuthId();" style="border:0px; width:165px; height:25px;"/>
							<br />
							<br />
							공공아이핀(I-PIN)은 인터넷상의 개인식별번호를
							의미하며, 대면확인이 어려운 인터넷에서 주민등록
							번호를 사용하지 않고도 확인할 수 있는 수단입니다.						
							공공아이핀(I-PIN)관련 문의처
							*공공 I-PIN서비스센터
							http://www.gpin.go.kr TEL02-3279-3480~2
							*인천광역시 정보화담당관실
							TEL 032-440-2332~4 
						</dd>
					</dl>
				</fieldset>
			</div>
		</div>
		<!-- //contnet -->
	  </div>
	</div>
</div>
<jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>