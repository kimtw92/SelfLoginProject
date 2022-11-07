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
          <div class="sub_visual7">Ȩ������ �̿�ȳ�</div>
            <div class="local">
              <h2>������</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; Ȩ������ �̿�ȳ� &gt; <span>������</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<div id="content">
			<form id="pform" name="pform" method="post" action="/homepage/lecturer.do" enctype="multipart/form-data">
			<!-- INNO FILEUPLOAD ���� UPLOAD ��� ��������.-->
			<input type="hidden" name="INNO_SAVE_DIR"		value='<%=fileUploadPath%>' />
			<input type="hidden" name="mode"		value='save' />
				<div class="lecturer_tab01">
					<ul>
						<li><img src='/images/skin4/sub/lecturer_step01.gif'alt="�����û 1�ܰ�"></li>
						<li><img src='/images/skin4/sub/lecturer_step02.gif' alt="�����û 2�ܰ�"></li>
						<li><img src='/images/skin4/sub/lecturer_step03_on.gif' alt="�����û 3�ܰ�"></li>
						<li><img src='/images/skin4/sub/lecturer_step04.gif' alt="�����û 4�ܰ�"></li>
					</ul>
				</div>
				<div class="h30"></div>
				<p><img src="/images/skin4/sub/join_tt1.gif" alt="��������" /> </p>
                    <table class="personal" border="1" cellspacing="0" summary="�������� �Է�ǥ">
                        <tr class="first-child">
                            <th>
                                <span>��</span>����(�ѱ�)
                            </th>
                            <td>
                                <div class="help_wrap">
                                    <input type="text" name="name" id="name" class="input_text w157" maxlength="18"/>
                                </div>
                            </td>
							<th>
                                <span>��</span>����(����)
                            </th>
                            <td>
                                <div class="help_wrap">
                                    <input type="text" name="cname" id="cname" class="input_text w157" maxlength="18"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>�������
                            </th>
                            <td>
                                <select id="birth1" name="birth1" style="width:60px;height:22px">
									<option value="">����</option>
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
									<option value="">����</option>
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
									<option value="">����</option>
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
                                <span>��</span>����
                            </th>
                            <td>
								<select id="sex" name="sex" style="width: 100px; height: 22px">
									<option value="">**�����ϼ���**</option>
									<option value="M">��</option>
									<option value="F">��</option>
								</select>
                            </td>
						</tr>
                        <tr> 
                            <th>
                                <span>��</span>������
                            </th>
                            <td>
                                <div class="help_wrap">
									<select id="job" name="job" style="width:150px">
										<option value="">**�����ϼ���**</option>
										<option value="����">����</option>
										<option value="��û ������">��û ������</option>
										<option value="���� ������">���� ������</option>
										<option value="�߾�/Ÿ�õ� ������">�߾�/Ÿ�õ� ������</option>
										<option value="�������">�������</option>
										<option value="��Ÿ">��Ÿ</option>
									</select>
                                </div>
                            </td>
							<th>
                                <span>��</span>�� ��
                            </th>
                            <td>
                                <div class="help_wrap">
									<select id="degree" name="degree" style="width:110px">
										<option value="">**�����ϼ���**</option>
										<option value="01">�ڻ�
										<option value="02">����
										<option value="03">����
										<option value="04">����.��,�ʴ���
										<option value="05">����
										<option value="06">��������
										<option value="07">��Ÿ
									</select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>�Ⱝ�о�
                            </th> 
                            <td colspan="3">
                                <div class="help_wrap">
									<select id="gubun" name="gubun" style="width:150px">
										<option value="">**�����ϼ���**</option>
										<option value="001">�Ϲ�����</option>
										<option value="002">��ġ���ܱ����Ⱥ�</option>
										<option value="003">�濵�����������</option>
										<option value="004">��ȸ</option>
										<option value="005">����</option>
										<option value="006">����</option>
										<option value="007">ö�С�����������</option>
										<option value="008">���С����������</option>
										<option value="009">���ǡ�������ȯ��</option>
										<option value="010">���롤����</option>
										<option value="011">����</option>
										<option value="012">��ȭ������������������</option>
										<option value="013">�뵿���Ǽ�</option>
										<option value="014">��С�ȫ��</option>
										<option value="015">�ܱ���</option>
										<option value="016">��Ÿ</option>
									</select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>�̸���
                            </th>
                            <td colspan="3">
                                <div class="pw_mail"><input type="text" style="ime-mode: disabled; height:15px; width:150px;" name="txtEmailID" id="txtEmailID" class="input_text w88" title="�̸��� ID�Է�" maxlength="50" />
                                    @
                                    <input type="text" style="ime-mode:disabled;height:15px;" id="email1" name="email1" class="input_text w130" title="�̸��� ȣ��Ʈ�Է�" />
                                    <select id="email2" name="email2" style="width: 100px; height: 22px" onchange="document.getElementById('email1').value = this.value" class="input_text w130" >
                                        <option value="">�����Է�</option>
                                        <option value="hotmail.com">HOT</option>
                                        <option value="msn.co.kr">MSN</option>
                                        <option value="gmail.com">���۸���</option>
                                        <option value="naver.com">���̹�</option>
                                        <option value="nate.com">����Ʈ</option>
                                        <option value="daum.net">����</option>
                                        <option value="dreamwiz.com">�帲����</option>
                                        <option value="lycos.co.kr">�����ڽ�</option>
                                        <option value="yahoo.co.kr">����</option>
                                        <option value="empal.com">����</option>
                                        <option value="chol.com">õ����</option>
                                        <option value="korea.com">�ڸ��ƴ���</option>
                                        <option value="paran.com">�Ķ�</option>
                                        <option value="freechal.com">����ÿ</option>
                                        <option value="hanafos.com">�ϳ�����</option>
                                        <option value="hanmail.net">�Ѹ���</option>
                                        <option value="hanmir.com">�ѹ̸�</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>�ڵ��� 
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="hp" name="hp" style="height:15px;width:120px;" class="input_text w88" title="�ڵ�����ȣ" />&nbsp;ex) 010xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>���� ����ó
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="home_tel" name="home_tel" style="height:15px;width:120px;" class="input_text w88" title="��ȭ��ȣ" />&nbsp;ex) 032xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>���� �ּ�
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" name="homePost1" id="homePost1" maxlength="3" style="width:30px" class="textfield" value="" readonly="readonly" /> -
									<input type="text" name="homePost2" id="homePost2" maxlength="3" style="width:30px" class="textfield" value="" readonly="readonly" />
									<input type="button" value="�ּҰ˻�" class="boardbtn1" onclick="searchZip('homePost1','homePost2','homeAddr');" />
									<br />
									<input type="text" name="homeAddr" id="homeAddr" style="width:500px" class="textfield" value="" maxlength="100" readonly="readonly" />	
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�繫�� ����ó
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="office_tel" name="office_tel" style="height:15px;width:120px;" class="input_text w88" title="�繫�ǹ�ȣ" />&nbsp;ex) 032xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�繫�� �ּ�
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" id="officePost1" name="officePost1" maxlength="3" style="width:30px" class="textfield" value="" readonly="readonly" /> -
									<input type="text" id="officePost2" name="officePost2" maxlength="3" style="width:30px" class="textfield" value="" readonly="readonly" />
									<input type="button" value="�ּҰ˻�" class="boardbtn1" onclick="searchZip('officePost1','officePost2','officeAddr');" />
									<br />
									<input type="text" id="officeAddr" name="officeAddr" style="width:500px" class="textfield" value="" maxlength="100" readonly="readonly" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�з�
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
                                ��&nbsp;&nbsp;�����о�
								<div style="text-align:center;"><input type="button" value="�� ��" class="boardbtn1" onclick="addTextBox('dyBox2');" /></div>
                            </th>
                            <td colspan="3" id="dyBox2">
                                <div class="help_wrap">
									<font color="red">������ ��������� �����Ͻø� �˴ϴ�.</font><br />
									1. <input type="text" id="ocinfo2_0" name="ocinfo2" style="width:350px" class="textfield" /><br />
									2. <input type="text" id="ocinfo2_1" name="ocinfo2" style="width:350px" class="textfield" /><br />
									3. <input type="text" id="ocinfo2_2" name="ocinfo2" style="width:350px" class="textfield" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;��»���
								<div style="text-align:center;"><input type="button" value="�� ��" class="boardbtn1" onclick="addTextBox('dyBox3');" /></div>
                            </th>
                            <td colspan="3" id="dyBox3">
                                <div class="help_wrap">
									<font color="red">������ ��������� �����Ͻø� �˴ϴ�.</font><br />
									1. <input type="text" id="ocinfo3_0" name="ocinfo3" style="width:350px" class="textfield" maxlength="1000" /><br />
									2. <input type="text" id="ocinfo3_1" name="ocinfo3" style="width:350px" class="textfield" maxlength="1000" /><br />
									3. <input type="text" id="ocinfo3_2" name="ocinfo3" style="width:350px" class="textfield" maxlength="1000" />		
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;���� �� �ֿ��
								<div style="text-align:center;"><input type="button" value="�� ��" class="boardbtn1" onclick="addTextBox('dyBox4');" /></div>
                            </th>
                            <td colspan="3" id="dyBox4">
                                <div class="help_wrap">	
									<font color="red">������ ��������� �����Ͻø� �˴ϴ�.</font><br />
									1. <input type="text" id="ocinfo4_0" name="ocinfo4" style="width:350px" class="textfield" maxlength="1000" /><br />
									2. <input type="text" id="ocinfo4_1" name="ocinfo4" style="width:350px" class="textfield" maxlength="1000" /><br />
									3. <input type="text" id="ocinfo4_2" name="ocinfo4" style="width:350px" class="textfield" maxlength="1000" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>��й�ȣ
                            </th>
                            <td colspan="3">
                                <div class="help_wrap upw"><input maxlength="30" style="height:15px;" type="password"  id="passwd" name="passwd" class="input_text w157" /> ��û �̷� ��ȸ�� ���</div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>��й�ȣ Ȯ��
                            </th>
                            <td colspan="3">
                                <div class="help_wrap"><input maxlength="30" type="password" id="passwd_check" name="passwd_check" class="input_text w157" style="height:15px;" /> ��� �нǽ� ��ȸ �Ұ��� �մϴ�.</div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�ڱ�Ұ��� ÷��
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
                                	<jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>
									�ڱ�Ұ��� ÷��(DOC, HWP, pdf ������ ����)
								</div>
                            </td>
                        </tr>
                    </table>
					<p style="text-align:center;"><input type="button" value="����" onclick="goSave();"/></P>
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
			alert("����(�ѱ�)�� �Է����ּ���.");
			$("name").focus();
			return;
		}
		if($("cname").value.replace(/ /g,"") == "") {
			alert("����(����)�� �Է����ּ���.");
			$("cname").focus();
			return;
		}
		if($("birth1").value == "") {
			alert("������� (�⵵)�� �������ּ���.");
			$("birth1").focus();
			return;
		}
		if($("birth2").value == "") {
			alert("������� (��)�� �������ּ���.");
			$("birth2").focus();
			return;
		}
		if($("birth3").value == "") {
			alert("������� (��)�� �������ּ���.");
			$("birth3").focus();
			return;
		}
		if($("sex").value == "") {
			alert("������ �������ּ���.");
			$("sex").focus();
			return;
		}
		if($("job").value == "") {
			alert("�������� �������ּ���.");
			$("job").focus();
			return;
		}
		if($("degree").value == "") {
			alert("������ �������ּ���.");
			$("degree").focus();
			return;
		}
		if($("gubun").value == "") {
			alert("�Ⱝ�о߸� �������ּ���.");
			$("gubun").focus();
			return;
		}
		if($("txtEmailID").value.replace(/ /g,"") == "") {
			alert("�����ּ� ID�� �Է����ּ���.");
			$("txtEmailID").focus();
			return;
		}
		if($("email1").value.replace(/ /g,"") == "") {
			alert("�����ּ� �������� �����ϰų� �Է����ּ���.");
			$("email1").focus();
			return;
		}
		if($("hp").value.replace(/ /g,"") == "") {
			alert("�ڵ��� ��ȣ�� �Է����ּ���.");
			$("hp").focus();
			return;
		}
		if($("home_tel").value.replace(/ /g,"") == "") {
			alert("��ȭ��ȣ�� �Է����ּ���.");
			$("home_tel").focus();
			return;
		}
		if($("homePost1").value.replace(/ /g,"") == "") {
			alert("�ּҰ˻��� ���ּ���.");
			$("homePost1").focus();
			return;
		}
		if($("homePost2").value.replace(/ /g,"") == "") {
			alert("�ּҰ˻��� ���ּ���.");
			$("homePost2").focus();
			return;
		}
		if($("homeAddr").value.replace(/ /g,"") == "") {
			alert("���ּҸ� �Է����ּ���.");
			$("homeAddr").focus();
			return;
		}

		if($("passwd").value.replace(/ /g,"") == "") {
			alert("��й�ȣ�� �Է����ּ���.");
			$("passwd").focus();
			return;
		}
		if($("passwd_check").value.replace(/ /g,"") == "") {
			alert("��й�ȣ Ȯ���� �Է����ּ���.");
			$("passwd_check").focus();
			return;
		}
		if($("passwd").value != $("passwd_check").value) {
			alert("�Է��Ͻ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
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
	// �����о�, ��»���, ���� �׸� �߰� [���� ���� �״�� �����]
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