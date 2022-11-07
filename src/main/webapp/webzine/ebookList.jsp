<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : Webzine 관리 E-book
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

	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("ebookNo") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	//컨텐츠
	StringBuffer html = new StringBuffer();
	if(!listMap.getString("ebookNo").equals("")){
		
		for(int i=0; listMap.keySize("ebookNo") > i; i++){
			html.append("\n<tr>");
			html.append("\n	<td class=\"tableline11\">"+(pageNum-i)+"</td>");
			html.append("\n	<td valign=\"middle\" style=\"width:150px;height:150px;align:center\" align=\"center\" class=\"tableline11\"><img style=\"cursor:hand\" width=\"75\" height=\"56\" onclick=\"go_modify('"+listMap.getString("ebookNo", i)+"')\" src=\"/pds"+listMap.getString("imgPath", i)+"\"/></td>");
			html.append("\n	<td class=\"tableline11\" width=\"200\"><a href=\"javascript:go_modify('"+listMap.getString("ebookNo", i)+"')\">"+listMap.getString("ebookTitle",i)+"</a></td>");
			html.append("\n	<td class=\"tableline11\" style=\"padding: 0 10 0 10\">"+listMap.getString("ebookAuth",i)+"</td>");
			html.append("\n	<td class=\"tableline11\" width=\"80\">"+listMap.getString("grseq",i)+"</td>");
			html.append("\n	<td class=\"tableline11\" width=\"80\">"+listMap.getString("ebookPage",i)+"</td>");
			html.append("\n	<td class=\"tableline11 br0\"  width=\"60\">"+(listMap.getString("useYn",i).equals("Y") ? "사용" : "사용안함")+"</td>");
			html.append("\n</tr>");
		
		}
		
	}else{
		html.append("<tr>");
		html.append("	<td colspan=\"100%\" class=\"br0\" style=\"height:100px\" align=\"center\"> 등록된 자료가 없습니다. </td>");
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
	$("mode").value="ebookList";
	pform.action = "/webzine.do";
	pform.submit();
}

//수정모드
function go_modify(ebookNo, imgPath){
	$("imgPath").value = imgPath;
	$("ebookNo").value = ebookNo;
	$("mode").value = "ebookForm";
	$("qu").value = "modifyEbook";
	pform.action = "/webzine.do";
	pform.submit();
	
}
//등록모드
function go_insert(){
	$("mode").value = "ebookForm";
	$("qu").value = "insertEbook";
	pform.action = "/webzine.do";
	pform.submit();

}


function go_search(){
	
	$("mode").value="ebookList";
	$("currPage").value = "";
	pform.action = "/webzine.do";
	pform.submit();
	
}


</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<!-- 이미지 경로 -->
<input type="hidden" name="imgPath">
<!-- ebook 넘버 -->
<input type="hidden" name="ebookNo">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>E-book</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
					<div class="space01"></div>
                    <!-- button[s] -->
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="btn01">
						<tr>
							<td height="28" width="100%" align="right" class="tableline11" align="center" bgcolor=""><input type="button" class="boardbtn1" value="E-Book 추가" style="cursor:hand;" onclick="go_insert();"></td>
						</tr>
					</table>
                    <!-- button[e] -->
                                        					
					<!---[s] content -->
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="datah01">
						<tr bgcolor="#5071B4">
							<td class="white" width="40"><strong>번호</strong></td>
							<td class="white"><strong>E-BOOK IMAGE</strong></td>
							<td class="white" width="200"><strong>제목</strong></td>
							<td class="white"><strong>컨텐츠분류</strong></td>
							<td class="white" width="80"><strong>제작일시</strong></td>
							<td class="white" width="80"><strong> 총페이지수</strong></td>
							<td class="white br0" width="60"><strong>사용여부</strong></td>							
						</tr>
						<tbody>
						<%=html.toString() %>
						</tbody>
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

