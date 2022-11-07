<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prginfo  : 인천 LMS 시설대여를 신청하는 화면
// prgnm 	: 시설대여신청
// date		: 2008-08-28 
// auth 	: 양정환
// date-mod : 2009-04-06
// auth-mod : 최석호
	
	String multi = "0"; // 테니스장일 때 곱해야 할 돈.(오전/오후: 2000원, 종일: 4000원)
	if(request.getParameter("gubun").equals("all")) {
		multi = "40000";
	}else {
		multi = "20000"; 
	}
	
	String gubun=request.getParameter("gubun");
	String place=request.getParameter("place");
	
	String radioCheck=gubun+String.valueOf(place);
	String sum = "";
	
	// 사용요금 합계 계산을 위한 값 설정
	if(radioCheck.equals("am0") || radioCheck.equals("pm0")) {
		sum = "100000";
	} else if(radioCheck.equals("am1") || radioCheck.equals("pm1")) {
		sum = "20000";
	} else if(radioCheck.equals("all0")) {
		sum = "200000";
	} else if(radioCheck.equals("all1")) {
		sum = "40000";
	} else if(radioCheck.equals("am3") || radioCheck.equals("pm3")) {
		sum = "70000";
	} else if(radioCheck.equals("am4") || radioCheck.equals("pm4")) {
		sum = "60000";
	} else if(radioCheck.equals("all3")) {
		sum = "140000";
	} else if(radioCheck.equals("all4")) {
		sum = "120000";
	}
	
%>


