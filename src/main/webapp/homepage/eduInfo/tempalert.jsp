<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%
	//DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	String mode = (String)request.getAttribute("mode");
%>
<html>
<head>
<script type="text/javascript" language="javascript">
	function init() {
		//alert('중복되었습니다. 한달에 두번 예약 불가능 합니다.');
		var mode = "<%= mode %>";
		
		switch(mode){
	    	case "duplicatereservation":
	    		alert("신청자가 중복되었습니다. 월 1회만 신청 가능합니다.");
	    		history.back();
	    		break;
	    		
	    	case "alreadyExist":
	    		alert("이미 예약 되었습니다. 다른 날짜나 시간대에 예약해 주세요. ");
	    		location.href = "introduce.do?mode=reservation";
	    		break;

	    	case "alreadyExistPop":
	    		alert("이미 예약 되었습니다. 다른 날짜나 시간대에 예약해 주세요. ");
	    		opener.document.location.href= "introduce.do?mode=reservation";
			    self.close();
	    		break;
	    		
		    case "resvReject":
			    alert("현재는 신청을 받고 있지 않습니다.\n관리자에게 문의해주세요.");
			    //location.href = "/";
			    //return;
			    history.back();
			    break;

		    case "resvRejectPop":
			    alert("현재는 신청을 받고 있지 않습니다.\n관리자에게 문의해주세요.");
			    opener.document.location.href= "/";
			    self.close();
			    break;
		}
	}
</script>
</head>
<body onload="init();">
</body>
</html>