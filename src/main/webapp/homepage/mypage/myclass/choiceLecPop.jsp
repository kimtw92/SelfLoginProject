<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 수강신청
// date		: 2008-09-30
// auth 	: jong03
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%

// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);


StringBuffer sbListHtml = new StringBuffer();

int iNum = 0;
if(listMap.keySize("subj") > 0){		
	for(int i=0; i < listMap.keySize("subj"); i++){
		sbListHtml.append("<input type=\"radio\" name=\"choice_subj\" value=\""+listMap.getString("subj",i)+"\">"+listMap.getString("lecnm",i)+"<br />\n");
	}
}else{
	
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>

<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />

<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/NChecker.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/protoload.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/homeCategory.js"></script>

<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<script language="JavaScript" type="text/JavaScript">
<!--
function go_choice(){
	var chk="";
	f_name = document.pform;
	var choiceSubj = "";
	
	for(i=0;i<f_name.elements.length;i++){
		if(f_name.elements[i].type=='radio' && f_name.elements[i].name=='choice_subj' && f_name.elements[i].checked==true){
			choiceSubj = f_name.elements[i].value;
			chk = 1;
		}
	}

	if(chk != 1){
		alert('선택과목을 선택하세요!');
		return;
	}
	
	if(confirm("해당과목을 선택하시겠습니까?") == true){
		go_applyInfo($("grcode").value, $("grseq").value,$("subj").value, choiceSubj);
		return;
	}else{

	}

}

//과정 신청
function go_applyInfo(grcode,grseq,subj, choice_subj){
	
		var url = "/mypage/myclass.do";

		pars = "mode=choiceSubLecture&grcode=" + grcode + "&grseq="+grseq+"&subj="+subj+"&choice_subj="+choice_subj;
		//  alert(pars);			
		var myAjax = new Ajax.Request(
					
			url, 
				{
					method: "post", 
					parameters: pars,
					onComplete : showResponse
				}
		);
}

function showResponse(oRequest){
	alert(oRequest.responseText);
	opener.fnList();
	window.close();
}

//리스트
function goDetail(){
	pform.action = "/mypage/myclass.do?mode=attendDetail";
	pform.submit();
}
//-->
</script>
<!-- [Page Customize] -->
<style type="text/css">
<!--

-->
</style>
<!-- [/Page Customize] -->
</head>

<!-- popup size 400x220 -->
<body>

<form id="pform" name="pform" method="post">
<input type="hidden" name="subj"  value="<%=requestMap.getString("subj") %>">
<input type="hidden" name="grcode"  value="<%=requestMap.getString("grcode") %>">
<input type="hidden" name="grseq"  value="<%=requestMap.getString("grseq") %>">

<div class="top">
	<h1 class="h1">선택해주세요</h1>
</div>
<div class="contents">

	<div class="h10"></div>
	


	
    <table class="dataW02" style="width:370px;">	
	<colgroup>
		<col width="" />
	</colgroup>
	<tbody>
	<tr>
		<th class="bl0">
			선택해주세요
		</th>
	</tr>

	<tr>
		<td>
		<%=sbListHtml.toString() %>
		</td>
	</tr>
    </tbody>
	</table>	




	<!-- button -->
	<div class="btnC" style="width:375px;">
		<a href="javascript:go_choice();"> <img src="/images/<%=skinDir %>/button/btn_choice.gif" alt="선택" /></a>		
	</div>	
	<!-- //button -->
</div>


</form>
</body>
</html>

