<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 질문방 리스트
// date : 2008-07-09
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

	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");

	String tmpStr = "";
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	//String tmpRowStr = "";
	
	//년도 셀렉트박스 만들기
	Calendar cal = Calendar.getInstance();
	int year = cal.get(java.util.Calendar.YEAR);
	int month = cal.get(java.util.Calendar.MONTH) + 1;
	StringBuffer selYear = new StringBuffer();
	String reqYear = requestMap.getString("commYear");
	if(reqYear == "") reqYear = ""+year;	//금년도를 기본으로 선택
	
	for(int i=year+1; i >= 2000; i--) {
		//Selected 선택
		if((""+i).equals(requestMap.getString("commYear"))) {
			selYear.append("<option value=\""+i+"\" selected=\"selected\">"+i+"</option>");
		} else {
			selYear.append("<option value=\""+i+"\">"+i+"</option>");
		}
	}
	
	//기수 셀렉트박스 만들기
	StringBuffer selGrseq = new StringBuffer();
	String reqGrseq = "";
	if(requestMap.getString("grseq") != "") reqGrseq = requestMap.getString("grseq").substring(4);
	
	for(int j=1; j <= 9; j++) {
		//Selected 선택
		if(("0"+j).equals(reqGrseq)) {
			selGrseq.append("<option value=\"0"+j+"\" selected=\"selected\">0"+j+"기</option>");
		} else {
			selGrseq.append("<option value=\"0"+j+"\">0"+j+"기</option>");
		}
	}
	
	//테이블 그리기...
	for(int i=0; i < listMap.keySize("grcode"); i++){

		if( listMap.getInt("depth", i) == 0 ){

			listStr.append("\n<tr>");
			//번호
			listStr.append("\n	<td rowspan='2'>" + (pageNum-i) + "</td>");
			//과정명
			listStr.append("\n	<td rowspan='2'>" + listMap.getString("grcodenm", i) + "</td>");
			//기수
			listStr.append("\n	<td rowspan='2'>" + listMap.getString("grseq", i).substring(0, 4) + "-"+listMap.getString("grseq", i).substring(4)+"기 </td>");
			//제목
			tmpStr = "[건의] <a href=\"javascript:go_view('"+listMap.getString("grcode", i)+"','"+listMap.getString("grseq", i)+"','"+listMap.getString("no", i)+"');\" >"+listMap.getString("title", i)+"</a>";
			listStr.append("\n	<td class='sbj'>" + tmpStr + "</td>");
			//첨부
			tmpStr = ( listMap.getInt("groupfileNo", i) != 0 && listMap.getInt("groupfileNo", i) != -1  )  ? "<a href='javascript:fileDownloadPopup("+listMap.getString("groupfileNo", i)+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : "없음";
			listStr.append("\n	<td>" + tmpStr + "</td>");
			//분류
			listStr.append("\n	<td rowspan='2'>" + listMap.getString("category", i) + "</td>");
			//답변
			if( listMap.getString("finishYn", i).equals("Y") )
				tmpStr = "완료";
			else if( listMap.getString("finishYn", i).equals("D") )
				tmpStr = "삭제";
			else
				tmpStr = "진행중";
			listStr.append("\n	<td rowspan='2'>" + tmpStr + "</td>");
			//작성자
			listStr.append("\n	<td>" + listMap.getString("name", i) + "</td>");
			//작성일
			listStr.append("\n	<td>" + listMap.getString("regdate", i) + "</td>");
			listStr.append("\n</tr>");
	


			// 답변 항목
			DataMap lowMap = (DataMap)listMap.get("LOW_ROW_DATA", i);
			if(lowMap == null) lowMap = new DataMap();
			lowMap.setNullToInitialize(true);

			if( !lowMap.getString("no").equals("")){ //답변이 있다면

				listStr.append("\n<tr>");
				//제목
				listStr.append("\n	<td class='sbj'>" + lowMap.getString("title") + "</td>");
				//첨부
				tmpStr = (lowMap.getInt("groupfileNo") != 0 && lowMap.getInt("groupfileNo") != -1) ? "<a href='javascript:fileDownloadPopup("+lowMap.getString("groupfileNo")+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : "없음";
				listStr.append("\n	<td>" + tmpStr + "</td>");
				//작성자
				listStr.append("\n	<td>" + lowMap.getString("name") + "</td>");
				//작성일
				listStr.append("\n	<td>" + lowMap.getString("regdate") + "</td>");
				listStr.append("\n</tr>");

			}else{ //답변이 없다면

				listStr.append("\n<tr>");
				//제목
				listStr.append("\n	<td colspan='2' class='sbj'><font color='red'>조치사항을 입력하세요.</font></td>");
				//작성자
				listStr.append("\n	<td>&nbsp;</td>");
				//작성일
				listStr.append("\n	<td>&nbsp;</td>");
				listStr.append("\n</tr>");

			}

		} //end if depth

	} //end for 



	//row가 없으면.
	if( listMap.keySize("grcode") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' class='br0' style='height:100px'>건의사항이 없습니다.</td>");
		listStr.append("\n</tr>");

	}


	//페이징 String
	String pageStr = "";
	if(listMap.keySize("grcode") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
	$("currPage").value = 1;
	go_list();
}
//검색
function go_search(){
	$("currPage").value = 1;
	go_list();
}
//리스트
function go_list(){

	//년도, 기수
	var selYear  = document.getElementById("CommYear");
	var selGrseq = document.getElementById("CommGrseq");
	var commYear = selYear.options[selYear.selectedIndex].value;
	var commGrseq = selGrseq.options[selGrseq.selectedIndex].value;
	$("grseq").value = commYear + commGrseq;
	$("mode").value = "list";

	pform.action = "/courseMgr/question.do";
	pform.submit();

}