<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script  type="text/javascript" language="javascript">
<!--
	var flag = false;	

	/** 
	 * desc   : 폼 유효성 체크 / 입력 Submit
	 * param  : 
	 * return : 
	 */
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

		if(groupname == "") {
			alert("기관(단체)명을 입력 해 주세요.");
			document.getElementById("groupname").focus();
			return;
		}else if(tel1 == "" || tel2 == "" || tel3 == "") {
			alert("핸드폰 번호는 필수입니다.");
			document.getElementById("tel1").focus();
			return;
		}else if(resvname =="") {
			alert("예약자 이름을  입력해 주세요.");
			document.getElementById("resvname").focus();
			return;
		}else if(jumin1 =="" || jumin2 == ""){
			alert("주민번호를 입력 해 주세요.");
			document.getElementById("jumin1").focus();
			return;
		}else if(person == "0" || person == "" || person == null){
			alert("인원수를 입력해 주세요.");
			form.person.focus();
			return;
		}else if(jumin1 != "" && jumin2 != "" ){	// 주민번호 유효성 체크
			if(checkJuminNumber(jumin1, jumin2) != true) {
				return;
			}
		}

	<% if(place.equals("6")) { %>
		if(document.getElementById("room50").value == "") {
			alert("50석 자석을 입력해주세요.");
			document.getElementById("room50").focus();
			return;
		} else if(document.getElementById("room100").value == "") {
			alert("100석 자석을 입력해주세요.");
			document.getElementById("room100").focus();
			return;
		} else if(document.getElementById("starttime").value == "") {
			alert("시작 시간을 입력해주세요.");
			document.getElementById("starttime").focus();
			return;
		} else if(document.getElementById("endtime").value == "") {
			alert("종료 시간을 입력해주세요.");
			document.getElementById("endtime").focus();
			return;
		}
	
	<% } %>
	<% if(place.equals("7")) { %>
		if(document.getElementById("sexm").value == "") {
			alert("남자인원을 입력해주세요.");
			document.getElementById("sexm").focus();
			return;
		} else if(document.getElementById("sexf").value == "") {
			alert("여자인원을 입력해주세요.");
			document.getElementById("sexf").focus();
			return;
		} else if(document.getElementById("startdate").value == "") {
			alert("숙반기간을 입력해주세요.");
			document.getElementById("startdate").focus();
			return;
		} else if(document.getElementById("enddate").value == "") {
			alert("숙반기간을 입력해주세요.");
			document.getElementById("enddate").focus();
			return;
		}
	<%
	   }
	%>
		
		flag = true;		
		document.pform.action = "introduce.do";
		document.pform.submit();
	 }


	/** 
	 * desc   : 주민등록번호 유효성 체크
	 * param  : 주민번호
	 * return : boolean
	 */
	function checkJuminNumber(jumin1, jumin2) {
		var juminNumber = jumin1 + jumin2;		// 주민번호의 형태와 7번째 자리(성별) 유효성 검사
		//var juminNumber = form.juminNumber.value;
		fmt = /^\d{6}[1234]\d{6}$/;
		if( !fmt.test( juminNumber ) ) {
			alert("잘못된 주민등록번호입니다.");
			return false;
		}
		
		// 날짜 유효성 검사
		birthYear  = ( juminNumber.charAt(7) <= "2" ) ? "19" : "20";
		birthYear += juminNumber.substr( 0, 2 );
		birthMonth = juminNumber.substr( 2, 2 ) - 1;
		birthDate  = juminNumber.substr( 4, 2 );
		birth = new Date( birthYear, birthMonth, birthDate );
		if( birth.getYear() % 100 != juminNumber.substr( 0, 2 )
		|| birth.getMonth() != birthMonth
		|| birth.getDate() != birthDate ) {
			alert("잘못된 주민등록번호입니다.");
			return false;
		}
		
		// Check Sum 코드의 유효성 검사
		buf = new Array( 13 );
		for( i = 0; i < 6; i++ ) buf[i] = parseInt( juminNumber.charAt( i ) );
		for( i = 6; i < 13; i++ ) buf[i] = parseInt( juminNumber.charAt( i ) );
		multipliers = [ 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 ];
		for( i = 0, sum = 0; i < 12; i++ ) sum += ( buf[i] *= multipliers[i] );
		if( ( 11 - ( sum % 11 ) ) % 10 != buf[12] ) {
			alert("잘못된 주민등록번호입니다.");
			return false;
		}
		return true;
	}

	
	//우편번호 검색
	function searchZipp(post1, post2, addr){

		var url = "/homepage/join.do";
		url += "?mode=zipcode";
		url += "&zipCodeName1=pform." + post1;
		url += "&zipCodeName2=pform." + post2;
		url += "&zipAddr=pform." + addr;
		
		pwinpop = popWin(url,"cPop","420","350","yes","yes");

	}	 

	function calMoney(person) {
		document.getElementById("price").value = person * <%=Integer.parseInt(multi)%>;
		document.getElementById("setprice").value = person * <%=Integer.parseInt(multi)%>;
	}

	function init(){
		
		var form=document.pform;
		for(var i=0;i<form.elements.length;i++){
			if(form.elements[i].type=='radio'){
				if(form.elements[i].value=='<%=radioCheck%>'){
					form.elements[i].checked=true;
				}

				form.elements[i].disabled=true;		// 시설과 시간을 이미 알고 있으므로 선택할 필요 없다.
			}
		}
	}
	

	//합계를 계산한다 (사용료 * 사용인원)
	function setPriceSum(obj) {
		var form = document.pform;
		var unitcost = 0;
		var person   = 0;
		var sum	 	 = 0;

		form.unitcost.value = '<%= sum %>';
		unitcost     = form.unitcost.value;	// 단가가격

		if(obj.value != "" && obj.value != null)	person = Number(obj.value);
		
		if(form.place.value == "0") {
			sum = commaNum(Number(unitcost)) 	// 잔디구장의 사용금액은 인원수와 무관
		
		} else if(form.place.value == "3") {
			sum = commaNum(Number(unitcost)) 
		} else if(form.place.value == "4") {
			sum = commaNum(Number(unitcost))
		} else if(form.place.value == "1")  {
			//sum = commaNum(person * Number(unitcost));				// 테니스장의 경우
		} else {
			sum = commaNum(person * Number(unitcost));				// 테니스장의 경우
		}
		
		form.price_sum.value = sum;
		form.sum.value       = sum;
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

		if(totalTime <= 0 ) {
			totalTime = 0;
			sum = 0;
		}

		document.getElementById("time_sum").value = totalTime;
		document.getElementById("starttime").value = startTime;
		document.getElementById("endtime").value = endTime;

		form.price_sum.value = sum;
		form.sum.value       = sum;
	}


	// 숫자만 입력하게끔
	//function onlyNumber() {
		//if((event.keyCode < 48) || (event.keyCode > 57)) {
			//return false;
		//}
	//}
-->
</script>

