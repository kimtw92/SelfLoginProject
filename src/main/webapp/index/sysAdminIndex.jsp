<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시스템관리자 인덱스
// date  : 2008-06-27
// auth  : 
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);
String cboAuth = requestMap.getString("cboAuth");

if("D".equals(cboAuth)) {
    //request 데이터


	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	//과장질문방 리스트
	DataMap questionMap = (DataMap)request.getAttribute("QUESTION_DATA");
	questionMap.setNullToInitialize(true);
	//게시판 Q&A 리스트
	DataMap bbsMap = (DataMap)request.getAttribute("BBS_DATA");
	bbsMap.setNullToInitialize(true);
	


	String pageTitle = "";	

		
	if(cboAuth.equals("0")){
		pageTitle = "시스템관리자 운영메뉴";
	}else if(cboAuth.equals("2")){
		pageTitle = "과정운영자 운영메뉴";
	}else if(cboAuth.equals("3")){
		pageTitle = "기관담당자 운영메뉴";
	}else if(cboAuth.equals("5")){
		pageTitle = "평가담당자 운영메뉴";
	}else if(cboAuth.equals("7")){
		pageTitle = "강사 운영메뉴";
	}else if(cboAuth.equals("A")){
		pageTitle = "과정장 운영메뉴";
	}else if(cboAuth.equals("B")){
		pageTitle = "홈페이지관리자 운영메뉴";
	}else if(cboAuth.equals("C")){
		pageTitle = "부서담당자 운영메뉴";
	}else if(cboAuth.equals("D")){
		pageTitle = "기관담당자(외부) 운영메뉴";
	}
	

	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//대메뉴 코드
	String menuDepth1 = "";
	int menuDepth1Count = 0;
	int depthCount = 0;	
	
	String menuId = "";
	String imageName = "";
	StringBuffer html = new StringBuffer();
	if(listMap.keySize("menuGrade") > 0){
		
		html.append("\n	<tr valign=\"top\">");
		
		for(int i =0; i < listMap.keySize("menuGrade"); i++){
			if(!listMap.getString("menuDepth1", i).equals(menuDepth1)){
				if(listMap.getString("menuUseYn", i).equals("Y")){
					depthCount++;
					if(menuDepth1Count != 0 && menuDepth1Count % 4 != 0){
						//이미지 설정 
						if(menuDepth1Count % 4 == 1){
							imageName = "sitemap_box02";
						}else if(menuDepth1Count % 4 == 2){
							imageName = "sitemap_box03";
						}else if(menuDepth1Count % 4 == 3){
							imageName = "sitemap_box04";
						}
	
						//대분류
						html.append("\n		<td width='227' height=\"100%\" style=\"padding-right:0px\">");
						html.append("\n			<table width='100%' border='0' cellspacing=\"0\" cellpadding=\"0\">");
						html.append("\n				<tr height=\"33\" style='height:33px;'>");
						html.append("\n					<td   style=\"height:33px\" align=\"center\"  style=\"width:200px;font size:15;padding:3 0 0 0\" valign=\"middle\" bgcolor=\"#F5F5F5\">");
						html.append("\n 					<strong><font color=\"7E6B2F\">"+listMap.getString("menuName", i) +"</strong>");
						html.append("\n					</td>");
						html.append("\n					<td width=\"30\" rowspan=\"100%\"></td>");
	
						html.append("\n				</tr>");
						for(int j =0; j < listMap.keySize("menuGrade"); j++){
							//중분류
							if(listMap.getString("menuStepNo", j).equals("2") && listMap.getString("menuDepth1", i).equals(listMap.getString("menuDepth1", j))){
								if(listMap.getString("menuUseYn", j).equals("Y")){
									html.append("\n				<tr>");
									html.append("\n					<td height=\"25\"><strong><img src=\"../images/bullet_07.gif\" width=\"11\" height=\"11\" align=\"absmiddle\">");
									html.append(	listMap.getString("menuName", j));
									html.append("\n					</strong></td>");
									html.append("\n				</tr>");
								}
								for(int k = 0; k < listMap.keySize("menuGrade"); k++){
									menuId = listMap.getString("menuUrl", k)+"&menuId="+listMap.getString("menuDepth1", k)+"-"+listMap.getString("menuDepth2", k)+"-"+listMap.getString("menuDepth3", k);
									
									//소분류
									if(listMap.getString("menuStepNo", k).equals("3") && listMap.getString("menuDepth1", i).equals(listMap.getString("menuDepth1", k)) && listMap.getString("menuDepth2", j).equals(listMap.getString("menuDepth2", k))){
										if(listMap.getString("menuUseYn", k).equals("Y")){
											html.append("\n				<tr>");
											html.append("\n					<td height=\"16\"> <a href=\""+menuId+"\">ㆍ");
											html.append(	listMap.getString("menuName", k));
											html.append("\n					</a></td>");
											html.append("\n				</tr>");
										}
									}
								}
							}
						}
						
						html.append("\n			</table>");
						html.append("\n		</td>");
						//첫번째, 두번째, 세번째의 중앙라인에 줄을 그어준다.
						if(depthCount % 4 == 2 || depthCount % 4 == 3 || depthCount % 4 == 1){
							html.append("\n		<td width='10' valign=\"top\" background=\"/images/sitemap_dot.gif\"></td>");
							html.append("\n		<td width='5' valign=\"top\">&nbsp;</td>");
						}
						
	
	
						
					}else{
						if(menuDepth1Count == 0){
							imageName = "sitemap_box01";
						}else if(menuDepth1Count % 4 == 0){
							imageName = "sitemap_box01";						
						}
						
						//대분류
						html.append("\n		</tr>");
						html.append("\n		<tr>");
						html.append("\n			<td height='10'  colspan='100%'></td>");
						html.append("\n		</tr>");
						html.append("\n		<tr valign=\"top\">");
						html.append("\n		<td width='227' style=\"padding-right:0px\">");
						html.append("\n			<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
						html.append("\n				<tr valign=\"top\">");
						html.append("\n					<td height=\"33\" align=\"center\" width=\"150\" style=\"font size:15;padding:3 0 0 0\" valign=\"middle\" bgcolor=\"#F5F5F5\">");
						html.append("\n 					<strong><font color=\"7E6B2F\">"+listMap.getString("menuName", i) +"</strong>");
						html.append("\n					</td>");
						html.append("\n					<td width=\"30\" rowspan=\"100%\"></td>");
						html.append("\n				</tr>");
						for(int j =0; j < listMap.keySize("menuGrade"); j++){
							//중분류
							if(listMap.getString("menuStepNo", j).equals("2") && listMap.getString("menuDepth1", i).equals(listMap.getString("menuDepth1", j))){
								if(listMap.getString("menuUseYn", j).equals("Y")){
								html.append("\n				<tr>");
								html.append("\n					<td height=\"25\"><strong><img src=\"../images/bullet_07.gif\" width=\"11\" height=\"11\" align=\"absmiddle\">");
								html.append(	listMap.getString("menuName", j));
								html.append("\n					</td>");
								html.append("\n				</tr>");
								}
								for(int k = 0; k < listMap.keySize("menuGrade"); k++){
									menuId = listMap.getString("menuUrl", k)+"&menuId="+listMap.getString("menuDepth1", k)+"-"+listMap.getString("menuDepth2", k)+"-"+listMap.getString("menuDepth3", k);
									
									//소분류
									if(listMap.getString("menuStepNo", k).equals("3") && listMap.getString("menuDepth1", i).equals(listMap.getString("menuDepth1", k)) && listMap.getString("menuDepth2", j).equals(listMap.getString("menuDepth2", k))){
										if(listMap.getString("menuUseYn", k).equals("Y")){
											html.append("\n				<tr>");
											html.append("\n					<td height=\"16\"> <a href=\""+menuId+"\">ㆍ");
											html.append(	listMap.getString("menuName", k));
											html.append("\n					</a></td>");
											html.append("\n				</tr>");
										}
									}
								}
							}
							
						}			
						html.append("\n			</table>");
						html.append("\n		</td>");
						
						//첫번째, 두번째, 세번째의 중앙라인에 줄을 그어준다.
						if(menuDepth1Count % 4 == 2 || menuDepth1Count % 4 == 3 || menuDepth1Count % 4 == 0){
							html.append("\n		<td width='10' valign=\"top\" background=\"/images/sitemap_dot.gif\"></td>");
							html.append("\n		<td width='5' valign=\"top\">&nbsp;</td>");
						}
						
					}
					
					menuDepth1Count++;
					menuDepth1 = listMap.getString("menuDepth1", i);
				}
			}			
		}
			//리스트항목이 4개이하일때를 대비하여 만듬.
		if(menuDepth1Count < 4 ){
			for(int i = menuDepth1Count; i < 4; i++){
				html.append("\n		<td width='24%' height=\"100%\" style=\"padding-right:0px\">");
				html.append("\n		&nbsp;</td>");
			}
			
			if(menuDepth1Count == 1){
				html.append("\n		<td width='0%' height=\"100%\" style=\"padding-right:0px\">");
				html.append("\n		&nbsp;</td>");
			}
		}

		
		
		html.append("\n	</tr>");

	}else{
		
	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--



//-->
</script>
<script for="window" event="onload">
<!--

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<%-- START Q&A 레이어팝업 --%>
<% 
//시스템관리자, 강사만 레이어팝업 뜨도록 한다.
if("0".equals(cboAuth) || "7".equals(cboAuth)) {
%>

<div id="show_qna" style='position:absolute;top:1;border:3 solid #000000'>
<table width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
	<tr><td style='color:red;padding-left:5' height=20><b>현재 미응답된 과정 질문 및 QNA 목록</b></td></tr>
	<tr><td height=1 bgcolor=#a0a0a0></td></tr>
	
<%
	for(int i=0; i < questionMap.keySize(); i++) {
%>

	<tr>
		<td height=20 style='padding:5'>
			<a href="<%= questionMap.getString("goUrl", i) %>"><b>[<%= questionMap.getString("grcodenm", i) %> <%= questionMap.getString("grseq", i) %>]</b>
			<%//= questionMap.getString("subjnm", i) %>[<%= questionMap.getString("name", i) %>]
<% 
		String title = questionMap.getString("title", i);
		if(title.length() > 20) {
			title = title.substring(0, 19);
		}
%>			
			<%= title %>
			</a>
		</td>
	</tr>
<%	}	%>
<%
	for(int i=0; i < bbsMap.keySize(); i++) {
%>

	<tr>
		<td height=20 style='padding:5'>
			<a href="<%= bbsMap.getString("goUrl", i) %>"><b>[문의및답변게시판]</b>
<% 
		String title = bbsMap.getString("title", i);
		if(title.length() > 25) {
			title = title.substring(0, 24);
		}
%>			
			<%= title %>
			</a>
		</td>
	</tr>
<%	}	%>
	
	<tr><td height=1 bgcolor=#a0a0a0></td></tr>	
	<!-- <tr><td height=20 style='padding:5'>{pageing}</td></tr> -->
	<tr><td align=right><input type="button" value="닫기" class="boardbtn1" onClick="document.getElementById('show_qna').style.display='none'">&nbsp;</td></tr>
	<tr><td height=10></td></tr>
</table>
</div>
<script>
	document.getElementById('show_qna').style.left=document.body.clientWidth-507;
</script>
<%
}	%>
<%-- END Q&A 레이어 --%>



<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">




<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>            	
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>
            <!--[e] 경로 네비게이션-->
                                    
			

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong><%= pageTitle %></strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table width="100%" height="30"><tr><td></td></tr></table>
			<table width="100%"	 border="0" cellspacing="0" cellpadding="0" class="contentsTable">
				<tr>
					<td height="20">
						<table width="100%"	 border="0" cellspacing="0" cellpadding="0">
							<%=html.toString() %>
						</table>
					</td>
				</tr>
				
			</table>			
			<!--[e] Contents Form  -->
			<table width="100%" height="30"><tr><td></td></tr></table>                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>
<% } else { out.println("잘못된 접근방법입니다."); } %>