<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 입교안내
// date		: 2008-08-07
// auth 	: kang
%>


<%

	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("USER_NOTICE_LIST");
	listMap.setNullToInitialize(true);

	// 페이징 필수
	FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");


	StringBuffer listHtml = new StringBuffer();
	
	String pageStr = "";
	
	if(listMap.keySize("wuserno") > 0){	
		
		for(int i=0; i < listMap.keySize("wuserno"); i++){
			int num = i + 1;	
			listHtml.append("<tr> ");
			
			listHtml.append("<td class=\"bl0\">"+ num +"</td> ");
			
			if((listMap.getString("notiGubun", i)).equals("P")) {
				listHtml.append("<td>개인</td>");
			}else{
				listHtml.append("<td>그룹</td>");
			}			
	
			listHtml.append("<td class=\"sbj\"><a href=\"/mypage/myclass.do?mode=personalnoticeview&seq="+listMap.getString("seq", i)+"&gubun="+listMap.getString("notiGubun", i)+"\">"+ listMap.getString("title", i) +"</a></td> ");
			listHtml.append("<td class=\"\">"+ listMap.getString("regdate", i) +"</td> ");
			listHtml.append("<td>"+ listMap.getString("visit", i) +"</td> ");
			listHtml.append("</tr> ");		
		}
		pageStr = pageNavi.FrontPageStr();		
	}else{
		// 리스트가 없을때
		listHtml.append("<tr><td colspan=\"5\"> 공지사항이 없습니다. </td></tr> ");	
	}
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>


<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	$("mode").value = "personalnotice";
	pform.action = "/mypage/myclass.do";
	pform.submit();
}


//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<!-- 필수 -->
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">

<div id="wrapper">
	<div id="dvwhset">
		<div id="dvwh">
		
			<!--[s] header -->
			<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
				<jsp:param name="topMenu" value="1" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="7" />
					<jsp:param name="leftIndex" value="4" />
					<jsp:param name="leftSubIndex" value="1" />
				</jsp:include>
				<!--[e] left -->
				
				
	<!-- contentOut s ===================== -->
	<div id="subContentArear">
		<!-- content image
		<div id="contImg"><img src="/images/skin1/sub/img_cont00.jpg" alt="" /></div>
		//content image -->

		<!-- title/location -->
		<div id="top_title">
			<h1 id="title"><img src="/images/skin1/title/tit_mypage.gif" alt="마이페이지" /></h1>
			<div id="location">
			<ul> 
				<li class="home"><a href="">HOME</a></li>
				<li>마이페이지</li>
				<li>개인정보</li>
				<li class="on">개인공지</li>
			</ul>
			</div>
		</div>
		<!-- title/location -->
		<div class="spaceTop"></div>

		<!-- content s ===================== -->
		<div id="content">
			<!-- title --> 
			<h2 class="h2L"><img src="/images/skin1/title/tit_info.gif" class="mr8" alt="개인정보" /><img src="/images/skin1/title/tit_notice01.gif" alt="개인공지" /></h2>
			<!-- //title -->
			<div class="h9"></div>

			<!-- data -->
			<table class="bList01">	
			<colgroup>
				<col width="50" />
				<col width="67" />
				<col width="*" />
				<col width="99" />
				<col width="67" />
			</colgroup>

			<thead>
			<tr>
				<th class="bl0"><img src="/images/skin1/table/th_no.gif" alt="번호" /></th>
				<th><img src="/images/skin1/table/th_div01.gif" alt="구분" /></th>
				<th><img src="/images/skin1/table/th_sbj.gif" alt="제목" /></th>
				<th><img src="/images/skin1/table/th_date01.gif" alt="날짜" /></th>
				<th><img src="/images/skin1/table/th_hit.gif" alt="조회" /></th>
			</tr>
			</thead>

			<tbody>
			<%=listHtml %>
			</tbody>
			</table>
			<!-- //data --> 
			<div class="BtmLine"></div>                

			<!--[s] 페이징 -->
			<div class="paging">
			<%= pageStr %>
			</div>
			<!--//[s] 페이징 -->
			<div class="space"></div>
		</div>
		<!-- //content e ===================== -->			

	</div>
	<!-- //contentOut e ===================== -->				
				
				
																								
				<div class="spaceBtt"></div>
			</div>			
		</div>
		
		<div id="divQuickMenu" style="position:absolute; top:10; left:89%; width:90px; height:264px; z-index:1">
			<!--[s] quick -->
			<jsp:include page="/commonInc/include/comQuick.jsp" flush="false"/>
			<!--[e] quick -->
		</div>
	</div>
	<!--[s] footer -->
	<jsp:include page="/commonInc/include/comFoot.jsp" flush="false"/>
	<!--[e] footer -->
</div>

</form>
</body>				