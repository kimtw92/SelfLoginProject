<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<%
	DataMap listMap = (DataMap)request.getAttribute("RESERVATION");
	
	String radioCheck= listMap.getString("taRentTime",0)+listMap.getString("taReqSection",0);
	String phone=listMap.getString("taReqPhone",0);
	
	if(phone == null || phone.equals("")|| phone.equals("--")){
		phone="000-0000-0000";
	}
	String[] phoneArray = phone.split("-");	
	String date			= listMap.getString("taRentDate",0);
	String[] dateArray  = date.split("-");
	
	// 사용 승인번호
	String agrno = "";
	if(request.getParameter("agrno").equals(null) || request.getParameter("agrno").equals(""))	agrno = "";
	else	agrno = request.getParameter("agrno");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천사이버교육센터에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
<script>

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

	function go_modify(){
		var result = confirm("수정하시겠습니까?");

		if(result){
			
			var iframe = document.createElement("iframe");
			iframe.name = "hiddenFrame";
			iframe.width = 0;
			iframe.height = 0;
			document.body.appendChild(iframe);
			
			var par = opener;
			var se = self;
			
			function hiddenFrameOnload(){
				par.location.reload();
				se.close();
			}
			
			if(iframe.attachEvent){
				// IE에서 사용되는 방식
				iframe.attachEvent("onload", hiddenFrameOnload);
			}else{
				iframe.onload = hiddenFrameOnload;
			}
			
			var form=document.modifyForm;
			form.action="/courseMgr/reservation.do";
			form.target = "hiddenFrame";
			form.submit();
			
		}
	}

	function changePlace(value){
		var gubun = value.substring(0,2);
		var place = value.substring(2);

		document.getElementById("gubun").value=gubun;
		document.getElementById("place").value=place;
	}
</script>
</head>
<body onload="javascript:init();">
<form name="modifyForm">
<input type="hidden" value="modifyAction" name="mode"/>
<input type="hidden" value="<%=listMap.getString("taReqSection",0) %>" name="place" id="place"/>
<input type="hidden" value="<%=listMap.getString("taRentTime",0) %>" name="gubun" id="gubun"/>
<input type="hidden" value="<%=listMap.getString("taPk",0) %>" name="taPk"/>

<div class="top">
	<!-- <h1 class="h1">시설 사용 허가 신청서 수정<span class="txt_gray">2008-01</span></h1> -->
	<h1 style="text-align:center; font-family:Batang,Verdana;">시설 사용 신청서</h1>
