<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// prgnm 	: 화상강의 동의서
// date		: 2021-01-28
// auth 	: jbong
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%

//필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

//리스트
DataMap listMEM = (DataMap)request.getAttribute("MEM_DATA");
listMEM.setNullToInitialize(true);

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

//동의날짜
SimpleDateFormat dsf = new SimpleDateFormat("yyyy년 MM월 dd일");

Date date = new Date();

String sysdate = dsf.format(date);
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

window.onload = function() {
	var dept = "<%=dept%>";
	if(dept) {
		getMemSelDept("<%=dept%>");
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

function goToAgree(){
	var chk1 = document.getElementById("chk1");
	var chk2 = document.getElementById("chk2");
	var chk3 = document.getElementById("chk3");
	var chk4 = document.getElementById("chk4");
	var chk5 = document.getElementById("chk5");
	var chk6 = document.getElementById("chk6");
	var chk7 = document.getElementById("chk7");
	var chk8 = document.getElementById("chk8");
	var chk9 = document.getElementById("chk9");
	var chk10 = document.getElementById("chk10");
	var chk11 = document.getElementById("chk11");
	var chk12 = document.getElementById("chk12");
	var chk = false;
	var parentBtn = opener.document.getElementById("btn1");
	
	if(chk1.checked && chk2.checked && chk3.checked && chk4.checked && chk5.checked && chk6.checked &&
	   chk7.checked && chk8.checked && chk9.checked && chk10.checked && chk11.checked && chk12.checked){
		chk = true;
	} else {
		chk = false;
	}

	if(chk){
		alert("계속해서 수강신청 진행해주세요.");
		window.close();
		parentBtn.disabled = false;
	} else {
		alert("모두 체크해주세요.");
		return;
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
//
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
   <input type="hidden" name="grgubun" id="grgubun" value="<%=requestMap.getString("grgubun") %>">
   <input type="hidden" name="grcodeniknm" id="grcodeniknm" value="<%=session.getAttribute("grcodeniknm") %>"> 
   <input type="hidden" name="studyDate" id="studyDate" value="<%=session.getAttribute("studyDate") %>"> 
<div class="top">	
	<h1 class="h1">실시간 화상강의 학습 동의서<!--span class="txt_gray">2008-01</span--></h1>
</div>
<div class="contents">
	<!-- data -->
	<p class="InName"><strong class="txt_blue"><%=listMEM.getString("name") %></strong> 님의 개인정보 확인</p>
	<p class="InPro02">학습동의서</p>

	<!-- //data -->
	<div>
	<form name="frmAgree" onSubmit="return ChekcForm(this)">
		<table border="5" width="700" border-collapse="collapse" cellspacing="2">
			<tr>
				<td colspan="3">
					<br/><div><b><p align="center" >본인은 온라인 화상강의로 진행하는 상기 과정을 수강함에 있어,</p></b>
					<p align="center">아래 사항에 대해 동의합니다.</p></div>
				</td>
			</tr>
			<tr>
				<td><b>구분</b></td>
				<td><b>내용</b></td>
				<td><b>동의여부</b></td>
			</tr>
			<tr>
				<td rowspan="5"><b>교육준비</b></td>
				<td>1. 재택학습 원칙(사무실에서 수강 불가)</td>
				<td><input type="checkbox" name="chk[]" id="chk1"></td>
			</tr>
			<tr>
				<td>2. 인터넷(일반망O, 행정망X)이 연결된 PC 또는 노트북 준비<br/>
					* 태블릿 PC, 핸드폰을 주 교육 기기로 교육 참여 불가
				</td>
				<td><input type="checkbox" name="chk[]" id="chk2"></td>
			</tr>
			<tr>
				<td>3. 웹캠 및 스피커 등 소리 송출 가능한 장비 준비</td>
				<td><input type="checkbox" name="chk[]" id="chk3"></td>
			</tr>
			<tr>
				<td>4. 교육과정 필수 소프트웨어 설치(아래 과정만 해당)<br/>
					  - (5급 역량강화) 한글, PPT, 메모장, 워드 중 1개<br/>
					  - (공직자 맞춤형 커뮤니케이션) 2010버전 이상의 한글 및 PPT<br/>
					  - (인천특별시대 미래) 크롬(Chrome), 한글, PPT<br/>
				</td>
				<td><input type="checkbox" name="chk[]" id="chk4"></td>
			</tr>
			<tr>
				<td><b><font color="red">5. 사전테스트 참여</font></b><br/>
					<font color="blue">* 현안업무 발생 등으로 참여가 불가하게 될 경우 사전 연락</font>
				</td>
				<td><input type="checkbox" name="chk[]" id="chk5"></td>
			</tr>
			<tr>
				<td rowspan="3"><b>근태관리</b></td>
				<td>1. 강의 시작 10분 전에 강의실 접속(단, 첫날은 15분 전에 접속)</td>
				<td><input type="checkbox" name="chk[]" id="chk6"></td>
			</tr>
			<tr>
				<td>2. 출석 확인을 위해 카메라 기능 상시 활성화</td>
				<td><input type="checkbox" name="chk[]" id="chk7"></td>
			</tr>
			<tr>
				<td>3. 교육시간 중 사전 허가 받은 경우를 제외하고 무단이탈(외출, 개인 업무 등) 금지</td>
				<td><input type="checkbox" name="chk[]" id="chk8"></td>
			</tr>
			<tr>
				<td rowspan="4"><b>보안</b></td>
				<td>1. 최신 보안 업데이트 실시, 백신 설치</td>
				<td><input type="checkbox" name="chk[]" id="chk9"></td>
			</tr>
			<tr>
				<td>2. 공지된 회의(화상강의실) ID 및 비밀번호 외부 유출 금지</td>
				<td><input type="checkbox" name="chk[]" id="chk10"></td>
			</tr>
			<tr>
				<td>3. 강의 녹화 및 사진촬영 등 금지, 강의 자료 제3자에게 배포(전송),<br/>
					     게시판에 게재 등 유출 금지<br/>
					   <font color="blue">* 저작권법 위반 및 초상권 침해소지 있음</font>
				</td>
				<td><input type="checkbox" name="chk[]" id="chk11"></td>
			</tr>
			<tr>
				<td>4. 필요 시 교육운영 상황 기록(모니터링, 출석 확인 등)을 위한 인재개발원의 과정 녹화 진행</td>
				<td><input type="checkbox" name="chk[]" id="chk12"></td>
			</tr>
			<tr>
				<td colspan="3">
					<br/><br/><b><div align="center"><%=sysdate %></div><br/></b>
					 교육생 : <select id="deptSelect" name="DEPT_DATA" class="select01 w200" onChange="getMemSelDept(this.options[this.selectedIndex].value)">
					<option value = "" selected>--- 소속기관 선택 ---</option>
					<%= deptListHtml.toString() %>
					<input type="text" id="degreename" name="degreename" class="input01 w159"  readonly value="<%=jiknm%>"/>
					<%=listMEM.getString("name") %> <%=listMEM.getString("name") %>(서명은 성명으로대체)<br/><br/><br/>
					<div align="center">인천광역시 인재개발원장 귀하</div>
				</td>
			</tr>
		</table>
		</form>
	</div>
	

	<!-- button -->
	<div class="btnC">
		<a href="javascript:goToAgree();"><img src="/images/<%=skinDir %>/button/btn_yes01.gif" alt="예" /></a>
		<a href="javascript:window.close();"><img src="/images/<%=skinDir %>/button/btn_close01.gif" alt="닫기" /></a>
	</div>	
	<br/>
</div>
</form>
</body>
</html>
