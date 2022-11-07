<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
	// prgnm : 수강신청 승인현황 리스트
	// date : 2008-06-27
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
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////


	//간단한 과정 기수 정보
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	//유저 정보.
	DataMap userMap = (DataMap)request.getAttribute("USER_ROW_DATA");
	userMap.setNullToInitialize(true);

	//기관담당자 일경우 기관명
	String deptnmStr = (String)request.getAttribute("DEPTNM_STRING_DATA");
	
	//검색된 사용자의 수강신청 리스트
	DataMap lectureMap = (DataMap)request.getAttribute("LECTURE_DATA");
	lectureMap.setNullToInitialize(true);

	
	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 선택하세요! " : grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기";

	String descriptionStr = "";
	if(memberInfo.getSessClass().equals("0") || memberInfo.getSessClass().equals("2"))
		descriptionStr = "전체회원에 대한 최종승인이 가능합니다.";
	else if(memberInfo.getSessClass().equals("3"))
		descriptionStr = "1차승인까지만 가능합니다.";

%>

<!-- [s] commonHtmlTop include 필수 -->
	<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

	<script language="JavaScript" type="text/JavaScript">
	<!--
		function init() {
			var p_deptsub = "<%= userMap.getString("deptsub") %>";
			var p_dept = "<%= userMap.getString("dept") %>";
			getMemSelDept(p_dept, p_deptsub);
		}
		function getPart(objValue, objText) {
			if(objValue == ""){
				document.all.deptsub.value = "";
				document.all.deptsub.focus();
			}else{
				document.all.deptsub.value = objText;
			}
		}
		function getMemSelDept(form1, form2) {
			var url = "/mypage/myclass.do";
			pars = "deptname="+form2+"&dept=" + form1.substring(0,7) + "&mode=searchPart2";
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
					},
					onFailure : function(){					
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						alert("데이타를 가져오지 못했습니다.");
					}				
				}
			);
		}
		//comm Selectbox선택후 리로딩 되는 함수.
		function go_reload(){
			go_list();
		}
		
		//검색
		function go_search(){
			go_list();
		}
		
		//리스트
		function go_list(){
			$("mode").value = "form";
		
			pform.action = "/courseMgr/stuEnter.do";
			pform.submit();
		}
		
		//주민등록 및 이름 검색후 리로딩 되는 함수.
		function go_reloadPop(userno){
			$("userno").value = userno;
			go_list();
		}
		
		//수정
		function go_submit(){
			if($F("commYear") == "" || $F("commGrcode") == "" || $F("commGrseq") == ""){
				alert("년도 및 과정명, 기수를 선택해 주세요.");
				return;
			}
			var isPass = true;
			if( $("memberUpdateYN").checked == true ){
				if( !confirm("개인정보를 업데이트 합니까?") ){
					isPass = false;
				}
			}
		 
					
			if(document.all.deptsub.value == "") {
				alert("부서명을 입력해주세요.");
				return;
			}
			if(document.all.dept.value.indexOf("6289999") != -1) {
				if(document.all.PART_DATA.value == "") {
					alert("공사공단은 집적입력이 되지 않습니다. 부서명을 선택해주세요.");
					return;
				}
			}
		
		
			if(isPass == true && NChecker(document.pform) && confirm("등록 하시겠습니까?")){
				$("mode").value = "exec";
				$("qu").value = "insert";
		
				pform.action = "/courseMgr/stuEnter.do";
				pform.submit();
			}
		}

		//2010.01.11 - woni82
		//주민등록번호 삭제함.
		//아이디 및 이름 검색
		function go_searchMember1(qu){
			var mode = "list";
			var searchValue = "";
			if(qu == 'userid'){
				if($F("userid") == ""){
					alert("검색할 아이디를 입력하세요!");
					return;
				}
				searchValue = $F("userid");
			}

			//if(qu == 'resno'){
			//	if($F("resno") == ""){
			//		alert("검색할 주민번호를 입력하세요!");
			//		return;
			//	}
			//	searchValue = $F("resno");
			//}
			
			else{
				if($F("name") == ""){
					alert("검색할 이름을 입력하세요!");
					return;
				}
				searchValue = $F("name");
			}
		
			var url = "/commonInc/searchMember.do?mode=" + mode + "&qu=" + qu + "&searchValue=" + searchValue;
			popWin(encodeURI(url), "pop_searchMemberPop", "500", "280", "0", "");
		}
		
		function go_searchMember(qu){
			var mode = "list";
			var searchValue = "";

			if(qu == 'resno'){
				if($F("resno") == ""){
					alert("검색할 주민번호를 입력하세요!");
					return;
				}
				searchValue = $F("resno");
			}
			else{
				if($F("name") == ""){
					alert("검색할 이름을 입력하세요!");
					return;
				}
				searchValue = $F("name");
			}
		
			var url = "/commonInc/searchMember.do?mode=" + mode + "&qu=" + qu + "&searchValue=" + searchValue;
			popWin(encodeURI(url), "pop_searchMemberPop", "500", "280", "0", "");
		}
		
		//로딩시.
		onload = function()	{
			//상단 Onload시 셀렉트 박스 선택.
			var commYear = "<%= requestMap.getString("commYear") %>";
			var commGrCode = "<%= requestMap.getString("commGrcode") %>";
			var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
			
			//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
			var reloading = ""; 
		
			/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
			getCommYear(commYear); //년도 생성.
			getCommOnloadGrCode(reloading, commYear, commGrCode);
			getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);
			init();
		}
	//-->
	</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
	<form id="pform" name="pform" method="post">
	
		<input type="hidden" id="menuId"	name="menuId"	value="<%= requestMap.getString("menuId") %>">
		<input type="hidden" id="mode"     	name="mode"		value="<%= requestMap.getString("mode") %>">
		<input type="hidden" id="qu"		name="qu"		value="<%= requestMap.getString("qu") %>">
		<input type="hidden" id="userno"	name="userno"	value="<%= requestMap.getString("userno") %>">
		<input type="hidden" id="searchValue" name="searchValue" value="" />
		
		<% if(memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT)){ %>
		<input type="hidden" name="dept"				value="<%= memberInfo.getSessDept() %>">
		<input type="hidden" name="deptnm"				value="<%= deptnmStr %>">
		<% } %>
		
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
		
					<!--[s] Contents Form  -->
					<table cellspacing="0" cellpadding="0" border="0" width="100%"
						class="contentsTable">
						<tr>
							<td>
								<!-- 검색 -->
								<table class="search01">
									<tr>
										<th width="80" class="bl0">년도</th>
										<td width="20%">
											<div id="divCommYear" class="commonDivLeft">										
												<select name="commYear" onChange="getCommGrCode('subj');" class="mr10">
													<option value="">**선택하세요**</option>
												</select>
											</div>
										</td>
										<th width="80">과정명</th>
										<td>
											<div id="divCommGrCode" class="commonDivLeft">
												<select name="commGrcode" class="mr10">
													<option value="">**선택하세요**</option>
												</select>
											</div>
										</td>
										<td width="100" class="btnr" rowspan="2">
											<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
										</td>
									</tr>
									<tr>
										<th class="bl0">기수명</th>
										<td colspan="3">
											<div id="divCommGrSeq" class="commonDivLeft">
												<select name="commGrseq" class="mr10">
													<option value="">**선택하세요**</option>
												</select>
											</div>
										</td>
									</tr>
								</table>
								<!--//검색 -->	
								<div class="space01"></div>
		
								<div class="h10"></div>
		            
								<h2 class="h2"><%= grseqNm %></h2>
								<div class="h5"></div>
		
								<h2 class="h2"><img src="/images/bullet003.gif"> 교육생 직접입력 정보확인 </h2>
								<!-- // subTitle -->						
								<div class="h5"></div>
		
								<!-- date -->
								<table  class="dataw01">
									
									<tr>
										<th width="20%">아이디</th>
										<td class="br0">
											<input type="text" class="textfield" id="userid" name="userid" value="<%= userMap.getString("userid") %>" style="width:150" required="true!아이디를입력해주세요"/>
											<input type="button" value="조회" onclick="go_searchMember1('userid');" class="boardbtn1">
										</td>
									</tr>
									
									<!-- 
									<tr>
										<th width="20%">주민등록번호</th>
										<td class="br0">
											<input type="text" class="textfield" name="resno" value="<%= userMap.getString("resno") %>" style="width:150" required="true!주민등록번호를 입력하세요!" dataform="num!숫자만 입력해주세요." maxlength="13"/>
											<input type="button" value="조회" onclick="go_searchMember('resno');" class="boardbtn1">
											<span class="txt_99">ex) 7401281122232 , "-" 없이 입력</span>
										</td>
									</tr>
									 -->
									
									<tr>
										<th>이 름</th>
										<td class="br0">
											<input type="text" class="textfield" name="name" value="<%= userMap.getString("name") %>" style="width:150" required="true!이름을 입력하세요!"/>
											<!-- <input type="button" value="검색" onclick="go_searchMember('name');" class="boardbtn1">  -->
											<input type="button" value="검색" onclick="go_searchMember1('name');" class="boardbtn1">
										</td>
									</tr>
									
									<!-- 사용자의 수강신청 리스트  -->
									<tr>
										<th>당해년도<br>수강이력</th>
										<td class="br0">
										
		<%
			//수강신청한 이력이 있을때만 테이블 보이게
			if(lectureMap.keySize("grcode") > 0) { 
		%>
											<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsTable">
												<tr height='15' bgcolor="#5071B4">
													<td width="10%" align='center' class="tableline11 white">
														<strong>년도</strong>
													</td>
													<td width="*%" align='center' class="tableline11 white">
														<strong>과정명</strong>
													</td>
												
													<td width="10%" align='center' class="tableline11 white">
														<strong>기수</strong>
													</td>
													<td width="27%" align='center' class="tableline11 white">
														<strong>교육기간</strong>
													</td>
													<td width="15%" align='center' class="tableline21 white">
														<strong>승인여부</strong>
													</td>
												</tr>
			
		<%		
				for(int i=0; i < lectureMap.keySize("grcode"); i++) { 	
		%>
		
		<tr bgColor='#FFFFFF' height='25'>
		
			<td align='center' class='tableline11'><%= lectureMap.getString("grseq",i).substring(0,4) %>년</td>
			<td align='center' class='tableline11'><%= lectureMap.getString("grcodeniknm",i) %></td>
			<td align='center' class='tableline11'><%= lectureMap.getString("grseq",i).substring(4) %>기</td>
			<td align='center' class='tableline11'><%= lectureMap.getString("started",i) %> ~ <%= lectureMap.getString("enddate",i) %></td>
			<td align='center' class='tableline11'><%= lectureMap.getString("grchk",i) %></td>
		</tr>
										 		
		<% 		}	//END for() 	%>
												</table>
		<%	}	//END if() 		%>
			
		
										</td>
									</tr>
									<!-- //사용자의 수강신청 리스트  -->
									
									<tr>
										<th>전화번호(집)</th>
										<td class="br0">
											<input type="text" class="textfield" name="homeTel" value="<%= userMap.getString("homeTel") %>" style="width:150" required="true!전화번호를 입력하세요!" maxlength="13" />                  
											<span class="txt_99">ex).000-000-0000</span>
										</td>
									</tr>
									<tr>
										<th>이메일</th>
										<td class="br0">
											<input type="text" class="textfield" name="email" value="<%= userMap.getString("email") %>" style="width:200" required="true!이메일을 입력하세요!" dataform="email!이메일 형식에 맞게 입력해주세요." maxlength="100"/>
										</td>
									</tr>
									<% if( !memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) ){ %>
									<tr>
										<th>소속기관</th>
										<td class="br0">
											<input type="text" class="textfield" name="deptnm" value="<%= userMap.getString("deptnm") %>" style="width:200" onclick="go_commonSearchDept('dept', 'deptnm');" readonly required="true!소속기관을 입력하세요!" />
											<input type="hidden" name="dept" value="<%= userMap.getString("dept") %>">
											<input type="button" value="기관검색" onclick="go_commonSearchDept('dept', 'deptnm');" class="boardbtn1">
										</td>
									</tr>
									<% } %>
									<tr id="part">
										<th class="bl0">
											부서명 <span class="txt_org">*</span>
										</th>
										<td>
											<input type="text" class="textfield" 	id="deptsub" name="deptsub" value="<%= userMap.getString("deptsub") %>" style="width:200" maxlength="100"/>
											<select name="PART_DATA" class="select01 w120" onChange="getPart(this.options[this.selectedIndex].value,this.options[this.selectedIndex].text)">												<option value = "" selected>--- 부서 선택 ---</option>
												<option value = "" >직접입력</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>직급</th>
										<td class="br0">
											<input type="text" class="textfield" name="jiknm" value="<%= userMap.getString("jiknm") %>" style="width:200" onclick="go_commonSearchJik('pform.jik', 'pform.jiknm');" readonly required="true!직급을 입력하세요!"/>
											<input type="hidden" name="jik" value="<%= userMap.getString("jik") %>">
											<input type="button" value="직급검색" onclick="go_commonSearchJik('pform.jik', 'pform.jiknm');" class="boardbtn1">
										</td>
									</tr>
									<tr>
										<th>개인정보에 반영 여부</th>
										<td class="br0">
											<input type="checkbox" name="memberUpdateYN" value="Y" /> (체크시 개인정보를 업데이트 합니다.)
										</td>
									</tr>
								</table>
								<!-- //date -->
		
								<!-- 테이블하단 버튼  -->
								<table class="btn01" style="clear:both;">
									<tr>
										<td class="right">
											<input type="button" value="저장" onclick="go_submit();" class="boardbtn1">
											<input type="button" value="새로고침" onclick="go_search();" class="boardbtn1">
										</td>
									</tr>
								</table>
								<!-- //테이블하단 버튼  -->
								<div class="space01"></div>
		
								<!--안내 문구-->
								<h2 class="h2">안내</h2>		
								<ol class="coment01">
									<li>
										<!-- 신규회원을 입력하신 경우 비밀번호는 주민번호 "뒷자리"+"a"가 셋팅되었습니다.
										담당자에게 통보하여 주시기 바랍니다.  -->
										신규회원을 입력하실 경우 초기 비밀번호는 아이디 + "a"가 셋팅되도록 되어있습니다.
										담당자에게 통보하여 주시기 바랍니다.
									</li>
									<li>
										<%= descriptionStr %>
									</li>
								</ol>
								<!--//안내 문구-->
		
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

