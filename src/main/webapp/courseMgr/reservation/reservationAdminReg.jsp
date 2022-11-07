<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<%
	String year = (String)request.getAttribute("year");
	String month = (String)request.getAttribute("month");
	String day = (String)request.getAttribute("day");
	String gubun = (String)request.getAttribute("gubun");
	String place = (String)request.getAttribute("place");
	
	String radioCheck= gubun+place;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천사이버교육센터에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<script>
	var flag = false;
	
	function init(){
		
		var form=document.modifyForm;
		for(var i=0;i<form.elements.length;i++){
			if(form.elements[i].type=='radio'){
				if(form.elements[i].value=='<%=radioCheck%>'){
					form.elements[i].checked=true;
				}
			}
		}
	}

	function go_regist(){
		var form = document.modifyForm;

		if(flag) {
			alert("처리중입니다.");
			return;
		}

		jumin = $("jumin").value;
		resvname = $("resvname").value;
		groupname = $("groupname").value;
		tel1 = $("tel1").value;
		tel2 = $("tel2").value;
		tel3 = $("tel3").value;
		
		
		if(resvname =="") {
			alert("예약자 이름을  입력해 주세요.");
			document.getElementById("resvname").focus();
			return;
		}

<% if("6".equals(request.getParameter("place"))) { %>
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
	<% if("7".equals(request.getParameter("place"))) { %>
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
		
		document.modifyForm.action = "/courseMgr/reservation.do";
		flag = true;
		document.modifyForm.submit();
		opener.location.reload();
		self.close();
	}

	function changePlace(value){
		var gubun = value.substring(0,2);
		var place = value.substring(2);

		document.getElementById("gubun").value=gubun;
		document.getElementById("place").value=place;
	}

	function setTime() {
		var objSelStartTime = document.getElementById("selStartTime");
		var startTime = objSelStartTime.options[objSelStartTime.selectedIndex].value;

		var objSelEndTime = document.getElementById("selEndTime");
		var endTime = objSelEndTime.options[objSelEndTime.selectedIndex].value;
		var totalTime = endTime - startTime;
		var sum	 	 = 0;
		var form = document.modifyForm;
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
</script>
</head>
<body onload="javascript:init();">
<form name="modifyForm">
<input type="hidden" value="adminReg" name="mode"/>
<input type="hidden" name="year" value='<%=request.getParameter("year") %>'/>
<input type="hidden" name="month" value='<%=request.getParameter("month") %>'/>
<input type="hidden" name="day" value='<%=request.getParameter("day") %>'/>
<input type="hidden" name="gubun" value='<%=request.getParameter("gubun") %>'/>
<input type="hidden" name="place" value='<%=request.getParameter("place") %>'/>
<input type="hidden" id="jumin" name="jumin" value="9999999999999" />
<div class="top">
	<h1 class="h1">시설 사용 허가 신청서 등록(관리자)<!--span class="txt_gray">2008-01</span--></h1>
</div>
<div class="contents">

	<div class="h10"></div>
			<table class="dataH05">
			<colgroup>
			<col width="*" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
			</colgroup>
			<tr>
			<td rowspan="2" class="bg01">신청자<br />기관(단체)명</td>
			<td rowspan="2" class="left_pad"><input type="text" value="관리자" id="groupname" name="groupname" class="input01 w159" /></td>
			<td class="bg01">대표자 성명</td>
			<td colspan="2" class="left_pad"><input type="text" value="관리자" id="resvname" name="resvname" class="input01 w69" /></td>
			</tr>
			<tr>
			<td class="bg01">주민등록번호</td>
			<td colspan="2" class="left_pad">
                    <input type="password" value="9999999999999" name="jum" class="input01 w100" disabled/>
			</td>
			</tr>
			<tr>
			<td class="bg01">신청자주소</td>
			<td class="left_pad"><input type="text" value="" name="homeAddr" class="input01 w165" /></td>
			<td class="bg01">연락처<br />(핸드폰)</td>
			<td colspan="2" class="left_pad">
			<input type="text" value="" id="tel1" name="tel1" class="input01 w40" maxlength="3"/> -
			<input type="text" value="" id="tel2" name="tel2" class="input01 w40" maxlength="4" /> -
			<input type="text" value="" id="tel3" name="tel3" class="input01 w40" maxlength="4" />
			</td>
			</tr>
			<tr>
			<td class="bg01">사용목적</td>
			<td colspan="4" class="left_pad">
			<input type="text" value="" name="content" class="input01 w372" />
			</td>
			</tr>
			<tr>
				<td class="bg01">사용인원</td>
				<td class="left_pad">총 <input type="text" value="" name="person" class="input01 w40"  maxlength="3"/> 명</td>
				<td class="bg01">사용일</td>
				<td colspan="2">
					<input type="text" value="<%=year%>" name="year" class="input01 w40"  maxlength="4"/> 년 
					<input type="text" value="<%=month %>" name="month" class="input01 w40"  maxlength="2"/> 월 
					<input type="text" value="<%=day %>" name="day" class="input01 w40"  maxlength="2"/> 일
				</td>
			</tr>
            <%
                if("0".equals(request.getParameter("place"))) {
            %>
			<tr>
				<td class="bg01"  rowspan="18">사용시설</td>
				<td rowspan="3">운동장</td>
				<td  class="bg01"  rowspan="3">사용시간</td>
				<td><input type="radio" name="time" value="am0" onclick="javascript:changePlace(this.value)"/>오전(9시~13시)</td>
				<td>100,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="pm0" onclick="javascript:changePlace(this.value)"/>오후(13시~17시)</td>
				<td>100,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="all0" onclick="javascript:changePlace(this.value)"/>종일(9시~17시)</td>
				<td>200,000원</td>
			</tr>
            <%
                } else if("1".equals(request.getParameter("place"))) {
            %>

			<tr>
                <td class="bg01"  rowspan="18">사용시설</td>
				<td  rowspan="3">테니스장</td>
				<td class="bg01" rowspan="3">사용시간</td>
				<td><input type="radio" name="time" id="time"  value="am1" checked="checked" onclick="setTime();">1면</td>
				<td>5,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  id="time"  value="pm1" onclick="setTime();">2면</td>
				<td>10,000원</td>
			</tr>
			<tr>
				<td><!-- input type="radio" name="time"  value="all1" onclick="javascript:changePlace(this.value)"/>종일(9시~17시) -->&nbsp;
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
				<tr>
					<td colspan="5">
						<input type="text" size="10" name="price_sum"  id="price_sum" style="border:0; " value="" disabled="disabled"  />
						<input type="hidden" name="sum" id="sum" value="" alt="사용요금 합계 가격">
					</td>
				</tr>
			</tr>
            <%
                } else if("3".equals(request.getParameter("place"))) {
            %>
			<!-- tr>
				<td  rowspan="3">테니스장2</td>
				<td class="bg01" rowspan="3">사용시간</thd>
				<td><input type="radio" name="time"  value="am2" onclick="javascript:changePlace(this.value)"/>오전(9시~13시)</td>
				<td>20,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="pm2" onclick="javascript:changePlace(this.value)"/>오후(13시~17시)</td>
				<td>20,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="all2" onclick="javascript:changePlace(this.value)"/>종일(9시~17시)</td>
				<td>40,000원</td>
			</tr -->	
			
			<tr>
                <td class="bg01"  rowspan="18">사용시설</td>
				<td rowspan="3">강당</td>
				<td  class="bg01"  rowspan="3">사용시간</td>
				<td><input type="radio" name="time" value="am3" onclick="javascript:changePlace(this.value)"/>오전(9시~13시)</td>
				<td>70,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="pm3" onclick="javascript:changePlace(this.value)"/>오후(13시~17시)</td>
				<td>70,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="all3" onclick="javascript:changePlace(this.value)"/>종일(9시~17시)</td>
				<td>140,000원</td>
			</tr>
            <% } else if("4".equals(request.getParameter("place"))) { %>
			<tr>
                <td class="bg01"  rowspan="18">사용시설</td>
				<td rowspan="3">체육관</td>
				<td  class="bg01"  rowspan="3">사용시간</td>
				<td><input type="radio" name="time" value="am4" onclick="javascript:changePlace(this.value)"/>오전(9시~13시)</td>
				<td>60,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="pm4" onclick="javascript:changePlace(this.value)"/>오후(13시~17시)</td>
				<td>60,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="all4" onclick="javascript:changePlace(this.value)"/>종일(9시~17시)</td>
				<td>120,000원</td>
            </tr>
 <% } else if("6".equals(request.getParameter("place"))) { %>
			<tr>
                <td class="bg01"  rowspan="18">사용시설</td>
				<td rowspan="3">강의실</td>
				<td  class="bg01"  rowspan="3">강의실자석</td>
				<td>50석</td>
				<td><input type="text" name="room50" id="room50"  class="input02 w40"/>실  예약</td>
			</tr>
			<tr>
				<td>100석</td>
				<td><input type="text" name="room100" id="room100"  class="input02 w40"/>실  예약</td>
			</tr>
			<tr>
				<td><input type="hidden" id="time" name="time"  value="all6" >사용시간</td>
				<td><input type="text" name="starttime" id="starttime"  class="input02 w40"/>~<input type="text" name="endtime" id="endtime"  class="input02 w40"/>시</td>
            </tr>
 <% } else if("7".equals(request.getParameter("place"))) { %>
			<tr>
                <td class="bg01"  rowspan="18">사용시설</td>
				<td rowspan="3">생활관</td>
				<td  class="bg01"  rowspan="3">생활관자석</td>
				<td>남자 인원</td>
				<td><input type="text" name="sexm" id="sexm"  class="input02 w40"/> 명 숙박</td>
			</tr>
			<tr>
				<td>여자 인원</td>
				<td><input type="text" name="sexf" id="sexf"  class="input02 w40"/> 명 숙박</td>
			</tr>
			<tr>
				<td><input type="hidden" id="time" name="time"  value="all7">숙박기간</td>
				<td><input type="text" name="startdate" id="startdate"  class="input02 w80" readonly/>
				<a href = "javascript:void(0)" onclick="fnPopupCalendar('2015-12-07', 'startdate');">
					<img src = "/images/icon_calendar.gif" style="cousor:hand;" border = 0 align="absmiddle">
				</a><br />
				 ~ <input type="text" name="enddate" id="enddate"  class="input02 w80" readonly/>
				<a href = "javascript:void(0)" onclick="fnPopupCalendar('pform', 'enddate');">
					<img src = "/images/icon_calendar.gif" style="cousor:hand;" border = 0 align="absmiddle">
				</a> 예정
               </td>
            </tr>
<% } %>
            </table>
	<!-- button -->
	<div class="btnC" style="width:575px;">
		<a href="#" onclick="javascript:go_regist()"><img src="../../../images/skin1/button/btn_revision.gif" alt="등록" /></a>	
		<a href="#" onclick="javascript:self.close()"><img src="../../../images/skin1/button/btn_cancel01.gif" alt="취소" /></a>	
	</div>	
	<!-- //button -->
</div>
</form>

</body>
</html>