<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 학적부관리 리스트
// date : 2008-05-29
// auth : 정윤철
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
	
	
	DataMap rowMap = (DataMap)request.getAttribute("ROWLIST_DATA");
	rowMap.setNullToInitialize(true);
%>

<!-- [s] commonHtmlTop include 필수 -->
	<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

	<script language="JavaScript" type="text/JavaScript">
	
		//회원검색 팝업
		function go_userSearch(){
			$("mode").value = "memberSearchList";
			$("qu").value = "";
			pform.action = "/member/member.do";
			var popWindow = popWin('about:blank', 'majorPop11', '600', '500', 'yes', 'no');
			pform.target = "majorPop11";
			pform.submit();
			pform.target = ""; 
		}
		
		//셀렉트박스 바꾸기
		function go_change(divId, tu, memberDept){
			var url = "/member/employee.do";
			var pars = "mode=ajaxEmployee&tu="+tu+"&memberDept="+memberDept;
			var divId = divId;
			var myAjax = new Ajax.Updater(
				{success:divId},
				url, 
				{
					asynchronous : false,
					method: "get", 
					parameters: pars,
					onFailure: function(){
						alert("생성시 오류가 발생했습니다.");
					}
				}
			);	
			if(divId == "memberPart"){
				divId = "memberJik";
				tu = "memberPart";
				if(memberDept == "2" || memberDept == "3"){
					//교육지원과 교육운영과
					memberDept = "2";
				}else if(memberDept == "1"){
					memberDept = "1";
				}
				go_change(divId, tu, memberDept);
			}
		}
		
		//리스트이동
		function go_list(){
			location.href="/member/employee.do?mode=list&part=<%=requestMap.getString("part")%>&content=<%=requestMap.getString("content")%>&name=<%=requestMap.getString("name")%>&currPage=<%=requestMap.getString("currPage")%>&menuId=<%=requestMap.getString("menuId")%>";
		}
		
		//저장
		function go_save(qu){
			if(qu == "insert"){
				if(NChecker($("pform"))){
					if(confirm("등록 하시겠습니까?")){
						$("mode").value = "exec";
						$("qu").value = qu;
						pform.action ="/member/employee.do";
						pform.submit();
					}
				}
			}else if(qu == "modify"){
				if(NChecker($("pform"))){
					if(confirm("수정 하시겠습니까?")){
						$("mode").value = "exec";
						$("qu").value = qu;
						pform.action ="/member/employee.do";
						pform.submit();	
					}
				}
			}else if(qu == "delete"){
				if(confirm("삭제 하시겠습니까?")){
					$("mode").value = "exec";
					$("qu").value = qu;
					pform.action ="/member/employee.do";
					pform.submit();	
				}		
			}
		}
		
		//온로드
		onload = function() {
			//원장실을 기준으로 셀렉트박스들을 만든다.
			go_change('memberPart', 'memberDept', '<%=!rowMap.getString("memberPart").equals("") ? rowMap.getString("memberPart") : "1"%>');
			
			//부서 셀렉티드
			var part = "<%=rowMap.getString("memberPart")%>";
			partLen = $("memberDept").options.length;
			for(var i=0; i < partLen; i++) {
				if($("memberDept").options[i].value == part){
					$("memberDept").selectedIndex = i;
				}
			}
			
			//하위부서 셀렉티드
			var memberPartTame = "<%=rowMap.getString("memberPartTeam")%>";
			tameLen = $("memberPartTame").options.length;
			for(var i=0; i < tameLen; i++) {
				if($("memberPartTame").options[i].value == memberPartTame){
					$("memberPartTame").selectedIndex = i;
				}
			}
			
			//직급명 셀렉티드
			var memberJik = "<%=rowMap.getString("memberJik")%>";
			jikLen = $("memberJiknm").options.length;
			for(var i=0; i < jikLen; i++) {
				if($("memberJiknm").options[i].value == memberJik){
					$("memberJiknm").selectedIndex = i;
				}
			}
		}
	
	</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

	<form id="pform" name="pform" method="post">
		<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
		<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId")%>">
		<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
		
		<!-- 유저 번호 -->
		<input type="hidden" name="userno"				value="<%=requestMap.getString("userno")%>">
		<!-- 주민 번호 -->
		<input type="hidden" name="resno"				value="">
		<!-- 구분모드 -->
		<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">
		<!-- 시퀀스번호 -->
		<input type="hidden" name="seq"					value="<%=requestMap.getString("seq")%>">
		
		<input type="hidden" name="searchPart" value="<%=requestMap.getString("part") %>">
		<input type="hidden" name="searchName" value="<%=requestMap.getString("name") %>">
		<input type="hidden" name="searchContent" value="<%=requestMap.getString("content") %>">
	
		<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		    <tr>
		        <td width="211" height="86" valign="bottom" align="center" nowrap>
		        	<img src="/images/incheon_logo.gif" width="192" height="56" border="0">
		        </td>
		        <td width="8" valign="top" nowrap>
		        	<img src="/images/lefttop_bg.gif" width="8" height="86" border="0">
		        </td>
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
		
					<!--[s] subTitle -->
					<table width="100%" height="10">
						<tr>
							<td></td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
						<tr>
							<td height="20">
								<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>직원관리 <%=requestMap.getString("qu").equals("insert") ? "등록" : "수정"%></strong>
							</td>
						</tr>
					</table>
					<!--[e] subTitle -->
					<div class="h10"></div>
					<!--[s] Contents Form  -->
					<table cellspacing="0" cellpadding="0" border="0" width="100%"
						class="contentsTable">
						<tr>
							<td>
								<!-- date -->
								<table  class="dataw01">
									<tr>
										<th width="100">성명</th>
										<td>
											<input type = text class="textfield" name ="name" required="true!성명을 입력하십시오." onClick="go_userSearch();"" style="cursor:Hand" size ="10" maxlength ="10" value="<%=rowMap.getString("username") %>" readonly>
											<input type="button" value="검색" onclick="go_userSearch();" class="boardbtn1">
										</td>
									</tr>
									<tr>
										<th>부서</th>
										<td>
											<select style="width:100;text-align:center;" name="memberDept" onchange="go_change('memberPart', 'memberDept', this.value);" class="mr10">
												<!-- option value="1">원장실</option>
												<option value="2">교육지원과</option>
												<option value="3">교수실</option>
												<option value="4">인재양성과</option -->
												<option value="1">
												원장실
												</option>
												<option value="2">
												교육직원담당
												</option>
												<option value="3">
												기획평가담당
												</option>
												<option value="4">
												운영담당
												</option>
												<option value="5">
												사이버교육담당
												</option>
												<option value="6">
												교수실
												</option>
												<!-- option value="7">
												관리담당
												</option -->												
											</select>
										</td>
									</tr>
									<tr>
										<th>하위 부서</th>
										<td>
											<div id="memberPart">
												<select style="width:100;text-align:center;" name="memberPartTame" class="mr10">
													<option></option>
												</select>
											</div>
										</td>
										
									</tr>
									<tr>
										<th>직위</th>
										<td>
											<div id="memberJik">
												<select style="width:100;text-align:center;" name="memberJiknm" class="mr10">
													<option></option>
												</select>
											</div>
										</td>
									</tr>
									<tr>
										<th>담당업무</th>
										<td>
											<textarea name="content" required="true!담당업무를 입력하십시오." class="textarea" cols="60" rows="3"><%=rowMap.getString("content") %></textarea>
										</td>
									</tr>
									<tr>
										<th>전화번호</th>
										<td>
											<input type="text" class="textfield" name="phoneNumber"  size="14" maxlength="13" value="<%=rowMap.getString("phoneNumber") %>"/>
										</td>
									</tr>
									<tr>
										<th>팩스번호</th>
										<td>
											<input type="text" class="textfield" name="faxNumber" size="14" maxlength="13" value="<%=rowMap.getString("faxNumber") %>"/>
										</td>
									</tr>
								</table>
								<!-- //date -->
								<div class="h10"></div>
								<!-- 테이블하단 버튼  -->
								<table class="btn01" style="clear:both;">
									<tr>
										<td class="right">
											<%
												if(requestMap.getString("qu").equals("modify")){ 
											%>
												<input type="button" value="삭제" onclick="go_save('delete');" class="boardbtn1">
											<%
												} 
											%>
											<input type="button" value="저장" onclick="go_save('<%=requestMap.getString("qu") %>');" class="boardbtn1">
											<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
										</td>
									</tr>
								</table>
								<!-- //테이블하단 버튼  -->
							</td>
						</tr>
					</table>
					<!--//[e] Contents Form  -->
					<div class="space_ctt_bt"></div>

		        </td>
		    </tr>
		</table>
		
		<!--[s] bottom -->
		<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
		<!--[e] bottom -->
		
	</form>
</body>


