<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 가입회원에 대한 통계화면 리스트
// date : 2008-08-12
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
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//학력리스트  데이터
	DataMap educationMap = (DataMap)request.getAttribute("EDUCATION_LIST_DATA");
	listMap.setNullToInitialize(true);

	//필드 카운터수
	int fieldCount = requestMap.getInt("fieldCount");
	
	StringBuffer html = new StringBuffer();
	StringBuffer subMenu = new StringBuffer();
	String searchType = requestMap.getString("searchType");
	//월수가 1월~ 12월을 넘어가 다음년도가 될경우를 대비
	int tempCount = 0;
	if(fieldCount > 0){
		tempCount = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
		for(int i= 0; (fieldCount-1) > i; i++){
			if(tempCount > 12){
				tempCount = 1;
			}
			subMenu.append("<th>"+tempCount+"월</th>");
			tempCount++;
		}
	}
	
	//학력별에서 비어있는 항목을 한번만 표현하기위한 체크 변수
	int schoolCount = 0;
	if(listMap.keySize() > 0){
		for(int i = 0; listMap.keySize() > i; i++){
			html.append("<tr>");
			html.append("<td>"+(i+1)+"</td>");
			
			//월별검색 데이터는 제목이없으므로 빈값처리한다.
			if(searchType.equals("month")){
				//월별
				html.append("<td>월별</td>");
				
			}else if(searchType.equals("dept")){
				//기관별
				html.append("<td>"+listMap.getString("deptnm", i)+"</td>");
				
			}else if(searchType.equals("jik")){
				//직급별
				html.append("<td>"+listMap.getString("jiknm", i)+"</td>");				
				
			}else if(searchType.equals("sigun")){
				//시군별
				html.append("<td>"+listMap.getString("sigugun", i)+"</td>");
				
			}else if(searchType.equals("school")){
				//학력별
				for(int k = 0;  k < educationMap.keySize("gubun"); k++){
					if(listMap.getString("school", i).equals(educationMap.getString("gubun", k))){
						html.append("<td>"+educationMap.getString("gubunnm", k)+"</td>");
					}
					if(listMap.getString("school", i).equals("") && schoolCount == 0){
						html.append("<td>미등록</td>");
						schoolCount = 1;
					}
				}

				
			}else if(searchType.equals("resno")){
				//연령별
				if(i < 6){
					html.append("<td>"+listMap.getString("userAge", i)+"대</td>");					
				}else{
					html.append("<td>"+listMap.getString("userAge", i)+"대 이상</td>");					
				}
			}
			
			for(int j = 0; (fieldCount-1) > j; j++){
				
				if(searchType.equals("resno")){

					html.append("<td>"+listMap.getString("t"+(j+1), i)+"</td>");	
					
				}else{
					html.append("<td>"+listMap.getString("month"+(j+1), i)+"</td>");
					
				}
					
				
			}
			html.append("<td class=\"br0\">&nbsp;</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("<td style=\"height:100px;\" colspan=\"100%\" class=\"br0\">등록된 데이터가 없습니다.");
		html.append("</td>");
		html.append("</tr>");
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

//검색
function go_search(){

	var sYear = $("sDate").value;
	var eYear = $("eDate").value;
	var sMonth = $("sDate").value;
	var eMonth = $("eDate").value;

	var totalYear = Number(eYear.substr(0, 4)) - Number(sYear.substr(0, 4));
	var totalMonth = Number(eMonth.substr(4, 6)) - Number(sMonth.substr(4, 6));
	
	var total = (totalYear * 12) + totalMonth;
	if(total > 24){
		alert("검색기간은 2년 이하입니다.");
		return false;
		
	}
	
		
	if(NChecker($("pform"))){
		if(IsValidCharSearch($("searchType").value) == false){
			return false;
		}
		
		if($F("sDate").length != "6"){
			alert("시작일을 정확히 입력하여 주십시오.");
			return false;
		}
		
		if($F("eDate").length != "6"){
			alert("종료일을 정확히 입력하여 주십시오.");
			return false;
		}
		
		
		if($F("sDate") > $F("eDate")){
			alert("종료일이 시작일보다 빠릅니다. 다시 등록하여 주십시오.");
			return false;
		}
		
		if($F("sDate").substr(4, 6) > 12){
			alert("검색조건인 시작일자의 월수가 12월을 넘을수없습니다. 다시 입력하여주십시오.");
			return false;
		}
		
		if($F("eDate").substr(4, 6) > 12){
			alert("검색조건인 마지막일자의 월수가 12월을 넘을수없습니다. 다시 입력하여주십시오.");
			return false;
		}

		if($F("sDate").substr(4, 6) == 0){
			alert("검색조건인 시작일자의 월수는 1월이상 입니다. 다시 입력하여주십시오.");
			return false;
		}
		
		if($F("eDate").substr(4, 6) == 0){
			alert("검색조건인 마지막일자의 월수가  1월이상 입니다.  다시 입력하여주십시오.");
			return false;
		}
	
		$("mode").value = "memberStats";
		pform.action = "/statisMgr/stats.do";
		pform.submit();
	}
}

function go_excel(){
	if(NChecker($("pform"))){
	
		if($F("sDate") > $F("eDate")){
			alert("종료일이 시작일보다 빠릅니다. 다시 등록하여 주십시오.");
			return false;
		}
		
		if($F("sDate").substr(4, 6) > 12){
			alert("출력 시작일자의 월수가 12월을 넘을수없습니다. 다시 입력하여주십시오.");
			return false;
		}
		
		if($F("eDate").substr(4, 6) > 12){
			alert("출력 마지막일자의 월수가 12월을 넘을수없습니다. 다시 입력하여주십시오.");
			return false;
		}
		$("mode").value = "memberStatsExcel";
		pform.action = "/statisMgr/stats.do";
		pform.submit();
	}
}


</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu" value="">
<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">

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

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>가입회원통계 게시판</strong>
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
					
				     	<!-- tab -->						
						<jsp:include page="topMenu.jsp" flush="false">
							<jsp:param name="tabIndex" value="8" />
						</jsp:include>
						<!-- //tab -->
						<div class="space01"></div>
						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									검색조건
								</th>
								<td width="20%">
									<select name="searchType" class="mr10">
										<option value="month">
											**월별**
										</option>
										<option value="dept">
											**기관별**
										</option>
										<option value="jik">
											**직급별**
										</option>
										<option value="sigun">
											**주소지별**
										</option>
										<option value="resno">
											**연령대별**
										</option>
										<option value="school">
											**학력별**
										</option>								
									</select>
								</td>
								<th width="80">
									기간
								</th>
								<td>
									<input type="text" class="textfield" name="sDate" maxlength="6" size="9" required="true!기간이 없습니다." dataform="num!숫자만 입력해야 합니다."  value="<%=requestMap.getString("sDate") %>"/>
									 
									  ~
									 <input type="text" class="textfield" name="eDate" maxlength="6" size="9" required="true!기간이 없습니다." dataform="num!숫자만 입력해야 합니다."  value="<%=requestMap.getString("eDate") %>"/>
									 ( 기간입력 예 :199901 )
								</td>
								<td width="100" class="btnr">
									<input type="button" value="조회" onclick="go_search();" class="boardbtn1">
									<input type="button" value="출력" onclick="go_excel();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<%=subMenu.toString() %>
								<th class="br0">비고</th>
							</tr>
							</thead>

							<tbody>
							<%=html.toString() %>
							</tbody>
						</table>
						<!--//리스트  -->
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
	var searchType = "<%=requestMap.getString("searchType")%>";
	len = $("searchType").options.length
	
	for(var i=0; i < len; i++) {
		if($("searchType").options[i].value == searchType){
			$("searchType").selectedIndex = i;
		 }
 	 }
</script>
