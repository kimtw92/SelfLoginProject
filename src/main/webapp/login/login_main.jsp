<%@page import="loti.mypage.service.PaperService"%>
<%@page import="org.springframework.web.servlet.FrameworkServlet"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page language="java"  pageEncoding="UTF-8"%>
<%
// prgnm : 로그인 페이지 include 용
// date : 2008-05-13
// auth : kang
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%

	// 로그인 여부

System.out.println("TMAX Session ID : " + session.getId());
System.out.println("TMAX sess_loginYn : " + session.getAttribute("sess_loginYn"));


	String loginDisplayYn = ut.lib.util.Util.getValue((String)session.getAttribute("sess_loginYn"),"N");
	
	StringBuffer sbAuthHtml = new StringBuffer();
	int intAuthCount = 0;	
	String curAuth = "";
	String tmpAuth = "";
	String tmpUserName = "";
	
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);							
	
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	if(memberInfo.isLogin() == true){

		curAuth =  memberInfo.getSessCurrentAuth();
		tmpUserName = Util.getValue(memberInfo.getSessName(), "");
		
		///////////////////////////////////
		// 사용자 권한 셀렉트박스
		// 세션에 있는 권한 배열을 가져온다.
		if(curAuth != null && memberInfo.getSessAuth() != null){ 

			intAuthCount = memberInfo.getSessAuth().length;
			sbAuthHtml.append("<select id=\"cboAuth\" name=\"cboAuth\" style=\"width=200px;\" onchange=\"fnSelectAuth();\">");
			if(intAuthCount > 0){
				for(int i=0; i < intAuthCount; i++){
					
					tmpAuth = memberInfo.getSessAuth()[i][0];
					
					if(curAuth != "8"){
						curAuth = "8";
						tmpAuth = "8";					
					}
					
					sbAuthHtml.append("<option value='" + memberInfo.getSessAuth()[i][0] + "' " + ( curAuth.equals(tmpAuth) ? "selected":""  ) + " >" + memberInfo.getSessAuth()[i][1] +"</option>");
				}
			}else{
				sbAuthHtml.append("<option value=''>권한없음</option>");
			}
			sbAuthHtml.append("</select>");
			
		}

		
	
		///////////////////////////////////
	}	

	
	// 쪽지
	String newPaperCount = "0";
	if(loginDisplayYn.equals("Y")){
		PaperService paperService = SpringUtils.getBean(PaperService.class);
		DataMap paperCountData = null;		// 현재 쪽지 갯수
		paperCountData = paperService.paperNewCount(memberInfo.getSessNo());	
		if( paperCountData != null){
			paperCountData.setNullToInitialize(true);
			newPaperCount = paperCountData.getString("countPaper");
			
		}
	}
	
	String cookieId = Util.getValue(Util.getCookie(request, "cid"));
	
	// test용
	// 실서버 반영시 주석처리 할것
	//cookieId = "s9631167";
	
%>

<script language="JavaScript" type="text/JavaScript">

