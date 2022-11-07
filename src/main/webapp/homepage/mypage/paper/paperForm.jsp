<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 쪽지보내기
// date		: 2008-09-30
// auth 	: jong03
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

%>

<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	pform.currPage.value = page;
	fnList();
}

// 리스트
function fnList(){
	pform.action = "/mypage/paper.do";
	pform.submit();
}

//상세보기
function onView(form){
	pform.viewNo.value = form;
	pform.action = "/mypage/paper.do";
	pform.submit();
}
function onSubmit(){
	pform.mode.value = "exec";
	pform.rMode.value = "<%=requestMap.getString("mode")%>";
	pform.action = "/mypage/paper.do";
	pform.submit();
}
function onPop(){
	var url = "/mypage/paper.do";
	url += "?mode=memberList";
	pwinpop = popWin(url,"memSearch","400","250","yes","yes");
}
function setForm(form){
	pform.mode.value = form;
	pform.rMode.value = "<%=requestMap.getString("mode")%>";
	pform.action = "/mypage/paper.do";
	pform.submit();
}
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pforam" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="kind"		value="<%= requestMap.getString("kind") %>">
<input type="hidden" name="viewNo"		value="<%= requestMap.getString("viewNo") %>">

<!-- 페이징용 -->
<input type="hidden" name="rMode"	value="<%= requestMap.getString("rMode")%>">

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
					<jsp:param name="leftSubIndex" value="4" />
				</jsp:include>
				<!--[e] left -->

				<!-- contentOut s ===================== -->
				<div id="subContentArear">
					<!-- content image
					<div id="contImg"><img src="../../../images/skin1/sub/img_cont00.jpg" alt="" /></div>
					//content image -->
			
					<!-- title/location -->
					<div id="top_title">
						<h1 id="title"><img src="../../../images/skin1/title/tit_mypage.gif" alt="마이페이지" /></h1>
						<div id="location">
						<ul> 
							<li class="home"><a href="">HOME</a></li>
							<li>마이페이지</li>
							<li>개인정보</li>
							<li class="on">쪽지함</li>
						</ul>
						</div>
					</div>
					<!-- title/location -->
					<div class="spaceTop"></div>
			
					<!-- content s ===================== -->
					<div id="content">
						<!-- title --> 
						<h2 class="h2L"><img src="../../../images/skin1/title/tit_info.gif" class="mr8" alt="개인정보" /><img src="../../../images/skin1/title/tit_memobox.gif" alt="쪽지함" /></h2>
						<!-- //title -->
						<div class="h15"></div>
			
						<div class="tabs01">
							<ul>
								<li><a href="javascript:setForm('recieve');"><img src="/images/<%= skinDir %>/common/tab_memo01<%if(requestMap.getString("mode").equals("recieve")){out.print("_on");} %>.gif" alt="받은쪽지함" /></a></li>
								<li><a href="javascript:setForm('send');"><img src="/images/<%= skinDir %>/common/tab_memo02<%if(requestMap.getString("mode").equals("send")){out.print("_on");} %>.gif" alt="보낸쪽지함" /></a></li>
								<li><a href="javascript:setForm('form');"><img src="/images/<%= skinDir %>/common/tab_memo03<%if(requestMap.getString("mode").equals("form")){out.print("_on");} %>.gif" alt="쪽지쓰기" /></a></li>
							</ul>
						</div>
			
						<!--data-->
						<table class="bWrite01"> 
						<colgroup>
						<col width="128" />
						<col width="" />
						</colgroup>
			
						<tbody>
						<input type="hidden" name="recieveNo">
						<tr>
							<th><img src="../../../images/skin1/table/th_recvPe01.gif" alt="받는사람" /></th>
							<td><input type="text" name="recieveName" class="input01 mb" style="width:363px;" readonly /> <a href="javascript:onPop();"><img src="../../../images/skin1/button/btn_find01.gif" class="vm3" alt="사람찾기" /></a></td>
						</tr>
						<tr>
							<th><img src="../../../images/skin1/table/th_cont01.gif" alt="내용(30자)" /></th>
							<td><textarea class="textarea01" style="width:460px;height:176px;" name="reContent"></textarea></td>
						</tr>
						</tbody>
						</table>
						<!--//data-->
			
						<!-- button -->
						<div class="btnRbtt">
							<a href="javascript:onSubmit();"><img src="../../../images/skin1/button/btn_submit02.gif" alt="확인" /></a>
							<a href="javascript:history.go(-1);"><img src="../../../images/skin1/button/btn_cancel01.gif" alt="취소" /></a>
						</div>
						<!-- //button -->
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