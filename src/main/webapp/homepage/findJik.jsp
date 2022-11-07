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
		if($F('jik') == "") {
			alert("검색어를 입력해 주십시오.");
			return;
		}
		
			var jik = $F('jik');
			var url = "join.do";
			pars = "mode=findjikajax&jik="+jik;
			var divID = "jiklistajax";
			
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
						alert("데이타를 가져오지 못했습니다.");
					}				
				}
			);
	}
	
	function confirmJik(jiknm, jik) {
	
		var deptObj = opener.document.getElementById("deptSelect");	//소속기관
		var z1Obj = opener.document.getElementById("degreename");	//직급명
		var z2Obj = opener.document.getElementById("hiddenjik");	//직급코드
		z1Obj.value = jiknm;
		z2Obj.value = jik;
		
		//소방직급인 경우 소속기관을 소방으로 선택
		if(jiknm.indexOf("소방") != -1) deptObj.options[12].selected = true;
		self.close();
	}

</script>
</head>

<!-- popup size 400x220 -->
<body>
<div class="top">
	<h1 class="h1">직급명검색</h1>
</div>
<div class="contents">
	<!-- search -->
	<div class="popBoxWrap">
        <div class="drBoxTop">
            <dl>
                <dt><img src="/images/skin1/common/txt_pstSch.gif" class="vm2" alt="직급검색" /></dt>
                <dd>
                    <input type="text" value="" name="jik" id="jik" class="input01 w158" /> 
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
	<div class="textSet01" style="width:375px;">
		직급명(예:행정주사)입력 후 검색을 선택하세요.
	</div>
	<!-- //text -->	
	
	<div id="jiklistajax" />
	
	<!-- button -->
	<div class="btnC" style="width:375px;">
		<a href="javascript:window.close();"><img src="/images/skin1/button/btn_close01.gif" alt="닫기" /></a>		
	</div>	
	<!-- //button -->
</div>
</body>
</html>
