<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
 
<%

	String serverName = request.getServerName();
	int port = request.getServerPort();

  String domains = request.getRequestURL().toString();
  if(domains.indexOf("https") != -1) {
%>
로딩중입니다. 잠시만 기다려주세요...
<script language="javascript">
    var domains = "<%=domains%>";
    if(domains.indexOf("https") != -1) {
        location.href = 'http://hrd.incheon.go.kr/mypage/myclass.do?mode=personalinfomodify';
    }
 </script>
 
<%
  } else {
 %>
 
<%

	DataMap requestMap = (DataMap)request.getAttribute("DEPT_LIST");
	requestMap.setNullToInitialize(true);

	DataMap infoMap = (DataMap)request.getAttribute("USER_INFO");
	infoMap.setNullToInitialize(true);	
	
	StringBuffer deptListHtml = new StringBuffer();
	
	DataMap infopicMap = (DataMap)request.getAttribute("USER_INFO_PIC");
	infopicMap.setNullToInitialize(true);	
	
	if(requestMap.keySize("dept") > 0){
		for(int i=0; i < requestMap.keySize("dept"); i++){
			String selectString = ""; 
			if(infoMap.getString("dept",0).equals(requestMap.getString("dept",i))){
				selectString = "selected=\"selected\"" ;
			}			
			deptListHtml.append("<option value = \""+requestMap.getString("dept",i)+requestMap.getString("deptnm",i)+ "\"" + selectString +">"+requestMap.getString("deptnm",i)+"</option>");		
		}
	}
	
	StringBuffer picHtml = new StringBuffer();
	
	if(infopicMap.keySize("fileName") > 0) {
		picHtml.append("<dt><img id=\"mypicture\" width=\"95\" height=\"100\" src="+"/"+infopicMap.getString("filePath",0).replaceAll("/data1/loti_data/pic/","pic")+"/"+infopicMap.getString("fileName",0)+" alt=\"사진\" /></dt> ");
		
	}else {
		picHtml.append("<dt><!-- img id=\"mypicture\" width=\"95\" height=\"100\" src=\"/images/skin1/sub/img_photo.gif\" alt=\"사진\" / --></dt> ");
	}

	String birthdate = null;
	if(infoMap.getString("birthdate",0).toString().equals("")){
		birthdate = "00000000";
	}else{
		birthdate = infoMap.getString("birthdate",0);
	}

	String sex = null;
	if(infoMap.getString("sex",0).toString().equals("")){
		sex = "A";
	}else{
		sex = infoMap.getString("sex",0);
	}
	
%>
	<!-- 달력 관련 시작-->
	<Div id='popCal' style='POSITION:absolute;visibility:hidden;border:2px ridge;width:10'>
		<iframe name="popFrame" src="/homepage/popcalendar.htm" frameborder="0" marginwidth=0 marginheight=0 scrolling="no" width=183 height=188></iframe>
	</DIV>
	
	<SCRIPT event=onclick() for=document> popCal.style.visibility = "hidden";</SCRIPT>
	<!-- 달력 관련 끝-->

	<script language="javascript">
		window.onload = init;
		function init() {
             var p_dept = "<%=infoMap.getString("dept",0)%>";
			    var p_deptname = "<%=infoMap.getString("deptsub",0)%>";
				getMemSelDept(p_dept, p_deptname);
		}
		
		function getMemSelDept(form1, form2) {
			var url = "/mypage/myclass.do";
			pars = "deptname="+form2+"&dept=" + form1.substring(0,7) + "&mode=searchPart_";
			var divID = "part";
				
			var myAjax = new Ajax.Updater(
				{success: divID },
				url, 
				{
					method: "post", 
					parameters: pars,
					onLoading : function(){
						$(document.body).startWaiting('bigWaiting');
					},
					onSuccess : function(){
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						// $("month").value = month;
						// $("currPage").value = 1;
					},
					onFailure : function(){					
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						alert("데이타를 가져오지 못했습니다.");
					}				
				}
			);
		}
		
		function getPart(objValue, objText) {
			if(objValue == ""){
				document.pform.deptname.value = "";
				document.pform.deptname.focus();
			}else{
				document.pform.deptname.value = objText;
			}
		}
		
		function modifyProcess(){
		/*
			var form1 = document.pform;
			for(var i =0 ; i < form1.elements.length ; i++){
				if(form1.elements[i].value=="" && form1.elements[i].title != ""){
					alert(form1.elements[i].title+" 부분을 입력하여 주십시오" );
					form1.elements[i].focus();
					return;
				}
				if(form1.elements[i].name=="PWD_CHK" && form1.elements[i].value!=form1.elements[i-1].value){
					alert("패스워드가 일치하지 않습니다.\n확인하여 주십시오" );
					form1.elements[i].focus();
					return;
				}
			}
			eval("var Str = document.pform.PWD.value") ;
			for(i=0; i<Str.length; i++){
				Chr = Str.charAt(i) ;
				if(Str != "") {
					if(Str.length < 9 || Str.length > 12) {
						alert("비밀번호는 9자 이상, 12자 이하 이어야 합니다.") ;
						eval("document.pform.PWD.value = ''") ;
						eval("document.pform.PWD_CHK.value = ''") ;
						eval("document.pform.PWD.focus()") ;       
						return;     
					}
				}   
			}
		*/
			var form1 = document.pform;
			var Str = document.pform.PWD.value
			for(i=0; i<Str.length; i++){
				Chr = Str.charAt(i); 
				if(Str.length < 9 || Str.length > 12) {
					alert("비밀번호는 9자 에서, 12자 이하 이어야 합니다.") ;
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
			if(document.pform.PWD.value.indexOf(document.pform.USER_ID.value) != -1) {
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
			
// 			if(form1.newHomePost.value == ""){
// 				alert("주소를 입력해 주세요.");
// 				return;
// 			}
			
			if(form1.officename.value == ""){
				alert("소속기관을 선택하세요.");
				return;
			}

			if(form1.deptname.value == "") {
				alert("부서명을 입력해주세요.");
				return;
			}
			if(document.all.officename.value.indexOf("6289999") != -1) {
				if(form1.PART_DATA.value == "") {
					alert("공사공단은 집적입력이 되지 않습니다. 부서명을 선택해주세요.");
					return;
				}
			}
			
			alert("회원정보가 수정되었습니다.");
			//관리자
 			document.pform.action = "/mypage/myclass.do?mode=updateuser";			
			
			document.pform.submit();        
		}
		
		function mailServ(servName) {
			if(servName !='direct') {
				document.getElementById('mailserv').style.display='none';
				document.getElementById('mailserv').value=servName;
			}
			else{
				document.getElementById('mailserv').value='';
				document.getElementById('mailserv').style.display='';
				document.getElementById('mailserv').focus();
			}
		}
		
		//우편번호 검색
		function searchZip(post1, post2, addr){
			var url = "/homepage/join.do";
			url += "?mode=zipcode";
			url += "&zipCodeName1=pform." + post1;
			url += "&zipCodeName2=pform." + post2;
			url += "&zipAddr=pform." + addr;
			pwinpop = popWin(url,"cPop","420","350","yes","yes");
		}
		
		function findJik() {
			var url = "/homepage/join.do";
			url += "?mode=findjik";
			pwinpop = popWin(url,"jPop","420","350","yes","yes");	
		}
		
		function emailcheck() {
			eval("var Str1 = document.pform.emailid.value") ;
		    if(Str1 == "" ) {
				alert("이메일을 입력해 주십시오") ;
				return; 
		    }
		    
			email = $F('emailid')+'@'+$F('mailserv');
			var url = "join.do";
			pars = "mode=emailcheckajax&email="+email;
			var myAjax = new Ajax.Request(
				url, 
				{
					method: "get", 
					parameters: pars,
					onComplete: testFunction2
				}				
			);
		}
		
		function testFunction2(request){
			var num = request.responseText;
			if(num == 1) {
				alert("이메일 중복입니다.");
			}else {
				alert("사용가능한 이메일 입니다.");
			}	
		}
	</script>
<script language="javascript">

function goPopup(){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open("/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}


function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.pform.newAddr1.value = roadAddrPart1;
		document.pform.newAddr2.value = roadAddrPart2 +" "+ addrDetail;
		document.pform.newHomePost.value = zipNo;
}

</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left1.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual1">마이페이지</div>
            <div class="local">
              <h2>개인정보</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; 개인정보 &gt; <span>개인정보변경</span></div>
            </div>
            <div class="contnets">
            <!-- content s ===================== -->
			<form id="pform" name="pform" method="post">
					<%
						StringBuffer s = new StringBuffer();
						s.append("");
					%>
					
						<input type="hidden" name="fileno" value="notinit"/>
						
						<div id="hiddenidform">
							<%= s%>
						</div>
							<div id="content">
								<!-- title --> 
								<div class="ht3">기본입력사항</div>
								<div class="txtR32">
									(<span class="txt_org">*</span> 필수입력사항)
								</div>
								<!-- //title -->
								<div class="h9"></div>
					
								<!-- data -->
								<table class="dataW01">	
									<tr>
										<th class="bl0" width="160">
											이름 <span class="txt_org">*</span>
										</th>
										<td width="378">
											<%=infoMap.getString("name",0)%>
										</td>
										<!-- td width="100" rowspan="5">
											<dl class="photo">
												<%//=picHtml %>
												<dd>
													<a href=javascript:popWin("../homepage/join.do?mode=addpictures","cPop","420","600","yes","yes")>
														<img src="/images/skin1/button/btn_photoRegi01.gif" class="vm2" alt="사진등록" />
													</a>
												</dd>
											</dl>				
										</td -->
									</tr>
									<!-- <tr>
										<th class="bl0" width="160">
											주민등록번호 <span class="txt_org">*</span>
										</th>
										<td>
										<%	
											//if(infoMap.getString("resno",0).length() > 6){
											//	out.println(infoMap.getString("resno",0).substring(0,6)+"*******");
											//}
										%>
										</td>
									</tr>  -->
									 
									<!-- 2011.01.11 - woni82 -->
									<tr>
										<th class="bl0" width="160">
											생년월일 <span class="txt_org">*</span>
										</th>
										<td>
											<%
												if(birthdate.equals("00000000")){
											%>
												데이터 작업중입니다.
											<%
												}else{
											%>
												<%=birthdate.substring(0,4)%>년
												<%=birthdate.substring(4,6)%>월
												<%=birthdate.substring(6,8)%>일
											<%		
												}
											%>
											
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											성별<span class="txt_org">*</span>
										</th>
										<td>
										<%
											if(sex.equals("M")){
										%>
											남성
										<%
											} else if(sex.equals("F")){
										%>
											여성
										<%
											} else{
										%>
											데이터 작업중입니다.
										<%
										}
										%>
										</td>
									</tr>
	
									<tr>
										<th class="bl0" width="160">
											아이디 <span class="txt_org">*</span>
										</th>
										<td>
											<%=infoMap.getString("userId",0)%>
											<input type="hidden" id="USER_ID" name="USER_ID" value="<%=infoMap.getString("userId",0)%>" />
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											비밀번호 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="password" title="비밀번호" name="PWD" class="input02 w100" />
											<span class="txt11 ltspm1 vp2">(영문, 숫자 포함 9자 이상 12자 미만) '특수문자포함'</span>
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											비밀번호 확인 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="password" title="비밀번호확인" name="PWD_CHK" class="input02 w100" />
											<span class="txt11 ltspm1 vp2">(비밀번호를 다시 입력해 주세요)</span>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											비밀번호 재발급질문 <span class="txt_org">*</span>
										</th>
										<td colspan="2">
											<select title="비밀번호 재발급질문" name="PWD_QUS" class="select02 w200">
												<option value="" <%if(infoMap.getString("pwdQus",0).equals("")) {%> selected="selected"<%}%>>----- 질문을 선택하세요 -----</option>
												<option value = "본인의 초등학교는?" <%if(infoMap.getString("pwdQus",0).equals("본인의 초등학교는?")) {%> selected="selected"<%}%>>본인의 초등학교는?
												<option value = "본인의 핸드폰 번호는?" <%if(infoMap.getString("pwdQus",0).equals("본인의 핸드폰 번호는?")) {%> selected="selected"<%}%>>본인의 핸드폰 번호는?
												<option value = "어머니의 성함은?" <%if(infoMap.getString("pwdQus",0).equals("어머니의 성함은?")) {%> selected="selected"<%}%>>어머니의 성함은?
												<option value = "어릴적 별명은?" <%if(infoMap.getString("pwdQus",0).equals("어릴적 별명은?")) {%> selected="selected"<%}%>>어릴적 별명은?
												<option value = "본인이 태어난 곳은?" <%if(infoMap.getString("pwdQus",0).equals("본인이 태어난 곳은?")) {%> selected="selected"<%}%>>본인이 태어난 곳은?
												<option value = "가고 싶은 장소는?" <%if(infoMap.getString("pwdQus",0).equals("가고 싶은 장소는?")) {%> selected="selected"<%}%>>가고 싶은 장소는?
												<option value = "즐겨 부르는 노래는?" <%if(infoMap.getString("pwdQus",0).equals("즐겨 부르는 노래는?")) {%> selected="selected"<%}%>>즐겨 부르는 노래는?
												<option value = "감명 깊게 본 영화는?" <%if(infoMap.getString("pwdQus",0).equals("감명 깊게 본 영화는?")) {%> selected="selected"<%}%>>감명 깊게 본 영화는?
												<option value = "좋아하는 색깔은?" <%if(infoMap.getString("pwdQus",0).equals("좋아하는 색깔은?")) {%> selected="selected"<%}%>>좋아하는 색깔은?
												<option value = "가장 좋아하는 연예인은?" <%if(infoMap.getString("pwdQus",0).equals("가장 좋아하는 연예인은?")) {%> selected="selected"<%}%>>가장 좋아하는 연예인은?
												<option value = "부모님이 좋아하는 음식은?" <%if(infoMap.getString("pwdQus",0).equals("부모님이 좋아하는 음식은?")) {%> selected="selected"<%}%>>부모님이 좋아하는 음식은?
												<option value = "가장 기억에 남는 선생님은?" <%if(infoMap.getString("pwdQus",0).equals("가장 기억에 남는 선생님은?")) {%> selected="selected"<%}%>>가장 기억에 남는 선생님은?
												<option value = "좋아하는 애완동물은?" <%if(infoMap.getString("pwdQus",0).equals("좋아하는 애완동물은?")) {%> selected="selected"<%}%>>좋아하는 애완동물은?						
											</select>
											<span class="txt11">비밀번호 분실시 사용</span>
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											비밀번호 재발급 답 <span class="txt_org">*</span>
										</th>
										<td colspan="2">
											<input type="text" title="비밀번호 재발급 답" name="PWD_ANS" class="input02 w193" value='<%=infoMap.getString("pwdAns",0)%>' />
											<span class="txt11 vp2">비밀번호와 무관하게 입력</span>
										</td>
									</tr>
								</table>	
								<!-- //data --> 
								<div class="space"></div>
	
								<!-- title --> 
								<div class="ht3">연락처 입력</div>
								<div class="txtR32">
									(<span class="txt_org">*</span> 필수입력사항)
								</div>
								<!-- //title -->
								<div class="h9"></div>
								<%
									String id = "";
									String account = "";
									
									try {
										if(!infoMap.getString("email",0).equals("")) {
											java.util.StringTokenizer sToken1 = new java.util.StringTokenizer(infoMap.getString("email",0), "@");
											id = sToken1.nextToken();	
											account = sToken1.nextToken();	
										}
									}catch(Exception e){
										
									}				
								%>
	
								<!-- view -->
								<table class="dataW01">		
									<tr>
										<th class="bl0" width="160">
											이메일 <span class="txt_org">*</span>
										</th>
										<td width="458">
											<input type="text" title="이메일 아이디" name="emailid" value="<%=id%>" class="input02 w80" /> @ 
											<input type="text" title="이메일 계정" value="<%=account%>" name="mailserv" class="input02 w80" >
											<select name="mailserv"  title="이메일 계정" onChange="mailServ(this.value)" class="select02">
												<option value="korea.kr">korea.kr</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="naver.com">naver.com</option>
												<option value="paran.com">paran.com</option>
												<option value="empas.com">empas.com</option>
												<option value="dreamwiz.com">dreamwiz.com</option>
												<option value="yahoo.co.kr">yahoo.co.kr</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="nate.com">nate.com </option>
												<option value="chollian.net">chollian.net</option>
												<option value="empal.com">empal.com</option>														
												<option value="lycos.co.kr">lycos.co.kr</option>
												<option value="hanafos.com">hanafos.com</option>
												<option value="hanmir.com">hanmir.com</option>
												<option value="direct" selected="selected">직접입력</option>
											</select>
											<a href="javascript:emailcheck();">
												<img src="/images/skin1/button/btn_submit01.gif" class="vm2" alt="중복확인" /> 
											</a>	
											<a href="http://mail.korea.kr" target="_blank">
												<img src="/images/skin1/button/btn_email.gif" class="vm2" alt="이메일 신청" />
											</a>
										</td>
									</tr>
									<%
										String home1="";
										String home2="";
										String home3="";
										try {
											if(!infoMap.getString("homeTel",0).equals("")) {
												java.util.StringTokenizer sToken2 = new java.util.StringTokenizer(infoMap.getString("homeTel",0), "-");
												home1 = sToken2.nextToken();	
												home2 = sToken2.nextToken();	
												home3 = sToken2.nextToken();	
											}
										}catch(Exception e){
											
										}
									%>
									<tr>
										<th class="bl0">
											집전화
										</th>
										<td>
											<input type="text" value="<%=home1%>" name="HOME_TEL1" class="input02 w40" /> - <input type="text" value="<%=home2%>" name="HOME_TEL2" class="input02 w40" /> - <input type="text" value="<%=home3%>" name="HOME_TEL3" class="input02 w40" />
											<span class="txt11 vp2">(예 : 02-1234-5678)</span>
										</td>
									</tr>
									<%
										String office1="";
										String office2="";
										String office3="";
										try{			
											if(!infoMap.getString("officeTel",0).equals("--")) {			
												java.util.StringTokenizer sToken3 = new java.util.StringTokenizer(infoMap.getString("officeTel",0), "-");
												office1 = sToken3.nextToken();	
												office2 = sToken3.nextToken();	
												office3 = sToken3.nextToken();
											}
										}catch(Exception e){
											
										}				
									%>
									<tr>
										<th class="bl0">
											직장전화
										</th>
										<td>
											<input type="text" value="<%=office1%>" name="OFFICE_TEL1" class="input02 w40" /> - 
											<input type="text" value="<%=office2%>" name="OFFICE_TEL2" class="input02 w40" /> - 
											<input type="text" value="<%=office3%>" name="OFFICE_TEL3" class="input02 w40" />
											<span class="txt11 vp2">(예 : 02-1234-5678)</span>
										</td>
									</tr>
									<%
										String hp1="";
										String hp2="";
										String hp3="";
										
										try{
											if(!infoMap.getString("hp",0).equals("--")) {				
												java.util.StringTokenizer sToken4 = new java.util.StringTokenizer(infoMap.getString("hp",0), "-");
												hp1 = sToken4.nextToken();	
												hp2 = sToken4.nextToken();	
												hp3 = sToken4.nextToken();	
											}						
										}catch(Exception e){
											
										}
									%>
									<tr>
										<th class="bl0">
											휴대전화
										</th>
										<td>
											<input type="text" value="<%=hp1%>" name="HP1" class="input02 w40" /> - 
											<input type="text" value="<%=hp2%>" name="HP2" class="input02 w40" /> - 
											<input type="text" value="<%=hp3%>" name="HP3" class="input02 w40" />
											<span class="txt11 vp2">(예 : 010-1234-5678)</span>
										</td>
									</tr>
									<!-- tr>
										<th class="bl0">
											우편번호 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="우편번호" value="<%=infoMap.getString("homePost1",0) %>" name="homePost1" class="input02 w40" readonly/> - 
											<input type="text" title="우편번호" value="<%=infoMap.getString("homePost2",0) %>" name="homePost2" class="input02 w40" readonly/> 
											<a href="javascript:searchZip('homePost1','homePost2','homeAddr');"><img src="/images/skin1/button/btn_search02.gif" class="vm2" alt="검색"/></a>
										</td>
									</tr>

									<tr>
										<th class="bl0">
											주 소 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="주소" value="<%=infoMap.getString("homeAddr",0) %>" name="homeAddr" class="input02 w382" />
										</td>
									</tr> -->
									<tr>
										<th class="bl0">
											우편번호 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="새주소 우편번호" value="<%=infoMap.getString("newhomepost",0) %>" id="newHomePost" name="newHomePost" class="input02 w40" readonly/>
											<a href="javascript:goPopup();"><img src="/images/skin1/button/btn_search02.gif" class="vm2" alt="검색"/></a>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											주 소 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="새주소1" value="<%=infoMap.getString("newaddr1",0) %>" id="newAddr1" name="newAddr1" class="input02 w382" />
											<input type="text" title="새주소2" value="<%=infoMap.getString("newaddr2",0) %>" id="newAddr2" name="newAddr2" class="input02 w382" />
										</td>
									</tr>																		
								</table>	
								<!-- //view --> 
								<div class="space"></div>
	
								<!-- title --> 
								<div class="ht3">소속기관 정보</div>
								<div class="txtR32">
									(<span class="txt_org">*</span> 필수입력사항)
								</div>
								<!-- //title -->
								<div class="h9"></div>
	
								<!-- view -->
								<table class="dataW01">		
									<tr>
										<th class="bl0" width="160">
											소속기관명 <span class="txt_org">*</span>
										</th>
										<td width="458">
											<select title="소속기관명" name="officename" class="select02 w200" onChange="getMemSelDept(this.options[this.selectedIndex].value, document.pform.deptname.value)">
												<option  value="" selected="selected">----- 소속기관을 선택하세요 -----</option>
												<%=deptListHtml %>
											</select>
											<span class="txt11">(본청,직속기관,사업소는 인천광역시 선택)</span>			
										</td>
									</tr>
									<tr id="part">
										<th class="bl0">
											부서명 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="부서명" value="<%=infoMap.getString("deptsub",0)%>" id="deptname" name="deptname" class="input02 w193"/>
											<select name="PART_DATA" class="select01 w120" onChange="getPart(this.options[this.selectedIndex].value,this.options[this.selectedIndex].text)">
												<option value = "" selected>--- 부서 선택 ---</option>
												<option value = "" >직접입력</option>
											</select>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											직위
										</th>
										<td>
											<input type="text" value="<%=infoMap.getString("jikwi",0)%>" name="degree" class="input02 w193" />
										</td>
									</tr>
									<tr>
										<th class="bl0">직급 <span class="txt_org">*</span></th>
										<td>
										<input type="text" title="직급" value="<%=infoMap.getString("jiknm",0)%>" id="degreename" name="degreename" class="input02 w193" readonly/> 
										<input type="hidden" id="hiddenjik" name="hiddenjik" value="<%=infoMap.getString("jik",0)%>"/>
										<a href="javascript:findJik();">
											<img src="/images/skin1/button/btn_search02.gif" class="vm2" alt="검색" />
										</a>
										<span class="txt11">직급명(예:행정주사)입력 후 검색 </span>
										</td>
									</tr>
								</table>	
								<!-- //view --> 
								<div class="space"></div>
	
								<!-- title --> 
								<div class="ht3">기타</div>
								<div class="txtR32">
									(<span class="txt_org">*</span> 필수입력사항)
								</div>
								<!-- //title -->
								<div class="h9"></div>
	
								<!-- view -->
								<table class="dataW01">		
									<!-- tr>
										<th class="bl0" width="160">
											학력
										</th>
										<td width="458">
											<select  name="school"  class="select02">
												<option value="">----- 학력을 선택하세요 -----</option>
												<option value="01" <%if(infoMap.getString("school",0).equals("01")) {%> selected="selected"<%}%>>박사
												<option value="02" <%if(infoMap.getString("school",0).equals("02")) {%> selected="selected"<%}%>>석사
												<option value="03" <%if(infoMap.getString("school",0).equals("03")) {%> selected="selected"<%}%>>대졸
												<option value="04" <%if(infoMap.getString("school",0).equals("04")) {%> selected="selected"<%}%>>대재.퇴,초대졸
												<option value="05" <%if(infoMap.getString("school",0).equals("05")) {%> selected="selected"<%}%>>고졸
												<option value="06" <%if(infoMap.getString("school",0).equals("06")) {%> selected="selected"<%}%>>중졸이하
												<option value="07" <%if(infoMap.getString("school",0).equals("07")) {%> selected="selected"<%}%>>기타
											</select>
										</td>
									</tr -->
									<tr>
										<th class="bl0" width="160">최초임용일 
											<span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="최초임용일" value="<%=infoMap.getString("fidate",0)%>" name="FIDATE" class="input02 w100" /> 
											<a href = "javascript:void(0)" onclick="popFrame.fPopCalendar(FIDATE,FIDATE,popCal);return false">
												<img src="/images/skin1/icon/icon_cal01.gif" class="vp2" alt="달력" /> 
											</a>
											<span class="txt11 vp2">(예 :19910509)</span>
										</td>
									</tr>
									<tr>
										<th class="bl0" width="160">
											현직급임용일 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" title="현직급임용일" value="<%=infoMap.getString("upsdate",0)%>" name="UPSDATE" class="input02 w100" /> 
											<a href = "javascript:void(0)" onclick="popFrame.fPopCalendar(UPSDATE,UPSDATE,popCal);return false">
												<img src="/images/skin1/icon/icon_cal01.gif" class="vp2" alt="달력" /> 
											</a>
											<span class="txt11 vp2">(예 :19910509)</span>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											메일수신여부(교육안내문)
										</th>
										<td>
											<ul class="radioSet">
												<li>
													<input type="radio" value="Y" name="mailYN" class="radio01" <%if(infoMap.getString("mailyn",0).equals("Y")) {%> checked<%}%>/>
													<label for="" class="label01">Yes</label>
												</li>
												<li>
													<input type="radio" value="N" name="mailYN" class="radio01" <%if(infoMap.getString("mailyn",0).equals("N")) {%> checked<%}%>/>
													<label for="" class="label01">No</label>
												</li>
											</ul>
										</td>
									</tr>
									<tr>
										<th class="bl0">
											SMS수신여부
										</th>
										<td>
											<ul class="radioSet">
												<li>
													<input type="radio" value="Y" name="smsYN" class="radio01" <%if(infoMap.getString("smsYn",0).equals("Y")) {%> checked<%}%>/>
													<label for="" class="label01">Yes</label>
												</li>
												<li>
													<input type="radio" value="N" name="smsYN" class="radio01" <%if(infoMap.getString("smsYn",0).equals("N")) {%> checked<%}%>/>
													<label for="" class="label01">No</label>
												</li>
											</ul>
										</td>
									</tr>
								</table>	
								<!-- //view --> 
								<div class="space"></div>
	
								<!-- button -->
								<div class="btnCbtt">			
									<a href="javascript:modifyProcess('joinmember');">
										<img src="/images/skin1/button/btn_submit02.gif" alt="확인" />
									</a>
									<img src="/images/skin1/button/btn_cancel01.gif" alt="취소" />
								</div>
								<!-- //button -->		
								</div>
					</form>
    			    <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100040" /></jsp:include>
                    <div class="h80"></div>   
							<!-- //content e ===================== -->
          </div>
        </div>
    
   </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>
<%
  
  }
%>