<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<%
	String ftoday = (String)request.getAttribute("ftoday");	

%>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left6.jsp" flush="true" ></jsp:include>
    
      </div>

<link rel="stylesheet" type="text/css" href="/commonInc/css/style_00.css">
<script type="text/javascript">
function fnPopupCalendar2(frm, obj){
	var oDate = $F(obj);

	var result = window.showModalDialog("/commonInc/jsp/calendar.jsp?oDate="+oDate, "calendar", "dialogWidth:256px; dialogHeight:280px; center:yes; status:no;");

	if (result == -1 || result == null || result == ""){
		return;
	}
	
	if(result == "delete"){
		result = "";
	}

	if(result.length == 8){
		result = result.substring(0,4)+'-'+result.substring(4,6)+'-'+ result.substring(6,8);
	}

	try{
		eval(frm+"."+obj+".value = '"+result+"';");		
	}catch(e){
		$(obj).value = result;
	}

}

function save() {
	var check1 = $$('input:checked[type="radio"][name="check1"]').pluck('value');
	var check2 = $$('input:checked[type="radio"][name="check2"]').pluck('value');
	var check3 = $F("sDate");
	var check4 = $$('input:checked[type="radio"][name="check4"]').pluck('value');
	var check5 = $$('input:checked[type="radio"][name="check5"]').pluck('value');
	var price = $F("price");
	var check6 = $$('input:checked[type="radio"][name="check6"]').pluck('value');
	var check7 = $$('input:checked[type="radio"][name="check7"]').pluck('value');
	var etc = $("etc").innerText;

	if(check1 == "") {
		alert("1번문항을 선택해주세요.");
		return;
	} else if(check2 == "") {
		alert("2번문항을 선택해주세요.");
		return;
	} else if(check3 == "") {
		alert("3번문항을 선택해주세요.");
		return;
	} else if(check4 == "") {
		alert("4번문항을 선택해주세요.");
		return;
	} else if(check5 == "") {
		alert("5번문항을 선택해주세요.");
		return;
	} else if(check5 == "5") {
		if(price == "") {
			alert("5번 문항 적정가격을 입력해주세요.");
			return;
		}
	} else if(check6 == "") {
		alert("6번문항을 선택해주세요.");
		return;
	} else if(check7 == "") {
		alert("7번문항을 선택해주세요.");
		return;
	} else if(etc == "") {
		alert("8번문항을 입력해주세요.");
		return;
	}
	document.form.submit();
}

function checkTextareaLength(text, textLength){
	if( text == undefined || textLength < 0 ){
		return;
	}
	if( text.value.length > textLength ){
		alert("문자는 " + textLength + "자 까지만 입력 가능합니다.");
		text.value = text.value.substring(0,( textLength-1 ) );
		text.focus();
		return false;
	}
	return true;
}

function checkEtc() {
	if(!checkTextareaLength(document.form.etc,3800)) {
		return false;
	}
}

