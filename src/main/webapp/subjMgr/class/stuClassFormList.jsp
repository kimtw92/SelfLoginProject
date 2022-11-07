<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 입교자 반편성  지정하기 리스트
// date  : 2008-06-13
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
	
	// 과정명
	DataMap grCodeMap = (DataMap)request.getAttribute("GRCODENM");
	if(grCodeMap == null) grCodeMap = new DataMap();
	grCodeMap.setNullToInitialize(true);
	
	// 과목명
	DataMap subjMap = (DataMap)request.getAttribute("SUBJNM");
	if(subjMap == null) subjMap = new DataMap();
	subjMap.setNullToInitialize(true);
	
	// 선택과목
	DataMap refSubjMap = (DataMap)request.getAttribute("REFSUBJ_LIST");
	if(refSubjMap == null) refSubjMap = new DataMap();
	refSubjMap.setNullToInitialize(true);
	
	// 해당 과정기수의 이수처리가 완결되었는지 체크
	DataMap graynMap = (DataMap)request.getAttribute("GRAYN");
	if(graynMap == null) graynMap = new DataMap();
	graynMap.setNullToInitialize(true);
	
	
	String strTitle = "";
	strTitle = "년도 : <font color=\"#0080FF\">" + requestMap.getString("commYear") + "</font>"
			+ "&nbsp;&nbsp;&nbsp;과정명 : <font color=\"#0080FF\">" + grCodeMap.getString("grcodenm") + "</font>"
			+ "&nbsp;&nbsp;&nbsp;기수 : <font color=\"#0080FF\">" + requestMap.getString("grSeq").substring(4,6) + "</font>"
			+ "&nbsp;&nbsp;&nbsp;과목명 : <font color=\"#0080FF\">" + subjMap.getString("subjnm") + "</font>";
	
	String strRefSubj = "";
	String refSubjSelected = "";
	
	if(refSubjMap.keySize("subj") > 0){
		strRefSubj = "&nbsp;&nbsp;&nbsp;선택과목 : <select name=\"s_refSubj\" id=\"s_refSubj\" style=\"width:150px\" onchange=\"fnSearch();\">";
		strRefSubj += "<option value=\"\">**선택하세요**</option>";
		for(int i=0; i < refSubjMap.keySize("subj"); i++){
			if( refSubjMap.getString("subj",i).equals( requestMap.getString("s_refSubj") ) ){
				refSubjSelected = "selected";
			}else{
				refSubjSelected = "";
			}
			strRefSubj += "<option value=\"" + refSubjMap.getString("subj",i) + "\" " + refSubjSelected + " >" + refSubjMap.getString("lecnm",i) + "</option>";
		}
		strRefSubj += "</select>";
	}
	
	strTitle += strRefSubj;
	
	// 해당 과정기수의 이수처리가 완결되었으면 저장버튼 비활성
	String btnSaveDisplay = "";
	if(graynMap.keySize("cnt") > 0){
		if( graynMap.getInt("cnt") == 0){
			btnSaveDisplay = "Y";
		}else{
			btnSaveDisplay = "N";
		}
	}
	
	
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	String checked = "";
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	if(listMap.keySize("eduno") > 0){		
		for(int i=0; i < listMap.keySize("eduno"); i++){
			
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("eduno",i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("name",i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + Util.getValue( listMap.getString("resno",i) ,"&nbsp;" ) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("deptnm",i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("jiknm",i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline21\">");
			
			// 선택과목과을 선택해야만 체크박스가 나온다.
			if(!requestMap.getString("s_refSubj").equals("")){
				
				if( listMap.getString("subj",i).equals( requestMap.getString("s_refSubj") ) ){
					checked = "checked";
				}else{
					checked = "";
				}
				
				sbListHtml.append("		<input type=\"checkbox\" name=\"chk\" id=\"chk_" + i + "\" " + checked + " >");
				sbListHtml.append("		<input type=\"hidden\" name=\"userno_" + i + "\" id=\"userno_" + i + "\" value=\"" + listMap.getString("userno",i) + "\" > ");
			}else{
				sbListHtml.append("&nbsp;");
			}
				
			sbListHtml.append("	</td>");
			sbListHtml.append("</tr>");
			
		}
	}else{
		sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");		
		sbListHtml.append("</tr>");
	}
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--

// 검색
function fnSearch(){
	
	pform.action = "class.do";
	pform.submit();

}


// 저장
function fnSave(){

	if( "<%=btnSaveDisplay%>" == "N"){
		alert("이수처리완료로 변경불가능합니다.");
		return;
	}else if( $F("s_refSubj") == "" ){
		alert("선택과목을 선택하세요.");
		return;
	}else if( <%= listMap.keySize("eduno") %> == 0){
		alert("조회된 결과가 없습니다.");
		return;
	}else{
		
		var i=0;
		var tmpi = 0;
		var chkDataUserNo = "";
		var chkDataSubj = "";
		var chkDataWhereSubj = "";
		var objId = "";
		
		for(i=0; i < pform.elements.length; i++){		
			if(pform.elements[i].name == "chk"){
				
				tmp = pform.elements[i].id.split("_");
				objId = "userno_" + tmp[1];
				
				
				if( Form.Element.getValue(pform.elements[i].id) != null ){
					// 체크한것
					if(tmpi == 0){
						chkDataUserNo = $F(objId);
						chkDataSubj = $F("s_refSubj");
						chkDataWhereSubj = "<%= requestMap.getString("subj") %>";
					}else{
						chkDataUserNo += "|" + $F(objId);
						chkDataSubj += "|" + $F("s_refSubj");
						chkDataWhereSubj += "|" + "<%= requestMap.getString("subj") %>";
					}						
				}else{
					// 체크 안한것										
					if(tmpi == 0){
						chkDataUserNo = $F(objId);
						chkDataSubj = "<%= requestMap.getString("subj") %>";
						chkDataWhereSubj = $F("s_refSubj");
					}else{
						chkDataUserNo += "|" + $F(objId);
						chkDataSubj += "|" + "<%= requestMap.getString("subj") %>";
						chkDataWhereSubj += "|" + $F("s_refSubj");
					}					
				}
				
				tmpi += 1;
			}
			
		}
		
		$("chkDataSubj").value = chkDataSubj;
		$("chkDataUserNo").value = chkDataUserNo;
		$("chkDataWhereSubj").value = chkDataWhereSubj;
		
						
		if(confirm("저장하시겠습니까 ?")){
			$("mode").value = "saveStu";
			pform.action = "class.do";
			pform.submit();
		}
		
	}	
}

function fnList(){
	
	$("mode").value = "stuClassList";
	pform.action = "class.do";
	pform.submit();
}


//-->
</script>



<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 저장용  -->
<input type="hidden" name="chkDataUserNo"		id="chkDataUserNo"		value="">
<input type="hidden" name="chkDataSubj"			id="chkDataSubj"		value="">
<input type="hidden" name="chkDataWhereSubj"	id="chkDataWhereSubj"	value="">

<!-- 이전화면 검색조건 -->
<input type="hidden" name="commYear"	id="commYear" 	value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="commGrcode"	id="commGrcode" value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="commGrseq" 	id="commGrseq" 	value="<%= requestMap.getString("commGrseq") %>">

<!-- 이전에 리스트에서 선택한 코드 -->
<input type="hidden" name="grCode" 		id="grCode" 	value="<%= requestMap.getString("grCode") %>">
<input type="hidden" name="grSeq" 		id="grSeq" 		value="<%= requestMap.getString("grSeq") %>">
<input type="hidden" name="subj" 		id="subj" 		value="<%= requestMap.getString("subj") %>">



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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>입교자 지정 리스트</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2"></td></tr>
							<tr height="30">
								<td align="left" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<%= strTitle %>
								</td>
							</tr>
							<tr bgcolor="#375694"><td height="2"></td></tr>
						</table>
						
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="#5071B4">
								<td align="center" class="tableline11 white"><strong>교번</strong></td>
								<td align="center" class="tableline11 white"><strong>성명</strong></td>
								<td align="center" class="tableline11 white"><strong>주민번호</strong></td>
								<td align="center" class="tableline11 white"><strong>소속</strong></td>
								<td align="center" class="tableline11 white"><strong>직급</strong></td>
								<td align="center" class="tableline21 white"><strong>선택</strong></td>
							</tr>
							
							<%= sbListHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
					
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="right">
									<% if(btnSaveDisplay.equals("Y")){ %>								
									<input type="button" value="저 장" onclick="fnSave();" class="boardbtn1"   >
									<% }else if(btnSaveDisplay.equals("N")){ %>
									<font color='red'>이수처리완료로 변경불가능</font>
									<% } %>
									&nbsp;
									<input type="button" value="리스트" onclick="fnList();" class="boardbtn1">
								</td>
							</tr>
						</table>
					
						<br><br>
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



