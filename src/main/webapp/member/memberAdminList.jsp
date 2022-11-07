<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 특수권한관리
// date : 2008-06-04
// auth : 정윤철
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
	
	//셀렉트박스 데이터
	DataMap selectBoxMap = (DataMap)request.getAttribute("SELECTBOX_DATA");
	selectBoxMap.setNullToInitialize(true);
	
		//셀렉트박스 데이터
	DataMap selectDeptCodeListMap = (DataMap)request.getAttribute("SELECTDEPT_DATA");
	selectDeptCodeListMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	String selDept = (String)request.getAttribute("SELDEPT");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize() > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	StringBuffer option  = new StringBuffer();
	if(selectBoxMap.keySize("gadmin") > 0){
		for(int i = 0; selectBoxMap.keySize("gadmin") > i; i++){
			option.append("<option value=\""+selectBoxMap.getString("gadmin",i)+"\">"+selectBoxMap.getString("gadminnm",i)+"</option>");
		}
	}else if(selectBoxMap.keySize("gadmin") <= 0){
		option.append("<option value=\"\">권한이 없습니다.</option>");
	}
	
	StringBuffer option2  = new StringBuffer();
	String selected = "";
	if(selectDeptCodeListMap.keySize("dept") > 0){
		for(int i = 0; selectDeptCodeListMap.keySize("dept") > i; i++){
			selected = selectDeptCodeListMap.getString("dept",i).equals(selDept) ? "selected='selected'":"";
			option2.append("<option "+ selected +" value=\""+selectDeptCodeListMap.getString("dept",i)+"\">"+selectDeptCodeListMap.getString("deptnm",i)+"</option>");
		}
	}else if(selectDeptCodeListMap.keySize("dept") <= 0){
		option2.append("<option value=\"\">권한이 없습니다.</option>");
	}
	
	StringBuffer html = new StringBuffer();
	
	if(listMap.keySize("userno") > 0){
		for(int i =0; listMap.keySize("userno")> i; i++){
			String[] mem = listMap.getString("mem",i).split("[|]");
			html.append("<tr bgcolor = \"#FFFFFF\" align='center'>");
			html.append("	<td height = 25 class=\"tableline11\" align=\"center\">"+(pageNum - i)+"</td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+listMap.getString("gadminnm",i)+"</td>");

			html.append("	<td class=\"tableline11\" align=\"center\">"+mem[0]+"</td>");
			
			String mem1 = "";
			String mem2 = "";
			try{
				if( !mem[1].trim().equals("") || mem[1].trim() != null){
					for(int j =0; listMap.keySize() > j;j++){
						mem1 = mem[1];
					}
				}
				
				if( !mem[2].trim().equals("") || mem[2].trim() != null){
					for(int j =0; listMap.keySize() > j;j++){
						mem2 = mem[2];
					}	
				}
				
				
			}catch(Exception e){
				mem1 = "";
				mem2 = "";
			}
			html.append("	<td class=\"tableline11\" align=\"center\">" + mem1 + "</td>");

			
			html.append("	<td class=\"tableline11\" align=\"center\">"+mem2+"</td>");
			
			html.append("	<td class=\"tableline11\" align=\"center\">"+listMap.getString("jiknm",i)+"</td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+listMap.getString("partnm",i)+"</td>");
			
			if(listMap.getString("gadmin").equals("C")){
				html.append("	<td class=\"tableline11\" align=\"center\">"+listMap.getString("partnm",i)+"</td>");
			}else{
				html.append("	<td class=\"tableline11\" align=\"center\">"+listMap.getString("deptnm",i)+"</td>");
			}
			html.append("	<td class=\"tableline11\" align=\"center\"><input type=\"button\" class=boardbtn1 onclick=\"goPop('adminFormPop','"+listMap.getString("userno",i)+"')\" value=\"조회\"></td>");
			html.append("	<td class=\"tableline21\" align=\"center\">");
			html.append("		<input type=\"button\" class=boardbtn1 onclick= \"javascript:goDel('adminExec','"+listMap.getString("userno",i)+"','"+listMap.getString("gadmin", i)+"','"+listMap.getString("dept",i)+"');\" value=\"삭제\">");
			html.append("	</td>");
			html.append("</tr>");
		}
	}else if(listMap.keySize("userno") <= 0){
		html.append("<tr bgcolor = \"#FFFFFF\" align='center'>");
		html.append("	<td height =\"100\" class=\"tableline21\" align=\"center\" colspan=\"100%\">검색된 내용이 없습니다.</td>");
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
function go_list(search){
	$("mode").value = "adminList";
	
	if($("keyword").value!="" ){
		$("selGadmin").value="";
	}
	if(search == "search"){
		$("currPage").value = "";
		if(IsValidCharSearch($("keyword").value) == false){
	
		return false;
		}		
	}
	

	pform.action ="/member/member.do";
	pform.submit();
}

//셀렉박스 체인지 리스트
function chAdminMode(){
	$("keyword").value = "";
	$("currPage").value = "";
	$("mode").value = "adminList";
	pform.action ="/member/member.do";
	pform.submit();
}

//특수권한자 이력현황
function goPop(mode,userno){
	
	$("mode").value = "adminFormPop";
	if(userno == null || userno == ""){
		$("userno").value = "";
	}else{
		$("userno").value = userno;
	}
	pform.action = "/member/member.do";
	var popWindow = popWin('about:blank', 'majorPop11', '680', '600', 'auto', 'auto');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";

}
//출력
function report_print() {
  params = 'init_mode=view';
  popAI("http://152.99.42.130/report/report_82.jsp?p_gadmin=<%=requestMap.getString("selGadmin")%>");
}

//특수권한자 등록폼이동
function goForm(mode){
	$("mode").value = mode;
	pform.action ="/member/member.do";
	pform.submit();
}

//특수권한 삭제
function goDel(mode,userno,gadmin,dept){
	$("mode").value = mode;
	$("userno").value = userno;
	$("gadmin").value = gadmin;
	$("dept").value = dept;
	$("qu").value = "deleteAdmin";
	if( confirm('권한을  삭제하시겠습니까?')){
		pform.action ="/member/member.do";
		pform.submit();	
	}
	
	
}
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" value="adminList">

<input type="hidden" name="userno" value="">
<input type="hidden" name="gadmin" value="">
<input type="hidden" name="dept" value="">
<input type="hidden" name="qu" value="">

<!-- 특수자 이력현황조회시 유저번호가 필요하다 -->
<input type="hidden" name="userno" value="adminList">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>특수권한관리</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                        <!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="95%" border="0" cellpadding="0" cellspacing="0" style = "margin-left:10">
							<tr>
								<td colspan="100%" align="right" class="tableline21">
									<input type = button class = "boardbtn1" value = "특수권한자 이력현황" onClick = "goPop('adminFormPop')">
									<input type = "button" onClick="goForm('adminForm');" class = "boardbtn1" value = "추가">
								  	<input type="button" class="boardbtn1" value="출력" onclick="report_print();">
								</td>
							</tr>
							<tr height="2" bgcolor="#5071B4">
								<td colspan="100%"></td>
							</tr>
							<tr>
							  	<td width="10%"  bgcolor="#F7F7F7" class="tableline11" align="center"><strong> 권한 : </strong></td>
							  	<td width="10%" class="tableline21" style="padding-left:10px">
							  		<select name="selGadmin" onChange = "chAdminMode();" >
							  			<option value="">전체</option>
							  			<%=option.toString() %>
							  			<option value='7'>강사</option>
							 		</select>
							 	</td>
							 	<td width="100" bgcolor="#F7F7F7" class="tableline11" align="center"><strong>담당기관 : </strong></td>
							 	<td width="" class="tableline11">
							  		<select name="selDept" onChange = "chAdminMode();" >
							  			<option value="">전체</option>
							  			<%=option2.toString() %>
							 		</select>
							 	</td>
							 	<td width="100" bgcolor="#F7F7F7" class="tableline11" align="center"><strong>이름검색 : </strong></td>
								<td align="right" style="padding:0 0 0 0" width="150" class="tableline21"> <input type="text" class="textfield" maxlength="8" name="keyword" value="<%=requestMap.getString("keyword") %>" onkeypress="if(event.keyCode==13){go_list('search');return false;}" size="8"> <input type="button"  onclick="go_list('search')" value="검색" class="boardbtn1">
								</td>
							</tr>
							<tr height="2" bgcolor="#5071B4">
								<td colspan="100%"></td>
							</tr>
							<tr height="10">
								<td colspan="100%"></td>
							</tr>
							
							</table>
							<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#E5E5E5" style = "margin-left:10;margin-top:10">
							  <tr>
								<td height="2" colspan="100%" bgcolor="#375694"></td>
							  </tr>
							  <tr bgcolor="#5071B4" align = center>
							  	<td height = 28 class="tableline11 white" ><b>연번</td>
							  	<td class="tableline11 white"><b>권한</td>
							  	<td class="tableline11 white"><b>성명</td>
							  	<td class="tableline11 white"><b>생년월일</td>
							  	<td class="tableline11 white"><b>소속기관</td>
							  	<td class="tableline11 white"><b>직급</td>
							  	<td class="tableline11 white"><b>담당부서</td>
							  	<td class="tableline11 white"><b>담당기관</td>
							  	<td class="tableline11 white"><b>권한이력</td>
							  	<td class="tableline11 white"><b>삭제</td>
							  </tr>
							  <%=html.toString() %>
								<tr>
									<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
								</tr>
							</table>
							 <!-- space --><table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable"><tr><td height="10"></td></tr></table>
							<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                        		<tr>
                        			<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                        		</tr>
                        		<tr>
								  	<td colspan ="100%" align = "right">
								  	  
								  	</td>
								  </tr>
                        	</table>
                        <!---[e] content -->
					</td>
				</tr>
				<tr>
					<td height="30">&nbsp;</td>
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
<script language="JavaScript">
    document.write(tagAIGeneratorOcx);
    
    //현재 권한 리스트 선택
 	var gadmin = "<%=requestMap.getString("selGadmin")%>";
 	gadminLen = $("selGadmin").options.length;
	 for(var i=0; i < gadminLen; i++) {
	     if($("selGadmin").options[i].value == gadmin){
	      	$("selGadmin").selectedIndex = i;
		 }
 	 }
</script>





