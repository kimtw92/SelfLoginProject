<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 집합교육 대상자 승인 리스트
// date : 2008-07-07
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


	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);


	//기관 리스트
	DataMap fallListMap = (DataMap)request.getAttribute("FALL_LIST_DATA");
	fallListMap.setNullToInitialize(true);


	//과정 기수 상태 msg
	String message = (String)request.getAttribute("MESSAGE_STRING");
	
	if(message.equals("")){
		message = "<input type=\"button\" value=\"집합교육대상자 선정\" onclick=\"go_choice();\" class=\"boardbtn1\">";

	}


	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("userno"); i++){
		listStr.append("\n<tr>");

		//일련번호
		listStr.append("\n	<td>" + (i+1) + "</td>");

		//CheckBox
		tmpStr = listMap.getInt("progress", i) == 0 ? "checked" : "";
		listStr.append("\n	<td><input type='checkbox' class='chk_01' name='chk"+(i+1)+"' value=\"" + listMap.getString("userno", i) + "\" "+tmpStr+">");
		listStr.append("\n	<input type='hidden' name='hidUserno"+(i+1)+"' value=\"" + listMap.getString("userno", i) + "\" ></td>");

		//선발고사 (과정 기수에서 선발고사 체크를 선택했을경우만).
		if(grseqRowMap.getString("startexamYn").equals("Y")){
			tmpStr = listMap.getString("startexamYn", i).equals("Y") ? "checked" : "";
			listStr.append("\n	<td><input type='checkbox' class='chk_01' name='startexam"+(i+1)+"' value='Y' " + tmpStr + "></td>");
		}
		
		//성명
		listStr.append("\n	<td>" + listMap.getString("name", i) + "</td>");
		
		//아이디
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");

		//주민번호
		//listStr.append("\n	<td>" + listMap.getString("resno", i) + "</td>");

		//기관
		listStr.append("\n	<td>" + listMap.getString("deptnm", i) + "</td>");

		//직급
		listStr.append("\n	<td>" + listMap.getString("jiknm", i) + "</td>");

		//사이버과목(진도율)
		listStr.append("\n	<td class=\"br0\">" + listMap.getString("cyberSubj", i) + "</td>");

		listStr.append("\n</tr>");

	} //end for listMap.keySize("userno")

	//row가 없으면.
	if( listMap.keySize("userno") <= 0){
		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' height='100' class='br0'>입과 대상자가 없습니다</td>");
		listStr.append("\n</tr>");
	}

	//입교 과정의 탈락자 리스트
	StringBuffer fallListStr = new StringBuffer();
	for(int i=0; i < fallListMap.keySize("userno"); i++){

		fallListStr.append("\n<tr>");

		//일련번호
		fallListStr.append("\n	<td>" + (i+1) + "</td>");

		//성명
		fallListStr.append("\n	<td>" + fallListMap.getString("name", i) + "</td>");
		
		//아이디
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");

		//주민번호
		//fallListStr.append("\n	<td>" + fallListMap.getString("resno", i) + "</td>");

		//기관
		fallListStr.append("\n	<td>" + fallListMap.getString("deptnm", i) + "</td>");

		//직급
		fallListStr.append("\n	<td>" + fallListMap.getString("jiknm", i) + "</td>");

		//사이버과목(진도율)
		fallListStr.append("\n	<td class=\"br0\"><a href=\"javascript:go_reEnter('" + fallListMap.getString("userno", i) + "', '" + fallListMap.getString("name", i) + "')\">재입교</a></td>");

		fallListStr.append("\n</tr>");
	} //end for

	//row가 없으면.
	if( fallListMap.keySize("userno") <= 0){
		fallListStr.append("\n<tr>");
		fallListStr.append("\n	<td colspan='100%' height='100' class='br0'>입교 과정의 탈락자가 없습니다</td>");
		fallListStr.append("\n</tr>");
	}

	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 선택하세요!" : grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기 교육생 명단";
%>

