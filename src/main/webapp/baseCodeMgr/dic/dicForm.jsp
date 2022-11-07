<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 용어사전 등록, 수정
// date  : 2008-06-01
// auth  : kang
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
	
	String mode = requestMap.getString("mode");
	String pmode = "";
	String strSubTitle = "";
	String btnTitle = "";
	String btnDeleteDisplay = "";
	
	String d_subj = "";
	String d_dicSeq = "";
	String d_words = "";
	String d_types = "";
	String d_descs = "";
	String d_groups = "";
	String isOneData = "";
	
	if(mode.equals("dicReg")){
		
		strSubTitle = "용어사전 등록";
		btnTitle = "등 록";
		btnDeleteDisplay = " style='display:none' ";
		pmode = "insertDic";
		
	}else{
		
		strSubTitle = "용어사전 수정";
		btnTitle = "수 정";
		pmode = "updateDic";
		
		DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
		if(rowMap != null){
			rowMap.setNullToInitialize(true);
			d_subj = rowMap.getString("subj");
			d_dicSeq = rowMap.getString("dicSeq");
			d_words = rowMap.getString("words");
			d_types = rowMap.getString("types");
			d_descs = rowMap.getString("descs");
			d_groups = rowMap.getString("groups");
			
			isOneData = "true";
		}
		
	}
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript" type="text/JavaScript">

// 저장
function fnSave(){

	if(NChecker($("pform"))){
	
		if($("subj").value.trim() == ""){
			alert("과목을 선택하세요.");
			return;
		}
		if($("types").value.trim() == ""){
			alert("용어분류를 선택하세요.");
			return;
		}
		if($("groups").value.trim() == ""){
			alert("색인을 선택하세요.");
			return;
		}
	
		$("mode").value = "<%= pmode %>";
										
		pform.action="dic.do";
		pform.submit();
		
	}

}

// 삭제
function fnDelete(){
	if($("subj").value.trim() == ""){
		alert("과목을 선택하세요.");
		return;
	}
	
	if(confirm("삭제하시겠습니까 ?")){
		$("mode").value = "deleteDic";										
		pform.action="dic.do";
		pform.submit();
	}
}

// 취소
function fnCancel(){
	$("mode").value = "dicList";
	pform.action="dic.do";
	pform.submit();
}



</script>

<script for="window" event="onload">
	// 과목 만들기
	fnSingleSelectBoxByAjax("subj", 
							"divSubj", 
							"subj", 
							"subj", 
							"subjnm", 
							"<%= d_subj %>", 
							"300", 
							"true", 
							"<%=isOneData%>",
							"true");
	
	// 색인 만들기	
	fnSingleSelectBoxByAjax("dicGroup", 
							"divDicGroup", 
							"groups", 
							"groups", 
							"groups", 
							"<%= d_groups %>", 
							"300", 
							"true",
							"false",
							"true");
	
	// 용어 분류만들기
	fnSingleSelectBoxByAjax("dicType", 
							"divTypes", 
							"types", 
							"types", 
							"typenm", 
							"<%= d_types %>", 
							"300", 
							"true",
							"false",
							"true");
	
	
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="dicSeq"		value="<%= requestMap.getString("dicSeq") %>">

<!-- 검색인자 -->
<input type="hidden" name="s_subj"		value="<%= requestMap.getString("s_subj") %>">
<input type="hidden" name="s_groups"	value="<%= requestMap.getString("s_groups") %>">
<input type="hidden" name="s_dicTypes"	value="<%= requestMap.getString("s_dicTypes") %>">
<input type="hidden" name="s_searchTxt"	value="<%= requestMap.getString("s_searchTxt") %>">

<!-- 페이징 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">



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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong><%= strSubTitle %></strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
					
						<br>
						<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#D6DBE5">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>과 목</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<div id="divSubj">
										<select name="subj"></select>											
									</div>	
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>제 목</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<input type="text" name="words" class="textfield" style="width:90%" value="<%= d_words %>" required="true!제목이 없습니다." maxchar="45!글자수가 많습니다." >
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>해 설</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<textarea name="descs" style="width:90%;height:200px" class="box" required="true!해설이 없습니다." maxchar="900!글자수가 많습니다."><%= d_descs %></textarea>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>용어분류</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<div id="divTypes">
										<select name="types"></select>
									</div>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF" height="28">
								<td width="15%" align="center" class="tableline11 dkblue" bgcolor="#E4EDFF" ><strong>색 인</strong></td>
								<td class="tableline21" align="left" style="padding:0 0 0 10">
									<div id="divDicGroup">
										<select name="groups"></select>
									</div>
								</td>
							</tr>
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						
						<!--[s] 하단 버튼  -->
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="center">
									<input type="button" value="<%= btnTitle %>" onclick="fnSave();" class="boardbtn1" >&nbsp;									
									<input type="button" value="삭 제" onclick="fnDelete()" class="boardbtn1" <%= btnDeleteDisplay %> >&nbsp;
									<input type="button" value="취 소" onclick="fnCancel()" class="boardbtn1" >
									
								</td>
							</tr>
							<tr><td height="5"></td></tr>
						</table>
						<!--[e] 하단 버튼  -->
					
					
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->


	
</form>
</body>






	