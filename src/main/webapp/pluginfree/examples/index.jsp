<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"
%><%@page import="java.util.Date"
%><%@page import="java.text.SimpleDateFormat"
%><%
SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSS");
String now = format.format(new Date());

request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>nProtect Online Security v1.0.0</title>
<style>
body,td, th{font-size:10pt}
input, textarea{font-size:9pt;}
</style>

<script type="text/javascript" src="/pluginfree/js/nosquery-1.11.3.js"></script>
<!--고객사에서 사용하는 jquery 버전이 1.7.4이상일 경우 해당경로로 변경하여 사용 가능 -->
<script type="text/javascript" src="/pluginfree/jsp/nppfs.script-1.6.0.jsp"></script>
<script type="text/javascript" src="/pluginfree/js/nppfs-1.6.0.js"></script>

<script type="text/javascript">
nosQuery(document).ready(function(){
    nosQuery("#userAgent").text(navigator.userAgent);
    var isSupport = npPfsCtrl.IsSupport();
    var isMobile = npPfsDefine.isMobileDevice();
    if(!isSupport && !isMobile)
    {
           //alert("보안프로그램을 지원하지 않는 환경입니다. 접속 가능 환경을 확인하시고 다시 시도하십시오.");
    }
    else
    {
           npPfsStartup(document.form1, false, true, false, false, "npkencrypt", "on");
    }
});

</script>

</head>
<!-- <body oncontextmenu="return false" onselectstart="return false" ondragstart="return false"> -->
<body>
<table>
	<tr>
 		<th style="text-align:left;font-size:14pt;">접속정보</th>
 	</tr>
	<tr>
 		<td>
			<span id="userAgent"></span>
		</td>
	</tr>
</table> 

<div style="margin-bottom:20px; padding:10px; border:1px solid #000;">

<form name="form1"  method="post" target="resultTarget">
<div id="nppfs-loading-modal" style="display:none;"></div>
<div class="nppfs-elements" style="display:none;"></div>

	<input type="hidden" name="mode" value="KEYCRYPT" />
	<table width="100%">
		<colgroup>
			<col width="10%"></col>
			<col width="90%"></col>
		</colgroup>
		<tr>
			<th colspan="2" style="text-align:left;font-size:14pt;">키보드보안 테스트</th>
		</tr>
				<tr>
			<td>Id:</td>
			<td><input type="text"     name="TEXT_1" id="t1" style="ime-mode:disabled;"  value="" maxlength="14" /> : 14글자</td>
		</tr>
		<tr>
			<td>PW:</td>
			<td><input type="password" name="PASS_1" id="p1" style="ime-mode:disabled;"   value="" maxlength="16" /> : 16글자</td>
		</tr>
		
	</table>
</form>
</div>

</body>
</html>
