<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : Webzine 관리 사진리스트
// date : 2008-07-02
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
	
	//신규동지년도 데이터
	DataMap yearListMap = (DataMap)request.getAttribute("YEARLIST_DATA");
	yearListMap.setNullToInitialize(true);	

	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("photoNo") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	//컨텐츠
	StringBuffer html = new StringBuffer();
	if(!listMap.getString("photoNo").equals("")){
		//마지막 4번째의 TD박스 클래스가 tableline21이기때문에 체크해주기 위해서 사용한다.
		int tempCount = 1;
		//CSS클래스 임시 저장
		String cssClass = "";
		int tempIcount =0;
		html.append("\n	<tr>");
		if(listMap.keySize("photoNo") > 4){
			for(int i=0; listMap.keySize("photoNo") > i; i++){
				
				//4번째 td박스클래스 변경
				if(tempCount % 4 == 0){
					cssClass = "br0";
				}else{
					cssClass = "";
				}
				
				
				//i의 0번째 값을 나눌수가 없으므로 임시로 값을 가진다.
				if(i == 0){
					tempIcount = 1;
				}else{
					tempIcount = i+1;
				}

				//리스트 시작
				if(tempIcount % 5 != 0){
					html.append("\n	<td valign=\"middle\" style=\"width:200px;height:150px;align:center\" align=\"center\" class=\""+cssClass+"\"><img style=\"cursor:hand\" width=\"150\" height=\"112\" onclick=\"go_view('"+listMap.getString("photoNo", i)+"')\" src=\"/pds"+listMap.getString("imgPath", i)+"\"/><br> <a href=\"javascript:go_pop('"+ listMap.getString("imgPath", i) +"', '"+ listMap.getString("photoNo", i) +"')\">"+listMap.getString("wcomments", i)+"</a></td>");
					
				}else{
					html.append("\n	</tr>");
					html.append("\n	<tr valign=\"middle\">");
					html.append("\n		<td style=\"padding-left:10px;width:200px;height:150px;align:center\" align=\"center\" class=\"\"><img style=\"cursor:hand\" width=\"150\" height=\"112\" onclick=\"go_view('"+listMap.getString("photoNo", i)+"')\" src=\"/pds"+listMap.getString("imgPath", i)+"\"/><br><a href=\"javascript:go_pop('"+ listMap.getString("imgPath", i) +"', '"+ listMap.getString("photoNo", i) +"')\">"+listMap.getString("wcomments", i)+"</a></td>");
					
				}
				
				tempCount++;
			}
		}else{
			for(int i=0; 4 > i; i++){
	
				//4번째 td박스클래스 변경
				if(tempCount % 3 == 0){
					cssClass = "br0";
				}
				
				
				//i의 0번째 값을 나눌수가 없으므로 임시로 값을 가진다.
				if(i == 0){
					tempIcount = 1;
				}else{
					tempIcount = i+1;
				}
				
				//리스트 시작
				if(tempIcount % 5 != 0){
				
					if(!listMap.getString("photoNo", i).equals("")){
						html.append("\n	<td style=\"width:200px;height:150px;align:center;text-align:center;\" align=\"center\" class=\""+cssClass+"\"><img style=\"cursor:hand\" width=\"150\" height=\"112\" onclick=\"go_view('"+listMap.getString("photoNo", i)+"')\" src=\"/pds"+listMap.getString("imgPath", i)+"\"/><br><a href=\"javascript:go_pop('"+ listMap.getString("imgPath", i) +"', '"+ listMap.getString("photoNo", i) +"')\">"+listMap.getString("wcomments", i)+"</a></td>");

					}else{
						
						html.append("\n	<td style=\"width:200px;height:150px;align:center;text-align:center;\" align=\"center\" class=\"br0\"></td>");
					}
					
				}else{
					html.append("\n	</tr>");
					html.append("\n	<tr valign=\"middle\">");
					html.append("\n		<td style=\"padding-left:10px;width:150px;height:150px;align:center\" align=\"center\" class=\""+cssClass+"\"><img style=\"cursor:hand\" width=\"150\" height=\"112\" onclick=\"go_view('"+listMap.getString("photoNo", i)+"')\" src=\"/pds"+listMap.getString("imgPath", i)+"\"/><br><a href=\"javascript:go_pop('"+ listMap.getString("imgPath", i) +"', '"+ listMap.getString("photoNo", i) +"')\">"+listMap.getString("wcomments", i)+"</a></td>");
				
				}
				tempCount++;
			}
		}
		html.append("\n	</tr>");
		//tr박스를 닫아주기위해서 한번더 체크!
		if(listMap.keySize("photoNo") >= 4){
			html.append("\n	</tr>");
		}
		
	}else{
		html.append("<tr>");
		html.append("	<td colspan=\"100%\" style=\"height:100px\" class=\"br0\" align=\"center\"> 등록된 사진이 없습니다 . </td>");
		html.append("</tr>");
		
	}
	
	//신규동지년도 셀렉박스
	StringBuffer option = new StringBuffer();
	
	if(yearListMap.keySize("year") > 0){
		for(int i=0; yearListMap.keySize("year") > i; i++){
			option.append("<option value=\""+yearListMap.getString("year",i)+"\">"+yearListMap.getString("year",i)+"</option>");
		}
	}
	
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//리스트
function go_list(){
	$("mode").value="complateList";
	pform.action = "/webzine.do";
	pform.submit();
}

