<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    
    DataMap examMList = (DataMap)request.getAttribute("examMList");
    
    StringBuilder radioBuilder = new StringBuilder();
    
    for(int i=0; i<examMList.keySize("idExam"); i++){
    	radioBuilder
    			.append("		<label><input name=\"idExam\" type=\"radio\" ")
    			.append(i == 0 ? "checked" : "")
    			.append(" value=\"")
    			.append(examMList.getString("idExam",i))
    			.append("\" >")
    			.append(examMList.getString("title",i))
    			.append("</label><br>")
    			;
    }
    
    String idExam = request.getParameter("idExam") == null ? examMList.getString("idExam") : request.getParameter("idExam");
    
    %>
<!-- <script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script> -->
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<style type="text/css">
	.onTap {
		border : #5071b4 solid 1px;
		background-color: #5071b4;
		font : bolder;
		color : #ffffff;
		display: inline;
		width : 100px;
		height : 30px;
		cursor: pointer;
		text-align: center;
	}
	.offTap {
		border : #5071b4 solid 1px;
		background-color: #ffffff;
		font : bolder;
		display: inline;
		width : 100px;
		height : 30px;
		cursor: pointer;
		text-align: center;
	}
</style>

<body>
<script type="text/javascript">

	
	window.onload = function(){
		
		grcode = '<%=request.getParameter("grcode")%>';
		grseq = '<%=request.getParameter("grseq")%>';
		subj = '<%=request.getParameter("subj")%>';
		subjnm = '<%=request.getParameter("subjnm")%>';
		idExam = '<%=idExam %>';
		stareType = 1;
		buttonGroupAll = new Array();
		buttonGroup1 = new Array();
		buttonGroup2 = new Array();
		buttonGroup3 = new Array();
		buttonGroup4 = new Array();
		
		var btnScoring = document.getElementById("btn-scoring");
		btnScoring.onclick = function(){
			scoringAns(grcode, grseq, subj, 2);
		};
		buttonGroupAll.push(btnScoring);
		buttonGroup2.push(btnScoring);
		
		var radioIdExam = document.form1.idExam;
		for(var i=0; i<radioIdExam.length; i++){
			radioIdExam[i].onclick = function(){
				getAns(grcode, grseq, subj, subjnm, this.value, stareType);
			};
		}
		
		var btnNoEnd = document.getElementById("btn-no-end");
		btnNoEnd.onclick = function(){
			completeAns(grcode, grseq, subj, 'N');
		};
		buttonGroupAll.push(btnNoEnd);
		buttonGroup1.push(btnNoEnd);
		
		var btnEnd = document.getElementById("btn-end");
		btnEnd.onclick = function(){
			completeAns(grcode, grseq, subj, 'Y');
		};
		buttonGroupAll.push(btnEnd);
		buttonGroup2.push(btnEnd);
		
		var btnDelete = document.getElementById("btn-delete");
		btnDelete.onclick = function(){
			deleteAns();
		};
		buttonGroupAll.push(btnDelete);
		buttonGroup1.push(btnDelete);
		buttonGroup2.push(btnDelete);
		buttonGroup3.push(btnDelete);
		
		var btnRestore = document.getElementById("btn-restore");
		btnRestore.onclick = function(){
			restoreAns();
		};
		buttonGroupAll.push(btnRestore);
		buttonGroup4.push(btnRestore);
		
		var btnExcel = document.getElementById("btn-excel");
		btnExcel.onclick = function(){
			requestMGGS("ansExcel", grcode, grseq, subj);
		};
		buttonGroupAll.push(btnExcel);
		buttonGroup1.push(btnExcel);
		buttonGroup2.push(btnExcel);
		buttonGroup3.push(btnExcel);
		buttonGroup4.push(btnExcel);
		
		
		var btnScoringExcel = document.getElementById("btn-scoring-excel");
		btnScoringExcel.onclick = function(){
			requestMGGS("ansScoringListExcel", grcode, grseq, subj);
		};
		buttonGroupAll.push(btnScoringExcel);
		buttonGroup1.push(btnScoringExcel);
		
		var btnLms = document.getElementById("btn-lms");
		btnLms.onclick = function(){
			requestMGGS("sendToLms", grcode, grseq, subj, "POST");
		};
		buttonGroupAll.push(btnLms);
		buttonGroup1.push(btnLms);
		
		getAns(grcode, grseq, subj, subjnm, idExam, stareType);
	}
	
	function completeAns(grcode, grseq, subj, ynEnd){
		var url = "/courseMgr/offScoring.do";
		var pars = "mode=completeAns&grcode="+grcode+"&grseq="+grseq+"&subj="+subj+"&ynEnd="+ynEnd;
		var form1 = document.getElementById("completeAnsForm");
		form1.action = url+"?"+pars;
		form1.target = "hiddenFrame";
		form1.submit();
		
	}
	
	function serializeCheckboxByClass(className, includeName){
		var checkboxes = document.getElementsByClassName(className);
		if(checkboxes.length == 0){
			return "";
		}
		var name = checkboxes[0].name;
		var checkedArray = new Array();
		for(var i=0; i<checkboxes.length; i++){
			if(checkboxes[i].checked){
				checkedArray.push(checkboxes[i]);
			}
		}
		if(includeName == false){
			return checkedArray.toString();
		}
		var result = "";
		for(var i=0; i<checkedArray.length; i++){
			result += "&" + name + "=" + checkedArray[i].value;
		}
		
		return result;
	}
	
	function scoringAns(grcode, grseq, subj, pStareType){
		var url = "/courseMgr/offScoring.do";
		var pars = "mode=scoringAns&grcode="+grcode+"&grseq="+grseq+"&subj="+subj+
						"&idExam="+getRadioValue(document.form1.idExam)+"&stareType="+pStareType
						+ serializeCheckboxByClass("checkboxUserNo");
						;
		var request = new Ajax.Request (
			url,
			{
				method:"POST",
				parameters : pars,
				onSuccess :  function(request){
					var response = request.responseText;
					alert(response);
					getAns(grcode, grseq, subj, '', getRadioValue(document.form1.idExam), 2);
				},
				onFailure :  function(){
					alert("통신중 오류가 발생했습니다.");
				}
			}	
		);

		
	}

	function getAns(grcode, grseq, subj, subjnm, idExam, pStareType){
		var url = "/courseMgr/offScoring.do";
		var pars = "mode=ansAjax&grcode="+grcode+"&grseq="+grseq+"&subj="+subj+"&idExam="+idExam+"&stareType="+pStareType;
		var divId = "divAns";
		var myAjax = new Ajax.Updater(
			{success:divId},
			url, 
			{
				asynchronous : false,
				method: "get", 
				parameters: pars,
				onFailure: function(){
					alert("통신중 오류가 발생했습니다.");
				}
			}
		);
		onTap(null, pStareType);
	}
	
	function getRadioValue(el){
		if(!el.length){
			return el.value;
		}
		for(var i=0; i<el.length; i++){
			if(el[i].checked){
				return el[i].value; 
			}
		}
	}
	
	function requestMGGS(pmode, pgrcode, pgrseq, psubj, method){
		
		var form1 = document.createElement("form");
		
		form1.name = "tempForm";
		form1.action = "/courseMgr/offScoring.do";
		form1.target = "hiddenFrame";
		form1.method = method || "GET";
		
		var idExam = document.createElement("input");
		idExam.name = "idExam";
		idExam.type = "text";
		idExam.value = getRadioValue(document.form1.idExam);
		
		form1.appendChild(idExam);
		
		var mode = document.createElement("input");
		mode.name = "mode";
		mode.type = "text";
		mode.value = pmode;
		
		form1.appendChild(mode);
		
		var grcode = document.createElement("input");
		grcode.name = "grcode";
		grcode.type = "text";
		grcode.value = pgrcode;
		
		form1.appendChild(grcode);
		
		var grseq = document.createElement("input");
		grseq.name = "grseq";
		grseq.type = "text";
		grseq.value = pgrseq;
		
		form1.appendChild(grseq);
		
		var subj = document.createElement("input");
		subj.name = "subj";
		subj.type = "text";
		subj.value = psubj;
		
		form1.appendChild(subj);
		
		document.body.appendChild(form1);
		
		form1.submit();
		
		document.body.removeChild(form1);
	}
	
	function selectAll(el){
		var form1 = document.getElementById("completeAnsForm");
		var checkboxes = form1.userno;
		
		for(var i=0; i<checkboxes.length; i++){
			checkboxes[i].checked = el.checked;
		}
	}
	
	function setDisplay(elArr, pdisplay){
		for(var i=0; i<elArr.length; i++){
			elArr[i].style.display = pdisplay;
		}
	}
	
	function onTap(el, idx){
		var onTaps = document.getElementsByClassName("onTap");
		for(var i=0; i<onTaps.length; i++){
			onTaps[i].className = "offTap";
		}
		if(idx){
			var tds = document.getElementById("tap").getElementsByTagName("td");
			tds[idx-1].className = "onTap";
		}else{
			el.className = "onTap";
		}
		
		setDisplay(buttonGroupAll, "none");
		var buttonGroup = window["buttonGroup"+idx];
		setDisplay(buttonGroup, "inline");
	}
	
	function getTapData(el, pStareType){
		getAns(grcode, grseq, subj, subjnm, idExam, pStareType);
// 		onTap(el);
	}
	
	function deleteAns(){
		var msg = "선택한 응시자의 답안지를 삭제하시겠습니까?\n"
						+ "답안지를 삭제하면 나중에 복구 목록에서 복구할 수 있습니다.\n"
						+ "재 시험을 치르게 할 때만 삭제하시기 바랍니다.\n";
		if(!confirm(msg)){
			return;
		}
		
		msg = serializeCheckboxByClass("checkboxUserNo", false)
					+ "응시자 답안지를 삭제합니다.\n 계속 하시겠습니까?\n\n"
					+ "[취소]를 누르면 삭제가 취소됩니다.";
		if(!confirm(msg)){
			return;
		}
		
		var url = "/courseMgr/offScoring.do";
		var pars = "mode=deleteAns&grcode="+grcode+"&grseq="+grseq+"&subj="+subj+
						"&idExam="+getRadioValue(document.form1.idExam)
						+ serializeCheckboxByClass("checkboxUserNo");
						;
		var request = new Ajax.Request (
			url,
			{
				method:"POST",
				parameters : pars,
				onSuccess :  function(request){
					var response = request.responseText;
					alert(response);
					getAns(grcode, grseq, subj, '', getRadioValue(document.form1.idExam), 4);
				},
				onFailure :  function(){
					alert("통신중 오류가 발생했습니다.");
				}
			}	
		);
	}
	
