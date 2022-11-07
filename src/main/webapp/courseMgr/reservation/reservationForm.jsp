<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시설대여신청 직권입력
// date  : 2009-04-20
// auth  : 최석호
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
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script  type="text/javascript" language="javascript">

	var flag = false;	
	
	function submitaction_() {
		var form = document.pform;
		var place = form.place.value;

		if(flag) {
			alert("처리중입니다.");
			return;
		}
		resvname 	= document.getElementById("resvname").value;
		tel1 		= document.getElementById("tel1").value;
		tel2 		= document.getElementById("tel2").value;
		tel3 		= document.getElementById("tel3").value;
		groupname 	= document.getElementById("groupname").value;
		jumin1 		= document.getElementById("jumin1").value;
		jumin2 		= document.getElementById("jumin2").value;
		person		= form.person.value;
		place		= form.place.value;
		gubun		= form.gubun.value;
		resv_day	= form.resv_day.value;

		if(groupname == "") {
			alert("기관(단체)명을 입력 해 주세요.");
			document.getElementById("groupname").focus();
			return;
		} else if(resvname =="") {
				alert("예약자 이름을  입력해 주세요.");
				document.getElementById("resvname").focus();
				return;
		} else if(jumin1 =="" || jumin2 == ""){
			alert("주민번호를 입력 해 주세요.");
			document.getElementById("jumin1").focus();
			return;
		} else if(tel1 == "" || tel2 == "" || tel3 == "") {
			alert("핸드폰 번호는 필수입니다.");
			document.getElementById("tel1").focus();
			return;
		} else if(person == "0" || person == "" || person == null){
			alert("인원수를 입력해 주세요.");
			form.person.focus();
			return;
		} else if(place == "") {
			alert("사용시설을 선택해 주세요.");
			form.placeSelect.focus();
			return;
		} else if(gubun == "") {
			alert("사용시간을 선택해 주세요.");
			return;
		} else if(resv_day == "") {
			alert("사용일을 입력해 주세요.");
			form.resv_day.focus();
			return;
		} 
		
		//else if(jumin1 != "" && jumin2 != "" ){	// 주민번호 유효성 체크
			//if(checkJuminNumber(jumin1, jumin2) != true) {
				//return;
			//}
		//}

		setPriceSum(place, gubun,person);
		
		flag = true;		
		document.pform.action = "reservation.do";
		document.pform.submit();
	 }

	//장소값 세팅
	function setPlace(num) {
		var form = document.pform;
		document.pform.place.value = form.placeSelect.options(num).value;
		
	}

	//시간구분 세팅
	function setTime(time) {
		document.pform.gubun.value = time;
	}
	
	//합계를 계산한다 (사용료 * 사용인원)
	function setPriceSum(place, gubun, person) {
		var form = document.pform;

		var unitcost = 0;
		var sum	 	 = 0;
		
		var place = place;	//사용 시설
		var time  = gubun;	//사용 시간 구분
		var multi = time + place;
		person = Number(person);

		if(multi == "am0" || multi == "pm0") {
			unitcost = "100000";
		} else if(multi == "am1" || multi == "pm1") {
			unitcost = "20000";
		} else if(multi == "all0") {
			unitcost = "200000";
		} else if(multi == "all1") {
			unitcost = "40000";
		} else if(multi == "am3" || multi == "pm3") {
			sum = "70000";
		} else if(multi == "am4" || multi == "pm4") {
			sum = "60000";
		} else if(multi == "all3") {
			sum = "140000";
		} else if(multi == "all4") {
			sum = "120000";
		}
				
		
		if(multi == "am0" || multi == "pm0" || multi == "all0" || multi == "am3" || multi == "pm3" || multi == "all3" || multi == "am4" || multi == "pm4" || multi == "all4")	sum = commaNum(Number(unitcost));	// 잔디구장의 사용금액은 인원수와 무관
		else	sum = commaNum(person * Number(unitcost));	// 테니스장의 경우
		
		form.sum.value = sum;
		return sum;
	}
	
	// 숫자를 화폐 단위로 변경 (###,###)
	function commaNum(num) {  
        if (num < 0) { num *= -1; var minus = true} 
        else var minus = false      
        var dotPos = (num+"").split(".")
        var dotU = dotPos[0] 
        var dotD = dotPos[1] 
        var commaFlag = dotU.length%3 

        if(commaFlag) { 
                var out = dotU.substring(0, commaFlag)  
                if (dotU.length > 3) out += "," 
        } 
        else var out = "" 
        for (var i=commaFlag; i < dotU.length; i+=3) { 
                out += dotU.substring(i, i+3)  
                if( i < dotU.length-3) out += "," 
        } 
        if(minus) out = "-" + out 
        if(dotD) return out + "." + dotD 
        else return out 
	}

