<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시설예약관리
// date  : 2008-
// auth  : 양정환
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	/** 필수 코딩 내용 */
	// 로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    // navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
    
	//신청&승인 리스트 DataMap
	DataMap listMap = (DataMap)request.getAttribute("RESERVATION_LIST");
	listMap.setNullToInitialize(true);
	//관리자SMS 리스트
	DataMap adminMap = (DataMap)request.getAttribute("ADMIN_SMS_LIST");
	adminMap.setNullToInitialize(true);
	//신청&승인 구분 변수
	String type = (String)request.getAttribute("type");
	
	StringBuffer listHtml  = new StringBuffer();
	StringBuffer adminHtml = new StringBuffer();
	//관리자 리스트를 그린다.
	for(int i=0; i < adminMap.keySize("raNo"); i++) {
		adminHtml.append(adminMap.getString("raName", i)+"("+adminMap.getString("raHp", i)+")<a href=\"javascript:delAdmin('"+adminMap.getString("raNo", i)+"');\" title=\"삭제\">[X]</a>&nbsp;&nbsp;");
	}
	
	//신청&승인 리스트를 그린다.
	int number=1;
	for(int i=0; i < listMap.keySize("taPk"); i++){
		
		listHtml.append("<tr>");
		listHtml.append("<td>"+ (number++) +"</td>");
		
		if(listMap.getString("taReqSection", i).equals("1")) {
			if(!"".equals(listMap.getString("starttime", i))) {
				listHtml.append("<td>"+listMap.getString("taRentDate", i) + "(" + listMap.getString("starttime", i)+"시 ~ " +  listMap.getString("endtime", i)+"시)</td>");	
			} else {
				listHtml.append("<td>"+listMap.getString("taRentDate", i)+"</td>");
			}
			
		} else {
			if(listMap.getString("taRentTime", i).equals("am")) {
				listHtml.append("<td>"+listMap.getString("taRentDate", i)+" (오전 09:00~13:00)</td>");
			}else if(listMap.getString("taRentTime", i).equals("pm")){
				listHtml.append("<td>"+listMap.getString("taRentDate", i)+" (오후 13:00~17:00)</td>");
			}else if(listMap.getString("taRentTime", i).equals("all")) {
				if(listMap.getString("taReqSection", i).equals("6")){
					listHtml.append("<td>"+listMap.getString("taRentDate", i)+"</td>");
				} else if(listMap.getString("taReqSection", i).equals("7")){
					listHtml.append("<td>"+listMap.getString("taRentDate", i)+"</td>");
				} else {
					listHtml.append("<td>"+listMap.getString("taRentDate", i)+" (<font color=red>종일 09:00~17:00</font>)</td>");
				}
				
				
			}
		}

		listHtml.append("<td>"+listMap.getString("taReqGroup", i)+"</td>");
		listHtml.append("<td>"+listMap.getString("taReqName", i)+"</td>");
		
		if(listMap.getString("taReqSection", i).equals("0")) {
			listHtml.append("<td>잔디구장</td>");
		}else if(listMap.getString("taReqSection", i).equals("1")){
			listHtml.append("<td>테니스장</td>");
		}else if(listMap.getString("taReqSection", i).equals("2")){
			listHtml.append("<td>테니스장2</td>");
		}else if(listMap.getString("taReqSection", i).equals("3")){
			listHtml.append("<td>강당</td>");
		}else if(listMap.getString("taReqSection", i).equals("4")){
			listHtml.append("<td>체육관</td>");
		}else if(listMap.getString("taReqSection", i).equals("6")){
			listHtml.append("<td>강의실</td>");
		}else if(listMap.getString("taReqSection", i).equals("7")){
			listHtml.append("<td>생활관</td>");
		}

		if(listMap.getString("taReqSection", i).equals("6")){
			listHtml.append("<td>50석: "+listMap.getString("room50", i)+" 실 예약<br />  100 석: "+listMap.getString("room100", i)+" 실 예약<br /> 사용 시간 : "+listMap.getString("starttime", i)+"시 ~ "+listMap.getString("endtime", i)+"시</td>");
		} else if(listMap.getString("taReqSection", i).equals("7")){
			listHtml.append("<td>남자 : "+listMap.getString("sexm", i)+"명<br />여자 : "+listMap.getString("sexf", i)+"명<br/>숙박기간 : "+listMap.getString("startdate", i)+"일 ~ "+listMap.getString("enddate", i)+"일</td>");
		} else if(listMap.getString("taReqSection", i).equals("1")){
			if(!"".equals(listMap.getString("starttime", i))) {
				
				String taRentTime = listMap.getString("taRentTime", i);
				String taRentTimeName = "am1".equals(taRentTime) ? "1면":"2면";

				listHtml.append("<td>"+taRentTimeName+"("+listMap.getString("taPerson", i)+")명</td>");

			} else {
				listHtml.append("<td></td>");
			}
		} else {
			listHtml.append("<td></td>");
		}
	
		// 신청일시
		listHtml.append("<td>"+listMap.getString("taDate", i)+"</td>");
		
		// 사용승인번호
		if(listMap.getString("taAgreement", i).equals("N")) {
			listHtml.append("<td><input type='text' id='agrno' name='agrno' size='3' maxlength='3'/></td>");
		}else if(listMap.getString("taAgreement", i).equals("Y")) {
			listHtml.append("<td><font color='blue'>" + listMap.getString("taAgrNo", i) + "</font></td>");
		}
		
		if(listMap.getString("taAgreement", i).equals("N")) {
			listHtml.append("<td><a href=\"javascript:confirmResv('" + 
							listMap.getString("taPk", i) + "', '" + 
							listMap.getString("taReqName", i) + "', '" + 
							listMap.getString("taReqPhone", i) + "', " + 
							i + ")\">승인</a> | <a href=\"javascript:cancelResv('"+listMap.getString("taPk", i)+"')\">취소</a></td>");
		}else if(listMap.getString("taAgreement", i).equals("Y")) {
			listHtml.append("<td><font color='blue'> 승인처리</font><font color='red'>(<a href=\"javascript:cancelResv('"+listMap.getString("taPk", i)+"')\"><font color='red'>취소</font></a>)</font></td>");
		}else if(listMap.getString("taAgreement", i).equals("C")) {
			listHtml.append("<td>"+listMap.getString("taAgrDate2", i)+"</td>");
			listHtml.append("<td><font color=red> 취소처리 </font></td>");
		}
		listHtml.append("<td><a href=\"javascript:go_modify('"+listMap.getString("taPk",i)+"', '" + listMap.getString("taAgreement", i) + "')\">수정</a></td>");
		listHtml.append("</tr>");
	}
	
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script type="text/javascript" language="javascript">

	//승인처리
	function confirmResv(taPk, name, hp, i) {
		var agrnoObj = document.getElementsByName("agrno");	//승인번호 엘리먼트
		var taAgrNo  = "";	//승인번호 값

		if(agrnoObj[i].value == "" || agrnoObj[i].value == null) {
			alert("승인번호를 입력 하세요.");
			agrnoObj[i].focus();
			return;
		} else {
			taAgrNo = agrnoObj[i].value;
		}
		
		if(confirm('승인처리 하시겠습니까?')) {
						
			// SMS 발송
			if(name != null && hp != null) { send_sms(name, hp); }		
			else { return; }
			
			alert('승인처리 되었습니다.');
			location.href="/courseMgr/reservation.do?mode=confirmaction&taPk="+taPk+"&taAgrNo="+taAgrNo;
			
		} else {
			return;
		}
	}

	//SMS 발송
	function send_sms(name, hp) {
		if(confirm("문자메세지를 발송 하시겠습니까?")) {
			var form = document.pform;
			$("smsName").value = name;
			$("smsHp").value = hp;
			form.action = "mail.do";
			form.submit();
			//location.href = "/courseMgr/mail.do?mode=sms_rsv_agreement"+"&qu=rsv_agreement"+"&smsName="+name+"&smsPhone="+hp; };
		} else { 
			return; 
		}
	}
	
	//취소(삭제)
	function cancelResv(taPk) {
		var result2 = confirm('취소처리 하시겠습니까?');

		if(result2 == true) {
			alert('취소처리되었습니다.');
			location.href="/courseMgr/reservation.do?mode=cancelaction&taPk=" + taPk;
		}else {
			return;
		}		
	}

	function viewDetail(content, post, addr, tel, hp, money) {
		alert("행사내용 및 인원 : " + content + "\n" + "주소 : ("+post+") " + addr +"\n" + "전화번호 : " + tel + "\n" + "핸드폰번호 :" + hp + "\n" + "금액 : " + money +"원");
	}

	//수정
	function go_modify(taPk, taAgreement){
		var agrnoObj;
		var agrnoParam = "";

		// 신청내역 화면일 경우만 사용 승인번호 인자를 설정한다.
		if(taAgreement == "N") {
			agrnoObj   = document.getElementById("agrno");	//사용 승인번호		
		
			if(agrnoObj.value == null)	agrnoParam = "";
			else	agrnoParam = agrnoObj.value;
		}

		url="/courseMgr/reservation.do?mode=modify&taPk="+taPk+"&agrno="+agrnoParam;		
		window.open(url,'modifyPop','statusbar=no,height=750px,width=650px,scrollbars=1,resizable=1');
	}

	//관리자SMS 등록
	function addAdmin() {
		$("mode").value 	= "exec";
		$("qu").value   	= "add";
		$("menuId").value 	= "1-5-2";
		$("raName").value 	= $("name").value;
		$("raHp").value 	= $("hp").value;

		if($("name").value == "" || $("hp").value == "") {
			alert('이름과 핸드폰번호는 모두 필수입니다.');
			return;
		}
		
		pform.action = "/courseMgr/reservation.do";
		pform.submit();
	}

	//관리자SMS 삭제
	function delAdmin(raNo) {
		$("mode").value = "exec";
		$("qu").value   = "del";
		$("menuId").value = "1-5-2";
		
		$("raNo").value = raNo;

		pform.action  = "/courseMgr/reservation.do";
		pform.submit();
	}

	//신청내역, 승인내역 전환
	function go_list(type){
		location.href="/courseMgr/reservation.do?mode=list&menuId=1-5-2&type="+type;
	}

	function setTime() {
		var objSelStartTime = document.getElementById("selStartTime");
		var startTime = objSelStartTime.options[objSelStartTime.selectedIndex].value;

		var objSelEndTime = document.getElementById("selEndTime");
		var endTime = objSelEndTime.options[objSelEndTime.selectedIndex].value;

		var totalTime = endTime - startTime;

		var sum	 	 = 0;
		var form = document.pform;
		var tempTime = form.time;
		var timeName = "am1";
		
		for(i=0; i < tempTime.length; i++) {
			if(tempTime[i].checked == true) {
				timeName = tempTime[i].value;
			}
		}
		
		if(timeName == "am1") {
			sum = (5000 * totalTime);
		} else if(timeName == "pm1") {
			sum = (10000 * totalTime);
		}

		if(totalTime < 0 ) {
			totalTime = 0;
			sum = 0;
		}

		document.getElementById("time_sum").value = totalTime;
		document.getElementById("starttime").value = startTime;
		document.getElementById("endtime").value = endTime;

		form.price_sum.value = sum;
		form.sum.value       = sum;
	}
