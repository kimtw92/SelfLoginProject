<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.dreamsecurity.eam.gpki.pmi.*, java.io.*, java.lang.*, java.text.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../common/include/SSOInit.jsp" %>
<%	
	/*********************************************************************************/
	int	   	nRet 				= 0;
	String 	strMyRefere 		= "";

	strMyRefere = request.getHeader("REFERER");
	//nRet = REFERER_CHECKURL_AC.indexOf(strMyRefere);
	//nRet = strMyRefere.indexOf(REFERER_CHECKURL_AC);

	if( nRet < 0 )
	{ 
	%>
	<script LANGUAGE='JavaScript'>
	<!--
		parent.document.errorForm.MSG.value = "[경고-S] 불법 접속자 입니다. 본서비스에 허가되지 않은 불법접속 사용자는 법적 제제를 받습니다.";
		parent.document.errorForm.submit();
	-->	
	</script>
	<%
		return;
	}
	/*********************************************************************************/
	String 	strAppCode		= "";			// 어플리케이션 코드
	String	SERVICE_APP_CODE 	= "SERVICE_APP_CODE";
	
	// 세션에서 어플리케이션 코드 값을 얻는다.
	strAppCode = (String)session.getAttribute(SERVICE_APP_CODE);

	if( strAppCode == null || strAppCode.length() < 1 )
	{ 
%>
		<script LANGUAGE='JavaScript'>
		<!--
			parent.document.errorForm.MSG.value = "APP CODE 정보가 없습니다.";
			parent.document.errorForm.submit();
		-->	
		</script>
<%
		return;
	}
	/*********************************************************************************/
			
	String 		strEnvKey		= "";	// 서버 공개키로 Envelop한 키(MagicPass 생성)
	String 		strNewKey		= "";	// 새로운 세션키
	String 		strEncKey		= "";	// 이전 키로 암호화된 새로운 세션키
	String		strTimeStampNo		= "";	// TimeStamp No

	// MagicPass가 생성한 세션키를 얻는다.
	strEnvKey = request.getParameter("ISK"); 

	if( strEnvKey == null || strEnvKey.length() < 5 )
	{ 
%>

<script LANGUAGE='JavaScript'>
<!--
	parent.document.errorForm.MSG.value = "보안통신을 위한 초기 세션 키 값이 존재하지 않습니다.";
	parent.document.errorForm.submit();
-->	
</script>

<%
		return;
	}

	MGApiJni 	mgApi = new MGApiJni();

	// 서버의 개인키로 복호화
	if( (nRet = mgApi.verifyKey(strEnvKey, MG_CERT_INFO)) != 0 )
	{
%>

<script LANGUAGE='JavaScript'>
<!--
	parent.document.errorForm.MSG.value = "MagicPass가 보내온 초기 세션키의 개인키 복호화에 실패하였습니다. \nERROR CODE : " + "<%=nRet%>";
	parent.document.errorForm.submit();
-->	
</script>

<%
		return;
	}	

	// 개인키 복호화 성공! 새로운 세션키를 생성하여 MagicPass에 전송
	// changeKey시에 TimeStamp를 생성하여 세션키와 함께 MagicPass에 준다
	// 이 값은 로그인 데이터에 함께 포함되어 정보를 비교하도록 한다.
	if( (nRet = mgApi.changeKey(mgApi.getResult())) == 0 )
	{
		strNewKey = new String(mgApi.getClientSessionKey());
		strEncKey = new String(mgApi.getResult());
		strTimeStampNo = new String(mgApi.getTimeStampNo());
	}
	else
	{
%>

<script LANGUAGE='JavaScript'>
<!--
	parent.document.errorForm.MSG.value = "MagicPass와의 키 교환을 위한 서버의 세션키 생성에 실패하였습니다.\nERROR CODE : " + <%=nRet%>";
	parent.document.errorForm.submit();
-->	
</script>

<%
		return;
	}	
	
	// 서버의 키 교환에 성공했으면, 세션키를 세션에 저장한다.
	//ENC_SESSION_KEY
	session.setAttribute("SKey", strNewKey);
	session.setAttribute("TimeStampNo", strTimeStampNo);
%>
	
	
<HTML>
<HEAD>
<TITLE>::: APP LOGIN-SET KEY :::</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
</HEAD>
<BODY>
<form name="connectForm" action="SSOAppLCheck.jsp" method="post">
	<input type="hidden" name="ED">	
</form>
<script LANGUAGE='JavaScript'>
<!--
	var	varRet;

	// 새로운 키로 이전 키를 교환한다.
	//alert("<%=MG_SITE_NAME%>");
	if( !parent.IsLogon("<%=MG_SITE_NAME%>") )
	{
		parent.document.errorForm.MSG.value = "MagicPass[SSO CLIENT]프로그램이 로그인중이 아닙니다. 로그인후 다시 시도하십시오.";
		parent.document.errorForm.submit();
	}
	else
	{
		if( (varRet = parent.ChangeAppKey("<%=MG_SITE_NAME%>", "<%=strAppCode%>", "<%=strEncKey%>")) != 0 )
		{
			parent.document.errorForm.MSG.value = "MagicPass에서 세션키 복호화에 실패하였습니다.\nERROR CODE : " + varRet;
			parent.document.errorForm.submit();
		}
		else
		{
			// 로그인을 위해 사용자 암호화된 토큰 정보를 얻는다.
			if( (varRet = parent.GetToken("<%=MG_SITE_NAME%>", "<%=strAppCode%>")) == 0 )
				varEncrypt = parent.GetResult();
			else
			{
				parent.document.errorForm.MSG.value = "로그온 정보를 얻지 못하였습니다.<br>" + ErrorMsg(varRet);
				parent.document.errorForm.submit();				
			}
			
			if( varEncrypt == null )
			{
				parent.document.errorForm.MSG.value = "로그온 정보를 얻지 못하였습니다.";
				parent.document.errorForm.submit();				
			}
			else
			{
				document.connectForm.ED.value = varEncrypt;
				document.connectForm.submit();
			}
		}
	}
-->	
</script>
</BODY>
</HTML>
