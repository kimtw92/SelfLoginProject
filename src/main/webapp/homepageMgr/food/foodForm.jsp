<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 식단관리 폼
// date  : 2008-08-7
// auth  : 정윤철
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
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//리스트
function go_list(){
	$("mode").value = "list";
	pform.action = "/homepageMgr/food.do";
	pform.submit();
}


//등록 체크
function go_check(){
	if($("sDate").value == $("chksDate").value){
		go_modify();
	}else{
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
				
				onComplete : go_chk2,
				onFailure: function(){
					alert("오류가 발생했습니다.");
				}
			}
		);
	}
}


//체크 두번째
function go_chk2(originalRequest){
	var returnValue = trim(originalRequest.responseText);
		
	if(returnValue == 4){
		alert("등록일자는 일주일단위로만 가능합니다.");
		return false;
	}

	if(returnValue == 1){
		alert("등록 시작일은 월요일만 가능합니다.");
		return false;
	}

	if(returnValue == 2){
		alert("등록 마지막일은 금요일만 가능합니다.");
		return false;
	}
	
	
	
	
	var url = "/homepageMgr/food.do";
	var pars = "mode=ajaxCountChechk&sDate="+$F("sDate")+"&gubun="+$("gubun").value;
	var divId = "";
	
	var myAjax = new Ajax.Request(
		//{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			
			onComplete : go_save,
			onFailure: function(){
				alert("오류가 발생했습니다.");

			}
		}
	);
		
}
//저장
function go_save(originalRequest){
	
	var returnValue = trim(originalRequest.responseText);
	if($F("qu") != "modify" ){
		if(returnValue > 0){
			alert("중복된데이터가 있어서 등록이 불가능합니다.");	
			return false;
			
		}
	}
	
	
	if(NChecker($("pform"))){
		if($("qu").value == "insert"){
			if( confirm('등록하시겠습니까?')){
				$("mode").value="exec";	
				pform.action = "/homepageMgr/food.do";
				pform.submit();
			
			}
		}else{
			if( confirm('수정하시겠습니까?')){
				$("qu").value = "deleteInsert";
				$("mode").value="exec";	
				pform.action = "/homepageMgr/food.do?mode=exec";
				pform.submit();
			}
		}
	}
}

//식단 수정
function go_modify(){
	if( confirm('수정하시겠습니까?')){
		$("qu").value = "deleteInsert";
		$("mode").value="exec";	
		pform.action = "/homepageMgr/food.do";
		pform.submit();
	}
}


//식단관리 삭제
function go_delete(){
	if( confirm('삭제하시겠습니까?')){
		$("mode").value="exec";
		$("qu").value="delete";
		pform.action = "/homepageMgr/food.do";
		pform.submit();
	}
}

//로딩시.
onload = function()	{
	//셀렉티드
	var gubun = "<%=listMap.getString("gubun")%>";
	len = $("gubun").options.length
	
	for(var i=0; i < len; i++) {
		if($("gubun").options[i].value == gubun){
			$("gubun").selectedIndex = i;
		 }
 	 }
}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
<input type="hidden" name="qu"			value="<%= requestMap.getString("qu") %>">
<input type="hidden" name="chksDate"			value="<%= requestMap.getString("sDate") %>">
<input type="hidden" name="chkeDate"			value="<%= requestMap.getString("eDate") %>">

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

			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- date -->
						<table  class="dataw01">
							<tr>
								<th style="border-left:0px solid #E5E5E5;" width="150">기간</th>
								<td style="border-right:0px solid #E5E5E5;">
							 		<input type="text" size="10" name="sDate" required="true!기간을 입력하십시오." readonly class="textfield" value="<%=requestMap.getString("sDate")%>">
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','sDate');" src="../images/icon_calen.gif" alt="" />
									~
							 		<input type="text" size="10" name="eDate" required="true!기간을 입력하십시오." readonly class="textfield" value="<%=requestMap.getString("eDate")%>">
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','eDate');" src="../images/icon_calen.gif" alt="" />
									<span class="txt_99">일주일 단위로 선택할 수 있습니다.</span>
								</td>
							</tr>
							<tr>
								<th>구분</th>
								<td>
									<select name="gubun">
										<option value="1">아침</option>
										<option value="2">점심</option>
										<option value="3">저녁</option>
									</select>
								</td>
							</tr>							
							<tr>
								<th style="border-left:0px solid #E5E5E5;">월</th>
								<td style="border-right:0px solid #E5E5E5;">
									<textarea class="textarea01" style="width:98%;" required="true!월요일 메뉴를 입력하십시오." name="content"><%=listMap.getString("content",0) %></textarea>
								</td>
							</tr>
							<tr>
								<th style="border-left:0px solid #E5E5E5;">화</th>
								<td style="border-right:0px solid #E5E5E5;">
									<textarea class="textarea01" style="width:98%;" required="true!화요일 메뉴를 입력하십시오." name="content"><%=listMap.getString("content",1) %></textarea>
								</td>
							</tr>
							<tr>
								<th style="border-left:0px solid #E5E5E5;">수</th>
								<td style="border-right:0px solid #E5E5E5;">
									<textarea class="textarea01" style="width:98%;" required="true!수요일 메뉴를 입력하십시오." name="content"><%=listMap.getString("content",2) %></textarea>
								</td>
							</tr>
							<tr>
								<th style="border-left:0px solid #E5E5E5;">목</th>
								<td style="border-right:0px solid #E5E5E5;">
									<textarea class="textarea01" style="width:98%;" required="true!목요일 메뉴를 입력하십시오." name="content"><%=listMap.getString("content",3) %></textarea>
								</td>
							</tr>
							<tr>
								<th style="border-left:0px solid #E5E5E5;">금</th>
								<td style="border-right:0px solid #E5E5E5;">
									<textarea class="textarea01" style="width:98%;" required="true!금요일 메뉴를 입력하십시오." name="content"><%=listMap.getString("content",4) %></textarea>
								</td>
							</tr>
						</table>
						<!-- //date -->

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="저장" onclick="go_check();" class="boardbtn1">
									<%if(requestMap.getString("qu").equals("modify")){ //수정페이지일때 삭제 %>
									<input type="button" value="삭제" onclick="go_delete();" class="boardbtn1">
									<%} %>
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->
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