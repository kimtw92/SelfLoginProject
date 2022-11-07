<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과목별 학습현황
// date : 2008-07-25
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

	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	double tmpDouble = 0;
	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr>");

		//번호
		listStr.append("\n	<td>" + (i+1) + "</td>");
		
		//아이디
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");

		//이름
		listStr.append("\n	<td>" + listMap.getString("name", i) + "</td>");

		//기관
		listStr.append("\n	<td>" + listMap.getString("deptnm", i) + "</td>");

		//직급
		listStr.append("\n	<td>" + listMap.getString("jiknm", i) + "</td>");

		//주민번호
		//tmpStr = StringReplace.subString(listMap.getString("resno", i), 0, 6) + "-XXXXXX";
		//listStr.append("\n	<td>" + tmpStr + "</td>");

		//전화번호
		listStr.append("\n	<td>" + listMap.getString("hp", i) + "</td>");

		//진도율
		listStr.append("\n	<td>" + listMap.getString("tstep", i) + "</td>");

		//진도율점수
		listStr.append("\n	<td>" + listMap.getString("avcourse", i) + "</td>");

		//차시평가
		listStr.append("\n	<td>" + listMap.getString("quizstep", i) + "</td>");

		//평가점수
		listStr.append("\n	<td>" + listMap.getString("avquiz", i) + "</td>");

		//평가점수
		listStr.append("\n	<td>" + listMap.getString("avlcount", i) + "</td>");


		if(!memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT)){ 
			
			//과제물점수
			listStr.append("\n	<td>" + listMap.getString("avreport", i) + "</td>");
			
			//취득점수
			tmpDouble = Double.parseDouble(listMap.getString("avcourse", i)) + Double.parseDouble(listMap.getString("avlcount", i)) + Double.parseDouble(listMap.getString("avquiz", i)) + Double.parseDouble(listMap.getString("avreport", i));
//			listStr.append("\n	<td class='br0'>" + HandleNumber.getCommaOnePointNumber(tmpDouble) + "</td>");
			listStr.append("\n	<td class='br0'>" + tmpDouble + "</td>");
			listStr.append("\n	<td class='br0'>" + listMap.getString("grayn", i) + "</td>");
			
		}else{
			
			//과제물점수
			listStr.append("\n	<td class='br0'>" + listMap.getString("avreport", i) + "</td>");
		}


		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("dept") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' style=\"height:100px\" class='br0'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

	<script language="JavaScript" type="text/JavaScript">
	<!--
		//페이지 이동
		function go_page(page) {
			go_list();
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
		
			$("mode").value = "subj_list";
		
			pform.action = "/courseMgr/studySta.do";
			pform.submit();
		
		}
		
		//로딩시.
		onload = function()	{
		
			//상단 Onload시 셀렉트 박스 선택.
			var commYear	= "<%= requestMap.getString("commYear") %>";
			var commGrCode	= "<%= requestMap.getString("commGrcode") %>";
			var commGrSeq	= "<%= requestMap.getString("commGrseq") %>";
			var commSubj	= "<%= requestMap.getString("commSubj") %>";
			
			//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, subj)
			var reloading = "subj"; 
		
		
			/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
			getCommYear(commYear); //년도 생성.
			getCommOnloadGrCode(reloading, commYear, commGrCode);
			getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);
			getCommOnloadSubj(reloading, commYear, commGrCode, commGrSeq, commSubj);	// 과목
		
		}
		function go_excel(){
		
			if( $F("commGrcode") == "" ){
				alert("과정을 먼저 선택해 주세요.");
				return;
			}
		
			if( $F("commGrseq") == "" ){
				alert("기수를 먼저 선택해 주세요.");
				return;
			}
			
			if( $F("commSubj") == "" ){
				alert("과목을 먼저 선택해 주세요.");
				return;
			}
			
		
			$("mode").value = "subj_excel";
			$("qu").value = "";
		
			pform.action = "/courseMgr/studySta.do";
			pform.submit();
		
		}		
	//-->
	</script>
	
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
	<form id="pform" name="pform" method="post">
	
		<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
		<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
		<input type="hidden" name="qu"					value="">
		
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
								<!-- tab menu -->
								<div class="tabmenu" style="width:100%;">
									<ul class="tabset">
										<li class="on">과목별 학습현황 </li>
										<a href="javascript:fnGoStudyStaTotalByAdmin();"><li style="cursor:hand;">전체 학습현황</li></a>
									<%if( memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN) ){%>
										<a href="javascript:fnGoStudyStaCyberByAdmin();"><li style="cursor:hand;">사이버 학습현황</li></a>
										<a href="javascript:fnGoStudyStaMixByAdmin();"><li style="cursor:hand;">혼합교육 학습현황</li></a>
										<a href="javascript:fnGoStudyStaOnlineByAdmin();"><li style="cursor:hand;">온라인평가현황</li></a>
									<%}%>
									</ul>
								</div>
								<!-- //tab menu -->
								<div class="space01"></div>
		
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
											<input type="button" value="EXCEL" onclick="go_excel();" class="boardbtn1">
										</td>
									</tr>
									<tr>
										<th class="bl0">
											기수명
										</th>
										<td>
											<div id="divCommGrSeq" class="commonDivLeft">
												<select name="commGrseq" class="mr10">
													<option value="">**선택하세요**</option>
												</select>
											</div>
										</td>
										<th>
											과목
										</th>
										<td>
											<div id="divCommSubj" class="commonDivLeft">										
												<select name="commSubj" style="width:250px;font-size:12px">
													<option value="">**선택하세요**</option>
												</select>
											</div>
										</td>
									</tr>
		
								</table>
								<!--//검색 -->	
								<div class="space01"></div>
		
								<!--[s] 리스트  -->
								<!-- 리스트  -->
								<table class="datah01">
									<thead>
										<tr>
											<th>번호</th>
											
											<th>아이디</th>
											
											<th>이름</th>
											<th>기관</th>
											<th>직급</th>
											
											<!-- 
											<th>주민번호</th>
											 -->
											 
											<th>전화번호</th>
											<th>진도율<br />(%)</th>
											<th>진도율<br />점수</th>
											<th>차시<br />평가<br />정답율<br />(%)</th>
											<th>차시<br />평가<br />점수</th>
											<th>평가<br />점수</th>
										<%if(!memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT)){ %>
											<th>과제물<br />점수</th>
											<th class="br0">취득<br />점수</th>
											<th class="br0">이수<br />여부</th>
										<%}else{%>
											<th class="br0">과제물<br />점수</th>
										<%}%>
										</tr>
									</thead>
									<tbody>
										<%= listStr.toString() %>
									</tbody>
								</table>
								<!--//리스트  -->	
								<div class="space01"></div>
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

