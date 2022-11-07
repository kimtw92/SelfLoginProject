<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%   
// prgnm : 수료증 발급대장
// date : 2008-07-11 
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

	
	String tmpStr = "";	
	
	//과정기수 정보.
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);
	
	//기관 리스트 
	DataMap grResultDeptList = (DataMap)request.getAttribute("RESULT_DEPT_LIST_DATA");
	grResultDeptList.setNullToInitialize(true);

	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr>");
		
		
		int tmpSeqno = listMap.getInt("seqno", i); //임시 석차
		String tmpPaccept = Util.getValue(listMap.getString("paccept", i), "0"); // 임시 총점

		String seqno = ""; //석차
		String paccept = ""; //총점
		
		if( memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN)
				|| memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT ) ){
			
			seqno = tmpSeqno + "";
			paccept = tmpPaccept;
			
		}else{

			if( tmpSeqno <= 3 && Double.parseDouble(tmpPaccept) >= 60){
				seqno = tmpSeqno + "";
				paccept = tmpPaccept;
			}else{
				seqno = "*";
				if( listMap.getString("rgrayn", i).equals("Y") && Double.parseDouble(tmpPaccept) == 60) paccept = "*";
				else if( listMap.getString("rgrayn", i).equals("Y") && Double.parseDouble(tmpPaccept) > 0) paccept = "60점 이상";
				else paccept = "60점 미만";
			}
		}
		String birthdate = listMap.getString("birthdate", i);
		if(!"".equals(birthdate)) {
			birthdate = birthdate.substring(0,4) + "-" + birthdate.substring(4,6) + "-" + birthdate.substring(6,8);
		} else {
			birthdate = "";
		}
		
		//성명
		listStr.append("\n	<td>" + listMap.getString("rname", i) + "</td>");

		// 생일
		listStr.append("\n	<td>" + birthdate + "</td>");
		//성명
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");

		//주민번호
		//tmpStr = StringReplace.subString(listMap.getString("rresno", i), 0, 6) + "-XXXXXX";
		//listStr.append("\n	<td>" + tmpStr + "</td>");
		
		//소속
		listStr.append("\n	<td>" + listMap.getString("rdeptnm", i) + "</td>");
		
		//부서
		listStr.append("\n	<td>" + listMap.getString("rdeptsub", i) + "</td>");
		
		//직급명
		listStr.append("\n	<td>" + listMap.getString("rjiknm", i) + "</td>");
		
		//교육일자
		listStr.append("\n	<td>" + listMap.getString("started1", i) + "<br>&nbsp;~" + listMap.getString("enddate1", i) + "</td>");
		
		//교번
		tmpStr = listMap.getString("eduno", i).equals("0") ? "" : listMap.getString("eduno", i);
		listStr.append("\n	<td>" + tmpStr + "</td>");
		
		//기관 담당자 일경우는 제외.
		if(!memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) ){
			//성적
			listStr.append("\n	<td>" + paccept + "</td>");
			
			//석차
			tmpStr = seqno.equals("0") ? "" : seqno;
			listStr.append("\n	<td>" + tmpStr + "</td>");
		}
		
		//수료
		listStr.append("\n	<td>" + listMap.getString("txtRgrayn", i) + "</td>");
		
		//수료번호
		listStr.append("\n	<td class='br0'>" + listMap.getString("rno", i) + "</td>");
		
		listStr.append("\n</tr>");
	
	
	} //end for 

	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' class='br0' style='height:100px'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

	//select Box 기관 리스트
	String selDetpStr = "";
	for(int i=0; i < grResultDeptList.keySize("rdept"); i++)
		selDetpStr += "<option value=\"" + grResultDeptList.getString("rdept", i) + "\">" + grResultDeptList.getString("rdeptnm", i) + "</option>";

	String grseqStatusStr = "";
	if(grseqRowMap.getString("closing").equals("Y"))
		grseqStatusStr = "수료처리가 완결되었습니다.";
	else if(grseqRowMap.getInt("enddate") < Integer.parseInt(DateUtil.getDateTime()) )
		grseqStatusStr = "교육이 종료되었습니다.";
	else 
		grseqStatusStr = "교육이 진행중입니다.";
	
%>

