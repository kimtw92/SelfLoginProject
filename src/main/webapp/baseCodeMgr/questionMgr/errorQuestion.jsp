<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과목코드별 문항관리 - 오류 답안 처리
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%!
public static String setChecked(String input, String ca){
	List<String> list = Arrays.asList(ca.split("\\{\\^\\}"));
	return list.contains(input) ? "checked='checked'" : "";
}
%>

<%
    //request 데이터
// 	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
// 	requestMap.setNullToInitialize(true);

String msg = Util.nvl(request.getParameter("msg"));

DataMap question = (DataMap) request.getAttribute("question");

String validType = question.getString("idValidType");

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script type="text/javascript">

	if("<%=msg%>".length != 0){
		alert("<%=msg%>");
	}

	window.onload = function(){
		setInfo();
		createAns();
	};
	
	function setInfo(){
		qtype = "<%=question.getString("idQtype")%>";
		validType = "<%=validType%>";
		document.getElementsByName("validType2")[+validType].click();
		var divValidType = document.getElementById("div-validType");
		var divRadioGroup = document.getElementById("div-radio-group-valid"+qtype);
		divRadioGroup.style.display = "";
		divValidType.appendChild(divRadioGroup);
	}
	
	function createAns(){
		var ansHtml = "";
		switch(qtype){
		case "1":
			ansHtml += "<label><input name=\"ca\" type=\"checkbox\" value=\"1\" <%=setChecked("1", question.getString("ca"))%> > O</label>";
			ansHtml += "<label><input name=\"ca\" type=\"checkbox\" value=\"2\" <%=setChecked("2", question.getString("ca"))%> > X</label>";
			break;
		case "2":
			ansHtml += "<label><input name=\"ca\" type=\"checkbox\" value=\"1\" <%=setChecked("1", question.getString("ca"))%> > ①</label>";
			ansHtml += "<label><input name=\"ca\" type=\"checkbox\" value=\"2\" <%=setChecked("2", question.getString("ca"))%> > ②</label>";
			ansHtml += "<label><input name=\"ca\" type=\"checkbox\" value=\"3\" <%=setChecked("3", question.getString("ca"))%> > ③</label>";
			ansHtml += "<label><input name=\"ca\" type=\"checkbox\" value=\"4\" <%=setChecked("4", question.getString("ca"))%> > ④</label>";
			break;
		}
		document.getElementById("div-ca-pane").innerHTML = ansHtml;
	}

	function setMessage(radio){
// 		0	정상 문제
// 		1	오류 문제
// 		2	모두 정답 처리
		this["0"] = "정답을 1개만 선택하세요.";
		this["1"] = "정답을 모두 선택하세요.";
		this["2"] = "정답을 선택할 필요가 없습니다.";
		document.getElementById("p-msg").innerHTML = this[radio.value];
	}
	
	function getCheckedValue(el){
		if(!el.length){
			return el.value;
		}
		for(var i=0; i<el.length; i++){
			if(el[i].checked){
				return el[i].value; 
			}
		}
	}
	
	function countCheckedBoxByName(pname){
		var names = document.getElementsByName(pname);
		var cnt = 0;
		for(var i=0; i<names.length; i++){
			if(names[i].checked){
				cnt++;
			}
		}
		return cnt;
	}
	
	function checkNormalQuestion(){
		var cnt = countCheckedBoxByName("ca");
		if(cnt>1){
			return {chk:false, msg:"정상 문제일 경우 답은 1개만 선택 가능합니다."};
		}else if(cnt == 0){
			return {chk:false, msg:"정답을 1개 선택하셔야 합니다."};
		}
		return {chk:true, msg:"오류 문제 처리를 하시겠습니까?\n오류 문제 처리를 하게되면 이 문제가 출제된 모든 시험의 채점과 성적 처리를 다시 진행해야 됩니다."};
	}
	
	function checkErrorQuestion(){
		var cnt = countCheckedBoxByName("ca");
		if(cnt==0){
			return {chk:false, msg:"정답을 1개이상 선택해 주세요."};
		}
		return {chk:true, msg:"오류 문제 처리를 하시겠습니까?\n오류 문제 처리를 하게되면 이 문제가 출제된 모든 시험의 채점과 성적 처리를 다시 진행해야 됩니다."};
	}
	
	function checkErrorQuestion(){
		var cnt = countCheckedBoxByName("ca");
		if(cnt==0){
			return {chk:false, msg:"정답을 1개이상 선택해 주세요."};
		}
		return {chk:true, msg:"오류 문제 처리를 하시겠습니까?\n오류 문제 처리를 하게되면 이 문제가 출제된 모든 시험의 채점과 성적 처리를 다시 진행해야 됩니다."};
	}
	
	function checkOkAllQuestion(){
		return {chk:true, msg:"오류 문제 처리를 하시겠습니까?\n오류 문제 처리를 하게되면 이 문제가 출제된 모든 시험의 채점과 성적 처리를 다시 진행해야 됩니다."};
	}
	
	function validValues(){
		var validType = null;
		
		var validRadios = new Array();
		
		for(var i=1; i<=2; i++){
			
			var vt = pform["validType"+i];
			for(var j=0; vt && j<vt.length; j++){
				validRadios.push(vt[j]);
			}
		}
		
		validType = getCheckedValue(validRadios);
		var checkObj = null;
		switch(+validType){
		case 0:
			checkObj = checkNormalQuestion();
			break;
		case 1:
			checkObj = checkErrorQuestion();
			break;
		case 2:
			checkObj = checkOkAllQuestion();
			break;
		default:
			break;
		}
		if(checkObj.chk == true){
			return confirm(checkObj.msg);
		}else{
			alert(checkObj.msg);
			return checkObj.chk;
		}
	}
	
	function submitForm(){
		var chk = validValues();
		if(chk == true){
			pform.submit();
		}
	}
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="padding: 10px;">

