<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 선택과목 등록, 수정
// date  : 2008-06-03
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
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	String mode = "";
	if(requestMap.getString("mode").equals("oform")){
		mode = "oInsert";
	}else{
		mode = "oUpdate";
	}
	
	String strSubTitle = "선택과목 등록";
	String btnTitle = "등 록";
	String btnDeleteDisplay = " style='display:none' ";
	String divSubjGrpDisplay = "";
	String delYn = "";
	
	StringBuffer sbSubjGrp = new StringBuffer();
	
	// 업데이트 모드시 값 저장용
	String subj = "";				// 과목코드
	String subject_name = "";		// 과목명 
	String subjgubun = "";			// 과목분류
	String subjtype = "N";			// 과목유형
	String appGubun = "S";			// 과목선택 타입
	String useYn = "Y";				// 사용여부
	String evalutegubun = "";		// 평가유형
	
	if(mode.equals("oUpdate")){
		// 수정모드임
		strSubTitle = "선택과목 수정";
		btnTitle = "수 정";
		btnDeleteDisplay = "";
		
		divSubjGrpDisplay = " style='display:none' ";
		
		DataMap subjRowMap = (DataMap)request.getAttribute("SUBJROW_DATA");
		subjRowMap.setNullToInitialize(true);
		
		DataMap subjGrpMap = (DataMap)request.getAttribute("SUBJGRP_DATA");
		subjGrpMap.setNullToInitialize(true);
		
		// 기본정보
		if(subjRowMap.keySize("subj") > 0){
			subj = subjRowMap.getString("subj");
			subject_name = subjRowMap.getString("subjnm");
			subjgubun = subjRowMap.getString("subjgubun");
			subjtype = subjRowMap.getString("subjtype");
			evalutegubun = subjRowMap.getString("evalutegubun");
			appGubun = subjRowMap.getString("appGubun");
			useYn = subjRowMap.getString("useYn");
			
			if( subjRowMap.getString("countDelyn").equals("0")){
				delYn = "Y";				
			}
		}
		
		// 선택과목 리스트
		if(subjGrpMap.keySize("subj") > 0){
			for(int i=0; i < subjGrpMap.keySize("subj"); i++){
				//sbSubjGrp.append("- " + subjGrpMap.getString("subjnm", i) + " [ " + subjGrpMap.getString("subj", i) + " ]<br>" );
				sbSubjGrp.append("<option value=\"" + subjGrpMap.getString("subj", i) + "\">" + subjGrpMap.getString("subjnm", i) + "</option>");
			}
		}
		
	}
	
	
%>



<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript" type="text/JavaScript">

// 선택과목 팝업
function fnSubjPop(){

	var url = "subj.do";
	url += "?mode=subjPop";
	
	pwinpop = popWin(url,"subjPop","500","500","yes","no");
	

}

// 선택과목 항목 입력
function fnInsertData(value, text){

	var selectObj = $("subjgrp");
	var i=0;
	var msg = "";
	
	for(i=0; i < selectObj.length; i++){
		if(selectObj.options[i].value == value){
			msg = "기존에 등록된 과목과 중복되는 코드가 있습니다.";
			return;
		}
	}
	
	if(msg == ""){
	
		var selectOption = document.createElement("OPTION");
		selectObj.options.add(selectOption);
		selectOption.innerText = text;
		selectOption.value = value;

	}else{
		alert(msg);
	}
}

// 선택과목 항목 삭제
function fnDeleteData(){

	var selectObj = $("subjgrp");
	var i=0;
	
	for ( i= selectObj.length-1; i >=0 ; i--){
		if ( selectObj.options[i].selected == true){
			selectObj.remove(i);
		}
	}
}

// 저장
function fnSave(){

<%
	if(delYn.equals("Y") || "".equals(delYn)){ 
%>

	if(NChecker($("pform"))){
				
		
		
		var selectObj = $("subjgrp");
	
		if(selectObj.length < 2){
			alert("선택과목은 두개 이상 입력해야 됩니다");
			return;
		}
	
		var tmp_evalutegubun = "";
		if( Form.Element.getValue("subjtype_N") != null ){
			tmp_evalutegubun = Form.Element.getValue("subjtype_N");
		}else{
			tmp_evalutegubun = Form.Element.getValue("subjtype_Y");
		}
		$("evalutegubun").value = tmp_evalutegubun;
		
		
		var tmp_subjgrp
		for(var i=0; i < selectObj.length; i++){
			if(i==0){
				tmp_subjgrp = selectObj.options[i].value;
			}else{
				tmp_subjgrp += "|" + selectObj.options[i].value;
			}
		}		
		$("subjgrp_code").value = tmp_subjgrp;
						
		
		if(confirm("저장하시겠습니까 ?")){
			$("mode").value = "<%=mode%>";
			pform.action = "subj.do";
			pform.submit();		
		}
	}

<%
	}else{
		out.println("alert('해당 과목에 강의가 개설되어 있으면 수정할 수 없습니다.');");
	}
%>


}

