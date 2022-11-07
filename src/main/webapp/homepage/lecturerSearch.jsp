<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr"%>
<%@ page import="ut.lib.util.* "%>
<%@ page import="ut.lib.support.* "%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
<%
	String name = Util.getValue(request.getParameter("name"), "");
	String birth1 = Util.getValue(request.getParameter("birth1"), "");
	String birth2 = Util.getValue(request.getParameter("birth2"), "");
	String birth3 = Util.getValue(request.getParameter("birth3"), "");
	String password = Util.getValue(request.getParameter("password"), "");
	DataMap listMap = null;
	try {
		listMap = (DataMap)request.getAttribute("LECTURER_LIST");
		listMap.setNullToInitialize(true);
	} catch(Exception e) {
		
	}
%>

<div id="subContainer">
	<div class="subNavi_area">
		<jsp:include page="/homepage_new/inc/left7.jsp" flush="true" ></jsp:include>
	</div>
	<div id="contnets_area">
		<div class="sub_visual7">홈페이지 이용안내</div>
		<div class="local">
			<h2>강사등록조회</h2>
			<div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 홈페이지 이용안내 &gt; <span>강사등록조회</span></div>
		</div>
		<div class="contnets">
			<!-- contnet -->
			<div id="content">
				<div class="h30"></div>
				<form id="pform" name="pform" method="post" action="">
				<input type="hidden" id="mode" name="mode" value="lecturerSearch">
				<table class="dataW01">		
				<tr>
					<th class="bl0" width="60">생년월일</th>
					<td>
						<select id="birth1" name="birth1" style="width:60px;height:22px">
							<option value="">선택</option>
							<% 
								int statrYYYY = 1920;
								int endYYYY = (ut.lib.util.DateUtil.getYear()+10);
							
								String yyyy = "";
								for(int i=statrYYYY;i<=endYYYY;i++) {
									yyyy = String.valueOf(i);
							%>
								<option value="<%=yyyy%>" <%=yyyy.equals(birth1)?"selected='selected'":""%>><%=yyyy%></option>
							<%
								}
							%>
						</select>
						<select id="birth2" name="birth2" style="width:50px;height:22px">
							<option value="">선택</option>
							<% 
								String mm = "";
								for(int i=12;i>=1;i--) {
									if(i < 10) {
										mm = "0" + i;
									} else {
										mm = String.valueOf(i);
									}
							%>
								<option value="<%=mm%>" <%=mm.equals(birth2)?"selected='selected'":""%>><%=mm%></option>
							<%
								}
							%>
						</select>
						<select id="birth3" name="birth3" style="width:50px;height:22px">
							<option value="">선택</option>
							<% 
								String dd = "";
								for(int i=31;i>=1;i--) {
									if(i < 10) {
										dd = "0" + i;
									} else {
										dd = String.valueOf(i);
									}
							%>
								<option value="<%=dd%>" <%=dd.equals(birth3)?"selected='selected'":""%>><%=dd%></option>
							<%
								}
							%>
						</select>				
					
					</td>
					<th class="bl0" width="50">이름</th>
					</th>
					<td>
						<input type="text" id="name" name="name" class="input02 w120" maxlength="24" value="<%=name%>"/>
					</td>
					<th class="bl0" width="60">비밀번호</th>
					<td>
						<input type="password" id="password" name="password" maxlength="20" class="input02 w100" onKeypress="if(event.keyCode==13) {search();}" value="<%=password%>"/>
					</td>
				</tr>
				</table>
				<!-- //view --> 
				<!-- //title -->
				<div class="h9"></div>
				<!-- button -->
				<div class="btnRbtt">			
					<a href="javascript:search();"><img src="../../../images/skin1/button/btn_submit03.gif" alt="확인" /></a>
					<a href="javascript:reset();"><img src="../../../images/skin1/button/btn_cancel02.gif" alt="취소" /></a>
				</div>
				<div class="h9"></div>		
				<%
					if(listMap != null) {
				%>
				<table class="dataW01" style="dont-size:9px;">		
					<tr>
						<th class="bl0" style="padding:0px;text-align:center;">최초신청일자</th>
						<th style="padding:0px;text-align:center;">신청자성명</th>
						<th style="padding:0px;text-align:center;">현재상태</th>
						<th style="padding:0px;text-align:center;">확인날짜</th>
						<th style="padding:0px;text-align:center;">수정여부</th>
					</tr>
					<%  if(listMap.keySize() == 0) { %>
					<tr>
						<td colspan="5" class="bl0" style="padding:0px;text-align:center;height:30px;"><b>신청자 정보를 찾을수 없습니다. 관리자에게 문의해주세요.</b></td>
					</tr>	
					<%
						} else {
							for(int i=0;listMap.keySize() > i;i++){
					%>
					<tr>
						<td class="bl0" style="padding:0px;text-align:center;height:30px;"><%=listMap.getString("enterdate",i)%></td>
						<td style="padding:0px;text-align:center;"><%=listMap.getString("name",i)%></td>
						<td style="padding:0px;text-align:center;"><%=listMap.getString("checks",i)%></td>
						<td style="padding:0px;text-align:center;"><%=listMap.getString("checkdate",i)%></td>
						<% if("Y".equals(listMap.getString("checkyn",i))) { %>
							<td style="padding:0px;text-align:center;"><a href="javascript:alert('[수정불가] : 이미 관리자가 확인함')"><img src="../../../images/skin1/button/btn_noupdate_1.gif" alt="수정불가" /></a><a href="javascript:deleteLecturer('<%=listMap.getString("seqno",i)%>')"><img src="../../../images/skin1/button/btn_delete_1.gif" alt="삭제" /></a></td>						
						<% } else { %>
							<td style="padding:0px;text-align:center;"><a href="javascript:updateLecturer('<%=listMap.getString("seqno",i)%>')"><img src="../../../images/skin1/button/btn_update_1.gif" alt="수정" /></a><a href="javascript:deleteLecturer('<%=listMap.getString("seqno",i)%>')"><img src="../../../images/skin1/button/btn_delete_1.gif" alt="삭제" /></a></td>
						<% } %>
					</tr>
					<%
							}
						}	
					%>
				</table>

				<a href="javascript:reset();"></a>


				<%
					}
				%>
				</form>
				<div class="h30"></div>
			</div>
			<!-- //contnet -->
		</div>
	</div>
