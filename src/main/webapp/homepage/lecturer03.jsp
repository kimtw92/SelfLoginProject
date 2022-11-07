<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%
	String fileUploadPath = ut.lib.util.Constants.UPLOADDIR_HOMEPAGE + "lecturer/";
%>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    <div id="subContainer">
    <div class="subNavi_area">
      <jsp:include page="/homepage_new/inc/left7.jsp" flush="true" ></jsp:include>
      </div>
        <div id="contnets_area">
          <div class="sub_visual7">홈페이지 이용안내</div>
            <div class="local">
              <h2>강사등록</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 홈페이지 이용안내 &gt; <span>강사등록</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<div id="content">
			<form id="pform" name="pform" method="post" action="/homepage/lecturer.do" enctype="multipart/form-data">
			<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
			<input type="hidden" name="INNO_SAVE_DIR"		value='<%=fileUploadPath%>' />
			<input type="hidden" name="mode"		value='save' />
				<div class="lecturer_tab01">
					<ul>
						<li><img src='/images/skin4/sub/lecturer_step01.gif'alt="강사신청 1단계"></li>
						<li><img src='/images/skin4/sub/lecturer_step02.gif' alt="강사신청 2단계"></li>
						<li><img src='/images/skin4/sub/lecturer_step03_on.gif' alt="강사신청 3단계"></li>
						<li><img src='/images/skin4/sub/lecturer_step04.gif' alt="강사신청 4단계"></li>
					</ul>
				</div>
				<div class="h30"></div>
				<p><img src="/images/skin4/sub/join_tt1.gif" alt="인적사항" /> </p>
                    <table class="personal" border="1" cellspacing="0" summary="인적사항 입력표">
                        <tr class="first-child">
                            <th>
                                <span>■</span>성명(한글)
                            </th>
                            <td>
                                <div class="help_wrap">
                                    <input type="text" name="name" id="name" class="input_text w157" maxlength="18"/>
                                </div>
                            </td>
							<th>
                                <span>■</span>성명(한자)
                            </th>
                            <td>
                                <div class="help_wrap">
                                    <input type="text" name="cname" id="cname" class="input_text w157" maxlength="18"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>생년월일
                            </th>
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
										<option value="<%=yyyy%>"><%=yyyy%></option>
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
										<option value="<%=mm%>"><%=mm%></option>
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
										<option value="<%=dd%>"><%=dd%></option>
									<%
										}
									%>
								</select>
                            </td>
							<th>
                                <span>■</span>성별
                            </th>
                            <td>
								<select id="sex" name="sex" style="width: 100px; height: 22px">
									<option value="">**선택하세요**</option>
									<option value="M">남</option>
									<option value="F">여</option>
								</select>
                            </td>
						</tr>
                        <tr> 
                            <th>
                                <span>■</span>현직위
                            </th>
                            <td>
                                <div class="help_wrap">
									<select id="job" name="job" style="width:150px">
										<option value="">**선택하세요**</option>
										<option value="교수">교수</option>
										<option value="본청 공무원">본청 공무원</option>
										<option value="군구 공무원">군구 공무원</option>
										<option value="중앙/타시도 공무원">중앙/타시도 공무원</option>
										<option value="유관기관">유관기관</option>
										<option value="기타">기타</option>
									</select>
                                </div>
                            </td>
							<th>
                                <span>■</span>학 위
                            </th>
                            <td>
                                <div class="help_wrap">
									<select id="degree" name="degree" style="width:110px">
										<option value="">**선택하세요**</option>
										<option value="01">박사
										<option value="02">석사
										<option value="03">대졸
										<option value="04">대재.퇴,초대졸
										<option value="05">고졸
										<option value="06">중졸이하
										<option value="07">기타
									</select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>출강분야
                            </th> 
                            <td colspan="3">
                                <div class="help_wrap">
									<select id="gubun" name="gubun" style="width:150px">
										<option value="">**선택하세요**</option>
										<option value="001">일반행정</option>
										<option value="002">정치·외교·안보</option>
										<option value="003">경영·경제·통계</option>
										<option value="004">사회</option>
										<option value="005">교육</option>
										<option value="006">법률</option>
										<option value="007">철학·윤리·종교</option>
										<option value="008">과학·기술·정보</option>
										<option value="009">보건·복지·환경</option>
										<option value="010">교통·지리</option>
										<option value="011">역사</option>
										<option value="012">문화·관광·예술·문학</option>
										<option value="013">노동·건설</option>
										<option value="014">언론·홍보</option>
										<option value="015">외국어</option>
										<option value="016">기타</option>
									</select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>이메일
                            </th>
                            <td colspan="3">
                                <div class="pw_mail"><input type="text" style="ime-mode: disabled; height:15px; width:150px;" name="txtEmailID" id="txtEmailID" class="input_text w88" title="이메일 ID입력" maxlength="50" />
                                    @
                                    <input type="text" style="ime-mode:disabled;height:15px;" id="email1" name="email1" class="input_text w130" title="이메일 호스트입력" />
                                    <select id="email2" name="email2" style="width: 100px; height: 22px" onchange="document.getElementById('email1').value = this.value" class="input_text w130" >
                                        <option value="">직접입력</option>
                                        <option value="hotmail.com">HOT</option>
                                        <option value="msn.co.kr">MSN</option>
                                        <option value="gmail.com">구글메일</option>
                                        <option value="naver.com">네이버</option>
                                        <option value="nate.com">네이트</option>
                                        <option value="daum.net">다음</option>
                                        <option value="dreamwiz.com">드림위즈</option>
                                        <option value="lycos.co.kr">라이코스</option>
                                        <option value="yahoo.co.kr">야후</option>
                                        <option value="empal.com">엠팔</option>
                                        <option value="chol.com">천리안</option>
                                        <option value="korea.com">코리아닷컴</option>
                                        <option value="paran.com">파란</option>
                                        <option value="freechal.com">프리첼</option>
                                        <option value="hanafos.com">하나포스</option>
                                        <option value="hanmail.net">한메일</option>
                                        <option value="hanmir.com">한미르</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>핸드폰 
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="hp" name="hp" style="height:15px;width:120px;" class="input_text w88" title="핸드폰번호" />&nbsp;ex) 010xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>자택 연락처
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="home_tel" name="home_tel" style="height:15px;width:120px;" class="input_text w88" title="전화번호" />&nbsp;ex) 032xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>자택 주소
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" name="homePost1" id="homePost1" maxlength="3" style="width:30px" class="textfield" value="" readonly="readonly" /> -
									<input type="text" name="homePost2" id="homePost2" maxlength="3" style="width:30px" class="textfield" value="" readonly="readonly" />
									<input type="button" value="주소검색" class="boardbtn1" onclick="searchZip('homePost1','homePost2','homeAddr');" />
									<br />
									<input type="text" name="homeAddr" id="homeAddr" style="width:500px" class="textfield" value="" maxlength="100" readonly="readonly" />	
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ■&nbsp;&nbsp;사무실 연락처
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="office_tel" name="office_tel" style="height:15px;width:120px;" class="input_text w88" title="사무실번호" />&nbsp;ex) 032xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ■&nbsp;&nbsp;사무실 주소
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" id="officePost1" name="officePost1" maxlength="3" style="width:30px" class="textfield" value="" readonly="readonly" /> -
									<input type="text" id="officePost2" name="officePost2" maxlength="3" style="width:30px" class="textfield" value="" readonly="readonly" />
									<input type="button" value="주소검색" class="boardbtn1" onclick="searchZip('officePost1','officePost2','officeAddr');" />
									<br />
									<input type="text" id="officeAddr" name="officeAddr" style="width:500px" class="textfield" value="" maxlength="100" readonly="readonly" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ■&nbsp;&nbsp;학력
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" id="ocinfo1_0" name="ocinfo1" style="width:350px" class="textfield" maxlength="1000" value="" /><br />
									<input type="text" id="ocinfo1_1" name="ocinfo1" style="width:350px" class="textfield" maxlength="1000" value="" /><br />
									<input type="text" id="ocinfo1_2" name="ocinfo1" style="width:350px" class="textfield" maxlength="1000" value="" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ■&nbsp;&nbsp;전공분야
								<div style="text-align:center;"><input type="button" value="추 가" class="boardbtn1" onclick="addTextBox('dyBox2');" /></div>
                            </th>
                            <td colspan="3" id="dyBox2">
                                <div class="help_wrap">
									<font color="red">삭제시 빈공간으로 저장하시면 됩니다.</font><br />
									1. <input type="text" id="ocinfo2_0" name="ocinfo2" style="width:350px" class="textfield" /><br />
									2. <input type="text" id="ocinfo2_1" name="ocinfo2" style="width:350px" class="textfield" /><br />
									3. <input type="text" id="ocinfo2_2" name="ocinfo2" style="width:350px" class="textfield" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ■&nbsp;&nbsp;경력사항
								<div style="text-align:center;"><input type="button" value="추 가" class="boardbtn1" onclick="addTextBox('dyBox3');" /></div>
                            </th>
                            <td colspan="3" id="dyBox3">
                                <div class="help_wrap">
									<font color="red">삭제시 빈공간으로 저장하시면 됩니다.</font><br />
									1. <input type="text" id="ocinfo3_0" name="ocinfo3" style="width:350px" class="textfield" maxlength="1000" /><br />
									2. <input type="text" id="ocinfo3_1" name="ocinfo3" style="width:350px" class="textfield" maxlength="1000" /><br />
									3. <input type="text" id="ocinfo3_2" name="ocinfo3" style="width:350px" class="textfield" maxlength="1000" />		
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ■&nbsp;&nbsp;저서 및 주요논문
								<div style="text-align:center;"><input type="button" value="추 가" class="boardbtn1" onclick="addTextBox('dyBox4');" /></div>
                            </th>
                            <td colspan="3" id="dyBox4">
                                <div class="help_wrap">	
									<font color="red">삭제시 빈공간으로 저장하시면 됩니다.</font><br />
									1. <input type="text" id="ocinfo4_0" name="ocinfo4" style="width:350px" class="textfield" maxlength="1000" /><br />
									2. <input type="text" id="ocinfo4_1" name="ocinfo4" style="width:350px" class="textfield" maxlength="1000" /><br />
									3. <input type="text" id="ocinfo4_2" name="ocinfo4" style="width:350px" class="textfield" maxlength="1000" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>비밀번호
                            </th>
                            <td colspan="3">
                                <div class="help_wrap upw"><input maxlength="30" style="height:15px;" type="password"  id="passwd" name="passwd" class="input_text w157" /> 신청 이력 조회시 사용</div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>비밀번호 확인
                            </th>
                            <td colspan="3">
                                <div class="help_wrap"><input maxlength="30" type="password" id="passwd_check" name="passwd_check" class="input_text w157" style="height:15px;" /> 비번 분실시 조회 불가능 합니다.</div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ■&nbsp;&nbsp;자기소개서 첨부
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
                                	<jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>
									자기소개서 첨부(DOC, HWP, pdf 문서만 가능)
								</div>
                            </td>
                        </tr>
                    </table>
					<p style="text-align:center;"><input type="button" value="저장" onclick="goSave();"/></P>
					<br />
			</div>
				<input type="hidden" id="stOcinfo1" name="stOcinfo1" />
				<input type="hidden" id="stOcinfo2" name="stOcinfo2" />
				<input type="hidden" id="stOcinfo3" name="stOcinfo3" />
				<input type="hidden" id="stOcinfo4" name="stOcinfo4" />
			</form>
            <!-- //contnet -->
          </div>
        </div>
    </div>
	<script language="JavaScript"> 
