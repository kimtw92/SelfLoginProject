<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사용자 게시판 리스트
// date : 2008-06-05
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
	
	//게시판 권한 설정
	DataMap managerBoardRowMap = (DataMap)request.getAttribute("MANAGER_BOARDROW_DATA");
	managerBoardRowMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("seq") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	//현재 게시판권한과 맞는게 잇는지 체크
      int read = 0;
      int write = 0;
      int download = 0;
      //읽기권한체
      for(int i=0; i < managerBoardRowMap.keySize("boardGrade"); i++){
      	if(managerBoardRowMap.getString("boardGrade",i).equals(memberInfo.getSessCurrentAuth())&& managerBoardRowMap.getString("boardRead",i).equals("Y")){
      		read=1;
      	}
      }
      //쓰기권한체크
      for(int i=0; i < managerBoardRowMap.keySize("boardGrade"); i++){
      	if(managerBoardRowMap.getString("boardGrade",i).equals(memberInfo.getSessCurrentAuth())&& managerBoardRowMap.getString("boardWrite",i).equals("Y")){
      		write=1;
      	}
      }
      //다운로드권한체크
      for(int i=0; i < managerBoardRowMap.keySize("boardGrade"); i++){
        	if(managerBoardRowMap.getString("boardGrade",i).equals(memberInfo.getSessCurrentAuth())&& managerBoardRowMap.getString("boardDownload",i).equals("Y")){
        		download=1;
        	}
        }

      StringBuffer html = new StringBuffer();
	if(listMap.keySize("seq") > 0){
		for(int i=0;listMap.keySize("seq") > i; i++){
			int j = 0;
			html.append("<tr bgcolor=\"#FFFFFF\" align='center'>");
			html.append("<td class=\"tableline11\" height=\"30\">"+(pageNum - i)+"</a></td>");
			html.append("<td class=\"tableline11\" align=\"left\" style=\"padding-left:10px\">");
            if(j < listMap.getInt("depth",i)*2){ 

            	int temp = listMap.getInt("depth",i)*2;
              	for(j=0; j < temp; j++){ 
              		html.append("&nbsp");
              	}
              	html.append("☞");
            }

        	if(read == 1){
				html.append("<a href =\"javascript:go_view('bbsBoardView','"+listMap.getString("seq",i)+"');\"> "+listMap.getString("title",i)+"</a>"+"</td>");
        	}else{
        		html.append(listMap.getString("title",i) +"</td>");
        	}
			
        	if(download == 1){
			html.append("<td class=\"tableline11\">"+(!listMap.getString("groupfileNo",i).equals("-1") ? 
						"<a href='javascript:fileDownloadPopup("+listMap.getString("groupfileNo", i)+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : 
						"&nbsp;" ) +"</td>");
			
        	}else{
    			html.append("<td class=\"tableline11\">"+(!listMap.getString("groupfileNo",i).equals("-1") ? 
						"<img src=/images/compressed.gif border=0 valign='middle'>" : 
						"&nbsp;" ) +"</td>");
    			
        	}
			html.append("<td class=\"tableline11\">"+listMap.getString("regdate",i)+"</td>");
			html.append("<td class=\"tableline11\">"+listMap.getString("username",i)+"</td>");
			html.append("<td class=\"tableline21\">"+listMap.getString("visit",i)+"</td>");
			
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("	<td height=\"300\" bgcolor=\"#FFFFFF\" align=\"center\" colspan=\"100%\"><strong>등록된 글이 없습니다.</strong></td>");
		html.append("</tr>");
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
	$("mode").value = "bbsBoardList";
	pform.action = "/homepageMgr/board/bbs.do";
	pform.submit();
}
//등록폼 이동
function go_form(){
	$("mode").value = "bbsBoardForm";
	$("qu").value = "insertBbsBoardForm";
	pform.action = "/homepageMgr/board/bbs.do";
	pform.submit();
	
}

//뷰페이지 이동
function go_view(mode,seq){
	$("mode").value=mode;
	$("qu").value="selectBbsBoardview";
	$("seq").value=seq;
	pform.action = "/homepageMgr/board/bbs.do";
	pform.submit();
}

//검색
function go_search(){
	if(IsValidCharSearch($("selectText").value) == false){
		return false;
	}
	$("currPage").value = "";
	pform.action = "/homepageMgr/board/bbs.do";
	pform.submit();
}

</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode" value="bbsBoardList">
<input type="hidden" name="qu" value="">

<input type="hidden" name="boardId" value="<%=requestMap.getString("boardId")%>">
<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<!-- 상세페이지 기본키 사용  -->
<input type="hidden" name="seq" value="">
<input type="hidden" name="boardName" value="<%=requestMap.getString("boardName") %>">
<input type="hidden" name="sessClass" value="<%=memberInfo.getSessCurrentAuth()  %>">
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong><%=requestMap.getString("boardName") %> 게시판</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
										
										
										
										
                    <!---[s] content -->

					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
					<!-- 검색 -->
					<table  width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="2" colspan="100%" bgcolor="#5071B4"></td>
						</tr>					
						<tr>
							<td bgcolor="#F5F5F5" class="tableline11" align="center"><strong>검색 구분 :</strong></td>
							<td height="28" class="tableline11" width="150" align="center">
								<select name="selectType" style="width:100px;">
				                    <option value='all'>선택</option>
				                    <option value='title'>제목</option>
				                    <option value='content'>내용</option>
				                    <option value='username'>작성자</option>
				                  </select>
				            </td>	
				            <td bgcolor="#F5F5F5" class="tableline11" align="center"><strong>검색어 : </strong></td>
				            <td class="tableline11" align="left" style="padding-left:10px" width="300"><input class="textfield" size="30" type="text" name="selectText" onkeypress="if(event.keyCode==13){go_search();return false;}" maxlength="20" value="<%=requestMap.getString("selectText") %>"></td>
				            <td class="tableline21" align="center">
							<input type="button" class="boardbtn1" value="검 색" onclick="go_search();">&nbsp;
							<%if( write == 1 ){ %>
								<input type="button" class="boardbtn1" value="글쓰기" onclick="go_form();">
							<%} %>
							</td>
						</tr>
						<tr>
							<td height="2" colspan="100%" bgcolor="#5071B4"></td>
						</tr>
						<tr>
							<td height="25"></td>
						</tr>
					</table>
						
					<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="E5E5E5">
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						</tr>
						<tr bgcolor="#5071B4">
						  <td height="28" class="tableline11 white"><div align="center"><strong>No</strong></div></td>
						  <td class="tableline11 white"><div align="center"><strong>제목</strong></div></td>
						  <td class="tableline11 white"><div align="center"><strong>첨부</strong></div></td>
						  <td class="tableline11 white"><div align="center"><strong>게시일자</strong></div></td>
						  <td class="tableline11 white"><div align="center"><strong>작성자</strong></div></td>
						  <td class="tableline21 white"><div align="center"><strong>조회</strong></div></td>
						</tr>
						<%=html.toString() %>
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
						</tr>
                    </table>
                    
                     <!---[e] content -->
                     <!---[s] content --><table width="100%" height="20"><tr><td></td></tr></table>
                   	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                   		<!-- space -->
                   		<tr>
                   			<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                   		</tr>
                   	</table>
					<!-- space --><table width="100%" height="50"><tr><td></td></tr></table>                        
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
	var selectType = "<%=requestMap.getString("selectType")%>";
	len = $("selectType").options.length
	
	for(var i=0; i < len; i++) {
		if($("selectType").options[i].value == selectType){
			$("selectType").selectedIndex = i;
		 }
 	 }
</script>


