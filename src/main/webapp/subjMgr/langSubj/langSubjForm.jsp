<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 어학점수입력
// date  : 2008-06-16
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
	
	
	String strTitle = "";
	strTitle = "년도 : <font color=\"#0080FF\">" + requestMap.getString("commYear") + "</font>"
			+ "&nbsp;&nbsp;&nbsp;과정명 : <font color=\"#0080FF\">" + grCodeMap.getString("grcodenm") + "</font>"
			+ "&nbsp;&nbsp;&nbsp;기수 : <font color=\"#0080FF\">" + requestMap.getString("commGrseq").substring(4,6) + "</font><br><br>"
			+ "과목명 : <font color=\"#0080FF\">" + subjMap.getString("subjnm") + "</font>";
			
			
	// 분반 갯수 목록
	String strSubjClassHtml = "";
	DataMap subjClassMap = (DataMap)request.getAttribute("SUBJCLASS_LIST");
	if(subjClassMap == null) subjClassMap = new DataMap();
	subjClassMap.setNullToInitialize(true);
			
	if(subjClassMap.keySize("classno") > 0){
		strSubjClassHtml = "반 선택 : <select name=\"selSubjClass\" id=\"selSubjClass\" style=\"width:120px;\" onchange=\"fnSearch();\" >";
		strSubjClassHtml += "<option value=\"\">**선택하세요**</option>";
		
		String optSelected = "";
		
		for(int j=0; j < subjClassMap.keySize("classno"); j++){
			
			if( subjClassMap.getString("classno",j).equals(requestMap.getString("selSubjClass")) ){
				optSelected = "selected";
			}else{
				optSelected = "";
			}
			
			strSubjClassHtml += "	<option value=\"" + subjClassMap.getString("classno",j) + "\" " + optSelected + " >" + subjClassMap.getString("classnm",j) + "</option>";
		}
		strSubjClassHtml += "</select>";
	}
	
	
	// 어학점수입력 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	// 페이징
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	StringBuffer sbListHtml = new StringBuffer();
	String pageStr = "";
	int rowi = 0;
	
	if(listMap.keySize("name") > 0){		
		for(int i=0; i < listMap.keySize("name"); i++){
			
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + (pageNum - i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("name", i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + Util.getValue( listMap.getString("resno", i), "&nbsp;") + "</td>");
			sbListHtml.append("	<td align=\"left\" class=\"tableline_left\">" + listMap.getString("deptnm", i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("jiknm", i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">");
			sbListHtml.append("		<input type=\"text\" name=\"langPoint\" id=\"langPoint1_" + rowi + "\" value=\"" + listMap.getString("langPoint", i) + "\" style=\"width:50px\" dataform=\"num!숫자만 입력해야 합니다.\" maxlength=\"4\" >");			
			sbListHtml.append("		<input type=\"hidden\" name=\"userNo\" id=\"userNo_" + rowi + "\" value=\"" + listMap.getString("userno", i) + "\"    >");
			sbListHtml.append("	</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">");
			sbListHtml.append("		<input type=\"text\" name=\"langPoint2\" id=\"langPoint2_" + rowi + "\" value=\"" + listMap.getString("langPoint2", i) + "\" style=\"width:50px\" dataform=\"num!숫자만 입력해야 합니다.\" maxlength=\"4\" >");
			sbListHtml.append("	</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">");
			sbListHtml.append("		<input type=\"text\" name=\"langPoint3\" id=\"langPoint3_" + rowi + "\" value=\"" + listMap.getString("langPoint3", i) + "\" style=\"width:50px\" dataform=\"num!숫자만 입력해야 합니다.\" maxlength=\"4\" >");
			sbListHtml.append("	</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline21\">");
			sbListHtml.append("		<input type=\"text\" name=\"langPoint4\" id=\"langPoint4_" + rowi + "\" value=\"" + listMap.getString("langPoint4", i) + "\" style=\"width:50px\" dataform=\"num!숫자만 입력해야 합니다.\" maxlength=\"4\" >");
			sbListHtml.append("	</td>");
			sbListHtml.append("</tr>");
			
			rowi ++;
		}
		
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
		
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

	pform.action = "langSubj.do";
	pform.submit();

}

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnSearch();
}

// 저장
function fnSave(){

	var i=0;
	var tmp;
	var tmpi = 0;
	var tmpObjByLangPoint1 = "";
	var tmpObjByLangPoint2 = "";
	var tmpObjByLangPoint3 = "";
	var tmpObjByLangPoint4 = "";
	var tmpObjByUserNo = "";
	
	var dataByLangPoint1 = "";
	var dataByLangPoint2 = "";
	var dataByLangPoint3 = "";
	var dataByLangPoint4 = "";
	var dataByUserNo = "";


	if(NChecker($("pform"))){

		for(i=0; i < pform.elements.length; i++){		
			if(pform.elements[i].name == "userNo"){
									
				tmp = pform.elements[i].id.split("_");
				
				tmpObjByLangPoint1 = "langPoint1_" + tmp[1];
				tmpObjByLangPoint2 = "langPoint2_" + tmp[1];
				tmpObjByLangPoint3 = "langPoint3_" + tmp[1];
				tmpObjByLangPoint4 = "langPoint4_" + tmp[1];
				tmpObjByUserNo = "userNo_" + tmp[1];
												
				if(parseInt(tmpi) == 0){
					dataByLangPoint1 = chkData( tmpObjByLangPoint1 );
					dataByLangPoint2 = chkData( tmpObjByLangPoint2 );
					dataByLangPoint3 = chkData( tmpObjByLangPoint3 );
					dataByLangPoint4 = chkData( tmpObjByLangPoint4 );
					dataByUserNo = $F(tmpObjByUserNo);
				}else{
					dataByLangPoint1 += "|" + chkData( tmpObjByLangPoint1 );
					dataByLangPoint2 += "|" + chkData( tmpObjByLangPoint2 );
					dataByLangPoint3 += "|" + chkData( tmpObjByLangPoint3 );
					dataByLangPoint4 += "|" + chkData( tmpObjByLangPoint4 );
					dataByUserNo += "|" + $F(tmpObjByUserNo);
				}
				
				tmpi += 1;
			
			}
		}
		
		$("dataByLangPoint1").value = dataByLangPoint1;
		$("dataByLangPoint2").value = dataByLangPoint2;
		$("dataByLangPoint3").value = dataByLangPoint3;
		$("dataByLangPoint4").value = dataByLangPoint4;
		$("dataByUserNo").value = dataByUserNo;
		
		if(tmpi > 0){
			if(confirm("저장하시겠습니까 ?")){						
				
				$("mode").value = "save";
				pform.action = "langSubj.do";
				pform.submit();
				
			}
		}else{
			alert("저장할 데이타가 없습니다.");
		}
	}
}

// 입력하지 않은 컬럼은 empty 문자로 대체시킨다.
function chkData(obj){
	if($F(obj).trim() == ""){
		return "empty";
	}else{
		return $F(obj).trim();
	}
}

function fnList(){

	$("mode").value = "list";
	pform.action = "langSubj.do";
	pform.submit();
}

//-->
</script>
<script for="window" event="onload">
<!--



//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 이전화면 검색조건 -->
<input type="hidden" name="commYear" 	id="commYear" 	value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="commGrcode" 	id="commGrcode" value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="commGrseq" 	id="commGrseq"	value="<%= requestMap.getString("commGrseq") %>">

<!-- 이전선택 조건 -->
<input type="hidden" name="grCode" 		id="grCode" 	value="<%= requestMap.getString("grCode") %>">
<input type="hidden" name="grSeq" 		id="grSeq" 		value="<%= requestMap.getString("grSeq") %>">
<input type="hidden" name="subj" 		id="subj"		value="<%= requestMap.getString("subj") %>">

<!-- 페이징 -->
<input type="hidden" name="currPage"	id="currPage"	value="<%= requestMap.getString("currPage")%>">

<!-- 저장데이타  -->
<input type="hidden" name="dataByLangPoint1"	id="dataByLangPoint1"	value="">
<input type="hidden" name="dataByLangPoint2"	id="dataByLangPoint2"	value="">
<input type="hidden" name="dataByLangPoint3"	id="dataByLangPoint3"	value="">
<input type="hidden" name="dataByLangPoint4"	id="dataByLangPoint4"	value="">
<input type="hidden" name="dataByUserNo"		id="dataByUserNo"		value="">



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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>어학점수입력</strong>
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
									<br>
									<%= strTitle %>
									&nbsp;&nbsp;&nbsp;<%= strSubjClassHtml.toString() %><br><br>									
								</td>
							</tr>
							<tr bgcolor="#375694"><td height="2"></td></tr>
						</table>
						
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr><td height="10"></td></tr>
							<tr height="30">
								<td align="right" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<input type="button" value="리스트" onclick="fnList();" class="boardbtn1">
									<input type="button" value="수정" onclick="fnSave();" class="boardbtn1">							
								</td>
							</tr>
							<tr><td height="5"></td></tr>
						</table>
						
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="30" bgcolor="#5071B4">
								<td width="40" align="center" class="tableline11 white"><strong>번호</strong></td>
								<td width="70" align="center" class="tableline11 white"><strong>성명</strong></td>
								<td width="100" align="center" class="tableline11 white"><strong>주민번호</strong></td>
								<td width="170" align="center" class="tableline11 white"><strong>소속기관</strong></td>
								<td width="150" align="center" class="tableline11 white"><strong>직급</strong></td>
								<td width="60" align="center" class="tableline11 white"><strong>1차</strong></td>
								<td width="60" align="center" class="tableline11 white"><strong>2차</strong></td>
								<td width="60" align="center" class="tableline11 white"><strong>3차</strong></td>
								<td width="60" align="center" class="tableline21 white"><strong>4차</strong></td>
							</tr>
							
							<%= sbListHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						
						<!--[s] 페이징 -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#ffffff"><td align="center"><%=pageStr%></td></tr>
						</table>
						<!--[e] 페이징 -->
					
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