function cancel() {
	if(confirm("작성하신 데이타가 지워집니다.")) {		
		document.form.reset();
	}
}
</script>

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
            <li><a href="javascript:fnGoMenu('7','reservationConfirm');">시설대여예약확인</a></li>
			<li class="last TabOn" ><a href="javascript:fnGoMenu('7','reservationSurvey');">시설대여설문</a></li>
          </ol>

			<div class="h9"></div>
		<form id="form" name="form" method="post" action="/homepage/introduce.do?mode=saveReservationSurvey">
		<!-- //button -->
				<div class="wrap">

				<div class="title">인재개발원 시설 사용에 대한 설문</div>
				<div class="con">
				<div class="box">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;본 설문은 인재개발원 시설 사용에 대한 만족도를 조사하여 시민들에게 보다 나은 <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;서비스를 제공하고자 하는 것임을 알려드립니다.
				</div>
				<br />
				<form id="pform" name="pform" method="post" >
				<ul>
				  <li class="na">1. 귀하께서는 인재개발원 시설개방 사용하는것을 어떻게 알게 되었습니까?</li>
				  <li class="ra">
					<input type="radio" name="check1" id="check1" value="1"/>인재개발원 홈페이지
					<input type="radio" name="check1" id="check1" value="2"/>반상회보
					<input type="radio" name="check1" id="check1" value="3"/>동아리 회원
					<input type="radio" name="check1" id="check1" value="4"/>아는사람 소개
				  </li>
				  <li class="na">2. 귀하께서 사용(이용)하신 시설은?</li>
				  <li class="ra"> 
					<input type="radio" name="check2" id="check2" value="1"/>체육관
					<input type="radio" name="check2" id="check2" value="2"/>강의실
					<input type="radio" name="check2" id="check2" value="3"/>강당
					<input type="radio" name="check2" id="check2" value="4"/>잔디구장
					<input type="radio" name="check2" id="check2" value="5"/>테니스장
					<input type="radio" name="check2" id="check2" value="6"/>생활관(숙소)
				  </li>
				  <li class="na">3. 귀하께서 시설을 사용하신 날은 언제 입니까?</li>
				  <li class="ra">
					<input type="text" class="textfield" name="sDate" value="<%=ftoday%>" style="width:70px" readonly/>
					<img style="cursor:hand" onclick="fnPopupCalendar2('pform','sDate');" src="../images/icon_calen.gif" alt="달력" />
				  </li>
				  <li class="na">4. 시설 및 환경에 만족하였습니까?</li>
				  <li class="ra">
					<input type="radio" name="check4" id="check4" value="1"/>매우만족
					<input type="radio" name="check4" id="check4" value="2"/>만족
					<input type="radio" name="check4" id="check4" value="3"/>보통
					<input type="radio" name="check4" id="check4" value="4"/>불만족
					<input type="radio" name="check4" id="check4" value="5"/>매우 불만족
				  </li>
				  <li class="na">5. 시설 사용료에 대하여는 어떻게 생각하십니까?</li>
				  <li class="ra">
					<input type="radio" name="check5" id="check5" value="1"/>저렴하다
					<input type="radio" name="check5" id="check5" value="2"/>적당하다
					<input type="radio" name="check5" id="check5" value="3"/>비싸다
					<input type="radio" name="check5" id="check5" value="4"/>많이 비싸다<br />
					<input type="radio" name="check5" id="check5" value="5"/>기타 
					<font color="red">(적정가격은 : <input type="text" name="price" id="price" maxlength="7" style="width:50;ime-mode:disabled" onkeyDown="go_commNumCheck()"/>원)</font>
				  </li>
				  <li class="na">6. 시설 이용시 인재개발원 직원 지원(서비스)에 만족 하였습니까?</li>
				  <li class="ra">
					<input type="radio" name="check6" id="check6" value="1"/>매우만족
					<input type="radio" name="check6" id="check6" value="2"/>만족
					<input type="radio" name="check6" id="check6" value="3"/>보통
					<input type="radio" name="check6" id="check6" value="4"/>불만족
					<input type="radio" name="check6" id="check6" value="5"/>매우불만
				  </li>
				  <li class="na">7. 기회가 된다면 다음에도 인재개발원 시설을 사용하실 계획입니까?</li>
				  <li class="ra">
					<input type="radio" name="check7" id="check7" value="1" />꼭 이용하겠다
					<input type="radio" name="check7" id="check7" value="2" />이용하겠다
					<input type="radio" name="check7" id="check7" value="3"/>생각해보겠다
					<input type="radio" name="check7" id="check7" value="4" />이용하지 않겠다
				  </li>
				  <li class="na">8. 시설(물) 사용에 대한 건의 및 개선사항<font color="red">(불편하셨던 점이나 시정했으면
				   하는 점을 구체적으로 작성하여 주시면 감사 하겠습니다)</font>
				  </li>
				  <li class="text_a"><br /><textarea name="etc" id="etc" onkeyup="checkEtc();"></textarea></li>
				</ul>
				</form>
				</div>

				<div class="btn2">
				<ul>
					<li class="b1"><a href="javascript:save();"><img src="/images/btn_1.gif" alt="저장"/></a></li>
					<li class="b2"><a href="javascript:cancel();"><img src="/images/btn_2.gif" alt="취소"/></a></li>
				</ul>

				</div>

				</div>
</form>						

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