<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 입교안내
// date		: 2008-08-07
// auth 	: kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%


// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);


// 페이징 필수
FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");


StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";

if(listMap.keySize("seq") > 0){		
	for(int i=0; i < listMap.keySize("seq"); i++){
		
		sbListHtml.append("<tr>");
		sbListHtml.append("	<td class=\"bl0\">"+listMap.getString("seq",i)+"</td>");
		int l = Util.getIntValue(listMap.getString("depth",i),0);
		
		sbListHtml.append("	<td class=\"sbj\">");
		
		for (int z=0;z < l ; z ++){
			sbListHtml.append("&nbsp;&nbsp;");
		}
		if ( l > 0){
			sbListHtml.append("<img src=\"/images/"+ skinDir +"/icon/icon_re.gif\">");
		}
		sbListHtml.append(" <a href=\"javascript:onView('"+listMap.getString("seq",i)+"');\">"+StringReplace.subStringPoint(listMap.getString("title",i),23)+"</a></td>");		
		sbListHtml.append("	<td>"+listMap.getString("regdate",i)+"</td>");
		sbListHtml.append("	<td>"+listMap.getString("username",i)+"</td>");				
		sbListHtml.append("	<td>"+listMap.getString("visit",i)+"</td>");
		sbListHtml.append("	<td>");
		if (Util.getIntValue(listMap.getString("groupfileNo",i), 0) > 0){
			sbListHtml.append("<a href=\"javascript:fileDownloadPopup("+listMap.getString("groupfileNo",i)+");\"><img src=\"/images/"+ skinDir+"/icon/icon_fileDwn.gif\" alt=\"한글file 첨부\" /></a>");
		}
		sbListHtml.append(" </td>");
		sbListHtml.append("</tr>");

	}
	
	pageStr = pageNavi.FrontPageStr();				
}else{
	// 리스트가 없을때
	sbListHtml.append("	<tr>");
	sbListHtml.append("		<td class=\"bl0\" colspan=\"6\" >게시물이 없습니다.</td>");
	sbListHtml.append("	</tr>");
	
}
%>

<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	pform.action = "/homepage/support.do?mode=readList";
	pform.submit();
}
// 검색
function goSearch(){
	$("currPage").value = "1";
	$("mode").value = "readList";
	pform.action = "/homepage/support.do";
	pform.submit();
}
//상세보기
function onView(form){
	// $("mode").value = "noticeView";
	$("qu").value = "selectBbsBoardview";
	$("boardId").value = "READING";
	pform.action = "/homepage/support.do?mode=readView&seq="+form;
	pform.submit();
}
//글쓰기
function goWrite(){
	$("qu").value = "insertBbsBoardForm";
	$("boardId").value = "READING";
	pform.action = "/homepage/support.do?mode=readWrite";
	pform.submit();
}
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" name="qu">
<input type="hidden" name="boardId">

<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">

<div id="wrapper">
	<div id="dvwhset">
		<div id="dvwh">
		
			<!--[s] header -->
			<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
				<jsp:param name="topMenu" value="5" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="4" />
					<jsp:param name="leftIndex" value="1" />
					<jsp:param name="leftSubIndex" value="5" />
				</jsp:include>
				<!--[e] left -->

				<!-- contentOut s ===================== -->
				<div id="subContentArear">
					<!-- content image -->
					<div id="contImg"><img src="/images/<%= skinDir %>/sub/img_cont03.gif" alt="학습지원" /></div>
					<!-- //content image -->
			
					<!-- title/location -->
					<div id="top_title">
						<h1 id="title"><img src="/images/<%= skinDir %>/title/tit_0301.gif" alt="열린광장" /></h1>
						<div id="location">
						<ul> 
							<li class="home"><a href="">HOME</a></li>
							<li>열린광장</li>
							<li class="on">독서감상문</li>
						</ul>
						</div>
					</div>
					<!-- title/location -->
					<div class="spaceTop"></div>
			
					<!-- content s ===================== -->
					<div id="content">
						<!-- title --> 
						<h2 class="h2L" style="height:30px">독서감상문</h2>
						<!--div class="txtR">(<span class="txt_org">*</span> 필수입력사항)</div-->
						<!-- //title -->
						<div class="h9"></div>
						
						<div class="qnaTxtSet03">
							<ul class="qnaTxt">
								<li>
								이곳은 인천광역시인재개발원 독서감상문 게시판입니다. 
								</li>
								<li>
								본 게시판은 교육과정중 독서휴가제를 통해 작성하신 독서감상문을 게재하는<br />
								 게시판 입니다.  많은 이용 부탁 드립니다.
								</li>
							</ul>
						</div>
						
						<!--div class="txtR">(<span class="txt_org">*</span> 필수입력사항)</div-->
						<!-- //title -->
						<!-- <div class="h9"></div>  -->
			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="83" />
							<col width="77" />
							<col width="59" />
							<col width="71" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_no.gif" alt="번호" /></th>				
							<th><img src="/images/<%= skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_date.gif" alt="작성일" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_wName01.gif" alt="작성자" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_hit.gif" alt="조회" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_addfile.gif" alt="첨부" /></th>
						</tr>
						</thead>
							<%= sbListHtml.toString() %>
						<tbody>
						
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>  
						
						<!-- button -->
						<div class="btnRbtt">			
							<a href="javascript:goWrite();"><img src="/images/<%= skinDir %>/button/btn_write01.gif" alt="글쓰기" /></a>
						</div>
			
						<!--[s] 페이징 -->
						<div class="paging">
							<%= pageStr %>		
						</div>
						<!--//[s] 페이징 -->
						<div class="h80"></div>
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