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

	// 년도 그릅
	DataMap yearMap = (DataMap)request.getAttribute("LIST_YEAR");

	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	String yyyy = (String) request.getAttribute("yyyy");
	////////////////////////////////////////////////////////////////////////////////////
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script type="text/javascript">
<!--

function goSelectList() {
	location.href = "/courseMgr/reservation.do?mode=holyday&yyyy=" + $F("yyyy");
}

function goUpdate(key) {
	if(confirm("관리번호 "+key+"번을 수정 하시겠습니까?")) {
		var url = "/courseMgr/reservation.do";
		var pars = "mode=updateHolyDayAjaxAction";
		pars += "&holyday_key="+key;
		pars += "&update_holyday=" + $F("update_holyday_"+key);
		pars += "&update_holyday_name=" + $F("update_holyday_name_"+key);
		var myAjax = new Ajax.Request(
			url, 
			{
				method: "post", 
				parameters:pars,
				onSuccess : function(data){		
					var result = trim(data.responseText);
					if(result == 'ok'){
						alert("수정 되었습니다.");
						goSelectList();
						return;
					} else if(result == 'check'){
						alert("중복되는 공휴일 입니다.");
						return;
					}
					alert("수정중 에러가 발생 했습니다. 관리자에게 문의해 주세요.");
				},
				onFailure : function(){
					alert("데이터를 조회하는데 실패하였습니다.");
				}    
			}
		);
	}
}

function goDelete(key) {
	if(confirm("관리번호 "+key+"번을 삭제 하시겠습니까?")) {
		var url = "/courseMgr/reservation.do";
		var pars = "mode=deleteHolyDayAjaxAction";
		pars += "&holyday_key="+key;
		var myAjax = new Ajax.Request(
			url, 
			{
				method: "post", 
				parameters:pars,
				onSuccess : function(data){		
					var result = trim(data.responseText);
					if(result == 'ok'){
						alert("삭제 되었습니다.");
						goSelectList();
						return;
					}
					alert("삭제중 에러가 발생 했습니다. 관리자에게 문의해 주세요.");
				},
				onFailure : function(){
					alert("데이터를 조회하는데 실패하였습니다.");
				}    
			}
		);
	}
}

