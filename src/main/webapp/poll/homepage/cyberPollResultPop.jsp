<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : CyberPoll 미리보기
// date : 2008-06-16
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
	
	//ROW 데이터
	DataMap listMap = (DataMap)request.getAttribute("VIEWLIST_DATA");
	listMap.setNullToInitialize(true);
	
	String question = "";
	StringBuffer html =  new StringBuffer();
	for(int i=0; i < listMap.keySize("questionNo"); i++){
		//현재 문재가 보기이고 퀘스트 넘버가 멥의 안에있는 현재 i번째의 전꺼와 비교하여 다를경우 셋을 한다.
		if(listMap.getString("pflag",i).equals("B") && !listMap.getString("answerKind",i).equals("0") && !question.equals(listMap.getString("questionNo",i))){
			
			//현재 등록된 질문번호 셋
			requestMap.addString("tempQuest", listMap.getString("questionNo",i));
			html.append("<input type=\"hidden\" name=\"questionNo\" value=\""+listMap.getString("questionNo",i)+"\">");
			question = listMap.getString("questionNo",i);
		}
	}

%>

<html>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<!-- [s] commonHtmlTop include 필수 -->
	<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
	<!-- [e] commonHtmlTop include -->
	<head>
	
	<script language=javascript>
	<!--
	function go_save(){
		if(NChecker($("pform"))){

		var chk = 0;
		var chkVal = 0;
		//모든 객체를 가져온다.
		for(var i=0; i < pform.elements.length; i++){  
			//가져온 모든 객체에서 가져오고자하는 아이디의 오브젝트만 검색한다.
			if(pform.elements[i].id == "mixrequest"){
				//검색된 오브젝트를 변수에 obj변수에 담는다.
				var obj= pform.elements[i].id;
				//obj속성은 라디오 박스이다.
				if($(obj).checked == true){
					//체크드가 되었다면은 1을주어서 밑에서 검색을 할 수 있도록 한다.
					chkVal = 1;
				}else{
					//체크가 안되었다면 추가 검색을 안해도 된다.
					chkVal = 0;
				}
				
				//체크박스가 선택이 되었을경우 다시한번더 검색 한다.
				if(chkVal == 1){
					//선택된 라디오 박스의 인풋박스를 다시 검색한다.
					for(var i=0; i < pform.elements.length; i++){  
						if(pform.elements[i].id == "mixrequestTxt"){
							var obj= pform.elements[i].name;
							if($(obj).value == ""){
								//검색된 인풋박스의 값이 없을경우 1을 준다.
								chk = 1;
							}else{
								chk = 0;
							}
						}
					}
				}
				
				//값이 없을경우 경고창을 출력한다
				if(chk == 1){
					alert("단일+주관식 형식의 답입력란에 답을 입력 하여주십시오.");
					return false;
				}
			}
		}
		
		<%for(int i=0;i < requestMap.keySize("tempQuest"); i++){
		%>
			try{
				if(go_commonCheckedCheck(pform.answerNo_<%=requestMap.getString("tempQuest",i)%>) == false){
					alert("<%=i+1%> 번째 설문항목을 선택하여주십시오");
					return false;
				}
			}catch(e){
			
			}
			
		<%	
		}%>
			if(confirm("등록 하시겠습니까?")){
				$("mode").value = "subExec";
				$("qu").value = "resultInsert";
				pform.action = "/poll/homepage.do";
				pform.submit();
			}
		}
	}
	//-->
	</script>
	</head>
	<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
		<form id="pform" name="pform" method="post">
		<input type="hidden" name="mode">
		<input type="hidden" name="qu">
		<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
		<input type="hidden" name="titleNo" value="<%=listMap.getString("titleNo") %>">
		<input type="hidden" name="userNo" value="<%=memberInfo.getSessNo()%>">
		<!-- questionNo 히든박스 모음 [s]-->
		<%=html.toString() %>
		<!-- questionNo 히든박스 모음 [e] -->
		
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
				<tr>
					<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
						<!-- [s]타이틀영역-->
						<table cellspacing="0" cellpadding="0" border="0">
							<tr>
								<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
								<td><font color="#000000" style="font-weight:bold; font-size:13px">설문 관리 미리보기 </font></td>
							</tr>
						</table>
						<!-- [e]타이틀영역-->
					</td>
				</tr>
				<tr > 
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						
						   <tr>
				              <td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
				                 <%
				                 for(int i=0; i < listMap.keySize("titleNo"); i++){ 
				                 		
				                 	if(listMap.getString("pflag",i).equals("A")){

				                 %>
									<tr bgcolor="#5071B4">
										<td colspan="100%" height="2"></td>
									</tr>   				                 
                					<tr bgcolor="#F7F7F7"> 
				                 		<td class="tableline11" width="50" height="28" align="center"><strong>설문<%=listMap.getString("questionNo",i) %></strong></td>
										<td class="tableline21" colspan="2" width="" align="center"><%=listMap.getString("question",i)%></td>	
									</tr>
								<%	
				                 	
					                 	for(int j = 0; j < listMap.keySize("titleNo"); j++){
											
					                 		if(listMap.getString("pflag",j).equals("B") 
					                 				&& listMap.getString("titleNo", j).equals(listMap.getString("titleNo", i)) 
					                 				&& listMap.getString("questionNo", j).equals(listMap.getString("questionNo", i)) && listMap.getString("answerKind",j).equals("1")){
					            %>
				                	<tr>
				                		<td width="50" class="tableline11" align="center">
				                			<input type="radio" name="answerNo_<%=listMap.getString("questionNo", i)%>" value="<%=listMap.getString("answerNo",j) %>">
				                		</td>
				                		<td style="padding-left:10px;" class="tableline21">
				                			<%=listMap.getString("question",j) %>
				                		</td>
					                </tr>					            	
					            <%
					                 		}else if(listMap.getString("pflag",j).equals("B") 
					                 				&& listMap.getString("titleNo", j).equals(listMap.getString("titleNo", i)) 
					                 				&& listMap.getString("questionNo", j).equals(listMap.getString("questionNo", i)) && listMap.getString("answerKind",j).equals("2")){
					             %>
				                	<tr>
				                		<td width="50" align="center" class="tableline11">
				                			<input type="radio" id="mixrequest" name="answerNo_<%=listMap.getString("questionNo",i)%>" value="<%=listMap.getString("answerNo",j) %>">
				                		</td>
				                		<td style="padding-left:10px;" class="tableline21">
				                			<%=listMap.getString("question",j) %>&nbsp;<input id="mixrequestTxt" name="answerTxt_<%=listMap.getString("questionNo")%>" size="30" type="text">
				                		</td>
					                </tr>	
					             <%
				                 		}else if(listMap.getString("pflag",j).equals("B") 
				                 				&& listMap.getString("titleNo", j).equals(listMap.getString("titleNo", i)) 
				                 				&& listMap.getString("questionNo", j).equals(listMap.getString("questionNo", i)) && listMap.getString("answerKind",j).equals("4")){
				                 			
				                 %>
									<tr> 
				                		<td width="50" height="20" colspan="2" style="padding-left:10px;">
				                			<input required="true!주관식 답을 입력하여 주십시오!" name="answerTxt_<%=listMap.getString("questionNo",i)%>" type="text" size="50">
				                		</td>
					                </tr>	
				                 <%
				                 	}
				                 	
			                 	}
								%>
									<tr bgcolor="#5071B4">
										<td colspan="100%" height="2"></td>
									</tr>   								
									<tr><td height="30">&nbsp;</td></tr>
								<%
							}
		                 }
									%>
									<tr>
										<td width="100%" align="center" colspan="100%">
										<%if(listMap.keySize("titleNo") > 0){ %>
											<input type="button" onclick="go_save();" class="boardbtn1" value="확인">
										<%} %>
											<input type="button" onclick="self.close();" class="boardbtn1" value="닫기">
										</td>
									</tr>
								</table></td>
				            </tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