</div>
<div class="contents">

	<div class="h10"></div>
	
			<table class="dataH05" style="font-size:9pt;">
			<colgroup>
			<col width="*" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
			</colgroup>
			<tr>
			<td class="bg01">사용승인번호</td>
			<td class="left_pad">
		<% if(listMap.getString("taAgreement", 0).equals("N")) { %>
				<input type="text" name="agrno" maxlength="3" class="input01 w159" style="display:none;" />
		<% } else if(listMap.getString("taAgreement", 0).equals("Y")) { %>
				<%= listMap.getString("taRentDate", 0).substring(2, 2) %>
				<input type="text" name="agrno" maxlength="3" class="input01 w159" value="<%= listMap.getString("taAgrNo", 0) %>" />
		<% } %>
			</td>
			<td class="bg01">대표자 성명</td>
			<td colspan="2" class="left_pad"><input type="text" value="<%=listMap.getString("taReqName",0) %>" name="resvname" class="input01 w69" /></td>
			</tr>
			<tr>
			<td class="bg01">신청자<br />기관(단체)명</td>
			<td class="left_pad"><input type="text" value="<%=listMap.getString("taReqGroup",0) %>" name="groupname" class="input01 w159" /></td>
			<td class="bg01">주민등록번호</td>
			<td colspan="2" class="left_pad">
				<%= listMap.getString("taReqSerialNo",0).substring(0, 6) %> - <%= listMap.getString("taReqSerialNo", 0).substring(6, 13) %>
            	<!-- <input type="password" value="<%//=listMap.getString("taReqSerialNo",0) %>" name="jumin" class="input01 w100" disabled/> -->
			</td>
			</tr>
			<tr>
			<td class="bg01">신청자주소</td>
			<td class="left_pad"><input type="text" value="<%=listMap.getString("taReqAddress",0) %>" name="homeAddr" class="input01 w165" /></td>
			<td class="bg01">연락처<br />(핸드폰)</td>
			<td colspan="2" class="left_pad">
			<input type="text" value="<%=phoneArray[0] %>" name="tel1" class="input01 w40" maxlength="3"/> -
			<input type="text" value="<%=phoneArray[1] %>" name="tel2" class="input01 w40" maxlength="4" /> -
			<input type="text" value="<%=phoneArray[2] %>" name="tel3" class="input01 w40" maxlength="4" />
			</td>
			</tr>
			<tr>
			<td class="bg01">사용목적</td>
			<td colspan="4" class="left_pad">
			<input type="text" value="<%=listMap.getString("taRentIntention",0) %>" name="content" class="input01 w372" />
			</td>
			</tr>
			<tr>
				<td class="bg01">사용인원</td>
				<td class="left_pad">총 <input type="text" value="<%=listMap.getString("taPerson",0) %>" name="person" class="input01 w40"  maxlength="3"/> 명</td>
				<td class="bg01">사용일</td>
				<td colspan="2">
					<input type="text" value="<%=dateArray[0] %>" name="year" class="input01 w40"  maxlength="4"/> 년 
					<input type="text" value="<%=dateArray[1] %>" name="month" class="input01 w40"  maxlength="2"/> 월 
					<input type="text" value="<%=dateArray[2] %>" name="day" class="input01 w40"  maxlength="2"/> 일
				</td>
			</tr>
			<tr>
				<td class="bg01"  rowspan="18">사용시설</td>
				<td rowspan="3">잔디구장</td>
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
			<tr>
				<td  rowspan="3">테니스장</td>
				<td class="bg01" rowspan="3">사용시간</td>
				<td><input type="radio" name="time"  value="am1" onclick="javascript:changePlace(this.value)"/>오전(9시~13시)</td>
				<td>20,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="pm1" onclick="javascript:changePlace(this.value)"/>오후(13시~17시)</td>
				<td>20,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="all1" onclick="javascript:changePlace(this.value)"/>종일(9시~17시)</td>
				<td>40,000원</td>
			</tr>
			<tr>
				<td  rowspan="3">체육관</td>
				<td class="bg01" rowspan="3">사용시간</td>
				<td><input type="radio" name="time"  value="am4" onclick="javascript:changePlace(this.value)"/>오전(9시~13시)</td>
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
			<tr>
				<td  rowspan="3">강당</td>
				<td class="bg01" rowspan="3">사용시간</td>
				<td><input type="radio" name="time"  value="am3" onclick="javascript:changePlace(this.value)"/>오전(9시~13시)</td>
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
			<tr>
				<td  rowspan="3">강의실</td>
				<td class="bg01" rowspan="3">사용시간</td>
				<td><input type="radio" name="time"  value="am6" onclick="javascript:changePlace(this.value)"/>오전(9시~13시)</td>
				<td>30,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="pm6" onclick="javascript:changePlace(this.value)"/>오후(13시~17시)</td>
				<td>30,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="all6" onclick="javascript:changePlace(this.value)"/>종일(9시~17시)</td>
				<td>60,000원</td>
			</tr>	
			<tr>
				<td  rowspan="3">생활관</td>
				<td class="bg01" rowspan="3">사용시간</td>
				<td><input type="radio" name="time"  value="am7" onclick="javascript:changePlace(this.value)"/>오전(9시~13시)</td>
				<td></td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="pm7" onclick="javascript:changePlace(this.value)"/>오후(13시~17시)</td>
				<td></td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="all7" onclick="javascript:changePlace(this.value)"/>종일(9시~17시)</td>
				<td>1인 60,000<br/>3,4 인 15,000</td>
			</tr>				
			<!-- 2009.04.01 / 최석호 / 테니스장1, 테니스장2 통합 (테니스장)  
			<tr>
				<td  rowspan="3">테니스장2</td>
				<td class="bg01" rowspan="3">사용시간</thd>
				<td><input type="radio" name="time"  value="am2" onclick="javascript:changePlace(this.value)"/>오전(9시~13시)</td>
				<td>40,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="pm2" onclick="javascript:changePlace(this.value)"/>오후(13시~17시)</td>
				<td>40,000원</td>
			</tr>
			<tr>
				<td><input type="radio" name="time"  value="all2" onclick="javascript:changePlace(this.value)"/>종일(9시~17시)</td>
				<td>80,000원</td>
			</tr>
			-->	
			</table>

	<!-- button -->
	<div class="btnC" style="width:575px;">
		<a href="#" onclick="javascript:go_modify()"><img src="../../../images/skin1/button/btn_revision.gif" alt="수정" /></a>
		<a href="#" onclick="javascript:window.print()"><img src="../../../images/skin1/button/btn_print.gif" alt="인쇄" /></a>		
		<a href="#" onclick="javascript:self.close()"><img src="../../../images/skin1/button/btn_cancel01.gif" alt="취소" /></a>	
	</div>	
	<!-- //button -->
</div>
</form>

</body>
</html>