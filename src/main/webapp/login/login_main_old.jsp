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
					
					sbAuthHtml.append("<option value='" + memberInfo.getSessAuth()[i][0] + "' " + ( curAuth.equals(tmpAuth) ? "selected":""  ) + " >" + memberInfo.getSessAuth()[i][1] + "</option>");
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
<!--

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
			if($("input:checkbox[id='idsave']").is(":checked") == true ){
				setCookie("save");
			}else{
				setCookie("");
			}
			// pfrom.method="CONNECT";
			if ($("#security").checked == true){
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
			if($("input:checkbox[id='idsave']").is(":checked") == true){
				setCookie("save");
			}else{
				setCookie("");
			}
			// pfrom.method="CONNECT";
			if ($("input:checkbox[id='security']").is(":checked") == true){
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
<!--
#cboAuth{width:165px;height:20px;border:1px solid #d7d7d7;}
-->
</style>
<form id="loginForm" name="loginForm" method="post">
		<div class="logForm"  <%= loginDisplayYn.equals("Y") ? "":"style=\"display:none\"" %>>
			<h1 class="logTtle">교육생 로그인</h1>
			<table class="tb_m_login">
						<tr>
							<td colspan="2" class="logPics"> <img src="/2017/images/log_user.png"></td>
						</tr>
						<tr>
							<td colspan="2" class="logNames"> <b><%= tmpUserName %>(<%=(String)session.getAttribute("sess_userid") %>)</b> 님</td>
						</tr>
						<tr>
							<td colspan="2">오신것을 환영합니다.</td>
						</tr>
						<tr>
							<td colspan="2"><%= sbAuthHtml.toString() %></td>
						</tr>
						<tr>
							<td><a href="/mypage/myclass.do?mode=personalinfomodify"><img src="/2017/images/btn_log_privacy.gif"></a></td>
							<td><a href="javascript:fnLoginOut();"><img src="/2017/images/btn_log_out.gif"></a></td>
						</tr>
			</table>
			
		</div>
		
		<div class="logForm" <%= loginDisplayYn.equals("Y") ? "style=\"display:none\"":"" %>>
			<h1 class="logTtle">교육생 로그인</h1>
			<table class="tb_m_login" >
						<tr>
							<td colspan="2" class="logSafe"> <input type="checkbox" id="security" name="security" checked>보안접속 / <input type="checkbox" id="idsave" name="idsave" <%= cookieId.equals("")? "":"checked" %>>아이디저장</td>
							
						</tr>
						<tr>
							<td><input type="text" id="userId" name="userId" value="<%= cookieId %>" required="true!아이디가 없습니다." title="id" onKeyPress="if(event.keyCode == 13){fnLogin();}" placeholder="ID"></td>
							<td rowspan="2"><a href="javascript:;" onClick="javascript:fnLogin();"><img src="/2017/images/lf_log_in.png"></a></td>
						</tr>
						<tr>
							<td><input type="password" id="pwd" name="pwd"  onKeyPress="if(event.keyCode == 13) {fnLogin();}" title="password" required="true!암호가 없습니다." placeholder="PWD"></td>
							<!-- <td></td> -->
						</tr>
						<tr>
							<td><a href="/homepage/renewal.do?mode=member01" ><img src="/2017/images/btn_log_idpwd.gif"></a></td>
							<td><a href="/homepage/join.do?mode=joinstep1" ><img src="/2017/images/btn_log_join.gif"></a></td>
						</tr>
			</table>
		</div>
		<!-- //login -->
		</form>
