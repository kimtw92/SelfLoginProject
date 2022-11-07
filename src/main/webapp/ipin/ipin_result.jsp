<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>

<%
	/********************************************************************************************************************************************
		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 결과 페이지
	*********************************************************************************************************************************************/
	
	String sSiteCode				= "EL60";			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
	String sSitePw					= "hrd7673hrd!!";			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드) 
	
		
		// 사용자 정보 및 CP 요청번호를 암호화한 데이타입니다.
    String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");
    
    // CP 요청번호 : ipin_main.jsp 에서 세션 처리한 데이타
    String sCPRequest = (String)session.getAttribute("CPREQUEST");

    
    // 객체 생성
	IPINClient pClient = new IPINClient();
	
	
	/*
	┌ 복호화 함수 설명  ──────────────────────────────────────────────────────────
		Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
		
		fnResponse 함수는 결과 데이타를 복호화 하는 함수이며,
		'sCPRequest'값을 추가로 보내시면 CP요청번호 일치여부도 확인하는 함수입니다. (세션에 넣은 sCPRequest 데이타로 검증)
		
		따라서 귀사에서 원하는 함수로 이용하시기 바랍니다.
	└────────────────────────────────────────────────────────────────────
	*/
	int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
	//int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData, sCPRequest);
	
	String sRtnMsg				= "";							// 처리결과 메세지
	String sVNumber				= pClient.getVNumber();			// 가상주민번호 (13자리이며, 숫자 또는 문자 포함)
	String sName				= pClient.getName();			// 이름
	String sDupInfo				= pClient.getDupInfo();			// 중복가입 확인값 (DI - 64 byte 고유값)
	String sAgeCode				= pClient.getAgeCode();			// 연령대 코드 (개발 가이드 참조)
	String sGenderCode			= pClient.getGenderCode();		// 성별 코드 (개발 가이드 참조)
	String sBirthDate			= pClient.getBirthDate();		// 생년월일 (YYYYMMDD)
	String sNationalInfo		= pClient.getNationalInfo();	// 내/외국인 정보 (개발 가이드 참조)
	String sCPRequestNum		= pClient.getCPRequestNO();		// CP 요청번호
			
	// Method 결과값에 따른 처리사항
	if (iRtn == 1)
	{
		/*
			다음과 같이 사용자 정보를 추출할 수 있습니다.
			사용자에게 보여주는 정보는, '이름' 데이타만 노출 가능합니다.
		
			사용자 정보를 다른 페이지에서 이용하실 경우에는
			보안을 위하여 암호화 데이타(sResponseData)를 통신하여 복호화 후 이용하실것을 권장합니다. (현재 페이지와 같은 처리방식)
			
			만약, 복호화된 정보를 통신해야 하는 경우엔 데이타가 유출되지 않도록 주의해 주세요. (세션처리 권장)
			form 태그의 hidden 처리는 데이타 유출 위험이 높으므로 권장하지 않습니다.
		*/
		
		// 사용자 인증정보에 대한 변수
		
		/* out.println("가상주민번호 : " + sVNumber + "<BR>");
		out.println("이름 : " + sName + "<BR>");
		out.println("중복가입 확인값 (DI) : " + sDupInfo + "<BR>");
		out.println("연령대 코드 : " + sAgeCode + "<BR>");
		out.println("성별 코드 : " + sGenderCode + "<BR>");
		out.println("생년월일 : " + sBirthDate + "<BR>");
		out.println("내/외국인 정보 : " + sNationalInfo + "<BR>");
		out.println("CP 요청번호 : " + sCPRequestNum + "<BR>");
		out.println("***** 복호화 된 정보가 정상인지 확인해 주시기 바랍니다.<BR><BR><BR><BR>"); */
		
		sRtnMsg = "정상 처리되었습니다.";
		
	}
	else if (iRtn == -1 || iRtn == -4)
	{
		sRtnMsg =	"iRtn 값, 서버 환경정보를 정확히 확인하여 주시기 바랍니다.";
	}
	else if (iRtn == -6)
	{
		sRtnMsg =	"당사는 한글 charset 정보를 euc-kr 로 처리하고 있으니, euc-kr 에 대해서 허용해 주시기 바랍니다.<BR>" +
					"한글 charset 정보가 명확하다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
	}
	else if (iRtn == -9)
	{
		sRtnMsg = "입력값 오류 : fnResponse 함수 처리시, 필요한 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
	}
	else if (iRtn == -12)
	{
		sRtnMsg = "CP 비밀번호 불일치 : IPIN 서비스 사이트 패스워드를 확인해 주시기 바랍니다.";
	}
	else if (iRtn == -13)
	{
		sRtnMsg = "CP 요청번호 불일치 : 세션에 넣은 sCPRequest 데이타를 확인해 주시기 바랍니다.";
	}
	else
	{
		sRtnMsg = "iRtn 값 확인 후, NICE평가정보 전산 담당자에게 문의해 주세요.";
	}

%>
<%!
public String requestReplace (String paramValue, String gubun) {
        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }
%>

<html>
<head>
<title>NICE평가정보 가상주민번호 서비스</title>
<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script type="text/javascript">
function dupinfoCheck() {
	var dupinfo = document.getElementById("dupinfo").value;
	var url="/homepage/support.do";
	var pars = "mode=dupinfoCheckAjax2&dupinfo="+dupinfo;		
	var request = new Ajax.Request (
		url,
		{
			method:"post",
			parameters : pars,
			onSuccess : successProcess,
			onFailure : failProcess
		}	
	);
}
function successProcess(request) {
	var response = request.responseText;
	if(response == 'YES') {
		alert('실명확인되었습니다.');
		document.authform.action = "/homepage/join.do";
		document.authform.target = "mother";
		document.authform.submit();	
        window.close();
	}else if(response == 'REJOIN') {
		alert("이미 가입되어 있습니다.");
		window.close();
	}else {
		alert("실명확인이 실패하였습니다.");
		window.close();
	}
}
function failProcess() {
	alert("에러가 발생하였습니다.");
}
</script>
</head>
<body onload="dupinfoCheck()";>
<form method="post" name="authform">
	<input type="hidden" id="mode" name="mode" value="joinstep3"/>
	<input type="hidden" id="regtype" name="regtype" value="2"/>
	<input type="hidden" id="username" name="username" value="<%=sName%>"/>
	<input type="hidden" id="dupinfo" name="dupinfo" size="70" value="<%= sDupInfo %>"/>
	<input type="hidden" id="realname" name="realname" value="<%=sName%>"/>
	<input type="hidden" id="sex" name="sex" value="<%= "1".equals(sGenderCode) ? "1":"0" %>"/>
	<input type="hidden" id="age" name="age" value=""/>
	<input type="hidden" id="birthdate" name="birthdate" value="<%= sBirthDate %>"/>
	<input type="hidden" id="nationalinfo" name="nationalinfo" value="<%= sNationalInfo %>"/>
	<input type="hidden" id="authinfo" name="authinfo" value=""/>
</form>
</body>
</html>