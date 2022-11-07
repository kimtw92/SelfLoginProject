<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%
	LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천광역시 인재개발원에 오신 것을 환영합니다.</title>

<link rel="stylesheet" href="/commonInc/css/pop_id.css" type="text/css" />
<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script language = "javascript">
	function fnLoginOut(){
		pform.action = "/homepage/login.do?mode=loginOut";
		pform.submit();	
	}

	function existid(){
		eval("var Str = document.pform.USER_ID.value") ;

		if(Str == "") {
			alert("아이디를 입력해 주십시오.") ;
			return; 
		}
		for(i=0; i<Str.length; i++){
			Chr = Str.charAt(i) ;
			if(Str.length < 9 || Str.length > 12) {
				alert("아이디는 9자 이상, 12자 이하 이어야 합니다.") ;
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

		var id = $F('idform');

		new Ajax.Request('/homepage/join.do?mode=idcheckajax' , {
			parameters : {
				userid : id
			},
			onSuccess : function(request) {
				try {
					var num = request.responseText;
					if(num == 1) {
						alert("사용불가능한 아이디입니다.");
					}else {
						alert("사용가능한 아이디 입니다.");
						$('oUserid').value = $F('idform');
					}	
				} catch(e) {
					alert(e.description);
				}
			},
			on401: function() {
				alert("세션이 종료되었습니다.");
			},
			onFailure : function() {
				alert("오류 발생");
			}
		});

	}
	
	function updateId() {
		if($F('idform') == "") {
			$('idform').focus();
			alert("아이디를 입력해주세요.");
			return;
		}

		if($F('oUserid') == "") {
			alert("아이디 중복체크를 해주세요.");
			return;
		}

		if(confirm("마지막으로 검색된 [ " + $('oUserid').value + " ] 로 등록 하시겠습니까? \n * 한번 등록한 아이디는 변경이 불가능 합니다.")) {
		    new Ajax.Request('/member/member.do?mode=ajaxCreateId' , {
				parameters : {
					userid : $F('oUserid')
					,userno : $F('userno')
				},
				onSuccess : function(request) {
					try {
						var num = request.responseText;
						if(num == 1) {
							alert("등록 완료\n다시로그인 해주세요.");
							fnLoginOut();
							window.close();
							return;
						} else {
							if(num == -2) {
								alert("잘못된 접근방법입니다.");
								return;
							}
							alert("아이디 변경 실패 관리자에게 문의해주세요.");
						}
					} catch(e) {
						alert(e.description);
					}
				},
				on401: function() {
					alert("세션이 종료되었습니다.");
				},
				onFailure : function() {
					alert("오류 발생");
				}
		    });
		}
	}
</script>
</head>

<body>

<div id="wrap">
  <form id="pform" name="pform" method="post" action="">
  <h1>아이디 등록</h1>
  <h3>아이디를 입력해 주세요.</h3>
  <div class="p_id_box">
 <span class="p_id_s1" style="padding:6px;">ID </span> 미등록자입니다. 반드시 <span class="p_id_s1">ID</span> 를 등록해 주시기 바랍니다.
    <label><span class="p_id_s">ID</span>
		<input type="text" id="idform" name="USER_ID" class="pop_id" style="width:130px;ime-mode:disabled" maxlength="12" />
		<a href="javascript:existid();"><img src="/commonInc/css/img/pop_id_05.gif" class="pop_id_bt" /></a>
		<input type="hidden" id="oUserid" name="oUserid" />
		<input type="hidden" id="userno" name="userno" value="<%=loginInfo.getSessNo() %>" />
	</label>
  </div>
<br />
	
	<table border="1" style="border:1px solid #cccccc;" width="450px">
	<tr>
	<td>    
	※ 개인정보보호법에 의거 주민등록번호를 이용한 In2In에서 인재개발원으로의 <br /> <font color="blue">통합로그인(SSO)이</font> 중단됩니다. ID가 없는 회원은
	통합로그인(SSO) 중단 전 <br /> 반드시 ID를 등록하여 주시기 바랍니다.
	<br /><font color="red">ID 미등록시 향후 인재개발원 서비스 이용이 제한됩니다.</font><br/>
	☞ 통합로그인(SSO) 중단 일시 : 2014. 9월 예정
	</td>
	</tr>
	</table>

  <!-- p class="p_id_box2">
    <span class="p_id_s1">ID </span> 미등록자입니다. 반드시 <span class="p_id_s1">ID</span> 를 등록해 주시기 바랍니다.
	※ 개인정보보호법에 의거 주민등록번호를 이용한 In2In에서 인재개발원으로의 통합로그인(SSO)이 중단됩니다. ID가 없는 회원은
	통합로그인(SSO) 중단 전 반드시 ID를 등록하여 주시기 바랍니다.
	ID 미등록시 향후 인재개발원 서비스 이용이 제한됩니다.
	☞ 통합로그인(SSO) 중단 일시 : 2014. 9월 예정
  </p -->

  <p class="p_id_box3">
    <a href="javascript:updateId();"><img src="/commonInc/css/img/pop_id_09.gif" alt="저장"/></a>
    <a href="javascript:self.close();"><img src="/commonInc/css/img/pop_id_11.gif" alt="닫기"/></a>
  </p>

</form>
</div>


</body>
</html>
