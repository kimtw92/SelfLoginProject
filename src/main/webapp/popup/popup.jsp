<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<script type="text/javascript">
	function go_link_page() {
		var url = "/html/ServiceCenter/noticeView.do?page=1&seq=594"
		var newWindow = window.open("about:blank");
		newWindow.location.href = url;
		self.close();
	}

	function popup_close() {
		popup_setCookie("popup0001", "end", 1);
		self.close();
	}

	function popup_setCookie(cname, value, expire) {
		var todayValue = new Date();
		todayValue.setDate(todayValue.getDate() + expire);
		document.cookie = cname + "=" + encodeURI(value) + "; expires=" + todayValue.toGMTString() + "; path=/;";
	}
</script>
</head>
<body>
	<div>
		<form action="" method="post" name="popFrm"></form>
		<a href="http://incheon.nhi.go.kr/" target="_blank"><img src="/images/main/main_20190201.png" style="cursor: pointer" onclick="self.close()" /></a>
	</div>
	<div style="WIDTH: 100%; TEXT-ALIGN: right">
		<input type="checkbox" name="chkbox" onclick="popup_close();">
		오늘 하루 보지않기
	</div>
</body>
</html>