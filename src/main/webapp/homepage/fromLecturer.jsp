<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr"%>
<%@ page import="ut.lib.util.* "%>
<%@ page import="ut.lib.support.* "%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%
	String fileUploadPath = ut.lib.util.Constants.UPLOADDIR_HOMEPAGE + "lecturer/";
	DataMap memberInfo = (DataMap)request.getAttribute("LECTURER_LIST");
	memberInfo.setNullToInitialize(true);

	DataMap mapLecturerHistoryList1 = (DataMap)request.getAttribute("LECTURER_HISTORY_LIST1");
	DataMap mapLecturerHistoryList2 = (DataMap)request.getAttribute("LECTURER_HISTORY_LIST2");
	DataMap mapLecturerHistoryList3 = (DataMap)request.getAttribute("LECTURER_HISTORY_LIST3");
	DataMap mapLecturerHistoryList4 = (DataMap)request.getAttribute("LECTURER_HISTORY_LIST4");

	int mapLecturerHistoryList2count = mapLecturerHistoryList2.keySize("seqno");
	int mapLecturerHistoryList3count = mapLecturerHistoryList3.keySize("seqno");
	int mapLecturerHistoryList4count = mapLecturerHistoryList4.keySize("seqno");

	mapLecturerHistoryList1.setNullToInitialize(true);
	mapLecturerHistoryList2.setNullToInitialize(true);
	mapLecturerHistoryList3.setNullToInitialize(true);
	mapLecturerHistoryList4.setNullToInitialize(true);

	String name = Util.getValue(memberInfo.getString("name"));
	String cname = Util.getValue(memberInfo.getString("cname"));
	String birth = Util.getValue(memberInfo.getString("birth"));
