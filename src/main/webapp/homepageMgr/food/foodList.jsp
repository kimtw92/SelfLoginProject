<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 식단관리 리스트
// date  : 2008-08-7
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
	
	StringBuffer html = new StringBuffer();
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("fyear") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	int cnt = 1;
	int num = 1;
	int currPage = requestMap.getInt("currPage");
	int totalpage = 0;
	if(currPage > 1){
		for(int i = 1; currPage > i; i++){
			totalpage += totalpage+10;
			
		}
		totalpage += 1;
	}else{
		totalpage = 1;
	}
	num = num*totalpage;
	
	String sDate = "";
	String eDate = "";
	
	//아침, 점심, 저녁 구분
	String eatTimeGubun = "";
	
	if(listMap.keySize("fyear") > 0){
		for(int i =0; i < listMap.keySize("fyear"); i++){
			if(cnt % 5 == 0){
				
				if(listMap.getString("gubun", i).equals("1")){
					eatTimeGubun = "아침";
					
				}else if(listMap.getString("gubun", i).equals("2")){
					eatTimeGubun = "점심";
					
				}else{
					eatTimeGubun = "저녁";
					
				}
				
				String vSdate = "";
				String vEdate = "";
				if(listMap.getInt("fdate", (i-4)) < 10){
					vSdate = "0"+listMap.getInt("fdate", (i-4));
				}else{
					vSdate = String.valueOf(listMap.getInt("fdate", (i-4)));
				}
				
				if(listMap.getInt("fdate", i) < 10){
					vEdate = "0"+listMap.getInt("fdate", i);
				}else{
					vEdate = String.valueOf(listMap.getInt("fdate", i));
				}
					
				sDate = listMap.getString("fyear", (i-4))+listMap.getString("fmonth", (i-4))+ vSdate;
				
				eDate = listMap.getString("fyear", i)+listMap.getString("fmonth", i)+ vEdate;
				
				html.append("\n	<tr>");
				html.append("\n	<td>"+(num++)+"</td>");
				html.append("\n	<td><a href=\"javascript:go_modify('"+sDate+"','"+eDate+"', '"+listMap.getString("gubun", i)+"')\">"+listMap.getString("fyear", i)+"년"+listMap.getString("fmonth", i)+"월 "+listMap.getString("cnt", i)+"째주 "+eatTimeGubun+" 식단표</a></td>");
				html.append("\n	<td>"+listMap.getString("fyear", (i-4))+"."+listMap.getString("fmonth", (i-4))+"."+ listMap.getString("fdate", (i-4)) + " ~" );
				html.append("\n"	 +listMap.getString("fyear", i)+"."+listMap.getString("fmonth", i)+"."+ listMap.getString("fdate", i));
				html.append("\n	</td>");			
				html.append("\n	<td class=\"br0\" >");
				html.append("\n	<input type=\"button\" value=\"미리보기\" class=\"boardbtn1\" onclick=\"go_modify('"+sDate+"','"+eDate+"', '"+listMap.getString("gubun", i)+"');\" class=\"boardbtn1\">");
				html.append("\n	</td>");			
				html.append("\n	</tr>");
			}
			cnt++;
		}
		
	}else{
		html.append("\n	<tr>");
		html.append("\n	<td colspan=\"100%\" class=\"br0\" style=\"height:100px;\">등록된 데이터가 없습니다.</td>");
		html.append("\n	</tr>");		
	}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//리스트
function go_list(){
	pform.action = "/homepageMgr/food.do";
	pform.submit();
}

//폼 페이지 이동
function go_form(){
	$("mode").value = "form";
	$("sDate").value = "";
	$("eDate").value = "";
	$("qu").value = "insert";
	pform.action = "/homepageMgr/food.do";
	pform.submit();

}

//수정모드
function go_modify(sDate, eDate, gubun){
	//현재 등록이 되어있는 전체 날짜를 수정모드와함께 던진다.
	$("sDate").value = sDate;
	$("eDate").value = eDate;
	$("gubun").value = gubun;
	$("mode").value = "form";
	$("qu").value = "modify";
	pform.action = "/homepageMgr/food.do";
	pform.submit();
}


//로딩시.
onload = function()	{

}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value="<%=requestMap.getString("currPage")%>">
<input type="hidden" name="qu"		value="">
<input type="hidden" name="sYear"		value="<%=listMap.getString("") %>">
<input type="hidden" name="sDate"		value="">
<input type="hidden" name="eDate"		value="">
<input type="hidden" name="gubun"		value="">

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

			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>식단관리</strong>
					</td>
				</tr>
			</table> 
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"class="contentsTable">
				<tr>
					<td>
						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>기간</th>
								<th class="br0">비고</th>
							</tr>
							</thead>

							<tbody>
							<%=html.toString() %>
							</tbody>
						</table>
						<!-- 테이블하단 버튼   -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="등록" onclick="go_form();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->
						
					</td>
				</tr>
			</table>	

	        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
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