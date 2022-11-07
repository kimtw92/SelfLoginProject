<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 계정관리 수정 폼
// date : 2008-05-28
// auth : 정윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	//기관명, 기관코드 리스트.
	DataMap deptSelectBoxMap = (DataMap)request.getAttribute("DEPTLIST_DATA");
	deptSelectBoxMap.setNullToInitialize(true);

	//멤버 정보
	DataMap memberRowMap = (DataMap)request.getAttribute("ROW_DATA");
	memberRowMap.setNullToInitialize(true);
	
	// [s]기관정보 셀렉트박스 변수
	String deptSelectBox = "";
	if(deptSelectBoxMap.keySize("dept") > 0 ){
		//셀렉트박스 데이터가 있을경우
		for(int i=0;deptSelectBoxMap.keySize("dept") > i; i++){
			
			deptSelectBox += "<option value=\""+deptSelectBoxMap.getString("dept",i)+"\">"+deptSelectBoxMap.getString("deptnm",i)+"";
		}
	}else{
		deptSelectBox = "<option value=\"\">등록된 기관이 없습니다.</option>";
	}
	//[e]기관정보 셀렉트박스 변수
	
%>


<!-- 달력 관련 시작-->
<Div id='popCal' style='POSITION:absolute;visibility:hidden;border:2px ridge;width:10'>
<iframe name="popFrame" src="/homepage/popcalendar.htm" frameborder="0" marginwidth=0 marginheight=0 scrolling="no" width=183 height=188></iframe>
</DIV>

<SCRIPT event=onclick() for=document> popCal.style.visibility = "hidden";</SCRIPT>
<!-- 달력 관련 끝-->


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

//멤버 리스트로 이동
function go_list(){
	
	location.href = "/member/member.do?mode=list&menuId=<%=requestMap.getString("menuId")%>&currPage=<%=requestMap.getString("currPage")%>&dept=<%=requestMap.getString("dept")%>&name=<%=requestMap.getString("name")%>&resno=<%=requestMap.getString("resno")%>&auth=<%=requestMap.getString("auth")%>";
}

//직급검색
function jiknmSearch(){
	$("mode").value = "";
	pform.action = "/search/searchDept.do";
	var popWindow = popWin('about:blank', 'majorPop11', '500', '400', 'YES', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";

}


//처음 온로드시 사용되는 ajax
function go_partCode(dept, deptnm, partcd, partnm){
	var url = "/member/member.do";
	var pars = "mode=ajaxPartCode&dept="+dept+"&partcd="+partcd+"&partnm="+partnm;
	var divId = "partCodeDIV";

	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			onFailure: function(){
				alert("생성시 오류가 발생했습니다.");
			}
		}
	);
	//alert(deptnm);
	$("deptnm").value = deptnm;
}



//로딩시.
onload = function()	{

	//부서코드 
	var dept = "<%=memberRowMap.getString("dept")%>";
	
	go_partCode($F("dept"), '<%=memberRowMap.getString("deptnm")%>', '<%=memberRowMap.getString("partcd")%>', '<%=memberRowMap.getString("deptsub")%>');
	$("dept").value = dept;

}

function getPart(objValue, objText) {

    if(objValue == ""){
		$("partnm").value = "";
		$("partnm").focus();
	}else{
		$("partcd").value = objValue;
		$("partnm").value = objText;
	}

}

//저장
function go_save(){
	//이름체크
	if($("name").value == ""){
		alert("이름을 입력하십시오.");
		return false;
	}else{
		if(checkKoreanOnly($("name").value)== false){
			alert("한글만 입력 하십시오.");
			$("name").value="";
			return false;
		}
	}
	
	//비밀번호가 있을경우 체크
	if($("pwd").value != ""){
		if($("pwd").value.length < 4 ){
			alert("비밀번호는 4자 이상으로 입력하십시요");
			$("pwd").value = "";
			$("pwd").focus();
			return false;
		}
	}
	 
	var hp1 = $("hp1").value;		
	//핸드폰 숫자 체크[s]
	if(isNum(hp1, '핸드폰 번호를') == false){
		$("hp1").value = "";
		return false;
	}
	
	var hp2 = $("hp2").value;		
	if(isNum(hp2, '핸드폰 번호를') == false){
		$("hp2").value = "";
		return false;
	}
	var hp3 = $("hp3").value;		
	if(isNum(hp3, '핸드폰 번호를') == false){
		$("hp3").value = "";
		return false;
	}
	
	//이메일체크
	if(checkEmail($("email").value) == false){
		$("email").value="";
		$("email").focus();
		return false;
	}
	
	if($("email").value == ""){
		alert("이메일을 입력 하여 주십시오.");
		return false;
	}
	
	if($("email").value == ""){
		alert("이메일을 입력 하여 주십시오.");
		return false;
	}
	if(document.all.partnm.value == "") {
		alert("부서명을 입력해주세요.");
		return;
	}
	if(document.all.dept.value == "6289999") {
		if(document.all.partcd.value == "") {
			alert("공사공단은 집적입력이 되지 않습니다. 부서명을 선택해주세요.");
			return;
		}
	}
 	if(confirm("저장 하시겠습니까?")){
		pform.action = "/member/member.do";
		$("mode").value="exec";
		$("qu").value="update";
		pform.submit();
	}
}

