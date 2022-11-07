<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 역량과정 역량진단 설문.
// date : 2019-03-27
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
 	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true); 

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	//LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	//DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	//navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	//String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////

%>

<!-- [s] commonHtmlTop include 필수 -->
<%-- <jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/> --%>
<!-- [e] commonHtmlTop include -->

<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>인천광역시인재개발원에 오신 것을 환영합니다.[1]</title>


<link href="/commonInc/css/master_style.css" rel="stylesheet" type="text/css">
<link href="/commonInc/css/style2.css" rel="stylesheet" type="text/css">
<link href="/commonInc/css/protoload.css" rel="stylesheet" type="text/css">

<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<script language="javascript" src="/commonInc/js/NChecker.js"></script>
<script language="javascript" src="/commonInc/js/protoload.js"></script>
<script language="javascript" src="/commonInc/inno/InnoDS.js"></script>

<link  type="text/css" href="/homepage_new/css/sub.css" rel="stylesheet" charset="euc-kr">
<link rel="STYLESHEET" type="text/css" href="/homepage_new/css/common.css" />
<link rel="stylesheet" type="text/css" href="/homepage_new/css/content.css" />
<script type="text/javascript" language="javascript" src="/homepage_new/js/navigation.js"></script>
<script type="text/javascript" src="/lib/js/script.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>

<script language="JavaScript" type="text/JavaScript">

//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	/* var commGrCode = ""; */
	var commGrCode = "<%= request.getAttribute("commGrCode") %>";
	var commGrSeq = "<%= request.getAttribute("commGrSeq") %>";
	var banda = "<%= request.getAttribute("banda") %>";
	console.log("banda================ : " + banda)
	/* var commGrSeq = ""; */
	var banda1 = document.getElementById("banda1");
	var banda2 = document.getElementById("banda2");
	if (banda == "1"){
		document.getElementById("titlename").innerHTML = "역량과정 사전역량진단";
		banda2.style.display = "none";
		banda2.style.visibility = 'hidden';
		
	}else if (banda == "2"){
		document.getElementById("titlename").innerHTML = "역량과정 사후역량진단";
		banda1.style.display = "none";
		banda1.style.visibility = 'hidden';
	}
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = ""; 

	//alert( [reloading, commYear, commGrSeq, commGrCode]);
	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	//getCommYear(commYear); //년도 생성.
	//getCyberCommOnloadGrSeq(reloading, commYear, commGrSeq);
	//getCyberCommOnloadGrCode(reloading, commYear, commGrCode, commGrSeq);

}

// 레이어 넘기기
function layerClose(id) {
	id2=id+1;
	if (id > 1) {
		if (id == 2){
			for (var s = 1 ; s < 11 ; s++){
				var num = "";
				if (s < 10){
					num = "0"+s;
					eval("var questions = document.all('q_"+num+"')");
				} else {
					num = s;
					eval("var questions = document.all('q_"+num+"')");
				}
				//console.log("============================= num : " + num);
				//console.log("questions.length : " + questions.length);
				if (questions.length > 0){
					//console.log("questions.length > 0");
					var checkeds = false;
					for (var i = 0 ; i < questions.length ; i++){
						//console.log("questions["+i+"].checked : " + questions[i].checked);
						if(questions[i].checked){
							checkeds = true;
						}
						
					}
					if(!checkeds){
						return alert("모든 문항을 체크해주세요.");
					}
				}
			}
		} else if (id == 3){
			for (var s = 11 ; s < 21 ; s++){
				var num = s;
				eval("var questions = document.all('q_"+num+"')");
				if (questions.length > 0){
					var checkeds = false;
					for (var i = 0 ; i < questions.length ; i++){
						if(questions[i].checked){
							checkeds = true;
						}
						
					}
					if(!checkeds){
						return alert("모든 문항을 체크해주세요.");
					}
				}
			}
		} else if (id == 4){
			for (var s = 21 ; s < 31 ; s++){
				var num = s;
				eval("var questions = document.all('q_"+num+"')");
				if (questions.length > 0){
					var checkeds = false;
					for (var i = 0 ; i < questions.length ; i++){
						if(questions[i].checked){
							checkeds = true;
						}
					}
					if(!checkeds){
						return alert("모든 문항을 체크해주세요.");
					}
				}
			}
		}
	} 
	document.getElementById("survey_box" + id).style.display = "none";
	document.getElementById("survey_box" + id2).style.display = "block";
}

