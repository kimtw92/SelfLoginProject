<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시설대여신청 직권입력
// date  : 2009-04-20
// auth  : 최석호
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//request 데이터
	//DataMap resultMap = (DataMap)request.getAttribute("LIST_DATA");
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	StringBuffer listHtml  = new StringBuffer();
	int number=1;
	for(int i=0; i < listMap.keySize("menucd"); i++){
		
		listHtml.append("<tr>");
		listHtml.append("<td>"+ (number++) +"</td>");
		listHtml.append("<td>" + listMap.getString("menunm", i) + "</td>");
		listHtml.append("<td>");
		listHtml.append("<select id=\""+listMap.getString("menucd", i)+"_YN\" name=\"useyn\">");
		
		//사용 option
		listHtml.append("<option value=\"Y\"");
		if("Y".equals(listMap.getString("useYn", i))) {
			listHtml.append(" selected=\"selected\"");
		}
		listHtml.append(">사용</option>");
		
		//미사용 option
		listHtml.append("<option value=\"N\"");
		if("N".equals(listMap.getString("useYn", i))) {
			listHtml.append(" selected=\"selected\"");
		}
		listHtml.append(">미사용</option>");
		
		listHtml.append("</td>");
		listHtml.append("<td><a href=\"javascript:go_modify('"+listMap.getString("menucd",i)+"')\">수정</a></td>");
		listHtml.append("</tr>");
	}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script type="text/javascript">
<!--
//수정
function go_modify(menucd) {

	var useYn   = document.getElementById(menucd + "_YN").value;	//셀렉트박스 사용여부 값
	var mode    = document.getElementById("mode").value;			//mode

	if(confirm("수정 하시겠습니까?")) {
		var url="/courseMgr/reservation.do?mode="+mode+"&menucd="+menucd+"&useyn="+useYn;
		location.href = url;		
	} else {
		return;
	}
}
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form id="pform" name="pform" method="post">

<input type="hidden" id="mode" name="mode" value="useModify">
<input type="hidden" name="menucd" value="" alt="메뉴코드">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap="nowrap"><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap="nowrap"><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>시설임대 사용여부</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr><td>&nbsp;</td></tr>
				<!-- 리스트  -->
				<tr>				
					<td>
						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th>메뉴명</th>
								<th>사용여부</th>
								<th class="br0">수정</th>
							</tr>
							</thead>
							<tbody>
							<%= listHtml %>
							</tbody>
						</table>
					</td>
				</tr>
				<!-- //리스트  -->
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

