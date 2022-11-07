<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>


<script>
	function setCookie( name, value, expiredays ) { //쿠키 설정
		 var todayDate = new Date();
		 todayDate.setDate( todayDate.getDate() + expiredays ); 
		 document.cookie = name + "=" + escape( value ) 
		 + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}

	function closeWindow()  {
		setCookie("CookieName3", "noPopup_3" , 1); //쿠키 이름을 'noPopup'으로 설정.
		self.close(); //팝업창을 닫는다.
	}
</script>
<%
	DataMap popupViewMap = (DataMap)request.getAttribute("POPUP_CONTENTS");
	popupViewMap.setNullToInitialize(true);
	
	String popupViewHtml = new String();
	
	if(popupViewMap.keySize("content") > 0){
		popupViewHtml +=popupViewMap.getString("content",0);
	}	
	
	char a = 0x5C;
	char b = '\u0020';
	popupViewHtml = popupViewHtml.replace(a,b);

%>
<head>
<title><%=popupViewMap.getString("title",0) %></title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
</head>
<body topmargin="5" leftmargin="5">


<%=StringReplace.convertHtmlDecode(popupViewHtml)%>

<div style="background:#727272;text-align:right;margin-top:0px;">
	<img src="../../../images/skin1/common/close_T.gif" onClick="closeWindow();" style="cursor:hand;" alt="오늘 하루만 창 닫기" />
</div>

</body>