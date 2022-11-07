<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가담당자 > 평가점수관리 > 가점입력
// date : 2008-08-13
// auth : CHJ
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
	String menuId=requestMap.getString("menuId");
	DataMap pointUpList=(DataMap)request.getAttribute("pointUpList");
	pointUpList.setNullToInitialize(true);
	DataMap closing=(DataMap)request.getAttribute("closing");
	closing.setNullToInitialize(true);
	
	String listStr="";
	if(!pointUpList.isEmpty()){
		for(int i=0;i<pointUpList.keySize("name");i++){
			listStr +="<tr bgcolor='#FFFFFF' height='25'>";
			listStr +="<td class='tableline11' align='center'>"+pointUpList.getString("gubun",i)+"</td>";
			if(pointUpList.getString("resno",i).equals("")){
				listStr +="<td class='tableline11' align='center'>-XXXXXXX</td>";									
			}else{
				listStr +="<td class='tableline11' align='center'>"+pointUpList.getString("resno",i).substring(0, 6)+"-XXXXXXX"+"</td>";
			}
			listStr +="<td class='tableline11' align='center'>"+pointUpList.getString("name",i)+"</td>";
			listStr +="<td class='tableline11' align='center'>"+pointUpList.getString("addpoint",i)+"</td>";
			listStr +="<td class='tableline11' align='center'>";
			listStr +="<input type='hidden' name='h_userno[]' value='"+pointUpList.getString("userno",i)+"'><input type='text' name='add_point[]' value='"+pointUpList.getString("addpoint",i)+"' size='5'></div></td>";
			listStr +="</tr>";			
		}
	}else{
		listStr +="<tr bgcolor='#FFFFFF' height='40'>";
		listStr +="<td align='center' class='tableline21' colspan='100%'>데이타가 없습니다.</td>";		
		listStr +="</tr>";
	}
	String buttonStr="";
	if(closing.getString("closing").equals("Y")){
		buttonStr="이수처리되어 수정할 수 없습니다";
	}else{
		buttonStr="<input type='button' value='저장' class='boardbtn1' onclick='submitQa();'>";		
	}
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>점수별 성적분포도</title>
<head>
<script for="window" event="onload">
<!--
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";

	var reloading = ""; 

	getCommYear(commYear);																							// 년도
	getCommOnloadGrCode(reloading, commYear, commGrCode);									// 과정
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);				// 기수

//-->
</script>
<script language="JavaScript" type="text/JavaScript">
	function go_search(){
		go_list();
	}
	
	function go_list(){	
		$("mode").value = "pointUp";	
		pform.action = "/evalMgr/score.do";
		pform.submit();	
	}
	
	function findMember(title, smode, grcode, grseq, code, name, mark){
	
		var url = "/member/member.do?mode=findPerson&menuId=<%=menuId%>&title=" + title + "&smode=" + smode + "&commGrcode=" + grcode + "&commGrseq=" + grseq + "&code=" + code + "&name=" + name+"&mark="+mark;
		window.open(url,"findmember","width=500,height=700,scrollbars=yes");		
	}
	
	function submitQa() {
		var f = document.pform;
		for(var i=0;i<pointObj.length;i++){
			if (Number(pointObj[i].value) > 20){
				var j=i+1;
				alert(j+" 번째 입력하신 점수가 20점보다 큽니다. 저장할 수 없습니다.");
				return;
			}
		}	
		if (confirm("저장하시겠습니까?")) {
			var pointStr="";
			var userStr="";
			for(i=0; i < document.forms["pform"].elements["add_point[]"].length; i++){		 
					if( i>0){
						pointStr += "|";	
						userStr +="|";					
					}	
					pointStr += pointObj[i].value;
					userStr += userObj[i].value;
			}		
		
			$("pointStr").value=pointStr;
			$("usernoStr").value=userStr;

			$("mode").value = "pointUpExec";		
			pform.action = "/evalMgr/score.do";
			f.submit();
		}
}
</script>
</head>
<body>
<form id="pform" name="pform" method="post">
	<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
	<input type="hidden" name="mode"					value="<%= requestMap.getString("mode") %>">
	<input type="hidden" name="qu"						value="">
	<input type="hidden" name="pointStr"				value="">
	<input type="hidden" name="usernoStr"			value="">
	
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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->


			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>가점입력</strong>
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
						<br>
						<br>
						<table width=90% border="0" cellpadding="0" cellspacing="0" bgcolor="E5E5E5" align="center">
							<tr bgcolor="ffffff"> 
								<td colspan="3">
								&nbsp;
								<%if(!closing.getString("closing").equals("Y")){ %>
								<strong>학생장<a href="javascript:findMember('stuM', 'stumas','<%=requestMap.getString("commGrcode") %>','<%=requestMap.getString("commGrseq") %>', 'grstumascode_m', 'grstumas_m', 'addpoint');" ><span class="txt_blue">[변경]</span></a></strong>
								&nbsp;&nbsp;
								<strong>부학생장<a href="javascript:findMember('stuS', 'stumas','<%=requestMap.getString("commGrcode") %>','<%=requestMap.getString("commGrseq") %>', 'grstumascode_s', 'grstumas_s','addpoint');"><span class="txt_blue">[변경]</span></a></strong>
								<%} %>
								</td>
								<td colspan="3" align=right>
								<%=buttonStr %>
								</td>
							</tr>
						</table>
						<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
							<tr bgcolor="#375694"> 
								<td height="2" colspan="12"></td>
							</tr>
							<tr height="28" bgcolor="#5071B4"> 
								<td align="center" class="tableline11 white" width=15%><div align="center"><strong>구분</strong></div></td>
								<td align="center" class="tableline11 white" width=20%><div align="center"><strong>주민번호</strong></div></td>
								<td align="center" class="tableline11 white" width=15%><div align="center"><strong>성명</strong></div></td>
								<td align="center" class="tableline11 white" width=15%><div align="center"><strong>가점</strong></div></td>
								<td align="center" class="tableline11 white" width=15%><div align="center"><strong>가점수정</strong></div></td>
							</tr>
							<%=listStr %>
						</table>
					<!--[e] Contents Form  -->
					<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>				                            
				</td>
			</tr>
			</table>		
</form>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
</body>
</html>
<script>
	pointObj	= document.getElementsByName('add_point[]');
	userObj	= document.getElementsByName('h_userno[]');
</script>
