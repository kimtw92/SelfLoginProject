<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<%
// date	: 2008-08-26
// auth 	: 양정환
%>

<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
 
<%

	DataMap requestMap = (DataMap)request.getAttribute("DEPT_LIST");
	requestMap.setNullToInitialize(true);
	
	StringBuffer deptListHtml = new StringBuffer();
	
	if(requestMap.keySize("dept") > 0){
		for(int i=0; i < requestMap.keySize("dept"); i++){
			deptListHtml.append("<option value = \""+requestMap.getString("dept",i)+requestMap.getString("deptnm",i)+"\">"+requestMap.getString("deptnm",i)+"</option>");
		}
	}
%>

	<!-- 달력 관련 시작-->	
	<Div id='popCal' style='POSITION:absolute;visibility:hidden;border:2px ridge;width:10'>
		<iframe name="popFrame" src="./popcalendar.htm" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" width="183" height="188"></iframe>
	</DIV>
	
	<SCRIPT event="onclick()" for="document"> 
		popCal.style.visibility = "hidden";
	</SCRIPT>
	<!-- 달력 관련 끝-->

	<script type="text/javascript" language="javascript">
		var staticidcheck = false;
		var staticemailcheck = false;
		var juminNumCheck = false;
	
		//주민등록번호 체크
		function juminCheck() {
			//alert("jumincheck");
			var url="support.do";
			var pars = "mode=authCheckAjax&name="+document.getElementById("username").value+"&resno="+document.getElementById("ssn1").value+document.getElementById("ssn2").value;
		
			//alert(pars);
			var request = new Ajax.Request (
				url,
				{
					method:"post",
					parameters : pars,
					onSuccess : successProcess
				}	
			);	
		}
		
		function successProcess(request) {
			var response = request.responseText;
		
			//alert(response);
		
			if(response == 'YES') {
				juminNumCheck = true;	
			}else if(response == 'UNDER') {
				alert("14세 미만은 가입할 수 없습니다.");
			}else if(response == 'REJOIN') {
				alert("이미 가입되어 있는 주민등록번호 입니다.");
			}else {
				alert("실명확인이 실패하였습니다.\n다시 입력해 주십시오.");
			}
		}
		
		//소속기관명 선택시
		function getMemSelDept(form1, form2) {
			//var url = "/mypage/myclass.do";
			var url = "join.do";
			var pars = "deptname="+form2+"&dept=" + form1.substring(0,7) + "&mode=searchPart_";
			var divID = "part";
		
			var myAjax = new Ajax.Updater(
		
					{success: divID },
					url, 
					{
						method: "post", 
						parameters: pars,
						onLoading : function(){
							$(document.body).startWaiting('bigWaiting');
						},
						onSuccess : function(){
							window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
							// $("month").value = month;
							// $("currPage").value = 1;
						},
						onFailure : function(){					
							window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
							alert("데이타를 가져오지 못했습니다.");
						}				
					}
				);
		}
		
		//부서명 선택
		function getPart(objValue, objText) {
			if(objValue == ""){
				document.pform.deptname.value = "";
				document.pform.deptname.focus();
			} else {
				document.pform.deptname.value = objText;
			}
		}
		
		//ID 체크
		function idcheck(){
			eval("var Str = document.pform.USER_ID.value") ;
	
			if(Str == "") {
				alert("아이디를 입력해 주십시오.") ;
				return; 
			}
	        for(i=0; i<Str.length; i++){
	            Chr = Str.charAt(i) ;
	            if(Str.length < 6 || Str.length > 12) {
	                alert("아이디는 6자 이상, 12자 이하 이어야 합니다.") ;
	                eval("document.pform.USER_ID.value = ''") ;
	                eval("document.pform.USER_ID.focus()") ;       
	                return;     
	            }  
	            if((Chr < "0" || Chr > "9") && (Chr < 'a' || Chr > 'z')) {
	                alert("아이디는 영문(소문자, 숫자포함) 이어야 합니다.") ;
	                eval("document.pform.USER_ID.value = ''") ;
	                eval("document.pform.USER_ID.focus()") ;
	                return ;
	            }
			}
			
			id = $F('idform');
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
		
		function emailcheck() {
			eval("var Str1 = document.pform.emailid.value") ;
	        if(Str1 == "" ) {
				alert("이메일을 입력해 주십시오") ;
				return; 
	        }
	            
			email = $F('emailid')+'@'+$F('mailserv');
			var url = "join.do";
			pars = "mode=emailcheckajax&email="+email;


			var myAjax = new Ajax.Request(
				url, 
				{
					method: "post", 
					parameters: pars,
					onComplete: testFunction2
				}				
			);
		}
		
		function testFunction2(request){
			var num = request.responseText;
		
			if(num == 1) {
				alert("이메일 중복입니다.");
			}else {
				alert("사용가능한 이메일 입니다.");
				staticemailcheck = true;
			}	
		}
		function joinProcess(mode){

			var form1 = document.pform;

			for(var i =0 ; i < form1.elements.length ; i++){        	
			    if(form1.elements[i].value=="" && form1.elements[i].title != ""){
			        alert(form1.elements[i].title+" 부분을 입력하여 주십시오" );
			        form1.elements[i].focus();
			        return;
			    }
			    if(form1.elements[i].name=="PWD"){
					var Str = document.pform.PWD.value
						for(i=0; i<Str.length; i++){
							Chr = Str.charAt(i); 
							if(Str.length < 9 || Str.length > 12) {
								alert("비밀번호는 9자 에서 12자 이하 이어야 합니다.") ;
								eval("document.pform.PWD.value = ''") ;
								eval("document.pform.PWD_CHK.value = ''") ;
								eval("document.pform.PWD.focus()") ;       
								return;     
							}
						}
			            if(Str == "") {
			            	alert("비밀번호를 입력해주세요.");
			            	eval("document.pform.PWD.focus()") ;
			            	return;
			            }
			            // = /[~!@\#$%^&*\()\=+_']/gi; 특수문자
			            var isPW = /^[A-Za-z0-9`\-=\\;',.\/~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{6,16}$/;
						if(!isPW.test(Str)) {
							alert("비밀번호는 영문/숫자와 특수문자를 혼용하여 입력해주시기 바랍니다.");
							eval("document.pform.PWD.value = ''") ;
							eval("document.pform.PWD_CHK.value = ''") ;
							eval("document.pform.PWD.focus()") ;   
							return ;
						}
						if(document.pform.PWD.value.indexOf(document.pform.USER_ID.value) != -1) {
							alert("아이디는 비밀번호에 사용될 수 없음");
							eval("document.pform.PWD.value = ''") ;
							eval("document.pform.PWD_CHK.value = ''") ;
							eval("document.pform.PWD.focus()") ;   
							return;
						}
						var isNumber = /^[0-9]+$/;
						if(isNumber.test(Str)) {
							alert("숫자만 입력하실수 없습니다. 다시 입력해주세요.");
							eval("document.pform.PWD.value = ''") ;
							eval("document.pform.PWD_CHK.value = ''") ;
							eval("document.pform.PWD.focus()") ;  
							return;
						}
						var isChkPwd = false;
						var comStr = "";
						for (var k=0; k<Str.length; k++) {
							comStr = Str.charAt(k) + Str.charAt(k) + Str.charAt(k) + Str.charAt(k);
							if (Str.indexOf(comStr) != -1) {
								isChkPwd = true;
								break;
							}
						}
	
						if (isChkPwd) {
							alert("동일한 문자/숫자 4자리/공백은 사용하실 수 없습니다. 다시 입력해주세요.");
							eval("document.pform.PWD.value = ''") ;
							eval("document.pform.PWD_CHK.value = ''") ;
							eval("document.pform.PWD.focus()") ;  
							return ;
						}
			 
						if (Str.length >= 4) {
							var iUniCode = 0;
							for (var i=0; i <= Str.length - 3; i++) {
								iUniCode = Str.charCodeAt(i);
								if (Str.charCodeAt(i+1) == iUniCode + 1 && Str.charCodeAt(i+3) == iUniCode + 3) {
									alert("연속된 문자/숫자 4자리는 사용하실 수 없습니다. 다시 입력해주세요.");
									eval("document.pform.PWD.value = ''") ;
									eval("document.pform.PWD_CHK.value = ''") ;
									eval("document.pform.PWD.focus()") ;  
									return ;
								}
							}
						}
		
					//2011.01.05 - woni82
					//회원 가입시 주민등록번호를 체크하는 부분.
					//i-Pin 을 적용하면서 회원의 주민등록번호를 저장 안하기 때문에 주석처리하여 두었음.
					//차후 필요하다면 다시 주석해제하여 사용할 것.
					
					//juminCheck();
			        		//alert(juminNumcheck);
			        //if(juminNumCheck == false){
			            	//alert("12");
			        //	alert("중복된 주민등록번호가 있습니다");
			        //  return;
			        //}
					if(form1.PWD_CHK.value == ""){
				        alert("비밀번호 확인 부분을 입력하여 주십시오" );
						eval("document.pform.PWD_CHK.value = ''") ;
						eval("document.pform.PWD_CHK.focus()") ;  
				        return;
					} else {
						if(form1.PWD.value != form1.PWD_CHK.value) {
					        alert("패스워드가 일치하지 않습니다.\n확인하여 주십시오" );
							eval("document.pform.PWD.value = ''") ;
							eval("document.pform.PWD_CHK.value = ''") ;
							eval("document.pform.PWD.focus()") ;
							return;
						}		        
					}
					if(form1.deptname.value == "") {
						alert("부서명을 입력해주세요.");
						return;
					}
					if(document.all.officename.value.indexOf("6289999") != -1) {
						if(form1.PART_DATA.value == "") {
							alert("공사공단은 집적입력이 되지 않습니다. 부서명을 선택해주세요.");
							return;
						}
					}
					if(form1.hiddenjik.value == "") {
						alert("직급을 입력해주세요.");
						return;
					}
					
			        if( staticidcheck == true && staticemailcheck == true ) {
			        	/* document.pform.action = "https://hrd.incheon.go.kr/homepage/join.do?mode="+mode; */ 
			        	 /* document.pform.action = "http://hrd.incheon.go.kr/homepage/join.do?mode="+mode; */ 
			        	 document.pform.action = "https://hrd.incheon.go.kr/homepage/join.do?mode="+mode;
						document.pform.submit();        
			        }else if (staticidcheck == false){
			        	alert("아이디 중복체크를 하셔야 합니다.");
			        }else if(staticemailcheck == false){
			        	alert("이메일 중복체크를 하셔야 합니다."); 
			        }
			       return;
			    }
			}
			eval("var Str = document.pform.PWD.value") ;
			for(i=0; i<Str.length; i++){
				Chr = Str.charAt(i);   
				if(Str.length < 9 || Str.length > 12) {
					alert("비밀번호는 9자 에서, 12자 이하 이어야 합니다.") ;
					eval("document.pform.PWD.value = ''") ;
					eval("document.pform.PWD_CHK.value = ''") ;
					eval("document.pform.PWD.focus()") ;       
					return;     
				}
			}

			//2011.01.05 - woni82
			//회원 가입시 주민등록번호를 체크하는 부분.
			//i-Pin 을 적용하면서 회원의 주민등록번호를 저장 안하기 때문에 주석처리하여 두었음.
			//차후 필요하다면 다시 주석해제하여 사용할 것.
			
			//juminCheck();
	        		//alert(juminNumcheck);
	        //if(juminNumCheck == false){
	            	//alert("12");
	        //	alert("중복된 주민등록번호가 있습니다");
	        //  return;
	        //}
	        		//alert("13");
	        
	        
	        if( staticidcheck == true && staticemailcheck == true ) {
				 /* document.pform.action = "https://hrd.incheon.go.kr/homepage/join.do?mode="+mode; */ 
				 /* document.pform.action = "http://hrd.incheon.go.kr/homepage/join.do?mode="+mode;  */
				  document.pform.action = "https://hrd.incheon.go.kr/homepage/join.do?mode="+mode;
				document.pform.submit();        
	        }else if (staticidcheck == false){
	        	alert("아이디 중복체크를 하셔야 합니다.");
	        }else if(staticemailcheck == false){
	        	alert("이메일 중복체크를 하셔야 합니다.");
	        }
		}

		 function mailServ(servName) {
			 if(servName !='direct') {
				document.getElementById('mailserv').style.display='none';
				document.getElementById('mailserv').value=servName;
			 }
			 else{
				document.getElementById('mailserv').value='';
				document.getElementById('mailserv').style.display='';
				document.getElementById('mailserv').focus();
			 }
		}
		
		//우편번호 검색
		function searchZip(post1, post2, addr){
			var url = "/homepage/join.do";
			url += "?mode=zipcode";
			url += "&zipCodeName1=pform." + post1;
			url += "&zipCodeName2=pform." + post2;
			url += "&zipAddr=pform." + addr;
			pwinpop = popWin(url,"cPop","420","350","yes","yes");
		}
		
		function findJik() {
			var url = "/homepage/join.do";
			url += "?mode=findjik";
			pwinpop = popWin(url,"jPop","420","350","yes","yes");	
		}

		// 2011.01.11 - woni82
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
		
		//2010.01.11 - woni82
		onload = function()	{
			
			decodeName('<%=request.getParameter("username")%>');

			var regType = "<%=request.getParameter("regtype") %>";

			//주민등록번호를 가지고 생년월일 성별 처리를 하기 위한 설정
			//회원가입시 최소한의 기본정보를 셋팅해주기 위한 설정
			if(regType == 1){

				//주민등록번호
				var ssn1 = "<%=request.getParameter("ssn1") %>";
				var ssn2 = "<%=request.getParameter("ssn2") %>";

				//생년월일 구하기
				var year = "";
				var checkYear = ssn1.substring(0,1);
				if (checkYear == 0){
					year = "20"+ssn1.substring(0,2);
				}
				else{
					year = "19"+ssn1.substring(0,2);
				} 
				var month = ssn1.substring(2,4);
				var day = ssn1.substring(4,6);
	
				//alert(year+month+day);
				document.getElementById("bYear").value = year;
				document.getElementById("bMonth").value = month;
				document.getElementById("bDay").value = day;

				//성별구하기
				var sex = "";
				var gender = "";
				var checkSex = ssn2.substring(0,1);
				if(checkSex == 1 || checkSex == 3 || checkSex ==5 || checkSex == 7){
					sex = "M";
					gender = "남자";
				}
				else{
					sex = "F";
					gender = "여자";
				}
				document.getElementById("sex").value = sex;
				document.getElementById("gender").value = gender;
			}
			//아이핀 번호를 가지고 생년월일 성별 처리를 하기 위한 설정
			//회원가입시 최소한의 기본정보를 셋팅해주기 위한 설정
			else{
				//생년월일 구하기
				var birthdate = "<%=request.getParameter("birthdate")%>";
				var year = birthdate.substring(0,4);
				var month = birthdate.substring(4,6);
				var day = birthdate.substring(6,8);
	
				//alert(year+month+day);
				document.getElementById("bYear").value = year;
				document.getElementById("bMonth").value = month;
				document.getElementById("bDay").value = day;

				//성별구하기
				var sex = "";
				var gender = "";
				var checkSex = "<%=request.getParameter("sex")%>";
				if(checkSex == 1){
					sex = "M";
					gender = "남성";
				}
				else{
					sex = "F";
					gender = "여성";
				}
				document.getElementById("sex").value = sex;
				document.getElementById("gender").value = gender;
			}
		}

		function checkYn(checkyn) {
			if(checkyn == "Y") {
				document.getElementById("checkYn1").checked = true;
				document.getElementById("checkYn2").checked = false;
			}else if(checkyn == "N") {
				document.getElementById("checkYn1").checked = false;
				document.getElementById("checkYn2").checked = true;
				if(confirm("메인으로 이동 하시겠습니까?")) {
					document.location.href = "http://hrd.incheon.go.kr/";
				}
			}
			
			if(checkyn == "Y2") {
				document.getElementById("checkYn3").checked = true;
				document.getElementById("checkYn4").checked = false;
			}else if(checkyn == "N2") {
				document.getElementById("checkYn3").checked = false;
				document.getElementById("checkYn4").checked = true;
				if(confirm("메인으로 이동 하시겠습니까?")) {
					document.location.href = "http://hrd.incheon.go.kr/";
				}
			}
			if(document.getElementById("checkYn1").checked && document.getElementById("checkYn3").checked){
				 // 약관에 동의하십니까?
				if(confirm("회원으로 가입하시겠습니까?")) {
					document.getElementById("info_form").style.display = "";
					document.getElementById("terms_area").style.display = "none";
				}
			}

		}
		function joinCancle() {
			if(confirm("메인으로 이동 합니다.")) {
				document.location.href='http://hrd.incheon.go.kr/';
			}
		}
	</script>
	<script type="text/javascript">
		function goPopup(){
			// 주소검색을 수행할 팝업 페이지를 호출합니다.
			// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
			var pop = window.open("/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
		}


		function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
				// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
				document.pform.newAddr1.value = roadAddrPart1;
				document.pform.newAddr2.value = roadAddrPart2 +" "+ addrDetail;
				document.pform.newHomePost.value = zipNo;
		}
	</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/login/main_login.jsp" flush="false"/>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual1.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>회원가입</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; <span>회원가입</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
              <form id="pform" name="pform" method="post">
					
					<%
						StringBuffer s = new StringBuffer();
						s.append("");
					%>
						<div id="hiddenidform">
							<%= s%>
						</div>
						<input type="hidden" name="fileno" value=""/>
	
						<!-- 회원가입 타입을 지정하기 위한 값 -->
						<input type="hidden" id="regtype"name="regtype" value="<%=request.getParameter("regtype")%>"/>
						
						<!-- regtype : 2 i-Pin 실명인증 -->
						<input type="hidden" id="dupinfo" name="dupinfo" value="<%=request.getParameter("dupinfo")%>"/>
						<input type="hidden" id="virtualno" name="virtualno" value="<%=request.getParameter("virtualno")%>"/>

						<input type="hidden" id="age" name="age" value="<%=request.getParameter("age")%>"/>
						<input type="hidden" id="birthdate" name="birthdate" value="<%=request.getParameter("birthdate")%>"/>
						
						<input type="hidden" id="nationalinfo" name="nationalinfo" value="<%=request.getParameter("nationalinfo")%>"/>
						<input type="hidden" id="authinfo" name="authinfo" value="<%=request.getParameter("authinfo")%>"/>
						<!-- contentOut s ===================== -->
						<div id="subContentArear">
							<!-- content image
							<div id="contImg"><img src="/images/skin1/sub/img_cont00.jpg" alt="" /></div>
							//content image -->
							
							<div class="spaceTop"></div>
							<!-- content s ===================== -->
<style type="text/css">
	.terms_text{ margin:8px 0 14px 0; border:1px solid #e5e0cf; padding:10px 15px; overflow:auto; color:#80734d; height:198px;}
	.terms_text h5{ line-height:2em; font-size:0.917em; margin:0;}
	.terms_text p{ line-height:1.5em; font-size:0.917em; margin-top:4px;}
    .text_size {font-size:1.3em}
</style>		
							<div id="content">
								<!-- title --> 
								<div id="terms_area">									
									<div>
											<div class="terms_text">
                                            <h2>개인정보수집동의(개인정보처리방침)</h2><br /><br />
											<div class="text_size"> 


            <P><SPAN>인천광역시인재개발원은</SPAN><SPAN'> 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은「</SPAN><SPAN>개인정보처리방침</SPAN><SPAN'>」을 두고 있습니다.</SPAN></P>

<P><BR></P>

<P><SPAN'>인천광역시인재개발원은 개인정보 처리방침을 개정하는 경우 홈페이지를 통하여 공지할 것입니다.</SPAN></P>

<P><BR></P>

<P><SPAN>본 방침은 2014년 8월 7일부터 시행됩니다.</SPAN></P>

<P><BR></P>

<P><SPAN>인천광역시인재개발원</SPAN><SPAN'>이 운영하고 있는 웹사이트는 다음과 같으며, 이 방침은 별도의 설명이 없는 한 우리 원에서 운영하는 모든 웹사이트에 적용됨을 알려드립니다.</SPAN></P>

<P STYLE='text-align:left;'><SPAN'>&nbsp;&nbsp;- hrd.incheon.go.kr&nbsp;&nbsp; : 인천광역시인재개발원 대표 홈페이지</SPAN></P>

<P STYLE='text-align:left;'><SPAN'>&nbsp;&nbsp;- m.hrd.incheon.go.kr : 인재개발원 대표 홈페이지(모바일용)</SPAN></P>

<P><BR></P>

<P><SPAN class="titles"><strong>제1조 개인정보의 처리 목적</strong></SPAN></P>

<P><SPAN'>개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적 이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.</SPAN></P>

<P>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="28" height="38" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>연번</SPAN></P>
	</TD>
	<TD width="53" height="38" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>파일명</SPAN></P>
	</TD>
	<TD width="86" height="38" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>처리목적</SPAN></P>
	</TD>
	<TD width="212" height="38" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>처 리 항 목</SPAN></P>
	</TD>
	<TD width="81" height="38" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>수집방법</SPAN></P>
	</TD>
	<TD width="98" height="38" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>운영근거</SPAN></P>
	</TD>
	<TD width="45" height="38" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>보유</SPAN></P>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>기간</SPAN></P>
	</TD>
	<TD width="49" height="38" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>담당</SPAN></P>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>부서</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="28" height="135" valign="middle" style='border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>1</SPAN></P>
	</TD>
	<TD width="53" height="135" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>교육생정&nbsp; 보</SPAN></P>
	</TD>
	<TD width="86" height="135" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'></SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>교육생의</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>학적관리</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'></SPAN></P>
	</TD>
	<TD width="212" height="135" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&#8228; 필수항목 </SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;: 성명, 생년월일, 성별, 아이디, </SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;&nbsp;비밀번호, </SPAN><SPAN STYLE='font-family:"굴림";letter-spacing:-1.6pt;'>아이핀(I-PIN)식별번호</SPAN><SPAN STYLE='font-family:"굴림";letter-spacing:0.6pt;'>,</SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp; </SPAN><SPAN STYLE='font-family:"굴림";letter-spacing:-1.0pt;'>이메일, 휴대전화, 주소, 소속기관,</SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;&nbsp;부서, 직급, 최초임용일,</SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;&nbsp;현직급임용일</SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&#8228; 선택항목</SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;: 집전화, 직장전화, 직위</SPAN></P>
	</TD>
	<TD width="81" height="135" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>온라인 수집</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>(홈페이지</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>회원신청)</SPAN></P>
	</TD>
	<TD width="98" height="135" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>지방공무원</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>교육훈련법</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>시행령&nbsp;</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>제11조</SPAN></P>
	</TD>
	<TD width="45" height="135" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>회원</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>탈퇴시</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>까지</SPAN></P>
	</TD>
	<TD width="49" height="135" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>인  재</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>양성과</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="28" height="152" valign="middle" style='border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>2</SPAN></P>
	</TD>
	<TD width="53" height="152" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>강사</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>정보</SPAN></P>
	</TD>
	<TD width="86" height="152" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>강의 의뢰, 강의료 지급, 소식 및 고지사항 전달을 위한 강사정보관리</SPAN></P>
	</TD>
	<TD width="212" height="152" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&#8228;&nbsp; 필수항목 </SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;: 성명, 주민등록번호</SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&#8228; 선택항목 </SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;: 성명(한자), 은행명, 계좌번호, </SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp; </SPAN><SPAN STYLE='font-family:"굴림";letter-spacing:0.5pt;'>담당분야, 직업, </SPAN><SPAN STYLE='font-family:"굴림";'>휴대전화,</SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp; </SPAN><SPAN STYLE='font-family:"굴림";letter-spacing:0.5pt;'>집주소, 집전화,</SPAN><SPAN STYLE='font-family:"굴림";'> 사무실주소,</SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;&nbsp;직장전화,&nbsp; 이메일, 소속, </SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;&nbsp;경력사항, 저서 및 주요논문, </SPAN></P>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;&nbsp;강의과목, 강사소개서</SPAN></P>
	</TD>
	<TD width="81" height="152" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";letter-spacing:-1.7pt;'>&nbsp;오프라인 수집</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>(서면 수집)</SPAN></P>
	</TD>
	<TD width="98" height="152" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>국세기본법 시행령</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>제68조</SPAN></P>
	</TD>
	<TD width="45" height="152" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>준영구</SPAN></P>
	</TD>
	<TD width="49" height="152" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:double #000000 1.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>인&nbsp; 재</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>양성과</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="28" height="73" valign="middle" style='border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>3</SPAN></P>
	</TD>
	<TD width="53" height="73" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.3pt;'>시설대여</SPAN><SPAN STYLE='font-family:"굴림";'> 정보</SPAN></P>
	</TD>
	<TD width="86" height="73" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>시설대여</SPAN></P>
	</TD>
	<TD width="212" height="73" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P STYLE='text-align:left;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&#8228; 필수항목</SPAN></P>
	<P STYLE='text-align:left;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;: 성명, 생년월일, 주소,</SPAN></P>
	<P STYLE='text-align:left;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;&nbsp;&nbsp;핸드폰번호, 단체명</SPAN></P>
	</TD>
	<TD width="81" height="73" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>오프라인 수집</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>(서면 수집)</SPAN></P>
	</TD>
	<TD width="98" height="73" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";letter-spacing:-1.1pt;'>인천광역시 인재개발원</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";letter-spacing:-1.1pt;'> </SPAN><SPAN STYLE='font-family:"굴림";'>시설사용료 징수 조례</SPAN></P>
	</TD>
	<TD width="45" height="73" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>준영구</SPAN></P>
	</TD>
	<TD width="49" height="73" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>교&nbsp; 육</SPAN></P>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>지원과</SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P><SPAN><BR></SPAN></P>

<P><SPAN class="titles"><strong>제2조 처리하는 개인정보의 항목</strong></SPAN></P>

<P><SPAN'>인천광역시인재개발원이 처리하는 개인정보의 항목 및 수집 방법은 제1조와 같습니다.</SPAN></P>

<P><BR></P>

<P><SPAN class="titles"><strong>제3조 개인정보의 처리 및 보유 기간</strong></SPAN></P>

<P><SPAN'>이용자 개인정보는 원칙적으로 개인정보의 처리목적이 달성되면 지체없이 파기합니다. 단, 1조에 명시된 항목의 정보에 대하여는 제1조의 사유로 명시한 기간 동안 보존합니다.</SPAN></P>

<P><SPAN'><BR></SPAN></P>

<P><SPAN class="titles"><strong>제4조 개인정보의 제3자 제공</strong></SPAN></P>

<P><SPAN'>인천광역시인재개발원은 원칙적으로 이용자의 개인정보를 제1조(개인정보의 처리 목적)에서 명시한 범위 내에서 처리하며, 회원가입 및 회원의 이용 서비스 향상을 위해 다음과 같이 정보주체의 개인정보를 제3자에게 제공하고 있으며 정보주체의 동의 없이는 제공되지 않습니다. </SPAN></P>
<P>&nbsp;&nbsp;
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="152" height="32" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>제공받는 자 </SPAN></P>
	</TD>
	<TD width="152" height="32" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>정보의 이용 목적 </SPAN></P>
	</TD>
	<TD width="159" height="32" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>정보의 제공 범위 </SPAN></P>
	</TD>
	<TD width="193" height="32" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>정보의 보유 및 이용 기간 </SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="152" height="80" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>인천광역시인재개발원 </SPAN><SPAN STYLE='font-family:"굴림";letter-spacing:-1.6pt;'>홈페이지를 이용하는 기관</SPAN></P>
	</TD>
	<TD width="152" height="80" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";letter-spacing:-1.2pt;'>교육운영</SPAN></P>
	</TD>
	<TD width="159" height="80" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>성명, 생년월일, 성별, 소속기관, 부서, 직급</SPAN></P>
	</TD>
	<TD width="193" height="80" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>회원 탈퇴 시까지</SPAN></P>
	</TD>
</TR>
</TABLE>&nbsp;</P>


<P><SPAN'>단, 개인정보보호법 제18조 제2항에 의거 다음에 해당하는 경우에는 예외로 합니다.</SPAN></P>

<P><SPAN'>&nbsp;가. 정보주체로부터 별도의 동의를 받은 경우 </SPAN></P>

<P><SPAN'>&nbsp;나. 다른 법률에 특별한 규정이 있는 경우 </SPAN></P>

<P><SPAN'>&nbsp;다. 정보주체 또는 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우 </SPAN></P>

<P><SPAN'>&nbsp;라. 통계작성 및 학술연구 등의 목적을 위하여 필요한 경우로서 특정 개인을 알아 볼 수 없는 형태로 개인정보를 제공하는 경우 </SPAN></P>

<P><SPAN'>&nbsp;마. 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공하지 아니하면 다른 법률에서 정하는 소관 업무를 수행할 수 없는 경우로서 보호위원회의 심의·의결을 거친 경우 </SPAN></P>

<P><SPAN'>&nbsp;바. 조약, 그 밖의 국제협정의 이행을 위하여 외국정부 또는 국제기구에 제공하기 위하여 필요한 경우 </SPAN></P>

<P><SPAN'>&nbsp;사. 범죄의 수사와 공소의 제기 및 유지를 위하여 필요한 경우 </SPAN></P>

<P><SPAN'>&nbsp;아. 법원의 재판업무 수행을 위하여 필요한 경우 </SPAN></P>

<P><SPAN'>&nbsp;자. 형 및 감호, 보호처분의 집행을 위하여 필요한 경우 </SPAN></P>

<P><SPAN'>&nbsp;차. 업무상 연락을 위하여 회원의 정보(성명, 주소, 전화번호)를 사용하는 경우</SPAN></P>

<BR>

<P><SPAN class="titles"><strong>제5조 개인정보처리의 위탁에 관한 사항</strong></SPAN></P>

<P><SPAN'>인천광역시인재개발원은 개인정보 처리를 위탁하는 사항은 다음과 같습니다.</SPAN></P>

<P><SPAN>&nbsp;가. 위탁하는 업체</SPAN></P>

<p>
<table>
<TR>
	<TD width="30px" height="auto" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>연번 </SPAN></P>
	</TD>
	<TD width="auto" height="auto" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>업체명</SPAN></P>
	</TD>
	<TD width="auto" height="auto" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>위탁내용</SPAN></P>
	</TD>
	<TD width="auto" height="auto" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>주소</SPAN></P>
	</TD>
	<TD width="auto" height="auto" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>전화</SPAN></P>
	</TD>
	<TD width="auto" height="auto" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>근무시간</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="30px" height="auto" valign="middle" style='text-align: center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>1</SPAN>
		</P>
	</TD>
	<TD width="100px;" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>(주)애니에듀</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>인천광역시인재개발원 사이버교육센터 웹사이트 및 콘텐츠 유지보수 수행</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>서울특별시 금천구 가산디지털2로 123, 704호</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>02-865-5640</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>09:00 ~ 18:00</SPAN>
		</P>
	</TD>
</TR>
<TR>
	<TD width="30px" height="auto" valign="middle" style='text-align: center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>2</SPAN>
		</P>
	</TD>
	<TD width="100px;" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>로제타스톤코리아</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>사이버외국어교육 언어학습솔루션과정 임차</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>서울특별시 영등포구 영신로 220</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>1577-9613</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>09:00 ~ 18:00</SPAN>
		</P>
	</TD>
</TR>
<!-- <TR>
	<TD width="30px" height="auto" valign="middle" style='text-align: center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>3</SPAN>
		</P>
	</TD>
	<TD width="100px;" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>㈜휴넷</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>인천시민사이버교육센터 콘텐츠 임차 운영</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>서울특별시 구로구 디지털로26길 5 에이스하이엔드타워 1차 8층</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>1588-6559</SPAN>
		</P>
	</TD>
	<TD width="auto" height="auto" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<P STYLE='line-height:120%;'>
			<SPAN STYLE='font-family:"굴림";'>09:00 ~ 18:00</SPAN>
		</P>
	</TD>
</TR> -->
</table>

</p>

<!-- <P><SPAN>&nbsp;&nbsp;- 업 체 명 : ㈜니트로아이</SPAN></P>

<P><SPAN>&nbsp;&nbsp;- 위탁내용 : 인천광역시인재개발원 사이버교육센터 웹사이트 및 콘텐츠 유지보수 수행</SPAN></P>

<P><SPAN>&nbsp;&nbsp;- 주&nbsp;&nbsp;&nbsp; 소 : 경기도 수원시 팔달구 경수대로 446번길 24 니트로빌딩 5층</SPAN></P>

<P><SPAN>&nbsp;&nbsp;- 전&nbsp;&nbsp;&nbsp; 화 : 031-255-4040</SPAN></P>

<P><SPAN>&nbsp;&nbsp;- 근무시간 : 09:00 ~ 18:00</SPAN></P> -->

<P><SPAN>&nbsp;나. 개인정보의 안전관리에 관한 사항</SPAN></P>

<P><SPAN>&nbsp;&nbsp;&nbsp; </SPAN><SPAN>개인정보의 처리업무를 위탁하는 경우 다음의 내용이 포함된 문서에 의하여 처리하고 있습니다</SPAN><SPAN>.</SPAN></P>

<P><SPAN>&nbsp;&nbsp;- 위탁업무의 목적 및 범위 : 인재개발원 시스템 유지보수 / 인재개발원 보유 개인정보 </SPAN></P>

<P><SPAN>&nbsp;&nbsp;- 수탁업체의 개인정보 재위탁 금지</SPAN></P>

<P><SPAN>&nbsp;&nbsp;- 출입통제, 잠금장치 등 개인정보 안정성 확보 조치 마련</SPAN></P>

<P><SPAN>&nbsp;&nbsp;- 위탁업체의 관리현황점검 등 감독 강화</SPAN></P>

<P><SPAN>&nbsp;&nbsp;- 수탁업체의 개인정보 처리 준수 의무 위반 시 손해배상 책임</SPAN></P>

<P><SPAN>위탁계약 시 개인정보보호 관련 법규의 준수, 개인정보에 관한 제3자 제공 금지 및 책임부담 등을 명확히 규정하고, 당해 계약내용을 서면 및 전자 보관하고 있습니다. 업체 변경시 공지사항 및 개인정보처리방침을 통해 고지하겠습니다.</SPAN></P>

<P><SPAN><BR></SPAN></P>

<P><SPAN class="titles"><strong>제6조 정보주체의 권리&#12539;의무 및 그 행사방법</strong></SPAN></P>

<P STYLE='text-align:left;'><SPAN'>정보주체는 다음과 같은 권리를 행사 할 수 있으며, 만14세 미만 아동의 법정대리인은 그 아동의 개인정보에 대한 열람, 정정·삭제, 처리정지를 요구할 수 있습니다.</SPAN></P>

<P><SPAN'> </SPAN><SPAN>1. 개인정보 열람 요구</SPAN><SPAN'> :「개인정보보호법」 제35조(개인정보의 열람)에 따라 열람을 요구할 수 있습니다. </SPAN></P>

<P><SPAN'>단, 아래에 해당하는 경우에는 법 제35조 4항에 의하여 열람을 제한할 수 있습니다.</SPAN></P>

<P><BR></P>

<P><SPAN'>&nbsp;&nbsp;가. 법률에 따라 열람이 금지되거나 제한되는 경우</SPAN></P>

<P><SPAN'>&nbsp;&nbsp;나. </SPAN><SPAN>다른 사람의 생명·신체를 해할 우려가 있거나 다른 사람의 재산과 그 밖의 이익을 부당하게</SPAN><SPAN'> </SPAN></P>

<P><SPAN'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;침해할 우려가 있는 경우</SPAN></P>

<P><SPAN'>&nbsp;&nbsp;다. </SPAN><SPAN>공공기관이 다음 각 목의 어느 하나에 해당하는 업무를 수행할 때 중대한 지장을 초래하는 경우</SPAN></P>

<P><SPAN'>1) 조세의 부과·징수 또는 환급에 관한 업무 </SPAN></P>

<P STYLE='margin-left:27.5pt;text-indent:-27.5pt;'><SPAN'>2)</SPAN>「초·중등교육법」 및 「고등교육법」에 따른 각급 학교,「평생교육법」에 따른 평생교육시설, 그 밖의 다른 법률에 따라 설치된 고등교육기관에서의 성적평가 또는 입학자선발에 관한 업무</P>

<P><SPAN'>3) 학력·기능 및 채용에 관한 시험, 자격심사에 관한 업무</SPAN></P>

<P><SPAN'>4) 보상금·급부금 산정 등에 대하여 진행 중인 평가 또는 판단에 관한 업무 </SPAN></P>

<P><SPAN'>5) 다른 법률에 따라 진행 중인 감사 및 조사에 관한 업무 </SPAN></P>

<P><BR></P>

<P><SPAN'>&nbsp; </SPAN><SPAN>2. 개인정보 정정·삭제 요구</SPAN><SPAN'> :「개인정보보호법」 제36조(개인정보의 정정·삭제)에 따라 정정·삭제를 요구할 수 있습니다. 다만, 다른 법령에서 그 개인정보가 수집대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다. </SPAN></P>

<P><BR></P>

<P><SPAN>&nbsp; </SPAN><SPAN>3. 개인정보 처리정지 요구</SPAN><SPAN> :「개인정보보호법」 제37조(개인정보의 처리정지 등)에 따라 처리정지를 요구할 수 있습니다. 단, 아래에 해당하는 경우에는 법 제37조 2항에 의하여 처리정지 요구를 거절할 수 있습니다. </SPAN></P>

<P><BR></P>

<P><SPAN>&nbsp;&nbsp;가. 법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우 </SPAN></P>

<P STYLE='margin-left:22.2pt;text-indent:-22.2pt;line-height:150%;'><SPAN>&nbsp;&nbsp;나. </SPAN><SPAN>다른 사람의 생명·신체를 해할 우려가 있거나 다른 사람의 재산과 그 밖의 이익을 부당하게 침해 할 우려가 있는 경우</SPAN></P>

<P STYLE='margin-left:22.9pt;text-indent:-22.9pt;line-height:150%;'><SPAN>&nbsp;&nbsp;다. </SPAN><SPAN>공공기관이 개인정보를 처리하지 아니하면 다른 법률에서 정하는 소관업무를 수행할 수 없는 경우</SPAN>

<P STYLE='margin-left:22.3pt;text-indent:-22.3pt;line-height:150%;'><SPAN>&nbsp;&nbsp;라. 개인정보를 처리하지 아니하면 정보주체와 약정한 서비스를 제공하지 못하는 등 계약의 이행이 곤란한 경우로서 정보주체가 그 계약의 해지 의사를 명확하게 밝히지 아니한 경우</SPAN></P>

<P><BR></P>

<P><SPAN>&nbsp; </SPAN><SPAN>4. 개인정보 열람, 정정·삭제, 처리정지 처리절차 </SPAN></P>

<P><SPAN>&nbsp;&nbsp;가. 개인정보 열람, 정정, 삭제, 처리정지 청구는 개인정보보호종합지원 포털&nbsp; (www.privacy.go.kr)을 통해 신청하실 수 있습니다.</SPAN></P>

<P><SPAN>&nbsp;&nbsp;나. 개인정보 열람 등 요구방법</SPAN></P>

<P><SPAN>1) 개인정보보호종합지원 포털(www.privacy.go.kr)에 접속</SPAN></P>

<P><SPAN>2) 개인정보열람 등 요구 -&gt; 본인인증 확인 </SPAN></P>

<P><SPAN>3) [개인정보파일 목록검색]을 통한 대상기관 선택</SPAN></P> 

<P><SPAN>4) 신청유형 선택(개인정보 열람, 개인정보 정정·삭제, 개인정보 처리정지 중 택 1)</SPAN></P>

<P><SPAN>5) 요구서 작성 후 민원청구</SPAN></P>

<P><SPAN><BR></SPAN></P>

<P><SPAN class="titles"><strong>제7조 개인정보의 파기</strong></SPAN></P>

<P><SPAN>인천광역시인재개발원은 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 해당 개인정보를 파기합니다.</SPAN></P>

<P><SPAN>&nbsp;가. 파기 절차</SPAN></P>

<P><SPAN>&nbsp;&nbsp;&nbsp;인천광역시인재개발원은 파기하여야 하는 개인정보에 대해 개인정보 파기계획을 수립하여 파기합니다. 파기 사유가 발생한 개인정보를 선정하고, 분야별 개인정보보호 책임자의 승인하에 개인정보를 파기합니다.</SPAN></P>


<P><SPAN><BR></SPAN></P>

<P STYLE='margin-top:5.0pt;line-height:150%;'><SPAN>&nbsp;나. 파기 방법</SPAN></P>

<P><SPAN>&nbsp;&nbsp; </SPAN><SPAN>인천광역시인재개발원은 전자적 파일 형태로 기록·저장된 개인정보는 기록을 재생할 수 없도록파기하며, 종이 문서에 기록·저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.</SPAN><SPAN> </SPAN></P>



<P><BR></P>

<P><SPAN class="titles"><strong>제8조 개인정보의 안전성 확보 조치</strong></SPAN></P>

<P><SPAN>인천광역시인재개발원은 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.</SPAN></P>

<P><SPAN>가. 개인정보 취급직원의 최소화 및 교육 </SPAN></P>

<P><SPAN>&nbsp;&nbsp;&nbsp; </SPAN><SPAN>개인정보를 취급하는 직원은 반드시 필요한 인원에 한하여 지정·관리하고 있으며 취급직원을 대상으로 안전한 관리를 위한 교육을 실시하고 있습니다</SPAN><SPAN> </SPAN></P>
<P><BR></P>

<P><SPAN>나. 개인정보에 대한 접근 제한 </SPAN></P>

<P><SPAN>&nbsp;&nbsp;&nbsp; 개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여·변경·말소를 통하여</SPAN></P>

<P><SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;개인정보에 대한 접근통제를 위한 필요한 조치를 하고 있으며 침입차단시스템을 이용하여</SPAN></P>

<P><SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;외부로부터의 무단 접근을 통제하고 있습니다. </SPAN></P>

<P><BR></P>

<P><SPAN>다. 접속기록의 보관 </SPAN></P>

<P><SPAN>&nbsp;&nbsp;&nbsp; </SPAN><SPAN>개인정보처리시스템에 접속한 기록(웹 로그, 요약정보 등)을 최소 6개월 이상 보관·관리하고 있습니다. </SPAN><SPAN> </SPAN></P>


<P><BR></P>

<P><SPAN>라. 개인정보의 암호화 </SPAN></P>

<P><SPAN>&nbsp;&nbsp;&nbsp; 개인 식별번호와 비밀번호 등 개인정보는 암호화 등을 통해 안전하게 저장 및 관리되고 있습니다. 또한 중요한 데이터는 저장 및 전송 시 암호화하여 사용하는 등의 별도 보안기능을사용하고 있습니다.</SPAN></P>

<BR>

<P><SPAN class="titles"><strong>제9조 영상정보처리기기[CCTV] 에서의 개인정보처리</strong></SPAN></P>

<P><SPAN>인천광역시인재개발원은 시설안전관리를 위하여 CCTV를 설치운영함에 있어 법령의 규정에 의해서만 화상정보를 수집&#8228;보유하며, 보유하고 있는 CCTV화상은 관계법령에 적법하고 적정하게 처리하여 여러분의 권익이 침해받지 않도록 노력하고 있습니다.</SPAN></P>
<P><BR></P>
<P><SPAN>인천광역시 인재개발원이 공익목적을 위하여 설치 운영중인 영상정보처리기기(CCTV)의 현황은 다음과 같습니다.</SPAN></P>

<P><BR></P>

<P><SPAN>○ 개인영상정보 보호책임자 : 인재개발원장</SPAN></P>

<P><SPAN>○ CCTV 촬영시간 : 상시(24시간)</SPAN></P>

<P><SPAN>○ 화상정보보유기간 : 30일</SPAN></P>

<P><SPAN>○ 안내판 규격 : 300mm * 300mm (경비실 1개, 본관 2개, 체육관 1개)</SPAN></P>

<P><SPAN>○ 카메라 대수 : 시설물 관리용 14대</SPAN></P>

<P><SPAN>○ 카메라 위치 </SPAN></P>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
	<tr>
		<td rowspan="6" valign="top" width="30px"></td>
		<td rowspan="5" valign="top" width="80px">본관 11대</td>  
		<td width="50px">1층:</td>
		<td width="200px">로비2대, 복도1대, 출입구1대.</td>
	</tr>
	
	<tr>
		<td>2층:</td>
		<td>로비1대, 강당옆1대.</td>
	</tr>
	
	<tr>
		<td>3층:</td>
		<td>로비1대.</td>
	</tr>
	
	<tr>
		<td>4층:</td>
		<td>로비1대.</td>
	</tr>
	
	<tr>
		<td>옥상 :</td>
		<td>체육관1대, 인발연1대, 운동장1대.</td>
	</tr>
	
	<tr>
		<td >외관 3대</td>  
		<td colspan="2">1층 주차장 1대, 경비실 2대(정문출입구, 주차장)</td>
	</tr>
	</table> 
	




<P><BR></P>

<P><SPAN class="titles"><strong>제10조 권익침해 구제방법</strong></SPAN></P>

<P><SPAN>개인정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보 분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다.</SPAN></P>

<P><SPAN>이 밖에 기타 개인정보침해의 신고 및 상담에 대하여는 아래의 기관에 문의하시기를 바랍니다.</SPAN></P>

<P><SPAN><BR></SPAN></P>

<P STYLE='line-height:130%;'>&nbsp;1. 개인정보 분쟁조정위원회 : 02-405-5150 (www.kopico.or.kr)</P>

<P STYLE='line-height:130%;'>&nbsp;2. 개인정보 침해신고센터 : (국번없이)118 (privacy.kisa.or.kr)</P>

<P STYLE='line-height:130%;'>&nbsp;3. 대검찰청 사이버범죄수사단 : 02-3480-3571 (cybercid@spo.go.kr)</P>

<P STYLE='line-height:130%;'>&nbsp;4. 경찰청 사이버테러대응센터 : 1566-0112 (<A HREF="http://www.netan.go.kr" TARGET="_self">www.netan.go.kr</SPAN></A>)</P>

<P><BR></P>

<P><SPAN>또한, 개인정보의 열람, 정정·삭제, 처리정지 등에 대한 정보주체자의 요구에 대하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익을 침해 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다. ☞ 중앙행정심판위원회(www.simpan.go.kr)</P>

<P><BR></P>

<P><SPAN class="titles"><strong>제11조 개인정보보호 책임자 및 담당자 연락처</strong></SPAN></P>

<P><SPAN'>인천광역시인재개발원은 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 개인정보 보호책임자 및 담당자를 지정하고 있습니다.</SPAN></P>

<P STYLE='line-height:140%;'><BR></P>

<P STYLE='margin-left:16.8pt;text-indent:-16.8pt;line-height:140%;'><SPAN >&nbsp;1. 인천광역시인재개발원 개인정보 보호책임자</SPAN></P>

<P STYLE='line-height:140%;'><SPAN >&nbsp;&nbsp;&nbsp; 담당부서 : 인재개발원</SPAN></P>

<P STYLE='line-height:140%;'><SPAN >&nbsp;&nbsp; 직 위 : 원&nbsp; 장</SPAN></P>

<P STYLE='line-height:140%;'><SPAN >&nbsp;&nbsp; 성 명 : 백 완 근</SPAN></P>

<P STYLE='line-height:140%;'><SPAN >&nbsp;&nbsp; 전화번호 : 032-440-7601</SPAN></P>

<P STYLE='line-height:140%;'><BR></P>

<P STYLE='margin-left:16.8pt;text-indent:-16.8pt;line-height:140%;'><SPAN >&nbsp;2. 인천광역시인재개발원 개인정보 보호담당자</SPAN></P>

<P STYLE='line-height:140%;'><SPAN >&nbsp;&nbsp; 담당부서 : 인재양성과</SPAN></P>

<P STYLE='line-height:140%;'><SPAN >&nbsp;&nbsp; 성 명 : 김 기 진</SPAN></P>

<P STYLE='line-height:140%;'><SPAN >&nbsp;&nbsp; 전화번호 : 032-440-7684</SPAN></P>

<P STYLE='text-align:left;line-height:140%;'><SPAN >&nbsp;&nbsp; 이 메 일 : blue092678@korea.kr</SPAN></P>

<P STYLE='text-align:left;line-height:140%;'><BR></P>

<P STYLE='margin-left:16.8pt;text-indent:-16.8pt;line-height:140%;'><SPAN >&nbsp;3. 개인정보 분야별 보호책임자 및 담당자 연락처</SPAN></P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="46" height="32" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>연번</SPAN></P>
	</TD>
	<TD width="80" height="32" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>담당부서</SPAN></P>
	</TD>
	<TD width="160" height="32" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>파일명</SPAN></P>
	</TD>
	<TD width="150" height="32" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>분야별 보호책임자</SPAN></P>
	</TD>
	<TD width="143" height="32" valign="middle" bgcolor="#e2fed2" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 1.1pt;border-bottom:double #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"돋움";'>분야별 보호담당자</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="46" height="38" valign="middle" style='border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림체";'>1</SPAN></P>
	</TD>
	<TD width="80" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림체";'>인재양성과</SPAN></P>
	</TD>
	<TD width="160" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>공무원 학적부</SPAN></P>
	</TD>
	<TD width="150" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"굴림체";'>인재양성과장</SPAN></P>
	<P STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"굴림체";'>032-440-7614</SPAN></P>
	</TD>
	<TD width="143" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림체";'>김기진 032-440-7684</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="46" height="38" valign="middle" style='border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'>2</P>
	</TD>
	<TD width="80" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림체";'>교육지원과</SPAN></P>
	</TD>
	<TD width="160" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>영상정보처리기기(CCTV)</SPAN></P>
	</TD>
	<TD width="150" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"굴림체";'>교육지원과장</SPAN></P>
	<P STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"굴림체";'>032-440-7610</SPAN></P>
	</TD>
	<TD width="143" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림체";'>김성호 032-440-7624</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="46" height="34" valign="middle" style='border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'>3</P>
	</TD>
	<TD width="80" height="34" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림체";'>인재양성과</SPAN></P>
	</TD>
	<TD width="160" height="34" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>강사 DB</SPAN></P>
	</TD>
	<TD width="150" height="34" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"굴림";'>인재양성과장</SPAN></P>
	<P STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"굴림";'>032-440-7614</SPAN></P>
	</TD>
	<TD width="143" height="34" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림체";'>김수진 032-440-7685</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="46" height="34" valign="middle" style='border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'>4</P>
	</TD>
	<TD width="80" height="34" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림체";'>교육지원과</SPAN></P>
	</TD>
	<TD width="160" height="34" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>시설대여</SPAN></P>
	</TD>
	<TD width="150" height="34" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"굴림체";'>교육지원과장</SPAN></P>
	<P STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"굴림";'>032-440-7610</SPAN></P>
	</TD>
	<TD width="143" height="34" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"굴림";'>김미정 032-440-7633</SPAN></P>
	</TD>
</TR>
</TABLE></P> 

<P><SPAN><BR></SPAN></P>

<P><SPAN class="titles"><strong>제12조 개인정보 처리방침의 변경</strong></SPAN></P>

<P><SPAN'>이 개인정보처리방침은 시행일로부터 적용되며, 분야별로 관리되는 개인정보파일의 정보 주체수 변경시는 고지를 생략합니다.</SPAN></P>

<P><SPAN'><BR></SPAN></P>

<P STYLE='text-align:left;'><SPAN>별지 : 개인정보처리방침 변경 이력</SPAN></P>

<P STYLE='line-height:130%;'><SPAN >○ 2012. 10. 25&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 개인정보처리방침 수립</SPAN></P>

<P STYLE='line-height:130%;'><SPAN >○ 2013. 04. 09&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 개인정보처리방침 수정</SPAN></P>

<P STYLE='line-height:130%;'><SPAN >○ 2020. 05. 20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 개인정보처리방침 수정</SPAN></P>

<P STYLE='line-height:130%;'><SPAN >○ 2020. 10. 19&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 개인정보처리방침 수정</SPAN></P>

<P STYLE='line-height:130%;'><SPAN >○ 2021. 09. 24&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 개인정보처리방침 수정</SPAN></P>

<P><SPAN'><BR></SPAN></P>

<P><SPAN'><BR></SPAN></P>

<P><BR></P>



											</div>
		


											</div>
											<p class="terms_bom" style="text-align:center;">정보 주체는 개인정보보호법 제15조에 따라 개인정보 수집 및 이용에 따른 동의를 거부할 수 </p>
											<p class="terms_bom" style="text-align:center;">있습니다. 그러나 동의 거부 시 인천광역시 인재개발원 홈페이지에 회원가입이 되지 않으며, </p>
											<p class="terms_bom" style="text-align:center;">공무원 집합교육 및 e-러닝(외국어) 신청을 할 수 없습니다. </p>
											<!-- p class="terms_bom" style="text-align:center;">회원으로 가입하시겠습니까?</p -->
										</div>
									<div style="text-align:center;">
										<input type="radio" value="Y" class="radio01" id="checkYn1" onclick="checkYn('Y');"/>
										<label for="" class="label01">동의함</label>
										<input type="radio" value="N" class="radio01" id="checkYn2" onclick="checkYn('N');"/>
										<label for="" class="label01">동의하지 않음</label>
									</div>
								</div>

<style type="text/css">
	.terms_text{ margin:8px 0 14px 0; border:1px solid #e5e0cf; padding:10px 15px; overflow:auto; color:#80734d; height:198px;}
	.terms_text h5{ line-height:2em; font-size:0.917em; margin:0;}
	.terms_text p{ line-height:1.5em; font-size:0.917em; margin-top:4px;}
    .text_size {font-size:1.3em}
</style>	

								<div id="content">
								<!-- title --> 
								<div id="terms_area" display="none">									
									<div>
											<div class="terms_text">
                                            <h2>수집한 개인정보의 제3자 제공동의</h2><br /><br />
											<div class="text_size"> 

<P><SPAN class="titles"><strong>개인정보의 제3자 제공</strong></SPAN></P>

<P><SPAN'>인천광역시인재개발원은 원칙적으로 이용자의 개인정보를 제1조(개인정보의 처리 목적)에서 명시한 범위 내에서 처리하며, 회원가입 및 회원의 이용 서비스 향상을 위해 다음과 같이 정보주체의 개인정보를 제3자에게 제공하고 있으며 정보주체의 동의 없이는 제공되지 않습니다. </SPAN></P>
<P>&nbsp;&nbsp;
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="152" height="32" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>제공받는 자 </SPAN></P>
	</TD>
	<TD width="152" height="32" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>정보의 이용 목적 </SPAN></P>
	</TD>
	<TD width="159" height="32" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>정보의 제공 범위 </SPAN></P>
	</TD>
	<TD width="193" height="32" valign="middle" bgcolor="#e2fed2"  style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";font-weight:"bold";'>정보의 보유 및 이용 기간 </SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="152" height="80" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-family:"굴림";'>인천광역시인재개발원 </SPAN><SPAN STYLE='font-family:"굴림";letter-spacing:-1.6pt;'>홈페이지를 이용하는 기관</SPAN></P>
	</TD>
	<TD width="152" height="80" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";letter-spacing:-1.2pt;'>교육운영</SPAN></P>
	</TD>
	<TD width="159" height="80" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>성명, 생년월일, 성별, 소속기관, 부서, 직급</SPAN></P>
	</TD>
	<TD width="193" height="80" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림";'>회원 탈퇴 시까지</SPAN></P>
	</TD>
</TR>
</TABLE>&nbsp;</P>


<P><SPAN'>단, 개인정보보호법 제18조 제2항에 의거 다음에 해당하는 경우에는 예외로 합니다.</SPAN></P>

<P><SPAN'>&nbsp;가. 정보주체로부터 별도의 동의를 받은 경우 </SPAN></P>

<P><SPAN'>&nbsp;나. 다른 법률에 특별한 규정이 있는 경우 </SPAN></P>

<P><SPAN'>&nbsp;다. 정보주체 또는 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우 </SPAN></P>

<P><SPAN'>&nbsp;라. 통계작성 및 학술연구 등의 목적을 위하여 필요한 경우로서 특정 개인을 알아 볼 수 없는 형태로 개인정보를 제공하는 경우 </SPAN></P>

<P><SPAN'>&nbsp;마. 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공하지 아니하면 다른 법률에서 정하는 소관 업무를 수행할 수 없는 경우로서 보호위원회의 심의·의결을 거친 경우 </SPAN></P>

<P><SPAN'>&nbsp;바. 조약, 그 밖의 국제협정의 이행을 위하여 외국정부 또는 국제기구에 제공하기 위하여 필요한 경우 </SPAN></P>

<P><SPAN'>&nbsp;사. 범죄의 수사와 공소의 제기 및 유지를 위하여 필요한 경우 </SPAN></P>

<P><SPAN'>&nbsp;아. 법원의 재판업무 수행을 위하여 필요한 경우 </SPAN></P>

<P><SPAN'>&nbsp;자. 형 및 감호, 보호처분의 집행을 위하여 필요한 경우 </SPAN></P>

<P><SPAN'>&nbsp;차. 업무상 연락을 위하여 회원의 정보(성명, 주소, 전화번호)를 사용하는 경우</SPAN></P>

<BR>

<P><BR></P>


											</div>
		


											</div>
											<p class="terms_bom" style="text-align:center;">정보주체는 개인정보보호법 제17조에 따라 개인정보 제공에 대한 동의를 거부할 수 있습니다. </p>
											<p class="terms_bom" style="text-align:center;">그러나 동의 거부 시 인천광역시 인재개발원 홈페이지에 회원가입이 되지 않으며, </p>
											<p class="terms_bom" style="text-align:center;">공무원 집합교육 및 e-러닝(외국어) 신청을 할 수 없습니다.</p>
											<!-- p class="terms_bom" style="text-align:center;">회원으로 가입하시겠습니까?</p -->
										</div>
									<div style="text-align:center;">
										<input type="radio" value="Y2" class="radio01" id="checkYn3" onclick="checkYn('Y2');"/>
										<label for="" class="label01">동의함</label>
										<input type="radio" value="N2" class="radio01" id="checkYn4" onclick="checkYn('N2');"/>
										<label for="" class="label01">동의하지 않음</label>
									</div>
								</div>
								<div id="info_form" style="display:none;">

								<h2 class="h2L">
									<img src="/images/skin1/title/tit_inData.gif" alt="기본입력사항" />
								</h2>
								<div class="txtR">
									(<span class="txt_org">*</span> 필수입력사항)
								</div>
								<!-- //title -->
								<div class="h9"></div>

								<!-- data -->
								<table class="dataW01">	
									<tr>
										<th class="bl0" width="160">
											이름 <span class="txt_org">*</span>
										</th>
										<td width="378">
											<input type="text" value=<%=request.getParameter("username") %> id="username" name="username" class="input02 w100" />									
											<input type="hidden" title="주민번호앞자리" value=<%=request.getParameter("ssn1") %> id="ssn1" name="ssn1" class="input02 w40" />
											<input type="hidden" title="숨겨진주민번호뒷자리" value=<%=request.getParameter("ssn2") %> id="ssn2" name="ssn2"/>
											<span class="txt11 vp2">반드시 실명가입</span>
										</td>
										<!-- td width="100" rowspan="5">
											<dl class="photo">
												<input type="hidden" name="hiddenpicurl"/>
												<dt>
													<img width="95" height="100" id="mypicture" name="mypicture" src="/images/skin1/sub/img_photo.gif" alt="사진" />
												</dt>
												<dd>
													<a href="javascript:popWin('join.do?mode=addpictures','cPop','420','600','yes','yes')">
														<img src="/images/skin1/button/btn_photoRegi01.gif" class="vm2" alt="사진등록" />
													</a>
												</dd>	
											</dl>				
										</td -->
									</tr>
									<!-- <tr>
										<th class="bl0" width="160">
											주민등록번호 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="주민번호앞자리" value=<%=request.getParameter("ssn1") %> id="ssn1" name="ssn1" class="input02 w40" /> - 
											<input type="text" title="주민번호뒷자리" value="xxxxxxx" name="viewssn2" class="input02 w40" />
											<input type="hidden" title="숨겨진주민번호뒷자리" value=<%=request.getParameter("ssn2") %> id="ssn2" name="ssn2"/>
										</td>
									</tr>  -->
									<tr>
										<th class="bl0" width="160">
											생년월일<span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" value="" id="bYear" name="bYear" class="input02 w54" />년
											<input type="text" value="" id="bMonth" name="bMonth" class="input02 w32" />월
											<input type="text" value="" id="bDay" name="bDay" class="input02 w32" />일
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											성별 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="hidden" value="" id="sex" name="sex"/>
											<input type="text" value="" id="gender" name="gender" class="input02 w54" />
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											아이디 <span class="txt_org">*</span>
										</th>
										<td>
											<input id="idform" type="text" title="아이디" name="USER_ID" class="input02 w100" />
											<a href="javascript:idcheck();">
												<img src="/images/skin1/button/btn_submit01.gif" class="vm2" alt="중복확인" />
											</a>
											<span class="txt11 ltspm1 vp2">(영문(소문자), 숫자 포함 6자~12자)</span>
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											비밀번호 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="password" title="비밀번호" name="PWD" class="input02 w100" />
											<span class="txt11 ltspm1 vp2">(영문, 숫자 포함 9자 이상 12자 미만) '특수문자포함'</span>
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											비밀번호 확인 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="password" title="비밀번호확인" name="PWD_CHK" class="input02 w100" />
											<span class="txt11 ltspm1 vp2">(비밀번호를 다시 입력해 주세요)</span>
										</td>
									</tr>
									<tr>
										<th class="bl0">비밀번호 재발급질문 <span class="txt_org">*</span></th>
										<td colspan="2">
											<select title="비밀번호 재발급질문" name="PWD_QUS" class="select02 w200">
												<option value="" selected="selected">----- 질문을 선택하세요 -----</option>
												<option value = "본인의 초등학교는?">본인의 초등학교는?
												<option value = "본인의 핸드폰 번호는?">본인의 핸드폰 번호는?
												<option value = "어머니의 성함은?">어머니의 성함은?
												<option value = "어릴적 별명은?">어릴적 별명은?
												<option value = "본인이 태어난 곳은?">본인이 태어난 곳은?
												<option value = "가고 싶은 장소는?">가고 싶은 장소는?
												<option value = "즐겨 부르는 노래는?">즐겨 부르는 노래는?
												<option value = "감명 깊게 본 영화는?">감명 깊게 본 영화는?
												<option value = "좋아하는 색깔은?">좋아하는 색깔은?
												<option value = "가장 좋아하는 연예인은?">가장 좋아하는 연예인은?
												<option value = "부모님이 좋아하는 음식은?">부모님이 좋아하는 음식은?
												<option value = "가장 기억에 남는 선생님은?">가장 기억에 남는 선생님은?
												<option value = "좋아하는 애완동물은?">좋아하는 애완동물은?
											</select>
											<span class="txt11">비밀번호 분실시 사용</span>
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											비밀번호 재발급 답 <span class="txt_org">*</span>
										</th>
										<td colspan="2">
											<input type="text" title="비밀번호 재발급 답" name="PWD_ANS" class="input02 w193" />
											<span class="txt11 vp2">비밀번호와 무관하게 입력</span>
										</td>
									</tr>
								</table>	
								<!-- //data --> 
								<div class="space"></div>

								<!-- title --> 
								<h2 class="h2L">
									<img src="/images/skin1/title/tit_address.gif" alt="연락처 입력" />
								</h2>
								<div class="txtR">
									(<span class="txt_org">*</span> 필수입력사항)
								</div>
								<!-- //title -->
								
								<div class="h9"></div>
			
								<!-- view -->
								<table class="dataW01">		
									<tr>
										<th class="bl0" width="160">
											이메일 <span class="txt_org">*</span>
										</th>
										<td width="458">
											<input type="text" title="이메일 아이디" name="emailid" id="emailid" class="input02 w80" /> @ 
											<input type="text" title="이메일 계정" name="mailserv" id="mailserv" class="input02 w80" >
											<select name="mailservSel" id="mailservSel"  title="이메일 계정" onChange="mailServ(this.value)" class="select02">
												<option value="korea.kr">korea.kr</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="naver.com">naver.com</option>
												<option value="paran.com">paran.com</option>
												<option value="empas.com">empas.com</option>
												<option value="dreamwiz.com">dreamwiz.com</option>
												<option value="yahoo.co.kr">yahoo.co.kr</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="nate.com">nate.com </option>
												<option value="chollian.net">chollian.net</option>
												<option value="empal.com">empal.com</option>														
												<option value="lycos.co.kr">lycos.co.kr</option>
												<option value="hanafos.com">hanafos.com</option>
												<option value="hanmir.com">hanmir.com</option>
												<option value="direct" selected="selected">직접입력</option>
											</select>
											<a href="javascript:emailcheck();">
												<img src="/images/skin1/button/btn_submit01.gif" class="vm2" alt="중복확인" /> 
											</a>	
											<a href="http://mail.korea.kr" target="_blank">
												<img src="/images/skin1/button/btn_email.gif" class="vm2" alt="이메일 신청" />
											</a>
										</td>
									</tr>
									<!-- tr>
										<th class="bl0">
											집전화
										</th>
										<td>
											<input type="text" value="" name="HOME_TEL1" class="input02 w40" /> - 
											<input type="text" value="" name="HOME_TEL2" class="input02 w40" /> - 
											<input type="text" value="" name="HOME_TEL3" class="input02 w40" />
											<span class="txt11 vp2">(예 : 02-1234-5678)</span>
										</td>
									</tr -->
									<tr>
										<th class="bl0">
											직장전화
										</th>
										<td>
											<input type="text" value="" name="OFFICE_TEL1" class="input02 w40" /> - 
											<input type="text" value="" name="OFFICE_TEL2" class="input02 w40" /> - 
											<input type="text" value="" name="OFFICE_TEL3" class="input02 w40" />
											<span class="txt11 vp2">(예 : 02-1234-5678)</span>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											휴대전화 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" value="" title="휴대전화 1"  name="HP1" class="input02 w40" /> - <input type="text" value="" title="휴대전화 2" name="HP2" class="input02 w40" /> - <input type="text" value="" title="휴대전화 3" name="HP3" class="input02 w40" />
											<span class="txt11 vp2">(예 : 010-1234-5678)</span>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											우편번호 <!-- span class="txt_org">*</span -->
										</th>
										<td>
											<input type="text" title="우편번호" id="homePost1" name="homePost1" class="input02 w40" /> - 
											<input type="text" title="우편번호" id="homePost2" name="homePost2" class="input02 w40" /> 
											<a href="javascript:searchZip('homePost1','homePost2','homeAddr');"><img src="/images/skin1/button/btn_search02.gif" class="vm2" alt="검색"/></a>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											주 소 <!--span class="txt_org">*</span -->
										</th>
										<td>
											<input type="text" title="주소" id="homeAddr" name="homeAddr" class="input02 w382" />
										</td>
									</tr>
									<tr>
										<th class="bl0">
											새주소 우편번호 <!-- span class="txt_org">*</span -->
										</th>
										<td>
											<input type="text" title="새주소 우편번호" id="newHomePost" name="newHomePost" class="input02 w40" readonly/>
											<a href="javascript:goPopup();"><img src="/images/skin1/button/btn_search02.gif" class="vm2" alt="검색"/></a>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											새 주 소 <!--span class="txt_org">*</span -->
										</th>
										<td>
											<input type="text" title="새주소1" id="newAddr1" name="newAddr1" class="input02 w382" />
											<input type="text" title="새주소2" id="newAddr2" name="newAddr2" class="input02 w382" />
										</td>
									</tr>	
								</table>	
								<!-- //view --> 
			
								<div class="space"></div>

								<!-- title --> 
								<h2 class="h2L">
									<img src="/images/skin1/title/tit_poInfo.gif" alt="소속기관 정보" />
								</h2>
								<div class="txtR">
									(<span class="txt_org">*</span> 필수입력사항)
								</div>
								<!-- //title -->
								<div class="h9"></div>

								<!-- view -->
								<table class="dataW01">	
									<tr>
										<th class="bl0" width="160">
											소속기관명 <span class="txt_org">*</span>
										</th>
										<td width="458">
											<!-- 
											<select title="소속기관명" name="officename" id="officename" class="select02 w200" onChange="getMemSelDept(this.options[this.selectedIndex].value, document.pform.deptname.value)"> 
											-->
											<select id="deptSelect" name="officename" class="select02 w200" title="소속기관명" onChange="getMemSelDept(this.options[this.selectedIndex].value, document.pform.deptname.value)">
												<option  value="" selected="selected">----- 소속기관을 선택하세요 -----</option>
												<%=deptListHtml %>
											</select>
											<span class="txt11">(본청,직속기관 및 사업소는 인천광역시 선택)</span>			
										</td>
									</tr>
									<tr id="part">
										<th class="bl0">
											부서명 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="부서명" value="" name="deptname" id="deptname" class="input02 w193" />
											<select name="PART_DATA" id="PART_DATA" class="select01 w120" onChange="getPart(this.options[this.selectedIndex].value,this.options[this.selectedIndex].text)">
												<option value = "" selected="selected">--- 부서 선택 ---</option>
												<option value = "" >직접입력</option>
											</select>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											직급 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="직급" id="degreename" name="degreename" class="input02 w193" readonly/> 
											<input type="hidden" id="hiddenjik" name="hiddenjik"/>
											<a href="javascript:findJik();">
												<img src="/images/skin1/button/btn_search02.gif" class="vm2" alt="검색" />
											</a>
											<span class="txt11">직급명(예:행정주사)입력 후 검색 </span>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											직위
										</th>
										<td>
											<input type="text" value="" name="degree" class="input02 w193" />
										</td>
									</tr>
								</table>	
								<!-- //view --> 
								<div class="space"></div>

								<!-- title --> 
								<h2 class="h2L">
									<img src="/images/skin1/title/tit_etc.gif" alt="기타" />
								</h2>
								<div class="txtR">
									(<span class="txt_org">*</span> 필수입력사항)
								</div>
								<!-- //title -->
								<div class="h9"></div>

								<!-- view -->
								<table class="dataW01">		
									<!-- tr>
										<th class="bl0" width="160">
											학력
										</th>
										<td width="458">
											<select name="school" class="select02">
												<option value="">----- 학력을 선택하세요 -----</option>
												<option value="01">박사
												<option value="02">석사
												<option value="03">대졸
												<option value="04">대재.퇴,초대졸
												<option value="05">고졸
												<option value="06">중졸이하
												<option value="07">기타
											</select>
										</td>
									</tr -->
									<tr>
										<th class="bl0" width="160">
											최초임용일 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="최초임용일" onclick="window.frames.popFrame.fPopCalendar(FIDATE,FIDATE,popCal);return false" name="FIDATE" class="input02 w100" /> 
											<a href = "javascript:void(0)" onclick="window.frames.popFrame.fPopCalendar(FIDATE,FIDATE,popCal);return false">
												<img src="/images/skin1/icon/icon_cal01.gif" class="vp2" alt="달력" /> 
											</a>
											<span class="txt11 vp2">(예 :19910509)</span>
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											현직급임용일 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="현직급임용일" onclick="window.frames.popFrame.fPopCalendar(UPSDATE,UPSDATE,popCal);return false" name="UPSDATE" class="input02 w100" />
											<a href = "javascript:void(0)" onclick="window.frames.popFrame.fPopCalendar(UPSDATE,UPSDATE,popCal);return false">
												<img src="/images/skin1/icon/icon_cal01.gif" class="vp2" alt="달력" /> 
											</a>
											<span class="txt11 vp2">(예 :19910509)</span>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											메일수신여부(교육안내문)
										</th>
										<td>
											<ul class="radioSet">
												<li>
													<input type="radio" value="Y" name="mailYN" class="radio01" checked="checked"/>
													<label for="" class="label01">Yes</label>
												</li>
												<li>
													<input type="radio" value="N" name="mailYN" class="radio01" />
													<label for="" class="label01">No</label>
												</li>
											</ul>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											SMS수신여부
										</th>
										<td>
											<ul class="radioSet">
												<li>
													<input type="radio" value="Y" name="smsYN" class="radio01" checked="checked"/>
													<label for="" class="label01">Yes</label>
												</li>
												<li>
													<input type="radio" value="N" name="smsYN" class="radio01" />
													<label for="" class="label01">No</label>
												</li>
											</ul>
										</td>
									</tr>
									<!-- tr>
										<th class="bl0"><span class="ltspm1">인천사이버교육센터 동시가입</span></th>
										<td>
											<ul class="radioSet">
											<li><input type="radio" value="Y" name="cmYN" class="radio01" /><label for="" class="label01">Yes</label></li>
											<li><input type="radio" value="N" name="cmYN" class="radio01" /><label for="" class="label01">No</label></li>
											</ul>
										</td>
									</tr -->
								</table>	
								<!-- //view --> 
								<div class="space"></div>
						
								<!-- button -->
								<div class="btnCbtt">			
									<a href="javascript:joinProcess('joinmember');">
										<img src="/images/skin1/button/btn_submit02.gif" alt="확인" />
									</a>
									<a href="javascript:joinCancle();;">
										<img src="/images/skin1/button/btn_cancel01.gif" alt="취소" />
									</a>
								</div>
								<!-- //button -->		
								<div class="space"></div>
								</div>
							</div>
							<!-- //content e ===================== -->
						</div>
						<!-- //contentOut e ===================== -->
																								
						<div class="spaceBtt"></div>
						
					</form>	
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>