</div>
<script language="JavaScript" type="text/JavaScript"> 
	<!--
	function search() {
		var pform = document.pform;
		if(pform.birth1.value == "") {
			alert("생년월일 년도를 선택해주세요.");
			pform.birth1.focus();
			return;
		}
		if(pform.birth2.value == "") {
			alert("생년월일 월을 선택해주세요.");
			pform.birth2.focus();
			return;
		}
		if(pform.birth3.value == "") {
			alert("생년월일 일을 선택해주세요.");
			pform.birth3.focus();
			return;
		}
		if(pform.name.value == "") {
			alert("성명을 입력해주세요.");
			pform.name.focus();
			return;
		}
		if(pform.password.value == "") {
			alert("비밀번호를 입력해주세요.");
			pform.password.focus();
			return;
		}
		document.pform.action = "/homepage/lecturer.do";
		pform.submit();
	}
	function reset() {
		document.location.href = "/homepage/lecturer.do?mode=lecturerSearch";
	}
	function deleteLecturer(seqno) {
		if(confirm("삭제하시겠습니까? 삭제시 복구불가능합니다.")) {
			var url = "/homepage/lecturer.do";
			var pars = "mode=deleteLecturer";
			pars += "&seqno="+seqno;
			pars += "&birth1="+$("birth1").value;
			pars += "&birth2="+$("birth2").value;
			pars += "&birth3="+$("birth3").value;
			pars += "&name="+$("name").value;
			pars += "&password="+$("password").value;

			var myAjax = new Ajax.Request(
				url, 
				{
					method: "post", 
					parameters:pars,
					onLoading : function(){
					},
					onSuccess : function(data){		
						var result = trim(data.responseText);
						if(result == 'ok'){
							alert("삭제 성공");
							search();
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
	function updateLecturer(seqno) {
		$("seqno").value = seqno;
		$("goform").submit();
	}
	//-->
</script>
<form id="goform" name="goform" method="post" action="/homepage/lecturer.do?mode=fromLecturer">
	<input type="hidden" id="seqno" name="seqno" />
	<input type="hidden" id="birth1" name="birth1" value="<%=birth1%>"/>
	<input type="hidden" id="birth2" name="birth2" value="<%=birth2%>" />
	<input type="hidden" id="birth3" name="birth3" value="<%=birth3%>" />
	<input type="hidden" id="name" name="name"  value="<%=name%>"/>
	<input type="hidden" id="password" name="password"  value="<%=password%>"/>
</form>
<jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>
