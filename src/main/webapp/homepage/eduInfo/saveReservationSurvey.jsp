<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Integer result = (Integer)request.getAttribute("result");
%>	

<script type="text/javascript" language="javascript">
	function init() {
		var result = <%=result%>;
		if(result >= 1) {
			alert('설문이 완료되었습니다.\n 감사합니다.');
		} else {
			alert('오류가 발생 했습니다.\n 관리자에게 문의해주세요.');
		}
		var form = document.pform;

		form.action = "introduce.do";
		form.submit();
	}
</script>

<body onLoad="init();">
<form name="pform" method="POST">
	<input type="hidden" name="mode" value="reservationSurvey" />
</form>
</body>