function goSave() {
	if($F("save_holyday") == "") {
		alert("공휴일을 선택해주세요.");
		$("save_holyday").focus();
		return;
	}
	if($F("save_holyday_name").replace(/ /g,'') == "") {
		alert("공휴일명을 입력해주세요.");
		$("save_holyday_name").focus();
		return;
	}
	if(confirm("공휴일을 저장 하시겠습니까?")) {
		var url = "/courseMgr/reservation.do";
		var pars = "mode=saveHolyDayAjaxAction";
		pars += "&save_holyday="+$F("save_holyday");
		pars += "&save_holyday_name="+$F("save_holyday_name");
		var myAjax = new Ajax.Request(
			url, 
			{
				method: "post", 
				parameters:pars,
				onSuccess : function(data){		
					var result = trim(data.responseText);
					if(result == 'ok'){
						alert("저장되었습니다.");
						goSelectList();
						return;
					} else if(result == 'check'){
						alert("중복되는 공휴일 입니다.");
						return;
					}
					alert("저장중 에러가 발생 했습니다. 관리자에게 문의해 주세요.");
				},
				onFailure : function(){
					alert("데이터를 조회하는데 실패하였습니다.");
				}    
			}
		);
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
            <table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td rowspan="3" width="6" style="background:#FFFFFF URL(/images/bg_navi.gif) repeat-y" nowrap></td>
					<td height="1" bgcolor="#E3E3E3"></td>
				</tr>	
				<tr>
					<td bgcolor="#F5F5F5" height="33" align="right" class="font1" style="padding-right:10px"><a href="http://lsc1019.loti.incheon/index/sysAdminIndex.do?mode=sysAdmin">HOME</a>> <A HREF="/homepageMgr/board.do?&menuId=1-1-1">홈페이지관리</A> > <A HREF="/">시설임대관리</A> > <A HREF="/courseMgr/reservation.do?mode=holyday">시설임대공휴일관리</A>
					</td>
				</tr>
				<tr>
					<td height="1" bgcolor="#E3E3E3"></td>
				</tr>
			</table>   
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="commonTitleTable">
				<tr>
					<td height="22">
						<img src="/images/bullet_title.gif" width="5" height="14" align="middle">&nbsp;
						<font color="#00689F" style="font-weight:bold">시설임대 공휴일관리 </font>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr><td height="2" bgcolor="#00AF9C" ></td></tr>
							<tr><td height="2" bgcolor="#D9D9D9" ></td></tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<!--[e] 타이틀 -->

			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>시설임대 공휴일관리</strong>
						&nbsp;&nbsp;&nbsp;&nbsp;<strong><font color="blue">[매년초 음력 공휴일 및 임시공휴일 반드시 확인바랍니다.]</font></strong>
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
						<form id="regform" name="regform">
						<select id="yyyy" name="yyyy" style="padding-top:20px;" onchange="goSelectList();">
							<%
								for(int i=0; i < yearMap.keySize(); i++){
							%>
								<option value="<%=yearMap.getString("yyyy",i)%>" <%=yyyy.equals(yearMap.getString("yyyy",i)) ? "selected='selected'":""%>><%=yearMap.getString("yyyy",i)%></option>
							<%
								}	
							%>
							
						</select> 년
						<table class="datah01" style="margin-top:5px;">
							<thead>
							<tr>
								<th>관리번호</th>
								<th>공휴일</th>
								<th>공휴일명</th>
								<th class="br0">수정여부</th>
							</tr>
							</thead>
							<tbody>
							<%
								if(listMap.keySize() == 0) {
							%>
									<tr>
										<td colspan="4">검색된 데이타가 없습니다.</td>
									</tr>
							<%
								} else {
									for(int i=0; i < listMap.keySize(); i++){
							%>
										<tr>
											<td><%=listMap.getString("holydayKey", i)%></td>
											<td>
												<input type="text" class="textfield" id="update_holyday_<%=listMap.getString("holydayKey", i)%>" name="update_holyday_<%=listMap.getString("holydayKey", i)%>" onclick="fnPopupCalendar('regform', this);" readonly="readonly" style="text-align:center;" maxlength="8" value="<%=listMap.getString("holyday", i)%>"/>
											</td>
											<td><input type="text" id="update_holyday_name_<%=listMap.getString("holydayKey", i)%>" name="update_holyday_name_<%=listMap.getString("holydayKey", i)%>" class="textfield" style="text-align:center;" value="<%=listMap.getString("holydayName", i)%>" /></td>
											<td><a href='javascript:goUpdate("<%=listMap.getString("holydayKey", i)%>");'>수정</a> | <a href='javascript:goDelete("<%=listMap.getString("holydayKey", i)%>");'>삭제</a></td>
										</tr>
							<%
									}
								}
							%>
							</tbody>
						</table>
						</form>
						<form id="saveform" name="saveform">
						<table class="datah01" style="margin-top:20px;">
							<thead>
							<tr>
								<th>관리번호</th>
								<th>공휴일</th>
								<th>공휴일명</th>
								<th class="br0">수정여부</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td>자동생성</td>
									<td>
										<input type="text" class="textfield" id="save_holyday" name="save_holyday" onclick="fnPopupCalendar('saveform', this);" readonly="readonly" style="text-align:center;" maxlength="8" />
										<a href = "javascript:fnPopupCalendar('saveform', document.saveform.save_holyday);">
											<img src="/images/skin1/icon/icon_cal01.gif" class="vp2" alt="달력" /> 
										</a> (예 : 20110101)
									</td>
									<td><input type="text" id="save_holyday_name" name="save_holyday_name" maxlength="30" style="text-align:center;" onKeypress="if(event.keyCode==13) {goSave();}"/></td>
									<td><input type="button" class="boardbtn1" value=" 공휴일추가 " onClick="goSave();" /></td>
								</tr>
							</tbody>
						</table>
						</form>
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