<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left6.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual6">인재개발원 소개</div>
            <div class="local">
              <h2>시설현황</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; 시설현황 &gt; <span>시설대여 신청</span></div>
            </div>
            <div class="contnets">
		<!-- content s ===================== -->
<form id="pform" name="pform" method="post">
<input type="hidden" name="mode" id="mode" value="reservationaction">
<input type="hidden" name="year" id="year" value='<%=request.getParameter("year") %>'>
<input type="hidden" name="month" id="month" value='<%=request.getParameter("month") %>'>
<input type="hidden" name="day" id="day" value='<%=request.getParameter("day") %>'>
<input type="hidden" name="gubun" id="gubun" value='<%=request.getParameter("gubun") %>'>
<input type="hidden" name="place" id="place" value='<%=request.getParameter("place") %>'>
<input type="hidden" name="unitcost" id="unitcost" value="" alt="단가 가격">
<input type="hidden" name="sum" id="sum" value="" alt="사용요금 합계 가격">
<input type="hidden" id="setprice" name="setprice" value="">
            <ol class="TabSub">
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6');">시설개요</a></li>
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-2');">층별안내</a></li>
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-3');">편의시설</a></li>
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-4');">시설대여안내</a></li>
            <li class="TabOn last"><a href="javascript:fnGoMenu('7','reservation');"  onclick="alert('1. 시설 대여 안내 [신청 절차] 확인 바랍니다. \n - 유선상 예약가능 여부 확인 필요 (☏ 032-440-7632) \n\n2. 예약 후 [최종 승인]이 되어야 시설 사용이 가능합니다. \n - 유선상 미확인 신청시 최종 승인 불가 할수 있음 \n\n ※ 본 시설은 교육시설로서 교육(시,군구 행사 포함) 일정 \n및 교육에 지장없는 범위 내에서 시민에게 개방하고 있어 \n타 대관시설에 비해 제약이 있을 수 있습니다.');">시설대여신청</a></li>
            <li><a href="javascript:fnGoMenu('7','reservationConfirm');">시설대여예약확인</a></li>
			<li class="last"><a href="javascript:fnGoMenu('7','reservationSurvey');">시설대여설문</a></li>
          </ol>
		<div id="content">
		<!-- title --> 
			<h2 class="h2Ltxt"><img src="../../../images/skin1/title/tit_050606.gif" alt="예약하기" /></h2>
			<!-- //title -->
			<div class="space"></div>
            <!-- view -->
			<table class="dataW01">		
			<tr>
				<th class="bl0" rowspan="2">신청자 <br>기관(단체)명</th>
				<td rowspan="2"><input type="text" value="" name="groupname" id="groupname" class="input02 w120" /></td>
				<th>대표자 성명</th>
				<td colspan="2"><input type="text" id="resvname" value="" name="resvname" class="input02 w120" /></td>
			</tr>
			<tr>
				<th>주민등록번호</th>
				<td colspan="2">
					<input type="text" value="" name="jumin1" id="jumin1" maxlength="6" class="input02 w100" /> - 
					<input type="password" value="" name="jumin2" id="jumin2" maxlength="7" class="input02 w100" />
				</td>
			</tr>
			<tr>
				<th class="bl0" >신청자주소</th>
				<td colspan="2"><input type="text" value="" name="homeAddr" class="input02 w200" /></td>				
				<td colspan="2">
					연락처(핸드폰)<br>
					<input type="text" value="" name="tel1" id="tel1" maxlength="3" class="input02 w40" /> -
                	<input type="text" value="" name="tel2" id="tel2" maxlength="4" class="input02 w40" /> -
					<input type="text" value="" name="tel3" id="tel3" maxlength="4" class="input02 w40" />
				</td>
			</tr>
			<tr>				
				<th class="bl0" >사용목적</th>
				<td colspan="4"><input type="text" value="" name="content" id="content" class="input02 w382" /></td>
			</tr>
			<tr>
				<th class="bl0" >사용인원</th>
				<td>총 <input type="text" value="0" name="person" id="person"  class="input02 w40" onchange="javascript:
