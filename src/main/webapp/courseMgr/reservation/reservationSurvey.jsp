<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시설예약관리
// date  : 2008-
// auth  : 양정환
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	/** 필수 코딩 내용 */
	// 로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    // navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);

	
	DataMap listMap = null;
	try {
		listMap = (DataMap)request.getAttribute("RESERVATION_LIST");
		listMap.setNullToInitialize(true);
	} catch(Exception e) {
		
	}
	

	int sumCnt = listMap.getInt("sumCnt", 0);
	double  floatAve = 0;
	
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
	function listOpenPopup(listnum) {
		var w = window.open("/courseMgr/reservation.do?mode=reservationSurveyDetail&listnum=" + listnum, "listOpenPopup", "directories=yes,toolbar=yes,left=400,top=100,width=400,height=800");
	}
</script>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>설문관리</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
					<tr>
						<td colspan="100%">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr bgcolor="#5071B4"><td height="2" colspan="100%"></td></tr>
								<tr height="28" bgcolor="F7F7F7" >
									<td width="80" align="center" class="tableline11"><strong>설문 내용</strong></td>
		
									</td>				
								</tr>
								<tr bgcolor="#5071B4"><td height="2" colspan="100%"></td></tr>
							</table>
						</td>
					</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>				
					<td>
						<table class="datah01">
							<thead>
							<tr>
								<th>설문 인원</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td  width="25%">단위 ( 명 )</td>
								</tr>
								<tr>
									<td><font color="red" size="6"><%=sumCnt%></font></td>
								</tr>
							</tbody>
						</table>
						<table class="datah01">
							<thead>
							<tr>
								<th>질문 1</th>
								<th colspan="3" style="text-align:left; padding-left:5px;">귀하께서는 인재개발원 시설개방 사용하는것을 어떻게 알게 되었습니까?</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td  width="25%">문항</td>
									<td  width="25%">지문</td>
									<td  width="25%">응답자수</td>
									<td  width="25%">비율</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt11", 0));
								%>
								<tr>
									<td>1</td>
									<td>인재개발원 홈페이지</td>
									<td><%=listMap.getString("cnt11", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt12", 0));
								%>
								<tr>
									<td>2</td>
									<td>반상회보</td>
									<td><%=listMap.getString("cnt12", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt13", 0));
								%>
								<tr>
									<td>3</td>
									<td>동아리 회원</td>
									<td><%=listMap.getString("cnt13", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt14", 0));
								%>
								<tr>
									<td>4</td>
									<td>아는사람 소개</td>
									<td><%=listMap.getString("cnt14", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
							</tbody>
						</table>
						<table class="datah01">
							<thead>
							<tr>
								<th>질문 2</th>
								<th colspan="3" style="text-align:left; padding-left:5px;">귀하께서 사용(이용)하신 시설은?</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td  width="25%">문항</td>
									<td  width="25%">지문</td>
									<td  width="25%">응답자수</td>
									<td  width="25%">비율</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt21", 0));
								%>
								<tr>
									<td>1</td>
									<td>체육관</td>
									<td><%=listMap.getString("cnt21", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt22", 0));
								%>							
								<tr>
									<td>2</td>
									<td>강의실</td>
									<td><%=listMap.getString("cnt22", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt23", 0));
								%>
								<tr>
									<td>3</td>
									<td>강당</td>
									<td><%=listMap.getString("cnt23", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt24", 0));
								%>
								<tr>
									<td>4</td>
									<td>잔디구장</td>
									<td><%=listMap.getString("cnt24", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt25", 0));
								%>
								<tr>
									<td>5</td>
									<td>테니스장</td>
									<td><%=listMap.getString("cnt25", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt26", 0));
								%>
								<tr>
									<td>6</td>
									<td>생활관(숙소)</td>
									<td><%=listMap.getString("cnt26", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
							</tbody>
						</table>
						<table class="datah01">
							<thead>
							<tr>
								<th width="25%">질문 3</th>
								<th colspan="3" style="text-align:left; padding-left:5px;">귀하께서 시설을 사용하신 날은 언제 입니까?</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td  width="100%" colspan="3">객관식 <font color="blue">[<a href="javascript:listOpenPopup(3);">목록보기</a>]</font></td>
								</tr>
							</tbody>
						</table>
						<table class="datah01">
							<thead>
							<tr>
								<th>질문 4</th>
								<th colspan="3" style="text-align:left; padding-left:5px;">시설 및 환경에 만족하였습니까?</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td  width="25%">문항</td>
									<td  width="25%">지문</td>
									<td  width="25%">응답자수</td>
									<td  width="25%">비율</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt41", 0));
								%>
								<tr>
									<td>1</td>
									<td>매우만족</td>
									<td><%=listMap.getString("cnt41", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt42", 0));
								%>
								<tr>
									<td>2</td>
									<td>만족</td>
									<td><%=listMap.getString("cnt42", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt43", 0));
								%>
								<tr>
									<td>3</td>
									<td>보통</td>
									<td><%=listMap.getString("cnt43", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt44", 0));
								%>
								<tr>
									<td>4</td>
									<td>불만족</td>
									<td><%=listMap.getString("cnt44", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt45", 0));
								%>
								<tr>
									<td>5</td>
									<td>매우 불만족</td>
									<td><%=listMap.getString("cnt45", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
							</tbody>
						</table>
						<table class="datah01">
							<thead>
							<tr>
								<th>질문 5</th>
								<th colspan="3" style="text-align:left; padding-left:5px;">시설 사용료에 대하여는 어떻게 생각하십니까?</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td  width="25%">문항</td>
									<td  width="25%">지문</td>
									<td  width="25%">응답자수</td>
									<td  width="25%">비율</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt51", 0));
								%>
								<tr>
									<td>1</td>
									<td>저렴하다</td>
									<td><%=listMap.getString("cnt51", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt52", 0));
								%>
								<tr>
									<td>2</td>
									<td>적당하다</td>
									<td><%=listMap.getString("cnt52", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt53", 0));
								%>
								<tr>
									<td>3</td>
									<td>비싸다</td>
									<td><%=listMap.getString("cnt53", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt54", 0));
								%>
								<tr>
									<td>4</td>
									<td>많이 비싸다</td>
									<td><%=listMap.getString("cnt54", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt55", 0));
								%>
								<tr>
									<td>5</td>
									<td>기타(가격) <font color="blue">[<a href="javascript:listOpenPopup(5);">목록보기</a>]</font></td>
									<td><%=listMap.getString("cnt55", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
							</tbody>
						</table>
						<table class="datah01">
							<thead>
							<tr>
								<th>질문 6</th>
								<th colspan="3" style="text-align:left; padding-left:5px;">시설 이용시 인재개발원 직원 지원(서비스)에 만족 하였습니까?</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td  width="25%">문항</td>
									<td  width="25%">지문</td>
									<td  width="25%">응답자수</td>
									<td  width="25%">비율</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt61", 0));
								%>
								<tr>
									<td>1</td>
									<td>매우만족</td>
									<td><%=listMap.getString("cnt61", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt62", 0));
								%>
								<tr>
									<td>2</td>
									<td>만족</td>
									<td><%=listMap.getString("cnt62", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt63", 0));
								%>
								<tr>
									<td>3</td>
									<td>보통</td>
									<td><%=listMap.getString("cnt63", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt64", 0));
								%>
								<tr>
									<td>4</td>
									<td>불만족</td>
									<td><%=listMap.getString("cnt64", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt65", 0));
								%>
								<tr>
									<td>5</td>
									<td>매우 불만족</td>
									<td><%=listMap.getString("cnt65", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
							</tbody>
						</table>
						<table class="datah01">
							<thead>
							<tr>
								<th>질문 7</th>
								<th colspan="3" style="text-align:left; padding-left:5px;">기회가 된다면 다음에도 인재개발원 시설을 사용하실 계획입니까?</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td  width="25%">문항</td>
									<td  width="25%">지문</td>
									<td  width="25%">응답자수</td>
									<td  width="25%">비율</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt71", 0));
								%>
								<tr>
									<td>1</td>
									<td>꼭 이용하겠다</td>
									<td><%=listMap.getString("cnt71", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt72", 0));
								%>
								<tr>
									<td>2</td>
									<td>이용하겠다</td>
									<td><%=listMap.getString("cnt72", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt73", 0));
								%>
								<tr>
									<td>3</td>
									<td>생각해보겠다</td>
									<td><%=listMap.getString("cnt73", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
								<%
									floatAve = Math.round(100.0/sumCnt*listMap.getInt("cnt74", 0));
								%>
								<tr>
									<td>4</td>
									<td>이용하지 않겠다</td>
									<td><%=listMap.getString("cnt74", 0)%></td>
									<td><%=floatAve%>%</td>
								</tr>
							</tbody>
						</table>
						<table class="datah01">
							<thead>
							<tr>
								<th width="25%">질문 8</th>
								<th colspan="3" style="text-align:left; padding-left:5px;">시설(물) 사용에 대한 건의 및 개선사항(불편하셨던 점이나 시정했으면 하는 점을 구체적으로 작성하여 주시면 감사 하겠습니다)</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td  width="100%" colspan="3">객관식 <font color="blue">[<a href="javascript:listOpenPopup(8);">목록보기</a>]</font></td>
								</tr>
							</tbody>
						</table>
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
</body>