<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm :	CyberPoll 미리보기
// date : 2008-07-01
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
	 
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("VIEWLIST_DATA");
	listMap.setNullToInitialize(true);
	
	//라인이 한줄인지 두줄인지 체크
	int chkLine = 0;
	//보기갯수
	int viw = 0;
	//카운터수 
	int ansCnt = 0;
	//전체 카운터수 
	int allAnsCnt = 0;
	//퍼센트 카운트
	int percentageCnt = 0;
	// 이미지 사이즈 카운트
	int imageNum = 0;
	// 응답 전체 수 
	int total = 0;
	//이미제 사이즈 개체수 제한 카운터
	int contorlCnt = 0;

%>

<html>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<head>
	
		<script language=javascript>
		<!--
		
		//-->
		</script>
	</head>
	<!-- [s] commonHtmlTop include 필수 -->
	<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
	<!-- [e] commonHtmlTop include -->
	<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
		<form id="pform" name="pform" method="post">
		<table class="pop01">
			<tr>
				<td class="titarea">
					<!-- 타이틀영역 -->
					<div class="tit">
						<h1 class="h1"><img src="../images/bullet_pop.gif" /> <%=requestMap.getString("subTitle")%> </h1>
					</div>
					<!--// 타이틀영역 -->
				</td>
			</tr>
			<tr>
				<td class="con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					
					<%for(int i=0; i < listMap.keySize("titleNo"); i++){ 
						if(listMap.getString("pflag",i).equals("A")){ 
							chkLine = 0;
							viw = listMap.getInt("answerCnt",i);
							contorlCnt += viw;
							
						%>
						<tr bgcolor="#375694">
							<td height="2" colspan="8"></td>
						</tr>
						<tr bgcolor="#5071B4"> 
							<td class="tableline11 white" width="50" height="35" align="center"><strong>설문<%=listMap.getInt("questionNo",i)+1 %></strong></td>
							<td class="tableline11 white" colspan="2" width="" align="center"><%=listMap.getString("question",i)%></td>
							<td class="tableline11 white" colspan="2" width="150" align="center">
								<%if(listMap.getString("answerKind", i-1).equals("4")){ %>
									주관식
								<%}else{ %>
									객관식
								<%} %>
							</td>
							
						<% %>	
						</tr>
						<%
		
						if(!listMap.getString("answerKind",(i+1)).equals("4")){
							if(chkLine <= listMap.getInt("answerNo")){
							int rowCount = 0;
							int chkValue = 0;
							
							for(int j=0; j < listMap.keySize("titleNo"); j++){ 
								if(listMap.getString("pflag", j).equals("B") && listMap.getString("titleNo", i).equals(listMap.getString("titleNo", j)) && listMap.getString("questionNo", i).equals(listMap.getString("questionNo", j))){
									rowCount++;
								} 	
							}
						%>
						
						<%
							//그래프를위해서 td박스한개만 생성하기 위한 변수
							chkValue = 0;
							//이미지 네임
							int imgName = 0;
							
							for(int j=0; j < listMap.keySize("titleNo"); j++){ 
								if(listMap.getString("pflag", j).equals("B") && listMap.getString("titleNo", i).equals(listMap.getString("titleNo", j)) && listMap.getString("questionNo", i).equals(listMap.getString("questionNo", j)) && !listMap.getString("answerKind",j).equals("4")){ 
									chkValue++;
									
									for(int m = 0; listMap.getInt("nameCnt") > m; m++){
										if(listMap.getString("pflag", j).equals("B") && listMap.getString("titleNo", i).equals(listMap.getString("titleNo", j)) && listMap.getString("questionNo", i).equals(listMap.getString("questionNo", j)) && !listMap.getString("answerKind",j).equals("4")){ 
											try{
												total = listMap.getInt("questionCnt_"+ansCnt)/listMap.getInt("questionTotalCnt_"+allAnsCnt);
				
											}catch(Exception e){
												total = 0;
												
											}
											
											int height= (total*70)+1;
											requestMap.addInt("total", total);
											requestMap.addInt("height", height);							
											ansCnt++;
											
										}
									}
									
									chkLine = listMap.getInt("answerNo",j);
									
									StringBuffer html = new StringBuffer();
									
								for(int k=0; k < viw; k++){ 
									if(listMap.getString("pflag", j).equals("B") && listMap.getString("titleNo", i).equals(listMap.getString("titleNo", j)) && listMap.getString("questionNo", i).equals(listMap.getString("questionNo", j)) && k < 5){ 
										imgName++;
		
										html.append("<td height=\"91\"><table width=\"20\" height=\"100%\"><tr><td height=\"71\" valign=\"bottom\"><img src=\"/images/sub0801_search_graph.gif\" width='20' height=\""+requestMap.getString("height", imageNum)+"\"></td></tr>");
										html.append("						 <tr><td><img src=\"/images/sub0801_search_num"+imgName+".gif\" width='20' height=\"10\"></td></tr></table></td>");
		
										if(imageNum < contorlCnt){
											imageNum++;
											
										}else if(imageNum == 0){
											if(imageNum <= contorlCnt){
												imageNum++;
											}
										}
									}
								}		
		
								
								if(chkValue == 1 && !listMap.getString("answerKind",i).equals("4")){
			
						%>
						
						<tr bgcolor="" style="padding:0 0 0 0">
							<td class="tableline11" align="center" height="30">문항</td>
							<td class="tableline11" align="center">지문</td>
							<td class="tableline11" width="" align="center">응답자수</td>
							<td class="tableline11" align="center" width="150" colspan="2" align="center">비율</td>
						</tr>
						<%} %>
						
						<tr>
							<td class="tableline11" align="center" height="28"><%=listMap.getString("answerNo",j) %></td>
							<td width="160" style="padding-left:10px" class="tableline11"><%=listMap.getString("question", j) %></td>
							<td class="tableline11" align="center" width=""><%=requestMap.getInt("total", percentageCnt) %></td>
							<td class="tableline11" align="center" width="30"><%=requestMap.getInt("total", percentageCnt)*100%>%</td>
							<%	
								if(chkValue == 1){
							%>
							<td width="120" class="tableline21" valign="bottom" rowspan="<%=rowCount%>" style="padding-left:10px">
								<table width="20">
									<tr>
							<%=html.toString() %>	
									<tr>
								</table>
							</td>
							
							<%
							
										}
										percentageCnt++;
									}
							%>
						</tr>
						
						<% 		
						
								}
							}//end if
						}//end for 
						
						%>
					
					<tr><td height="10">&nbsp;</td></tr>	
					<%
					allAnsCnt++;}}%>
					</table>
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>
