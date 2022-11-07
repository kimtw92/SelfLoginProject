<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 수료증 HTML 등록 / 수정 폼
// date : 2008-06-04
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


	//개인공지 상세 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

	String content =  "     " + StringReplace.convertHtmlEncodeNamo2( rowMap.getString("content") );

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--


//리스트
function go_view(){

	$("mode").value = "view";
	$("qu").value = "";

	pform.action = "/courseMgr/resultHtml.do";
	pform.submit();

}

//수정 naver
function go_modify(){

// 	var wc = $("Wec");
// 	$("content").value = trim(wc.TextValue); //나모 폼 체크를하기 위해 값을 가져온다.
	var contents = getContents(); // naver 에디터에서 컨텐츠를 가지고 온다.

// 	if($F("content") == "" || $F("content") == " "){
	if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
		alert("내용을 입력하세요");
		return;
	}

	if(confirm("수정 하시겠습니까?")){

// 		$("content").value = wc.MIMEValue; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
		$("content").value = contents;
		
		$("mode").value = "exec";
		$("qu").value = "update";
		pform.action = "/courseMgr/resultHtml.do?mode=exec";
		pform.submit();

	}

}

//로딩시.
onload = function()	{

}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>
<input type="hidden" name="no"					value='<%=requestMap.getString("no")%>'>

<input type="hidden" name="title" value="<%=rowMap.getString("title")%>">

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


			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->
						<div class="space01"></div>

						<!--안내 문구-->
						<h2 class="h2">안내. 다음의 값들의 이름은 바꾸면 안됨.</h2>		
						<ol class="coment01">
							<li>
									{수료번호} : 수강생의 수료번호 ex) 505<br>
									{소속기관} : 수강생의 기관 ex) 인천광역시 중구<br>
									{상세기관} : 수강생의 상세기관 ex) 용유출장소 <br>
									{직급명} : 직급명 ex) 지방행정서기 <br>
									{성명} : 이름 ex)홍 길 동 <br>

									{년도} : 과정년도 ex) 2008 <br>
									{기수} : 과정기수 ex) 제1기 <br>
									{과정명} : 과정명 ex) 신규채용자과정 <br>

									{교육시작일} : 교육시작일 ex) 2008.03.12 <br>
									{교육종료일} : 교육종료일 ex) 03.18 <br>

									{현재일자} : 오늘일자 ex) 2008년 08월 26일 <br>
									{교육원장명} : 교육원장명 ex) 홍길동 <br>
							</li>
						</ol>
						<!--//안내 문구-->
						<div class="space01"></div>


						<!-- date -->
						<table  class="btn01">
<!-- 
							<tr bgcolor="#FFFFFF">
								<td width="15%" height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>제목</strong></td>
								<td width="85%" class="tableline21" align="left" >&nbsp;
									<input type="text" class="textfield" name="title" value="<%=rowMap.getString("title")%>" style="width:50%">
								</td>
							</tr>

							<tr bgcolor="#FFFFFF">
								<td width="15%" height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>사용유무</strong></td>
								<td width="85%" class="tableline21" align="left" >&nbsp;
									<input type="radio" class="chk_01" name="useYn" id="useYn1" value="Y" <%=rowMap.getString("useYn").equals("Y") ? "checked" : ""%>><label for="useYn1">Yes</label>
									<input type="radio" class="chk_01" name="useYn" id="useYn2" value="N" <%=!rowMap.getString("useYn").equals("Y") ? "checked" : ""%>><label for="useYn2">No</label>
								</td>
							</tr>
-->

							<tr bgcolor="#FFFFFF">
								<td align="left" colspan="2">
									<!-- Namo Web Editor용 Contents -->
									<input type="hidden" name="content" id="content" value="     <%= content%>">

								<jsp:include page="/se2/SE2.jsp" flush="true" >
									<jsp:param name="contents" value="<%= content%>"/>
								</jsp:include>
								</td>
							</tr>
						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="right">
								<%if(requestMap.getString("qu").equals("update")){%>
									<input type="button" class="boardbtn1" value=' 수정 ' onClick="go_modify();" >
								<%}%>
									<input type="button" class="boardbtn1" value=' 취소 ' onClick="go_view();" >
								</td>
							</tr>
						</table>

						<!---[e] content -->
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->

			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

