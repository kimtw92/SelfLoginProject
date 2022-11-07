<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 로그인 처리 페이지
// date : 2008-05-13
// auth : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	/* DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA"); */
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String msg = (String)request.getAttribute("RESULT_MSG");
	String url = (String)request.getAttribute("RESULT_URL");
	String state = (String)request.getAttribute("RESULT_STATE");
	System.out.println("==============================");
	System.out.println(url);
	System.out.println(msg);
	System.out.println(state);
	
	String loginDisplayYn = ut.lib.util.Util.getValue((String)session.getAttribute("sess_loginYn"),"N");
	

%>


<script language="JavaScript" type="text/JavaScript">
    var msg = "<%=msg%>";
    
    switch("<%=state%>"){
    	case "ok":    	
    	case "logout":
    		location.href="<%=url%>";
    		break;
        case "id":
            alert(msg);
    		location.href="http://hrd.incheon.go.kr";
    		break;    		
        case "pwd":
            alert(msg);
    		location.href="http://hrd.incheon.go.kr";
    		break;    		
        case "pwdsms":
        	alert(msg);
    		location.href="http://hrd.incheon.go.kr";
    		window.open("/homepage/renewal.do?mode=memberpassword","createId","scrollbars=no,resizable=yes,width=630,height=220,top=200,left=200").focus();
    		break;
        case "damo":
        	alert(msg);
        	location.href="http://localhost:8083/mypage/myclass.do?mode=personalinfomodify";
    		break;    		
        case "oldpwd":        	
        	alert(msg);
        	//window.open("/homepage/renewal.do?mode=newPwd","createId","scrollbars=no,resizable=yes,width=630,height=170,top=200,left=200").focus();
    		//location.href="http://hrd.incheon.go.kr";
    		location.href="/homepage/renewal.do?mode=newPwd";
    		
    		
    		break;	

    	default:
    		alert(msg);
    		location.href="<%=url%>";
    		break;	

    }
    
</script>