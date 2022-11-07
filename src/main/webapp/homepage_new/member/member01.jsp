<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>

<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<script>window.name="mother"</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
 
<script language="JavaScript" type="text/JavaScript">
    function idSearch() {
		if($F("id_name").replace(/ /g,'') == "") {
			$("id_name").focus();
			alert("이름을 입력해주세요.");
			return;
		}
		if($F("id_email").replace(/ /g,'') == "") {
			$("id_email").focus();
			alert("이메일을 입력해주세요.");
			return;
		}
		/*
		var isNumber = /^[0-9]+$/;
		if (!isNumber.test($F("id_jumin"))) { //익스플로 8버전 패치
			alert("숫자만 입력가능합니다.");
			$("id_jumin").value = "";
			$("id_jumin").focus();
			return;
		}
		if($F("id_jumin").length != 13) {
			$("id_jumin").focus();
			alert("13자리를 입력해주세요.");
			return;
		}
		*/
		var f_idArea = $("f_idArea");
		f_idArea.submit();
	}

	function pwSearch() {
		if($F("pw_userid").replace(/ /g,'') == "") {
			$("pw_userid").focus();
			alert("ID를 입력해주세요.");
			return;
		}
		if($F("pw_name").replace(/ /g,'') == "") {
			$("pw_name").focus();
			alert("이름을 입력해주세요.");
			return;
		}
		if($F("pw_email").replace(/ /g,'') == "") {
			$("pw_email").focus();
			alert("이메일을 입력해주세요.");
			return;
		}
		
		/*
		var isNumber = /^[0-9]+$/;
		if (!isNumber.test($F("email"))) { //익스플로 8버전 패치
			alert("숫자만 입력가능합니다.");
			$("pw_jumin").value = "";
			$("pw_jumin").focus();
			return;
		}

		
		if($F("pw_jumin").length != 13) {
			$("pw_jumin").focus();
			alert("13자리를 입력해주세요.");
			return;
		}		
		*/
				
		var f_pwArea = $("f_pwArea");
		f_pwArea.submit();
	}
	function checkNumber(div) {     
		if(div == "id") {
			if(event.keyCode == 13) {
				idSearch();
			}
		} else if(div == "pw") {
			if(event.keyCode == 13) {
				pwSearch();
			}
		}
		
		if((event.keyCode<48) || (event.keyCode>57)) {
			event.returnValue = false;
		}
	} 

	function menuTab(obj) {
		if(obj.src.indexOf("_on.gif") != -1) {
			return;
		}
		if(obj.id == "tabmenu1") {
			$("tabmenu2").src = $("tabmenu2").src.replace("_on.gif",".gif");
			$("id_userinfo").style.display = "block";
			$("id_ipenArea").style.display = "none";
			$("f_idArea").reset();
		} else if(obj.id == "tabmenu2") {
			$("tabmenu1").src = $("tabmenu1").src.replace("_on.gif",".gif");
			$("id_userinfo").style.display = "none";
			$("id_ipenArea").style.display = "block";
			$("f_idArea").reset();
		} else if(obj.id == "tabmenu3") {
			$("tabmenu4").src = $("tabmenu4").src.replace("_on.gif",".gif");
			$("pw_userinfo").style.display = "block";
			$("pw_ipenArea").style.display = "none";
			$("f_pwArea").reset();
		} else if(obj.id == "tabmenu4") {
			$("tabmenu3").src = $("tabmenu3").src.replace("_on.gif",".gif");
			$("pw_userinfo").style.display = "none";
			$("pw_ipenArea").style.display = "block";
			$("f_pwArea").reset();
		}
		obj.src = obj.src.replace(".gif","_on.gif");
	}

	//아이핀으로 실명 인증하기 
	function gPinAuthId() {
		wWidth = 360;
		wHight = 120;
		wX = (window.screen.width - wWidth) / 2;
		wY = (window.screen.height - wHight) / 2;
		var w = window.open("../G-PIN/Sample-AuthRequest.jsp?gpinAuthRetPage=ipinFindId", "gPinLoginWin", "directories=no,toolbar=no,left=200,top=100,width="+wWidth+",height="+wHight);
	}
	//아이핀으로 실명 인증하기 
	function gPinAuthPw() {
		wWidth = 360;
		wHight = 120;
		wX = (window.screen.width - wWidth) / 2;
		wY = (window.screen.height - wHight) / 2;
		var w = window.open("../G-PIN/Sample-AuthRequest.jsp?gpinAuthRetPage=ipinFindPw", "gPinLoginWin", "directories=no,toolbar=no,left=200,top=100,width="+wWidth+",height="+wHight);
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
                
 			    <div id="subContentArear">
					<div class="spaceTop"></div>
					<!-- content s ===================== -->
					<div id="content">
						<div class="dSet02">
							<div class="dch">
								<div class="findt">
									<ul>
										<li><a href="#"><img id="tabmenu1" onclick="menuTab(this);" src="/images/skin1/sub/findtab01_on.gif" alt="아이디찾기" /></a></li>
										<!-- <li><a href="#"><img id="tabmenu2" onclick="menuTab(this);" src="/images/skin1/sub/findtab02.gif" alt="공공아이핀인증" /></a></li> -->
									</ul>
								</div>
								<form id="f_idArea" name="f_idArea" method="post" action="/homepage/renewal.do?mode=member02">
								<table class="dW" id="id_userinfo">		
								<tr>
									<th class="thdw" width="70">이름</th>
									<td class="tddw"><input type="text" id="id_name" name="id_name" class="input02" style="width:115px;" maxlength="20" tabindex="1"/></td>
									<td class="td_btn" rowspan="2"><input type="image" src="/images/skin1/button/btn_find02.gif" alt="찾기" onclick="idSearch(); return false;" tabindex="3"/></td>
								</tr>
								<tr>
									<th class="thdw">이메일</th>
									<td class="tddw"><input type="text" id="id_email" name="id_email" class="input02" style="width:115px;" maxlength="40" tabindex="2"/></td>
									
								</tr>
								</table>
								</form>
								<br />
								<div id="id_ipenArea" style="display:none;padding-left:8px;">
									<div class="ipin03">
										<span>공공아이핀(I-PIN)</span>은 인터넷상의 개인식별번호를<br/> 
										의미하며, 대면확인이 어려운 인터넷에서 주민등록<br/>
										번호를 사용하지 않고도 확인할 수 있는 수단입니다.<br/> 
									</div>
									<div class="btn_ipin02">
                                    <br />
                                    <center>
									<input type="image" src="/images/skin1/button/btn_ipin01.gif" alt="공공아이핀인증" onclick="gPinAuthId();"/>
                                    </center>
                                        <br />
									</div>
									<div class="ipin04">
										<span>공공아이핀(I-PIN)관련 문의처</span><br/> 
										*공공 I-PIN서비스센터<br/> 
										http://www.gpin.go.kr TEL02-3279-3480~2<br/> 
										*인재개발원<br/> 
										TEL 032-440-7684
									</div>
								</div>
							</div>
						</div>
						<div class="dSet03">
							<div class="dch">
								<div class="findt">
									<ul>
										<li><a href="#"><img id="tabmenu3" onclick="menuTab(this);" src="/images/skin1/sub/findtab03_on.gif" alt="비밀번호찾기" /></a></li>
										<!-- <li><a href="#"><img id="tabmenu4" onclick="menuTab(this);" src="/images/skin1/sub/findtab02.gif" alt="공공아이핀인증" /></a></li> -->
									</ul>
								</div>
								<form id="f_pwArea" name="f_pwArea" method="post" action="/homepage/renewal.do?mode=member03">
								<table class="dW" id="pw_userinfo">		
								<tr>
									<th class="thdw" width="70">아이디</th>
									<td class="tddw"><input type="text" id="pw_userid" name="pw_userid" class="input02" style="width:115px;ime-mode:disabled;" tabindex="4"/></td>
									<td class="td_btn" rowspan="3"><input type="image" src="/images/skin1/button/btn_find02.gif" alt="찾기" onclick="pwSearch(); return false;" tabindex="7" maxlength="20"/></td>
								</tr>
								<tr>
									<th class="thdw">이름</th>
									<td class="tddw"><input type="text" id="pw_name" name="pw_name" class="input02" style="width:115px;" tabindex="5" maxlength="20"/></td>
								</tr>
								<tr>
									<th class="thdw">이메일</th>
									<td class="tddw">
										<input type="text" id="pw_email" name="pw_email" class="input02" style="width:115px;" tabindex="6" maxlength="40"/>
									</td>
								</tr>
								</table>
								</form>
								<br />
								<div id="pw_ipenArea" style="display:none;padding-left:8px;">
									<div class="ipin03">
										<span>공공아이핀(I-PIN)</span>은 인터넷상의 개인식별번호를<br/> 
										의미하며, 대면확인이 어려운 인터넷에서 주민등록<br/>
										번호를 사용하지 않고도 확인할 수 있는 수단입니다.<br/> 
									</div>
									<div class="btn_ipin02">
                                        <br />
									<center><input type="image" src="/images/skin1/button/btn_ipin01.gif" alt="공공아이핀인증" onclick="gPinAuthPw();"/></center>
                                        <br />
									</div>

									<div class="ipin04">
										<span>공공아이핀(I-PIN)관련 문의처</span><br/> 
										*공공 I-PIN서비스센터<br/> 
										http://www.gpin.go.kr TEL02-3279-3480~2<br/> 
										*인재개발원<br/> 
										TEL 032-440-7684
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- //content e ===================== -->
					</div>
				<div class="space"></div>
				<!-- search01 -->
            <!-- //contnet -->
          </div>
        </div>    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>