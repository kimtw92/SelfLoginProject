<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : cyberPoll관리 폼
// date : 2008-06-05
// auth : 정 윤철
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
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	// QUESTION데이터
	DataMap questionMap = (DataMap)request.getAttribute("QUESTIONROW_DATA");
	questionMap.setNullToInitialize(true);
	
	//질문 상세 보기 데이터
	DataMap sampRowMap = (DataMap)request.getAttribute("INQSAMPROW_DATA");
	sampRowMap.setNullToInitialize(true);
	
	//질문 리스트
	DataMap questionListMap = (DataMap)request.getAttribute("QUESTIONLIST_DATA");
	questionListMap.setNullToInitialize(true);
	String qu ="";
	
	if(questionMap.keySize() <= 0 ){
		 qu = "insertSamp";
		 requestMap.setString("qu", qu);
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript" type="text/JavaScript">
	//문자 바이트 체크
	function fnCharCount(objname, size, sizelength)
	{
		obj = document.all[objname];
		if (obj.value.length > size )
		{
			alert(size+"자리가 넘었습니다.");
			obj.value = obj.value.substr(0,size-1);
		}
		if (sizelength)
		{
			document.all[sizelength].value = obj.value.length;
		}

	}
	
	//상위 설문 보기 유형 셀렉박스 
	function answer_kind_change(chValue){
		if(chValue == "1" ){//단일선택
			for(var i=0; i < pform.elements.length; i++){  
				if(pform.elements[i].name == "answerKind"){
					var obj= pform.elements[i].id;
					$(obj).style.display = "none";
				}
			}
			for(var j=0; j > 11; j++){
				//하위항목 1번째로 셀렉티드
				if($(obj).options[j].value == "1"){
					$(obj).selectedIndex = j;
				}	
			}
	 	}else if(chValue == "2"){//단일선택+주관식 답변
			for(i=0; i < pform.elements.length; i++){  
				if(pform.elements[i].name == "answerKind"){
					var obj= pform.elements[i].id;
					$(obj).style.display = "";
					for(var j=0; j < $(obj).length; j++){
						if($(obj).options[j].value == "1"){
							$(obj).selectedIndex = j;
						}
					}
				}
			}
			
	 	}else if(chValue == "4"){//주관식
	 		for(i=0; i < pform.elements.length; i++){  
				if(pform.elements[i].name == "answerKind"){
					var obj= pform.elements[i].id;
					$(obj).style.display = "none";
					for(var j=1; 11 > j; j++){
						if(j == 0){
							document.getElementById("q_tr_row_"+(Number(j)+1)).style.display = "";
						}else{
							document.getElementById("q_tr_row_"+(Number(j)+1)).style.display = "none";
						}
					}
					
					//하위항목 첫번째 셀렉트박스 주관식으로 셀렉티드
					for(var j=0; j < $("answerKind_1").length; j++){
						if($("answerKind_1").options[j].value == "4"){
							$("answerKind_1").selectedIndex = j;
						}
					}
				}
			}
			//현재 보여주는 값을 1로 셀렉티드
			for(var i=0; i < $("answerCnt").length; i++) {
				if($("answerCnt").options[i].value == "1"){
					$("answerCnt").selectedIndex = i;
					chgExamCnt('1');
			 	}
			 }
	 	}
	}
	
	//하위항목에서의 항목변환 시 체크
	function chgExamAnswer(chvalue){
		//하위항목 단일과 주관식 답변 체크
		if(chvalue == "2"){
			var complate = "";
			
			//하위항목 단일과 주관식 답변이 현재 몇개인지 체크
			for(var i=0; i < pform.elements.length; i++){ 
				if(pform.elements[i].name == "answerKind"){
					var obj= pform.elements[i].id;
					if($(obj).value == "2"){
						complate = Number(complate)+1;
					}
					
				}
				
			}
			
			//한개이상의 단일항목과 주관식 답변을 선택하였을경우 	
			if(complate > 1){
				alert("단일선택 + 주관식 답변은 한개의 보기만 사용할 수 있습니다.")
				
				//하위항목 첫번째 셀렉트박스 주관식으로 셀렉티드
				for(var i=0; i < pform.elements.length; i++){ 

					if(pform.elements[i].name == "answerKind"){
						var obj= pform.elements[i].id;
						for(var j=0; j > 11; ++j){
							if($(obj).value == "1"){
								$(obj).selectedIndex = j;
								
							}
						}
					}
				}
				//상위 셀렉티드 함수 호출함수
				answer_kind_change('1');
				return false;
			}
		}
		
		//주관식 
		if(chvalue == "4"){
			answer_kind_change('4');
			return false;
			
		}
	}
		

	//보기갯수에따른 필드 보여주기
	function chgExamCnt(chValue){
		for(var i=0; i < pform.elements.length; i++){  
			if(pform.elements[i].name == "answerKind"){
				var obj= pform.elements[i].id;
				
			}
		}
		
		//기본 11개의 보기만큼 루프를 돌린다.
		for(var j = 0; 11 > j; j++ ){
		//j가 체크한 개수보다 만을때까지 보여준다.
			if(j < chValue){
				$(obj).style.display = "";
				document.getElementById("q_tr_row_"+(Number(j)+1)).style.display = "";
				
			}else{
				$(obj).style.display = "none";
				document.getElementById("q_tr_row_"+(Number(j)+1)).style.display = "none";				
			}
		}
	}
		
	//리스트
	function go_list(){
		$("mode").value ="";
		pform.action = "/poll/homepage.do";
		pform.submit();
	}

	//질문항목이동
	function go_modifyQuestion(questionNo){
		$("mode").value = "subForm";
		$("questionNo").value = questionNo;		
		pform.action = "/poll/homepage.do";
		pform.submit();
	}
	
	//질문 추가 등록
	function go_insertSamp(){
		$("mode").value = "subForm";
		$("qu").value = "insertSamp";
		pform.action = "/poll/homepage.do";
		pform.submit();
	}
	
	//수정
	function go_modify(qu){
		var chkMsgValue = "";
		var b = 1;
		
		if($("question").value == "" || $("question").value == null){
			alert("질문을 입력하십시오.");
			$("question").fcous;
			return false;
		}
		
		
		//현재 보기 항목에 값이 있는지 체크
		for(var i=0; i < pform.elements.length; i++){ 
			
			if(pform.elements[i].name == "answer"){
			
				var obj= pform.elements[i].id;

				if($(obj).value == "" || $(obj).value == null){
					chkMsgValue = 1;
					
				}

				if(b == $("answerCnt").value){

					break;
				}
				b++;
			}
		}
		
		if(chkMsgValue == 1){
			alert("보기를 입력하여 주십시오.");
			return false;
		}
		
		
		
		if(confirm("저장하시겠습니까?")){
			$("mode").value = "subExec";
			$("qu").value = "<%=qu%>";
			pform.action = "/poll/homepage.do";
			pform.submit();		
		}
	}
	//항목삭제
	function go_delete(){
		if(confirm("항목을 삭제하시겠습니까?")){
			$("mode").value = "subExec";
			$("qu").value = "deleteSamp";
			pform.action = "/poll/homepage.do";
			pform.submit();		
		}
	}

	//전체삭제
	function go_allDelete(titleNo){
		if(confirm("질문내용 전체를 삭제 하시겠습니까?")){
			$("titleNo").value = titleNo;
			$("mode").value = "subExec";
			$("qu").value = "allDelete";
			pform.action = "/poll/homepage.do";
			pform.submit();		
		}
	}	
	
	//로딩시.
	onload = function()	{
		//설문보기 갯수
		chgExamCnt('<%=questionMap.getString("answerCnt")%>');

		
		//설문 보기 갯수 셀렉티드
		var answerCnt = "<%=questionMap.getString("answerCnt")%>";
		len = $("answerCnt").options.length
		for(var i=0; i < len; i++) {
			if($("answerCnt").options[i].value == answerCnt){
				$("answerCnt").selectedIndex = i;
			 }
	 	 }
	 	 
		//상위 설문유형 셀렉티드	 	 
	 <%for(int i=0; i < sampRowMap.keySize("answerKind"); i++){%>
	 	var answerKind = "<%=sampRowMap.getString("answerKind",i)%>";
		
		if(<%=sampRowMap.getString("answerKind",i)%> == "2"){
			for(var j=0; j < $("this_answer_kind").options.length; j++){
				if($("this_answer_kind").options[j].value == "2"){
					$("this_answer_kind").selectedIndex = j;
				}
			}		
		}else{
			for(var j=0; j < $("this_answer_kind").options.length; j++){
				if($("this_answer_kind").options[j].value == "<%=sampRowMap.getString("answerKind",i)%>"){
					$("this_answer_kind").selectedIndex = j;
				}
			}	
		}

		//하위 설문유형 셀릭티드
		for(i=0; i < pform.elements.length; i++){  
			if(pform.elements[i].name == "answerKind"){
				var obj= pform.elements[i].id;
				$(obj).style.display = "";
				for(var j=<%=i+1%>; j < $(obj).options.length; j++){
					if($(obj).options[j].value == answerKind){
						$(obj).selectedIndex = j;
					}
				}
			}
		}
	 	<%}%>
	}
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">
<!-- 타이틀 번호 -->
<input type="hidden" name="titleNo" value="<%=requestMap.getString("titleNo") %>">
<!-- 질문번호 -->
<input type="hidden" name="questionNo" value="<%=requestMap.getString("questionNo") %>">
<!-- 관련 질문 참조 번호 -->
<input type="hidden" name="questionCheckedNo" value="<%=questionMap.getString("questionCheckedNo") %>}">
<!-- 관련 질문 보기 번호 -->
<input type="hidden" name="sampCheckedNo" value="<%=questionMap.getString("sampCheckedNo") %>">

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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->

			<div class="h10"></div>

			<!--[s] content Form  -->
			
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
			 <!---[s] content -->
			 		
			 		
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<%if(questionListMap.keySize("questionNo") > 0){ %>
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0" class="">
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
										<tr bgcolor="#5071B4">
											<td width="100" class="tableline11 white" align="center"><strong>질문번호</strong></td>
											<td align="center" class="tableline21 white br0" height="28"><strong>질문항목</strong></td>
										</tr>
										<%for(int i=0; i < questionListMap.keySize("questionNo"); i++){ %>
											<tr>
												<td height="28" align="center" class="tableline11"><%=i+1%></td>
												<td align="left" style="padding-left:10px" class="tableline21 br0"><a href="javascript:go_modifyQuestion('<%=questionListMap.getString("questionNo",i)%>');"><%=questionListMap.getString("questionNo",i).equals(requestMap.getString("questionNo")) ? "<b>"+questionListMap.getString("question",i)+"</b>" :  questionListMap.getString("question",i)%></td>
											</tr>
												
										<%} %> 
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
									</table>
								</td>
														
							</tr>

							<tr><td><div class="space01"></div></td></tr>
						<%} %>
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0" class="">
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
	
										<tr bgcolor=#ffffff>
											<td  rowspan=2 width="70" align="center" class="tableline11" bgcolor="#F7F7F7"><strong>질문</strong></td>
											<td  align=center>
											<textarea style="width:95%" rows=3 name="question" onKeyUp="fnCharCount(this.name,80,'sizelength');"><%=questionMap.getString("question") %></textarea>
											</td>
										</tr>
										<tr bgcolor=#ffffff>
											<td class="tableline21 br0">
												&nbsp;* 질문 내용은 80자 까지만 입력이 가능 합니다. <input type="text" name="sizelength" size="3" readonly value="0">자
												<script language='javascript'>fnCharCount('question',80,'sizelength');</script>
												</td>
										</tr>
								
										
										<tr bgcolor=#ffffff height=30>
											<td  align=center class="tableline11" width="70" bgcolor="#F7F7F7"><strong>보기 개수</strong></td>
											<td style='padding-left:5' class="tableline21">
												<table cellpadding=0 cellspacing=0>
													<tr>
														<td width="70">
														<select name="answerCnt" onChange="chgExamCnt(this.value);">
															<option value="">보기갯수 선택</option>
										  					<option value="1">1</option>
										  					<option value="2">2</option>
										  					<option value="3">3</option>
										  					<option value="4">4</option>
										  					<option value="5">5</option>
										  					<option value="6">6</option>
										  					<option value="7">7</option>
										  					<option value="8">8</option>
										  					<option value="9">9</option>
										  					<option value="10">10</option>
														</select>
								
														<td>
														설문 보기 유형
														<select name="this_answer_kind" onChange="answer_kind_change(this.value)">
								   							<option value="1">단일선택</option>
								   							<option value="2">단일선택+주관식답변</option>
								   							<option value="4">주관식답변</option>
														</select>
								
								
														</td>
								
													</tr>
												</table>
								
											</td>
										</tr>
								<%for(int i=0; i < 11; i++){ %>
										<tr id="q_tr_row_<%=i+1%>" style='display:none' bgcolor=#ffffff>
											<td align=center width="70" width="70" class="tableline11" bgcolor="#F7F7F7"><strong>보기<%=i+1%></strong></td>
										      <td class="br0 tableline21" style='padding-left:5'>
								    				<select name="answerKind" id="answerKind_<%=i+1%>" onChange="chgExamAnswer(this.value)" style='display:none'>
								    					<option value="1" <%=sampRowMap.getString("answerKind",i).equals("1") ? "selected" : ""%>>단일선택</option>
								    					<option value="2" <%=sampRowMap.getString("answerKind",i).equals("2") ? "selected" : ""%>>단일선택+주관식답변</option>
								    					<option value="4" <%=sampRowMap.getString("answerKind",i).equals("4") ? "selected" : ""%>>주관식답변</option>
													</select>
													<div>
													<textarea name="answer" id="answer_<%=i+1%>" style="width=90%" rows=3><%=sampRowMap.getString("answer",i) %></textarea>
													</div>
												</td>
										</tr>
								<%} %>
									</table>
								</td>
							</tr>
							<tr bgcolor="#375694">
								<td height="2" colspan="8"></td>
							</tr>
						</table>
						<table width=95% cellpadding=0 cellspacing=0 align=center>
							<tr>
								<td align=right style="padding:10 10 10 10">
								<input type="button" value="저장" onClick="go_modify('<%=requestMap.getString("qu") %>');" class=boardbtn1>
								<%if(!requestMap.getString("qu").equals("insertSamp")){ %>
									<input type="button" value="질문 추가 등록" onClick="go_insertSamp();" class=boardbtn1>
									<input type="button" value="항목삭제" onClick="go_delete();" class=boardbtn1>
									<input type="button" value="전체삭제" onClick="go_allDelete('<%=questionMap.getString("titleNo") %>');" class=boardbtn1>
									
								<%}else{%>
									<input type="button" value="항목리스트" onClick="go_modifyQuestion();" class=boardbtn1>															
								<%} %>	
									<input type="button" value="리스트" onClick="go_list();" class=boardbtn1>	
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<div class="space_ctt_bt"></div>
		</td>
	</tr>
</table>	
		<!-- space -->
		<table width="100%" height="10"><tr><td></td></tr></table>
		<!--[e] content Form  -->

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>