// 설문 종료
function resultForm(){

	for (var s = 31 ; s < 36 ; s++){
		var num = s;
		eval("var questions = document.all('q_"+num+"')");
		if (questions.length > 0){
			var checkeds = false;
			for (var i = 0 ; i < questions.length ; i++){
				if(questions[i].checked){
					checkeds = true;
				}
				
			}
			if(!checkeds){
				return alert("모든 문항을 체크해주세요.");
			}
		}
	}
	var url = "/poll/capacityDiagnosisPoll.do";
	pform.action = url;
	pform.submit();
}
//-->
</script>
<style type="text/css">
/*설문조사 추가*/
.survey{
	text-align:center;
	padding: 10px 10px;
}
.survey a{
    padding: 10px 30px;
    color: #ffffff;
    background: #a0a9ba;
    text-align:center;}
</style>
</head>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<%-- <jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include> --%>
    <div id="subContainer" style="padding:30px 30px 30px 30px; width: auto;">
    
    <!-- <div class="subNavi_area"> -->
		<%-- <jsp:include page="/homepage_new/inc/left1.jsp" flush="true" ></jsp:include> --%>
	<!-- </div> -->

	<form id="pform" name="pform" method="post" >
		<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
		<input type="hidden" name="mode"				value="form">
		
		<input type="hidden" name="commGrCode"		id="commGrCode"		value="<%= requestMap.getString("commGrCode") %>">
		<input type="hidden" name="commGrSeq"		id="commGrSeq"		value="<%= requestMap.getString("commGrSeq") %>">
		<input type="hidden" name="grcode"		id="grcode"		value="<%= requestMap.getString("grcode") %>">
		<input type="hidden" name="grseq"		id="grseq"		value="<%= requestMap.getString("grseq") %>">
		
		<input type="hidden" name="banda"		id="banda"		value="<%= requestMap.getString("banda") %>">
		<input type="hidden" name="titleNo"				value="">
		<input type="hidden" name="isCyber"				value="Y">
	
	
        <div id="contnets_area">
          <!-- <div class="sub_visual1">역량과정 사전역량진단</div> -->
			<div id="content">
				<h3 id="titlename">역량과정 사전역량진단</h3>
				<br/>
				<div id="survey_box1" class="point_box" style="display:block;">
					<p class="box_img"><span><img src="/homepage_new/images/common/box_point.gif" alt=""></span></p>
					<div class="list">
						<ul>
							<li>본 설문은 현재 본인의 역량 수준을 확인하기 위한 것입니다. 문항별로 읽어보시고 본인에게 해당되는 수준을 체크해 주시면 됩니다.</li>
							<li>1점(매우 그렇지 않다) ~ 3점(보통이다)~5점(매우 그렇다)를 기준으로 체크해 주시기 바랍니다. </li>
							<li id="banda1">본 설문은 교육 효과성을 확인하기 위하여 교육 종료 후 다시 한번 진행할 예정이니 현재 본인의 수준을 솔직하게 응답해 주시면 됩니다.</li>
							<li id="banda2" style="color:blue;">역량교육 후 1개월이 지난 시점에서 자신의 업무 방식을 생각하며 작성해주세요.</li>
						</ul>
					</div>
					<div class="survey">
						<a href="javascript:layerClose(1)">설문시작</a>
					</div>
				</div>
			
				<div id="survey_box2" class="point_box" style="display:none;">
					<div style="text-align:right;">
						<p style="color:red;">1점(매우 그렇지 않다) ~ 3점(보통이다)~5점(매우 그렇다)</p>
					</div>
					<table class="dataH07"> 
						<colgroup>
							<col width="5%">
							<col width="*">
							<col width="5%">
							<col width="5%">
							<col width="5%">
							<col width="5%">
							<col width="5%">
						</colgroup>
			
						<thead>
							<tr>
								<th class="t04" rowspan="2">번호</th>
								<th class="t04" rowspan="2">문항</th>
								<th class="t04" colspan="5">체크</th>
							</tr>
							<tr>
								<th class="t04">1</th>
								<th class="t04">2</th>
								<th class="t04">3</th>
								<th class="t04">4</th>
								<th class="t04">5</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td class="sbj">장기적인 관점으로 팀의 사업계획을 수립한다.</td>
								<td><input type="radio" name="q_01" value="1"></td>
								<td><input type="radio" name="q_01" value="2"></td>
								<td><input type="radio" name="q_01" value="3"></td>
								<td><input type="radio" name="q_01" value="4"></td>
								<td><input type="radio" name="q_01" value="5"></td>
							</tr>
							<tr>
								<td>2</td>
								<td class="sbj">팀 업무 목표에 따른 중장기적인 관점을 가지고 업무계획을 세운다.</td>
								<td><input type="radio" name="q_02" value="1"></td>
								<td><input type="radio" name="q_02" value="2"></td>
								<td><input type="radio" name="q_02" value="3"></td>
								<td><input type="radio" name="q_02" value="4"></td>
								<td><input type="radio" name="q_02" value="5"></td>
							</tr>
							<tr>
								<td>3</td>
								<td class="sbj">팀의 주요한 역할과 책임을 분명하게 알고 있다.</td>
								<td><input type="radio" name="q_03" value="1"></td>
								<td><input type="radio" name="q_03" value="2"></td>
								<td><input type="radio" name="q_03" value="3"></td>
								<td><input type="radio" name="q_03" value="4"></td>
								<td><input type="radio" name="q_03" value="5"></td>
							</tr>
							<tr>
								<td>4</td>
								<td class="sbj">시정책의 변화를 올바르게 이해하여 팀의 업무방향에 적용한다.</td>
								<td><input type="radio" name="q_04" value="1"></td>
								<td><input type="radio" name="q_04" value="2"></td>
								<td><input type="radio" name="q_04" value="3"></td>
								<td><input type="radio" name="q_04" value="4"></td>
								<td><input type="radio" name="q_04" value="5"></td>
							</tr>
							<tr>
								<td>5</td>
								<td class="sbj">팀의 현안업무를 시정책과 연계하여 팀원들을 이해시킨다.</td>
								<td><input type="radio" name="q_05" value="1"></td>
								<td><input type="radio" name="q_05" value="2"></td>
								<td><input type="radio" name="q_05" value="3"></td>
								<td><input type="radio" name="q_05" value="4"></td>
								<td><input type="radio" name="q_05" value="5"></td>
							</tr>
							<tr>
								<td>6</td>
								<td class="sbj">팀업무와 관련되는 정책이나 환경 변화에 항상 관심과 주의를 기울인다.</td>
								<td><input type="radio" name="q_06" value="1"></td>
								<td><input type="radio" name="q_06" value="2"></td>
								<td><input type="radio" name="q_06" value="3"></td>
								<td><input type="radio" name="q_06" value="4"></td>
								<td><input type="radio" name="q_06" value="5"></td>
							</tr>
							<tr>
								<td>7</td>
								<td class="sbj">팀의 업무상황 변화와 주요 발생 이슈를 사전에 미리 파악한다.</td>
								<td><input type="radio" name="q_07" value="1"></td>
								<td><input type="radio" name="q_07" value="2"></td>
								<td><input type="radio" name="q_07" value="3"></td>
								<td><input type="radio" name="q_07" value="4"></td>
								<td><input type="radio" name="q_07" value="5"></td>
							</tr>
							<tr>
								<td>8</td>
								<td class="sbj">업무를 실행에 옮기기 전에 업무들의 연관된 사항들을 세밀하게 확인한다.</td>
								<td><input type="radio" name="q_08" value="1"></td>
								<td><input type="radio" name="q_08" value="2"></td>
								<td><input type="radio" name="q_08" value="3"></td>
								<td><input type="radio" name="q_08" value="4"></td>
								<td><input type="radio" name="q_08" value="5"></td>
							</tr>
							<tr>
								<td>9</td>
								<td class="sbj">업무 방향이나 정책이 변경될 경우에도 적절한 대안이나 방법을 제시한다.</td>
								<td><input type="radio" name="q_09" value="1"></td>
								<td><input type="radio" name="q_09" value="2"></td>
								<td><input type="radio" name="q_09" value="3"></td>
								<td><input type="radio" name="q_09" value="4"></td>
								<td><input type="radio" name="q_09" value="5"></td>
							</tr>
							<tr>
								<td>10</td>
								<td class="sbj">향후 생길 수 있는 문제나 사안까지도 업무에 미리 고려한다.</td>
								<td><input type="radio" name="q_10" value="1"></td>
								<td><input type="radio" name="q_10" value="2"></td>
								<td><input type="radio" name="q_10" value="3"></td>
								<td><input type="radio" name="q_10" value="4"></td>
								<td><input type="radio" name="q_10" value="5"></td>
							</tr>
						</tbody>
					</table>
					<div class="survey">
						<a href="javascript:layerClose(2)">다음</a>
					</div>
				</div>
			
				<div id="survey_box3" class="point_box" style="display:none;">
					<div style="text-align:right;">
						<p style="color:red;">1점(매우 그렇지 않다) ~ 3점(보통이다)~5점(매우 그렇다)</p>
					</div>
					<table class="dataH07"> 
						<colgroup>
							<col width="5%">
							<col width="*">
							<col width="5%">
							<col width="5%">
							<col width="5%">
							<col width="5%">
							<col width="5%">
						</colgroup>
			
						<thead>
							<tr>
								<th class="t04" rowspan="2">번호</th>
								<th class="t04" rowspan="2">문항</th>
								<th class="t04" colspan="5">체크</th>
							</tr>
							<tr>
								<th class="t04">1</th>
								<th class="t04">2</th>
								<th class="t04">3</th>
								<th class="t04">4</th>
								<th class="t04">5</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>11</td>
								<td class="sbj">다양한 내/외부 사람들과 우호적인 관계를 통해 업무협조를 이끌어 낸다.</td>
								<td><input type="radio" name="q_11" value="1"></td>
								<td><input type="radio" name="q_11" value="2"></td>
								<td><input type="radio" name="q_11" value="3"></td>
								<td><input type="radio" name="q_11" value="4"></td>
								<td><input type="radio" name="q_11" value="5"></td>
							</tr>
							<tr>
								<td>12</td>
								<td class="sbj">일관되는 기준과 원칙을 가지고 업무를 추진한다.</td>
								<td><input type="radio" name="q_12" value="1"></td>
								<td><input type="radio" name="q_12" value="2"></td>
								<td><input type="radio" name="q_12" value="3"></td>
								<td><input type="radio" name="q_12" value="4"></td>
								<td><input type="radio" name="q_12" value="5"></td>
							</tr>
							<tr>
								<td>13</td>
								<td class="sbj">시민의 요구사항을 파악하기 위해서 적극적인 자세로 일한다.</td>
								<td><input type="radio" name="q_13" value="1"></td>
								<td><input type="radio" name="q_13" value="2"></td>
								<td><input type="radio" name="q_13" value="3"></td>
								<td><input type="radio" name="q_13" value="4"></td>
								<td><input type="radio" name="q_13" value="5"></td>
							</tr>
							<tr>
								<td>14</td>
								<td class="sbj">특정 주민이나 집단의 이익이 아닌 공공의 이익을 고려하여 대안을 제시한다.</td>
								<td><input type="radio" name="q_14" value="1"></td>
								<td><input type="radio" name="q_14" value="2"></td>
								<td><input type="radio" name="q_14" value="3"></td>
								<td><input type="radio" name="q_14" value="4"></td>
								<td><input type="radio" name="q_14" value="5"></td>
							</tr>
							<tr>
								<td>15</td>
								<td class="sbj">현장방문 및 수시점검을 통해 지역현안을 확인 및 해결한다.</td>
								<td><input type="radio" name="q_15" value="1"></td>
								<td><input type="radio" name="q_15" value="2"></td>
								<td><input type="radio" name="q_15" value="3"></td>
								<td><input type="radio" name="q_15" value="4"></td>
								<td><input type="radio" name="q_15" value="5"></td>
							</tr>
							<tr>
								<td>16</td>
								<td class="sbj">이해관계자들의 입장과 요구사항을 정확하게 파악한다.</td>
								<td><input type="radio" name="q_16" value="1"></td>
								<td><input type="radio" name="q_16" value="2"></td>
								<td><input type="radio" name="q_16" value="3"></td>
								<td><input type="radio" name="q_16" value="4"></td>
								<td><input type="radio" name="q_16" value="5"></td>
							</tr>
							<tr>
								<td>17</td>
								<td class="sbj">이해관계 및 갈등상황을 확인하기 위해 다양한 의사소통 채널을 활용한다.</td>
								<td><input type="radio" name="q_17" value="1"></td>
								<td><input type="radio" name="q_17" value="2"></td>
								<td><input type="radio" name="q_17" value="3"></td>
								<td><input type="radio" name="q_17" value="4"></td>
								<td><input type="radio" name="q_17" value="5"></td>
							</tr>
							<tr>
								<td>18</td>
								<td class="sbj">이해관계가 서로 상충되더라도 중간에서 합리적으로 조정한다.</td>
								<td><input type="radio" name="q_18" value="1"></td>
								<td><input type="radio" name="q_18" value="2"></td>
								<td><input type="radio" name="q_18" value="3"></td>
								<td><input type="radio" name="q_18" value="4"></td>
								<td><input type="radio" name="q_18" value="5"></td>
							</tr>
							<tr>
								<td>19</td>
								<td class="sbj">전문성을 바탕으로 근거와 논리를 가지고 상대방을 이해시킨다.</td>
								<td><input type="radio" name="q_19" value="1"></td>
								<td><input type="radio" name="q_19" value="2"></td>
								<td><input type="radio" name="q_19" value="3"></td>
								<td><input type="radio" name="q_19" value="4"></td>
								<td><input type="radio" name="q_19" value="5"></td>
							</tr>
							<tr>
								<td>20</td>
								<td class="sbj">이해관계자와의 유연한 대화를 통해서 공감대와 합의를 이끌어낸다.</td>
								<td><input type="radio" name="q_20" value="1"></td>
								<td><input type="radio" name="q_20" value="2"></td>
								<td><input type="radio" name="q_20" value="3"></td>
								<td><input type="radio" name="q_20" value="4"></td>
								<td><input type="radio" name="q_20" value="5"></td>
							</tr>
						</tbody>
					</table>
					<div class="survey">
						<a href="javascript:layerClose(3)">다음</a>
					</div>
				</div>
			
				<div id="survey_box4" class="point_box" style="display:none;">
					<div style="text-align:right;">
						<p style="color:red;">1점(매우 그렇지 않다) ~ 3점(보통이다)~5점(매우 그렇다)</p>
					</div>
					<table class="dataH07"> 
						<colgroup>
							<col width="5%">
							<col width="*">
							<col width="5%">
							<col width="5%">
							<col width="5%">
							<col width="5%">
							<col width="5%">
						</colgroup>
			
						<thead>
							<tr>
								<th class="t04" rowspan="2">번호</th>
								<th class="t04" rowspan="2">문항</th>
								<th class="t04" colspan="5">체크</th>
							</tr>
							<tr>
								<th class="t04">1</th>
								<th class="t04">2</th>
								<th class="t04">3</th>
								<th class="t04">4</th>
								<th class="t04">5</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>21</td>
								<td class="sbj">팀원들 간에 서로 협력하고 단합하는 팀분위기를 만든다.</td>
								<td><input type="radio" name="q_21" value="1"></td>
								<td><input type="radio" name="q_21" value="2"></td>
								<td><input type="radio" name="q_21" value="3"></td>
								<td><input type="radio" name="q_21" value="4"></td>
								<td><input type="radio" name="q_21" value="5"></td>
							</tr>
							<tr>
								<td>22</td>
								<td class="sbj">팀원들에 대해서 항상 존중하는 태도를 지니고, 담당자들의 입장과 상황을 이해한다.</td>
								<td><input type="radio" name="q_22" value="1"></td>
								<td><input type="radio" name="q_22" value="2"></td>
								<td><input type="radio" name="q_22" value="3"></td>
								<td><input type="radio" name="q_22" value="4"></td>
								<td><input type="radio" name="q_22" value="5"></td>
							</tr>
							<tr>
								<td>23</td>
								<td class="sbj">주요한 결정을 내린 후에는 소신있게 추진해 나간다.</td>
								<td><input type="radio" name="q_23" value="1"></td>
								<td><input type="radio" name="q_23" value="2"></td>
								<td><input type="radio" name="q_23" value="3"></td>
								<td><input type="radio" name="q_23" value="4"></td>
								<td><input type="radio" name="q_23" value="5"></td>
							</tr>
							<tr>
								<td>24</td>
								<td class="sbj">다양한 대안이 있을 경우 논리적이고 객관적인 근거에 따라 실행할 대안을 결정한다.</td>
								<td><input type="radio" name="q_24" value="1"></td>
								<td><input type="radio" name="q_24" value="2"></td>
								<td><input type="radio" name="q_24" value="3"></td>
								<td><input type="radio" name="q_24" value="4"></td>
								<td><input type="radio" name="q_24" value="5"></td>
							</tr>
							<tr>
								<td>25</td>
								<td class="sbj">팀 업무 중에 이슈가 발생할 경우에 신속하게 의사결정 해준다.</td>
								<td><input type="radio" name="q_25" value="1"></td>
								<td><input type="radio" name="q_25" value="2"></td>
								<td><input type="radio" name="q_25" value="3"></td>
								<td><input type="radio" name="q_25" value="4"></td>
								<td><input type="radio" name="q_25" value="5"></td>
							</tr>
							<tr>
								<td>26</td>
								<td class="sbj">팀원들에게 적합한 업무와 책임을 부여한다.</td>
								<td><input type="radio" name="q_26" value="1"></td>
								<td><input type="radio" name="q_26" value="2"></td>
								<td><input type="radio" name="q_26" value="3"></td>
								<td><input type="radio" name="q_26" value="4"></td>
								<td><input type="radio" name="q_26" value="5"></td>
							</tr>
							<tr>
								<td>27</td>
								<td class="sbj">우선순위에 따라 팀의 업무를 계획하고 추진한다.</td>
								<td><input type="radio" name="q_27" value="1"></td>
								<td><input type="radio" name="q_27" value="2"></td>
								<td><input type="radio" name="q_27" value="3"></td>
								<td><input type="radio" name="q_27" value="4"></td>
								<td><input type="radio" name="q_27" value="5"></td>
							</tr>
							<tr>
								<td>28</td>
								<td class="sbj">팀의 목표에 따라 체계적으로 업무를 진행시킨다.</td>
								<td><input type="radio" name="q_28" value="1"></td>
								<td><input type="radio" name="q_28" value="2"></td>
								<td><input type="radio" name="q_28" value="3"></td>
								<td><input type="radio" name="q_28" value="4"></td>
								<td><input type="radio" name="q_28" value="5"></td>
							</tr>
							<tr>
								<td>29</td>
								<td class="sbj">가용자원(시간, 예산, 인력)을 중요도, 시급도에 따라 효과적으로 배분한다.</td>
								<td><input type="radio" name="q_29" value="1"></td>
								<td><input type="radio" name="q_29" value="2"></td>
								<td><input type="radio" name="q_29" value="3"></td>
								<td><input type="radio" name="q_29" value="4"></td>
								<td><input type="radio" name="q_29" value="5"></td>
							</tr>
							<tr>
								<td>30</td>
								<td class="sbj">계획한 일정을 수시로 점검하여 업무진행에 차질이 없도록 관리한다.</td>
								<td><input type="radio" name="q_30" value="1"></td>
								<td><input type="radio" name="q_30" value="2"></td>
								<td><input type="radio" name="q_30" value="3"></td>
								<td><input type="radio" name="q_30" value="4"></td>
								<td><input type="radio" name="q_30" value="5"></td>
							</tr>
						</tbody>
					</table>
					<div class="survey">
						<a href="javascript:layerClose(4)">다음</a>
					</div>
				</div>
			
				<div id="survey_box5" class="point_box" style="display:none;">
					<div style="text-align:right;">
						<p style="color:red;">1점(매우 그렇지 않다) ~ 3점(보통이다)~5점(매우 그렇다)</p>
					</div>
					<table class="dataH07"> 
						<colgroup>
							<col width="5%">
							<col width="*">
							<col width="5%">
							<col width="5%">
							<col width="5%">
							<col width="5%">
							<col width="5%">
						</colgroup>
			
						<thead>
							<tr>
								<th class="t04" rowspan="2">번호</th>
								<th class="t04" rowspan="2">문항</th>
								<th class="t04" colspan="5">체크</th>
							</tr>
							<tr>
								<th class="t04">1</th>
								<th class="t04">2</th>
								<th class="t04">3</th>
								<th class="t04">4</th>
								<th class="t04">5</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>31</td>
								<td class="sbj">역량과 지식∙기술과의 차이점을 이해하고 있다.</td>
								<td><input type="radio" name="q_31" value="1"></td>
								<td><input type="radio" name="q_31" value="2"></td>
								<td><input type="radio" name="q_31" value="3"></td>
								<td><input type="radio" name="q_31" value="4"></td>
								<td><input type="radio" name="q_31" value="5"></td>
							</tr>
							<tr>
								<td>32</td>
								<td class="sbj">조직 상∙하간, 조직 내∙외간 의사소통의 중요성과 의사소통방법을 잘 이해하고 있다.</td>
								<td><input type="radio" name="q_32" value="1"></td>
								<td><input type="radio" name="q_32" value="2"></td>
								<td><input type="radio" name="q_32" value="3"></td>
								<td><input type="radio" name="q_32" value="4"></td>
								<td><input type="radio" name="q_32" value="5"></td>
							</tr>
							<tr>
								<td>33</td>
								<td class="sbj">5급 사무관(팀장)으로서 갖추어야 할 역량을 이해하고 있다.</td>
								<td><input type="radio" name="q_33" value="1"></td>
								<td><input type="radio" name="q_33" value="2"></td>
								<td><input type="radio" name="q_33" value="3"></td>
								<td><input type="radio" name="q_33" value="4"></td>
								<td><input type="radio" name="q_33" value="5"></td>
							</tr>
							<tr>
								<td>34</td>
								<td class="sbj">역할수행과 서류함기법의 특성에 대하여 이해하고 있다.</td>
								<td><input type="radio" name="q_34" value="1"></td>
								<td><input type="radio" name="q_34" value="2"></td>
								<td><input type="radio" name="q_34" value="3"></td>
								<td><input type="radio" name="q_34" value="4"></td>
								<td><input type="radio" name="q_34" value="5"></td>
							</tr>
							<tr>
								<td>35</td>
								<td class="sbj">5급 사무관과 6급 이하의 역할 차이를 역량 관점에서 이해하고 있다.</td>
								<td><input type="radio" name="q_35" value="1"></td>
								<td><input type="radio" name="q_35" value="2"></td>
								<td><input type="radio" name="q_35" value="3"></td>
								<td><input type="radio" name="q_35" value="4"></td>
								<td><input type="radio" name="q_35" value="5"></td>
							</tr>
						</tbody>
					</table>
					<div class="survey">
						<a href="javascript:resultForm();">설문종료</a>
					</div>
				</div>
			</div>
		</div>
	<!--[s] bottom -->
	<%-- <jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/> --%>
	<!--[e] bottom -->
		
	</form>
		
</div>
</body>