function go_pop(imgPath, photoNo){

	$("imgPath").value = imgPath;
	$("mode").value = "complatePreView";
	$("photoNo").value = photoNo;
	$("qu").value ="preView";	
	pform.action = "/webzine.do";
	var popWindow = popWin('about:blank', 'majorPop11', '600', '600', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}


//수정모드
function go_view(photoNo, imgPath){
	$("imgPath").value = imgPath;
	$("mode").value = "complateForm";
	$("qu").value = "modifyComplate";
	$("photoNo").value = photoNo;
	pform.action = "/webzine.do";
	var popWindow = popWin('about:blank', 'majorPop11', '600', '600', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
	
}
//등록모드
function go_form(){
	$("mode").value = "complateForm";
	$("qu").value = "insertComplate";
	pform.action = "/webzine.do";
	var popWindow = popWin('about:blank', 'majorPop11', '600', '600', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";

}


function go_search(){
	
	$("mode").value="complateList";
	$("currPage").value = "";
	pform.action = "/webzine.do";
	pform.submit();
	
}


</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="imgPath">
<!-- 사진번호 -->
<input type="hidden" name="photoNo"				value="">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap="nowrap"><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap="nowrap"><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>포토갤러리 리스트</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                    
                    <!-- search[s] -->
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="search01">
						<tr>
							<td height="28" width="100" class="tableline11" align="center" bgcolor="#F7F7F7"><strong>조회 년도</strong></td>
							<td width="100"  class="tableline21" align="center"><select onchange="go_search();" name="date"><option value="">** 선택 **</option><%=option.toString() %> </select></td>
							<td class="btn0">&nbsp;</td>
							
						</tr>
					</table>
                    <!-- search[e] -->
                    
					<div class="space01"></div>
                    <!-- button[s] -->
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="btn01">
						<tr>
							<td height="28" width="100%" align="right" class="tableline11" align="center" bgcolor=""><input type="button" class="boardbtn1" value="사진추가" style="cursor:hand;" onclick="go_form();"></td>
						</tr>
					</table>
                    <!-- button[e] -->                    					
					<!---[s] content -->
					<!--//검색 -->

					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="datah01">
						<%=html.toString() %>
                    </table>
                    
                     <!---[e] content -->
					<div class="h5"></div>
					<br>
                   	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                   		<tr>
                   			<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                   		</tr>
                   	</table>
                   <!-- sapce[s] --><table height="50"><tr><td></td></tr></table>
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
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
	var date = "<%=requestMap.getString("date")%>";
	len = $("date").options.length
	
	for(var i=0; i < len; i++) {
		if($("date").options[i].value == date){
			$("date").selectedIndex = i;
		 }
 	 }
</script>