// 	<!--
	var ocinfo2 = 3;
	var ocinfo3 = 3;
	var ocinfo4 = 3;
	function goSave() {
		if($("name").value.replace(/ /g,"") == "") {
			alert("성명(한글)을 입력해주세요.");
			$("name").focus();
			return;
		}
		if($("cname").value.replace(/ /g,"") == "") {
			alert("성명(한자)를 입력해주세요.");
			$("cname").focus();
			return;
		}
		if($("birth1").value == "") {
			alert("생년월일 (년도)를 선택해주세요.");
			$("birth1").focus();
			return;
		}
		if($("birth2").value == "") {
			alert("생년월일 (월)을 선택해주세요.");
			$("birth2").focus();
			return;
		}
		if($("birth3").value == "") {
			alert("생년월일 (일)를 선택해주세요.");
			$("birth3").focus();
			return;
		}
		if($("sex").value == "") {
			alert("성별을 선택해주세요.");
			$("sex").focus();
			return;
		}
		if($("job").value == "") {
			alert("현직위를 선택해주세요.");
			$("job").focus();
			return;
		}
		if($("degree").value == "") {
			alert("학위를 선택해주세요.");
			$("degree").focus();
			return;
		}
		if($("gubun").value == "") {
			alert("출강분야를 선택해주세요.");
			$("gubun").focus();
			return;
		}
		if($("txtEmailID").value.replace(/ /g,"") == "") {
			alert("메일주소 ID를 입력해주세요.");
			$("txtEmailID").focus();
			return;
		}
		if($("email1").value.replace(/ /g,"") == "") {
			alert("메일주소 도메인을 선택하거나 입력해주세요.");
			$("email1").focus();
			return;
		}
		if($("hp").value.replace(/ /g,"") == "") {
			alert("핸드폰 번호를 입력해주세요.");
			$("hp").focus();
			return;
		}
		if($("home_tel").value.replace(/ /g,"") == "") {
			alert("전화번호를 입력해주세요.");
			$("home_tel").focus();
			return;
		}
		if($("homePost1").value.replace(/ /g,"") == "") {
			alert("주소검색을 해주세요.");
			$("homePost1").focus();
			return;
		}
		if($("homePost2").value.replace(/ /g,"") == "") {
			alert("주소검색을 해주세요.");
			$("homePost2").focus();
			return;
		}
		if($("homeAddr").value.replace(/ /g,"") == "") {
			alert("상세주소를 입력해주세요.");
			$("homeAddr").focus();
			return;
		}

		if($("passwd").value.replace(/ /g,"") == "") {
			alert("비밀번호를 입력해주세요.");
			$("passwd").focus();
			return;
		}
		if($("passwd_check").value.replace(/ /g,"") == "") {
			alert("비밀번호 확인을 입력해주세요.");
			$("passwd_check").focus();
			return;
		}
		if($("passwd").value != $("passwd_check").value) {
			alert("입력하신 비밀번호가 일치하지 않습니다.");
			return;
		}

		var stOcinfo1 = document.all.ocinfo1;
		var stOcinfo2 = document.all.ocinfo2;
		var stOcinfo3 = document.all.ocinfo3;
		var stOcinfo4 = document.all.ocinfo4;

		var arrOcinfoList1 = new Array(stOcinfo1.length);
		var arrOcinfoList2 = new Array(stOcinfo2.length);
		var arrOcinfoList3 = new Array(stOcinfo3.length);
		var arrOcinfoList4 = new Array(stOcinfo4.length);

		for(var i=0; i < stOcinfo1.length;i++) {
			if(stOcinfo1[i].value.replace(/ /g,"") != "") {
				arrOcinfoList1[i] = stOcinfo1[i].value;
			}
		}

		for(var i=0; i < stOcinfo2.length;i++) {
			if(stOcinfo2[i].value.replace(/ /g,"") != "") {
				arrOcinfoList2[i] = stOcinfo2[i].value;
			}
		}

		for(var i=0; i < stOcinfo3.length;i++) {
			if(stOcinfo3[i].value.replace(/ /g,"") != "") {
				arrOcinfoList3[i] = stOcinfo3[i].value;
			}
		}

		for(var i=0; i < stOcinfo4.length;i++) {
			if(stOcinfo4[i].value.replace(/ /g,"") != "") {
				arrOcinfoList4[i] = stOcinfo4[i].value;
			}
		}

		$("stOcinfo1").value = arrOcinfoList1.join("|#|").trim();
		$("stOcinfo2").value = arrOcinfoList2.join("|#|").trim();
		$("stOcinfo3").value = arrOcinfoList3.join("|#|").trim();
		$("stOcinfo4").value = arrOcinfoList4.join("|#|").trim();


		pform.submit();

	}

	function searchZip(post1, post2, addr){
		var url = "/search/searchZip.do";
		url += "?mode=form";
		url += "&zipCodeName1=pform." + post1;
		url += "&zipCodeName2=pform." + post2;
		url += "&zipAddr=pform." + addr;
		pwinpop = popWin(url,"cPop","400","250","yes","yes");
	}
	// 전공분야, 경력사항, 저서 항목 추가 [기존 로직 그대로 사용함]
	function addTextBox(objId) {
		var tdObj = $(objId);
		var printBr1 = "<br />";
		var printBr2 = "<br />";
		var printBr3 = "<br />";

		if(ocinfo2 == 3) {
			printBr1 = "";
		}
		if(ocinfo3 == 3) {
			printBr2 = "";
		}
		if(ocinfo4 == 3) {
			printBr3 = "";
		}

		switch(objId){
			case "dyBox2":
				tdObj.innerHTML += printBr1 + (ocinfo2+1) + ". " + "<input type=\"text\" name=\"ocinfo2\" id=\"ocinfo2_" + ocinfo2 + "\" style=\"width:350px\" class=\"textfield\">";
				ocinfo2++;
				break;				
			case "dyBox3":
				tdObj.innerHTML += printBr2 + (ocinfo3+1) + ". " + "<input type=\"text\" name=\"ocinfo3\" id=\"ocinfo3_" + ocinfo3 + "\" style=\"width:350px\" class=\"textfield\">";
				ocinfo3++;
				break;
			case "dyBox4":
				tdObj.innerHTML += printBr3 + (ocinfo4+1) + ". " + "<input type=\"text\" name=\"ocinfo4\" id=\"ocinfo4_" + ocinfo4 + "\" style=\"width:350px\" class=\"textfield\">";
				ocinfo4++;
				break;
		}
	}
	//-->
	</script>
<jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>