<!-- [s] commonHtmlTop include 필수 -->
	<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
	<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

	<script language="JavaScript" type="text/JavaScript">
	<!--
	
		//AI
		function go_pollAI(){
			if( $F("commGrcode") == "" ){
				alert("과정을 먼저 선택해 주세요.");
				return;
			}

			if( $F("commGrseq") == "" ){
				alert("기수를 먼저 선택해 주세요.");
				return;
			}
			popAI("http://152.99.42.130/report/report_100.jsp?p_commGrcode=" + $F("commGrcode") + "&p_commGrseq=" + $F("commGrseq"));
		}
		 
		function go_reload(){
			go_list();
		}
		
		//검색
		function go_search(){
			go_list();
		}
		
		//리스트
		function go_list(){
			$("mode").value = "gove_list";
		
			pform.action = "/courseMgr/certiResult.do";
			pform.submit();
		}
		
		//엑셀 출력
		function go_excel(){
			if( $F("commGrcode") == "" ){
				alert("과정을 먼저 선택해 주세요.");
				return;
			}

			if( $F("commGrseq") == "" ){
				alert("기수를 먼저 선택해 주세요.");
				return;
			}

			$("mode").value = "gove_excel";
			$("qu").value = "";

			pform.action = "/courseMgr/certiResult.do";
			pform.submit();
		}
		//로딩시.
		onload = function()	{
			try{
				var searchDept = '<%=requestMap.getString("searchDept")%>';
				$("searchDept").value = searchDept;
			}catch(e){}
		
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
								<!-- 검색 -->
								<table class="search01">
									<tr>
										<th width="80" class="bl0">
											년도
										</th>
										<td width="20%">
											<div id="divCommYear" class="commonDivLeft">										
												<select name="commYear" onChange="getCommGrCode('');" class="mr10">
													<option value="">**선택하세요**</option>
												</select>
											</div>
										</td>
										<th width="80">
											과정명
										</th>
										<td>	
											<div id="divCommGrCode" class="commonDivLeft">
												<select id="commGrcode" name="commGrcode" class="mr10">
													<option value="">**선택하세요**</option>
												</select>
											</div>
										</td>
										<td width="100" class="btnr" rowspan="3">
											<input type="button" value="검색" onclick="go_search();return false;" class="boardbtn1">
											<input type="button" value="EXCEL" onclick="go_excel();return false;" class="boardbtn1">
											<input type='button' value='출력' onclick="go_pollAI();" class='boardbtn1' />
										</td>
									</tr>
									<tr>
										<th class="bl0">
											기수명
										</th>
										<td>
											<div id="divCommGrSeq" class="commonDivLeft">
												<select id="commGrseq" name="commGrseq" class="mr10">
													<option value="">**선택하세요**</option>
												</select>
											</div>
										</td>
										<th>
											조회
										</th>
										<td>
											<input type="radio" class="chk_01" name="searchRgrayn" id="searchRa1" value="Y" <%= requestMap.getString("searchRgrayn").equals("Y") ? "checked" : "" %>/><label for="searchRa1">이수</label>
											<input type="radio" class="chk_01" name="searchRgrayn" id="searchRa2" value="N" <%= requestMap.getString("searchRgrayn").equals("N") ? "checked" : "" %>/><label for="searchRa2">미이수</label>
											<input type="radio" class="chk_01" name="searchRgrayn" id="searchRa3" value="" <%= requestMap.getString("searchRgrayn").equals("") ? "checked" : "" %>/><label for="searchRa3">전체 </label>
										</td>
									</tr>
								<%
								//특정 관리자만 검색할수 있는 Select Box 생성.
								if(memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN)
										|| memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSE)
										|| memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSEMAN) ){
								%>
									<tr>
										<th class="bl0">
											기관선택
										</th>
										<td colspan="3">
											<select name="searchDept" class="mr10">
												<option value="">전체조회</option>
												<%= selDetpStr %>
											</select>
										</td>
									</tr>
								<%}%>
								</table>
								<!--//검색 -->
								<div class="space01"></div>
								<div class="h5"></div>
								<!-- subText -->
								<div class="tit01" style="padding-left:0;">
									전체교육생수 : <strong><%= requestMap.getInt("totalCnt") %></strong>명 <span class="txt_99">(<%= grseqStatusStr %>)</span>
								</div> 
								<!-- //subText -->
								<div class="h10"></div>
								
								<!--[s] 리스트  -->
								<table class="datah01">
									<thead>
										<tr>
											<th>성명</th>
											<th>생년월일</th>
											<th>ID</th>
											
											<!-- 
											<th>주민번호</th>
											 -->
											 
											<th>소속</th>
											<th>부서</th>
											<th>직급명</th>
											<th>교육일자</th>
											<th>교번</th>
										<% if(!memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) ){ %>
											<th>성적</th>
											<th>석차</th>
										<% } %>
											<th>수료</th>
											<th class="br0">수료<br>번호</th>
										</tr>
									</thead>
									<tbody>
									<%= listStr.toString() %>
									</tbody>
								</table>
								<!--//[e] 리스트  -->	
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
	<script language="JavaScript"> 
//AI Report
document.write(tagAIGeneratorOcx);
</script>
	
</body>

