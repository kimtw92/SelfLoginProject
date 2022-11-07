<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%!
    String getSession(HttpSession session, String attrName){
        return session.getAttribute(attrName) != null ? (String)session.getAttribute(attrName) : "";
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	    <meta content="text/html; charset=utf-8" http-equiv="content-type" />
	    <title>GPIN SP - 사용자 본인인증 결과</title>
	    
		<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
		
		<style type="text/css">
				td{
					border-style: solid;
					border-width: 1;
					border-color: #A9CCF1 #A9CCF1 #BEDEFE #BEDEFE;
				}
				td .title{
					font-family: dotum;
					font-size: 7px;
					text-align: center;
				}
				td .content{
					font-family: dotum;
					font-size: 9;
					text-align: left;
				}
				table{
					border-width: 1;
					border-color: #BEDEFE #BEDEFE #A9CCF1 #A9CCF1;
				}
			</style>
		
		<script language="javascript">
			function dupinfoCheck() {

				var dupinfo = document.getElementById("dupinfo").value;
				var virtualno = document.getElementById("virtualno").value;
				var url="/homepage/support.do";
				var pars = "mode=dupinfoCheckAjax&virtualno="+virtualno+"&dupinfo="+dupinfo;		
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
	
				//alert(response);
		
				var age = document.getElementById("age").value
		
				if(age < 2) {
					alert("14세 미만은 가입할 수 없습니다.");
					history.back(-2);	
				}
		
				if(response == 'YES') {
					alert('실명확인되었습니다.');
					document.authform.action = "/homepage/join.do";
					document.authform.target = "mother";
					document.authform.submit();	
					window.close();		
						
				}else if(response == 'REJOIN') {
					alert("이미 가입되어 있습니다.");
					history.back(-2);
					
					//현재 실서버에는 실명인증 모듈이 설치가 되어 있는데 테스트 서버에는 없어서 실명확인이 실패하게 됩니다.
					//회원가입 프로세스를 변경하게 될 경우에는 현재 주석을 해제하시면 회원가입페이지로 넘어갈 수 있습니다.
					//document.authform.action = "join.do";
					//document.authform.target = "mother";
					//document.authform.submit();	
					//window.close();
					
				}else {
					alert("실명확인이 실패하였습니다.\n다시 입력해 주십시오.");
					history.back(-2);
					
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
	
	<body onload="encodeName('<%=getSession(session, "realName")%>');dupinfoCheck()">	
		<form method="post" name="authform">
		
			<input type="hidden" id="mode" name="mode" value="joinstep3"/>
			<input type="hidden" id="regtype" name="regtype" value="2"/>
			<input type="hidden" id="username" name="username" value=""/>
		<%
		    /**
		     * Sample-AuthRequest 를 통한 사용자인증 완료후 session에 저장된 사용자정보를 가져오는 페이지입니다.
		     * Sample-AuthRequest에서 리턴페이지로 지정을 해주어야 연결되며 보여지는 항목의 상세한 내용은 가이드를참조하시기바랍니다.
		     */
		    // 인증 수신시 요청처와 동일한 위치인지를 session에 저장한 요청자 IP와 비교합니다.
			if (request.getRemoteAddr().equals(session.getAttribute("gpinUserIP")))
			{
		%>
			<script language="JavaScript" type="text/JavaScript">
				alert("아이핀 인증완료");
			</script>
		    <table border="1" style="display:none;">
		        <tr>
		            <td class="title"><font size="2">중복확인코드<!--(dupInfo)--></font></td>
		            <td class="content">
						<input type="text" id="dupinfo" name="dupinfo" size="70" value="<%= getSession(session, "dupInfo") %>"/>
					</td>
		        </tr>
		        <tr>
		            <td class="title"><font size="2">개인식별번호<!--(virtualNo)--></font></td>
		            <td class="content">
						<input type="text" id="virtualno" name="virtualno" value="<%= getSession(session, "virtualNo") %>"/>
					</td>
		        </tr>
		        <tr>
		            <td class="title"><font size="2">이름<!--(realName)--></font></td>
		            <td class="content">
						<input type="text" id="realname" name="realname" value="<%=getSession(session, "realName")%>"/>
					</td>
		        </tr>
		        <tr>
		            <td class="title"><font size="2">성별<!--(sex)--></font></td>
		            <td class="content">
						<input type="text" id="sex" name="sex" value="<%= getSession(session, "sex") %>"/>
					</td>
		        </tr>
		        <tr>
		            <td class="title"><font size="2">나이<!--(age)--></font></td>
		            <td class="content">
						<input type="text" id="age" name="age" value="<%= getSession(session, "age") %>"/>
					</td>
		        </tr>
		        <tr>
		            <td class="title"><font size="2">생년월일<!--(birthDate)--></font></td>
		            <td class="content">
						<input type="text" id="birthdate" name="birthdate" value="<%= getSession(session, "birthDate") %>"/>
					</td>
		        </tr>
		        <tr>
		            <td class="title"><font size="2">국적<!--(nationalInfo)--></font></td>
		            <td class="content">
						<input type="text" id="nationalinfo" name="nationalinfo" value="<%= getSession(session, "nationalInfo") %>"/>
					</td>
		        </tr>
		        <tr>
		            <td class="title"><font size="2">본인인증방법<!--(authInfo)--></font></td>
		            <td class="content">
						<input type="text" id="authinfo" name="authinfo" value="<%= getSession(session, "authInfo") %>"/>
					</td>
		        </tr>
		    </table>
		<%
			}
			else
			{
		%>
				<table>
					<tr>
						<td>세션값을 받지 못했습니다.</td>
					</tr>
				</table>
		<%
			}
		%>
			<br />
		
		</form>
	</body>
</html>