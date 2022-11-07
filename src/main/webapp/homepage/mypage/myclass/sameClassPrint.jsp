<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// prgnm 	: 동기모임 상세리스트
// date		: 2008-08-28
// auth 		: jong03
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
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

if(listMap.keySize("grseq") > 0){		
	String eduno = "";		
	for(int i=0; i < listMap.keySize("grseq"); i++){
		eduno = "";
		eduno = "0".equals(listMap.getString("eduno",i)) ? "미부여":listMap.getString("eduno",i);
		sbListHtml.append(" <tr>\n");
		//sbListHtml.append(" 	<td class=\"bl0 cent\" rowspan=\"2\">"+((i+1)+(requestMap.getInt("currPage") -1)*10)+"</td>\n");
		sbListHtml.append(" 	<td class=\"bl0 cent\" rowspan=\"2\">"+ eduno +"</td>\n");
		sbListHtml.append(" 	<td class=\"cent\" rowspan=\"2\"><img src=\"/images/"+ skinDir+"/sub/img_pNone.gif\" alt=\"profile 사진\" /></td>\n");
		sbListHtml.append(" 	<th>이름</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("name",i)+"</td>\n");
		sbListHtml.append(" 	<th>기관</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("deptnm",i)+"</td>\n");
		sbListHtml.append(" 	<th>부서</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("deptsub",i)+"</td>\n");
		sbListHtml.append(" </tr>\n");
		sbListHtml.append(" <tr>\n");
		sbListHtml.append(" 	<th>직급</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("jiknm",i)+"</td>\n");
		sbListHtml.append(" 	<th>Phone</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("telno",i)+"</td>\n");
		sbListHtml.append(" 	<th>E-mail</th>\n");
		sbListHtml.append(" 	<td>"+listMap.getString("email",i)+"</td>\n");
		sbListHtml.append(" </tr>\n");
	}
	
	pageStr = pageNavi.FrontPageStr();
	
}else{
	// 리스트가 없을때
}
%>

<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 검색
function fnList(){
	pform.action = "/mypage/myclass.do?mode=sameClassView";
	pform.submit();
}
//상세보기
function onView(form){
	// $("mode").value = "noticeView";
	$("qu").value = "selectBbsBoardview";
	$("boardId").value = "DATA";
	pform.action = "/homepage/support.do?mode=programView&seq="+form;
	pform.submit();
}
//글쓰기
function goWrite(){
	$("qu").value = "insertBbsBoardForm";
	$("boardId").value = "DATA";
	pform.action = "/homepage/support.do?mode=programList";
	pform.submit();
}

function go_Print(grcode, grseq, currPage){
	var url = "/mypage/myclass.do";
	url += "?mode=sameClassPrint";
	url += "&grcode="+grcode;
	url += "&grseq="+grseq;
	url += "&currPage="+currPage;
	pwinpop = popWin(url,"printPop","500","430","yes","yes");

}
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" name="qu">
<input type="hidden" name="boardId">
			
	<!-- content s ===================== -->
	<div id="content">
		<div class="h9"></div>
		<!-- data -->
		<table class="bList01">	
		<colgroup>
			<col width="50" />
			<col width="*" />
			<col width="44" />
			<col width="121" />
			<col width="44" />
			<col width="121" />
			<col width="44" />
			<col width="121" />
		</colgroup>

		<thead>
		<tr>
			<th class="bl0"><img src="/images/<%= skinDir %>/table/th_scNo.gif" alt="교번" /></th>
			<th><img src="/images/<%= skinDir %>/table/th_photo.gif" alt="사진" /></th>
			<th colspan="6"><img src="/images/<%= skinDir %>/table/th_deAddr.gif" alt="세부주소" /></th>
		</tr>
		</thead>

		<tbody class="detail">
		<%=sbListHtml.toString() %>
		</tbody>
		</table>
		<!-- //data --> 
		<div class="BtmLine"></div>                

	</div>
	<!-- //content e ===================== -->

<script language="JavaScript" type="text/JavaScript">
<!--
print();
//-->
</script>
</form>
</body>	