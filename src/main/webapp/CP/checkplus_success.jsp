<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String sReserved1  = requestReplace(request.getParameter("param_r1"), "");
    String sReserved2  = requestReplace(request.getParameter("param_r2"), "");
    String sReserved3  = requestReplace(request.getParameter("param_r3"), "");

    String sSiteCode = "G8709";				   // NICE로부터 부여받은 사이트 코드
    String sSitePassword = "H9NGAKRFF6WF";			 // NICE로부터 부여받은 사이트 패스워드

    String sCipherTime = "";				 // 복호화한 시간
    String sRequestNumber = "";			 // 요청 번호
    String sResponseNumber = "";		 // 인증 고유번호
    String sAuthType = "";				   // 인증 수단
    String sName = "";							 // 성명
    String sDupInfo = "";						 // 중복가입 확인값 (DI_64 byte)
    String sConnInfo = "";					 // 연계정보 확인값 (CI_88 byte)
    String sBirthDate = "";					 // 생일
    String sGender = "";						 // 성별
    String sNationalInfo = "";       // 내/외국인정보 (개발가이드 참조)
    String sMessage = "";
    String sPlainData = "";
    
    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();
        
        // 데이타를 추출합니다.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);
        
        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
        sResponseNumber = (String)mapresult.get("RES_SEQ");
        sAuthType 			= (String)mapresult.get("AUTH_TYPE");
        sName 					= (String)mapresult.get("NAME");
        sBirthDate 			= (String)mapresult.get("BIRTHDATE");
        sGender 				= (String)mapresult.get("GENDER");
        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
        sDupInfo 				= (String)mapresult.get("DI");
        sConnInfo 			= (String)mapresult.get("CI");
	    // 휴대폰 번호 : MOBILE_NO => (String)mapresult.get("MOBILE_NO");
		// 이통사 정보 : MOBILE_CO => (String)mapresult.get("MOBILE_CO");
		// checkplus_success 페이지에서 결과값 null 일 경우, 관련 문의는 관리담당자에게 하시기 바랍니다.        
        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");

        if(!sRequestNumber.equals(session_sRequestNumber))
        {
            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
            sResponseNumber = "";
            sAuthType = "";
        }
    }
    else if( iReturn == -1)
    {
        sMessage = "복호화 시스템 에러입니다.";
    }    
    else if( iReturn == -4)
    {
        sMessage = "복호화 처리오류입니다.";
    }    
    else if( iReturn == -5)
    {
        sMessage = "복호화 해쉬 오류입니다.";
    }    
    else if( iReturn == -6)
    {
        sMessage = "복호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else if( iReturn == -12)
    {
        sMessage = "사이트 패스워드 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }

%>
<%!
public static String requestReplace (String paramValue, String gubun) {
        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }
%>

<html>
<head>
    <title>NICE신용평가정보 - CheckPlus 안심본인인증 테스트</title>
    <script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
		<script language="javascript">
			function dupinfoCheck() {
				var dupinfo = document.getElementById("dupinfo").value;
				var url="/homepage/support.do";
				var pars = "mode=dupinfoCheckAjax2&dupinfo="+dupinfo;		
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
					alert('실명 확인되었습니다!');
								
 					document.authform.action = "/homepage/join.do";
					document.authform.target = "mother";
					document.authform.submit();
					
					window.close();

					/* var popup = parent.window.open("", "pop", "");
                    popup.close();  */                   
				
			
				}else if(response == 'REJOIN') {
					alert("이미 가입되어 있습니다.");
					window.close();
					
					//현재 실서버에는 실명인증 모듈이 설치가 되어 있는데 테스트 서버에는 없어서 실명확인이 실패하게 됩니다.
					//회원가입 프로세스를 변경하게 될 경우에는 현재 주석을 해제하시면 회원가입페이지로 넘어갈 수 있습니다.
					//document.authform.action = "join.do";
					//document.authform.target = "mother";
					//document.authform.submit();	
				
					
				}else {
					alert("실명확인이 실패하였습니다.\n다시 입력해 주십시오.");
					window.close();
					
					//현재 실서버에는 아이핀인증 모듈이 설치가 되어 있는데 테스트 서버에는 없어서 실명확인이 실패하게 됩니다.
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
			
			//값을 받는 부분 (joinstep3.jsp의 데이터 타입이 utf-8이므로 이름을 인코딩하여 넘겨줍니다.)
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
				document.getElementById("username").value = s0;
			
			    return s0;
			}
	        </script>
</head>
<body onload="encodeName('<%= sName %>');dupinfoCheck()">
<form method="post" name="authform">
			<input type="hidden" id="mode" name="mode" value="joinstep3"/>
			<input type="hidden" id="regtype" name="regtype" value="2"/>
			<input type="hidden" id="username" name="username" value=""/>
            <input type="hidden" id="age" name="age" value=""/>
            <input type="hidden" id="dupinfo" name="dupinfo" size="70" value="<%= sDupInfo %>"/>
            <input type="hidden" id="realname" name="realname" value="<%=sName%>"/>
            <input type="hidden" id="sex" name="sex" value="<%= "1".equals(sGender) ? "1":"0" %>"/>
            <input type="hidden" id="birthdate" name="birthdate" value="<%= sBirthDate %>"/>
            <input type="hidden" id="nationalinfo" name="nationalinfo" value="<%= sNationalInfo %>"/>
            <input type="hidden" id="authinfo" name="authinfo" value="<%= sAuthType %>"/>
    <center>
    <p><p><p><p>
    <a href="javascript:dupinfoCheck();">본인인증이 완료 되었습니다.</a><br>

    <!-- table border=1>
        <tr>
            <td>복호화한 시간</td>
            <td><%= sCipherTime %> (YYMMDDHHMMSS)</td>
        </tr>
        <tr>
            <td>요청 번호</td>
            <td><%= sRequestNumber %></td>
        </tr>            
        <tr>
            <td>NICE응답 번호</td>
            <td><%= sResponseNumber %></td>
        </tr>            
      
    </table --><br><br>        
    <%= sMessage %><br>
    </center>
</body>
</html>