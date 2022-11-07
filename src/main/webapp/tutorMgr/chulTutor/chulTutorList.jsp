<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 출강강사 명단 리스트
// date  : 2008-07-10
// auth  : 정윤철
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
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	

	//출강강사 전체 카운트  데이터
	DataMap totalCount = (DataMap)request.getAttribute("TOTALCOUNT_DATA");
	totalCount.setNullToInitialize(true);
	
	//과정별 출강강사 카운트
	DataMap courseTotalCount = (DataMap)request.getAttribute("COURSETOTALCOUNT_DATA");
	courseTotalCount.setNullToInitialize(true);
	
	//과정별 출강강사 총카운트 데이터
	DataMap courseCount = (DataMap)request.getAttribute("COURSECOUNT_DATA");
	courseCount.setNullToInitialize(true);

	//과정별 소계 데이터
	DataMap courseList = (DataMap)request.getAttribute("COURSELIST_DATA");
	courseList.setNullToInitialize(true);

	StringBuffer html = new StringBuffer();
	if(listMap.keySize("tlevel") > 0){
		for(int i=0; listMap.keySize("tlevel") > i; i++){
			html.append("<tr>");
			html.append("<td align=\"center\">"+(pageNum-i)+"</td>");
			html.append("<td align=\"center\" width=\"115\">"+(listMap.getString("grcodenm",i).equals("") ? "&nbsp" : listMap.getString("grcodenm",i))+"</td>");
			html.append("<td align=\"center\">"+listMap.getString("lecnm",i)+"</td>");
			html.append("<td align=\"center\">"+listMap.getString("grseq",i)+"</td>");
			html.append("<td align=\"center\" width=\"40\">"+listMap.getString("name",i)+"</td>");
			if(listMap.getString("tgubun",i).equals("1")){
				html.append("<td align=\"center\" width=\"55\">주강사</td>");
				
			}else if(listMap.getString("tgubun",i).equals("0")){
				html.append("<td align=\"center\">보조강사</td>");
				
			}else{
				html.append("<td align=\"center\">&nbsp;</td>");
				
			}
			html.append("<td align=\"center\">"+listMap.getString("tposition",i)+"</td>");
			html.append("<td align=\"center\">"+listMap.getString("jikwi",i)+"</td>");
			html.append("<td align=\"center\" class=\"br0\">"+listMap.getString("homeTel",i)+"</td>");
			html.append("</tr>");			
		}
	}else{
		html.append("<tr>");
		html.append("<td align=\"center\" colspan=\"100%\" class=\"br0\" style=\"height:100px\">등록된 출강강사가 없습니다.</td>");
		html.append("</tr>");		
	}
	//전체 카운트 버퍼
	StringBuffer count = new StringBuffer();
	//출강강사별 버퍼	
	StringBuffer curCount = new StringBuffer();
	
	if(courseTotalCount.keySize() > 0 ){
		curCount.append("<tr>");
		curCount.append("<td align=\"center\"><strong>과정별소계</strong></td>");
		curCount.append("<td align=\"center\">"+courseTotalCount.getString("total")+"</td>");
		if(courseCount.keySize("tgbun") > 0){
			for(int i=0; courseCount.keySize("tgubun") > i; i++){
				if(totalCount.keySize() == 1){
					if(totalCount.getString("tcnt").equals("1")){
						curCount.append("<td align=\"center\">0</td>");
						curCount.append("<td align=\"center\" class=\"br0\">"+courseCount.getString("tcnt",i)+"&nbsp;</td>");
					}else{
						curCount.append("<td align=\"center\">"+courseCount.getString("tcnt",i)+"&nbsp;</td>");
						curCount.append("<td align=\"center\" class=\"br0\">0</td>");
					}
				}else{
					if(courseCount.getString("tgubun",i).equals("1")){
						curCount.append("<td align=\"center\">"+courseCount.getString("tcnt",i)+"&nbsp;</td>");
						
					}else if(totalCount.getString("tgubun",i).equals("0")){
						curCount.append("	<td align=\"center\" class=\"br0\">"+courseCount.getString("tcnt",i)+"&nbsp;</td>");
						
					}
				}
			}
		}else{
			curCount.append("<td align=\"center\">0</td>");
			curCount.append("<td align=\"center\" class=\"br0\">0</td>");
		}
		count.append("</tr>");
	}
	
	count.append("<tr>");
	count.append("<td align=\"center\"><strong>전체총합계</stron></td>");
	count.append("<td align=\"center\">"+totalCount.getString("total")+"</td>");
	for(int i=0; totalCount.keySize("tgubun") > i; i++){
		if(totalCount.getString("tgubun",i).equals("1")){
			count.append("<td align=\"center\" class=\"br0\">"+totalCount.getString("tcnt",i)+"&nbsp;</td>");
			
		}else if(totalCount.getString("tgubun",i).equals("0")){
			count.append("	<td align=\"center\">"+totalCount.getString("tcnt",i)+"&nbsp;</td>");
			
		}
	}
	count.append("</tr>");
	
	StringBuffer option = new StringBuffer();
	for(int i=0; courseList.keySize("grcode") > i; i++){
		option.append("<option value=\""+courseList.getString("grcode",i)+"\">"+courseList.getString("grcodenm",i)+"</option>");
		
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


<script language="JavaScript">
<!--
	//검색
	function go_serach(){
		$("mode").value = "list";
	
		if($("gubun").value == "date"){
		
			if($("date1").value == "" || $("date1").value ==null){
				alert("기간별 시작일을 선택하십시오.")
				return false;
			}
		
			if($("date2").value == "" || $("date2").value ==null){
				alert("기간별 종료일을 선택하십시오.")
				return false;
			}
		
		
			if($("date1").value > $("date2").value){
				alert("시작일이 종료일보다 낮을수 없습니다.")
				return false;
			}
			
		}
		if(NChecker($("pform"))){
			
			if($("gubun").value == "date"){
				$("year").value = "";
				
			}else{
				$("date1").value = "";
				$("date2").value = "";
				
			}
	
			$("currPage").value= "";
			pform.action = "/tutorMgr/chulTutor.do";				
			pform.submit();
		}
	}
	
	//현재 년도 검색인지 또는 날짜 검색인지 구분
	function chk(chkValue){
		if(chkValue == 1){
			$("gubun").value ="year";
			
		}else if(chkValue == 2){
			$("gubun").value ="date";
			
		}
	}
	
	//페이지 이동
	function go_page(page) {
		$("currPage").value = page;
		go_list();
	}
	
	//리스트페이지
	function go_list(){
		$("mode").value = "list";
		pform.action = "/tutorMgr/chulTutor.do";				
		pform.submit();
	}
	
	//출강강사내역 엑셀 출력
	function go_excel(){
		$("mode").value = "excel";
		pform.action = "/tutorMgr/chulTutor.do";				
		pform.submit();
	
	}
//페이지 열릴때 사용 되는 스크립트
onload = function(){

}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="qu"		value="">
<input type="hidden" name="gubun"		value="<%=!requestMap.getString("gubun").equals("") ? requestMap.getString("gubun") : "year"%>">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>출강강사명단</strong>
					</td>
				</tr>
			</table> 
			<!--[e] subTitle -->
			<div class="space01"></div>
			<!--[s] Contents Form  -->
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
									날짜선택
								</th>
								<td colspan="3">
									<input type="radio"  name="use" onclick="chk('1');" value="" <%=!requestMap.getString("gubun").equals("date") ? "checked" : ""%> />
									연도별
									<input type="text" maxLength="4" dataform="num!숫자만 입력해야 합니다." class="textfield mr10" name="year" value="<%=requestMap.getString("year") %>" style="width:100px" />
									
									
									<input type="radio" name="use" onclick="chk('2');" value="" <%=requestMap.getString("gubun").equals("date") ? "checked" : ""%>/>
									기간별
									<input type="text" class="textfield" name="date1" value="<%=requestMap.getString("date1")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','date1');" src="../images/icon_calen.gif" alt="" />
									~
									<input type="text" class="textfield" name="date2" value="<%=requestMap.getString("date2")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','date2');" src="../images/icon_calen.gif" alt="" />
								</td>
								<td width="100" class="btnr" rowspan="2">
									<input type="button" value="검 색" onclick="go_serach();" class="boardbtn1">
								</td>								
							</tr>
							<tr>
								<th class="bl0">
									과정선택 
								</th>
								<td>
									<select name="grcode" class="mr10">
										<option selected  value="">
											**선택하세요**
										</option>
											<%=option.toString() %>
									</select>									
								</td>
								<th>
									정렬순 
								</th>
								<td>
									<input type="radio" name="order" value="A.GRCODENM" <%=requestMap.getString("order").equals("B.NAME") ? "" : "checked"%>>
									<label for="use">
										과정명  
									</label>
									<input type="radio" name="order" value="B.NAME" <%=requestMap.getString("order").equals("B.NAME") ? "checked" : ""%>>
									<label for="use_y">
										강사명  
									</label>
									<input type="radio" name="order" value="A.LECNM" <%=requestMap.getString("order").equals("A.LECNM") ? "checked" : ""%>>
									<label for="use_n">
										과목명  
									</label>
								</td>				
							</tr>
						</table>
						<!--//검색 -->
						<div class="space01"></div>
						
						<!-- 상단 버튼  -->
						<table class="btn01">
							<tr>
								<td class="left">
									<span class="mr10"><span class="txt_blue">총계 :</span> <strong></strong><%=totalCount.getInt("total") %>명</span>  
									<span class="txt_blue">기관명 :</span> 인천공무원교육원 

								</td>
								<td class="right">
									<input type="button" value="내역확인서 출력" onclick="go_excel();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--// 상단 버튼  -->

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>연번</th>
								<th>과정명</th>
								<th>교과목</th>
								<th>기수</th>
								<th>강사명</th>
								<th>강사구분</th>
								<th>강사소속</th>
								<th>직위</th>
								<th class="br0">전화번호</th>
							</tr>
							</thead>

							<tbody>
							<%=html %>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	

						<!-- 페이징 --> 
						<div class="paging">
							<%=pageStr%>
						</div>
						<!-- //페이징 -->
						<div class="space01"></div>

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th></th>
								<th>전체</th>
								<th>보조강사</th>
								<th class="br0">주강사</th>
							</tr>
							</thead>

							<tbody>
							<%=curCount.toString() %>
							<%=count.toString() %>
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
</body>

<script language="JavaScript" type="text/JavaScript">
	//검색 조건 셀렉티드
	var grcode = "<%=requestMap.getString("grcode")%>";
	len = $("grcode").options.length
	
	for(var i=0; i < len; i++) {
		if($("grcode").options[i].value == grcode){
			$("grcode").selectedIndex = i;
		 }
 	 }
</script>