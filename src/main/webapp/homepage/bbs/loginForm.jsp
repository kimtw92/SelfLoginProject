<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// prgnm 	: 실명인증
	// date		: 2008-09-30
	// auth 	: jong03
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>

<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<script language="javascript" src="/commonInc/js/commonJs.js"></script>

<%
	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
%>

	<script language="JavaScript" type="text/JavaScript">
	<!--
		// 페이지 이동
		function go_page(page) {
			$("currPage").value = page;
			fnList();
		}
		
		// 리스트
		function fnList(){
			$("mode").value = "freeBoardList";
			pform.action = "/homepage/support.do";
			pform.submit();
		}
		
		//리스트
		function goSearch(){
			$("currPage").value = "1";
			$("mode").value = "freeBoardList";
			pform.action = "/homepage/support.do";
			pform.submit();
		}
		
		//상세보기
		function onView(form){
			// $("mode").value = "View";
			$("qu").value = "selectBbsBoardview";
			$("boardId").value = "BBS";
			pform.action = "/homepage/support.do?mode=freeBoardView&seq="+form;
			pform.submit();
		}
		
		//글쓰기폼으로 이동
		function goWrite(){
			$("qu").value = "insertBbsBoardForm";
			$("boardId").value = "BBS";
			$("mode").value = "freeBoardWrite";
			pform.action = "/homepage/support.do";
			pform.submit();
		}
		
		//실명확인
		function authCheck() {
		
			if($F('checkName') == '') {
				alert("이름을 입력해 주십시오.");
				return;
			} else if($F('checkName').length < 2) {
				alert("이름은 2자 이상입니다.");
				return;
			} else if($F('juminNum1').length != 6) {
				alert("주민등록번호 앞자리는 6자입니다.");
				return;
			} else if($F('juminNum2').length != 7) {
				alert("주민등록번호 뒷자리는 7자입니다.");
				return;
			} else if($F('juminNum2').substr(0,1)!=1 && $F('juminNum2').substr(0,1)!=2) {
				alert("잘못된 주민등록번호 형식입니다.");
				return;
			}
			
			//var pars = "mode=authCheckAjax&name="+$F('username')+"&resno="+$F('ssn1')+$F('ssn2');
			$("mode").value = "realNameCheck";
			pform.action = "/homepage/support.do";
			pform.submit();
		}
		
		//로그인
		function goLogin() {

        if($("userId").value == "") {
			alert("ID 를 입력해주세요.");
			$("userId").focus();
			return;
		} else if($("pwd").value == "") {
			alert("비밀번호를 입력해주세요.");
			$("pwd").focus();
			return;
		}
	
		if(document.loginForm){
			if($("idsave").checked == true){
				setCookie("save");
			}else{
				setCookie("");
			}
			// pfrom.method="CONNECT";
			if ($("security").checked == true){
				document.loginForm.action = "https://<%=request.getServerName()%>/homepage/login.do?mode=loginChk";
			} else {
				document.loginForm.action = "/homepage/login.do?mode=loginChk";
			}
			
			document.loginForm.submit();	
		}		

			/*
			var url = "/homepage/login.do";
			var user_id = $('user_id').value;
			var user_pwd = $('user_pwd').value;
		
			$('userId').value = $('user_id').value;
			$('pwd').value = $('user_pwd').value;
			
			var pars = "mode=passwordNullCheckAjax&id="+user_id+"&pw="+user_pwd;
			
			var request = new Ajax.Request (
				url,
				{
					method:"POST",
					parameters : pars,
					onSuccess : setPasswordloginProcess,
					onFailure : alertProcess
				}
			);
            */
		}
		
		function setPasswordloginProcess(request) {
			var response = request.responseText;
		
			alert(response);
			
			if(response == 'YES') {
				window.open("login.do?mode=setpasswordstep1","abc", "width=460,height=388, left=200, top=200, menubar=0, toolbar=0, status=0, location=0");
				//return;
			}else {
				if(NChecker(document.pform)){
					//if($("idsave").checked == true){
						//setCookie("save");
					//}else{
						//setCookie("");
					//}
					// pfrom.method="CONNECT";
					//if ($("security").checked == true){
						//pform.action  = "https://<%//=request.getServerName()%>/homepage/login.do?mode=loginChk";
						// url = "http://hrd.incheon.go.kr/homepage/login.do";
						// url = "/homepage/login.do";
						// alert(url);
					//} else {
						//pform.action = "http://<%//=request.getServerName()%>/homepage/login.do?mode=loginChk";
						//url = "/homepage/login.do";
						//alert(url);
					//}
					
					pform.action = "/homepage/login.do?mode=loginChk";
					pform.submit();	
				}		
			}
		}
		
		function alertProcess() {
			alert("에러가 발생하였습니다.\n관리자에게 문의 주시기 바랍니다.");
		}
	//-->
	</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

	<form id="pform" name="pform" method="post">
		<!-- 필수 -->
		<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>" />
		<input type="hidden" name="qu"		value="<%= requestMap.getString("qu") %>" />
		<input type="hidden" name="url"		value="<%= requestMap.getString("url") %>" />
		<input type="hidden" name="seq"		value="<%= requestMap.getString("seq") %>" />
		<input type="hidden" name="boardId" value="<%= requestMap.getString("boardId") %>" />
		<!-- 페이징용 -->
		<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>" />
	
		<div id="wrapper">
			<div id="dvwhset">
				<div id="dvwh">
					<!--[s] header -->
					<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
						<jsp:param name="topMenu" value="4" />
					</jsp:include>
					<!--[e] header -->						
					
					<div id="middle">			
						<!--[s] left -->
						<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
							<jsp:param name="leftMenu" value="4" />
							<jsp:param name="leftIndex" value="1" />
							<jsp:param name="leftSubIndex" value="3" />
						</jsp:include>
						<!--[e] left -->
		
						<!-- contentOut s ===================== -->
						<div id="subContentArear">
							<!-- content image
							<div id="contImg"><img src="/images/<%=skinDir %>/sub/img_cont00.jpg" alt="" /></div>
							//content image -->
					
							<!-- title/location -->
							<div id="top_title">
								<h1 id="title">
									<img src="/images/<%=skinDir %>/title/tit_login.gif" alt="마이페이지" />
								</h1>
								<div id="location">
								<ul> 
									<li class="home"><a href="">HOME</a></li>
									<li class="on">로그인화면</li>
								</ul>
								</div>
							</div>
							<!-- title/location -->
							<div class="spaceTop"></div>
					
							<!-- content s ===================== -->
							<div id="content">
							<div class="space01"></div>
							
							<!-- data -->
							<div class="dSchSet" style="height:140px;">
								<div class="dSch03">
								
									<div class="memberY">
										<h2 class="h2">
											<img src="/images/<%=skinDir %>/title/tit_memberY.gif" alt="" />
										</h2>
										<div class="loginBtnSet01">
											<ul class="loginBtn01">
												<li class="left">
													<span class="txt01">아이디</span>
													<input type="text" id="user_id" name="user_id" class="input01 mb" style="width:125px;" /><br />
													<span class="txt01">비밀번호</span>
													<input type="password" id="user_pwd" name="user_pwd" class="input01" style="width:125px;" />
												</li>
												<li class="right">
													<a href="javascript:goLogin();">
														<img src="/images/<%=skinDir %>/button/btn_login02.gif" alt="로그인" />
													</a>
												</li>
											</ul>
										</div>
									</div>
						
									<!-- 2011.01.11 - woni82 - 비회원 로그인 기능 제거함. -->
									<!-- <div class="memberN">
										<h2 class="h2">
											<img src="/images/<%=skinDir %>/title/tit_memberN.gif" alt="" />
										</h2>
										<div class="loginBtnSet01">
											<ul class="loginBtn01">
												<li class="left">
													<span class="txt01">이름</span>
													<span class="inp01">
														<input type="text" id="checkName" name="checkName" class="input01 mb" style="width:125px;" />
													</span>
													<br />
													<span class="txt01">주민등록번호</span>
													<span class="inp01">
														<input type="text" id="juminNum1" name="juminNum1" maxlength="6" class="input01" style="width:54px;" /> -
														<input type="password" id="juminNum2" name="juminNum2" maxlength="7" class="input01" style="width:53px;" />
													</span>
												</li>
												<li class="right">
													<a href="javascript:authCheck();">
														<img src="/images/<%=skinDir %>/button/btn_login02.gif" alt="로그인" />
													</a>
												</li>
											</ul>
										</div>
									</div> -->
									
									<div class="h6"></div>	
								</div>
							</div>
							<!-- //data --> 			
							<div class="space"></div>		
						</div>
							<!-- //content e ===================== -->
					
						</div>
						<!-- //contentOut e ===================== -->
		
					
						<div class="spaceBtt"></div>
					</div>			
				</div>
				
				<div id="divQuickMenu" style="position:absolute; top:10; left:89%; width:90px; height:264px; z-index:1">
					<!--[s] quick -->
					<jsp:include page="/commonInc/include/comQuick.jsp" flush="false"/>
					<!--[e] quick -->
				</div>
			</div>
			<!--[s] footer -->
			<jsp:include page="/commonInc/include/comFoot.jsp" flush="false"/>
			<!--[e] footer -->
		</div>
	
	</form>
</body>	