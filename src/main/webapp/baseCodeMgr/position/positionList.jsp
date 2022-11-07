<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 직급코드관리 리스트
// date : 2008-05-14
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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	DataMap listMap = (DataMap)request.getAttribute("POSITION_LIST_DATA");
	listMap.setNullToInitialize(true);
	
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//직급코드관리 리스트 
	StringBuffer contentList = new StringBuffer();
	if(listMap.keySize("jik") > 0 ){
		for(int i=0; listMap.keySize("jik") > i; i++) {
			contentList.append("<tr>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(pageNum - i)+"</strong></td>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(!listMap.getString("jik",i).equals("") ? listMap.getString("jik",i) : "&nbsp")+"</td>");
			if(listMap.getString("jikGubun",i).equals("1")){
				contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">인천광역시</td>");
				
			}else if(listMap.getString("jikGubun",i).equals("2")){
				contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">공사/공단</td>");
				
			}else{
				contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">&nbsp;	</td>");
				
			}
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"left\" style=\"padding-left:10px\">"+(!listMap.getString("jiknm",i).equals("") ? listMap.getString("jiknm",i) : "&nbsp")+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(!listMap.getString("jikjnm",i).equals("") ? listMap.getString("jikjnm",i) : "&nbsp")+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(!listMap.getString("jikrnm",i).equals("") ? listMap.getString("jikrnm",i) : "&nbsp")+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(!listMap.getString("jiklnm",i).equals("") ? listMap.getString("jiklnm",i) : "&nbsp")+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(!listMap.getString("dogsnm",i).equals("") ? listMap.getString("dogsnm",i) : "&nbsp")+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline11\" align=\"center\">"+(!listMap.getString("useYn",i).equals("") ? listMap.getString("useYn",i) : "&nbsp")+"</td>");
			contentList.append("		<td height=\"28\" class=\"tableline21\" align=\"center\"><input type=\"button\" value=\"수정\" onclick=\"go_form('modify','"+listMap.getString("jik",i)+"','"+listMap.getString("jiknm",i)+"','"+listMap.getString("jikjnm",i)+"','"+listMap.getString("jikrnm",i)+"','"+listMap.getString("dogsnm",i)+"','"+listMap.getString("useYn",i)+"','"+listMap.getString("jikGubun",i)+"')\" class=\"boardbtn1\"></td>");
			contentList.append("</tr>");
		}
	}else{
		contentList.append("	<tr>");
		contentList.append("		<td colspan=\"100%\" class=\"tableline21\" align=\"center\" height=\"100\"> 등록된 자료가 없습니다. </td>");
		contentList.append("	</tr>");
	}
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("jik") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
	//리스트
	function go_list(){
		$("mode").value = "list";
		pform.action = "/baseCodeMgr/position.do";
		pform.submit();
	}
	//조회
	function goSearch(){
		$("mode").value = "list";
		$("currPage").value = "";
		if(IsValidCharSearch($("search").value) == false){
		
			return false;
		}
		pform.action = "/baseCodeMgr/position.do";
		pform.submit();
	}
	
	//페이지 이동
	function go_page(page) {
		$("currPage").value = page;
		go_list();
	}	
	
	
	//팝업 폼
	function go_form(qu, jik, jiknm, jikjnm, jikrnm, dogsnm, useYn, jikGubun){
		$("mode").value = "form";
		$("qu").value = qu;
		
		if(qu == "modify"){
			$("jik").value = jik;
			$("jiknm").value = jiknm;
			$("jikjnm").value = jikjnm;
			$("jikrnm").value = jikrnm;
			$("dogsnm").value = dogsnm;
			$("useYn").value = useYn;
			$("jikGubun").value = jikGubun;
		}
		var popWindow = popWin('about:blank', 'majorPop11', '320', '340', 'auto', 'no');
		pform.action = "/baseCodeMgr/position.do";
		pform.target = "majorPop11";
		pform.submit();
		pform.target = "";
	}
	

	//일괄등록
	function goAllInsert(){
		$("mode").value = "uploadForm";
		var popWindow = popWin('about:blank', 'majorPop11', '700', '340', 'auto', 'no');
		pform.action = "/baseCodeMgr/position.do";
		pform.target = "majorPop11";
		pform.submit();
		pform.target = "";
		
	}
	
	
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" action="">

	<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
	<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
	<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
	
	<input type="hidden" name="qu">
	<!-- 직급코드 -->
	<input type="hidden" name="jik" value="">
	<!-- 계급 -->
	<input type="hidden" name="jiknm">
	<!-- 직렬 -->
	<input type="hidden" name="jikjnm">
	<!-- 직류 -->
	<input type="hidden" name="jikrnm">
	<!-- 직종 -->
	<input type="hidden" name="dogsnm">
	<!-- 사용여부 -->
	<input type="hidden" name="useYn">
	<!-- 구분 -->
	<input type="hidden" name="jikGubun">
	
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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>직급코드 관리 리스트</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->
			
			
			<!-- buuton[s] -->
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsTable">
				<tr>
					<td colspan="3">
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="">
							<tr>
								<td align="right" >
									<input type="button" onClick="go_form('insert');"  value="개별입력" class="boardbtn1">&nbsp;&nbsp;
									<input type="button" onClick="goAllInsert('allInsert');"  value="일괄입력" class="boardbtn1">&nbsp;&nbsp;
									<input type="button" onClick="fnGoFileDown('jik.xls', '/excel/');"  value="업로드파일 서식 다운로드" class="boardbtn1">
								</td>
							</tr>
							<tr>
							<tr>
								<td height="2" bgcolor="#5071B4" ></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" style="padding:0 0 0 0" cellpadding="0" class="contentsTable">
							<tr>
								<td class="tableline11">&nbsp;</td>
								<td width="100" bgcolor="#F7F7F7" class="tableline11" align="center"><strong>직급명 검색</strong></td>
								<td height="28" width="230" class="tableline11" style="padding-left:10px" align="left">
									<input type="text" name="search" class="textfield" maxlength="10" onkeypress="if(event.keyCode==13){goSearch();return false;}" value="<%=requestMap.getString("search") %>">
								</td>
								<td width="50" align="center">
									<input type="button" onClick="goSearch();" onkeyPress="goSearch();" value="조회" class="boardbtn1">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr>
					<td colspan="100%">
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
							<tr>
								<td height="2" bgcolor="#5071B4" style="width:85%" ></td>
							</tr>
							<tr>
								<td height="2"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<!-- buuton[e] -->
			
			
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                        <!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694">
								<td height="2" colspan="100%"></td>
							</tr>
							
							<tr bgcolor="#5071B4">
								<td height=28 align="center" class="tableline11 white"><strong>번호</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>직급코드</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>구분</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>직급명</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>직종</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>직렬</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>직류</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>계급</strong></td>
								<td height="28" align="center" class="tableline11 white" ><strong>사용여부</strong></td>
								<td height="28" align="center" class="tableline21 white" ><strong>기능선택</strong></td>
							</tr>
								<%=contentList.toString() %>
							<tr bgcolor="#375694">
								<td height="2" colspan="100%"></td>
							</tr>	
						</table>
						
                        <!---[e] content -->
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<!-- pageing[s] -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td colspan="8" align="center">
						<%=pageStr %>
					</td>
				</tr>
			</table>
			<!-- pageing[e] -->
			<!-- space --><table><tr><td height="30">&nbsp;</td></tr></table>                         
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>






