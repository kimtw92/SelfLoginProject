<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가 담당자 > 평가항목관리 > 교육훈련평가 리스트
// date : 2008-09-01
// auth : 최형준
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
	String tpl_mode=requestMap.getString("tpl_mode");
	String conf_button=requestMap.getString("conf_button");
	String m_point_ment=requestMap.getString("m_point_ment");
	String l_point_ment=requestMap.getString("l_point_ment");
	
	int sum_exam_point=requestMap.getInt("sum_exam_point");
	int sum_reportpoint=requestMap.getInt("sum_reportpoint");
	int sum_steppoint=requestMap.getInt("sum_steppoint");
	int sum_quizpoint=requestMap.getInt("sum_quizpoint");
	int gunpoint=requestMap.getInt("gunpoint");
	
	int sum_grp_point=requestMap.getInt("sum_grp_point");
	String grp_point_ment=requestMap.getString("grp_point_ment");
	String gun_point_ment=requestMap.getString("gun_point_ment");
	String step_point_ment=requestMap.getString("step_point_ment");
	String quiz_point_ment=requestMap.getString("quiz_point_ment");
	String rep_point_ment=requestMap.getString("rep_point_ment");
	int tot_sumpoint=requestMap.getInt("tot_sumpoint");
	String tm_ment=requestMap.getString("tm_ment");
	String popjs_tag=requestMap.getString("popjs_tag");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script language="JavaScript" type="text/JavaScript">
<!--
	//로딩시.
	onload = function()	{
	
		var commYear = "<%= requestMap.getString("commYear") %>";
		var commGrCode = "<%= requestMap.getString("commGrcode") %>";
		var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
		var reloading = ""; 
	
		getCommYear(commYear);																							// 년도
		getCommOnloadGrCode(reloading, commYear, commGrCode);									// 과정
		getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);				// 기수
	
	}

	//검색
	function go_search(){
		$("tpl_mode").value="";
		go_list();
	}
	
	//수정하기
	function go_editform () {
		if($("commYear").value == ""){
			alert("년도를 입력하세요");
		}else if($("commGrcode").value == ""){
			alert("과정을 입력하세요");
		}else if($("commGrseq").value == ""){
			alert("기수를 입력하세요");
		}else{
			$("tpl_mode").value="edit";
			go_list();
		}
	}
	
	//저장
	function go_action(mod){
		$("mode").value=mod;
		pform.action = "/evalMgr/evalItem.do";
		pform.submit();		
	}

	//리스트
	function go_list(){	
		$("mode").value = "eduTrain";
		pform.action = "/evalMgr/evalItem.do";
		pform.submit();
	}
	
