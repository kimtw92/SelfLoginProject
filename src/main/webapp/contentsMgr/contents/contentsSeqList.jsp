<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 콘텐츠 관리 - 회차 리스트
// date : 2008-09-03
// auth : LYM
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

	//과목 정보
	DataMap subjMap = (DataMap)request.getAttribute("SUBJ_ROW_DATA");
	subjMap.setNullToInitialize(true);
	

	//과목의 등록된 회차 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	String tmpStr2 = "";
	for(int i=0; i < listMap.keySize("subj"); i++){

		listStr.append("\n<tr>");

		//회차
		listStr.append("\n	<td>" + listMap.getString("dates", i) + "</td>");
		//과목명
		listStr.append("\n	<td>" + listMap.getString("orgTitle", i) + "</td>");

		//강사가 아닌경우
		if(!memberInfo.getSessCurrentAuth().equals("7")){
			//미리보기
			tmpStr = "<a href=\"javascript:go_contentPreview('"+listMap.getString("subj", i)+"', '"+listMap.getString("ctId", i)+"', '"+listMap.getString("orgDir", i)+"', '"+listMap.getString("orgDirName", i)+"', 'N', '"+listMap.getString("menuyn", i)+"', '"+listMap.getString("skinId", i)+"', '"+listMap.getString("lcmsWidth", i)+"', '"+listMap.getString("lcmsHeight", i)+"', '"+listMap.getString("orgId", i)+"')\">[보기]</a>";
			listStr.append("\n	<td>" + tmpStr + "</td>");
			
			//맛보기유무
			if(listMap.getString("previewYn", i).equals("Y")){
				tmpStr2 = "예";
				tmpStr = "N";
			}else{
				tmpStr2 = "아니오";
				tmpStr = "Y";
			}
			tmpStr = "<a href=\"javascript:go_ajax('"+listMap.getString("orgSeq", i)+"', '" + tmpStr + "')\">" + tmpStr2 + "</a>";
			listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");
			
		//강사인 경우
		} else {
			//미리보기
			tmpStr = "<a href=\"javascript:go_contentPreview('"+listMap.getString("subj", i)+"', '"+listMap.getString("ctId", i)+"', '"+listMap.getString("orgDir", i)+"', '"+listMap.getString("orgDirName", i)+"', 'N', '"+listMap.getString("menuyn", i)+"', '"+listMap.getString("skinId", i)+"', '"+listMap.getString("lcmsWidth", i)+"', '"+listMap.getString("lcmsHeight", i)+"', '"+listMap.getString("orgId", i)+"')\">[보기]</a>";
			listStr.append("\n	<td class=\"br0\">" + tmpStr + "</td>");
		}

		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("subj") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' class='br0' style='height:100px'>등록된 회차가 없습니다.</td>");
		listStr.append("\n</tr>");

	}

	

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--



//Ajax 함수를 사용하고 리로딩 되는 함수
function go_reload(){

	$("mode").value = "seq_list";

	pform.action = "/contentsMgr/contents.do";
	pform.submit();

}


//리스트
function go_list(){

<%
	if(requestMap.getString("retType").equals("subj")){
		// 과목코드화면에서 넘어왔을경우
%>
		$("mode").value = "list";
		pform.action = "/baseCodeMgr/subj.do";
		pform.submit();
<%
	}else{
		//콘텐트관리일경우
		if( !requestMap.getString("retType").equals("lecture") ){
%>
		$("mode").value = "list";
		$("qu").value = "";
		$("subj").value = "";
	
		pform.action = "/contentsMgr/contents.do";
		pform.submit();
<%
		//강사의 콘텐츠 보기 일경우
		}else{
%>
		$("mode").value = "selectLecturerList";
		pform.action = "/contentsMgr/contents.do";
		pform.submit();
<%			
		}
	}
%>

}


//맛보기 설정
function go_ajax(orgSeq, previewYn){

	var objAjax = new Object();
	objAjax.url = "/contentsMgr/contents.do";
	objAjax.pars = "mode=ajax_exec&qu=preview"+"&previewYn="+ previewYn +"&orgSeq="+ orgSeq;
	objAjax.aSync = true; 
	objAjax.targetDiv = "";
	objAjax.successMsg = "설정 되었습니다.";
	objAjax.successFunc = "go_reload();";

	go_ajaxCommonObj(objAjax); //Ajax 통신.

}

