<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육확인서, 출강 강사 확인서 출력전 등록 팝업 폼
// date : 2008-10-01
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<SCRIPT LANGUAGE="JavaScript">
<!--
//저장
function go_exec(){
	if(NChecker($("pform"))){
		if(confirm("등록 하시겠습니까?")){
			if($("comments").value.length > 50){
				alert("내역 최대 글자 수는 50자수 입니다. 다시 입력 하여 주십시오.")
				return false;
			}
			
			$("mode").value = "breakeDownExec";
			pform.action = "/member/member.do";
			pform.submit();
		}
	}
}
	
	
//-->
</SCRIPT>

<body leftmargin="0" topmargin=0>
	<form name="pform">
	<input type="hidden" name="mode">
	<input type="hidden" name="qu">
	<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">
	<!-- 유저넘버  -->
	<input type="hidden" name="userno" value="<%=requestMap.getString("userno")%>">
	<input type="hidden" name="grcode" value="<%=requestMap.getString("grcode")%>">
	<input type="hidden" name="grseq" value="<%=requestMap.getString("grseq")%>">
	<input type="hidden" name="breakDownGubun" value="<%=requestMap.getString("breakDownGubun") %>">
	<input type="hidden" name="name" value="<%=requestMap.getString("name") %>">
	<input type="hidden" name="searchName" value="<%=requestMap.getString("searchName") %>">
	<input type="hidden" name="searchName" value="<%=requestMap.getString("searchResno") %>">
	<input type="hidden" name="sessNo" value="<%=requestMap.getString("sessNo") %>">
	 <table class="pop01">
		<tr>
			<td class="titarea">
				<!-- 타이틀영역 -->
				<div class="tit">
					<h1 class="h1"><img src="../images/bullet_pop.gif" />출력내역서 등록</h1>
				</div>
				<!--// 타이틀영역 -->			
			</td>
		</tr>
		<tr>
			<td class="con">
				<!-- 리스트  -->
				<table class="datah01">
					<thead>
					<tr>
						<th>출력 내역</th>
						<td class="br0">
							<textarea name="comments" class="textarea" cols="50" rows="2"><%=listMap.getString("comments") %></textarea>
						</td>
					</tr>
				</table>
				<!-- //리스트  -->
	
				<!-- 하단 닫기 버튼  -->
				<table class="btn02">
					<tr>
						<td class="center">
							<input type="button" value="등록" onclick="go_exec();" class='boardbtn1'>
							<input type="button" value="취소" onclick="self.close();" class='boardbtn1'>
						</td>
					</tr>
				</table>
				<!--// 하단 닫기 버튼  -->
			</td>
		</tr>
	</table>
	</form>
</body>