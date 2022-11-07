<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.dreamsecurity.eam.gpki.pmi.*, java.io.*, java.lang.*, java.text.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../common/include/SSOInit.jsp" %>
<%
	int 	MG_SUCCESS              = 0;
	int		nRet;
	String	strCert = "";
	/////////////////////////////////////////
	String	MPS_SERVICE_GBN 	= "SERVICEGBN";          
	String	SERVICE_PAGE_URL 	= "SERVICE_PAGE_URL";
	String	SERVICE_APP_CODE 	= "SERVICE_APP_CODE";

	String 	strServiceGBN 		= "";
	String 	strMenuUrl 		= "";
	/////////////////////////////////////////
	try
	{
		strServiceGBN = request.getParameter("SG");
		strMenuUrl = request.getParameter("MenuUrl");
	
		// 서비스 구분자 체크하기
		if( strServiceGBN == null || strServiceGBN.length() < 1 )
		{
%>
<html><head><title>::: LOGIN ERROR :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<body onload="javascript:errorForm.submit();">
<form name="errorForm" action="SSOErrorMsg.jsp" method="post" target="_parent">
	<input type="hidden" name="MSG" value="연결할 사이트 정보가 없습니다. 확인후 접속하십시오.">
</form>
</body>
</html>
<%
			return;
		}
	    	else if( !strServiceGBN.equals(LINK_APP_GBN_CODE) )	
		{
%>
<html><head><title>::: LOGIN ERROR :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<body onload="javascript:errorForm.submit();">
<form name="errorForm" action="SSOErrorMsg.jsp" method="post" target="_parent">
        <input type="hidden" name="MSG" value="서비스구분[<%=strServiceGBN%>] 코드가 일치하지 않습니다. 확인후 접속하십시오.">
</form>
</body>
</html>
<%
             return;
        }
        else
        {
             // Site 이름 세션 넣기
             session.setAttribute(MPS_SERVICE_GBN, strServiceGBN);

             // 서비스 페이지 URL 세션에 넣기
             session.setAttribute(SERVICE_APP_CODE, LINK_APP_CODE);

             if (strMenuUrl != null && strMenuUrl.length() > 0)
                 session.setAttribute(SERVICE_PAGE_URL, strMenuUrl);
             else
                 session.setAttribute(SERVICE_PAGE_URL, LINK_SERVICE_PAGE_URL);
        }

		// 인증서 로드
		MGApiJni mgApi = new MGApiJni();
		if( (nRet = mgApi.getCert(MG_CERT_INFO)) == MG_SUCCESS )
		{
			strCert = new String(mgApi.getResult());
		}
		else
		{
%>
<html><head><title>::: LOGIN ERROR :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<body onload="javascript:errorForm.submit();">
<form name=errorForm method=post action="SSOErrorMsg.jsp">
<input type="hidden" name="MSG" value="데이터 암호화를 위한 서버 인증서 정보 조회에 실패하였습니다.">
</form>
</body></html>
<%
			return;
		}
	}
	catch(Exception e)
	{
	}
%>

<HTML>
<HEAD>
<TITLE>:::: 시도행정정보화 로그인 ::::</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<!--style type="text/css">
    body { overflow:hidden } 
</style-->
<link rel=stylesheet href="../common/css/sso_style.css" type="text/css">
<script LANGUAGE='JavaScript' SRC='../common/js/report.js'></script>
<script LANGUAGE='JavaScript' SRC='../common/js/func.js'></script>
<!-- ACTIVEX MODULE -->
<%=OBJECT_MAGICLOADERX%>
<%=OBJECT_MAGICPASSX%>

</HEAD>

<form name="errorForm" action="SSOErrorMsg.jsp" method="post" target="_parent">
	<input type="hidden" name="MSG">
</form>

<form name="sessionkeyForm" method="post" action="SSOAppSetSKey.jsp" target="ssoiframe">
	<input type="hidden" name="ISK">
</form>
<iframe style="visibility:hidden;" name="ssoiframe" width="1" height="1" frameborder="0" scrolling="no">
</iframe>
<script>
<!--
	if( ProgramCheck("<%=PROGRAM_NAME%>") == false )
	{
		document.errorForm.MSG.value = "MagicPass[SSO CLIENT]프로그램이 로그인중이 아닙니다. 로그인후 다시 시도하십시오.(1)";
		alert(document.errorForm.MSG.value);
		document.sessionkeyForm.submit();
	}
	else if( !IsLogon("<%=MG_SITE_NAME%>") ) 
	{
		document.errorForm.MSG.value = "MagicPass[SSO CLIENT]프로그램이 로그인중이 아닙니다. 로그인후 다시 시도하십시오.(2)";
		alert(document.errorForm.MSG.value);
		document.errorForm.submit();
	}
	else
	{
		var varRet;
		//alert("<%=MG_SITE_NAME%>");
		if ((varRet = GetAppEnvKey("<%=MG_SITE_NAME%>", "<%=LINK_APP_CODE%>", "<%=strCert%>")) == 0)
		{
			document.sessionkeyForm.ISK.value = GetResult();
			document.sessionkeyForm.submit();
		}
		else
		{
			errorForm.MSG.value = ReportError(varRet);
			errorForm.submit();		
		}
	}
-->	
</script>
<!--
<BODY>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tR>
    <tD>
      <table width="760" bgcolor="#FFFFFF" border="0" bordercolor="#BDBDBD" style="border-collapse:collapse" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td style="padding:10 0 10 0">
            <table width="740" border="0" cellpadding="0" cellspacing="0" align="center">
              <tr>
                <tD width="532" valign="top">
                <img src="../common/images/login_kb_main_img.jpg" width="530" height="270" border="0">
                </td>
                <tD width="10"></td>
                <tD width="198" valign="top">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <tD height="10"></td>
                    </tr>
                    <tr>
                      <tD style="padding:0 0 0 10">
                      <img src="../common/images/login_logo.gif" width="154" height="29" border="0">
                    </td>
                    </tr>
                    <tr>
                      <tD height="20"></td>
                    </tr>
                    <tr>
                      <tD>
                      <img src="../common/images/login_bg_01.gif" width="198" height="8" border="0">
                      </td>
                    </tr>
                    <tr>
                      <tD background="../common/images/login_bg_02.gif">
                      <tD>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tR>
                            <tD height="3"></td>
                          </tr>
                          <tR>
                            <tD>
                              <table width="175" border="0" cellpadding="0" cellspacing="0" align="center">
                                <tR>
                                  <tD>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                      <tR>
                                        <tD style="padding:71 0 71 0">
                                          <table border="0" cellpadding="0" cellspacing="0" align="center">
                                            <tR>
                                              <tD>
                                                <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                  <tr>
                                                    <tD align="center">
                                                    <img src="../common/images/logging.gif" width="99" height="15" border="0">
                                                  </td>
                                                  </tr>
                                                  <tr>
                                                    <tD height="20"></td>
                                                  </tr>
                                                  <tr>
                                                    <tD>
                                                    <img src="../common/images/bar.gif" width="160" height="15" border="0">
                                                    </td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                    </table>                                  
                                  </tD>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <tD>
                      <img src="../common/images/login_bg_03.gif" width="198" height="8" border="0">
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</BODY>
-->
</HTML>
	