/*
	String birth1 = "";
	String birth2 = "";
	String birth3 = "";
	if(!"".equals(birth) && birth.length() == 8) {
		birth1 = Util.getValue(birth.substring(0,4));
		birth2 = Util.getValue(birth.substring(4,6));
		birth3 = Util.getValue(birth.substring(6,8));
	}
*/
	String seqno = Util.getValue(memberInfo.getString("seqno"));
	String sex = Util.getValue(memberInfo.getString("sex"));
	String job = Util.getValue(memberInfo.getString("job"));
	String degree = Util.getValue(memberInfo.getString("degree"));
	String gubun = Util.getValue(memberInfo.getString("gubun"));
	String email = Util.getValue(memberInfo.getString("email"));
	String emailTemp[] = new String[1];
	String emailId = "";
	String emailHost = "";
	try {
		emailTemp = email.split("@");
		emailId = Util.getValue(emailTemp[0]);
		emailHost = Util.getValue(emailTemp[1]);
	} catch(Exception e) {
		emailId = "";
		emailHost = "";
	}
	String hp = Util.getValue(memberInfo.getString("hp"));
	String home_tel = Util.getValue(memberInfo.getString("homeTel"));
	String homePost1 = Util.getValue(memberInfo.getString("homePost1"));
	String homePost2 = Util.getValue(memberInfo.getString("homePost2"));
	String homeAddr = Util.getValue(memberInfo.getString("homeAddr"));
	String officeTel = Util.getValue(memberInfo.getString("officeTel"));
	String officePost1 = Util.getValue(memberInfo.getString("officePost1"));
	String officePost2 = Util.getValue(memberInfo.getString("officePost2"));
	String officeAddr = Util.getValue(memberInfo.getString("officeAddr"));

	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.

	DataMap fileMap = (DataMap)request.getAttribute("FILE_GROUP_LIST");
	if(fileMap == null)
		fileMap = new DataMap();
	fileMap.setNullToInitialize(true);

	for(int i=0; i < fileMap.keySize("groupfileNo"); i++){
		
		if(fileMap.getInt("groupfileNo", i)==0){
			continue;
		}
		
		tmpStr = fileMap.getString("groupfileNo", i) + "#" + fileMap.getString("fileNo", i); 
// 		fileStr += "document.InnoDS.AddTempFile('" + fileMap.getString("fileName", i) + "', " + fileMap.getInt("fileSize", i) + ", '" + tmpStr + "');";
// 		fileStr += "g_ExistFiles['" + tmpStr + "'] = false;";

        fileStr += "var input"+i+" = document.createElement('input');\n";
		fileStr += "input"+i+".value='"+fileMap.getString("fileName", i)+"';\n";
		fileStr += "input"+i+".setAttribute('fileNo', '"+tmpStr+"');\n";
		fileStr += "input"+i+".name='existFile';\n";
		fileStr += "multi_selector.addListRow(input"+i+");\n\n";
	}
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
              <h2>강사등록조회</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 홈페이지 이용안내 &gt; <span>강사등록조회</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<div id="content">
			<form id="pform" name="pform" method="post" action="/homepage/lecturer.do" enctype="multipart/form-data">
			<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
			<input type="hidden" name="INNO_SAVE_DIR"		value='<%=fileUploadPath%>' />
			<input type="hidden" name="mode"		value='update' />
			<script event="OnUploadComplete" for="InnoDS">
				InnoDSSubmit(document.pform);
			</script>
				<div class="h30"></div>
				<p><img src="/images/skin4/sub/join_tt1.gif" alt="인적사항" /> </p>
                    <table class="personal" border="1" cellspacing="0" summary="인적사항 입력표">
                        <tr class="first-child">
                            <th>
                                <span>■</span>성명(한글)
                            </th>
                            <td>
                                <div class="help_wrap">
                                    <input type="text" name="name" id="name" class="input_text w157" maxlength="18" value="<%=name%>" readonly="readonly"/> 이름변경불가
                                </div>
                            </td>
							<th>
                                <span>■</span>성명(한자)
                            </th>
                            <td>
                                <div class="help_wrap">
                                    <input type="text" name="cname" id="cname" class="input_text w157" maxlength="18" value="<%=cname%>"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>생년월일
                            </th>
                            <td>
								<input type="text" name="birth" id="birth" class="input_text w157" maxlength="18" value="<%=birth%>" readonly="readonly"/> 생일변경불가
                            </td>
							<th>
                                <span>■</span>성별
                            </th>
                            <td>
								<select id="sex" name="sex" style="width: 100px; height: 22px">
									<option value="">**선택하세요**</option>
									<option value="M" <%="M".equals(sex) ? "selected='selected'":""%>>남</option>
									<option value="F" <%="F".equals(sex) ? "selected='selected'":""%>>여</option>
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
										<option value="교수" <%="교수".equals(job) ? "selected='selected'":""%>>교수</option>
										<option value="본청 공무원" <%="본청 공무원".equals(job) ? "selected='selected'":""%>>본청 공무원</option>
										<option value="군구 공무원" <%="군구 공무원".equals(job) ? "selected='selected'":""%>>군구 공무원</option>
										<option value="중앙/타시도 공무원" <%="중앙/타시도 공무원".equals(job) ? "selected='selected'":""%>>중앙/타시도 공무원</option>
										<option value="유관기관" <%="유관기관".equals(job) ? "selected='selected'":""%>>유관기관</option>
										<option value="기타" <%="기타".equals(job) ? "selected='selected'":""%>>기타</option>
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
										<option value="01" <%="01".equals(degree) ? "selected='selected'":""%>>박사
										<option value="02" <%="02".equals(degree) ? "selected='selected'":""%>>석사
										<option value="03" <%="03".equals(degree) ? "selected='selected'":""%>>대졸
										<option value="04" <%="04".equals(degree) ? "selected='selected'":""%>>대재.퇴,초대졸
										<option value="05" <%="05".equals(degree) ? "selected='selected'":""%>>고졸
										<option value="06" <%="06".equals(degree) ? "selected='selected'":""%>>중졸이하
										<option value="07" <%="07".equals(degree) ? "selected='selected'":""%>>기타
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
										<option value="001" <%="001".equals(gubun) ? "selected='selected'":""%>>일반행정</option>
										<option value="002" <%="002".equals(gubun) ? "selected='selected'":""%>>정치·외교·안보</option>
										<option value="003" <%="003".equals(gubun) ? "selected='selected'":""%>>경영·경제·통계</option>
										<option value="004" <%="004".equals(gubun) ? "selected='selected'":""%>>사회</option>
										<option value="005" <%="005".equals(gubun) ? "selected='selected'":""%>>교육</option>
										<option value="006" <%="006".equals(gubun) ? "selected='selected'":""%>>법률</option>
										<option value="007" <%="007".equals(gubun) ? "selected='selected'":""%>>철학·윤리·종교</option>
										<option value="008" <%="008".equals(gubun) ? "selected='selected'":""%>>과학·기술·정보</option>
										<option value="009" <%="009".equals(gubun) ? "selected='selected'":""%>>보건·복지·환경</option>
										<option value="010" <%="010".equals(gubun) ? "selected='selected'":""%>>교통·지리</option>
										<option value="011" <%="011".equals(gubun) ? "selected='selected'":""%>>역사</option>
										<option value="012" <%="012".equals(gubun) ? "selected='selected'":""%>>문화·관광·예술·문학</option>
										<option value="013" <%="013".equals(gubun) ? "selected='selected'":""%>>노동·건설</option>
										<option value="014" <%="014".equals(gubun) ? "selected='selected'":""%>>언론·홍보</option>
										<option value="015" <%="015".equals(gubun) ? "selected='selected'":""%>>외국어</option>
										<option value="016" <%="016".equals(gubun) ? "selected='selected'":""%>>기타</option>
									</select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>이메일
                            </th>
                            <td colspan="3">
                                <div class="pw_mail"><input type="text" style="ime-mode: disabled; height:15px; width:150px;" name="txtEmailID" id="txtEmailID" class="input_text w88" title="이메일 ID입력" maxlength="50" value="<%=emailId%>"/>
                                    @
                                    <input type="text" style="ime-mode:disabled;height:15px;" id="email1" name="email1" class="input_text w130" title="이메일 호스트입력" value="<%=emailHost%>"/>
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
                                    <input maxlength="15" type="text" id="hp" name="hp" style="height:15px;width:120px;" class="input_text w88" title="핸드폰번호" value="<%=hp%>"/>&nbsp;ex) 010xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>자택 연락처
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="home_tel" name="home_tel" style="height:15px;width:120px;" class="input_text w88" title="전화번호"  value="<%=home_tel%>"/>&nbsp;ex) 032xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>자택 주소
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" name="homePost1" id="homePost1" maxlength="3" style="width:30px" class="textfield" readonly="readonly" value="<%=homePost1%>" /> -
									<input type="text" name="homePost2" id="homePost2" maxlength="3" style="width:30px" class="textfield"readonly="readonly" value="<%=homePost2%>"/>
									<input type="button" value="주소검색" class="boardbtn1" onclick="searchZip('homePost1','homePost2','homeAddr');" />
									<br />
									<input type="text" name="homeAddr" id="homeAddr" style="width:500px" class="textfield" maxlength="100" readonly="readonly" value="<%=homeAddr%>"/>	
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ■&nbsp;&nbsp;사무실 연락처
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="office_tel" name="office_tel" style="height:15px;width:120px;" class="input_text w88" title="사무실번호" value="<%=officeTel%>" />&nbsp;ex) 032xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ■&nbsp;&nbsp;사무실 주소
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" id="officePost1" name="officePost1" maxlength="3" style="width:30px" class="textfield" readonly="readonly" value="<%=officePost1%>"/> -
									<input type="text" id="officePost2" name="officePost2" maxlength="3" style="width:30px" class="textfield" readonly="readonly" value="<%=officePost2%>"/>
									<input type="button" value="주소검색" class="boardbtn1" onclick="searchZip('officePost1','officePost2','officeAddr');" />
									<br />
									<input type="text" id="officeAddr" name="officeAddr" style="width:500px" class="textfield" maxlength="100" readonly="readonly" value="<%=officeAddr%>"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ■&nbsp;&nbsp;학력
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" id="ocinfo1_0" name="ocinfo1" style="width:350px" class="textfield" maxlength="1000" value="<%=Util.getValue(mapLecturerHistoryList1.getString("ocinfo", 0))%>"/><br />
									<input type="text" id="ocinfo1_1" name="ocinfo1" style="width:350px" class="textfield" maxlength="1000" value="<%=Util.getValue(mapLecturerHistoryList1.getString("ocinfo", 1))%>"/><br />
									<input type="text" id="ocinfo1_2" name="ocinfo1" style="width:350px" class="textfield" maxlength="1000" value="<%=Util.getValue(mapLecturerHistoryList1.getString("ocinfo", 2))%>"/>
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
									<% for(int i=0; i < mapLecturerHistoryList2.keySize("seqno"); i++){ %>
									<%=(i+1)%>. <input type="text" id="ocinfo2_<%=i%>" name="ocinfo2" style="width:350px" class="textfield" value="<%=Util.getValue(mapLecturerHistoryList2.getString("ocinfo", i))%>"/><br />
									<% } %>
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
									<% for(int i=0; i < mapLecturerHistoryList3.keySize("seqno"); i++){ %>
									<%=(i+1)%>. <input type="text" id="ocinfo3_<%=i%>" name="ocinfo3" style="width:350px" class="textfield" value="<%=Util.getValue(mapLecturerHistoryList3.getString("ocinfo", i))%>"/><br />
									<% } %>
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
									<% for(int i=0; i < mapLecturerHistoryList4.keySize("seqno"); i++){ %>
									<%=(i+1)%>. <input type="text" id="ocinfo4_<%=i%>" name="ocinfo4" style="width:350px" class="textfield" value="<%=Util.getValue(mapLecturerHistoryList4.getString("ocinfo", i))%>"/><br />
									<% } %>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>■</span>비밀번호
                            </th>
                            <td colspan="3">
                                <div class="help_wrap upw"><input maxlength="30" style="height:15px;" type="password"  id="passwd" name="passwd" class="input_text w157" /> (다시입력해주세요.)</div>
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
					<p style="text-align:center;"><input type="button" value="저장" onclick="goSave();"/><input type="button" value="취소" onclick="goCancle();"/></P>
					<br />
			</div>
				<input type="hidden" id="stOcinfo1" name="stOcinfo1" />
				<input type="hidden" id="stOcinfo2" name="stOcinfo2" />
				<input type="hidden" id="stOcinfo3" name="stOcinfo3" />
				<input type="hidden" id="stOcinfo4" name="stOcinfo4" />
				<input type="hidden" id="seqno" name="seqno" value="<%=seqno%>"/>
			</form>
            <!-- //contnet -->
          </div>
        </div>
    </div>
	<script language="JavaScript"> 
	<!--
	var ocinfo2 = <%=mapLecturerHistoryList2count%>;
	var ocinfo3 = <%=mapLecturerHistoryList3count%>;
	var ocinfo4 = <%=mapLecturerHistoryList4count%>;
	function goSave() {
		if($("cname").value.replace(/ /g,"") == "") {
			alert("성명(한자)를 입력해주세요.");
			$("cname").focus();
			return;
		}
		if($("birth").value == "") {
			alert("생년월일을 입력해주세요.");
			$("birth1").focus();
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

		$("pform").submit();

	}
	var g_ExistFiles = new Array();
	function OnInnoDSLoad(){
	}
	//로딩시.
	onload = function()	{
		<%= fileStr %>
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

		if(ocinfo2 == <%=mapLecturerHistoryList2count%>) {
			printBr1 = "";
		}
		if(ocinfo3 == <%=mapLecturerHistoryList3count%>) {
			printBr2 = "";
		}
		if(ocinfo4 == <%=mapLecturerHistoryList4count%>) {
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
	function goCancle() {
		if(confirm("조회 페이지로 이동 하시겠습니까?")) {
			document.location.href = "/homepage/lecturer.do?mode=lecturerSearch";
		}
	}
	//-->
	</script>
<jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>