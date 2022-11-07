<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강의기록 입력 팝업
// date  : 2008-07-07
// auth  : kang
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
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	    
	////////////////////////////////////////////////////////////////////////////////////
	
	
	String no = requestMap.getString("no");
	String userno = requestMap.getString("userno");
	String modify = requestMap.getString("modify");
	String grCode = requestMap.getString("grCode");
	String grSeq = requestMap.getString("grSeq");
	String subj = requestMap.getString("subj");
	
	String pmode = "";
	
	String strDate = "";
	String tDate = "";
	String tTime = "";
	String eduinwon = "";
	
	if(!no.equals("")){
		
		DataMap rowMap = (DataMap)request.getAttribute("ROW_MAP");
		if(rowMap == null) rowMap = new DataMap();
		rowMap.setNullToInitialize(true);
		
		if(rowMap.keySize("no") > 0){		
			for(int i=0; i < rowMap.keySize("no"); i++){
				strDate = rowMap.getString("strDate", i);
				tDate = rowMap.getString("tdate", i);
				tTime = rowMap.getString("ttime", i);
				eduinwon = rowMap.getString("eduinwon", i);
			}
		}
		pmode = "update";
	}else{
		pmode = "insert";
	}
	
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--



function fnSelectBoxByAjax(mode, divId, objId, code, codeNm, 
							findCode, width, asyn, isOneData, isLoading, 
							ptype){

	singleSelectBoxCreateCount += 1;

	var url = "/tutorMgr/lecHistory.do";
	var pars = "mode=" + mode;
	pars += "&objId=" + objId;
	pars += "&code=" + code;
	pars += "&codeNm=" + codeNm;
	pars += "&findCode=" + findCode;
	pars += "&width=" + width;
	pars += "&isOneData=" + isOneData;
	pars += "&ptype=" + ptype;
	
	pars += "&grCode=" + $F("grCode");
	pars += "&grSeq=" + $F("grSeq");
	pars += "&subj=" + $F("subj");
	
	
	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : asyn,
			method : "get", 
			parameters : pars,
			onLoading : function(){				
				
				$(objId).style.width = width;
				//$(objId).options.add(new Option("데이타 불러오는중..", ""));
				
				if(isLoading == "true"){
					$(document.body).startWaiting('bigWaiting');
				}
			},
			onSuccess : function(){
												
				singleSelectBoxCreateCount -= 1;
				
				if(singleSelectBoxCreateCount <= 0){
					if(isLoading == "true"){						
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						singleSelectBoxCreateCount = 0;
					}
				}
			},
			onFailure : function(){
			
				alert("셀렉트박스 생성시 오류가 발생했습니다.");
				$(objId).options.add(new Option("", ""));
				
				if(isLoading == "true"){
					window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
				}
			}			
		}
	);
}

//  기수
function fnGrSeq(){

	fnSelectBoxByAjax("lecCodeAjax",
					"divGrSeq", 
					"grSeq", 
					"codeseq", 
					"codenm", 
					"<%= grSeq %>", 
					"300", 
					"false", 
					"false", 
					"true",
					"grSeq");
					
	fnSubj();
}

// 과목
function fnSubj(){
	
	fnSelectBoxByAjax("lecCodeAjax",
					"divSubj", 
					"subj", 
					"codeseq", 
					"codenm", 
					"<%= subj %>", 
					"300", 
					"false", 
					"false", 
					"true",
					"subj");
}

// 저장
function fnSave(){

	if(NChecker($("sform"))){
	
		if( $F("grCode") == "" || $F("grSeq") == "" || $F("subj") == "" ){
			alert("과정, 기수, 과목은 모두 선택해야 합니다.");
			return;
		}
		
		if( parseInt($F("tDate")) > 5 ){
			alert("강의기간을 5일이내로 정확히 입력해 주십시요.");
			return;
		}
	
		if(confirm("저장하시겠습니까 ?")){			
			$("mode").value = "<%= pmode %>";
			sform.action = "/tutorMgr/lecHistory.do?mode=<%= pmode %>";
			sform.submit();			
		}
	
	}
}


//-->
</script>
<script for="window" event="onload">
<!--

	// 과정
	fnSelectBoxByAjax("lecCodeAjax",
					"divGrCode", 
					"grCode", 
					"codeseq", 
					"codenm", 
					"<%= grCode %>", 
					"300", 
					"false", 
					"false", 
					"true",
					"grCode");
	fnGrSeq();
	


//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="sform" name="sform" method="post" enctype="multipart/form-data">

<input type="hidden" name="menuId"	id="menuId"	value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" 	id="mode" 	value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="userno" 	id="userno" value="<%= userno %>">
<input type="hidden" name="no"		id="no" value="<%= no %>">

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" />강의기록 등록</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">
		
			<div id="idPrint">
			<table  class="dataw01">
				<tr>
					<th width="80">과정명</th>
					<td>
						<div id="divGrCode">
							<select name="grCode"></select>
						</div>
					</td>
				</tr>
				<tr>
					<th>과정기수</th>
					<td>
						<div id="divGrSeq">
							<select name="grSeq"></select>
						</div>
					</td>
				</tr>
				<tr>
					<th>과목</th>
					<td>
						<div id="divSubj">
							<select name="subj"></select>
						</div>
					</td>
				</tr>
				<tr>
					<th>강의시작일</th>
					<td>
						<input type="text" name="strDate" id="strDate" class="textfield" size="10" readonly required="true!강의시작일이 없습니다." value="<%= strDate %>">
						<img src="/images/icon_calendar.gif" border="0" align="absmiddle" onclick="fnPopupCalendar('','strDate');" style="cursor:hand;">
						※ 시작일을 지정하시면 자동으로 해당주의 금요일이 종료일이 됩니다. 월요일만 선택하세요.
					</td>
				</tr>
				<tr>
					<th>강의기간</th>
					<td>
						<input type="text" name="tDate" id="tDate" class="textfield" size="10" maxlength="5" required="true!강의기간이 없습니다." dataform="num!숫자만 입력해야 합니다." value="<%= tDate %>">						
						일수
						&nbsp;&nbsp;&nbsp;※ 5일 이내로 입력하세요.
					</td>
				</tr>
				<tr>
					<th>강의시간</th>
					<td>
						<input type="text" name="tTime" id="tTime" class="textfield" size="10" maxlength="5" required="true!강의시간이 없습니다." dataform="num!숫자만 입력해야 합니다." value="<%= tTime %>">
						시간
					</td>
				</tr>
				<tr>
					<th>강의인원</th>
					<td>
						<input type="text" name="eduinwon" id="eduinwon" class="textfield" size="10" maxlength="5" required="true!강의인원이 없습니다." dataform="num!숫자만 입력해야 합니다." value="<%= eduinwon %>">
						명
					</td>
				</tr>
				
			</table>
			</div>
			
			<!-- 하단 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="저 장" onclick="fnSave();" class="boardbtn1">
						&nbsp;&nbsp;
						<input type="button" value="닫 기" onclick="self.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 버튼  -->
		
		
		
		</td>
	</tr>
</table>

</form>
</body>