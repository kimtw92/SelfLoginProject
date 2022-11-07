<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>

<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    String sSiteCode = "G8709";				// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "H9NGAKRFF6WF";		// NICE로부터 부여받은 사이트 패스워드
    
    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType = "M";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	
   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
		
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    String sReturnUrl = "http://hrd.incheon.go.kr/homepage/cp.do?mode=success";      // 성공시 이동될 URL
    String sErrorUrl = "http://hrd.incheon.go.kr/homepage/cp.do?mode=fail";          // 실패시 이동될 URL

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
    String sMessage = "";
    String sEncData = "";
    
    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
    if( iReturn == 0 )
    {
        sEncData = niceCheck.getCipherData();
    }
    else if( iReturn == -1)
    {
        sMessage = "암호화 시스템 에러입니다.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "암호화 처리오류입니다.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "암호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
%>
 
 
<%
	/********************************************************************************************************************************************
		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
	*********************************************************************************************************************************************/
	
	String sSiteCodeN				= "EF20";			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
	String sSitePw					= "hrd7673hrd!!";			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)
	
	
	/*
	┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
		NICE평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
		따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.
		
		* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
		* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.
		
		아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
		예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
	└────────────────────────────────────────────────────────────────────
	*/
	String sReturnURL				= "http://hrd.incheon.go.kr/ipin/ipin_process.jsp";
	
	
	/*
	┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
		[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.
		
		CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
		데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.
		
		따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
	└────────────────────────────────────────────────────────────────────
	*/
	String sCPRequest				= "";
	
	
	
	// 객체 생성
	IPINClient pClient = new IPINClient();
	
	
	// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
	sCPRequest = pClient.getRequestNO(sSiteCodeN);
	
	// CP 요청번호를 세션에 저장합니다.
	// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
	// 필수사항은 아니며, 보안을 위한 권고사항입니다.
	session.setAttribute("CPREQUEST" , sCPRequest);
	
	
	// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
	int iRtn = pClient.fnRequest(sSiteCodeN, sSitePw, sCPRequest, sReturnURL);
	
	String sRtnMsg					= "";			// 처리결과 메세지
	String sEncDataN					= "";			// 암호화 된 데이타
	
	// Method 결과값에 따른 처리사항
	if (iRtn == 0)
	{
	
		// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
		// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
		sEncDataN = pClient.getCipherData();		//암호화 된 데이타
		
		sRtnMsg = "정상 처리되었습니다.";
	
	}
	else if (iRtn == -1 || iRtn == -2)
	{
		sRtnMsg =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
					"귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
	}
	else if (iRtn == -9)
	{
		sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
	}
	else
	{
		sRtnMsg = "iRtn 값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=uft-8" />
		
		<title>인천광역시 인재개발원에 오신것을 환영합니다</title>
		
		<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
		<!-- <script language="javascript" src="/commonInc/js/framework/jquery-1.2.6.js"></script> -->
		
		<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
		<link rel="stylesheet" type="text/css" href="/commonInc/css/ipin/popup.css" />
		
		<!-- [Page Customize] -->
		<style type="text/css">
		<!--
			div .tabline{border-bottom:solid 1px #cbcfda; padding: 23px 0 0 0;}
		-->
		</style>
		<!-- [/Page Customize] -->
		

<script type="text/javascript"> 
function fnIsKorea(obj) {
	if(obj.checked) {
		alert("외국인을 선택 하셨습니다.");
		document.getElementById("iskorea_title").innerText = "[외국인]";
	} else {
		alert("한국인을 선택 하셨습니다.");
		document.getElementById("iskorea_title").innerText = "[한국인]";
	}
}
// 외국인 등록번호 검증
function fCheck(){
  var sJumin1 = document.getElementById("ssn1").value;
  var sJumin2 = document.getElementById("ssn2").value;
  var fgn_reg_no = sJumin1 + sJumin2;
  
  if (fgn_reg_no == ''){
    alert('외국인등록번호를 입력하십시오.');
    return false;
  }
  if(fgn_reg_no.length != 13) {
    alert('외국인등록번호 자리수가 맞지 않습니다.');
    return false;
  }
  
  if((fgn_reg_no.charAt(6) == "5") || (fgn_reg_no.charAt(6) == "6")){
    birthYear = "19";
  }else if ((fgn_reg_no.charAt(6) == "7") || (fgn_reg_no.charAt(6) == "8")){
    birthYear = "20";
  }else if ((fgn_reg_no.charAt(6) == "9") || (fgn_reg_no.charAt(6) == "0")){
    birthYear = "18";
  }else{
    alert("외국인 주민번호가 아니거나 주민등록번호에 오류가 있습니다. 다시 확인하십시오.");
    return false;
  }

  birthYear += fgn_reg_no.substr(0, 2);
  birthMonth = fgn_reg_no.substr(2, 2) - 1;
  birthDate = fgn_reg_no.substr(4, 2);
  birth = new Date(birthYear, birthMonth, birthDate);
  
  if(birth.getYear() % 100 != fgn_reg_no.substr(0, 2) || birth.getMonth() != birthMonth || birth.getDate() != birthDate){
    alert('생년월일에 오류가 있습니다. 다시 확인하십시오.');
    return false;
  }
  
  if (fgn_no_chksum(fgn_reg_no) == false){
    alert('외국인등록번호에 오류가 있습니다. 다시 확인하십시오.');
    return false;
  }else{
    alert ('정상입니다.');
    return true;
  }
}
 
// 외국인 등록번호 유효 비트 체크
function fgn_no_chksum(reg_no) {
  var sum = 0;
  var odd = 0;
  
  buf = new Array(13);
  for(i = 0; i < 13; i++) buf[i] = parseInt(reg_no.charAt(i));
  odd = buf[7]*10 + buf[8];
  
  if(odd%2 != 0){
    return false;
  }
  
  if((buf[11] != 6)&&(buf[11] != 7)&&(buf[11] != 8)&&(buf[11] != 9)){
    return false;
  }
    
  multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
  for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);
  sum=11-(sum%11);
  
  if(sum>=10) sum-=10;
  sum += 2;
  
  if(sum>=10) sum-=10;
  
  if ( sum != buf[12]) {
    return false;
  }else{
    return true;
  }
}

			// 2011.01.13 - woni82
			// 주민등록번호를 이용한 실명인증시 사용되는 부분
			// 아이핀 중복코드 생성이 필요하기 때문에 변경됩니다.
			//주민번호로 실명인증을 할 경우에 i-Pin에서 중복확인코드를 발급받는다.
			//parameter : 주민등록번호, 사이트 ID
			function authCheck1(type, str, username, resno) {
				//alert("1. type : "+type+", str : "+str+", username : "+username+", resno : "+resno);
				if(type == "start"){
					//alert("2. type : "+type+", str : "+str+", username : "+username+", resno : "+resno);	
					
					username = $F('username');
					resno = $F('ssn1')+$F('ssn2');
					//alert("3. type : "+type+", str : "+str+", username : "+username+", resno : "+resno);
		
					if(username =='') {
						alert("이름을 입력해 주십시오.");
						return;
					}else if(username.length < 2){
						alert("이름은 2자 이상입니다.");
						return;
					}else if($F('ssn1').length != 6) {
						alert("주민등록번호 앞자리는 6자입니다.");
						return;
					}else if($F('ssn2').length != 7) {
						alert("주민등록번호 뒷자리는 7자입니다.");
						return;
					}else if($F('ssn2').substr(0,1)!=1 && $F('ssn2').substr(0,1)!=2) {
						alert("잘못된 주민등록번호 형식입니다.");
						return;
					}else {
						
					}
					if(document.getElementById("iskorea").checked) {
						if(!fCheck()) {
							return;
						}
					}

					//alert("1. "+username);
					//utf-8 형식의 데이터를 넘길 경우 euc-kr에서 한글이 깨지므로 encoding을 해주어 넘겨준다.
					username = encodeName(username);
					//alert("2. "+username);
					
					//2011.01.13
					// i-Pin 에서 발급한 사이트 아이디
					var siteId = "H9I2J9YCU8SQ";
					wWidth = 850;
					wHight = 520;
					wX = (window.screen.width - wWidth) / 2;
					wY = (window.screen.height - wHight) / 2;
					requrl = "../G-PIN/GMUserDuplicationValue.jsp?regNo=" + resno + "&siteId=" + siteId +"&username="+username;
					var w = window.open(requrl, "_blank", "directories=no,toolbar=no,left="+wX+",top="+wY+",width="+wWidth+",height="+wHight);
				}
				else if(type == "end"){
	
					//실명인증시 아이핀 중복코드를 추가하여 실명인증을 함.
					document.getElementById("dupinfo").value = str;

					//이름이 암호화 되서 들어오기 때문에 복호화 하여줌.
					username = decodeName(username);
					//alert("3. "+username);

					var url="support.do";
					var pars = "mode=authCheckAjax&name="+username+"&resno="+resno+"&dupinfo="+str;		
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
			}

			// 2011.01.14 - woni82
			//값을 받는 부분 (GMUserDuplicationValue.jsp의 데이터 타입이 euc-kr이므로 이름을 인코딩하여 넘겨줍니다.)
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

			// 이전 주민등록번호 실명 
			// 주민등록번호를 이용한 실명인증시 사용되는 부분
			function authCheck() {
				if($F('username') =='') {
					alert("이름을 입력해 주십시오.");
					return;
				}else if($F('username').length < 2){
					alert("이름은 2자 이상입니다.");
					return;
				}else if($F('ssn1').length != 6) {
					alert("주민등록번호 앞자리는 6자입니다.");
					return;
				}else if($F('ssn2').length != 7) {
					alert("주민등록번호 뒷자리는 7자입니다.");
					return;
				}else if($F('ssn2').substr(0,1)!=1 && $F('ssn2').substr(0,1)!=2) {
					alert("잘못된 주민등록번호 형식입니다.");
					return;
				}else {
					
				}		
				var url="support.do";
				var pars = "mode=authCheckAjax&name="+$F('username')+"&resno="+$F('ssn1')+$F('ssn2');
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
					alert('실명확인되었습니다.1');
					document.authform.action = "join.do";
					document.authform.target = "mother";
					document.authform.submit();	
					window.close();		
				}else if(response.indexOf("UNDER") != -1) {
					alert("14세 미만은 가입할 수 없습니다.");
				}else if(response.indexOf("CHECKNOPASS") != -1) {
					alert("실명 인증 실패 주민번호 이름을 확인해주세요.");
				}else if(response.indexOf("REJOIN") != -1) {
					alert("이미 가입되어 있는 주민등록번호 입니다.");

					//현재 실서버에는 실명인증 모듈이 설치가 되어 있는데 테스트 서버에는 없어서 실명확인이 실패하게 됩니다.
					//회원가입 프로세스를 변경하게 될 경우에는 현재 주석을 해제하시면 회원가입페이지로 넘어갈 수 있습니다.
					//document.authform.action = "join.do";
					//document.authform.target = "mother";
					//document.authform.submit();	
					//window.close();
					
				}else {
					alert("실명확인이 실패하였습니다.\n다시 입력해 주십시오.");

					//현재 실서버에는 실명인증 모듈이 설치가 되어 있는데 테스트 서버에는 없어서 실명확인이 실패하게 됩니다.
					//회원가입 프로세스를 변경하게 될 경우에는 현재 주석을 해제하시면 회원가입페이지로 넘어갈 수 있습니다.
					//document.authform.action = "join.do";
					//document.authform.target = "mother";
					//document.authform.submit();	
					//window.close();
				}
			}
		
			function failProcess() {
				alert("에러가 발생하였습니다.");
			}
			function HelpPopup() {
				window.open("https://www.namecheck.co.kr/front/company/certify/certify_service.jsp?menu_num=0&page_num=2&page_num_1=0","pop2","");
			}
			// 2011.01.05 - woni82
			// i-Pin 인증 관련 하여 새로 추가 되는 부분.	
//--------------------------------------------------------------------------------------------------------------------------						
			onload = function()	{
				//버튼 효과 변경
				$('tab2').hide();
				$('tab3').hide();
				$('tab5').hide();
				//i-pin 탭  숨기기
				$('tabPage2').hide();	
			}
			
			function changeTab(tabNo){
				if(tabNo == 1){
					//버튼 효과 변경
					$('tab1').show();
					$('tab2').hide();
					$('tab3').hide();
					$('tab4').show();
					$('tab5').hide();
					$('tab6').show();
					//탭 페이지 변경
					$('tabPage').show();
					$('tabPage2').hide();
					$('tabPage3').hide();
				}else if(tabNo == 2){
					//버튼 효과 변경
					//$('tab1').hide();
					//$('tab2').show();
                    $('tab3').show();
					//$('tab4').hide();
					$('tab5').show();
					//$('tab6').show();
					//탭 페이지 변경
					//$('tabPage').hide();
					$('tabPage2').show();
					$('tabPage3').hide();
                  //  $('tab1').class = "sel";
				}else if(tabNo == 3){
					//버튼 효과 변경
                    //$('tab1').hide();
                   // $('tab2').show();
                    $('tab3').show();
					//$('tab4').show();
					$('tab5').show();
					//$('tab6').hide();
					//탭 페이지 변경
					//$('tabPage').hide();
					$('tabPage2').hide();
					$('tabPage3').show();
				}
			}

			//아이핀으로 실명 인증하기 
			function gPinAuth() {
				wWidth = 360;
				wHight = 120;
				wX = (window.screen.width - wWidth) / 2;
				wY = (window.screen.height - wHight) / 2;
				//var w = window.open("../G-PIN/Sample-AuthRequest.jsp", "gPinLoginWin", "directories=no,toolbar=no,left="+wX+",top="+wY+",width="+wWidth+",height="+wHight);
				var w = window.open("../G-PIN/Sample-AuthRequest.jsp?gpinAuthRetPage=joinstep", "gPinLoginWin", "directories=no,toolbar=no,left=200,top=100,width="+wWidth+",height="+wHight);

				//self.close();
				//location.href("../G-PIN/Sample-AuthRequest.jsp"); 
			}
			
			//주민번호로 실명인증을 할 경우에 i-Pin에서 중복확인코드를 발급받는다.
			//parameter : 주민등록번호, 사이트 ID
			function makeUserDupValue(str) {
				//alert(str);
				//2011.01.13
				// i-Pin 에서 발급한 사이트 아이디
				var siteId = "H9I2J9YCU8SQ";
				
				wWidth = 850;
				wHight = 520;
				wX = (window.screen.width - wWidth) / 2;
				wY = (window.screen.height - wHight) / 2;
				requrl = "Sample-UserDuplicationValue.jsp?regNo=" + str + "&siteId=" + siteId;
				var w = window.open(requrl, "_blank", "directories=no,toolbar=no,left="+wX+",top="+wY+",width="+wWidth+",height="+wHight);
			}

			// 주민등록번호로 아이핀 중복코드를 부여받아 저장을 함.
			function isSubmit(str){
				//alert(str);
				document.getElementById("dupinfo").value = str;
				//return str;
			}
		function fnPopup(){
            window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
            document.form_chk.target = "popupChk";
            document.form_chk.submit();
		}
		</script>
	
	</head>

	<!-- popup size 642x506 -->
	<body>
		<div class="top">
			<h1 class="h1">실명확인</h1>
		</div>
		
		<form method="post" name="authform">
			<input type="hidden" name="mode" value="joinstep3"/>
			
			<!-- 회원가입형태을 지정해 줍니다. 주민등록번호 인증 -->
			<input type="hidden" id="regtype" name="regtype" value="1"/>
			
			<!-- 주민등록번호로 실명인증을 할 경우 i-Pin에서 중복코드를 생성하여야 되는데 그 값을 저장하기 위한 셋팅 -->
			<input type="hidden" id="dupinfo" name ="dupinfo" value=""/> 
		
			<div class="contents">
			
				<!-- text -->
				<h3 class="h3txt">인천광역시 인재개발원에서는 네티즌의 개인정보 보호를 위해</h3>
				<!-- //text -->
				<p class="popD1">
				인천광역시 인재개발원에서는 사용자의 개인정보보호를 위해 사용자 여러분이 인천광역시 인재개발원 홈페이지의<br />
				서비스를 이용함에 있어 온라인상에서 제공한 개인정보가 철저히 보호 받을 수 있도록<br />
				최선을 다하고 있습니다.
				</p>
				<div class="SpB"></div>
				<p class="popD1">
				회원으로 가입하신 사용자의 정보는 사전 동의 없이는 절대로 공개되지 않으며,<br />
				모든 회원 정보는 개인정보 보호정책에 의해 보호받고 있습니다.<br />
				인천광역시 인재개발원 홈페이지에서는 보다 많은 사용자들의 원활한 서비스 이용과<br />
				온라인 상에서의 익명 사용으로 인한 피해 등을 방지하기 위해 회원님에 대한 실명제를 시행하고 있습니다. 
				</p>
				<!-- <div class="SpB"></div> -->
			
				<div id="tap">
					<ul>
						<!-- li id="tab1" class="sel">
							<a href="javascript:changeTab(1);">
								주민등록번호
							</a>
						</li>
						<li id="tab2">
							<a href="javascript:changeTab(1);">
								주민등록번호
							</a>
						</li -->
						<li id="tab3" class="sel">
							<a href="javascript:changeTab(2);">
								나이스I-PIN
							</a>
						</li>
						<!-- li id="tab4">
							<a href="javascript:changeTab(2);">
								공공I-PIN인증
							</a>
						</li -->
						<li id="tab5">
							<a href="javascript:changeTab(3);">
								휴대폰인증
							</a>
						</li>
						<!-- li id="tab6">
							<a href="javascript:changeTab(3);">
								공공I-PIN인증[외국인]
							</a>
						</li -->
					</ul>
				
					<!-- 주민등록번호 tab선택시 내용 -->
					<!-- div id="tabPage">
					
						<form action="/path/to/script" method="post">
							<fieldset id="login">
								<legend>이용자 본인의이름과 주민등록번호를 정확히 입력해 주시기 바랍니다.</legend>
									<p>
										<label for="username">성명(본인이름)</label>
										<input type="text" id="username" name="username" class="input01 w204"/>
										<input style="display:none;" type="checkbox" id="iskorea" name="iskorea" onclick="fnIsKorea(this);"/> <span style="display:none;"  id="iskorea_title">[한국인]</span>
									</p>
									<p>
										<label for="userNum">주민등록번호&nbsp;&nbsp;  </label>
										<input type="text" id="ssn1" name="ssn1" class="input01 w98" maxlength="6" />-
										<input type="password" id="ssn2" name="ssn2" class="input01 w98" maxlength="7"/>
									</p>
							</fieldset>
				
							<!-- button -->
							<div class="btnArea">
								<!--<a href="javascript:authCheck();">-->
								<!--로컬 테스트시 authCheck1('end','테스트할중복코드(ipin발급)','이름','주민등록번호') 를 넣어 사용할것
								<a href="javascript:authCheck1('end','','','');"> 
								-->
								<!-- a href="javascript:authCheck1('start','','','');"> 
									<img src="../images/ipin/btn_confirm.gif" alt="확인" />
								</a>
								<a href="javascript:window.close();">
									<img src="../images/ipin/btn_cancle.gif" alt="취소" />
								</a -->
							</div>	
							<!-- //button -->
						</form>
						<br/>
						<!-- p>
							*이용자 본인의 이름 및 주민등록번호를 정확히 입력해주시기 바랍니다.
						</p>
						<p>
							*2006년 9월 25일 개정 공포된 주민등록법에 따라 주민등록 생성기를 이용하거나 다른 이의 주민등록번호를 도용하여 인터넷 서비스에 가입하는 이용자의 경우, 3년 이하의 징역 또는 1천만원 이하의 벌금에 처해지게 되므로 실명 기재에 유의하시기 바랍니다.  
						</p>
						<br />
						<p>
							*『실명인증』이 이루어지지 않는 경우 문의 , <br /> 
							한국신용평가정보(주) TEL 1588-2486 홈페이지 http://www.idcheck.co.kr 
						</p -->
					</div -->
					<!-- //주민등록번호 tab선택시 내용 -->
				
					<!-- 공공I-PIN인증 tab선택시 내용 -->
					<br /><br />
					<div id="tabPage2">
						<p>
							<strong>나이스 아이핀(I-PIN)</strong>은 대면확인이 어려운 인터넷에서 회원가입 희망자 본인임을 확인할 수 있는 수단입니다.
						</p>
						<a href="javascript:fnPopupIpin();">
							<img src="../images/ipin/btn_nice-ipin.gif" alt="나이스I-PIN인증" />
						</a>
						<!-- <a href="http://www.g-pin.go.kr/center/pic/sub_01.gpin" target="_blank">
							<img src="../images/ipin/btn_ipinguide.gif" alt="공공I-PIN도움말" />
						</a> -->
						<br/><br/>
						<p>
							<strong>나이스아이핀(I-PIN) 문의처 (아이핀ID, 비밀번호, 2차인증 실패 등) </strong>
						</p>
						
							<dt>
								<span>*나이스아이핀 &nbsp;&nbsp;
								<a href="http://www.niceipin.co.kr/" target="_blank">
									http://www.niceipin.co.kr/
								</a> 
								<span>&nbsp;<strong>TEL</strong>1600-1522</span></span>
							</dt>							
						</dl>
					</div>

					<div id="tabPage3" style="display:none;">
	                <br />
						<p>
							<strong>휴대폰 인증(안심본인인증)은</strong> 대면 확인이 어려운 인터넷에서 <strong>본인 명의 휴대폰</strong>을 이용하여 회원가입 희망자 본인임을 확인할 수 있는 수단입니다.
						</p>
						<!-- a href="javascript:fnPopup();" -->
							<!-- input type="button" value="휴대폰인증" onclick="fnPopup();"/ -->
							<a href="javascript:fnPopup();"><img src="/images/ipin/btn_ok2.gif" alt="휴대폰인증"></a>
						<!-- /a -->
						<!-- a href="https://www.namecheck.co.kr/front/company/certify/certify_service.jsp?menu_num=0&page_num=2&page_num_1=0" target="_blank" -->
							<!-- input type="button" value="휴대폰인증 도움말" onclick="HelpPopup();"/ -->
                            <a href="javascript:HelpPopup();"><img src="/images/ipin/btn_okguide2.gif" alt="휴대폰인증 도움말"/></a>
						<!-- /a -->

						<br/><br/>
						<p>
							<strong>휴대폰 본인인증(안심본인인증) 문의처(명의자 불일치 등)</strong>
						</p>
						<dl>
							<dt>
								<span>* NICE 평가정보&nbsp;&nbsp;
								<a href="https://nice.checkplus.co.kr" target="_blank">
									https://nice.checkplus.co.kr
								</a>

								&nbsp;<strong>TEL</strong> 1600-1522</span>
							</dt>
						
				
						
						</dl>
					</div>
					</div>
					<!-- //공공I-PIN인증 tab선택시 내용 -->
					
					<br>
					
				</div>
			
			</div>
		</form>
	<form name="form_chk" method="post">
		<input type="hidden" name="m" value="checkplusSerivce">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
		<input type="hidden" name="EncodeData" value="<%= sEncData %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	    
	    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	    	 해당 파라미터는 추가하실 수 없습니다. -->
		<input type="hidden" name="param_r1" value="">
		<input type="hidden" name="param_r2" value="">
		<input type="hidden" name="param_r3" value="">
	</form>
	
<!-- nice ipin -->
<script type="text/javascript">
function fnPopupIpin(){
	window.name ="Parent_window";
	window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	document.form_ipin.target = "popupIPIN2";
	document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
	document.form_ipin.submit();
}
</script>
<form name="form_ipin" method="post">
	<input type="hidden" name="m" value="pubmain">
    <input type="hidden" name="enc_data" value="<%= sEncDataN %>">
    <input type="hidden" name="param_r1" value="">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="">
</form>
<form name="vnoform" method="post">
	<input type="hidden" name="enc_data">
	<input type="hidden" name="param_r1" value="">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="">
</form>
<!-- nice ipin -->
	
    </body>

</html>