-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>
</head>
<body>
<form id="pform" name="pform" method="post" action="">	
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"					value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="tpl_mode"				value="<%=requestMap.getString("tpl_mode") %>">
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

        <td colspan="100%" valign="top" class="leftMenuBg" align="center"> 
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>            
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->


			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>교육 훈련평가</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->			

			<!--[s] Contents Form  -->	
			<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height="28" bgcolor="F7F7F7" >
					<td width="80" align="center" class="tableline11"><strong>년 도</strong></td>
					<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<div id="divCommYear" class="commonDivLeft">										
							<select name="commYear" onChange="getCommGrCode('subj');" style="width:100px;font-size:12px">
								<option value="">**선택하세요**</option>
							</select>
						</div>					
					</td>
					<td width="80" align="center" class="tableline11"><strong>과 정</strong></td>
					<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<div id="divCommGrCode" class="commonDivLeft">
							<select name="commGrcode" style="width:250px;font-size:12px">
								<option value="">**선택하세요**</option>
							</select>
						</div>
					</td>
					<td rowspan="2" bgcolor="#FFFFFF" width="100" align="center">
						<input type="button" value="검 색" onclick="go_search();" class="boardbtn1">
						<%=conf_button%>
					</td>
				</tr>
				<tr height="28" bgcolor="F7F7F7">
					<td align="center" class="tableline11"><strong>기 수</strong></td>
					<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<div id="divCommGrSeq" class="commonDivLeft">
							<select name="commGrseq" style="width:100px;font-size:12px">
								<option value="">**선택하세요**</option>
							</select>
						</div>
					</td>
					<td align="center" class="tableline11"  colspan="2" bgcolor="#FFFFFF">&nbsp;</td>
				</tr>														
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
			</table>
			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>	
			
			<%if(tpl_mode.equals("edit")){ %>
				<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr> 
					<td>&nbsp;</td>

					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="E5E5E5">
							<tr bgcolor="#375694"> 
								<td height="2" colspan="100%"></td>
							</tr>
							<tr height="28" bgcolor="#5071B4"> 
								<td width="10%" align="center" class="tableline11 white">
								구분
								</td>
								<td width="10%" align="center" class="tableline11 white">
								배점
								</td>
								<td width="80%" align="center" class="tableline11 white">
								평가내역
								</td>
							</tr>

							<tr>
								<td height="30"  class="tableline11" align="center" bgcolor="#F7F7F7">
								계
								</td>
								<td height="30"  class="tableline11" align="center" bgcolor="#ffffff">
								<%=tot_sumpoint %>
								</td>
								<td width="80%" height="30"  class="tableline11" align="left" bgcolor="#ffffff">
								
								</td>
							</tr>


							<tr>
								<td height="30"  class="tableline11" align="center" bgcolor="#F7F7F7">
								필답평가
								</td>
								<td height="30"  class="tableline11" align="center" bgcolor="#ffffff">
								<%=sum_exam_point%>
								</td>
								<td width="80%" height="30" class="tableline11" align="left" bgcolor="#ffffff">
								<%=m_point_ment %><br>
								<%=l_point_ment %><br>
								</td>
							</tr>

							<tr>
								<td height="30"  class="tableline11" align="center" bgcolor="#F7F7F7">
								분임평가
								</td>
								<td height="30"  class="tableline11" align="center" bgcolor="#ffffff">
								<%=sum_grp_point %>
								</td>
								<td width="80%" height="30"  class="tableline11" align="left" bgcolor="#ffffff">
								<%=grp_point_ment %>
								</td>
							</tr>
							<tr>
								<td height="30"  class="tableline11" align="center" bgcolor="#F7F7F7">
								과제평가
								</td>
								<td height="30"  class="tableline11" align="center" bgcolor="#ffffff">
								<%=sum_reportpoint%>
								</td>
								<td width="80%" height="30" class="tableline11" align="left" bgcolor="#ffffff">
								<%=rep_point_ment%>
								</td>
							</tr>

							<tr>
								<td height="30"  class="tableline11" align="center" bgcolor="#F7F7F7">
								근태평가
								</td>
								<td height="30"  class="tableline11" align="center" bgcolor="#ffffff">
								<%=gunpoint %>
								</td>
								<td width="80%" height="30"  class="tableline11" align="left" bgcolor="#ffffff">
									<textarea name="gun_evalment" cols="80" rows="5"><%=gun_point_ment%></textarea>
								</td>
							</tr>

							<tr>
								<td height="30"  class="tableline11" align="center" bgcolor="#F7F7F7">
								진도율
								</td>
								<td height="30"  class="tableline11" align="center" bgcolor="#ffffff">
								<%=sum_steppoint%>
								</td>
								<td width="80%" height="30"  class="tableline11" align="left" bgcolor="#ffffff">
									<textarea name="step_evalment" cols="80" rows="5"><%=step_point_ment%></textarea>
								</td>
							</tr>

							<tr>
								<td height="30"  class="tableline11" align="center" bgcolor="#F7F7F7">
								차시평가
								</td>
								<td height="30"  class="tableline11" align="center" bgcolor="#ffffff">
								<%=sum_quizpoint%>
								</td>
								<td width="80%" height="30"  class="tableline11" align="left" bgcolor="#ffffff">
									<textarea name="quiz_evalment" cols="80" rows="5"><%=quiz_point_ment%></textarea>
								</td>
							</tr>

							<tr>
								<td height="30" colspan="3" class="tableline11" align="left" bgcolor="#ffffff">
								<b>※ 필답평가시 컴퓨터용 싸인펜 사용</b>
							</tr>

							<%}else{ %>				
							
							<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>&nbsp;</td>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>&nbsp;</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>
															<%=tm_ment%>
															<iframe name="AIREPORT" src="#" width="100%" height="600" frameborder="0" border="1"></iframe>
														</td>
													</tr>													
												</table>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
									</table></td>
								<td>&nbsp;</td>
							</tr>
							</table>
						<%} %>
			<!--[e] Contents Form  -->	
			
			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>	
					</table>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
</form>
<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
</body>
</html>
<script language="javascript">
<!--
	document.write(tagAIGeneratorOcx);

	<%=popjs_tag%>
	function report_dis1() {
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_49.jsp?p_grcode=<%=requestMap.getString("commGrcode")%>&p_grseq=<%=requestMap.getString("commGrseq")%>");
	}
//-->
</script>