(this)" />명</td>
				<th>사용일</th>
				<td colspan="2">
					<%=request.getParameter("year") %>년 <%=request.getParameter("month") %>월  <%=request.getParameter("day")%>일 
				</td>
			</tr>
	<% if(place.equals("0")) { %>
			<tr>
				<th class="bl0"  rowspan="3">사용시설</th>
				<td rowspan="3">운동장</td>
				<th rowspan="3">사용시간</th>
				<td><!-- input type="radio" name="time" id="time"  value="am0" -->오전(9시~13시)</td>
				<td>100,000원</td>
			</tr>
			<tr>
				<td><!-- input type="radio" name="time"  id="time"  value="pm0" -->오후(13시~17시)</td>
				<td>100,000원</td>
			</tr>
			<tr>
				<td><!-- input type="radio" name="time"  id="time"  value="all0" -->종일(9시~17시)</td>
				<td>200,000원</td>
			</tr>
			
			<!-- 사용금액 합계 -->
			<input type="text" size="10" name="price_sum"  id="price_sum" style="border:0; display:none;" value="" disabled="disabled"  />
			
	<% } else if(place.equals("1")) { %>
			<tr>
				<th class="bl0"  rowspan="4">사용시설</th>
				<td rowspan="4">테니스장</td>
				<th rowspan="3">사용금액(시간당*사용면수)</th>
				<td><input type="radio" name="time" id="time"  value="am1" checked="checked" onclick="setTime();">1면</td>
				<td>5,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  id="time"  value="pm1" onclick="setTime();">2면</td>
				<td>10,000원</td>
			</tr>
			<tr>
				<td><!-- input type="radio" name="time"  id="time"  value="all1" -->&nbsp;
					<select id="selStartTime" name="selStartTime" onchange="setTime();">
						<option value="0">시간선택</option>
						<option value="8">오전 08</option>
						<option value="9">오전 09</option>
						<option value="10">오전 10</option>
						<option value="11">오전 11</option>
						<option value="12">오전 12</option>
						<option value="13">오후 01</option>
						<option value="14">오후 02</option>
						<option value="15">오후 03</option>
						<option value="16">오후 04</option>
					</select>
					~
					<select id="selEndTime" name="selEndTime" onchange="setTime();">
						<option value="0">시간선택</option>
						<option value="9">오전 09</option>
						<option value="10">오전 10</option>
						<option value="11">오전 11</option>
						<option value="12">오전 12</option>
						<option value="13">오후 01</option>
						<option value="14">오후 02</option>
						<option value="15">오후 03</option>
						<option value="16">오후 04</option>
						<option value="17">오후 05</option>
					</select>
					<input type="hidden" name="starttime" id="starttime"  class="input02 w40"/>
					<input type="hidden" name="endtime" id="endtime"  class="input02 w40"/>
				</td>
				<td><input type="text" size="2" name="time_sum" id="time_sum"  style="border:0; font-weight:bold;" value="" disabled="disabled" />시간</td>
			</tr>
			<tr>
				<td> 합계 </td>
				<td colspan="2" > <input type="text" size="10" name="price_sum" id="price_sum"  style="border:0; font-weight:bold;" value="" disabled="disabled" />원 </td>
			</tr>	
	<% } else if(place.equals("3")) { %>
			<tr>
				<th class="bl0"  rowspan="3">사용시설</th>
				<td rowspan="3">강당</td>
				<th rowspan="3">사용시간</th>
				<td><!-- input type="radio" name="time" id="time"  value="am0" -->오전(9시~13시)</td>
				<td>70,000</td>
			</tr>
			<tr>
				<td><!-- input type="radio" name="time"  id="time"  value="pm0" -->오후(13시~17시)</td>
				<td>70,000원</td>
			</tr>
			<tr>
				<td><!-- input type="radio" name="time"  id="time"  value="all0" -->종일(9시~17시)</td>
				<td>140,000원</td>
			</tr>
			
			<!-- 사용금액 합계 -->
			<input type="text" size="10" name="price_sum"  id="price_sum" style="border:0; display:none;" value="" disabled="disabled"  />
	<% } else if(place.equals("4")) { %>
			<tr>
				<th class="bl0"  rowspan="3">사용시설</th>
				<td rowspan="3">체육관</td>
				<th rowspan="3">사용시간</th>
				<td><!-- input type="radio" name="time" id="time"  value="am0" -->오전(9시~13시)</td>
				<td>60,000</td>
			</tr>
			<tr>
				<td><!-- input type="radio" name="time"  id="time"  value="pm0" -->오후(13시~17시)</td>
				<td>60,000원</td>
			</tr>
			<tr>
				<td><!-- input type="radio" name="time"  id="time"  value="all0" -->종일(9시~17시)</td>
				<td>120,000원</td>
			</tr>
			
			<!-- 사용금액 합계 -->
			<input type="text" size="10" name="price_sum"  id="price_sum" style="border:0; display:none;" value="" disabled="disabled"  />
	<% } else if(place.equals("6")) { %>
			<tr>
				<th class="bl0"  rowspan="3">사용시설</th>
				<td rowspan="3">강의실</td>
				<th rowspan="3">강의실자석</th>
				<td>50석</td>
				<td><input type="text" name="room50" id="room50"  class="input02 w40"/>실  예약</td>
			</tr>
			<tr>
				<td>100석</td>
				<td><input type="text" name="room100" id="room100"  class="input02 w40"/>실  예약</td>
			</tr>
			<tr>
				<td>사용시간</td>
				<td><input type="text" name="starttime" id="starttime"  class="input02 w40"/>~<input type="text" name="endtime" id="endtime"  class="input02 w40"/>시</td>
			</tr>
			
			<!-- 사용금액 합계 -->
			<input type="text" size="10" name="price_sum"  id="price_sum" style="border:0; display:none;" value="" disabled="disabled"  />
	<% } else if(place.equals("7")) { %>
			<tr>
				<th class="bl0"  rowspan="3">사용시설</th>
				<td rowspan="3">생활관</td>
				<th rowspan="3">생활관자석</th>
				<td>남자 인원</td>
				<td><input type="text" name="sexm" id="sexm"  class="input02 w40"/> 명 숙박</td>
			</tr>
			<tr>
				<td>여자 인원</td>
				<td><input type="text" name="sexf" id="sexf"  class="input02 w40"/> 명 숙박</td>
			</tr>
			<tr>
				<td>숙박기간</td>
				<td>
				<input type="text" name="startdate" id="startdate"  class="input02 w80" readonly/>
				<a href = "javascript:void(0)" onclick="fnPopupCalendar('pform', 'startdate');">
					<img src = "/images/icon_calendar.gif" style="cousor:hand;" border = 0 align="absmiddle">
				</a><br />
				 ~ <input type="text" name="enddate" id="enddate"  class="input02 w80" readonly/>
				<a href = "javascript:void(0)" onclick="fnPopupCalendar('pform', 'enddate');">
					<img src = "/images/icon_calendar.gif" style="cousor:hand;" border = 0 align="absmiddle">
				</a> 예정
				 </td>

			</tr>
			
			<!-- 사용금액 합계 -->
			<input type="text" size="10" name="price_sum"  id="price_sum" style="border:0; display:none;" value="" disabled="disabled"  />
	<% } %>
			<!--
			<tr>
				<td  rowspan="3">테니스장2</td>
				<th  rowspan="3">사용시간</th>
				<td><input type="radio" name="time"  value="am2">오전(9시~13시)</td>
				<td>40,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="pm2">오후</td>
				<td>40,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="all2">종일(9시~17시)</td>
				<td>80,000원</td>
			</tr>
			-->
			<tr>
				<td  class="bl0"  colspan="5" align="center">
					인천광역시인재개발원시설사용료징수조례 제4조의 규정에 의거<br />
					위와 같이 사용허가를 신청합니다.<br />
					<div class="h5"></div>
						<%=request.getParameter("year") %>년 <%=request.getParameter("month") %>월  <%=request.getParameter("day")%>일 
						<br/>
					<div class="h5"></div>
					<strong>인천광역시 인재개발원장 귀하</strong>
				</td>
			</tr>
		
			</table>	
			<!-- //view --> 
            <!-- //title -->
			<div class="h9"></div>
			<!-- button -->
			<div class="btnRbtt">			
				<img id="submitbutton" src="../../../images/skin1/button/btn_request01.gif" alt="신청" onClick="javascript:submitaction_();"/>
				<img src="../../../images/skin1/button/btn_cancel02.gif" alt="취소" onClick="javascript:history.back();"/>
			</div>
			<!-- //button -->
</form>
			<div class="h80"></div>

			<!-- title --> 
		</div>
		<!-- //content e ===================== -->
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>