<!-- [s] commonHtmlTop include 필수 -->
	<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

	<script language="JavaScript" type="text/JavaScript">
	<!--
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
			$("mode").value = "approval_list";
		
			pform.action = "/courseMgr/stuEnter.do";
			pform.submit();
		
		}
		
		//리스트 checkBox
		function listSelectAll() {	
			for (var i = 1; i <= <%= listMap.keySize("userno") %>; i++) {
				$("chk"+i).checked = $("checkAll").checked;
			}
		}
		
		//선발고사.
		function listExamSelectAll() {
			//선발 고사 항목
			for (var i = 1; i <= <%= listMap.keySize("userno") %>; i++) {
				$("startexam"+i).checked = $("checkAllExam").checked;
			}
		}
		
		//선정
		function go_choice(){
			if( $F("grcode") == "" || $F("grseq") == "" ){
				alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
				return;
			}
			<%
			//과정기수가 선발 고사 승인 여부 체크시.
			if(grseqRowMap.getString("startexamYn").equals("Y")){
			%>
				var isPass = true;
				for (var i = 1; i <= <%= listMap.keySize("userno") %>; i++) {
					if($("chk"+i).checked){
						if( !($("startexam"+i).checked) ){
							isPass = false;
							break;
						}
					}
				}
				if(!isPass){
					alert("선택한 수강생의 선발고사 승인 여부를 체크하여야 합니다.");
					return;
				}
			<%
			}//end if
			%>
			if(confirm("집합교육대상자를 선정하시겠습니까?")){
				$("mode").value = "exec";
				$("qu").value = "approval";
		
				pform.action = "/courseMgr/stuEnter.do";
				pform.submit();
			}
		}
		
		//재입교 처리.
		function go_reEnter(userno, name){
			if( $F("grcode") == "" || $F("grseq") == "" ){
				alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
				return;
			}
			if(confirm("재입교처리하시겠습니까?")){
		
				$("mode").value = "exec";
				$("qu").value = "reenter";
		
				$("userno").value = userno;
		
				pform.action = "/courseMgr/stuEnter.do";
				pform.submit();
			}
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
		}
	//-->
	</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
	<form id="pform" name="pform" method="post">
	
		<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
		<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
		<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">
		<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
		<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">
		<input type="hidden" name="qu"					value="">
		<input type="hidden" name="userno"				value="">
		<input type="hidden" name="listCnt"				value="<%= listMap.keySize("userno") %>">
		<input type="hidden" name="startexamYn"			value="<%= grseqRowMap.getString("startexamYn") %>">
		
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
					<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
						<tr>
							<td>
								<!-- 검색 -->
								<table class="search01">
									<tr>
										<th width="80" class="bl0">
											년도
										</th>
										<td width="20%">
											<div id="divCommYear" class="commonDivLeft">										
												<select name="commYear" onChange="getCommGrCode('subj');" class="mr10">
													<option value="">**선택하세요**</option>
												</select>
											</div>
										</td>
										<th width="80">
											과정명
										</th>
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
										<th class="bl0">
											기수명
										</th>
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
								<h2 class="h2">
									<%= grseqNm %>
								</h2>
								<div class="h5"></div>
								<!-- subTitle -->
								<h2 class="h2"><img src="/images/bullet003.gif"> 집합교육 입과 대상자</h2>
								<!--// subTitle -->
		
								<!--[s] 리스트  -->
								<table class="datah01">
									<thead>
										<tr>
											<th>일련번호</th>
											<th><input type="checkbox" class="chk_01" name="checkAll" value="Y" onClick="listSelectAll();"></th>
											<%
											if(grseqRowMap.getString("startexamYn").equals("Y")){
											%>
											<th>
												선발고사<input type="checkbox" class="chk_01" name="checkAllExam" value="Y" onClick="listExamSelectAll();">
											</th>
											<%
											}//end if
											%>
											<th>성명</th>
											<th>ID</th>
											<!-- 
											<th>주민번호</th>
											 -->
											
											<th>기관</th>
											<th>직급</th>
											<th class="br0">사이버과목(진도율)</th>
										</tr>
									</thead>
		
									<tbody>
										<%= listStr.toString() %>
									</tbody>
								</table>
								<!--//[e] 리스트  -->	
		
								<!-- 테이블하단 버튼  -->
								<table class="btn01" style="clear:both;">
									<tr>
										<td class="right">
											<%= message %>
											<input type="button" value="조회" onclick="go_search();" class="boardbtn1">
										</td>
									</tr>
								</table>
								<!-- //테이블하단 버튼  -->
								<div class="space01"></div>
		
								<!-- subTitle -->
								<h2 class="h2"><img src="/images/bullet003.gif"> 집합교육 탈락자</h2>
								<!--// subTitle -->         
		
								<!--[s] 리스트  -->
								<table class="datah01">
									<thead>
										<tr>
											<th>일련번호</th>
											<th>성명</th>
											<th>ID</th>
											<!-- 
											<th>주민번호</th> 
											-->
											
											<th>기관</th>
											<th>직급</th>
											<th class="br0">재입교</th>
										</tr>
									</thead>
		
									<tbody>
										<%= fallListStr.toString() %>
									</tbody>
								</table>
								<!--//[e] 리스트  -->            
							</td>
						</tr>
					</table>
					<!--//[e] Contents Form  -->
					<div class="space_ctt_bt"></div>
		<!--[ 코딩 끝 ] ------------------------------------------------------------------------------------------------------>	                            
		        </td>
		    </tr>
		</table>
		<!--[s] bottom -->
		<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
	<!--[e] bottom -->
		
	</form>
</body>

