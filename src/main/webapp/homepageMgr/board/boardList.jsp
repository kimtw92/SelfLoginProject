<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 게시판 관리 리스트
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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize() > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	
	StringBuffer html = new StringBuffer();
	if(listMap.keySize("boardId") > 0){
		for(int i=0;listMap.keySize("boardId") > i; i++){
			html.append("<tr bgcolor=\"#FFFFFF\" align='center'>");
			
			html.append("<td class=\"tableline11\"><a href=\"javascript:go_bbsList('bbsBoardList','"+listMap.getString("boardId",i)+"','"+listMap.getString("boardName",i)+"');\">"+(listMap.getString("boardId",i).equals("") ? "&nbsp;" : listMap.getString("boardId",i))+"</a></td>");
			html.append("<td class=\"tableline11\"><a href=\"javascript:go_bbsList('bbsBoardList','"+listMap.getString("boardId",i)+"','"+listMap.getString("boardName",i)+"');\">"+(listMap.getString("boardName",i).equals("") ? "&nbsp;" : listMap.getString("boardName",i)) +"</a></td>");
			//html.append("<td class=\"tableline11\">"+listMap.getString("name",i)+"</td>");
			html.append("<td class=\"tableline11\">http://"+request.getServerName() + ":" + request.getServerPort()+"/homepageMgr/board/bbs.do?mode=bbsBoardList&boardId="+(listMap.getString("boardId",i).equals("") ? "&nbsp;" : listMap.getString("boardId",i))+"&boardName="+listMap.getString("boardName",i)+"&menuId="+requestMap.getString("menuId")+"</td>");
// 			html.append("<td class=\"tableline11\">"+Constants.URL+"/homepageMgr/board.do?qu=bbsList&boardId="+(listMap.getString("boardId",i).equals("") ? "&nbsp;" : listMap.getString("boardId",i))+"</td>");
			html.append("<td class=\"tableline11\">"+(listMap.getString("useYn",i).equals("Y") ? "예" : "아니오")+"</td>");
			html.append("<td class=\"tableline11\">"+(listMap.getString("menuid",i).equals("") ? "&nbsp;" : listMap.getString("menuid",i))+"</td>");
			html.append("<td class=\"tableline21\"><input typt=\"button\" size=\"10\" class=\"boardbtn1\" value=\"수정\" onClick=\"go_form('modifyBoard','"+listMap.getString("boardId",i)+"')\"></td>");
			
			html.append("</tr>");
		}
	}else{
		html.append("<tr>등록된 게시판이 없습니다.</td>");
		html.append("	<td height=\"300\" bgcolor=\"#FFFFFF\" colspan=\"100%\">등록된 게시판이 없습니다.</td>");
		html.append("</tr>");
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
//게시판 생성, 수정
function go_form(qu, boardId){
	$("mode").value="form";
	$("qu").value=qu;
	$("boardId").value=boardId;
	pform.action = "/homepageMgr/board.do";
	pform.submit();
	
}

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//게시판 이동
function go_bbsList(mode,boardId,boardName){
	$("mode").value = mode;
	$("boardId").value = boardId;
	$("boardName").value = boardName;
	$("currPage").value = "";
	pform.action = "/homepageMgr/board/bbs.do";
	pform.submit();	
}

//리스트
function go_list(){
	$("mode").value = "";
	$("qu").value = "";
	pform.action = "/homepageMgr/board.do";
	pform.submit();
}

</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>

<!-- 수정 삭제시 기본 키값으로 게시판 아이디를 가지고 간다. -->
<input type="hidden" name="boardId">

<!-- 사용자 게시판으로 이동할때 사용된다. -->
<input type="hidden" name="boardName">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>게시판 관리 리스트</strong>
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
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align='right' colspan="100%">
							<input type="button" name="insert" value="게시판생성" class="boardbtn1" onClick="go_form('insertBoard');">
						</td>
					</tr>
					<tr>
						<td height="2" colspan="100%" bgcolor="#375694"></td>
					</tr>
					<tr bgcolor="#5071B4">
						<td height="28" class="tableline11 white" width="60"><div align="center"><strong>게시판ID</strong></div></td>
						<td class="tableline11 white" width="60"><div align="center"><strong>게시판명</strong></div></td>
						<!-- td class="tableline11 white" width="50"><div align="center"><strong>생성자</strong></div></td -->
						<td class="tableline11 white" width=""><div align="center"><strong>URL</strong></div></td>
						<td class="tableline11 white" width="60"><div align="center"><strong>사용여부</strong></div></td>
						<td class="tableline11 white" width=""><div align="center"><strong>메뉴ID</strong></div></td>
						<td class="tableline21 white" width=""><div align="center"><strong>비고</strong></div></td>
					</tr>
						<%=html.toString() %>
					<tr>
						<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
					</tr>
				</table>
                    
				<!---[e] content -->
				<!---[s] content --><table width="100%" height="10"><tr><td></td></tr></table>
				<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
					<tr>
						<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
					</tr>
				</table>
				<table><tr><td height="50">&nbsp;</td></tr></table>
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






