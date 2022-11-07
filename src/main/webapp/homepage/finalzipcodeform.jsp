<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonHtmlTop.jsp" %>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
// date	: 2008-08-26
// auth 	: 양정환
%>
<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	StringBuffer listHtml = new StringBuffer();
	String getAddr = requestMap.getString("selAddr");
	String post1 = getAddr.substring(0,3);
	String post2 = getAddr.substring(3,6);
	String post3 = getAddr.substring(6);
	
	listHtml.append(getAddr);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천사이버교육센터(시민포털)에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
<script>
	function confirmAddr() {
		z1Obj = opener.document.getElementById("homePost1");
		z2Obj = opener.document.getElementById("homePost2");
		addrObj = opener.document.getElementById("homeAddr");
		
		//alert(z1Obj.value+"_"+z2Obj.value+"_"+addrObj.value);
		z1Obj.value = "<%=post1 %>";
		z2Obj.value = "<%=post2 %>";
		addrObj.value = "<%=post3 %>" + document.getElementById("detail").value;
		//alert(z1Obj.value+"_"+z2Obj.value+"_"+addrObj.value);

		self.close();		
	}
</script>
</head>

<body>
<div class="top">
	<h1 class="h1">우편번호 검색</h1>
</div>
<div class="contents">

<form>
	<input type="hidden" name="post1" value=<%=post1 %>/>
	<input type="hidden" name="post2" value=<%=post2 %>/>
	<input type="hidden" name="post3" value=<%=post3 %>/>
	<div class="schList01">
		<ul class="adrs01">
			<li>
				<dl>
					<dt>현재주소</dt>  
					<dd><%="["+post1+"-"+post2+"] " + post3%></dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>상세주소</dt>  
					<dd>
						<input type="text" value="" id="detail" name="detail" class="input01 w274" />
						<a href="javascript:confirmAddr();">
							<img src="/images/skin1/button/btn_submit.gif" class="vm3" alt="확인">
						</a>
					</dd>
				</dl>
			</li>
		</ul>
	</div>

</form>
	<!-- //검색결과 -->
	<div class="space01"></div>
	

	<!-- button -->
	<div class="btnC" style="width:375px;">
		<a href="javascript:window.close();"><img src="/images/skin1/button/btn_close01.gif" alt="닫기" /></a>		
	</div>	
	<!-- //button -->
</div>
</body>
</html>