//미리보기
/**
 * var url = "/lcms/lecture/lecture_frame.jsp?subj=" + subj + "&ctId=" + ctId + "&orgDir=" + orgDir + "&orgDirname=" + orgDirname + "&review=" + review + "&menuYn=" + menuYn + "&skinId=" + skinId;
 * popWin(url, "pop_lcmsContentPreview", lcmsWidth, lcmsHeight, "0", "1");
 * 변경전 >>> go_contentPreview(subj, ctId, orgDir, orgDirname, review, menuYn, skinId, lcmsWidth, lcmsHeight)
 * 변경전  >>> go_contentPreview('NUY0000216', '100002033', '19055', '19055', 'N', 'N', '', '1024', '768')
 * 변경후 >>> openLecture(ctId, orgId, orgDir, orgDirName,width,height,topFrame,frameHeight,leftFrame)
 * 변경후 >>> openLecture('100002033','DUNET_O_ccda313f-2f78-4cc6-9de1-7f0fa6667727','19055', '19055','1024','768','0','50','0');" value=미리보기 type=button name=idcheck>
 */
function go_contentPreview(subj, ctId, orgDir, orgDirName, review, menuYn, skinId, width, height, orgId){
		//hwani. 임시변수. DB에서 가져오도록 수정
		var topFrame    = '0';
		var leftFrame   = '0';
		var frameHeight = '50';
		
		var url = "/lcms/lecture/lecture.jsp";
		var windowName = "contentWindow";		
		
		var option = "top=0, left=0,";
		if(width != null && width != "") {
			option += " width="+width+","
		} else {
			option += " width=1100,"
		}
		
		if(height != null && height != "") {
			option += " height="+height;
		} else {
			option += " height=700"
		}		
		
		//alert("ctId:"+ctId);
		//alert("orgId:"+orgId);
		//alert("orgDir:"+orgDir);
		//alert("orgDirname:"+orgDirName);
		
		url += "?ctId=" + ctId + "&orgId=" + orgId + "&orgDir=" + orgDir + "&orgDirName=" + orgDirName+"&UserId=admin&UserName=admin&topFrame="+topFrame+"&frameHeight="+frameHeight+"&leftFrame="+leftFrame;
		
		window.open(url, windowName, option);		
	

}


//로딩시.
onload = function()	{


}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">
<input type="hidden" name="searchValue"			value="<%= requestMap.getString("searchValue") %>">
<input type="hidden" name="qu"					value="<%= requestMap.getString("qu") %>">

<input type="hidden" name="subj"				value="<%= requestMap.getString("subj") %>">
<!-- 강사권한자의 콘텐츠보기에서는 년도, 과정코드, 과정기수정보가 필요하기때문에 히든값으로 값을 받는다. [s]-->
<input type="hidden" name="commYear"				value="<%= requestMap.getString("commYear") %>">
<input type="hidden" name="commGrcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="commGrseq"				value="<%= requestMap.getString("commGrseq") %>">

<!-- 강사권한자의 콘텐츠보기에서는 년도, 과정코드, 과정기수정보가 필요하기때문에 히든값으로 값을 받는다. [e]-->

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




			<div class="h10"></div>
			<!-- subTitle
			<div class="tit01">
				<h2 class="h2"><img src="../images/bullet003.gif">과정기수관리 리스트</h2>
			</div>
			// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>


						<div class="tit0101">
						  <img src="/images/bullet003.gif"> <b>과목명 : <%= subjMap.getString("subjnm") %></b>
						</div>
						<div class="txtr">
						  <input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
						</div>
						<div class="h5"></div>

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>회차</th>
								<th>회차명</th>
								<%-- 현재 권한이 강사가 아닐경우에만 맛보기 유무가 보임--%>
								<%if(!memberInfo.getSessCurrentAuth().equals("7")){ %>
								<th>미리보기</th>
								<th class="br0">맛보기유무</th>
								<%}else{ %>
								<th class="br0">미리보기</th>
								<%} %>
							</tr>
							</thead>

							<tbody>
							<%= listStr.toString() %>
							</tbody>
						</table>

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->
						<div class="space01"></div>
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

