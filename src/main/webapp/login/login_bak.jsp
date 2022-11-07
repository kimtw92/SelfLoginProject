<%@ page language="java"  pageEncoding="UTF-8"%>
<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<%
// prgnm : 로그인 페이지 include 용
// date : 2008-05-13
// auth : kang
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%@ page import="loti.mypage.service.PaperService"%>
<%

	// 로그인 여부
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
			sbAuthHtml.append("<select id=\"cboAuth\" name=\"cboAuth\" class=\"select01\" style=\"width=190\" onchange=\"fnSelectAuth();\">");
			if(intAuthCount > 0){
				for(int i=0; i < intAuthCount; i++){
					
					tmpAuth = memberInfo.getSessAuth()[i][0];
					
					sbAuthHtml.append("<option value='" + memberInfo.getSessAuth()[i][0] + "' " + ( tmpAuth.equals(curAuth) ? "selected":""  ) + " >" + memberInfo.getSessAuth()[i][1] + "</option>");
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
		PaperService paperSv = SpringUtils.getBean(PaperService.class);
		DataMap paperCountData = null;		// 현재 쪽지 갯수
		paperCountData = paperSv.paperNewCount(memberInfo.getSessNo());	
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
	var url = "";
	
	url = "/homepage/login.do";
	
	var pars = "mode=passwordNullCheckAjax&id="+$F('userId')+"&pw="+$F('pwd');
	
	var request = new Ajax.Request (
	url,
	{
		method:"POST",
		parameters : pars,
		onSuccess : setPasswordloginProcess,
		onFailure : alertProcess
	}	
	);
}

function setPasswordloginProcess(request) {
	var response = request.responseText;
	
	if(response == 'YES') {
		window.open("login.do?mode=setpasswordstep1","abc", "width=460,height=388, left=200, top=200, menubar=0, toolbar=0, status=0, location=0");
		//alert('오케이 팝업 띄워');
		//return;
	}else {
		if(NChecker(document.pform)){
			if($("idsave").checked == true){
				setCookie("save");
			}else{
				setCookie("");
			}
			// pfrom.method="CONNECT";
			if ($("security").checked == true){
				//pform.action  = "https://<%=request.getServerName()%>/homepage/login.do?mode=loginChk";
				// url = "http://hrd.incheon.go.kr/homepage/login.do";
				// url = "/homepage/login.do";
				// alert(url);
			} else {
				//pform.action = "http://<%=request.getServerName()%>/homepage/login.do?mode=loginChk";
				//url = "/homepage/login.do";
				//alert(url);
			}
			pform.action = "/homepage/login.do?mode=loginChk";
			pform.submit();	
		}		
	}
}

function alertProcess() {
	alert("에러가 발생하였습니다.\n관리자에게 문의 주시기 바랍니다.");
}

//function fnLogin(){
//	if(NChecker(document.pform)){
//		if($("idsave").checked == true){
//			setCookie("save");
//		}else{
//			setCookie("");
//		}
//		pform.action = "/homepage/login.do?mode=loginChk";
//		pform.submit();		
//	}
//}

function fnLoginOut(){
	pform.action = "/homepage/login.do?mode=loginOut";
	pform.submit();	
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
	var value = $F("userId");
	var expires = new Date(); 
	
	if(ptype == "save"){
		expires.setTime(expires.getTime() + 24*60*60*30*1000); 
	}else{
		expires.setTime(expires.getTime() + 1); 
	}
	
	var expiryDate= expires.toGMTString(); 	
	
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + expiryDate + ";"	
}


//
-->
</script>
	
	<div class="loginSet" <%= loginDisplayYn.equals("Y") ? "style=\"display:none\"":"" %> >
		<div class="tit"><img src="/images/<%= skinDir %>/main/txt_stuLogin.gif" alt="교육생 로그인" /></div>
		<div class="loginBtnSet">
			<ul class="loginBtn">
				<li class="left">
					<input type="text" name="userId" id="userId" class="input01 mb" style="width:100px;" onKeyPress="if(event.keyCode == 13){fnLogin();}" required="true!아이디가 없습니다." value="<%= cookieId %>" />
					<input type="password" name="pwd" id="pwd" class="input01" style="width:100px;" onKeyPress="if(event.keyCode == 13) {fnLogin();}" required="true!암호가 없습니다."/ >
				</li>
				<li class="right">
					<a href="javascript:fnLogin();"><img src="/images/<%= skinDir %>/button/btn_login01.gif" alt="로그인" /></a>
				</li>
			</ul>
		</div>
		<div class="check">				
			<input type="checkbox" class="chk" name="idsave" id="idsave" <%= cookieId.equals("")? "":"checked"   %> /><label for="idsave">아이디 저장하기</label>
			<input type="checkbox" class="chk" name="security" id="security" /><label for="security">보안접속</label>
		</div>
		<div class="btn" style="clear:both;">				
			<a href="javascript:open_window('win', '/homepage/join.do?mode=findstep1', 262, 134, 430, 330, 0, 0, 0, 0, 0);"><img src="/images/<%= skinDir %>/button/btn_idpw01.gif" alt="아이디/비밀번호 찾기" /></a>
			<a href="/homepage/join.do?mode=joinstep1"><img src="/images/<%= skinDir %>/button/btn_join01.gif" alt="회원가입" /></a>
		</div>
	</div>
		
	<!-- logout -->
	<div class="logoutSet" <%= loginDisplayYn.equals("Y") ? "":"style=\"display:none\"" %> >
		<p class="gstNameSet">				
			<span class="gstName">
				<img src="/images/skin1/icon/icon_arrow01.gif" class="vp2" alt="" />
				<strong><%= tmpUserName %></strong> (<%=(String)session.getAttribute("sess_userid") %>)
			</span>
			<span class="lgoutBtn"><a href="javascript:fnLoginOut();"><img src="/images/skin1/button/btn_logout01.gif" class="vm2" alt="로그아웃" /></a></span>
		</p>
		<div class="spaceN"></div>
		<p class="memoSet">
			<a href="javascript:fnGoMenu('8','recieve');"><img src="/images/skin1/icon/icon_memo01.gif" alt="쪽지" /></a> 
			<a href="javascript:fnGoMenu('8','recieve');" class="mTxt">쪽지: <strong><%= newPaperCount %></strong></a>
		</p>
		<p class="btnSet" style="clear:both;">
			<a href="/mypage/myclass.do?mode=main"><img src="/images/skin1/button/btn_mypage01.gif" alt="마이페이지" /></a>
			<a href="/mypage/myclass.do?mode=personalinfomodify"><img src="/images/skin1/button/btn_myinfo01.gif" alt="개인정보변경" /></a>
			<!-- <a href="javascript:alert('개인정보변경은\n마이페이지 > 개인정보 > 개인정보변경\n을 이용해주십시오.');"><img src="/images/skin1/button/btn_myinfo01.gif" alt="개인정보변경" /></a> -->
		</p>
		<%= sbAuthHtml.toString() %>		
	</div>
	<!-- //logout -->



