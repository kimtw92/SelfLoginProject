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
DataMap listMEM = (DataMap)request.getAttribute("MEM_DATA");
listMEM.setNullToInitialize(true);


String hp = listMEM.getString("hp");
String hp1 = "";
String hp2 = "";
String hp3 = "";
try {
	String[] hpTemp = hp.split("-");
	hp1 = hpTemp[0];
	hp2 = hpTemp[1];
	hp3 = hpTemp[2];
} catch(Exception e) {
	hp1 = "";
	hp2 = "";
	hp3 = "";
}

String email = listMEM.getString("email");
String jik  = listMEM.getString("jik");
String jiknm  = listMEM.getString("jiknm");
String upsdate  = listMEM.getString("upsdate").replaceAll("-","");
String dept  = listMEM.getString("dept");

DataMap deptMap = (DataMap)request.getAttribute("DEPT_DATA");
deptMap.setNullToInitialize(true);

DataMap listPART = (DataMap)request.getAttribute("PART_DATA");
listPART.setNullToInitialize(true);

DataMap infoMap = (DataMap)request.getAttribute("USER_INFO");
infoMap.setNullToInitialize(true);

//소속기관
StringBuffer deptListHtml = new StringBuffer();
if(deptMap.keySize("dept") > 0) {
	for(int i=0; i < deptMap.keySize("dept"); i++) {
		if(deptMap.getString("dept",i).equals(dept)) {
			deptListHtml.append("<option selected=\"selected\" value = \""+deptMap.getString("dept",i)+"\">"+deptMap.getString("deptnm",i)+"</option>");
		} else {
			deptListHtml.append("<option value = \""+deptMap.getString("dept",i)+"\">"+deptMap.getString("deptnm",i)+"</option>");
		}
	}	
}

%>

<html>
	<head>
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>

<link rel="stylesheet" type="text/css" href="/commonInc/css/<%=skinDir %>/popup.css" />

<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/NChecker.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/protoload.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/homeCategory.js"></script>

<script language="javascript" src="/commonInc/js/commonJs.js"></script>

<Script language='javascript'>
<!--
	
	window.onload = function() {
		var dept = "<%=dept%>";
		if(dept) {
			getMemSelDept("<%=dept%>");
		}
		var grcode = $("grcode").value;
		if(grcode.equals("10G0000381")){
			var btn1 = document.getElementById('btn1');
			btn1.disabled = false;
			
			var btn2 = document.getElementById('btn2');
			btn2.disabled = true;
		}
	}

	function getMemSelDept(form) {
		
		var url = "/mypage/myclass.do";
		pars = "dept=" + form + "&mode=searchPart";
		var divID = "part";
			
		var myAjax = new Ajax.Updater(
				
				{success: divID },
				url, 
				{
					method: "post", 
					parameters: pars,
					onLoading : function(){
						$(document.body).startWaiting('bigWaiting');
					},
					onSuccess : function(){
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						// $("month").value = month;
						// $("currPage").value = 1;
					},
					onFailure : function(){					
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						alert("데이타를 가져오지 못했습니다.");
					}				
				}
			);
	}

	function findJik(){
		var url="/homepage/join.do";
		url += "?mode=findjik";
		pwinpop = popWin(url,"jik","420","350","yes","yes");
	}
	
	function on_agree(grcode, grseq, userno, grgubun){
			var url = "/homepage/attend.do";
			url += "?mode=agreePopup";
			url += "&grcode="+$("grcode").value;
			url += "&grseq="+$("grseq").value;
			url += "&userno="+$("userno").value;
			url += "&grgubun="+$("grgubun").value;
			pwinpop = popWin(url,"agreePop","800","600","yes","yes");
	}

	function on_apply(){

		if ($("degreename").value == ""){
			alert("직급을 등록해 주세요");
			
		} else if (document.pForm.DEPT_DATA.options[document.pForm.DEPT_DATA.selectedIndex].value == ""){
			alert("소속기관을 선택해 주세요");
			
		} else if ($("PART_DATA").value == "" && document.pForm.DEPT_DATA.options[document.pForm.DEPT_DATA.selectedIndex].value == "6289999"){
			alert("공사공단은 부서명을 선택해주세요.");
		} else  if ( $("DEPTSUB").value == ""){
			alert("부서명을 등록해 주세요");
			
		} else if ($("hp1").value == "" || $("hp2").value == "" || $("hp3").value == ""){
			alert("핸드폰 번호를 등록해 주세요");
			
		} else if ($("email").value == ""){
			alert("메일주소를 등록해 주세요");
			
		} else if ($("email").value.indexOf("@")  ==  -1){
			alert("올바른 메일주소가 아닙니다");
		} else {
			//휴대폰번호병합

		var url = "/mypage/myclass.do";
		var pars = "mode=ajaxGetGrseq";
		pars += "&grseq="+$("grseq").value;
		pars += "&userno="+$("userno").value;
		pars += "&grcode="+$("grcode").value;

		var check = true;

		/*
		var myAjax = new Ajax.Request(
			url, 
			{
				method: "post", 
				parameters: pars,
				asynchronous : false,
				onSuccess : function(transport){
					var result = eval(transport.responseText.trim());
					if(result == '-200') { // 올해 수강신청한 이력이 있으면 신청불가
						check = false;
					} else {
						check = true;
					}
				},
				onFailure : function(){

					alert("데이타를 가져오지 못했습니다.");
					check = false;
				}				
			}
		);
		*/

			if(check) {
			$("hp").value = $("hp1").value + "-" + $("hp2").value + "-" + $("hp3").value;
			opener.go_applyInfo($("grcode").value,$("grseq").value,$("userno").value,
					$("DEPT_DATA").value,										 // deptcode 기관코드
					$("DEPT_DATA").options[$("DEPT_DATA").selectedIndex].text,	 // deptnm 기관명
					$("DEPTSUB").value,											 // deptsub 부서명
					$("degreename").value,										 // degreename 직급명
					$("hiddenjik").value,										 // jik 직급코드
					$("hp").value,												 // hp 핸드폰
					$("email").value,   										 // email 이메일
					$("UPSDATE").value,											 // 현직급임용일
					$("PART_DATA").value,									     // 기관분리코드
					$("grgubun").value);										 // 구분자
			} else {
				alert("본 과정은 선착순 수강 신청이 마감되었습니다.");
			}
			window.close();
			
		}
	}

	function getPart(objValue, objText) {
		if(objValue == ""){
			document.pForm.DEPTSUB.readOnly = false;
			document.pForm.DEPTSUB.value = "";
			document.pForm.DEPTSUB.focus();
		}else{
			document.pForm.DEPTSUB.readOnly = true;
			document.pForm.DEPTSUB.value = objText;
		}
	}
