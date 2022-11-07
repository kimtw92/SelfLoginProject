<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%
// date	: 2008-08-26
// auth 	: 양정환
%>

<html>
	<head>
		<title>인천광역시 인재개발원에 오신것을 환영합니다</title>
		
		<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
		<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
		
		<style type="text/css">
			.w95{width:95px;}
		</style>
		
		<script>

			//2011.01.06 - woni82
			//이름과 이메일을 사용하여 아이디 패스워드를 찾는 스크립트
			function goSearch1(){

				//alert("1111");
				
				if($F('username') =='') {
					alert("이름을 입력해 주십시오.");
					return;
				}else if($F('username').length < 2){
					alert("이름은 2자 이상입니다.");
					return;
				}
	
				//else if($F('ssn1').length != 6) {
				//	alert("주민등록번호 앞자리는 6자입니다.");
				//	return;
				//}else if($F('ssn2').length != 7) {
				//	alert("주민등록번호 뒷자리는 7자입니다.");
				//	return;
				//}else if($F('ssn2').substr(0,1)!=1 && $F('ssn2').substr(0,1)!=2) {
				//	alert("잘못된 주민등록번호 형식입니다.");
				//	return;
				//}

				//alert("11111");
				
				var username = $F('username');
	
				var emailid = $F('emailid');
				var mailserv = $F('mailserv');
	
				var mode = $F('mode');
	
				var url = "join.do";
				pars = "mode="+mode+"&name="+username+"&email="+emailid+"@"+mailserv;
				var divID = "findidpwajaxEmail"; 			
				var myAjax = new Ajax.Updater(
					{success: divID },
					url, 
					{
						method: "post", 
						parameters: pars,
						onLoading : function(){
							//alert("0000");		
						},
						onSuccess : function(){

							//alert("1111");
							
							window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);						
						},
						onFailure : function(){

							//alert("2222");
												
							window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
							alert("데이타를 가져오지 못했습니다.");
						}				
					}
				);
			}
		
			//2011.01.06 - woni82
			//이름과 주민등록번호를 사용하여 아이디 패스워드를 찾는 스크립트
			//아이핀 적용되면서 새로운 스크립트 사용됨.
			//사용 안함
			function goSearch(){
				if($F('username') =='') {
					alert("이름을 입력해 주십시오.");
					return;
				}else if($F('username').length < 2){
					alert("이름은 2자 이상입니다.");
					return;
				}

				else if($F('ssn1').length != 6) {
					alert("주민등록번호 앞자리는 6자입니다.");
					return;
				}else if($F('ssn2').length != 7) {
					alert("주민등록번호 뒷자리는 7자입니다.");
					return;
				}else if($F('ssn2').substr(0,1)!=1 && $F('ssn2').substr(0,1)!=2) {
					alert("잘못된 주민등록번호 형식입니다.");
					return;
				}
						
				var username = $F('username');

				var ssn1 = $F('ssn1');
				var ssn2 = $F('ssn2');
				
				var mode = $F('mode');

				var url = "join.do";
				pars = "mode="+mode+"&name="+username+"&ssn="+ssn1+ssn2;
				var divID = "findidpwajax"; 			
				var myAjax = new Ajax.Updater(
					{success: divID },
					url, 
					{
						method: "post", 
						parameters: pars,
						onLoading : function(){		
						},
						onSuccess : function(){
							window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);						
						},
						onFailure : function(){					
							window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
							alert("데이타를 가져오지 못했습니다.");
						}				
					}
				);
			}
			
			// findpwajax.jsp에서 쓰임	
			function sendEmail() {
				var email = $F('email');
				var userno = $F('userno');
				var format = /^[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+)*@[0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*$/;
			    if (email.search(format) != -1) {
		
				}else{
					alert("올바른 이메일 형식이 아닙니다.");
				    return;
				}
				
				var url="join.do";
				
				var pars = "mode=sendemail&email="+email+"&userno="+userno;
				
				var request = new Ajax.Request (
					url,
					{
						method:"get",
						parameters : pars,
						onSuccess : sendEmailSuccess,
						onFailure : sendEmailFailure
					}	
				);
			}
		
			function sendEmailSuccess(request) {
				var response = request.responseText;
				var email = $F('email');
				
				if(response == 'Y') {
					alert("["+email+"] <- 메일을 성공적으로 발송하였습니다.");
					self.close();
				}else {
					alert("메일 발송이 실패하였습니다.");
					self.close();	
				}
			}
		
			function sendEmailFailure() {
				alert("메일을 발송이 실패하였습니다.");
				self.close();
			}
			
			// findpwajax.jsp에서 쓰임
			function sendHp() {
				var url="join.do";
				var hp = $F('hp');
				var userno = $F('userno');
				var pars = "mode=sendsms&hp="+hp+"&userno="+userno;
				
				var request = new Ajax.Request (
				url,
				{
					method:"get",
					parameters : pars,
					onSuccess : sendHpSuccess,
					onFailure : sendHpFailure
				}	
				);
			}
		
			function sendHpSuccess(request){
				var response = request.responseText;
				var hp = $F('hp');
				
				if(response == 'Y') {
					alert("["+hp+"] <- 문자메시지를 성공적으로 발송하였습니다.");
					self.close();
				}else {
					alert("문자메시지 발송을 실패하였습니다.");
					self.close();			
				}	
			}	
		
			function sendHpFailure(){
				alert("문자메시지 발송을 실패하였습니다.");
				self.close();
			}	
			
			var staticidcheck = false;
		
			function idcheck(){
				eval("var Str = document.pform.alreadyuserid.value") ;
				if(Str == "") {
					alert("아이디를 입력해 주십시오.") ;
					return; 
				}
		        for(i=0; i<Str.length; i++){
		            Chr = Str.charAt(i) ; 
		            if(Str.length < 9 || Str.length > 12) {
		                alert("아이디는 9자 이상, 12자 이하 이어야 합니다.") ;
		                eval("document.pform.alreadyuserid.value = ''") ;
		                eval("document.pform.alreadyuserid.focus()") ;       
		                return;     
		            }
		            if((Chr < "0" || Chr > "9") && (Chr < 'a' || Chr > 'z')) {
		                alert("아이디는 영문(소문자, 숫자포함) 이어야 합니다.") ;
		                eval("document.pform.alreadyuserid.value = ''") ;
		                eval("document.pform.alreadyuserid.focus()") ;
		                return ;
		            }
				}
				id = $F('alreadyuserid');
				var url = "join.do";
				pars = "mode=idcheckajax&userid="+id;
				
				var myAjax = new Ajax.Request(
					url, 
					{
						method: "get", 
						parameters: pars,
						onComplete: testFunction1
					}				
				);
			}
			
			function testFunction1(request){
				var num = request.responseText;
				if(num == 1) {
					alert("아이디 중복입니다.");
				}else {
					alert("사용가능한 아이디 입니다.");
					staticidcheck = true;
				}	
			}
		
			function goRejoin(){
				eval("var Str = document.pform.alreadypassword.value") ;
		        for(i=0; i<Str.length; i++){
		            Chr = Str.charAt(i) ; 
		            if(Str.length < 9 || Str.length > 12) {
		                alert("비밀번호는 9자 이상, 12자 이하 이어야 합니다.") ;
		                eval("document.pform.alreadypassword.value = ''") ;
		                eval("document.pform.alreadypassword.focus()") ;       
		                return;     
		            }
				}		
				if(staticidcheck == false) {
					alert("아이디 중복체크를 하셔야 합니다.");
					return;
				}else {
					location.href="/homepage/join.do?mode=rejoinupdateidpw&id="+$F('alreadyuserid')+"&pw="+$F('alreadypassword')+"&resno="+$F('getresno');
				}
			}
		</script>	
	</head>
	<!-- popup size 400x300 -->
	<body>
		<div class="top">
			<h1 class="h1">아이디/비밀번호 찾기</h1>
		</div>
		
		<!-- <div id="findidpwajax" class="contents">
			 <input type="hidden" id="mode" name="mode" value="findpwajax"/> -->
		<div id="findidpwajaxEmail" class="contents">	
			<input type="hidden" id="mode" name="mode" value="findpwajaxEmail"/>
			
		    <!-- text -->
			<div class="textSet01" style="width:372px;">
				다음의 입력란에 회원님의 성명과 E-Mail 주소를 입력하십시오.<br />
				회원님의 ID/PASSWORD를 안내해 드리겠습니다. 
			</div>
			<!-- //text -->
		    <div class="h10"></div>
		
			<!-- search -->
			<div class="popBoxWrap">
				<div class="drBoxTop">
		            <dl>
		                <dt>
		                	<!-- <img src="/images/skin1/common/txt_name.gif" class="vm2" alt="성명" /> -->
		                	<img src="/images/skin1/common/txt_name2.gif" class="vm2" alt="성명" />
		                </dt>
		                <dd>
		                	&nbsp;&nbsp;
		                    <input type="text" id="username" name="username" class="input01 w158" /> 
		                </dd>
		            </dl>
		            
		            <!-- <dl>
		                <dt>
		                	<img src="/images/skin1/common/txt_no.gif" class="vm2" alt="주민등록번호" />
		                </dt>
		                <dd>
		                    <input type="text" id="ssn1" name="ssn1" maxlength="6" class="input01 w69" /> -
		                    <input type="text" id="ssn2" name="ssn2" maxlength="7" class="input01 w69" /> 
					        <a href="javascript:goSearch()"><img src="/images/skin1/button/btn_search04.gif" class="vm3" alt="검색" /></a>
		                </dd>
		            </dl> -->
				
					<!-- 주민등록 번호 대신 이메일주소로 대체함 -->
					<dl>
		                <dt>
		                	<img src="/images/skin1/common/txt_email.gif" class="vm2" alt="E-mail" />
		                </dt>
		                <dd>
		                	<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  -->
		                    <input type="text" title="이메일 아이디" name="emailid" id="emailid" class="input01 w69" /> @ 
							<input type="text" title="이메일 계정" name="mailserv" id="mailserv" class="input01 w95" >
					        <a href="javascript:goSearch1()">
					        	<img src="/images/skin1/button/btn_search04.gif" class="vm3" alt="검색" />
					        </a>
		                </dd>
		            </dl>
				
				</div>
			</div>
			<!-- //search -->
		
			<!-- button -->
			<div class="btnC" style="width:372px;">
				<a href="javascript:self.close();">
					<img src="/images/skin1/button/btn_close01.gif" alt="닫기" />
				</a>		
			</div>	
			<!-- //button -->
		</div>
	</body>
</html>
