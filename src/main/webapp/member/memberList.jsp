<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 학적부관리 리스트
// date : 2008-05-29
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
	
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	DataMap selectBoxMap = (DataMap)request.getAttribute("SELECTBOX_DATA");
	selectBoxMap.setNullToInitialize(true);
	
	DataMap totalMemberMap = (DataMap)request.getAttribute("TOTALMEMBER_DATA");
	totalMemberMap.setNullToInitialize(true);
	
	DataMap idCountMap = (DataMap)request.getAttribute("IDCOUNT_DATA");
	totalMemberMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize() > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	String html = "";

	if(listMap.keySize("name") > 0 ){
		for(int i=0; listMap.keySize("name") > i; i++){
			html += "<tr>";
			html += "	<td class=\"tableline11\" height = 25 align=\"center\">"+(pageNum - i)+"</td>";
			html += "	<td class=\"tableline11\" align=\"center\"><a href=\"javascript:goUser('"+listMap.getString("userno",i)+"', 'member');\">";
			html += listMap.getString("name",i).equals("") ? "&nbsp" : listMap.getString("name",i);
			html +="</a></td>";
			html += "<td class=\"tableline11\" align=\"center\">"+listMap.getString("userId",i)+"&nbsp;</td>";
			html += "	<td class=\"tableline11\" align=\"center\">";
			html += 	listMap.getString("birthdate",i).equals("") ? "&nbsp" : listMap.getString("birthdate",i) ;
			html += "	</td>";
			html += "	<td class=\"tableline11\" align=\"center\">";
			
			
			if(!listMap.getString("jiknmfrom",i).equals("") && listMap.getString("jiknm",i).equals("")){
				
				html += listMap.getString("jiknmfrom",i);
			}else if(listMap.getString("jiknmfrom",i).equals("") && !listMap.getString("jiknm",i).equals("")){
				html += listMap.getString("jiknm",i);
			}else{
				html += "&nbsp;";	
			}
			
			html +=	"	</td>";
			html += "	<td class=\"tableline11\" align=\"center\">" ;
			html += 	listMap.getString("deptnm",i).equals("") ? "&nbsp" : listMap.getString("deptnm",i);
			html += "	</td>";
			html += "	<td class=\"tableline11\" align=\"center\">";
			html += 	listMap.getString("deptsub",i).equals("") ? "&nbsp" : listMap.getString("deptsub",i);
			html += "	</td>";
			html += "	<td class=\"tableline11\" align=\"center\">";
			html += 	listMap.getString("officeTel",i).equals("") ? "&nbsp" : listMap.getString("officeTel",i);
			html += "	</td>";
			html += "	<td class=\"tableline21\" align=\"center\">";
			html +=  	listMap.getString("hp",i).equals("") ? "&nbsp" : listMap.getString("hp",i);
			html += "	</td>";
			html += "	<td class=\"tableline21\" align=\"center\">";
			html +=  	listMap.getString("lgfailcnt",i).equals("") ? "&nbsp" : listMap.getString("lgfailcnt",i);
			html += "	</td>";
			html += "	<td class=\"tableline21\" align=\"center\">";
			html +=  	listMap.getString("deleteyn",i).equals("") ? "&nbsp" : listMap.getString("deleteyn",i);
			html += "	</td>";
			html += "</tr>";
		}
	}else{
		html += "<tr>";
		html += "	<td colspan=\"100%\" height=\"100\" align=\"center\">";
		html += "	등록된 데이터가 없습니다.";
		html += "	</td>";
		html += "</tr>";
	}

	
	String selectHtml = "";
	
	for(int i=0; selectBoxMap.keySize() > i ;i++ ){
		selectHtml += "<option value=\""+selectBoxMap.getString("dept",i)+"\">"+selectBoxMap.getString("deptnm",i)+"</option>";
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


function go_search(){
	//검색 

	if(IsValidCharSearch($("name").value) == false){
		return false;
	}
	
	if(IsValidCharSearch($("birthdate").value) == false){
		return false;
	}

	if(IsValidCharSearch($("userid").value) == false){
		return false;
	}

	if(IsValidCharSearch($("email").value) == false){
		return false;
	}
	
	$("currPage").value = "";
	go_list();
}

//리스트
function go_list(){
	
	$("mode").value = "list";
	pform.action ="/member/member.do";
	pform.submit();
}



//사용자 정보 페이지 이동
function goUser(userNo, qu){
	
	$("mode").value = "form";
	$("userNo").value = userNo;
	$("qu").value = qu;

	pform.action = "/member/member.do";
	pform.submit();

}


</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="userNo"				value="<%=requestMap.getString("userNo")%>">
<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">
<!-- 부서명 -->
<input type="hidden" name="deptsub" 			value="<%=requestMap.getString("deptsub") %>">
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>계정관리</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			
			
			<!-- [s] 버튼 셀렉트 박스 영역 -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
							<tr>
								<td height="2" bgcolor="#5071B4" style="92%" ></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="100%">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td class="tableline11" bgcolor="#F7F7F7" width="80" align="center"><strong>기관선택 : </strong></td>
								<td class="tableline11" style="padding-left:10px;"> <select name="dept"><option value="">-- 선택하세요 --</option><%=selectHtml %></select> </td>
								<td class="tableline11" width="50" bgcolor="#F7F7F7" align="center"><strong>이름 : </strong></td>
								<td class="tableline11" style="padding-left:10px;"> <input type="text" id="name" name="name" maxlength="15" class="textfield" onkeypress="if(event.keyCode==13){go_search();return false;}" value="<%=requestMap.getString("name") %>"> </td>
								<td class="tableline11" bgcolor="#F7F7F7" align="center"><strong>생년월일 : </strong></td>
								<td class="tableline11" style="padding-left:10px;"><input type="text" id="birthdate" name="birthdate" maxlength="8" class="textfield" onkeypress="if(event.keyCode==13){go_search();return false;}" value="<%=requestMap.getString("birthdate") %>"></td>
								<td rowspan="2" class="tableline21" align="center"><input class="boardbtn1" type="button" onClick="go_search();" value="확인"></td>
							</tr>
							<tr>
								<td class="tableline11" bgcolor="#F7F7F7" align="center"><strong>아 이 디 : </strong></td>
								<td class="tableline11" style="padding-left:10px;"><input type="text" id="userid" name="userid" class="textfield" onkeypress="if(event.keyCode==13){go_search();return false;}" value="<%=requestMap.getString("userid") %>"></td>
								<td class="tableline11" bgcolor="#F7F7F7" align="center"><strong>이메일 : </strong></td>
								<td class="tableline11" style="padding-left:10px;"><input type="text" id="email" name="email" class="textfield" onkeypress="if(event.keyCode==13){go_search();return false;}" value="<%=requestMap.getString("email") %>"></td>
								<td class="tableline11" bgcolor="#F7F7F7" align="center"><strong>구분 :</strong></td>
								<td class="tableline11" colspan="3">
									<input type="radio" value="" name="auth" <%=requestMap.getString("checked") %>>일반
									<input type="radio" name="auth" value="5" <%=requestMap.getString("checked5") %>>강사
									<input type="radio" name="auth" value="10" <%=requestMap.getString("checked10") %>>학적부
								</td>
							 </tr>
						</table>
					</td>
					
					
					
				</tr>
				<tr>
					<td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
							<tr>
								<td height="2" bgcolor="#5071B4" style="92%" ></td>
							</tr>
							<tr>
								<td height="2"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr><td height="10"></td></tr>
			</table>
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
										
                        <!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
							<table width="100%" height="10" cellspacing="0" cellpadding="0" border="0" width="100%" >
								<tr>
									<td colspan="100%" width="100%" align="right">검색수 : <%= listMap.getString("count").equals("") ? "0" :  listMap.getString("count")%> 명 / 전체회원수 : <%=totalMemberMap.getString("mcnt") %>명 (ID발급: <%=idCountMap.getString("idCnt") %>명)</td>
								</tr>
								<tr bgcolor="#375694">
									<td height="2" colspan="100%"></td>
								</tr>
							
								<tr bgcolor="#5071B4">
									<td height="25" class="tableline11 white" align="center"><b>번호</td>
									<td width="60" class="tableline11 white"  align="center"><b>성명</td>
									<td width="60" class="tableline11 white"  align="center"><b>아이디</td>
									<td class="tableline11 white" align="center"><b>생년월일</td>
									<td class="tableline11 white" align="center"><b>직급</td>
									<td class="tableline11 white"" align="center"><b>기관</td>
									<td class="tableline11 white" align="center"><b>부서</td>
									<td class="tableline11 white" align="center"><b>사무실전화</td>
									<td class="tableline11 white" align="center"><b>휴대전화</td>
									<td class="tableline11 white" align="center"><b>로그인실패횟수</td>
									<td class="tableline11 white" align="center"><b>탈퇴여부</td>
								</tr>
									<%=html%>
							</table>
                        <!---[e] content -->
                        	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
								<tr>
									<td height="2" bgcolor="#375694" style="92%" ></td>
								</tr>
								<tr>
									<td height="2"></td>
								</tr>
							</table>
                        <!-- space --><table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable"><tr><td height="10"></td></tr></table>

                       		<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                        		<tr>
                        			<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                        		</tr>
                        	</table>
                        	<!-- space --><table><tr><td height="30">&nbsp;</td></tr></table>
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

<SCRIPT LANGUAGE="JavaScript">
//기관 셀렉티드
var dept = "<%=requestMap.getString("dept")%>";	
deptLen = $("dept").options.length
for(var i=0; i < deptLen; i++) {
    if($("dept").options[i].value == dept){
     	$("dept").selectedIndex = i;
	 }
}


</SCRIPT>




