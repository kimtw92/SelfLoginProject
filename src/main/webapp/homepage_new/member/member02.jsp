<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%@ page import="gov.mogaha.gpin.sp.util.StringUtil "%>
<%
	String name = StringUtil.nvl((String)request.getAttribute("name"),"");
	String userid = StringUtil.nvl((String)request.getAttribute("userid"), "");
	String userno = StringUtil.nvl((String)request.getAttribute("userno"), "");
	String mode = StringUtil.nvl((String)request.getAttribute("mode"), "");
%>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
 
<script language="JavaScript" type="text/JavaScript">
	window.onload = idCheck;
	var userid = "<%=userid%>";
	var mode = "<%=mode%>";
	function idCheck() {
		var userid = "<%=userid%>";
		if(userid.replace(/ /g,'') == "") {
			if(confirm("회원정보가 틀리거나 회원 ID가 없습니다. \n\n 회원가입으로 이동하시겠습니까?")){
				document.location.href = "/homepage/join.do?mode=joinstep1";
				return;
			}
			if(mode.indexOf("ipinFindId") != -1) {
				document.location.href = "/homepage/renewal.do?mode=member01";
				return;
			} else {
				history.go(-1);
				return;
			}
		}
		$("subContentArear").style.display = "block";
	}
	function goMember01() {
		document.location.href = "/homepage/renewal.do?mode=member01";
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
			<input type="hidden" id="userid" name="userid" value="<%=userid%>"/>
			<div id="subContentArear" style="display:none;">
				<div class="spaceTop"></div>
				<div class="joinUsMtSet02" id="joinUsMtSet02">
				<%if(!"nullid".equals(userid)) { %>
					<div class="joinUsMt02">
						<strong><span id="search_name_area"><%=name%></span></strong> 님의 아이디는 <strong class="txt_blue"><span id="search_id_area"><%=userid%></span></strong> 입니다.
						<div class="btn_c04">
							<input type="image" src="/images/skin1/button/btn_submit06.gif" alt="확인" onclick="goMember01(); return;"/>
						</div>
					</div>		
				<% } else { %>
					<form id="pform" name="pform" method="post" action="">
					<div class="joinUsMt02">
						<strong><span id="search_name_area"><%=name%></span></strong> 님의 아이디는 미등록된 ID 입니다. 부가정보 입력후 수정해주세요.
						<br />생년월일 : <input class="input02"  type="text" id="birthdate" name="birthdate" maxlength="8" style="ime-mode:disabled" onkeyDown="go_commNumCheck()"/> ex) 19831019
						<br />핸드폰번호 : <input class="input02"  type="text" id="hp" name="hp" maxlength="11" style="ime-mode:disabled" onkeyDown="go_commNumCheck()"/> ex)01000000000
						<br />사용하실ID : <input class="input02"  type="text" id="createid" name="createid" style="ime-mode:disabled" maxlength="12" />
						<a href="javascript:existid();">ID중복 체크</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="btn_c04" style="margin-top:5px;">
							<input type="hidden" id="oUserid" name="oUserid" />
							<input type="hidden" id="userno" name="userno" value="<%=userno %>" />
							<input type="image" src="/images/skin1/button/btn_submit07.gif" alt="확인" onclick="goCreateID(); return false;"/>
						</div>
					</div>		
					</form>
					
<script language="JavaScript" type="text/JavaScript">
	function goCreateID() {
		if($F("birthdate") == "") {
			alert("생년월일을 입력해주세요.");
			$("birthdate").focus();
			return;
		} else if($F("hp") == "") {
			alert("핸드폰번호를 입력해주세요.");
			$("hp").focus();
			return;
		} else if($F("createid") == "") {
			alert("ID를 입력해주세요.");
			$("createid").focus();
			return;
		} else if($F("oUserid") == "") {
			alert("ID중복 체크를 해주세요.");
			return;
		}

		if(confirm("마지막으로 검색된 [ " + $('oUserid').value + " ] 로 등록 하시겠습니까? \n * 한번 등록한 아이디는 변경이 불가능 합니다.")) {
		    new Ajax.Request('/member/member.do?mode=ajaxCreateId2' , {
				parameters : {
					userid : $F('oUserid')
					,userno : $F('userno')
					,hp : $F('hp')
					,birthdate : $F('birthdate')
				},
				onSuccess : function(request) {
					try {
						var num = request.responseText;
						if(num == 1) {
							alert("ID : [" + $F('oUserid') + "] 등록완료");
							document.location.href = "/homepage/renewal.do?mode=member01";
							return;
						} else {
							if(num == -2) {
								alert("잘못된 접근방법입니다.");
								history.go(-1);
								return;
							}
							alert("입력하신 개인정보가 틀립니다. 다시 확인후 시도해주세요.");
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

	function existid(){

		eval("var Str = document.pform.createid.value") ;

		if(Str == "") {
			alert("아이디를 입력해 주십시오.") ;
			return; 
		}
		for(i=0; i<Str.length; i++){
			Chr = Str.charAt(i) ;
			if(Str.length < 9 || Str.length > 12) {
				alert("아이디는 9자 이상, 12자 이하 이어야 합니다.") ;
				eval("document.pform.createid.value = ''") ;
				eval("document.pform.createid.focus()") ;       
				return;     
			}  
			if((Chr < "0" || Chr > "9") && (Chr < 'a' || Chr > 'z')) {
				alert("아이디는 영문(소문자, 숫자포함) 이어야 합니다.") ;
				eval("document.pform.createid.value = ''") ;
				eval("document.pform.createid.focus()") ;
				return ;
			}
		}

		var id = $F('createid');

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
						$('oUserid').value = $F('createid');
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
</script>					
				<% } %>
				</div>
			</div>
		<!-- //contnet -->
	  </div>
	</div>    
</div>

<jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>