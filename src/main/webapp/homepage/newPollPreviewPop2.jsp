<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%  
// prgnm : 인터넷 설문 미리보기
// date : 2008-09-23
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

%>
						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript" src="http://code.jquery.com/jquery-1.7.2.js"></script>
<script>

function go_submit(){
	
	 if(go_inputCheck()){
		window.close();
		document.pform.submit();
		return true;
	}else{
		return false;
	}
}

function go_inputCheck(){
	//문제 갯수.
	<%-- var qArray = new Array(<%//= listMap.keySize("questionNo") %>); --%>
	/* var radio1 = $(':input[id="radioBtn"]:radio:checked').val();
	
	if(radio1){
		alert("설문조사에 응해주셔서 감사합니다.");
		return true;
	} else{
		alert("모든 항목에 참여해주세요");
		return false;
	} */
	
/* 	var radio1 = document.querySelector('input[id="radioBtn"]').checked;
	
	if(radio1){
		alert("설문조사에 응해주셔서 감사합니다.");
		return true;
	} else{
		alert("모든 항목에 참여해주세요");
		return false;
	} */ 
	
 	/* var chkRadio = document.getElementsByName('poll_1');
	var chk_cnt = 0;
	for(var i = 0; chkRadio.length; i++){
		if(chkRadio[i].checked == true) chk_cnt++;
	}
	
	if(chk_cnt < 1){
		alert("모든 항목에 참여해주세요");
		return false;
	}  */
	
    /* var radio1 = document.getElementById("radioBtn")
	if(radio1 !=true){
		alert("모든 항목에 참여해주세요");
		radio1.focus();
		return false;
	} */
	
	/* var radio1 = document.getElementById("radioBtn_1");
	var radio2 = document.getElementById("radioBtn_2");
	var radio3 = document.getElementById("radioBtn_3");
	var radio4 = document.getElementById("radioBtn_4");
	var radio5 = document.getElementById("radioBtn_5");
	var radio6 = document.getElementById("radioBtn_6");
	var radio7 = document.getElementById("radioBtn_7");
	var radio8 = document.getElementById("radioBtn_8");
	var radio9 = document.getElementById("radioBtn_9");
	var radio10 = document.getElementById("radioBtn_10");
	var isboolean = false;
	
	if(radio1.checked != true && radio2.checked != true && radio3.checked != true && radio4.checked != true && radio5.checked != true 
			&& radio6.checked != true && radio7.checked != true && radio8.checked != true && radio9.checked != true && radio10.checked != true){
		alert("설문조사에 응해주셔서 감사합니다.");
	} 
	
 	if(isboolean){
		alert("설문조사에 응해주셔서 감사합니다.");
	} else {
		alert("모두 체크해주세요.");
		return;
	} */
	
	/* var radio1 = document.querySelector('input[name="poll_1"]:checked');
	if(radio1 != null){
		alert("설문조사에 응해주셔서 감사합니다.");
	}else{
		alert("모두 체크해주세요.")
	} */
	
	/* if(document.getElementById("radioBtn").checked){
		var selected = document.getElementById("radioBtn").value;
		alert("선택된 버튼은" + selected);
	} */
	
/* 	var radio1 = document.getElementsByName('poll_1');
	var radio2 = document.getElementsByName("poll_2");
	var radio3 = document.getElementsByName("poll_3");
	var radio4 = document.getElementsByName("poll_4");
	var radio5 = document.getElementsByName("poll_5");
	var radio6 = document.getElementsByName("poll_6");
	var radio7 = document.getElementsByName("poll_7");
	var radio8 = document.getElementsByName("poll_8");
	var radio9 = document.getElementsByName("poll_9");
	var radio10 = document.getElementsByName("poll_10");
	var sel_type = null;
	for(var i = 0; 10; i++){
		for(var j = 0; radio[i].length; j++){
			if(radio[i][j].checked == true){
				sel_type = radio[i][j].value;
			}
		}
	}
	
	
	if(sel_type == null){
		alert("모두 체크해주세요.");
		return false;
	} */
	
	/* var radioObj = document.all('poll_1', 'poll_2', 'poll_3', 'poll_4', 'poll_5', 'poll_6', 'poll_7', 'poll_8', 'poll_9', 'poll_10');
	var isChecked;
	if(radioObj.length == null){
		isChecked = radioObj.checked;
	}else{
		for(i = 0; radioObj.length; i++){
			if(radioObj[i].checked){
				isChecked = true;
				break;
			}
		}
	}
	
	if(isChecked){
		alert("체크있음");
	}else{
		alert("체크없음");
	} */
	
/* 	 if(!$("#poll_1").is(":checked")){
		alert("아무거나 누르셈");
		return;
	}  */
	
	/* if(!$('input:radio[name=poll_1]').is(':checked')){
		alert("ㅋㅋ");
	} */
	
	/* if(!$(':input:radio[id=radioBtn_1]:checked').val()){
		alert("선택좀");
		return
	}  */
	
	/* var flag = false;
	
	$('input:radio[name="'+name+'"]').each(function(){
		if($(this).is(":checked")){
			flag = true;
		}
	});
	
	return flag;
	
	if(!flag){
		alert("아니");
		return false;
	} */
	
	/* var chkRadio = document.getElementsByName('poll_1');
	var chk_cnt = 0;
	for(var i = 0; chkRadio.length; i++){
		if(chkRadio[i].checked == true) chk_cnt++;
	}
	
	if(chk_cnt < 1){
		alert("모든 항목에 참여해주세요");
		return false;
	} */
	
	/* var arrRadio1 = document.getElementsByName("poll_1");
	var arrRadio2 = document.getElementsByName("poll_2");
	var arrRadio3 = document.getElementsByName("poll_3");
	var arrRadio4 = document.getElementsByName("poll_4");
	var arrRadio5 = document.getElementsByName("poll_5");
	var arrRadio6 = document.getElementsByName("poll_6");
	var arrRadio7 = document.getElementsByName("poll_7");
	var arrRadio8 = document.getElementsByName("poll_8");
	var arrRadio9 = document.getElementsByName("poll_9");
	var arrRadio10 = document.getElementsByName("poll_10");
	var radioChk = true;
	for(var i = 0; arrRadio1.length; i++){
		if(arrRadio1[i].checked){
			//alert(arrRadio1[i].value + "굿굿");
			radioChk = false;
			break;
		}
		if(!arrRadio1[i].checked){
			//alert(arrRadio1[i].value + "이건좀");
			radioChk = true;
		}
	}
	
	for(var i = 0; arrRadio2.length; i++){
		if(arrRadio2[i].checked){
			//alert(arrRadio2[i].value + "굿굿");
			radioChk = true;
			break;
		}
		if(!arrRadio2[i].checked){
			//alert(arrRadio2[i].value + "이건좀");
			radioChk = false;
		}
	}
	
	for(var i = 0; arrRadio3.length; i++){
		if(arrRadio3[i].checked){
			alert(arrRadio3[i].value + "굿굿");
			radioChk = true;
			break;
		}
		if(!arrRadio3[i].checked){
			alert(arrRadio3[i].value + "이건좀");
			radioChk = false;
		}
	}
	
	for(var i = 0; arrRadio4.length; i++){
		if(arrRadio4[i].checked){
			alert(arrRadio4[i].value + "굿굿");
			radioChk = true;
			break;
		}
		if(!arrRadio4[i].checked){
			alert(arrRadio4[i].value + "이건좀");
			radioChk = false;
		}
	}
	
	for(var i = 0; arrRadio5.length; i++){
		if(arrRadio5[i].checked){
			alert(arrRadio5[i].value + "굿굿");
			radioChk = true;
			break;
		}
		if(!arrRadio5[i].checked){
			alert(arrRadio5[i].value + "이건좀");
			radioChk = false;
		}
	}
	
	for(var i = 0; arrRadio6.length; i++){
		if(arrRadio6[i].checked){
			alert(arrRadio6[i].value + "굿굿");
			radioChk = true;
			break;
		}
		if(!arrRadio6[i].checked){
			alert(arrRadio6[i].value + "이건좀");
			radioChk = false;
		}
	}
	
	for(var i = 0; arrRadio7.length; i++){
		if(arrRadio7[i].checked){
			alert(arrRadio7[i].value + "굿굿");
			radioChk = true;
			break;
		}
		if(!arrRadio7[i].checked){
			alert(arrRadio7[i].value + "이건좀");
			radioChk = false;
		}
	}
	
	for(var i = 0; arrRadio8.length; i++){
		if(arrRadio8[i].checked){
			alert(arrRadio8[i].value + "굿굿");
			radioChk = true;
			break;
		}
		if(!arrRadio8[i].checked){
			alert(arrRadio8[i].value + "이건좀");
			radioChk = false;
		}
	}
	
	for(var i = 0; arrRadio9.length; i++){
		if(arrRadio9[i].checked){
			alert(arrRadio9[i].value + "굿굿");
			radioChk = true;
			break;
		}
		if(!arrRadio9[i].checked){
			alert(arrRadio9[i].value + "이건좀");
			radioChk = false;
		}
	}
	
	for(var i = 0; arrRadio10.length; i++){
		if(arrRadio10[i].checked){
			alert(arrRadio10[i].value + "굿굿");
			radioChk = true;
			break;
		}
		if(!arrRadio10[i].checked){
			alert(arrRadio10[i].value + "이건좀");
			radioChk = false;
		}
	}
	
	if(!radioChk){
		alert("모든 항목에 참여해주세요");
		return false;
		
	}else{
		alert("아주 구시에요");
	} */
	
	/* var error = '';
	
	$('div.poll_q').each(function(){
		var poll_a = $(this).find('dl.q_no').text();//해당설문이름
		var checkBtn = $(this).find('input[type="radio"]:checked');//체크한것들
		
		if(!checkBtn.length){
			error += poll_a+'를 선택하시기 바랍니다.\n';//경고문저장
		}
	})
	
	if(error){
		alert("error");
		return false;
	} */
	
	/* var count = 0;
	for(var i = 1; i <= 10; i++){
		if($('radio[name="poll_' + i +'"]:checked').length < 1){
			
		}else{		
			count++;
		}
		
		if(count < 10){
			alert("모든 항목에 참여해주세요");
		}
	} */
	
	var cnt = 0;
	
	$('.poll_a').each(function(){
		var $radio = $(this).find('input:radio');
		var isCheck = true;
		$radio.each(function(){
			if($(this).is(":checked")){
				isCheck = false;
				return true;
			}
		});
		
		if(isCheck){
			cnt++;	
		}
		
	});
	
	if(cnt > 0){
		alert("체크 안한 항목이 있습니다.");
		return false;
	}
	<%
	
%>


}

/******** 이상 없으면 False 값으로 반환 됨. **************/


</script>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post"  action="/poll/coursePoll.do" onsubmit="go_submit();return false">	

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img  src="/images/bullet_pop.gif" /> 시설이용만족도 항목</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<!--설문-->
			<div class="pollset">
				<div class='poll_q'>
					<dl class='q_no'>
						<dt>질문1</dt>
						<dd>편의 시설에 대해 전반적으로 만족하십니까?</dd>
					</dl>
				</div>
				<ul class='poll_a'>
					<li>
						<input type='radio' name='poll_1' value='5'>매우 그렇다. <br/>
						<input type='radio' name='poll_1' value='4'>그렇다. <br/>
						<input type='radio' name='poll_1' value='3'>보통 <br/>
						<input type='radio' name='poll_1' value='2'>아니다. <br/>
						<input type='radio' name='poll_1' value='1'>전혀 아니다.
					</li>
				</ul>
				<div class='poll_q'>
					<dl class='q_no'>
						<dt>질문2</dt>
						<dd>화장실, 강의실 등 청결에 만족하십니까?</dd>
					</dl>
				</div>
				<ul class='poll_a'>
					<li>
						<input type='radio' name='poll_2' value='5'>매우 그렇다. <br/>
						<input type='radio' name='poll_2' value='4'>그렇다. <br/>
						<input type='radio' name='poll_2' value='3'>보통 <br/>
						<input type='radio' name='poll_2' value='2'>아니다. <br/>
						<input type='radio' name='poll_2' value='1'>전혀 아니다.  
					</li>
				</ul>
				<div class='poll_q'>
					<dl class='q_no'>
						<dt>질문3</dt>
						<dd>대관 사용료는 적정하다고 생각하십니까?</dd>
					</dl>
				</div>
				<ul class='poll_a'>
					<li>
						<input type='radio' name='poll_3' value='5'>매우 그렇다. <br/>
						<input type='radio' name='poll_3' value='4'>그렇다. <br/>
						<input type='radio' name='poll_3' value='3'>보통 <br/>
						<input type='radio' name='poll_3' value='2'>아니다. <br/>
						<input type='radio' name='poll_3' value='1'>전혀 아니다.  
					</li>
				</ul>
				<div class='poll_q'>
					<dl class='q_no'>
						<dt>질문4</dt>
						<dd>인재개발원의 접근성에 있어서 편리하십니까?</dd>
					</dl>
				</div>
				<ul class='poll_a'>
					<li>
						<input type='radio' name='poll_4' value='5'>매우 그렇다. <br/>
						<input type='radio' name='poll_4' value='4'>그렇다. <br/>
						<input type='radio' name='poll_4' value='3'>보통 <br/>
						<input type='radio' name='poll_4' value='2'>아니다. <br/>
						<input type='radio' name='poll_4' value='1'>전혀 아니다.   
					</li>
				</ul>
				<div class='poll_q'>
					<dl class='q_no'>
						<dt>질문5</dt>
						<dd>주차공간 등 부대시설에 대하여 만족하십니까?</dd>
					</dl>
				</div>
				<ul class='poll_a'>
					<li>
						<input type='radio' name='poll_5' value='5'>매우 그렇다. <br/>
						<input type='radio' name='poll_5' value='4'>그렇다. <br/>
						<input type='radio' name='poll_5' value='3'>보통 <br/>
						<input type='radio' name='poll_5' value='2'>아니다. <br/>
						<input type='radio' name='poll_5' value='1'>전혀 아니다.  
					</li>
				</ul>
				<div class='poll_q'>
					<dl class='q_no'>
						<dt>질문6</dt>
						<dd>시설 대관 예약 절차에 대하여 만족하십니까?</dd>
					</dl>
				</div>
				<ul class='poll_a'>
					<li>
						<input type='radio' name='poll_6' value='5'>매우 그렇다. <br/>
						<input type='radio' name='poll_6' value='4'>그렇다. <br/>
						<input type='radio' name='poll_6' value='3'>보통 <br/>
						<input type='radio' name='poll_6' value='2'>아니다. <br/>
						<input type='radio' name='poll_6' value='1'>전혀 아니다.  
					</li>
				</ul>
				<div class='poll_q'>
					<dl class='q_no'>
						<dt>질문7</dt>
						<dd>대관 신청에 대하여 공평하다고 생각하십니까?</dd>
					</dl>
				</div>
				<ul class='poll_a'>
					<li>
						<input type='radio' name='poll_7' value='5'>매우 그렇다. <br/>
						<input type='radio' name='poll_7' value='4'>그렇다. <br/>
						<input type='radio' name='poll_7' value='3'>보통 <br/>
						<input type='radio' name='poll_7' value='2'>아니다. <br/>
						<input type='radio' name='poll_7' value='1'>전혀 아니다.   
					</li>
				</ul>
				<div class='poll_q'>
					<dl class='q_no'>
						<dt>질문8</dt>
						<dd>지인에게 인재개발원 대관을 추천하고 싶으십니까?</dd>
					</dl>
				</div>
				<ul class='poll_a'>
					<li>
						<input type='radio' name='poll_8' value='5'>매우 그렇다. <br/>
						<input type='radio' name='poll_8' value='4'>그렇다. <br/>
						<input type='radio' name='poll_8' value='3'>보통 <br/>
						<input type='radio' name='poll_8' value='2'>아니다. <br/>
						<input type='radio' name='poll_8' value='1'>전혀 아니다.   
					</li>
				</ul>
				<div class='poll_q'>
					<dl class='q_no'>
						<dt>질문9</dt>
						<dd>인재개발원에서 지속적으로 대관하실 의향이 있으십니까?</dd>
					</dl>
				</div>
				<ul class='poll_a'>
					<li>
						<input type='radio' name='poll_9' value='5'>매우 그렇다. <br/>
						<input type='radio' name='poll_9' value='4'>그렇다. <br/>
						<input type='radio' name='poll_9' value='3'>보통 <br/>
						<input type='radio' name='poll_9' value='2'>아니다. <br/>
						<input type='radio' name='poll_9' value='1'>전혀 아니다.   
					</li>
				</ul>
				<div class='poll_q'>
					<dl class='q_no'>
						<dt>질문10</dt>
						<dd>인재개발원의 대관 운영이 지역발전에 기여한다고 생각하십니까?</dd>
					</dl>
				</div>
				<ul class='poll_a'>
					<li>
						<input type='radio' name='poll_10' value='5'>매우 그렇다. <br/>
						<input type='radio' name='poll_10' value='4'>그렇다. <br/>
						<input type='radio' name='poll_10' value='3'>보통 <br/>
						<input type='radio' name='poll_10' value='2'>아니다. <br/>
						<input type='radio' name='poll_10' value='1'>전혀 아니다.  
					</li>
				</ul>
			</div>
			<!--//설문-->
			<div class="space01"></div>

			<!-- 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">						
						<input type="submit"value="확인" class="boardbtn1">						
						<input type="button" value="닫기" onclick="window.close();" class="boardbtn1">											
					</td>
				</tr>
			</table>
			<!--// 닫기 버튼  -->
			<div class="h10"></div>
		</td>
	</tr>
</table>

</form>

</body>