</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form id="pform" name="pform" method="post">

<input type="hidden" name="mode" value="reservationaction">
<input type="hidden" name="year" value='<%=request.getParameter("year") %>'>
<input type="hidden" name="month" value='<%=request.getParameter("month") %>'>
<input type="hidden" name="day" value='<%=request.getParameter("day") %>'>
<input type="hidden" name="gubun" value="">
<input type="hidden" name="place" value="">
<input type="hidden" name="sum" value="" alt="사용요금 합계 가격">

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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->

			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>관리자 직접입력</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->
						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<!-- line --><table width="100%" height="2" cellspacing="0" cellpadding="0" bgcolor="#5378B9"><tr><td></td></tr></table>
									<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#D6DBE5">
										<tr bgcolor="#FFFFFF">
											<th class="tableline11 dkblue" bgcolor="#E4EDFF" align="center">기관명</th>
											<td class="tableline21" align="left">
												<input type="text" value="" name="groupname" class="textfield" />
											</td>
											<th class="tableline11 dkblue" bgcolor="#E4EDFF" align="center">대표자 성명</th>
											<td><input type="text" id="name" value="" name="resvname" class="textfield" /></td>
										</tr>
										<tr bgcolor="#FFFFFF">
											<th class="tableline11 dkblue" bgcolor="#E4EDFF" align="center">주민등록번호</th>
											<td>
												<input type="text" value="" name="jumin1" maxlength="6" class="textfield" /> - 
												<input type="text" value="" name="jumin2" maxlength="7" class="textfield" />
											</td>
											<th class="tableline11 dkblue" bgcolor="#E4EDFF" align="center">연락처(핸드폰)</th>
											<td>
												<input type="text" value="" name="tel1" maxlength="3" class="textfield" size="4" /> -
							                	<input type="text" value="" name="tel2" maxlength="4" class="textfield" size="4" /> -
												<input type="text" value="" name="tel3" maxlength="4" class="textfield" size="4" />
											</td>
										</tr>
										<tr bgcolor="#FFFFFF">
											<th class="tableline11 dkblue" bgcolor="#E4EDFF" align="center">신청자주소</th>
											<td colspan="3"><input type="text" name="homeAddr" class="textfield" size="70" /></td>				
											
										</tr>
										<tr bgcolor="#FFFFFF">				
											<th class="tableline11 dkblue" bgcolor="#E4EDFF" align="center">사용목적</th>
											<td colspan="3"><input type="text" name="content" class="textfield" size="70" /></td>
										</tr>
										<tr bgcolor="#FFFFFF">
											<th class="tableline11 dkblue" bgcolor="#E4EDFF" align="center">사용인원</th>
											<td> <input type="text" value="" name="person" class="textfield" />명</td>
											<th class="tableline11 dkblue" bgcolor="#E4EDFF" align="center">사용일</th>
											<td>
												<input type="text" class="textfield" name="resv_day" onclick="javascript:fnPopupCalendar(frm, this);" readonly="readonly"/>
												<a href = "javascript:fnPopupCalendar(frm, document.pform.resv_day);">
													<img src="/images/skin1/icon/icon_cal01.gif" class="vp2" alt="달력" /> 
												</a> (예 : 20090101)
											</td>
										</tr>
										<tr bgcolor="#FFFFFF">
											<th class="tableline11 dkblue" bgcolor="#E4EDFF" align="center">사용시설</th>
											<td>
												<select name="placeSelect" onchange="javascript:setPlace(this.selectedIndex);">
													<option value=""> --- 시설선택 --- </option>
													<option value="0">잔디구장</option>
													<option value="1">테니스장</option>
													<option value="3">강당</option>
													<option value="4">체육관</option>
												</select>
											</td>
											<th class="tableline11 dkblue" bgcolor="#E4EDFF" align="center">사용시간</th>
											<td>
												 	<input type="radio" name="time" value="am" onclick="javascript:setTime(this.value);">오전(09시~13시) <br>
												 	<input type="radio" name="time" value="pm" onclick="javascript:setTime(this.value);">오후(13시~17시) <br>
												 	<input type="radio" name="time" value="all" onclick="javascript:setTime(this.value);">종일(09시~17시)
											</td>
										</tr>
									</table>
									<!-- line --><table width="100%" height="2" cellspacing="0" cellpadding="0" bgcolor="#5378B9"><tr><td></td></tr></table>
								</td>
							</tr>
						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="center">
									<input type="button" class="boardbtn1" value=' 신청 ' onClick="javascript:submitaction_();" >
									<input type="button" class="boardbtn1" value=' 취소' onClick="javascript:history.back();">
								</td>
							</tr>
						</table>

						<!---[e] content -->
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->

			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body> 