//-->
</script>
</head>

<!-- popup size 603x889 -->
<body>
<!-- 달력 관련 시작-->

<Div id='popCal' style='POSITION:absolute;visibility:hidden;border:2px ridge;width:10'>
 <iframe name="popFrame" src="/homepage/popcalendar.htm" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" width="183" height="188"></iframe>
 
</DIV>
<SCRIPT event="onclick()" for="document"> popCal.style.visibility = "hidden";</SCRIPT>
<!-- 달력 관련 끝-->

<form method="POST"  name="pForm">
   <input type="hidden" name="grcode" id="grcode" value="<%=requestMap.getString("grcode") %>">
   <input type="hidden" name="grseq" id="grseq" value="<%=requestMap.getString("grseq") %>">
   <input type="hidden" name="userno" id="userno" value="<%=requestMap.getString("userno") %>">
   <input type="hidden" name="hp" id="hp" value="<%=requestMap.getString("hp") %>">
      <input type="hidden" name="grgubun" id="grgubun" value="<%=requestMap.getString("grgubun") %>">
<div class="top">	
	<h1 class="h1">개인정보확인<!--span class="txt_gray">2008-01</span--></h1>
</div>
<div class="contents">
	<!-- data -->
	<p class="InName"><strong class="txt_blue"><%=listMEM.getString("name") %></strong> 님의 개인정보 확인</p>
	<p class="InPro02">신청절차 : 신청버튼 클릭 > 개인정보 입력 > 과정내용 확인 및 수강의견 입력</p>

	<!-- //data -->
	<div class="space02"></div>

	<!-- data -->
	<div class="InDeta02">
		<dl>
			<dt class="t2" style="width:80px;">이 름</dt>
			<dd>: <%=listMEM.getString("name") %></dd>

		</dl>
		<!-- dl>
			<dt>주민번호</dt>
			<dd>: 731111-125125</dd>
		</dl -->
		<dl>
			<dt class="t2" style="width:80px;">직 급</dt>
			<dd>:
				<!-- input type="text" id="degreename" name="jiknm" class="input01 w159"  readonly /-->
				<input type="text" id="degreename" name="degreename" class="input01 w159"  readonly value="<%=jiknm%>"/>
				<input type="hidden" id="hiddenjik" name="jik" value="<%=jik%>"/>
				<a href="javascript:findJik();"><img src="/images/<%=skinDir %>/button/btn_search05.gif" class="vm3" alt="직급검색" /></a>
				<input type="hidden" title="현직급임용일" name="UPSDATE" id="UPSDATE" value="<%=upsdate %>"/>
			</dd>
		</dl>
		<dl>
			<dt style="width:80px;">소속기관</dt>
			<dd>:
				<!-- <select name="DEPT_DATA" id="DEPT_DATA" class="select01 w165" onChange="getMemSelDept(this.options[this.selectedIndex].value)"> -->
				<select id="deptSelect" name="DEPT_DATA" class="select01 w200" onChange="getMemSelDept(this.options[this.selectedIndex].value)">
					<option value = "" selected>--- 소속기관 선택 ---</option>
					<%= deptListHtml.toString() %>
				</select>

			</dd>
		</dl>
		<dl  id="part">
			<dt style="width:80px;">부 서 명</dt>
			<dd>:
				<input type="text" value="" name="DEPTSUB" class="input01 w159"/>
				<select name="PART_DATA" id="PART_DATA" class="select01 w120" onChange="getPart(this.options[this.selectedIndex].value,this.options[this.selectedIndex].text)">
					<option value = "" selected>--- 부서 선택 ---</option>

				</select>
			</dd>
		</dl>
		<!-- dl>
				<dt style="width:80px;">현직급임용일</dt>
				<dd>:
					<input type="text" title="현직급임용일" name="UPSDATE" id="UPSDATE" class="input01 w100" readonly="readonly" value="<%=upsdate %>"/>
					<a href = "javascript:void(0)" onclick="window.frames.popFrame.fPopCalendar(UPSDATE,UPSDATE,popCal);return false">
						<img src="/images/skin1/icon/icon_cal01.gif" class="vp2" alt="달력" /> 
					</a>

					<span class="txt11 vp2">(예 :19910509)</span>
				</dd>
			</dl>
		<dl -->
		<dl>
			<dt style="width:80px;">핸 드 폰</dt>
			<dd>:
				<input type="text" value="<%=hp1%>" name="hp1" id="hp1" class="input01" style="width:50px;" /> - 
				<input type="text" value="<%=hp2%>" name="hp2" id="hp2" class="input01" style="width:50px;" /> -
				<input type="text" value="<%=hp3%>" name="hp3" id="hp3" class="input01" style="width:50px;" /> 
			</dd>

		</dl>
		<dl>
			<dt style="width:80px;">이 메 일</dt>
			<dd>:
				<input type="text" name="email" id="email" class="input01 w159" value="<%=email%>" />
			</dd>
		</dl>
		<dl>
			<dt style="width:80px;">화상강의 <br/>학습 동의서 </dt>
			<dd>:
				<input type="button" id="btn2" alt="화상강의 동의서" onclick="on_agree();" value="화상강의 동의서"/><br/><br/>
				<b><font color="red">화상강의 동의서를 작성하여 수강신청 바랍니다.</font></b>
			</dd>
		</dl>			
	</div>
	<!-- //data -->

	<div class="space02"></div>

	<!-- data -->
	<div class="InCons">
		<div class="textSet01_3">※ 주의사항 : 수강승인 처리가 취소될 수 있으니 소속기관 등 개인정보를 정확하게<br/>&nbsp;&nbsp;&nbsp;&nbsp;입력 바랍니다.  
		</div>	<br/>
		<div><b>예)</b> <font color="red">상수도사업본부 → 인천광역시, 서구시설관리공단 → 공사·공단</font><br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font class="textSet01_2">해당정보가 맞습니까?</font></div> 
	</div>
	<!-- //data -->

	<!-- button -->
	<div class="btnC">
		<input type="button" id="btn1" alt="신청" onclick="on_apply();" value=" 신 청 " disabled/>
		<input type="button" alt="닫기" onclick="window.close()" value=" 닫 기 "/>

	</div>	
	<br/>
<b> <font color="red">☞ "예" 버튼클릭후 반응이 없을때</font> <input type="button" value="해결방법보기" onclick="window.open('/homepage/support.do?mode=faqView&fno=59','popup_info','');"/></b>
	<!-- //button -->
</div>
</form>
</body>
</html>
