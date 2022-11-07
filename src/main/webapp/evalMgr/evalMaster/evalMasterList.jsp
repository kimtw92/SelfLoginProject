<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가마스터 리스트
// date  : 2008-08-18
// auth  :  CHJ
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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	String listStr="";
	
	if(!listMap.isEmpty()){
		for(int i=0;i<listMap.keySize("subj");i++){
			listStr +="<tr bgcolor='#FFFFFF' height='25'>";
			listStr +="<td class='tableline11' align='center'>"+listMap.getString("subj",i)+"</td>";
			if(!listMap.getString("rowspan",i).equals("0")){
				listStr+="<td class='tableline11' align='center' rowspan='"+listMap.getString("rowspan",i)+"'>"+listMap.getString("subjGnm",i)+"</td>";
			}
			listStr +="<td class='tableline11' align='center'>"+listMap.getString("lecnm",i)+"</td>";
			listStr +="<td class='tableline11' align='center'>"+listMap.getString("evlYn",i)+"</td>";
			listStr +="<td class='tableline11' align='center'>"+listMap.getString("ptypeM",i)+"</td>";
			listStr +="<td class='tableline11' align='center'>"+listMap.getString("ptypeT",i)+"</td>";
			listStr +="<td class='tableline11' align='center'>"+listMap.getString("ptype1",i)+"</td>";
			listStr +="<td class='tableline11' align='center'>"+listMap.getString("ptype2",i)+"</td>";
			/*listStr +="<td class='tableline11' align='center'>"+listMap.getString("ptype3",i)+"</td>";
			listStr +="<td class='tableline11' align='center'>"+listMap.getString("ptype4",i)+"</td>";
			listStr +="<td class='tableline11' align='center'>"+listMap.getString("ptype5",i)+"</td>";*/
			listStr +="<td class='tableline11' align='center'>"+listMap.getString("function",i)+"</td>";
			listStr +="</tr>";
		}
	}else{
		listStr +="<tr bgcolor='#FFFFFF' height='25'>";
		listStr +="<td height='28' colspan='12' width='100%' align='center' class='tableline11'>등록된 과목이 없습니다.</td>";
		listStr +="</tr>";
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->



<script language="JavaScript" type="text/JavaScript">
<!--
function OpenEval(he, wi, go_url){	
	var optstr;
	if($("commGrcode").value == ""){
		alert("과정을 선택하세요.");
		return;
	}
	if($("commGrseq").value == ""){
		alert("기수를 선택하세요.");
		return;
	}
	
	optstr="height="+he+",width="+wi+",location=0,menubar=0,resizable=1,scrollbars=1,status=1,titlebar=0,toolbar=0,screeny=0,left=0,top=0";
	window.open(go_url, "POPWIN", optstr);
}

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
	
	go_list();
}
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/evalMgr/evalMaster.do";
	pform.submit();

}
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

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
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>평가마스터</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			
			
			<!-- [s] 사용자 추가 영역  -->
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"	class="contentsTable">
				<tr>
					<td>
						<!-- 검색  -->
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
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 상단 버튼  -->
						<table class="btn01">
							<tr>
								<td class="left">
									(중간 <%=listMap.getString("mevalYn").equals("O")?"O":"X" %>, 최종평가 <%=listMap.getString("levalYn").equals("O")?"O":"X" %>, 상시평가수 <%=listMap.getString("nevalCnt")%>회)
								</td>								
								<td class="right">
									<input type=button class="boardbtn1"  value="과정평가수설정" onClick="javascript:OpenEval(400, 500, '/evalMgr/evalMaster.do?mode=EvlinfoGrseq&menuId=<%= requestMap.getString("menuId") %>&commGrcode=<%=requestMap.getString("commGrcode") %>&commGrseq=<%=requestMap.getString("commGrseq")%>')">
								</td>
							</tr>
						</table>
						<!--// 상단 버튼  -->

						<!--[s] 리스트  -->
						<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
							<tr bgcolor="#375694"> 
								<td height="2" colspan="12"></td>
							</tr>
							<tr height="28" bgcolor="#5071B4"> 
								<td align="center" class="tableline11 white" width=10%><strong>과목코드</strong></td>
								<td align="center" class="tableline11 white" width=17%><strong>과목구분</strong></td>
								<td align="center" class="tableline11 white" width=20%><strong>과목</strong></td>
								<td align="center" class="tableline11 white" width=5%><strong>설정<br>여부</strong></td>
								<td align="center" class="tableline11 white" width=5%><strong>중간<br>평가수</strong></td>
								<td align="center" class="tableline11 white" width=5%><strong>최종<br>평가수</strong></td>
								<td align="center" class="tableline11 white" width=4%><strong>상시<br>1회</strong></td>
								<td align="center" class="tableline11 white" width=4%><strong>상시<br>2회</strong></td>
								<!-- 
								<td align="center" class="tableline11 white" width=4%><strong>상시<br>3회</strong></td>
								<td align="center" class="tableline11 white" width=4%><strong>상시<br>4회</strong></td>
								<td align="center" class="tableline11 white" width=4%><strong>상시<br>5회</strong></td>
								 -->
								<td align="center" class="tableline11 white" width=18%><strong>기능</strong></td>
							</tr>	
							<%=listStr %>
						</table>
						<!--//[e] 리스트  -->						
					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>

			
			<!-- [e] 사용자 추가 영역  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>