// 삭제
function fnDelete(){
	
	<%	
		if(delYn.equals("Y")){ 
			if( btnDeleteDisplay.equals("") ){ 
	%>
		var msg = "삭제하시겠습니까 ?\n\n※ 해당 과목에 강의가 개설되어 있으면 삭제할 수 없습니다.";
		if(confirm(msg)){
			$("mode").value = "delete";
			pform.action="subj.do";
			pform.submit();
		}
	<%
			}
		}else{
			out.println("alert('해당 과목에 강의가 개설되어 있으면 삭제할 수 없습니다.');");
		}
	%>	
}

// 취소
function fnCancel(){
	$("mode").value = "list";
	pform.action="subj.do";
	pform.submit();
}

</script>

<script for="window" event="onload">
	$("subjgubun").value = "<%= subjgubun %>";
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode" 		id="mode"		value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="subj"		id="subj"		value="<%= subj %>">

<input type="hidden" name="sel_gubun"		id="sel_gubun"		value="P">
<input type="hidden" name="subjgrp_code"	id="subjgrp_code"> <!-- 선택과목 코드값 -->


<!-- 제거된 object -->
<input type="hidden" name="evalutegubun" 	id="evalutegubun" 	value="<%= evalutegubun %>">	<!-- 평가유형 -->

<!-- 이전 검색결과 유지 -->
<input type="hidden" name="s_indexSeq" 	id="s_indexSeq"	value="<%= requestMap.getString("s_indexSeq") %>">
<input type="hidden" name="s_useYn" 	id="s_useYn"	value="<%= requestMap.getString("s_useYn") %>">
<input type="hidden" name="s_subType" 	id="s_subType"	value="<%= requestMap.getString("s_subType") %>">
<input type="hidden" name="s_searchTxt" id="s_searchTxt"	value="<%= requestMap.getString("s_searchTxt") %>">

<!-- 이전 페이징 유지 -->
<input type="hidden" name="currPage" 	id="currPage"	value="<%= requestMap.getString("currPage")%>">



<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>            	
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>            
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong><%= strSubTitle %></strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
					
						<br>
						<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#D6DBE5">
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>과목명</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="text" name="subject_name" id="subject_name" class="textfield" size="80" required="true!과목명이 없습니다." maxchar="45!글자수가 많습니다." value="<%= subject_name %>">
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>과목분류</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<select name="subjgubun" style="font-size:9pt">
										<option value="">기타</option>	
										<option value="01">소양분야</option>
										<option value="02">직무분야</option>
										<option value="03">행정및기타</option>
									</select>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>과목유형</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="subjtype" id="subjtype_N" value="N" <%= subjtype.equals("N") ? "checked" : "" %> >&nbsp;<label for="subjtype_N">집합</label>&nbsp;
									<input type="radio" name="subjtype" id="subjtype_Y" value="Y" <%= subjtype.equals("Y") ? "checked" : "" %> >&nbsp;<label for="subjtype_Y">사이버</label>&nbsp;									
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>과목선택 타입</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="app_gubun" id="app_gubun_S" value="S" <%= subjtype.equals("N") ? "checked" : "" %> >&nbsp;<label for="app_gubun_S">학습자지정</label>&nbsp;
									<input type="radio" name="app_gubun" id="app_gubun_M" value="M" <%= subjtype.equals("Y") ? "checked" : "" %> >&nbsp;<label for="app_gubun_M">관리자지정</label>&nbsp;									
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>사용여부</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="radio" name="use_yn" id="use_y" value="Y" <%= useYn.equals("Y") ? "checked" : "" %> >&nbsp;<label for="use_y">Yes</label>&nbsp;
									<input type="radio" name="use_yn" id="use_n" value="N" <%= useYn.equals("N") ? "checked" : "" %> >&nbsp;<label for="use_n">No</label>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="100%">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>선택과목</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<br>
									<%//= sbSubjGrp.toString() %>
									<div id="divSubjGrp" <%//= divSubjGrpDisplay %> >
										<select name="subjgrp" multiple size="10" style="width=200;font-size:9pt">
											<%= sbSubjGrp.toString() %>
										</select>
										<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="button" value="추 가" onclick="fnSubjPop();"  		class="boardbtn1" >
										<input type="button" value="삭 제" onclick="fnDeleteData();"  	class="boardbtn1" >
									</div>																		
									<br>
								</td>
							</tr>
							
						</table>
					
						<!--[s] 하단 버튼  -->
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="center">
									<input type="button" value="<%= btnTitle %>" onclick="fnSave();"   class="boardbtn1" >&nbsp;
									<input type="button" value="삭 제" onclick="fnDelete();" class="boardbtn1" <%= btnDeleteDisplay %> >&nbsp;
									<input type="button" value="취 소" onclick="fnCancel()"  class="boardbtn1" >
								</td>
							</tr>
							<tr><td height="5"></td></tr>
						</table>
						<!--[e] 하단 버튼  -->
					
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>






