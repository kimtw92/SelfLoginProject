<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<%
	String name = StringReplace.nvl(request.getParameter("name"), "");
	String jumin1 = StringReplace.nvl(request.getParameter("jumin1"), "");
	String jumin2 = StringReplace.nvl(request.getParameter("jumin2"), "");
	DataMap listMap = null;
	try {
		listMap = (DataMap)request.getAttribute("RESERVATION_LIST");
		listMap.setNullToInitialize(true);
	} catch(Exception e) {
		
	}
%>

<script>
<%
	if(listMap != null) {
%>
	function cancle_reservation(tapk, type) {
		if(type == "C") {
			alert("취소 상태 입니다.");
			return;
		}
		if(confirm("정말로 취소 하시겠습니까?")) {
			var url = "/homepage/introduce.do";
			var pars = "mode=canclereservationAjaxAction";
			pars += "&tapk="+tapk;

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
								alert("취소 성공");
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
<%
	}
%>
	function search() {
		var pform = document.pform;
		if(pform.name.value == "") {
			alert("성명을 입력해주세요.");
			pform.name.focus();
			return;
		}
		if(pform.jumin1.value == "") {
			alert("주민 압자리를 입력해주세요.");
			pform.jumin1.focus();
			return;
		}
		if(pform.jumin2.value == "") {
			alert("주민 뒷자리를 입력해주세요.");
			pform.jumin2.focus();
			return;
		}
		document.pform.mode.value = "reservationConfirm";
		document.pform.action = "/homepage/introduce.do";
		pform.submit();
	}

	function findReservationAjax(){
	
		var url = "/homepage/introduce.do";
		var pars = "mode=reservationConfirmAjaxAction";
		pars += "&name="+document.getElementById("name").value;
		pars += "&jumin1=" + document.getElementById("jumin1").value;
		pars += "&jumin2=" + document.getElementById("jumin2").value;

		var myAjax = new Ajax.Request(
				url, 
				{
					method: "post", 
				    parameters:pars,
				    onLoading : function(){
					},
					onSuccess : function(originalRequest){		
						var result=trim(originalRequest.responseText);
						if(result == 'notExist'){
							alert('신청기록이 존재하지 않습니다.');
						} else if(result == 'notRecog'){
							alert("승인처리 중입니다.");
						} else if(result == 'recog'){
							popupRecog();
						}
						
					},
					onFailure : function(){
						alert("데이터를 가져오는데 실패하였습니다.");
					}    
				}
			);
				
	}

	function popupRecog(){
		var url = "/homepage/introduce.do";
		var pars = "?mode=reservationConfirmAction";
		pars += "&name="+ encodeURI(document.getElementById("name").value);
		pars += "&jumin1=" + document.getElementById("jumin1").value;
		pars += "&jumin2=" + document.getElementById("jumin2").value;
		
		window.open(url+pars,'popupRecog','width=900,height=600,top=0,left=0,scrollbars=1,resizable=1');
	}
	
	function trim(str){
		return str.replace(/(^\s*)|(\s*$)/gi, "");
	}
	
	function findReservation() {
		if(document.getElementById("name").value=='' || document.getElementById("jumin1").value=='' || document.getElementById("jumin2").value=='') {
			alert('모든 항목은 필수 입니다.');
		}else{
			document.pform.action = "/homepage/introduce.do";
			document.pform.submit();
		}
	}
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left6.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual6">인재개발원 소개</div>
            <div class="local">
              <h2>시설현황</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; 시설현황 &gt; <span>시설대여 신청</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			
            <ol class="TabSub">
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6');">시설개요</a></li>
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-2');">층별안내</a></li>
            <!-- li><a href="javascript:fnGoMenu('7','eduinfo7-6-3');">편의시설</a></li -->
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-4');">시설대여안내</a></li>
            <li><a href="javascript:fnGoMenu('7','reservation');"  onclick="alert('1. 시설 대여 안내 [신청 절차] 확인 바랍니다. \n - 유선상 예약가능 여부 확인 필요 (☏ 032-440-7632) \n\n2. 예약 후 [최종 승인]이 되어야 시설 사용이 가능합니다. \n - 유선상 미확인 신청시 최종 승인 불가 할수 있음 \n\n ※ 본 시설은 교육시설로서 교육(시,군구 행사 포함) 일정 \n및 교육에 지장없는 범위 내에서 시민에게 개방하고 있어 \n타 대관시설에 비해 제약이 있을 수 있습니다.');">시설대여신청</a></li>
            <li class="TabOn last"><a href="javascript:fnGoMenu('7','reservationConfirm');">시설대여예약확인</a></li>
			<li class="last"><a href="javascript:fnGoMenu('7','reservationSurvey');">시설대여설문</a></li>
          </ol>
			  <form id="pform" name="pform" method="post">
<input type="hidden" name="mode" value="reservationConfirmAjaxAction">
				<div id="content">
			<!-- title --> 
			<div class="h15"></div>
			<h3>예약확인</h3>
			<!-- //title -->
			<div class="space"></div>
            <!-- view -->
			<table class="dataW01">		
			<tr>
				<th class="bl0" width="80">이름</th>
				<td><input type="text" value="<%=name%>" id="name" name="name" class="input02 w120" /></td>
				<th class="bl0" width="80">주민번호</th>
				<td>
					<input type="text" value="<%=jumin1%>" id="jumin1" maxlength="6" name="jumin1" class="input02 w100" /> - 
					<input type="password" value="<%=jumin2%>" id="jumin2" maxlength="7" name="jumin2" class="input02 w100" onKeypress="if(event.keyCode==13) {search();}" />
				</td>
			</tr>
			</table>
			<!-- //view --> 
            <!-- //title -->
			<div class="h9"></div>
			<!-- button -->
			<div class="btnRbtt">			
				<a href="javascript:search();"><img src="../../../images/skin1/button/btn_submit03.gif" alt="확인" /></a>
			</div>
			<div class="h9"></div>
			<%
				if(listMap != null) {
			%>
				<table class="dataW01" style="dont-size:9px;">		
					<tr>
						<th class="bl0" style="padding:0px;text-align:center;">예약일자</th>
						<th style="padding:0px;text-align:center;">단체명</th>
						<th style="padding:0px;text-align:center;">예약자성명</th>
						<th style="padding:0px;text-align:center;">대관장소</th>
						<th style="padding:0px;text-align:center;">신청일시</th>
						<th style="padding:0px;text-align:center;">처리상태</th>
					</tr>
					<%  if(listMap.keySize() == 0) { %>
					<tr>
						<td colspan="6" class="bl0" style="padding:0px;text-align:center;height:30px;"><b>예약자 정보를 찾을수 없습니다. 관리자에게 문의해주세요.</b></td>
					</tr>
					<%
						} else {
							String taRentTime = "";
							String taReqSection = "";
							String taAgreement = "";
							for(int i=0;listMap.keySize() > i;i++){
								if("6".equals(listMap.getString("taReqSection", i)) || "7".equals(listMap.getString("taReqSection", i)) || "1".equals(listMap.getString("taReqSection", i))){

									if(!"".equals(listMap.getString("starttime", i))) {
										taRentTime = listMap.getString("taRentDate", i) + "(" + listMap.getString("starttime", i)+"시 ~ " +  listMap.getString("endtime", i)+"시)";
									} else {
										taRentTime = listMap.getString("taRentDate", i);
									}

								} else {
									if("am".equals(listMap.getString("taRentTime", i))) {
										taRentTime = listMap.getString("taRentDate", i)+" (오전 09:00~13:00)";
									} else if("pm".equals(listMap.getString("taRentTime", i))){
										taRentTime = listMap.getString("taRentDate", i)+" (오후 13:00~17:00)";
									} else if("all".equals(listMap.getString("taRentTime", i))) {
										taRentTime = listMap.getString("taRentDate", i)+" (<font color=red>종일 09:00~17:00</font>)";
									}
								}
								if("0".equals(listMap.getString("taReqSection", i))) {
									taReqSection = "잔디구장";
								} else if("1".equals(listMap.getString("taReqSection", i))){
									taReqSection = "테니스장";
								} else if("2".equals(listMap.getString("taReqSection", i))){
									taReqSection = "테니스장2";
								} else if("3".equals(listMap.getString("taReqSection", i))){
									taReqSection = "강당";
								} else if("4".equals(listMap.getString("taReqSection", i))){
									taReqSection = "체육관";
								} else if("6".equals(listMap.getString("taReqSection", i))){
									taReqSection = "강의실";
								} else if("7".equals(listMap.getString("taReqSection", i))){
									taReqSection = "생활관";
								}
								if("N".equals(listMap.getString("taAgreement", i))) {
									taAgreement = "(승인처리중/취소)";
								} else if("Y".equals(listMap.getString("taAgreement", i))) {
									taAgreement = "(승인완료/취소)";
								} else if("C".equals(listMap.getString("taAgreement", i))) {
									taAgreement = "(취소처리)";
								}
					%>
					<tr>
						<td class="bl0" style="padding:0px;text-align:center;height:30px;"><%=taRentTime%></td>
						<td style="padding:0px;text-align:center;"><%=listMap.getString("taReqGroup",i)%></td>
						<td style="padding:0px;text-align:center;"><%=listMap.getString("taReqName",i)%></td>
						<td style="padding:0px;text-align:center;"><%=taReqSection%></td>
						<td style="padding:0px;text-align:center;"><%=listMap.getString("taDate", i)%></td>
						<td style="padding:0px;text-align:center;"><a href="javascript:cancle_reservation('<%=listMap.getString("taPk", i)%>','<%=listMap.getString("taAgreement", i)%>');"><%=taAgreement%></a></td>
					</tr>
					<%
							}
						}
					%>
				</table>
			<%
				}
			%>
			<!-- //button -->

			

			<!-- title --> 
		</div>

</form>
              <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100038" /></jsp:include>
              <div class="h80"></div>   
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>