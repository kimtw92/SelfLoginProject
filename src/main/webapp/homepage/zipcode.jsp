<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonHtmlTop.jsp" %>


<%
// date	: 2008-08-26
// auth 	: 양정환
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천사이버교육센터(시민포털)에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />


<script>
	function goSearch(){
			var address = $F('address');
			var url = "join.do";
			pars = "mode=zipcodecheckajax&address="+address;
			var divID = "zipcodelistajax";
			
		var myAjax = new Ajax.Updater(
				{success: divID },
				url, 
				{
					method: "post", 
					parameters: pars,
					onLoading : function(){
						
					},
					onSuccess : function(){
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);						
					},
					onFailure : function(){					
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						alert("데이타를 가져오지 못했습니다.1");
					}				
				}
			);
	}

	function detailaddressajax(){
		document.addrForm.action = "join.do";
		document.addrForm.submit();		
	}

</script>
</head>

<!-- popup size 400x220 -->
<body>
<div class="top">
	<h1 class="h1">우편번호 검색</h1>
</div>
<div class="contents">
	<!-- search -->
	<div class="popBoxWrap">
		<div class="drBoxTop">
            <dl>
                <dt><img src="/images/skin1/common/txt_zcdSch.gif" class="vm2" alt="우편번호검색" /></dt>
                <dd>
                    <input type="text" value="" id="address" name="address"  class="input01 w158" /> 
			        <a href="javascript:goSearch();">
			        	<img src="/images/skin1/button/btn_search04.gif" class="vm3" alt="검색" />
                    </a>
                </dd>
            </dl>
		</div>
	</div>
	<!-- //search -->
	<div class="h10"></div>
	
	<!-- text -->
	<div class="textSet01" style="width:372px;">
		읍/면/동의 이름을 입력하시고 “검색”를 선택하세요<br />
		(예:홍제 또는 만수 또는 일직)
	</div>
	<!-- //text -->
	
	<div id="zipcodelistajax" />
		
	<!-- button -->
	<div class="btnC" style="width:372px;">
		<a href="javascript:window.close()"><img src="/images/skin1/button/btn_close01.gif" alt="닫기" /></a>		
	</div>	
	<!-- //button -->
</div>
</body>
</html>

