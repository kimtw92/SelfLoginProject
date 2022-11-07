<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 동영상강의 리스트
// date		: 2009-06-11
// auth 	: hwani
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
//LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");

//navigation 데이터
//DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
//navigationMap.setNullToInitialize(true);

// 상단 navigation
//String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
////////////////////////////////////////////////////////////////////////////////////


//동영상 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);

//분류 리스트
DataMap divListMap = (DataMap)request.getAttribute("DIV_LIST_DATA");
listMap.setNullToInitialize(true);

//상단 네비게이션
String navigationStr = "";
if(!requestMap.getString("divCode").equals(""))
	navigationStr = requestMap.getString("divName");
else 
	navigationStr = divListMap.getString("divName", 4);


//페이지 처리
PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");

StringBuffer divListBuff = new StringBuffer(); //분류 리스트
StringBuffer listStr 	 = new StringBuffer(); //동영상 리스트

//분류 리스트
for(int j=0; j < divListMap.keySize("divCode"); j++) {
	if("88785".equals(divListMap.getString("divCode", j)) || "88786".equals(divListMap.getString("divCode", j)) || "88787".equals(divListMap.getString("divCode", j))) {
		
		continue;
	}
	divListBuff.append("<li><a href=\"javascript:go_listDiv('" + divListMap.getString("divCode", j) + "', '" + divListMap.getString("divName", j) + "')\" title=\"" + divListMap.getString("divName", j) + "\" ><span><font color=\"#FFFFFF\">" + divListMap.getString("divName", j) + "</span></font></a></li>");
	
}
/*
<tr>
<td>
<img src='./images/table/noimg.gif' class='imgtum'>
</td>

listStr.append("<td class=\"sbj\"> \n");
<a href=""><strong>1.한국인이 혼동하기 쉬운 핵심어휘  900</strong></a>
<a href="#"><img src='./images/button/btn_listen.gif' align="absmiddle" alt="강의듣기"></a>
<div class="space_5"></div>
<strong>게시일:20090908</strong> &nbsp; &nbsp; &nbsp;<strong>조회수:477</strong>
<div class="space_5"></div>
<font class="t11px">싸움, 좋은 의미의 싸움은 오히려 긍정적인 결과를 가져오기도 합니다.</font>
</td>
</tr>
*/

//동영상 리스트
for(int i=0; i < listMap.keySize("contCode"); i++) {
	
	String tmpStr = "";
	
	listStr.append("\n<tr>");
	
	// 섬네일 이미지
	if (listMap.getString("filePath",i).length() > 4) {
		listStr.append("\n	<td><img src='"+listMap.getString("filePath",i)+"' width='82' height='57' class='imgtum'></td>");
	} else {
		listStr.append("\n <td><img src='/images/table/noimg.gif' class='imgtum'></td>");
	}
	listStr.append("<td class=\"sbj\"> \n");
	listStr.append("<strong>" + listMap.getString("contName", i) + "</strong> \n");
	listStr.append("<a href=\"javascript:go_view(" + listMap.getString("contCode", i) + ");\"><img src='/images/button/btn_listen.gif' align='absmiddle' alt='강의듣기'></a> \n");
	listStr.append("<div class='space_5'></div> \n");
	listStr.append("<strong>게시일:" + listMap.getString("ldate", i) + "</strong> &nbsp; &nbsp; &nbsp;<strong>조회수:" + listMap.getString("visit", i) + "</strong> \n");
	listStr.append("<div class='space_5'></div> \n");
	listStr.append("<font class='t11px'>"+StringReplace.subStringPoint(listMap.getString("contSummary",i),150)+"</font> \n");
	listStr.append("</td>");
	/*
	//카테고리
	listStr.append("\n	<td>" + listMap.getString("divName", i) + "</td>");
	
	//강좌명
	listStr.append("\n	<td class=\"sbj\">" + listMap.getString("contName", i) + "</td>");

	//학습시간
	tmpStr = listMap.getString("movTime", i) + "분 " + listMap.getString("movMin", i) + "초";
	listStr.append("\n	<td>" + tmpStr + "</td>");
	
	//등록일시
	listStr.append("\n	<td class=\"\">" + listMap.getString("ldate", i) + "</td>");
	
	//조회수
	listStr.append("\n	<td>" + listMap.getString("visit", i) + "</td>");
	
	//강의듣기
	listStr.append("\n	<td><a href=\"javascript:go_view(" + listMap.getString("contCode", i) + ");\"><img src=\"/images/movie/button/btn_listen.gif\" alt=\"강의듣기\" /></a></td>");
	*/
	listStr.append("\n</tr>");
	
} //END === for()


//목록 데이터가 없으면.
if( listMap.keySize("contCode") <= 0){

	listStr.append("<tr bgColor='#FFFFFF'>");
	listStr.append("	<td align='center' class='tableline21' colspan='100%' height='100'>등록된 동영상강의가 없습니다.</td>");
	listStr.append("</tr>");

}

//페이징 String
String pageStr = "";
if(listMap.keySize("contCode") > 0){
	pageStr += pageNavi.showFirst();
	pageStr += pageNavi.showPrev();
	pageStr += pageNavi.showPage();
	pageStr += pageNavi.showNext();
	pageStr += pageNavi.showLast();
}