</script>

<iframe id="hiddenFrame" name="hiddenFrame" width="0" height="0"></iframe>
<br>
<br>
<h3 align="center">
	<%=request.getParameter("subjnm") %>
</h3>

<div>
	<p align="center">
		 OMR 답안지 업로드(*.txt)
	</p>
	<form name="form1" action="/courseMgr/offScoring.do?mode=saveAns" method="post" enctype="multipart/form-data" target="hiddenFrame">
		<input name="UPLOAD_DIR" type="hidden" value="/omr_temp/">
		<input name="grcode" type="hidden" value="<%=request.getParameter("grcode")%>">
		<input name="grseq" type="hidden" value="<%=request.getParameter("grseq")%>">
		<input name="subj" type="hidden" value="<%=request.getParameter("subj")%>">
		<table class="datah01">
			<thead>
			<tr>
				<th>
					시험
				</th>
				<th>
					답안지 업로드
				</th>
			</tr>
			</thead>
			<tbody>
				<tr>
					<td align="left">
						<%=radioBuilder.toString() %>
					</td>
					<td>
						<input name="file" type="file" accept="text/plain">
						<input type="submit" value="저장">
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<div align="right">
	<input id="btn-no-end" type="button" value="미완료" class="boardbtn1">
	<input id="btn-end" type="button" value="완료" class="boardbtn1">
	<input id="btn-scoring" type="button" value="채점" class="boardbtn1">
	<input id="btn-delete" type="button" value="답안지 삭제" class="boardbtn1">
	<input id="btn-restore" type="button" value="답안지 복구" class="boardbtn1">
	<input id="btn-excel" type="button" value="엑셀" class="boardbtn1">
	<input id="btn-scoring-excel" type="button" value="채점 대사리스트" class="boardbtn1">
	<input id="btn-lms" type="button" value="LMS 내보내기" class="boardbtn1">
</div>
<form id="completeAnsForm" method="post">
<!-- 	<div class="onTap">완료</div> -->
<!-- 	<div class="offTap">미완료</div> -->
<!-- 	<div class="offTap">미응시</div> -->
<!-- 	<div class="offTap">삭제된 답안지</div> -->
	<table id="tap" cellpadding="0" cellspacing="0">
		<tr>
			<td class="onTap" onclick="getTapData(this,1)">완료
			</td>
			<td class="offTap" onclick="getTapData(this,2)">미완료
			</td>
			<td class="offTap" onclick="getTapData(this,3)">미응시
			</td>
			<td class="offTap" onclick="getTapData(this,4)">삭제된 답안지
			</td>
		</tr>
	</table>
	<div id="divAns">
	</div>
</form>

</body>