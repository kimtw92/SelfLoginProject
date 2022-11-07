<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 기관코드관리 리스트
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
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	
	////////////////////////////////////////////////////////////////////////////////////
	 //request 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	String htmlTxt = "";
	StringBuffer contentList = new StringBuffer();
	if(listMap.keySize("partCnt") > 0 && requestMap.getString("mode").equals("list")){
		//기관코드관리 리스트
		contentList.append("	<tr height=\"28\" bgcolor=\"#5071B4\">");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>SEQ</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>기관코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>기관코드명</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>최하위기관코드명</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>Level</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>부서수</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>부서</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>최상위코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>상위코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>인사행정<br>연계여부</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline21 white\"><strong>사용</strong></td>");
		contentList.append("	</tr>");	
		
		for(int i=0;listMap.keySize("partCnt") > i;i++){
	
	        String levels = listMap.getString("levels",i);
	        if(levels.equals("101")){
	        	levels = "시스템관리자";
	        }else if(levels.equals("102")){
	        	levels= "과정운영자";
	        }else if(levels.equals("103")){
	        	levels= "기관담당자";
	        }else if(levels.equals("104")){
	        	levels= "평가담당자";
	        }else if(levels.equals("105")){
	        	levels= "강사관리자";
	        }else if(levels.equals("106")){
	        	levels= "홈페이지관리자";
	        }
			contentList.append("	<tr>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+(pageNum - i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" ><a href=\"javascript:goForm('update','"+listMap.getString("dept",i)+"');\"> "+listMap.getString("dept",i)+"</a></td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("deptnm",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("lownm",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+levels+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("partCnt",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" ><input type=\"button\"class=\"boardbtn1\" onclick=\"goPart('"+listMap.getString("dept",i)+"','"+listMap.getString("deptnm",i)+"');\" value=\"부서관리\"></td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("upper",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("parent",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline21 \" >"+listMap.getString("peoplesystemYn",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline21 \" >"+listMap.getString("useYn",i)+"</td>");
			contentList.append("	<tr>");
		}
	}else if(listMap.keySize("partCnt") <= 0 && requestMap.getString("mode").equals("list")){
		
		//기관코드관리 리스트 데이터가 없을경우 처리
		contentList.append("	<tr height=\"28\" bgcolor=\"#5071B4\">");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>SEQ</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>기관코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>기관코드명</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>최하위기관코드명</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>Level</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>부서수</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>부서</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>최상위<br>코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>상위<br>코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>인사행정<br>연계여부</strong></td>");		
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline21 white\"><strong>사용</strong></td>");
		contentList.append("	</tr>");	
		
		contentList.append("	<tr>");
		contentList.append("		<td height=\"100\" colspan=\"100%\" align=\"center\" class=\"tableline21 \" style=\"border-bottom-width:0px;\">등록된 자료가 없습니다.</td>");
		contentList.append("	<tr>");
	}else if(listMap.keySize("dept") > 0 && requestMap.getString("mode").equals("allDeptCodeList")){
		//전체기관 리스트 데이터
		
		contentList.append("	<tr height=\"28\" bgcolor=\"#5071B4\">");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>SEQ</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>기관코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>기관코드명</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>최하위기관코드명</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>Level</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>최상위<br>코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>상위<br>코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>인사행정<br>연계여부</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline21 white\"><strong>사용</strong></td>");
		contentList.append("	</tr>");
		
		
		for(int i=0;listMap.keySize("dept") > i;i++){
			
	        String levels = listMap.getString("levels",i);
	        if(levels.equals("101")){
	        	levels = "시스템관리자";
	        }else if(levels.equals("102")){
	        	levels= "과정운영자";
	        }else if(levels.equals("103")){
	        	levels= "기관담당자";
	        }else if(levels.equals("104")){
	        	levels= "평가담당자";
	        }else if(levels.equals("105")){
	        	levels= "강사관리자";
	        }else if(levels.equals("106")){
	        	levels= "홈페이지관리자";
	        }
			
			contentList.append("	<tr>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+(pageNum - i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" ><a href=\"javascript:goForm('allDeptUpdate','"+listMap.getString("dept",i)+"');\">"+listMap.getString("dept",i)+"</a></td>");
			
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" ><a href=\"javascript:goInsertDept('insert','"+listMap.getString("dept",i)+"','"+listMap.getString("adeptnm",i)+"','"+listMap.getString("alownm",i)+"','"+listMap.getString("levels",i)+"','"+listMap.getString("upper",i)+"','"+listMap.getString("parent",i)+"','"+listMap.getString("useYn",i)+"','"+listMap.getString("peoplesystemYn",i)+"');\">"+listMap.getString("adeptnm",i)+"</a></td>");
			contentList.append("");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("alownm",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+levels+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("upper",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("parent",i)+"</td>");
			// contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("parent",i)+"</td>");
			
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline21 \" >"+listMap.getString("peoplesystemYn",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline21 \" >"+listMap.getString("useYn",i)+"</td>");
			contentList.append("	<tr>");
		}
	}else if( listMap.keySize("dept") <= 0 && requestMap.getString("mode").equals("allDeptCodeList")){
		//전체 기관코드관리 리스트 데이터가 없을경우 처리

		contentList.append("	<tr height=\"28\" bgcolor=\"#5071B4\">");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>SEQ</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>기관코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>기관코드명</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>최하위기관코드명</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>Level</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>최상위코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>상위코드</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>인사행정<br>연계여부</strong></td>");
		contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline21 white\"><strong>사용</strong></td>");
		contentList.append("	</tr>");
		
		contentList.append("	<tr>");
		contentList.append("		<td height=\"100\" colspan=\"100%\" align=\"center\" style=\"border-bottom-width:0px;\" class=\"tableline21 \" >등록된 자료가 없습니다.</td>");
		contentList.append("	<tr>");
	}
	//모드가 기관코드일경우 버튼의 모드값을  전체 기관코드관리로 준 후 전체 코드관리 리스트로 이동한다.
	String searchType = "";
	//전체 기관코드 리스트일경우 기관코드 리스트로 이동하는 버튼과 기관코드 추가 버튼을 만든다.
	String button = "";
	
	if(requestMap.getString("mode").equals("list")){
		searchType = "<input type=\"button\" name=\"allList\" value=\"전체 기관코드 조회\" class=\"boardbtn1\" onclick=\"go_list('allDeptCodeList')\">";
	}else if(requestMap.getString("mode").equals("allDeptCodeList")){
		htmlTxt += "<tr bgcolor=\"#5071B4\"><td height=\"2\" colspan=\"100%\"></td></tr>";
		htmlTxt += "	<td bgcolor=\"#F7F7F7\" align=\"center\" width=\"100\" class=\"tableline11\" ><strong>기관코드명</strong></td>";
		htmlTxt += "	<td width=\"300\" class=\"tableline21\" style=\"padding-left:10px\"><input type=\"text\" name=\"search\" class=\"textfield\" maxlength=\"15\" onkeypress=\"if(event.keyCode==13){goSearch('allDeptCodeList');return false;}\" value=\""+requestMap.getString("search")+"\">";
		htmlTxt += "		<input type=\"button\"  class=\"boardbtn1\" name=\"allList\" value=\"조회\" onclick=\"goSearch('allDeptCodeList')\"></td>";
		htmlTxt += "	<td class=\"tableline21\">&nbsp;</td>";
		htmlTxt += "<tr bgcolor=\"#5071B4\"><td height=\"2\" colspan=\"100%\"></td></tr>";
		
		
		
		button += "&nbsp;<input type=\"button\" class=\"boardbtn1\" name=\"allList\" value=\"리스트\" onclick=\"go_list('list')\">";
		button += "&nbsp;<input type=\"button\" class=\"boardbtn1\" name=\"allList\" value=\"추가\" onclick=\"goForm('allDeptCodeInsert')\">";
	}
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("dept") > 0){
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
//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//리스트
function go_list(mode){
	
	if(mode != "" && mode != null){
		$("mode").value = mode;
	}else{
		$("mode").value = "<%=requestMap.getString("mode")%>";
	}
	pform.action = "/baseCodeMgr/dept.do";
	pform.submit();

}
//기관코드 폼
function goForm(qu,dept){
	$("mode").value = "form";
	$("dept").value = dept;
	$("qu").value = qu;
	
	pform.action = "/baseCodeMgr/dept.do";
	var popWindow = popWin('about:blank', 'majorPop11', '280', '320', 'no', 'no');
	
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

//선택된 전체 기관 데이터를 기관 데이터로 등록
function goInsertDept(qu, dept, adeptnm, alownm, levels, upper, parent, useYn, peoplesystemYn){
	$("qu").value= qu;
	//기관코드
	$("dept").value=dept;
	
	
	//기관코드명
	$("deptnm").value=adeptnm;
	
	//하위기관코드명
	$("lownm").value=alownm;
	
	//레벨
	$("levels").value=levels;
	
	//최상위코드
	$("upper").value=upper;
	
	//상위코드
	$("parent").value=parent;
	
	//인사행정연계여부
	$("peoplesystemYn").value=peoplesystemYn;
	
	//사용
	$("useYn").value=useYn;
	
	if( confirm('등록 하시겠습니까?')){
		$("mode").value="exec";
		document.pform.action ="/baseCodeMgr/dept.do";
		document.pform.submit(); 
	}
}
//부서관리 페이지 이동
function goPart(dept,deptnm){
	$("mode").value= "partCodeList";
	$("dept").value = dept;
	
	document.pform.action ="/baseCodeMgr/dept.do";
	document.pform.submit(); 
}

//조회
function goSearch(mode){
	$("mode").value = mode;
	$("currPage").value = "";
	if(IsValidCharSearch($("search").value) == false){
	
		return false;
	}
	pform.action = "/baseCodeMgr/dept.do";
	pform.submit();
}

</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="qu"					value=''>

<!-- 선택된 기관정보등록-->
<input type="hidden" name="dept"				value=''>
<input type="hidden" name="deptnm"				value=''>
<input type="hidden" name="lownm"				value=''>
<input type="hidden" name="levels"				value=''>
<input type="hidden" name="upper"				value=''>
<input type="hidden" name="parent"				value=''>
<input type="hidden" name="useYn"				value=''>
<input type="hidden" name="peoplesystemYn"		value=''>

<!-- 웹에디터용 Contents -->
<input type="hidden" name="hidContents" id="hidContents">

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
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong><%=requestMap.getString("mode").equals("allDeptCodeList") ? "전체 " :"" %>기관코드관리 리스트</strong>
					</td>
				</tr>
				
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                        <!---[s] content -->
						
						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<%=htmlTxt %>	
							<tr>
								<td colspan="100%" height="28" align="right"><%=searchType %><%=button%></td>
							</tr>
							<tr bgcolor="#375694">
								<td height="2" colspan="100%"></td>
							</tr>
							<tr>
								<td colspan="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<%= contentList.toString()%>
									</table>
								</td>
							</tr>
							<tr bgcolor="#375694">
								<td height="2" colspan="100%"></td>
							</tr>
						</table>
                        <!---[e] content -->
                       <!-- space --><table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable"><tr><td height="10"></td></tr></table>
                       <table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                        	<tr>
                        		<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                        	</tr>
                        </table>
					</td>
				</tr>
				<!-- space --><tr><td height="10">&nbsp;</td></tr>
				</table>
            <!-- space --><table><tr><td height="30">&nbsp;</td></tr></table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