<div id="div-radio-group-valid1" style="display: none;">
	<label><input name="validType1" type="radio" value="0" onclick="setMessage(this)" <%=setChecked("0", validType) %>> 정상 문제</label><br>
	<label><input name="validType1" type="radio" value="2" onclick="setMessage(this)" <%=setChecked("2", validType) %>> 모두 정답 처리</label><br>
</div>
<div id="div-radio-group-valid2" style="display: none;">
	<label><input name="validType2" type="radio" value="0" onclick="setMessage(this)" <%=setChecked("0", validType) %>> 정상 문제</label><br>
	<label><input name="validType2" type="radio" value="1" onclick="setMessage(this)" <%=setChecked("1", validType) %>> 정답 오류로 처리</label><br>
	<label><input name="validType2" type="radio" value="2" onclick="setMessage(this)" <%=setChecked("2", validType) %>> 모두 정답 처리</label>
</div>

<h3 align="center">정답 변경</h3>
<form name="pform" action="/baseCodeMgr/questionMgr.do" method="post" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="mode" value="updateErrorQuestion">
	<input type="hidden" name="idQ" value="<%=request.getParameter("idQ")%>">
	<table class="datah01">
		<tr><th colspan="3">오류 문제 정답 처리</th></tr>
		<tr>
			<td width="35%" style="text-align: left;">
				<div id="div-validType"></div>
			</td>
			<td width="35%" style="text-align: left;">
				<p id="p-msg">
				</p>
				<div id="div-ca-pane"></div>
			</td>
			<td width="30%" style="text-align: left;">
				<input type="button" value="확인" class="boardbtn1" onclick="submitForm()">
				<input type="button" value="취소" class="boardbtn1" onclick="window.close();">
			</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align: left;">
				<p>
					&lt;정상 문제&gt;<br>
					&nbsp;&nbsp;문제 유형에 맞게 정답 오류가 없는 문제입니다. 정상적으로 처리가 가능합니다.
				</p>
				
				<p>
					&lt;정답 오류&gt;<br>
					&nbsp;&nbsp;정답을 1개만 선택하는 선다형의 경우에만 해당됩니다.<br>
					&nbsp;&nbsp;원래 정답이 1개였으나 출제 후에 문제의 정답에 오류가 발견되어서 원래 정답외 다른 보기 지문도 정답으로 인정이 된다면 해당 보기 지문도 정답으로 인정해서 채점합니다. 예를 들어 정답이 1번인데 3번도 정답으로 볼 수 있다면 1번, 3번 모두 체크해놓으면 TMan에서 채점시 반영이 됩니다.
				</p>
				
				<p>
					&lt;모두 정답 처리&gt;<br>
					&nbsp;&nbsp;문제 자체에 오류가 있어서 모든 응시자의 답안을 답안 제출 유무와 관계없이 정답으로 처리합니다.
				</p>
				
				<hr>
				
				<p>
					&nbsp;&nbsp;&lt;정답 오류&gt; 와 &lt;모두 정답 처리&gt; 두가지 경우는 다음 출제할 때 이 문제를 사용할 수 없습니다. 반드시 출제해야 한다면 이 문제를 복사해서 새로 복사한 문제를 편집해서 사용하시기 바랍니다.
				</p>
				
				<p>
					&nbsp;&nbsp;문제 상태를 변경할 경우 이미 채점이 진행되었다면 TMan에서 채점과 통계 처리를 다시 해야 성적에 반영이 됩니다.<br>
					&nbsp;&nbsp;출제 횟수가 1회 이상이라면 문제 상태를 변경할 경우 이전 시험에서 정확한 성적 조회가 필요하다면 필요한 모든 시험에서 채점을 다시 해야 됩니다.
				</p>
				
				<hr>
			</td>
		</tr>
	</table>
</form>
</body>