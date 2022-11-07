<%@ page contentType="text/html; charset=EUC_KR" %>
<%
 String argv1 = request.getParameter("argv1");
 String argv2 = request.getParameter("argv2");

 
 if ( argv1 == null){
  argv1 = "";
 }
 if ( argv2 == null){
  argv2 = "";
 }
 
%>
 
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
alert("sso_index.jsp ют╢о╢ы.");
<!--
function init(){
 var argv1 = "<%=argv1%>";
 var argv2 = "<%=argv2%>";
 var decrypted1 = PassNi.getDecDataWithClientKey(argv1);
 var decrypted2 = PassNi.getDecDataWithClientKey(argv2);
 document.frm.userId.value = decrypted1;
 document.frm.pwd.value = decrypted2;
 document.frm.submit();
}
//-->
</SCRIPT>
</head>
<body onload="init();">
  <object classid="clsid:B400F1B0-A785-486D-A8DC-FB186E4B289C" id="PassNiv25m" name="PassNi"  style="width:0;height:0"></object>
    <FORM name="frm" METHOD=POST ACTION="https://hrd.incheon.go.kr/homepage/login.do">
	  <INPUT TYPE="hidden" NAME="mode" value="loginChk">
	  <INPUT TYPE="hidden" NAME="userId">
	  <INPUT TYPE="password" NAME="pwd">
	</FORM>
  </body>
</html> 
