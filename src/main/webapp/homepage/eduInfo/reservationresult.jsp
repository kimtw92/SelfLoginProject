<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//prginfo  : 인천 LMS 시설대여를 신청후 관리자에게 SMS 발송 하는 스크립트
//prgnm    : 시설대여신청
//date     : 2008-08-28
//auth 	   : 양정환
//date-mod : 2009-04-06
//auth-mod : 최석호

	//시설대여신청자의 정보를 관리자에게 SMS 발송하기 위한 인자들
	String resvname = (String)request.getAttribute("resvname");		//신청자 이름
	String place 	= (String)request.getAttribute("place");		//신청 시설 (0:잔디구장, 1:테니스장, 3:강당, 4:체육관)
	//String gubun 	= (String)request.getAttribute("gubun");		//신청 시간대 (am, pm)
	//String resv_day = (String)request.getAttribute("resv_day");	//신청 일자 (YYYYMMDD)
%>	

<script type="text/javascript" language="javascript">
	function init() {
		alert('예약처리가 완료되었습니다.\n[시설대여예약확인] 메뉴에서\n예약상황을 확인하실 수 있습니다.');

		//SMS 발송
		var form = document.pform;
		form.resvname.value 	= '<%=resvname%>';
		form.place.value 		= '<%=place%>';

		//alert(document.pform.resvname.value);
		//alert(document.pform.place.value);
		
		form.action = "introduce.do";
		form.submit();
	}
</script>

<body onLoad="init();">
<form name="pform" method="POST">
	<input type="hidden" name="mode" value="sms_rsv_action" />
	
	<!-- sss - TEST =========================== -->
		<!-- <input type="hidden" name="mode" value="reservation" /> -->
	<!-- eee - TEST =========================== -->
	
	<input type="hidden" name="qu" value="rsv_action" />
	<input type="hidden" name="resvname" />
	<input type="hidden" name="place" />
</form>
</body>