</script>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form id="pform" name="pform" method="POST">
	<input type="hidden" id="mode"	  	name="mode"		value="" />
	<input type="hidden" id="qu"	  	name="qu"		value="" />
	<input type="hidden" id="menuId"  	name="menuId"	value="" />
	<input type="hidden" id="raNo"		name="raNo"		value="" />
	<input type="hidden" id="raName"	name="raName"	value="" />	<%-- 관리자 이름 --%>
	<input type="hidden" id="raHp"		name="raHp"		value="" /> <%-- 관리자 휴대폰번호 --%>
	<input type="hidden" id="smsName"	name="smsName"	value="" /> <%-- 승인처리SMS 성명 --%>
	<input type="hidden" id="smsHp"		name="smsHp"	value="" /> <%-- 승인처리SMS 휴대폰번호 --%>
</form>

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap="nowrap"><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap="nowrap"><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"class="contentsTable">
					<tr>
						<td colspan="100%">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr bgcolor="#5071B4"><td height="2" colspan="100%"></td></tr>
								<tr height="28" bgcolor="F7F7F7" >
									<td width="80" align="center" class="tableline11"><strong>구분</strong></td>
									<td width="90%" align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
										<input type="radio" class="chk_01" name="searchKey" id="searchKey1" value="N" <%if("N".equals(type)){ %> checked="checked" <%} %> onclick="javascript:go_list('N');"><label for="searchKey1">신청내역</label>
										<input type="radio" class="chk_01" name="searchKey" id="searchKey2" value="Y" <%if("Y".equals(type)){ %> checked="checked" <%} %> onclick="javascript:go_list('Y');"><label for="searchKey2">승인내역</label>
										<input type="radio" class="chk_01" name="searchKey" id="searchKey3" value="C" <%if(type.equals("C")){ %>checked<%} %> onclick="javascript:go_list('C');"><label for="searchKey3">취소내역</label>
									</td>				
								</tr>
								<tr bgcolor="#5071B4"><td height="2" colspan="100%"></td></tr>
							</table>
						</td>
					</tr>
					<tr><td height="20px" colspan="100%"></td></tr>
					<tr><td> 관리자 목록 ▶  <%=adminHtml.toString()%></td></tr>
					<tr><td>
						관리자 추가 ▶
						이름: <input type="text" class="textfield" id="name" name="name">
						휴대폰: <input type="text" class="textfield" id="hp" name="hp">
						<input type="button" value="관리자등록하기" class="button" onclick="addAdmin();">
						</td>
					</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>				
					<td>
						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th>예약일자</th>
								<th>단체명</th>
								<th>예약자성명</th>
								<th>대관장소</th>
								<th>상세정보</th>
								<th>신청일시</th>
								<% if(!"C".equals(type)) {%>
								<th>승인번호</th>
								<% } else { %>
								<th>취소일시</th>
								<% } %>
								<th>승인처리</th>
								<th class="br0">수정</th>
							</tr>
							</thead>
							<tbody>
							<%= listHtml %>
							</tbody>
						</table>
					</td>
				</tr>
			</table>	
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>                     
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
</body>