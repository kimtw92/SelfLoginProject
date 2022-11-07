<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사 이력관리
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
	
	//기본등급 수당
	DataMap allowanceMap = (DataMap)request.getAttribute("ALLOWANCELIST_DATA");
	allowanceMap.setNullToInitialize(true);
	 
	//강사등급별 등급네임
	DataMap cousrNameMap = (DataMap)request.getAttribute("NAMELIST_DATA");
	cousrNameMap.setNullToInitialize(true);
	
	//등급별 카운터수
	DataMap cousrNameCountMap = (DataMap)request.getAttribute("COUNTLIST_DATA");
	cousrNameCountMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//기본수당변수
	int tempTutorSalary = 0;
	
	StringBuffer html = new StringBuffer();
	
	String sTime = "";
	String eTime = "";
	String totalTime = "";
	if(listMap.keySize("tuserno") > 0){

		for(int i=0; i < listMap.keySize("tuserno"); i++){
			if(listMap.getInt("tottime",i) == (listMap.getInt("maxStudytime",i) - listMap.getInt("minStudytime",i)+1)){
				if(listMap.getInt("minStudytime",i) == 1){
					sTime = "09:00";
					
				}else if(listMap.getInt("minStudytime",i) == 2){
					sTime = "10:00";
					
				}else if(listMap.getInt("minStudytime",i) == 3){
					sTime = "11:00";
					
				}else if(listMap.getInt("minStudytime",i) == 4){
					sTime = "12:00";
					
				}else if(listMap.getInt("minStudytime",i) == 5){
					sTime = "13:00";
					
				}else if(listMap.getInt("minStudytime",i) == 6){
					sTime = "14:00";
					
				}else if(listMap.getInt("minStudytime",i) == 7){
					sTime = "15:00";
					
				}else if(listMap.getInt("minStudytime",i) == 8){
					sTime = "16:00";
					
				}else if(listMap.getInt("minStudytime",i) == 9){
					sTime = "17:00";
					
				}
				
				if(listMap.getInt("maxStudytime",i) == 1){
					eTime = "09:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 2){
					eTime = "10:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 3){
					eTime = "11:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 4){
					eTime = "12:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 5){
					eTime = "13:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 6){
					eTime = "14:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 7){
					eTime = "15:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 8){
					eTime = "16:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 9){
					eTime = "17:50";
					
				}
			}
			
			if(sTime.equals("")){
				totalTime = "-";
			}else{
				totalTime = sTime+"~<br>"+eTime;
			}
			
			html.append("\n<tr>");
			//번호
			html.append("\n	<td align=\"center\">"+(pageNum - i )+"</td>");
			//성명
			html.append("\n	<td align=\"center\">"+(listMap.getString("name", i).equals("") ? "&nbsp" : listMap.getString("name",i) )+"</td>");
			//소속 및 직위
			html.append("\n	<td align=\"center\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"padding:0 0 0 0\" width=\"100%\"><tr><td width=\"100%\" style=\"border-right-width: 0px\">"+(listMap.getString("tposition", i).equals("") ? "&nbsp" : listMap.getString("tposition",i) )+"</td></tr><tr><td style=\"border-bottom-width: 0px;border-right-width: 0px\">");
			html.append((listMap.getString("jikwi", i).equals("") ? "&nbsp" : listMap.getString("jikwi",i) )+"</td></tr></table>");
			
			html.append("\n	<td align=\"center\">"+(listMap.getString("grcodeniknm", i).equals("") ? "&nbsp" : listMap.getString("grcodeniknm",i) )+"<br>");
			html.append((listMap.getString("lecnm", i).equals("") ? "&nbsp" : listMap.getString("lecnm", i) )+"</td>");
			
			html.append("\n	<td align=\"center\">"+(listMap.getString("resno", i).equals("") ? "&nbsp" : listMap.getString("resno", i) )+"</td>");
			
			html.append("\n	<td align=\"center\">"+(listMap.getString("bankname", i).equals("") ? "&nbsp" : listMap.getString("bankname", i) )+"<br>");
			html.append("\n	"+(listMap.getString("bankno", i).equals("") ? "&nbsp" : listMap.getString("bankno", i) )+"</td>");
			
			html.append("<td align=\"center\">"+(listMap.getString("started", i).equals("") ? "&nbsp" : listMap.getString("started", i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("tottime", i).equals("") ? "&nbsp" : listMap.getString("tottime", i) )+"</td>");
			html.append("<td align=\"center\">"+totalTime+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("levelName", i).equals("") ? "&nbsp" : listMap.getString("levelName", i) )+"</td>");
			for(int j =0; j < allowanceMap.keySize("tlevel"); j++){
				tempTutorSalary = 0;
				String strTime = listMap.getString("tottime", i);
				//예외 처리 값이없을때를 대비한다.
				int intTime = 0;
				
				if(!strTime.equals("")){
					intTime = Integer.parseInt(strTime);
					
				}
				
				//사이버강사
				if(listMap.getString("levelName", i).equals(allowanceMap.getString("levelName", j))){
					if(listMap.getString("subjtype", i).equals("N")){
						tempTutorSalary = intTime * allowanceMap.getInt("cDefaultAmt", j);	
						break;
					}else if(listMap.getString("subjtype", i).equals("Y")){
						//집합강사
						tempTutorSalary = intTime * allowanceMap.getInt("gDefaultAmt", j);	
						break;
					}
				}
			}
			html.append("<td class=\"br0\">"+NumConv.setComma(tempTutorSalary)+"원</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("<td align=\"center\" class=\"br0\" colspan=\"100%\" style=\"height:100px\">등록된 데이터가 없습니다.</td>");
		html.append("</tr>");	
	}
	
	
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("tuserno") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	StringBuffer cousrName = new StringBuffer();
	cousrName.append("<span class=\"mr10\"><strong>"+cousrNameCountMap.getString("aTotal")+"</span>");
	cousrName.append("<span class=\"mr10\"><strong>"+cousrNameCountMap.getString("a1Total")+"</span>");
	cousrName.append("<span class=\"mr10\"><strong>"+cousrNameCountMap.getString("bTotal")+"</span>");
	cousrName.append("<span class=\"mr10\"><strong>"+cousrNameCountMap.getString("c1Total")+"</span>");
	cousrName.append("<span class=\"mr10\"><strong>"+cousrNameCountMap.getString("c2Total")+"</span>");
	cousrName.append("<span class=\"mr10\"><strong>"+cousrNameCountMap.getString("dTotal")+"</span>");
	cousrName.append("<span class=\"mr10\"><strong>"+cousrNameCountMap.getString("zTotal")+"</span>");
	
	StringBuffer option = new StringBuffer();
	if(cousrNameMap.keySize("tlevel") > 0){
		for(int i=0; cousrNameMap.keySize("tlevel") > i; i++){
			option.append("\n<option value=\""+cousrNameMap.getString("tlevel",i)+"\">"+cousrNameMap.getString("levelName",i)+"</option>");
			
		}
	}
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
//검색
function go_search(){

	if($("sDate").value == "" || $("sDate").value ==null){
		alert("시작일을 선택하십시오.")
		return false;
	}

	if($("eDate").value == "" || $("eDate").value ==null){
		alert("종료일을 선택하십시오.")
		return false;
	}


	if($("sDate").value > $("eDate").value){
		alert("시작일이 종료일보다 낮을수 없습니다.")
		return false;
	}
	
	if(NChecker($("pform"))){
		$("mode").value = "historyTutorList";
		$("qu").value = "search";
		pform.action = "/tutorMgr/historyTutor.do";				
		pform.submit();
	}
}

function go_check(qu){

	
	if(qu == "search"){
		go_search();
	}else{
		go_excel()
	}
	
}

function go_excel(){
	$("mode").value = "historyTutorexcel"

	if(NChecker($("pform"))){
		pform.action = "/tutorMgr/historyTutor.do";				
		pform.submit();
		
	}
	
}
//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}
//리스트
function go_list(){
	$("mode").value = "historyTutorList";
	pform.action = "/tutorMgr/historyTutor.do";				
	pform.submit();
}
//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="qu"		value="">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강사이력관리</strong>
					</td>
				</tr>
			</table> 
			<!--[e] subTitle -->
			<div class="space01"></div>
			<!--[s] Contents Form  -->
			<div class="h10"></div>
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									구분
								</th>
								<td>
									<select name="tlevel" class="mr10">
										<option selected value="">
											**전체**
										</option>
										<%=option.toString() %>

									</select>	
								</td>
								<td width="140" class="btnr" rowspan="2">
									<input type="button" value="검 색" onclick="go_check('search');" class="boardbtn1">
									<input type="button" value="엑셀출력" onclick="go_check('excel');" class="boardbtn1">
								</td>								
							</tr>
							<tr>
								<th class="bl0">
									검색기간 
								</th>
								<td>
									<input type="text" class="textfield" name="sDate" value="<%=requestMap.getString("sDate")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','sDate');" src="../images/icon_calen.gif" alt="" />
									~
									<input type="text" class="textfield" name="eDate" value="<%=requestMap.getString("eDate")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','eDate');" src="../images/icon_calen.gif" alt="" />
									<select name="" class="mr10">
										<option selected value="B.STARTED">날짜순 정렬</option>
										<option value="NAME">이름순정렬</option>
									</select>	
								</td>		
							</tr>
						</table>
						<!--//검색 -->
						<div class="space01"></div>

						<!-- subTitle -->
						<div class="tit01" style="padding-left:0;">
						<%=cousrName.toString() %>
						</div>
						<!-- // subTitle -->						
						<div class="h5"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th width="60">성명</th>
								<th>소속 및 <br>직위</th>
								<th>과정(기수)및 <br>과목명</th>
								<th>주민<br>번호</th>
								<th>계좌<br>번호</th>
								<th>강의일자</th>
								<th>시간</th>
								<th>강의<br>시간</th>
								<th>등급</th>
								<th class="br0">금액</th>
							</tr>
							</thead>

							<tbody>
							<%=html.toString() %>
							</tbody>
						</table>
						<!--//리스트  -->	

						<!-- 페이징 --> 
						<div class="paging">
							<%=pageStr%>
						</div>
						<!-- //페이징 -->
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
	var tlevel = "<%=requestMap.getString("tlevel")%>";
	len = $("tlevel").options.length

	for(var i=0; i < len; i++) {
		if($("tlevel").options[i].value == tlevel){
			$("tlevel").selectedIndex = i;
		 }
 	 }
</script>