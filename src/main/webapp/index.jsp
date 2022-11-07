<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="ut.lib.util.* "%>

<%-- <% --%>
// 	String rtn = Util.getValue(request.getParameter("rtn"),"");	
// 	//response.sendRedirect("/homepage/index.do?mode=homepage");
<%-- %> --%>

<script type="text/javascript">
alert("index.jsp 입니다.");
<!--
<%-- 	if("<%=rtn%>" != ""){ --%>
// 		alert("세션이 종료되었습니다. 로그인을 다시 하십시요.");		
// 	}
	if (location.hostname == "loti.incheon.go.kr"){
		alert("인천광역시 인재개발원의 도메인이 http://hrd.incheon.go.kr로 변경되었습니다. \n\n 이후에는 상기 도메인으로 접속 바랍니다.");
		location.href="http://hrd.incheon.go.kr/homepage/index.do?mode=homepage";
	} else {
		location.href="/homepage/index.do?mode=homepage";
	}
	// location.href="/homepage/index.do?mode=homepage";
//-->
</script>


