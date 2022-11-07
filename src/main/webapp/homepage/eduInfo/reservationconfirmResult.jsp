<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 
// date		: 2009-03-22
// auth 	: 최형준(수정)
// modDate  : 
// modAuth  : 최석호
%>

<%
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("RESERVATION_CONFIRM_LIST");
	listMap.setNullToInitialize(true);
	System.out.println(listMap);
	String place = listMap.getString("taReqSection",0);
	String rentTime = listMap.getString("taRentTime",0);
	//String seqNo		= listMap.getString("taPk", 0);			// 사용승인번호의 마지막 자리
	String argNo		= listMap.getString("taAgrNo", 0);			// 사용 승인번호
	String sumPrice		= listMap.getString("taRentSum", 0);	// 사용료 합계
	String agreeDate	= listMap.getString("taAgrDate", 0);	// 승인일자
	
	// 승인일자 가공
	String agreeYear	= agreeDate.substring(0, 4);
	String agreeMonth	= agreeDate.substring(4, 6);
	String agreeDay		= agreeDate.substring(6);
		
	String placeName="";
	if(place.equals("0")){
		placeName="잔디구장";
	}else if(place.equals("1")){
		placeName="테니스장1";
	}else if(place.equals("2")){
		placeName="테니스장2";
	}
	
	String time = "";
	if(rentTime.equals("am")){
		time="09:00~13:00";
	}else if(rentTime.equals("pm")){
		time="13:00~17:00";
	}else if(rentTime.equals("all")){
		time="09:00~17:00";
	}
	
	String timevar=rentTime+place;
	String price="";
	
	if(timevar.equals("am0")){
		price="70,000";
	}else if(timevar.equals("pm0")){
		price="70,000";
	}else if(timevar.equals("all0")){
		price="150,000";
	}else if(timevar.equals("am1")){
		price="40,000";
	}else if(timevar.equals("pm1")){
		price="40,000";
	}else if(timevar.equals("all1")){
		price="80,000";
	}else if(timevar.equals("am2")){
		price="40,000";
	}else if(timevar.equals("pm2")){
		price="40,000";
	}else if(timevar.equals("all2")){
		price="80,000";
	}
	
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<html>
	<head>
	<script type="text/javascript" language="javascript">
		
		//btnPrintObj.style.display = "block";
		//alert(btnPrintObj);
		//document.getElementById("btnDiv").style.display = "block";
		//btnPrintObj.style.display = "none";
		
	function go_print() {
		var btnPrintObj = document.getElementById("btnDiv");
		var text		= "";
		btnPrintObj.innerHTML = text;
		//btnPrintObj.style.dsplay = "none;";
		window.print();
	}
	
	</script>
	
	
	<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
	<link rel="stylesheet" type="text/css" href="../../../css/skin1/layout.css" />
	<script type="text/javascript" language="javascript" src="../../../js/skin1/gnbMenu.js"></script>
	
	<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>
	
	</head>
<body>
	<div class="contents">
		<font style="font-family:바탕체; font-size:20px;">
		사용승인번호 제 <%= agreeYear.substring(2) %> - <%= argNo %><br/><br/><br/>
		<center><strong><font style="font-size:30px">인재개발원 시설사용 승인서</font></strong></center><br/><br/><br/>
		
		<strong>신청자(사용자)</strong>
		<UL>
		  <li>성명(개인ㆍ단체) : <%=listMap.getString("taReqGroup",0) %>(<%=listMap.getString("taReqName",0) %>)</li>
		  <li>대표주소 : <%=listMap.getString("taReqAddress",0) %></li>
		  <li>전화번호 : <%=listMap.getString("taReqPhone",0) %></li>
		</UL>
		  <div style="margin-top:15px"></div>
		<strong>승인내용</strong>
		<UL>
		<li>사용시설 : <%=placeName%> </li>        
		<li>사 용 일 : <%=listMap.getString("taRentDate",0) %> <%=time %> </li>
		<li><strong>사 용 료 : 금 <%//=price %><%= sumPrice %>원 <!-- (금삼만원) --></strong></li>
		<li>사용인원 : <%=listMap.getString("taPerson",0) %>명</li> 
		<li>사용목적 : <%=listMap.getString("taRentIntention",0) %></li>
		</UL>
		  <div style="margin-top:15px"></div>
		<strong>승인조건</strong>
		<OL>
			<li> 사용자가 주관하는 행사 및 경기 등으로 인하여 발생한 제반사고에 대하여는 사용자가 책임을 집니다.</li>
			<li> 시설사용 시 사용자의 귀책 사유로 발생한 시설물의 파손 및 훼손에 대하여는 사용자가  원상복구 또는 배상하여야 합니다.</li>
			<li> 다음의 경우에는 사용승인을 취소 또는 정지합니다.
				<ul type="square">
				    <li>시설 내에서 취사, 음주, 가무 및 특정 종교행사, 상행위 등으로 공공질서를 해치고     주변 주거지역에 해를 끼친다고 인정될 때 (주위에 공동주택이 있음)</li>
				    <li>사용승인 이외의 목적으로 사용하거나 승인 조건을 위반 할 때</li>
				    <li><strong>우천 등 기상변화에 따라 시설 유지관리상 필요하다고 인정될 때</strong></li>
				    <li><strong>기타 공공행사 등으로 인하여 원장이 필요하다고 인정될 때</strong></li>
			    </ul>
			</li>
			   
			<li> 시설사용 후에는 청소 등 원상으로 정리정돈 하여야 하며, <strong><u>발생한 쓰레기는      반드시 수거하여 가져가야 합니다.</u></strong></li>
			<li> 천막 등 부가시설이나 부착물에 대하여는 사전 승인을 받아야 합니다.</li>
			<li> 기타사항은 <strong>『인천광역시인재개발원시설사용료징수조례』를 참고하시기 바라며, <u>부과된 사용료를 계좌이체(신한은행:100-024-599151)하여 주시기 바랍니다.</u> </strong> <br/></li>
		</OL>
		
		※ 승인조건을 지키지 않아 물의를 야기시킨 경우 추후 시설사용을 제한합니다. <br/>
		<div style="margin-top:20px"></div>
		<center>
		<%= agreeYear %>년 <%= agreeMonth %>월 <%= agreeDay %>일<br/>
		<div style="margin-top:8px"></div>
		<strong><font style="font-size:20px">인천광역시 인재개발원장</font></strong> 
		</center>
		</font>
	</div>
	
	<!-- button -->
	<div id="btnDiv" style="display:block;" class="btnC">
		<a href="#" onclick="javascript:self.close()"><img id="btn_close" src="../../../images/skin1/button/btn_close01.gif" alt="닫기" /></a>
		<a href="#" onclick="javascript:go_print()"><img id="btn_print" src="../../../images/skin1/button/btn_print.gif" alt="인쇄" /></a>
	</div>	
	<!-- //button -->
</body>			
</html>