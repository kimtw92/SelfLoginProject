<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	/** 필수 코딩 내용 */
	// 로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    // navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);

	
	DataMap listMap = null;
	try {
		listMap = (DataMap)request.getAttribute("RESERVATION_LIST");
		listMap.setNullToInitialize(true);
	} catch(Exception e) {
		
	}
	
	String listnum = "";
	try {
		listnum = (String)request.getAttribute("listnum");
	} catch(Exception e) {
		
	}
	

%>

<script language="JavaScript">
window.onload = function(){

     if((parseInt(document.getElementById("content").offsetHeight) - parseInt(window.document.body.clientHeight)) > 20 ){
             window.document.body.scroll = "auto";
             window.resizeBy(0,0);
     }
}

</script>

</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%" id="content">

    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          

			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>설문관리 상세보기</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr><td>&nbsp;</td></tr>
				<tr>				
					<td>
						<table class="datah01" cellspacing="0" cellpadding="1" border="1" width="100%" class="contentsTable">
							<thead>
							<tr>
								<th colspan="2" >질문 <%=listnum%> 번 입력 목록</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td width="50%" align="center" bgcolor="#5071b4" style="color:#ffffff"><b>글번호</b></td>
									<td width="50%" align="center" bgcolor="#5071b4" color="#"><b>입력글</b></td>
								</tr>
								<% 
								  for(int i=0;listMap.keySize() > i;i++){ 
							    	if(listMap.getString("price", i) == "0" && "5".equals(listnum)) {
										continue;
									}
								
								%>

								<tr>
									<td align="center"><%=listMap.getString("seqno", i)%></td>
									<%
									if("3".equals(listnum)) {
									%>
										<td><%=listMap.getString("dateuse", i)%></td>		
									<%
									} else if("5".equals(listnum)) {
									%>
										<td><%=listMap.getString("price", i)%></td>		
									<%
									} else if("8".equals(listnum)) {
									%>
										<td><%=listMap.getString("etc", i).replaceAll("\\r\\n","<br />")%></td>		
									<%
									}
									%>
								</tr>
								<% } %>
							</tbody>
						</table>
					</td>
				</tr>
			</table>	
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>      

        </td>
    </tr>
</table>

</body>