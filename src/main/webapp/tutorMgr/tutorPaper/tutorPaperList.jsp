<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사원고관리 리스트
// date : 2008-08-04
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
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	

	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");

	//페이징 String
	String pageStr = "";
	if(listMap.keySize("grcode") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	//컨텐츠
	StringBuffer html = new StringBuffer();
	if(listMap.keySize("grseq") > 0 ){
		for(int i=0; listMap.keySize("grseq") > i; i++){
			html.append("<tr>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+(pageNum -i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("name",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("grseq",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("grcodenm",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("lecnm",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("pDate",i)+"</td>");
			html.append("	<td height=\"28\" class=\"tableline11\" align=\"center\">"+listMap.getString("pCnt",i) +"</td>");
			html.append("	<td height=\"28\" class=\"tableline21\" align=\"center\"><a href=\"javascript:go_delete('"+listMap.getString("grcode", i)+"', '"+listMap.getString("grseq", i)+"', '"+listMap.getString("subj", i)+"', '"+listMap.getString("tuserno", i)+"')\">삭제</a></td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("	<td colspan=\"100%\" height=\"300\" align=\"center\"> 등록된 데이터가 없습니다. </td>");
		html.append("</tr>");
		
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
function go_list(){
	$("mode").value="tutorPaperList";	
	pform.action = "/tutorMgr/tutorPaper.do";
	pform.submit();
}

//월요일과 금요일 체크, 특수문자 체크
function go_dateCheck(){
	//특수문자 체크
	if(IsValidCharSearch($("name").value) == false){
		$("name").value="";
		$("name").focus();
		return false;
	}
	
	if($("sDate").value == ""){
		alert("시작 날짜를 선택하여 주십시오.");
		return false;
	}
	
	if($("eDate").value == ""){
		alert("마지막 날짜를 선택하여 주십시오.");
		return false;
	}
	
	if($("eDate").value < $("sDate").value){
		alert("마지막일자가 시작일자보다 낮을순 없습니다. 다시 선택 하여주십시오.");
		return false;
	}
	
	var url = "/tutorMgr/tutorPaper.do";
	var pars = "mode=ajaxDateChechk&sDate="+$F("sDate")+"&eDate="+$F("eDate");
	var divId = "";
	
	var myAjax = new Ajax.Request(
		//{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			
			onComplete : go_search,
			onFailure: function(){
				alert("오류가 발생했습니다.");
			}
		}
	);
}

//검색시
function go_search(originalRequest){
	var returnValue = trim(originalRequest.responseText);
	if(returnValue == "1"){
		alert("시작날짜는 월요일만 선택가능합니다.	");
		return;
	}
	
	if(returnValue == "2"){
		alert("마지막날짜는 금요일만 선택가능합니다.");
		return;
	}
	
	$("currPage").value = "";
	$("mode").value="tutorPaperList";	
	pform.action = "/tutorMgr/tutorPaper.do";
	pform.submit();
}

//강의원고 삭제
function go_delete(grcode, grseq, subj, tuserno){
	$("grcode").value = grcode;
	$("grseq").value = grseq;
	$("subj").value = subj;
	$("tuserno").value = tuserno;

	if( confirm('삭제하시겠습니까?')){
		$("mode").value="exec";	
		$("qu").value="delete";	
		pform.action = "/tutorMgr/tutorPaper.do";
		pform.submit();
	}
}


//강의원고 등록
function go_insert(){
	$("mode").value="tutorPaperForm";	
	pform.action = "/tutorMgr/tutorPaper.do";
	pform.submit();
}

</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<!-- 삭제시 가져갈정보 -->
<input type="hidden" name="grcode">
<input type="hidden" name="grseq">
<input type="hidden" name="subj">
<input type="hidden" name="tuserno">

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

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강사원고관리</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                    
                    <!-- search[s] -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									성명
								</th>
								<td width="150">
									<input type="text" name="name" class="textfield" onkeypress="if(event.keyCode==13){go_dateCheck();}" value="<%=requestMap.getString("name") %>">
								</td>
								<th width="80">
									검색 기간 
								</th>
								<td width="300">
									<input type="text" class="textfield" name="sDate" value="<%=requestMap.getString("sDate")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','sDate');" src="../images/icon_calen.gif" alt="" />
									~
									<input type="text" class="textfield" name="eDate" value="<%=requestMap.getString("eDate")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','eDate');" src="../images/icon_calen.gif" alt="" />
								</td>
								<td width="100" class="btnr" rowspan="0">
									<input type="button" value="검색" onclick="go_dateCheck();" class="boardbtn1">
									<input type="button" value="등록" onclick="go_insert();" class="boardbtn1">
								</td>
							</tr>
						</table>
                    <!-- search[e] -->
                    					
					<!---[s] content -->
					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						  <tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						  </tr>
						<tr bgcolor="#5071B4">
						  <td height="28" width="50" align="center" class="tableline11 white" ><strong>번호</strong></td>
						  <td class="tableline11 white" align="center"><strong>강사명</strong></td>
						  <td class="tableline11 white" align="center"><strong>과정기수</strong></td>
						  <td class="tableline11 white" align="center"><strong>과정명</strong></td>
						  <td class="tableline11 white" align="center"><strong>과목명</strong></td>
						  <td class="tableline11 white" align="center"><strong>원고제출일</strong></td>
						  <td class="tableline11 white" align="center"><strong>원고장수</strong></td>
 						  <td class="tableline21 white" align="center"><strong>기능</strong></td>
						</tr>
						<%=html.toString() %>
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
						</tr>
                    </table>
                    
                     <!---[e] content -->
                     <!---[s] content --><table width="100%" height="10"><tr><td></td></tr></table>
                   	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                   		<tr>
                   			<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                   		</tr>
                   	</table>
                   <!-- sapce[s] -->	<table height="50"><tr><td></td></tr></table>
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

