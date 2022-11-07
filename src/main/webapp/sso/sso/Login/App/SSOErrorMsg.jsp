<%@ page import="java.io.*, java.lang.*" %>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%
	String	strErrorMsg = "";		// Configure File Path
	strErrorMsg = request.getParameter("MSG");
	//strErrorMsg = new String (request.getParameter("MSG").getBytes("8859_1"),"EUC_KR");
%>

<HTML>
<HEAD>
<TITLE>:::: 오류정보 ::::</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel=stylesheet href="../common/css/sso_style.css" type="text/css">
<style type="text/css">
    body { overflow:hidden } 
</style>
</HEAD>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<img src="../common/images/top_img.gif">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tR>
    <td>
      <table width="466" border="0" cellpadding="0" cellspacing="0" align="center">
        <tR>
          <tD background="../common/images/system_error_img_04.gif" width="466" height="124">
            <table width="360" border="0" cellpadding="0" cellspacing="0" align="center">
              <tr>
                <tD class="tb_text" style="padding:60 0 6 2">
                오류가 발생하였습니다.<br>
                오류 메시지 ::
                <%= strErrorMsg%>
                </td>
              </tr>
            </table>          
          </tD>
        </tr>
        <tR>
          <tD><img src="../common/images/system_error_img_03.gif" width="466" height="12"></tD>
        </tr>
  
        <tr>
          <tD height="10"></td>
        </tr>

        <tR>
          <tD>
            <table border="0" cellpadding="0" cellspacing="0" align="right">
              <tr>
                <td width="3"> </td>
                <tD>
                  <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="../common/images/btn2_left.gif" width="14" height="21"></td>
                      <tD background="../common/images/btn2_bg.gif" nowrap style="padding:2 0 0 0"><A HREF="javascript:self.close();">닫기</A></tD>
                      <td><img src="../common/images/btn2_right.gif" width="11" height="21"></td>
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
</HTML>
