<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 팝업관리 미리보기
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
	
	//리스트 데이터
	DataMap rowMap = (DataMap)request.getAttribute("VIEWROW_DATA");
	rowMap.setNullToInitialize(true);
%>

<html>
	<title><%=rowMap.getString("title") %></title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<head>
	
		<script language=javascript>
		<!--
		function setCookie( name, value, expiredays ) 
		{ 
		        var todayDate = new Date(); 
		        todayDate.setDate( todayDate.getDate() + expiredays ); 
		        document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
		} 
		function Pop_close() 
		{ 
		
				        self.close(); 
		} 
		//-->
		</script>
	</head>
	<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
		<form id="pform" name="pform" method="post">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr > 
					<td>
						<table width="<%=rowMap.getInt("popupWidth")%>"  width="" align="center" style="table-layout:fixed">
							<tr>
								<td height="<%=rowMap.getInt("popupHeight") - 25 %>"><%=StringReplace.convertHtmlDecodeNamo(rowMap.getString("content")) %></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td bgcolor="7FCFFC" height="25" valign="bottom"> 
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td align="right"><font color="#000000" size="2pt">오늘하루는 이창을 열지 않음</font> 
									<input type="checkbox" name="checkyn" value="checkbox" onClick="javascript:Pop_close()">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