function goEmail() {

	var email = $F('email');
	var userno = $F('userno');

	var format = /^[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+)*@[0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*$/;
    if (email.search(format) != -1) {

	}else{
		alert("올바른 이메일 형식이 아닙니다.");
	    return;
	}
	
	var url="/homepage/join.do";
	var pars = "mode=sendemail&email="+email+"&userno="+userno;
	var request = new Ajax.Request (
		url,
		{
			method:"post",
			parameters : pars,
			onSuccess : sendEmailSuccess,
			onFailure : sendEmailFailure
		}	
	);
}
function sendEmailSuccess(request) {
	var response = request.responseText;
	var email = $F('email');
	
	if(response.indexOf('Y') != -1) {
		alert("["+email+"] <- 메일을 성공적으로 발송하였습니다.");
	}else {
		alert("메일 발송이 실패하였습니다.");

	}
}

function sendEmailFailure() {
	alert("메일을 발송이 실패하였습니다.");
}

function goSms(userid) {
	var url = "/courseMgr/mail.do?mode=sms_pop2&qu=updatePasswd&userid=" + userid;
	popWin(url, "pop_sendSms", "800", "600", "1", "");
}
</script>
	<script type="text/javascript">
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
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode">

<!-- 자바단에서의 조건값 -->
<input type="hidden" name="qu" value="">

<!-- 검색후 직급 코드 받아주는  히든 박스 -->
<input type="hidden" name="jik" value="<%=memberRowMap.getString("jik") %>">

<input type="hidden" name="searchDept" value="<%=memberRowMap.getString("dept") %>">
<input type="hidden" name="searchName" value="<%=memberRowMap.getString("name") %>">
<input type="hidden" name="searchResno" value="<%=memberRowMap.getString("resno") %>">
<input type="hidden" name="searchAuth" value="<%=memberRowMap.getString("auth") %>">

<!-- 유저 넘버 -->
<input type="hidden" id= "userno" name="userno" value="<%=requestMap.getString("userNo") %>">

<!-- 우편번호 검색 후 우편번호를 받아주기위해서 정의 -->
<input type="hidden" name="zipCodeName1" value="pform.homePost1">
<input type="hidden" name="zipCodeName2" value="pform.homePost2">

<!-- 우편번호 검색 후 주소값을 받아주기위해서 사용-->
<input type="hidden" name="zipAddr" value="pform.homeAddr">

<!-- 직급검색전 리턴시켜주어야할 위치를 지정 해주는 히든 값 t1 :  직급코드 t2 : 직급명 -->
<input type="hidden" name="t1" value="pform.jik">
<input type="hidden" name="t2" value="pform.jiknm">

<!-- 기관명 -->
<input type="hidden" name="deptnm" value="<%=memberRowMap.getString("deptnm")%>">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>            	
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>            
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>계정관리</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr><td height="10"></td></tr>
			</table>
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
										
                        <!---[s] content -->
						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
							<table width="600px" cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
								<tr bgcolor="#375694">
									<td height="2" colspan="100%"></td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" width="90" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>마지막 접속일</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<%=memberRowMap.getString("lglast").equals("") ? "&nbsp" : memberRowMap.getString("lglast") %>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" width="90" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>가입일</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<%=memberRowMap.getString("indate").equals("") ? "&nbsp" : memberRowMap.getString("indate") %>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" width="90" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>탈퇴일</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<%=memberRowMap.getString("deleteDate").equals("") ? "&nbsp" : memberRowMap.getString("deleteDate") %>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" width="90" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>생년월일*</strong></td>
									<td class="tableline21" style="padding:0 0 0 10"><%=memberRowMap.getString("birthdate").equals("") ? "&nbsp" : memberRowMap.getString("birthdate") %></td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>아이디</strong></td>
									<td class="tableline21" style="padding:0 0 0 10"><input type="text" readonly="readonly" class="textfield" name="userId" maxlength="10" value="<%=memberRowMap.getString("userId").equals("") ? "&nbsp" : memberRowMap.getString("userId") %>"><input type="hidden" name="checkUserId" maxlength="10" value="<%=memberRowMap.getString("userId")%>"></td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>이름(한글)*</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<input type="text" class="textfield" name="name" maxlength="10" readonly="readonly" value="<%=memberRowMap.getString("name").equals("") ? "&nbsp" : memberRowMap.getString("name") %>">
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>비밀번호 재발급질문</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<select title="비밀번호 재발급질문" name="pwd_qus">
											<option value="" <%="".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>----- 질문을 선택하세요 -----</option>
											<option value = "본인의 초등학교는?" <%="본인의 초등학교는?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>본인의 초등학교는?</option>
											<option value = "본인의 핸드폰 번호는?" <%="본인의 핸드폰 번호는?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>본인의 핸드폰 번호는?</option>
											<option value = "어머니의 성함은?" <%="어머니의 성함은?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>어머니의 성함은?</option>
											<option value = "어릴적 별명은?" <%="어릴적 별명은?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>어릴적 별명은?</option>
											<option value = "본인이 태어난 곳은?" <%="본인이 태어난 곳은?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>본인이 태어난 곳은?</option>
											<option value = "가고 싶은 장소는?" <%="가고 싶은 장소는?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>가고 싶은 장소는?</option>
											<option value = "즐겨 부르는 노래는?" <%="즐겨 부르는 노래는?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>즐겨 부르는 노래는?</option>
											<option value = "감명 깊게 본 영화는?" <%="감명 깊게 본 영화는?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>감명 깊게 본 영화는?</option>
											<option value = "좋아하는 색깔은?" <%="좋아하는 색깔은?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>좋아하는 색깔은?</option>
											<option value = "가장 좋아하는 연예인은?" <%="가장 좋아하는 연예인은?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>가장 좋아하는 연예인은?</option>
											<option value = "부모님이 좋아하는 음식은?" <%="부모님이 좋아하는 음식은?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>부모님이 좋아하는 음식은?</option>
											<option value = "가장 기억에 남는 선생님은?" <%="가장 기억에 남는 선생님은?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>가장 기억에 남는 선생님은?</option>
											<option value = "좋아하는 애완동물은?" <%="좋아하는 애완동물은?".equals(memberRowMap.getString("pwdQus")) ? "selected='selected'" : ""  %>>좋아하는 애완동물은?</option>
										</select>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>비밀번호 재발급 답</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<input type="text" class="textfield" name="pwd_ans" value="<%=memberRowMap.getString("pwdAns").equals("") ? "&nbsp" : memberRowMap.getString("pwdAns") %>">
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>학력</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<select name="school">
											<option value="" <%="".equals(memberRowMap.getString("school")) ? "selected='selected'" : ""  %>>----- 학력을 선택하세요 -----</option>
											<option value="01" <%="01".equals(memberRowMap.getString("school")) ? "selected='selected'" : ""  %>>박사</option>
											<option value="02" <%="02".equals(memberRowMap.getString("school")) ? "selected='selected'" : ""  %>>석사</option>
											<option value="03" <%="03".equals(memberRowMap.getString("school")) ? "selected='selected'" : ""  %>>대졸</option>
											<option value="04" <%="04".equals(memberRowMap.getString("school")) ? "selected='selected'" : ""  %>>대재.퇴,초대졸</option>
											<option value="05" <%="05".equals(memberRowMap.getString("school")) ? "selected='selected'" : ""  %>>고졸</option>
											<option value="06" <%="06".equals(memberRowMap.getString("school")) ? "selected='selected'" : ""  %>>중졸이하</option>
											<option value="07" <%="07".equals(memberRowMap.getString("school")) ? "selected='selected'" : ""  %>>기타</option>
										</select>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>메일수신여부</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<input type="radio" value="Y" name="mailYN" <%="Y".equals(memberRowMap.getString("mailyn")) ? "checked='checked'" : ""  %> />
										<label for="" class="label01">Yes</label>
										<input type="radio" value="N" name="mailYN" <%="N".equals(memberRowMap.getString("mailyn")) ? "checked='checked'" : ""  %> />
										<label for="" class="label01">No</label>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>SMS수신여부</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<input type="radio" value="Y" name="smsYN" <%="Y".equals(memberRowMap.getString("smsYn")) ? "checked='checked'" : ""  %> />
										<label for="" class="label01">Yes</label>
										<input type="radio" value="N" name="smsYN" <%="N".equals(memberRowMap.getString("smsYn")) ? "checked='checked'" : ""  %> />
										<label for="" class="label01">No</label>
									</td>
								</tr>						 
								
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>변경패스워드</strong></td>
									<td class="tableline21" style="padding:0 0 0 10;vertical-align:middle;">
										<input maxlength="10" type="password" class="textfield" name="pwd" value="">
										<a href="javascript:goEmail()"><img src="/images/btn_mail01.gif" alt="이메일" /></a><a href="javascript:goSms('<%=memberRowMap.getString("userId").equals("") ? "&nbsp" : memberRowMap.getString("userId") %>');"><img src="/images/btn_sms01.gif" alt="SMS" /></a>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>기관</strong></td>
									<td class="tableline21" style="padding:0 0 0 10"><select name="dept" onchange="go_partCode(this.value, this.options[this.selectedIndex].text,'', '');"><option value="">==소속기관을 선택하세요==</option><%=deptSelectBox%></select></td>
									
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28"align="center" class="tableline11" bgcolor="#E4EDFF"><strong>부서</strong></td>
									<td class="tableline21" style="padding:0 0 0 10"> 
										<div name="partCodeDIV" id="partCodeDIV">
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>직급</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
									<input type="text" class="textfield" maxlength="20" name="jiknm" value="<%=memberRowMap.getString("jiknm") %>">
									<input type="button" class="boardbtn1" name="jiknmSearch;" value="직급검색"  onclick="jiknmSearch();"></td>
								</tr>
								<%-- 2010.03.17 - 달력추가 --%>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>최초임용일</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<input type="text" name="FIDATE" value="<%=memberRowMap.getString("fidate")%>" class="textfield" title="임용일">
										<a href = "javascript:void(0)" onclick="popFrame.fPopCalendar(FIDATE,FIDATE,popCal);return false">
											<img src="/images/skin1/icon/icon_cal01.gif" class="vp2" alt="달력" /> 
										</a>
										<span class="txt11 vp2">(예 :20101203)</span>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>현직급임용일</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<input type="text" name="UPSDATE" value="<%=memberRowMap.getString("upsdate")%>" class="textfield" title="현직급임용일">
										<a href = "javascript:void(0)" onclick="popFrame.fPopCalendar(UPSDATE,UPSDATE,popCal);return false">
											<img src="/images/skin1/icon/icon_cal01.gif" class="vp2" alt="달력" /> 
										</a>
										<span class="txt11 vp2">(예 :20101203)</span>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>직위</strong></td>
									<td class="tableline21" style="padding:0 0 0 10"><input type="text" class="textfield" maxlength="20" name="jikwi" value="<%=memberRowMap.getString("jikwi")%>"></td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" height="28" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>집전화</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<input type="text" class="textfield" maxlength="3" size="4" name="homeTel1" value="<%=memberRowMap.getString("homeTel1")%>"> - 
										<input type="text" class="textfield" maxlength="4" size="4" name="homeTel2" value="<%=memberRowMap.getString("homeTel2")%>"> - 
										<input type="text" class="textfield" maxlength="4" size="4" name="homeTel3" value="<%=memberRowMap.getString("homeTel3")%>">
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>사무실전화</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<input type="text" class="textfield" maxlength="3" size="4" name="officeTel1" value="<%=memberRowMap.getString("officeTel1")%>"> - 
										<input type="text" class="textfield" maxlength="4" size="4" name="officeTel2" value="<%=memberRowMap.getString("officeTel2")%>"> - 
										<input type="text" class="textfield" maxlength="4" size="4" name="officeTel3" value="<%=memberRowMap.getString("officeTel3")%>">
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>휴대폰</strong></td>
									<td class="tableline21" style="padding:0 0 0 10">
										<input type="text" class="textfield" maxlength="3" size="4" name="hp1" value="<%=memberRowMap.getString("hp1")%>"> - 
										<input type="text" class="textfield" maxlength="4" size="4" name="hp2" value="<%=memberRowMap.getString("hp2")%>"> - 
										<input type="text" class="textfield" maxlength="4" size="4" name="hp3" value="<%=memberRowMap.getString("hp3")%>">
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" align="center" class="tableline11" bgcolor="#E4EDFF"><strong>이메일*</strong></td>
									<td class="tableline21" style="padding:0 0 0 10"><input class="textfield" maxlength="30" type="text" class="textfield" id="email" name="email" size="30" value="<%=memberRowMap.getString("email") %>"></td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" align="center" class="tableline11" height="28" bgcolor="#E4EDFF"><strong>주소*</strong></td>
									<td class="tableline21" style="padding:0 0 0 0">
										<table cellspacing="0" cellpadding="0" style="padding:0 0 0 0" border="0" width="100%" class="contentsTable">
											<tr>
												<td class="tableline21" style="padding-left:10px;padding-bottom:6px" width="100%" height="28">
													<input type="text" class="textfield" maxlength="3" size="4" onclick="searchZip('homePost1','homePost2','homeAddr');" name="homePost1" value="<%=memberRowMap.getString("homePost1")%>" readonly> - 
													<input type="text" maxlength="3" size="4" class="textfield" onclick="searchZip('homePost1','homePost2','homeAddr');" name="homePost2" value="<%=memberRowMap.getString("homePost2")%>" readonly>
													<input type="button" value="주소검색" class="boardbtn1" onclick="searchZip('homePost1','homePost2','homeAddr');">
												</td>
											</tr>
											<tr width="28">
												<td class="" style="padding-left:10px;padding-bottom:6px;padding-top:6px"><input type="text" class="textfield" name="homeAddr" value="<%=memberRowMap.getString("homeAddr")%>" size="60"></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E4EDFF" align="center" class="tableline11" height="28" bgcolor="#E4EDFF"><strong>새 주 소</strong></td>
									<td class="tableline21" style="padding:0 0 0 0">
										<table cellspacing="0" cellpadding="0" style="padding:0 0 0 0" border="0" width="100%" class="contentsTable">
											<tr>
												<td class="tableline21" style="padding-left:10px;padding-bottom:6px" width="100%" height="28">
													<input type="text" title="새주소 우편번호" value="<%=memberRowMap.getString("newhomepost")%>" id="newHomePost" name="newHomePost" class="textfield" maxlength="7" size="9" readonly/>
													<a href="javascript:goPopup();"><img src="/images/skin1/button/btn_search02.gif" class="vm2" alt="검색"/></a>
												</td>
											</tr>
											<tr width="28">
												<td class="" style="padding-left:10px;padding-bottom:6px;padding-top:6px">
													<input type="text" title="새주소1" value="<%=memberRowMap.getString("newaddr1")%>" id="newAddr1" name="newAddr1" />
													<input type="text" title="새주소2" value="<%=memberRowMap.getString("newaddr2")%>" id="newAddr2" name="newAddr2" />
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td height="2" bgcolor="#375694" colspan="100%" ></td>
								</tr>
							</table>
							
                        <!---[e] content -->
                        <!-- space --><table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable"><tr><td height="10"></td></tr></table>
                        
                        <!-- button -->
                        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                        	<tr>
                        		<td height="10" align="center">
                        			<input type="button" class="boardbtn1" value="저장" onclick="go_save();">
	                       			<input type="button" class="boardbtn1" value="취소" onclick="go_list();">		
                        		</td>
                        	</tr>
                        </table>
                         <!-- space --><table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable"><tr><td height="50"></td></tr></table>
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>
	
<script language="JavaScript">
    //현재 등록된 기관코드 셀렉티드
 	var dept = "<%=memberRowMap.getString("dept")%>";
 	deptLen = $("dept").options.length;
	 for(var i=0; i < deptLen; i++) {
	     if($("dept").options[i].value == dept){
	      	$("dept").selectedIndex = i;
	      	// $("deptnm").value = $("dept").options[i].text;
		 }
 	 }
</script>








