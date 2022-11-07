<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사 대상지정 폼
// date : 2008-06-16
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
	
	    //request 데이터
	DataMap rowMap = (DataMap)request.getAttribute("LEVELGRU_ROW_DATA");
	rowMap.setNullToInitialize(true);
%>

<html>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<!-- [s] commonHtmlTop include 필수 -->
	<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
	<!-- [e] commonHtmlTop include -->
	<head>
	
<script language=javascript>
<!--

//등록, 수정 실행
function go_save(qu){
	if($("gruName").value == ""){
		alert("대상을 선택하여 주십시오.");
		return false;
	}

	if(NChecker($("pform"))){
		if(qu == "insert"){
			//등록모드
			if( confirm('등록 하시겠습니까?')){
				$("mode").value = "greadExec";
				$("qu").value = "insert";
				pform.action = "/tutorMgr/allowance.do";
				pform.submit();
			}
		}else if(qu == "modify"){
			//수정모드
			if( confirm('수정 하시겠습니까?')){
				$("mode").value = "greadExec";
				$("qu").value = "modify";
				pform.action = "/tutorMgr/allowance.do";				
				pform.submit();
			}
		}else{
			alert("잘못된 경로입니다.");
		}
	}
}
//-->
</script>
	</head>
	<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
		<form id="pform" name="pform" method="post">
		<input type="hidden" name="mode">
		<input type="hidden" name="qu">
		
		<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
		
		<!-- 지정강사 코드 -->
		<input type="hidden" name="gruCode"				value="<%=requestMap.getString("gruCode") %>">
		<!-- 강사등급코드 -->
		<input type="hidden" name="tlevel"				value="<%=requestMap.getString("tlevel") %>">
		
			<table class="pop01">
				<tr>
					<td class="titarea">
						<!-- 타이틀영역 -->
						<div class="tit">
							<h1 class="h1"><img src="../images/bullet_pop.gif" /> 대상 설정</h1>
						</div>
						<!--// 타이틀영역 -->
					</td>
				</tr>
				<tr>
					<td class="con">
						<!-- date -->
						<table  class="dataw01">
						  <tr>
							<th width="160">대 상</th>
							<td>
							  <input type="text" class="textfield" maxlength="10" onkeypress="if(event.keyCode==13){go_save('<%=requestMap.getString("qu") %>');return false;}"  name="gruName" value="<%=rowMap.getString("qu").equals("insert") ? "" : rowMap.getString("gruName") %>" style="width:200px;" />
							</td>
						  </tr>
						</table>
						<!-- //date -->
						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="저장" onclick="go_save('<%=requestMap.getString("qu") %>');" class="boardbtn1">
									<input type="button" onclick="self.close();" class="boardbtn1" value="취소">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