function fnLogin() {
	
        if($("#userId").val() == "") {
			alert("ID 를 입력해주세요.");
			$("#userId").focus();
			return;
		} else if($("#pwd").val() == "") {
			alert("비밀번호를 입력해주세요.");
			$("#pwd").focus();
			return;
		}
	
		if(document.loginForm){
			// 아이디 공백 제거 (2020.01.13// 김양호/7686)
			$("#userId").val($("#userId").val().replace(/ /gi, ""));
			if($("input:checkbox[id='id_check']").is(":checked") == true ){
				setCookie("save");
			}else{
				setCookie("");
			}
			// pfrom.method="CONNECT";
			if ($("input:checkbox[id='security_check']").is(":checked") == true){
				document.loginForm.action = "https://<%=request.getServerName()%>/homepage/login.do?mode=loginChk";
			} else {
				document.loginForm.action = "/homepage/login.do?mode=loginChk";
			}
			document.loginForm.submit();	
		}		
	/*
    var url = "";
	
	url = "/homepage/login.do";
	var userid = $F('userId');
	var passwd = $F('pwd');
	
	userid = userid.replace(/'/g,'').replace(/"/g,'').replace(/ /g,'');
	passwd = passwd.replace(/'/g,'').replace(/"/g,'').replace(/ /g,'');
	
	
	var pars = "mode=passwordNullCheckAjax&id="+userid+"&pw="+passwd;
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
	if(response == 'YES') {
		window.open("login.do?mode=setpasswordstep1","abc", "width=460,height=388, left=200, top=200, menubar=0, toolbar=0, status=0, location=0");
		//alert('오케이 팝업 띄워');
		//return;
	}else {
//		if(NChecker(document.loginForm)){

		if($("#userId").val() == "") {
			alert("ID 를 입력해주세요.");
			$("#userId").focus();
			return;
		} else if($("#pwd").val() == "") {
			alert("비밀번호를 입력해주세요.");
			$("#pwd").focus();
			return;
		}
	
		if(document.loginForm){
			if($("input:checkbox[id='id_check']").is(":checked") == true){
				setCookie("save");
			}else{
				setCookie("");
			}
			// pfrom.method="CONNECT";
			if ($("input:checkbox[id='security_check']").is(":checked") == true){
				document.loginForm.action = "https://<%=request.getServerName()%>/homepage/login.do?mode=loginChk";
			} else {
				document.loginForm.action = "/homepage/login.do?mode=loginChk";
			}
			
			document.loginForm.submit();	
		}		
	}
}

function alertProcess() {
	alert("에러가 발생하였습니다.\n관리자에게 문의 주시기 바랍니다.");
}

//function fnLogin(){
//	if(NChecker(document.loginForm)){
//		if($("idsave").checked == true){
//			setCookie("save");
//		}else{
//			setCookie("");
//		}
//		loginForm.action = "/homepage/login.do?mode=loginChk";
//		loginForm.submit();		
//	}
//}

function fnLoginOut(){
	document.loginForm.action = "/homepage/login.do?mode=loginOut";
	document.loginForm.submit();	
}



function open_window(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable){
	toolbar_str = toolbar ? 'yes' : 'no';
	menubar_str = menubar ? 'yes' : 'no';
	statusbar_str = statusbar ? 'yes' : 'no';
	scrollbar_str = scrollbar ? 'yes' : 'no';
	resizable_str = resizable ? 'yes' : 'no';
	window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
}


function setCookie(ptype) {
	var name = "cid";
	var value = $("#userId").val();
	var expires = new Date(); 
	if(ptype == "save"){
		expires.setTime(expires.getTime() + 24*60*60*30*1000); 
	}else{
		expires.setTime(expires.getTime() + 1); 
	}
	
	var expiryDate= expires.toGMTString(); 	
	
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + expiryDate + ";"	
}


//-->
</script>
<style>

/* #idsp{
 margin-left: 80px;
}
#logoutsp{
margin-left: 130px; 
} */

</style>
			<form id="loginForm" name="loginForm" method="post">
					<div class="login_after_box" <%= loginDisplayYn.equals("Y") ? "":"style=\"display:none\"" %>>
						<div class="login_after">
							
							<span><%= sbAuthHtml.toString() %></span>
							<span <%= sbAuthHtml.toString().isEmpty() ? "style=\"margin-left: 30px;\"" : "style=\"margin-left: 80px;\"" %>><%= tmpUserName %>(<%=(String)session.getAttribute("sess_userid") %>)</span>							
							<span <%= sbAuthHtml.toString().isEmpty() ? "style=\"margin-left: 140px;\"" : "style=\"margin-left: 130px;\"" %>><a href="javascript:fnLoginOut();">로그아웃</a></span>
						</div>
						<div class="login_after">
							<a href="javascript:fnGoMenu('1','main');">마이페이지</a>
							<a href="/mypage/myclass.do?mode=personalinfomodify">개인정보변경</a>
						</div>
					</div>
		
		    <!-- 로그인 전 -->
					<div class="login_box" <%= loginDisplayYn.equals("Y") ? "style=\"display:none\"":"" %>>
						<div class="login">
							<input type="text" id="userId" name="userId" title="아이디" placeholder="아이디" class="login_id"
								value="<%= cookieId %>" required="true!아이디가 없습니다." onKeyPress="if(event.keyCode == 13){fnLogin();}" />
							<input type="password" id="pwd" name="pwd" title="비밀번호" placeholder="비밀번호" class="login_pw" 
							 onKeyPress="if(event.keyCode == 13) {fnLogin();}" required="true!암호가 없습니다."/>
							<a href="#none" onClick="javascript:fnLogin();">로그인</a>
						</div>
						<div class="login_check">
							<div class="security_check">
								<input type="checkbox" id="security_check" name="security_check" checked />
								<label for="security_check">보안접속</label>
							</div>
							<div class="id_check">
								<input type="checkbox" id="id_check" name="id_check" <%= cookieId.equals("")? "":"checked" %> />
								<label for="id_check">아이디 저장</label>
							</div>
							<div class="login_gnb">
								<a href="/homepage/join.do?mode=joinstep1">회원가입</a>
								<a href="/homepage/renewal.do?mode=member01">아이디/비밀번호 찾기</a>
							</div>
						</div>
					</div>
		<!-- //login -->
		</form>
