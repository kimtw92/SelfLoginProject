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
		parent.document.errorForm.MSG.value = "[���-S] �ҹ� ������ �Դϴ�. �����񽺿� �㰡���� ���� �ҹ����� ����ڴ� ���� ������ �޽��ϴ�.";
		parent.document.errorForm.submit();
	-->	
	</script>
	<%
		return;
	}
	/*********************************************************************************/
	String 	strAppCode		= "";			// ���ø����̼� �ڵ�
	String	SERVICE_APP_CODE 	= "SERVICE_APP_CODE";
	
	// ���ǿ��� ���ø����̼� �ڵ� ���� ��´�.
	strAppCode = (String)session.getAttribute(SERVICE_APP_CODE);

	if( strAppCode == null || strAppCode.length() < 1 )
	{ 
%>
		<script LANGUAGE='JavaScript'>
		<!--
			parent.document.errorForm.MSG.value = "APP CODE ������ �����ϴ�.";
			parent.document.errorForm.submit();
		-->	
		</script>
<%
		return;
	}
	/*********************************************************************************/
			
	String 		strEnvKey		= "";	// ���� ����Ű�� Envelop�� Ű(MagicPass ����)
	String 		strNewKey		= "";	// ���ο� ����Ű
	String 		strEncKey		= "";	// ���� Ű�� ��ȣȭ�� ���ο� ����Ű
	String		strTimeStampNo		= "";	// TimeStamp No

	// MagicPass�� ������ ����Ű�� ��´�.
	strEnvKey = request.getParameter("ISK"); 

	if( strEnvKey == null || strEnvKey.length() < 5 )
	{ 
%>

<script LANGUAGE='JavaScript'>
<!--
	parent.document.errorForm.MSG.value = "��������� ���� �ʱ� ���� Ű ���� �������� �ʽ��ϴ�.";
	parent.document.errorForm.submit();
-->	
</script>

<%
		return;
	}

	MGApiJni 	mgApi = new MGApiJni();

	// ������ ����Ű�� ��ȣȭ
	if( (nRet = mgApi.verifyKey(strEnvKey, MG_CERT_INFO)) != 0 )
	{
%>

<script LANGUAGE='JavaScript'>
<!--
	parent.document.errorForm.MSG.value = "MagicPass�� ������ �ʱ� ����Ű�� ����Ű ��ȣȭ�� �����Ͽ����ϴ�. \nERROR CODE : " + "<%=nRet%>";
	parent.document.errorForm.submit();
-->	
</script>

<%
		return;
	}	

	// ����Ű ��ȣȭ ����! ���ο� ����Ű�� �����Ͽ� MagicPass�� ����
	// changeKey�ÿ� TimeStamp�� �����Ͽ� ����Ű�� �Բ� MagicPass�� �ش�
	// �� ���� �α��� �����Ϳ� �Բ� ���ԵǾ� ������ ���ϵ��� �Ѵ�.
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
	parent.document.errorForm.MSG.value = "MagicPass���� Ű ��ȯ�� ���� ������ ����Ű ������ �����Ͽ����ϴ�.\nERROR CODE : " + <%=nRet%>";
	parent.document.errorForm.submit();
-->	
</script>

<%
		return;
	}	
	
	// ������ Ű ��ȯ�� ����������, ����Ű�� ���ǿ� �����Ѵ�.
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

	// ���ο� Ű�� ���� Ű�� ��ȯ�Ѵ�.
	//alert("<%=MG_SITE_NAME%>");
	if( !parent.IsLogon("<%=MG_SITE_NAME%>") )
	{
		parent.document.errorForm.MSG.value = "MagicPass[SSO CLIENT]���α׷��� �α������� �ƴմϴ�. �α����� �ٽ� �õ��Ͻʽÿ�.";
		parent.document.errorForm.submit();
	}
	else
	{
		if( (varRet = parent.ChangeAppKey("<%=MG_SITE_NAME%>", "<%=strAppCode%>", "<%=strEncKey%>")) != 0 )
		{
			parent.document.errorForm.MSG.value = "MagicPass���� ����Ű ��ȣȭ�� �����Ͽ����ϴ�.\nERROR CODE : " + varRet;
			parent.document.errorForm.submit();
		}
		else
		{
			// �α����� ���� ����� ��ȣȭ�� ��ū ������ ��´�.
			if( (varRet = parent.GetToken("<%=MG_SITE_NAME%>", "<%=strAppCode%>")) == 0 )
				varEncrypt = parent.GetResult();
			else
			{
				parent.document.errorForm.MSG.value = "�α׿� ������ ���� ���Ͽ����ϴ�.<br>" + ErrorMsg(varRet);
				parent.document.errorForm.submit();				
			}
			
			if( varEncrypt == null )
			{
				parent.document.errorForm.MSG.value = "�α׿� ������ ���� ���Ͽ����ϴ�.";
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