//수강생 이력 정보 조회
function go_print(){

	if( $F("grcode") == "" || $F("grseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}

	params='init_mode=view';
	popAI("http://<%= Constants.AIREPORT_URL %>/report/test/report_2.jsp?p_grcode=" + $F("grcode") + "&p_grseq=" + $F("grseq"));

}


//상세보기
function go_view(grcode, grseq, no){

	$("grcode").value = grcode;
	$("grseq").value = grseq;
	
	$("mode").value = "view";
	$("qu").value = "view";
	
	$("no").value = no;

	pform.action = "/courseMgr/question.do";
	pform.submit();
}





//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = "grSeq"; 

	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	//getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	//getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);
}


//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">

<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">

<input type="hidden" name="qu"					value="">
<input type="hidden" name="no"					value="">

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
			<!-- subTitle
			<div class="tit01">
				<h2 class="h2"><img src="../images/bullet003.gif">과정기수관리 리스트</h2>
			</div>
			// subTitle -->

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
										<!-- <select id="commYear" name="commYear" onChange="getCommGrCode('grSeq');" class="mr10"> -->
										<select name="commYear" class="mr10">
											<option value="">**선택하세요**</option>
											<%= selYear.toString() %>
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
										<select id="commGrseq" name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
											<%= selGrseq.toString() %>
										</select>
									</div>
								</td>
							</tr>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>


						<!--[s] 리스트  -->
						<div class="datatbl01">

							<table class="datah01">
								<thead>
								<tr>
									<th>No</th>
									<th>과정명</th>
									<th>기수</th>
									<th width="100px">제목</th>
									<th>첨부</th>
									<th>분류</th>
									<th>답변</th>
									<th>작성자</th>
									<th class="br0">작성일</th>
								</tr>
								</thead>

								<tbody>
								<%= listStr.toString() %>
								</tbody>
							</table>


							<div class="paging">
								<%=pageStr%>		
							</div>

							<!-- 테이블하단 버튼  -->
							<table class="btn01" style="clear:both;">
								<tr>
									<td class="right">
										<input type="button" value="출력" onclick="go_print();" class="boardbtn1">
									</td>
								</tr>
							</table>
							<!-- //테이블하단 버튼  -->
							<div class="space01"></div>


						</div>

						
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
    document.write(tagAIGeneratorOcx);
</script>
</body>