%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/movie/layout.css" />
<script language="javascript" src="/commonInc/js/commonJs.js"></script>

<!-- [Page Customize] -->
<style type="text/css">
<!--

-->
</style>

<script language="javascript">
<!--

//페이지 이동
function go_page(page) {
	document.pform.currPage.value = page;
	go_list();
}

//리스트
function go_list() {
	var mode = "movList";
	document.pform.action = "/movieMgr/movieUse.do?mode=" + mode;
	document.pform.submit();
}

//분류별 리스트
function go_listDiv(divCode, divName) {
	/* 2011.04.04 추가*/

	if(divCode == "88785" || divCode == "88786" || divCode == "88787") {
		alert("경제 포커스, 자기계발, 교양강좌는 준비중 입니다.");
		return;
	}
	var mode = "movList";
	document.pform.divCode.value = divCode;
	document.pform.divName.value = divName;
	document.pform.action = "/movieMgr/movieUse.do?mode=" + mode;
	document.pform.submit();
}

//검색
function go_search() {
	var mode = "movList";
	document.pform.currPage.value = "1";
	document.pform.action = "/movieMgr/movieUse.do?mode=" + mode;
	document.pform.submit();
}

//강의듣기 팝업
function go_view(contCode) {

	var mode = "movView";
	url = "/movieMgr/movieUse.do?mode=" + mode + "&contCode=" + contCode;

	//popWin(url, "pop_contView", "800", "500", "0", "0");
	window.open(url, 'pop_contView', 'width=800,height=500,left=0,top=0,status=yes');
	//alert("준비중임돠");
}


-->
</script>
<!-- [/Page Customize] -->
</head>

<body>
<form id="pform" name="pform" method="post" style="padding-left:10px">


<!-- 페이징용 -->
<input type="hidden" name="currPage" value="<%= requestMap.getString("currPage")%>" />

<input type="hidden" name="divCode"	value="" />
<input type="hidden" name="divName"	value="" />


<div id="wrapper">
	<!-- dvwhset s  ######################################## -->
	<div id="dvwhset">
		<!-- header s  ######################################## -->
		<div id="header">
			<div class="topLogo"><a href="/"><img src="/images/movie/common/topImg.gif" alt="인천광역시 인재개발원" /></a></div>
			<div class="gTopMenu">
				<ul>
					<%= divListBuff.toString() %>
				</ul>
			</div>
		</div>
		<!-- header e  ######################################## -->

		<!-- dvmiddle s  ######################################## -->
		<div id="middle">
			<h2 class="stit"><%= navigationStr %></h2>
			<span class="alignR">
				<select class="select01" name="s_searchType">
					<option value="cont_name">강좌명</option>
				</select>
				<input type="text" id="s_searchText" name="s_searchText" class="input01" value="<%= requestMap.getString("s_searchText") %>" />
				<a href="javascript:go_search();"> <img src="/images/movie/button/btn_search.gif" alt="검색" class="vm1" /> </a>
			</span>
			
			<div class="space01"></div>

			<!-- data -->
			<table class="bList01">	
			<colgroup>
				<col width="113" />
				<col width="*" />
			</colgroup>

			<tbody>
			<%= listStr %>
			</tbody>
			</table>
			<!-- //data --> 
			<div class="space01"></div>
			
				<!--[s] 페이징 -->
				<div class="paging">
					<%= pageStr %>	
				</div>
				<!--//[s] 페이징 -->
				
		</div>
		<!-- dvmiddle e  ######################################## -->




<!-- footer s ######################################## -->
<div id="footerarea">
	<div id="footerset1">		
		<div id="footerLogo1">		
		<img src="/images/movie/footer/ftLogo1.gif" alt="" />
		<img src="/images/movie/footer/ftLogo2.gif" alt="" />
		</div>
		<div id="footerCpyt">
			<div class="bttMenu">
				<ul>
					<li><a href=""><img src="/images/movie/footer/footMenu01.gif" alt="센터소개" /></a></li>
					<li><a href=""><img src="/images/movie/footer/footMenu02.gif" alt="이용약관" /></a></li>
					<li><a href=""><img src="/images/movie/footer/footMenu03.gif" alt="개인정보보호정책" /></a></li>
					<li class="end"><a href=""><img src="/images/movie/footer/footMenu04.gif" alt="이메일 무단수집거부" /></a></li>
				</ul>
			</div>			
			<div class="bttTxt">
				<p class="txt">
					<span>22711 인천광역시 서구 심곡로98 / 시설안내 032)440-7632 / 교육안내 032)440-7655</span>
					<a href="mailto:lotiincheon@korea.kr;"><img src="/images/movie/common/footMail.gif" alt="Mail to Webmaster" /></a>
				</p>
				<p class="txt">홈페이지에 게시된 <span class="txt_gr">이메일주소가 자동 수집되는 것을 거부</span>하며, 위반시 정보통신 관련법령에 의해 처벌됩니다.</p>
				<p class="txt">Copyright@2007 <strong class="txt_blue">인천광역시인재개발원</strong>, All rights Reserved. 이 사이트의 콘텐츠를 무단 사용할 수 없습니다.</p>
			</div>
		</div>
	</div>
</div>
<!-- footer e ######################################## -->

	</div>
	<!-- dvwhset e  ######################################## -->

</div>
</form>
</body>
</html>