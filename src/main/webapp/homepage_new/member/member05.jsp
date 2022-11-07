<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%@ page import="gov.mogaha.gpin.sp.util.StringUtil "%>
<%
	String userid = StringUtil.nvl((String)request.getAttribute("userid"), "");
	String checkYN = StringUtil.nvl((String)request.getAttribute("checkYN"), "");
%>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<script>window.name="mother"</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
 
<script language="JavaScript" type="text/JavaScript">
	window.onload = idCheck;
	var userid = "<%=userid%>";
	var checkYN = "<%=checkYN%>";
	function idCheck() {
		if(checkYN.replace(/ /g,'') == "" || checkYN == "N") {
			alert("답변이 틀렸습니다.");
			history.go(-1);
			return;
		}
		if(userid.replace(/ /g,'') == "") {
			alert("검색된데이타가없습니다.");
			history.go(-1);
			return;
		}
		$("content").style.display = "block";
	}
	function changePasswd(){
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
							alert("비밀번호는 9자 이상, 12자 이하 이어야 합니다.") ;
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
					if(document.pform.PWD.value.indexOf(document.pform.userid.value) != -1) {
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
			}
		}
		eval("var Str = document.pform.PWD.value") ;
		for(i=0; i<Str.length; i++){
			Chr = Str.charAt(i);   
			if(Str.length < 9 || Str.length > 12) {
				alert("비밀번호는 9자 이상, 12자 이하 이어야 합니다.") ;
				eval("document.pform.PWD.value = ''") ;
				eval("document.pform.PWD_CHK.value = ''") ;
				eval("document.pform.PWD.focus()") ;       
				return;     
			}
		}
		sendPasswd();
	}
	function sendPasswd() {
		var form1 = document.pform;
		var checkYN = $F('checkYN');
		if(checkYN != "Y") {
			alert("변경 권한이없습니다.");
			return;
		}
		var pwd = form1.PWD.value
		var pwd_chk = form1.PWD_CHK.value;
		var userid = form1.userid.value;
        /*
		var url="/homepage/renewal.do";
		var pars = "mode=ajaxChangePasswd&PWD="+pwd+"&PWD_CHK="+pwd_chk+"&checkYN="+checkYN+"&userid="+userid;
		var request = new Ajax.Request (
			url,
			{
				method:"post", 
				parameters : pars,
				onSuccess : sendPasswordSuccess,
				onFailure : sendPasswordFailure
			}	
		);
        */
        form1.submit();
	}

	function sendPasswordSuccess(request) {
		var response = request.responseText;
		if(response.indexOf("-10") != -1) {
			alert("패스워드 변경 권한이없습니다.");
			return;
		} else if(response.indexOf("-20") != -1) {
			alert("패스워드 변경중 오류가발생했습니다.");
			return;
		} else if(response.indexOf("100") != -1) {
			alert("변경성공");
			document.location.replace("/");
			return;
		}
	}

	function sendPasswordFailure() {
		alert("패스워드이 실패 했습니다.");
	}
	function keyEvent() {     
		if(event.keyCode == 13) {
			changePasswd();
		}
	} 

</script>
    <div id="subContainer">
    <div class="subNavi_area">
      <jsp:include page="/login/main_login.jsp" flush="false"/>   
      </div>
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual1.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>아이디/비밀번호 찾기</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; <span>아이디/비밀번호 찾기</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<form id="pform" name="pform" method="POST" action="https://hrd.incheon.go.kr/homepage/renewal.do?mode=ajaxChangePasswd">
			<div id="content" style="display:none;">
				<!-- data -->
				<div class="dSchSet02">
				<div class="dSch">
					<dl>
		                <dt> 새로운 비밀번호</dt>
		                <dd>
		                    <input type="password" id="PWD" name="PWD" class="input01 w158" maxlength="12"/> 영문, 숫자 포함 9자 이상 12자 미만 '특수문자포함'
		                </dd>
		            </dl>
					<div class="line02"></div>
					<dl>
		                <dt> 비밀번호 확인</dt>
		                <dd>
		                	&nbsp;&nbsp;
		                    <input type="password" id="PWD_CHK" name="PWD_CHK" class="input01 w158" maxlength="12" onkeypress="keyEvent();"/> 입력하신 비밀번호를 다시 한번 입력해 주세요.
		                </dd>
		            </dl>
				</div>
			</div>
			<input type="hidden" id="userid" name="userid" value="<%=userid%>"/>
			<input type="hidden" id="checkYN" name="checkYN" value="<%=checkYN%>"/>
			<div class="btn_c02">
				<input type="image" src="/images/skin1/button/btn_submit05.gif" alt="확인" onclick="changePasswd(); return false;"/>
			</div>
			<!-- //data -->
		</div>
		<div class="h80"></div>
		</form>
            <!-- //contnet -->
          </div>
        </div>    
    </div>
    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>