<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 안내문 리스트
// date : 2008-09-18
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

    //과정 안내문
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true); 


%>

						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--

//리스트
function go_list(){

	$("mode").value = "guide_list";

	pform.action = "/poll/coursePoll.do";
	pform.submit();

}


//추가
function go_add(){

	var contents = getContents(); // naver 에디터에서 컨텐츠를 가지고 온다.
	
	if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
		alert("내용을 입력하세요");
		return;
	}
	//alert("1");
	if(confirm("등록 하시겠습니까?")){

		$("guideText").value = contents;

		$("mode").value = "guide_exec";
		$("qu").value = "insert";

		pform.action = "/poll/coursePoll.do?mode=guide_exec";
		pform.submit();

	}

}

//수정
function go_modify(){

	var contents = getContents(); // naver 에디터에서 컨텐츠를 가지고 온다.
	
	if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
		alert("내용을 입력하세요");
		return;
	}

	if(confirm("수정 하시겠습니까?")){

		$("guideText").value = contents;

		$("mode").value = "guide_exec";
		$("qu").value = "update";
		pform.action = "/poll/coursePoll.do?mode=guide_exec";
		pform.submit();

	}

}

//삭제
function go_delete(){

	if(confirm("삭제 하시겠습니까?")){

		$("mode").value = "guide_exec";
		$("qu").value = "delete";
		pform.action = "/poll/coursePoll.do?mode=guide_exec";
		pform.submit();

	}
}

onload = function()	{

}

//-->
</script>
<script language="javascript" src="/courseMgr/mail/sms.js"></script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" name="grseq"				value='<%=requestMap.getString("grseq")%>'>

<input type="hidden" name="searchKey"			value='<%=requestMap.getString("searchKey")%>'>
<input type="hidden" name="searchValue"			value='<%=requestMap.getString("searchValue")%>'>
<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">

<input type="hidden" name="guideNo"				value='<%= requestMap.getString("guideNo") %>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 안내문 <%= requestMap.getString("qu").equals("insert") ? "등록" : "수정" %></h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<!-- subTitle --> 
			<h2 class="h2"><img src="../images/bullet003.gif"> 안내문 <%= requestMap.getString("qu").equals("insert") ? "등록" : "수정" %>하기</h2>
			<!-- // subTitle -->
			<div class="h5"></div>

			<!-- 리스트  -->
			<table  class="dataw01">
				<tr>
					<th width="80">제목</th>
					<td>
						<input type="text" class="textfield" name="guideGrinqTitle" value="<%= rowMap.getString("guideGrinqTitle") %>" style="width:80%" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<!-- Namo Web Editor용 Contents -->
						<input type="hidden" name="guideText" id="guideText" value="<%= StringReplace.convertHtmlEncodeNamo2(rowMap.getString("guideText")) %>">
						<jsp:include page="/se2/SE2.jsp" flush="true" >
							<jsp:param name="contents" value="<%= StringReplace.convertHtmlEncodeNamo2(rowMap.getString("guideText")) %>"/>
						</jsp:include>
					</td>
				</tr>
			</table>
			<!-- //리스트  -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
					<% if( requestMap.getString("qu").equals("insert") ){ %>
						<input type="button" value="입력" onclick="go_add();" class="boardbtn1" />
					<% }else if( requestMap.getString("qu").equals("update") ){ %>
						<input type="button" value="수정" onclick="go_modify();" class="boardbtn1" />
						<input type="button" value="삭제" onclick="go_delete();" class="boardbtn1" />
					<% } %>
						<input type="button" value="리스트" onclick="go_list();" class="boardbtn1" />
						<input type="button" value="닫기" onclick="window.close();" class="boardbtn1" />
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->


		</td>
	</tr>
</table>

</form>

</body>