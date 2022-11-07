<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	
	String name = (String)request.getAttribute("name");
	String checkyn = (String)request.getAttribute("checkyn");
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LECTURERINFO_LIST");
	listMap.setNullToInitialize(true);
	
	StringBuffer html = new StringBuffer();
	StringBuffer munu = new StringBuffer();
		if(requestMap.getString("mode").equals("lecturerInfoList")){	
		if(listMap.keySize("seqno") > 0){
			munu.append("<thead>");
			munu.append("<tr>");
			munu.append("<th>한자</th>");
			munu.append("<th>이름</th>");
			munu.append("<th>성별</th>");
			munu.append("<th>신청일</th>");
			munu.append("<th>부가정보</th>");
			munu.append("<th>확인여부</th>");
			munu.append("</tr>");
			munu.append("</thead>");
				
			for(int i=0; i < listMap.keySize(); i++){
				html.append("<tr>");
				html.append("<td align=\"center\">"+(listMap.getString("cname", i).equals("") ? "&nbsp" : listMap.getString("cname",i) )+"</td>");
				html.append("<td align=\"center\"><a href=\"javascript:goView('"+listMap.getString("seqno", i)+"');\">"+(listMap.getString("name", i).equals("") ? "&nbsp" : listMap.getString("name",i) )+"</a></td>");
				html.append("<td align=\"center\">"+(listMap.getString("sex", i).equals("") ? "&nbsp" : listMap.getString("sex",i) )+"</td>");
				html.append("<td align=\"center\">"+(listMap.getString("enterdate", i).equals("") ? "&nbsp" : listMap.getString("enterdate",i) )+"</td>");
				html.append("<td align=\"center\">"+(listMap.getString("info", i).equals("") ? "&nbsp" : listMap.getString("info", i) )+"</td>");
				html.append("<td align=\"center\">"+(listMap.getString("checkyn", i).equals("") ? "&nbsp" : listMap.getString("checkyn", i) )+"</td>");
				html.append("</tr>");
			}
		}else{
			html.append("<tr>");
			html.append("<td align=\"center\" colspan=\"100%\" class=\"br0\" style=\"height:100px\">검색된 정보가 없습니다.</td>");
			html.append("</tr>");	
		}
	}

	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("seqno") > 0){
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


<script language="JavaScript">
<!--
	//검색
	function go_search(){
		if(NChecker($("pform"))){
			$("mode").value = "lecturerInfoList";
			$("pform").action = "/tutorMgr/lecturerInfoList.do";				
			$("pform").submit();
		}
	}

	function go_page(page) {
		$("currPage").value = page;
		go_search();
	}

	function goView(seqno) {
		checkYN(seqno);
	}

	function checkYN(seqno) {
		var url = "/tutorMgr/lecturerInfoList.do";
		var pars = "mode=ajaxCheckYN";
		pars += "&seqno="+seqno;

		var myAjax = new Ajax.Request(
			url, 
			{
				method: "post", 
				parameters:pars,
				asynchronous : false,
				onSuccess : function(data){		
					var result = trim(data.responseText);
					if(result == 'no'){
						if(confirm("확인처리되지 않은 데이타 입니다. 확인 처리 하시겠습니까?")) {
							updateYN(seqno);
							go_search();
						}
					} else if(result == 'null'){
						alert("데이터를 조회하는데 실패하였습니다.");
					}
					goPopup(seqno);
				},
				onFailure : function(){
					alert("데이터를 조회하는데 실패하였습니다.");
				}    
			}
		);
	}

	function updateYN(seqno) {
		var url = "/tutorMgr/lecturerInfoList.do";
		var pars = "mode=ajaxUpdateYN";
		pars += "&seqno="+seqno;
		var myAjax = new Ajax.Request(
			url, 
			{
				method: "post", 
				parameters:pars,
				asynchronous : false,
				onSuccess : function(data){		
					var result = trim(data.responseText);
					if(result > 0){
						alert("확인처리 성공");
					}
				},
				onFailure : function(){
					alert("데이터를 조회하는데 실패하였습니다.");
				}    
			}
		);
	}

	function goPopup(seqno) {
		var windowprops = "height=700,width=750,location=no,"
		+ "scrollbars=yes,menubars=no,toolbars=no,resizable=yes";
		var URL = "/tutorMgr/lecturerInfoList.do?mode=viewLecturerInfoPopup&seqno=" + seqno;
		var popup = window.open(URL,"viewPopup",windowprops).focus();
	}
//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" id="menuId" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" id="mode" name="mode"	value="<%= requestMap.getString("mode") %>">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강사출강현황</strong>
					</td>
				</tr>
			</table> 
			<!--[e] subTitle -->
			<div class="space01"></div>
			<!--[s] Contents Form  -->
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									이름
								</th>
								<td width="20%">
									<input type="text" id="name" name="name" value="<%=name%>"/>
								</td>
								<th width="80">
									확인여부
								</th>
								<td>
									<select id="checkyn" name="checkyn" onChange="go_search();">
										<option value="">전체</option>
										<option value="N" <%="N".equals(checkyn) ? "selected='selected'":""%>>미확인</option>
										<option value="Y" <%="Y".equals(checkyn) ? "selected='selected'":""%>>확인완료</option>
									</select>
								</td>
								<td width="120" class="btnr" rowspan="2">
									<input type="button" value="검 색" onclick="go_search();" class="boardbtn1">
								</td>								
							</tr>
						</table>
						<!--//검색 -->
						<div class="space01"></div>

						<!--[s] 리스트  -->
						<table class="datah01">
							<%=munu.toString() %>
							<tbody>
							<%=html.toString() %>
							</tbody>
						</table>
                       <!-- space --><table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable"><tr><td height="10"></td></tr></table>
                       <table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                        	<tr>
                        		<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                        	</tr>
                        </table>
						<!--//[e] 리스트  -->	
					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>                  
        </td>
    </tr>
</table>
<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
</form>
</body>