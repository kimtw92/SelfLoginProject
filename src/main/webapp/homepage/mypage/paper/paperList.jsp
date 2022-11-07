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


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);


// 페이징 필수
FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");


StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";
int iNum = 0;
if(listMap.keySize("papNo") > 0){		
	for(int i=0; i < listMap.keySize("papNo"); i++){
		
		// out.println(listMap.getString("papNo")+","+requestMap.getString("viewNo"));
		sbListHtml.append("<tr>\n");
		sbListHtml.append("<td class=\"bl0\"><input type=\"checkbox\" name=\"papNo\" value=\""+listMap.getString("papNo",i)+"\" >");
		if (requestMap.getString("kind").equals("RECIEVE")){
			sbListHtml.append(listMap.getString("sendName",i));
		} else if (requestMap.getString("kind").equals("SEND")){
			sbListHtml.append(listMap.getString("recieveName",i));
		}
		sbListHtml.append("</td>\n");
		sbListHtml.append("<td class=\"sbj\" ><a href=\"javascript:onView('"+listMap.getString("papNo",i)+"')\">"+Util.right(listMap.getString("contents",i),30)+"</a></td>\n");
		sbListHtml.append("<td>");
		if (requestMap.getString("kind").equals("RECIEVE")){
			sbListHtml.append(listMap.getString("recieveDate",i));
		} else if (requestMap.getString("kind").equals("SEND")){
			sbListHtml.append(listMap.getString("sendDate",i));
		}
		sbListHtml.append("</td>\n");
		sbListHtml.append("</tr>\n");
		if (listMap.getString("papNo",i).equals(requestMap.getString("viewNo"))){
			sbListHtml.append("<tr>\n");
			sbListHtml.append("<td class=\"con01\" colspan=\"3\">"+StringReplace.convertHtmlBr(listMap.getString("contents",i))+"</td>\n");
			sbListHtml.append("</tr>\n");
		}
		iNum ++;

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

// 리스트
function fnList(){
	pform.action = "/mypage/paper.do";
	pform.submit();
}

//상세보기
function onView(form){
	$("viewNo").value = form;
	pform.action = "/mypage/paper.do";
	pform.submit();
}

function setForm(form){
	$("mode").value = form;
	$("viewNo").value = "";
	pform.action = "/mypage/paper.do";
	pform.submit();
}

function setDel(){
	var lstNo = document.pform.papNo;
	var chkNum = 0;
<%	if (iNum > 1){%>
	for (var i=0,l=lstNo.length;i<l;i++){
		if (lstNo[i].checked == true){
			chkNum ++;
		}
	}
<%} else {%>
	if (lstNo.checked == true){
		chkNum ++;
	}
<%}%>
	if (chkNum > 0){
		$("mode").value = "delete";
		$("rMode").value = "<%=requestMap.getString("mode")%>";
		pform.action = "/mypage/paper.do";
		pform.submit();
	} else {
		alert("삭제할 항목을 선택해 주세요");
	}
}	
function setDelAll(){
	
	$("mode").value = "delAll";
	$("rMode").value = "<%=requestMap.getString("mode")%>";
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
<input type="hidden" name="rMode"		value="<%= requestMap.getString("rMode") %>">

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
					<jsp:param name="leftSubIndex" value="4" />
				</jsp:include>
				<!--[e] left -->

				<!-- contentOut s ===================== -->
				<div id="subContentArear">
					<!-- content image
					<div id="contImg"><img src="/images/<%= skinDir %>/sub/img_cont00.jpg" alt="" /></div>
					//content image -->
			
					<!-- title/location -->
					<div id="top_title">
						<h1 id="title"><img src="/images/<%= skinDir %>/title/tit_mypage.gif" alt="마이페이지" /></h1>
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
						<h2 class="h2L"><img src="/images/<%= skinDir %>/title/tit_info.gif" class="mr8" alt="개인정보" /><img src="/images/<%= skinDir %>/title/tit_memobox.gif" alt="쪽지함" /></h2>
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
						<table class="bList02"> 
						<colgroup>
						<col width="128" />
						<col width="" />
						<col width="112" />
						</colgroup>
			
						<thead>
<%if(requestMap.getString("mode").equals("recieve")){ %>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_sendp.gif" alt="보낸사람" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_cont.gif" alt="내용" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_date03.gif" alt="받은날짜" /></th>
						</tr>
<%} else { %>
						<tr>
							<th class="bl0"><img src="../../../images/skin1/table/th_sendp.gif" alt="보낸사람" /></th>
							<th><img src="../../../images/skin1/table/th_cont.gif" alt="내용" /></th>
							<th><img src="../../../images/skin1/table/th_date03.gif" alt="받은날짜" /></th>
						</tr>
<%} %>
						</thead>
						<tbody>
						<%=sbListHtml %>
						</tbody>
						</table>
						<!--//data-->
						<div class="BtmLine"></div>
			
						<!-- button -->
						<div class="btnRbtt">
							<a href="javascript:setDel();"><img src="/images/<%= skinDir %>/button/btn_selDelete01.gif" alt="선택삭제" /></a>
							<a href="javascript:setDelAll();"><img src="/images/<%= skinDir %>/button/btn_allDelete01.gif" alt="전체삭제" />
						</div>
						<!-- //button -->
			
						<!--[s] 페이징 -->
						<div class="paging">
							<%=pageStr %>	
						</div>
						<!--//[s] 페이징 -->
						<div class="BtmLine01"></div>
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