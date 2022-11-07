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

	//���� ���� START
	String fileStr = "";
	String tmpStr = ""; //�Ѿ�� ��.

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
          <div class="sub_visual7">Ȩ������ �̿�ȳ�</div>
            <div class="local">
              <h2>��������ȸ</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; Ȩ������ �̿�ȳ� &gt; <span>��������ȸ</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<div id="content">
			<form id="pform" name="pform" method="post" action="/homepage/lecturer.do" enctype="multipart/form-data">
			<!-- INNO FILEUPLOAD ���� UPLOAD ��� ��������.-->
			<input type="hidden" name="INNO_SAVE_DIR"		value='<%=fileUploadPath%>' />
			<input type="hidden" name="mode"		value='update' />
			<script event="OnUploadComplete" for="InnoDS">
				InnoDSSubmit(document.pform);
			</script>
				<div class="h30"></div>
				<p><img src="/images/skin4/sub/join_tt1.gif" alt="��������" /> </p>
                    <table class="personal" border="1" cellspacing="0" summary="�������� �Է�ǥ">
                        <tr class="first-child">
                            <th>
                                <span>��</span>����(�ѱ�)
                            </th>
                            <td>
                                <div class="help_wrap">
                                    <input type="text" name="name" id="name" class="input_text w157" maxlength="18" value="<%=name%>" readonly="readonly"/> �̸�����Ұ�
                                </div>
                            </td>
							<th>
                                <span>��</span>����(����)
                            </th>
                            <td>
                                <div class="help_wrap">
                                    <input type="text" name="cname" id="cname" class="input_text w157" maxlength="18" value="<%=cname%>"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>�������
                            </th>
                            <td>
								<input type="text" name="birth" id="birth" class="input_text w157" maxlength="18" value="<%=birth%>" readonly="readonly"/> ���Ϻ���Ұ�
                            </td>
							<th>
                                <span>��</span>����
                            </th>
                            <td>
								<select id="sex" name="sex" style="width: 100px; height: 22px">
									<option value="">**�����ϼ���**</option>
									<option value="M" <%="M".equals(sex) ? "selected='selected'":""%>>��</option>
									<option value="F" <%="F".equals(sex) ? "selected='selected'":""%>>��</option>
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
										<option value="����" <%="����".equals(job) ? "selected='selected'":""%>>����</option>
										<option value="��û ������" <%="��û ������".equals(job) ? "selected='selected'":""%>>��û ������</option>
										<option value="���� ������" <%="���� ������".equals(job) ? "selected='selected'":""%>>���� ������</option>
										<option value="�߾�/Ÿ�õ� ������" <%="�߾�/Ÿ�õ� ������".equals(job) ? "selected='selected'":""%>>�߾�/Ÿ�õ� ������</option>
										<option value="�������" <%="�������".equals(job) ? "selected='selected'":""%>>�������</option>
										<option value="��Ÿ" <%="��Ÿ".equals(job) ? "selected='selected'":""%>>��Ÿ</option>
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
										<option value="01" <%="01".equals(degree) ? "selected='selected'":""%>>�ڻ�
										<option value="02" <%="02".equals(degree) ? "selected='selected'":""%>>����
										<option value="03" <%="03".equals(degree) ? "selected='selected'":""%>>����
										<option value="04" <%="04".equals(degree) ? "selected='selected'":""%>>����.��,�ʴ���
										<option value="05" <%="05".equals(degree) ? "selected='selected'":""%>>����
										<option value="06" <%="06".equals(degree) ? "selected='selected'":""%>>��������
										<option value="07" <%="07".equals(degree) ? "selected='selected'":""%>>��Ÿ
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
										<option value="001" <%="001".equals(gubun) ? "selected='selected'":""%>>�Ϲ�����</option>
										<option value="002" <%="002".equals(gubun) ? "selected='selected'":""%>>��ġ���ܱ����Ⱥ�</option>
										<option value="003" <%="003".equals(gubun) ? "selected='selected'":""%>>�濵�����������</option>
										<option value="004" <%="004".equals(gubun) ? "selected='selected'":""%>>��ȸ</option>
										<option value="005" <%="005".equals(gubun) ? "selected='selected'":""%>>����</option>
										<option value="006" <%="006".equals(gubun) ? "selected='selected'":""%>>����</option>
										<option value="007" <%="007".equals(gubun) ? "selected='selected'":""%>>ö�С�����������</option>
										<option value="008" <%="008".equals(gubun) ? "selected='selected'":""%>>���С����������</option>
										<option value="009" <%="009".equals(gubun) ? "selected='selected'":""%>>���ǡ�������ȯ��</option>
										<option value="010" <%="010".equals(gubun) ? "selected='selected'":""%>>���롤����</option>
										<option value="011" <%="011".equals(gubun) ? "selected='selected'":""%>>����</option>
										<option value="012" <%="012".equals(gubun) ? "selected='selected'":""%>>��ȭ������������������</option>
										<option value="013" <%="013".equals(gubun) ? "selected='selected'":""%>>�뵿���Ǽ�</option>
										<option value="014" <%="014".equals(gubun) ? "selected='selected'":""%>>��С�ȫ��</option>
										<option value="015" <%="015".equals(gubun) ? "selected='selected'":""%>>�ܱ���</option>
										<option value="016" <%="016".equals(gubun) ? "selected='selected'":""%>>��Ÿ</option>
									</select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>�̸���
                            </th>
                            <td colspan="3">
                                <div class="pw_mail"><input type="text" style="ime-mode: disabled; height:15px; width:150px;" name="txtEmailID" id="txtEmailID" class="input_text w88" title="�̸��� ID�Է�" maxlength="50" value="<%=emailId%>"/>
                                    @
                                    <input type="text" style="ime-mode:disabled;height:15px;" id="email1" name="email1" class="input_text w130" title="�̸��� ȣ��Ʈ�Է�" value="<%=emailHost%>"/>
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
                                    <input maxlength="15" type="text" id="hp" name="hp" style="height:15px;width:120px;" class="input_text w88" title="�ڵ�����ȣ" value="<%=hp%>"/>&nbsp;ex) 010xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>���� ����ó
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="home_tel" name="home_tel" style="height:15px;width:120px;" class="input_text w88" title="��ȭ��ȣ"  value="<%=home_tel%>"/>&nbsp;ex) 032xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>���� �ּ�
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" name="homePost1" id="homePost1" maxlength="3" style="width:30px" class="textfield" readonly="readonly" value="<%=homePost1%>" /> -
									<input type="text" name="homePost2" id="homePost2" maxlength="3" style="width:30px" class="textfield"readonly="readonly" value="<%=homePost2%>"/>
									<input type="button" value="�ּҰ˻�" class="boardbtn1" onclick="searchZip('homePost1','homePost2','homeAddr');" />
									<br />
									<input type="text" name="homeAddr" id="homeAddr" style="width:500px" class="textfield" maxlength="100" readonly="readonly" value="<%=homeAddr%>"/>	
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�繫�� ����ó
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="office_tel" name="office_tel" style="height:15px;width:120px;" class="input_text w88" title="�繫�ǹ�ȣ" value="<%=officeTel%>" />&nbsp;ex) 032xxxxxxx 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�繫�� �ּ�
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" id="officePost1" name="officePost1" maxlength="3" style="width:30px" class="textfield" readonly="readonly" value="<%=officePost1%>"/> -
									<input type="text" id="officePost2" name="officePost2" maxlength="3" style="width:30px" class="textfield" readonly="readonly" value="<%=officePost2%>"/>
									<input type="button" value="�ּҰ˻�" class="boardbtn1" onclick="searchZip('officePost1','officePost2','officeAddr');" />
									<br />
									<input type="text" id="officeAddr" name="officeAddr" style="width:500px" class="textfield" maxlength="100" readonly="readonly" value="<%=officeAddr%>"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�з�
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
                                ��&nbsp;&nbsp;�����о�
								<div style="text-align:center;"><input type="button" value="�� ��" class="boardbtn1" onclick="addTextBox('dyBox2');" /></div>
                            </th>
                            <td colspan="3" id="dyBox2">
                                <div class="help_wrap">
									<font color="red">������ ��������� �����Ͻø� �˴ϴ�.</font><br />
									<% for(int i=0; i < mapLecturerHistoryList2.keySize("seqno"); i++){ %>
									<%=(i+1)%>. <input type="text" id="ocinfo2_<%=i%>" name="ocinfo2" style="width:350px" class="textfield" value="<%=Util.getValue(mapLecturerHistoryList2.getString("ocinfo", i))%>"/><br />
									<% } %>
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
									<% for(int i=0; i < mapLecturerHistoryList3.keySize("seqno"); i++){ %>
									<%=(i+1)%>. <input type="text" id="ocinfo3_<%=i%>" name="ocinfo3" style="width:350px" class="textfield" value="<%=Util.getValue(mapLecturerHistoryList3.getString("ocinfo", i))%>"/><br />
									<% } %>
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
									<% for(int i=0; i < mapLecturerHistoryList4.keySize("seqno"); i++){ %>
									<%=(i+1)%>. <input type="text" id="ocinfo4_<%=i%>" name="ocinfo4" style="width:350px" class="textfield" value="<%=Util.getValue(mapLecturerHistoryList4.getString("ocinfo", i))%>"/><br />
									<% } %>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>��й�ȣ
                            </th>
                            <td colspan="3">
                                <div class="help_wrap upw"><input maxlength="30" style="height:15px;" type="password"  id="passwd" name="passwd" class="input_text w157" /> (�ٽ��Է����ּ���.)</div>
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
					<p style="text-align:center;"><input type="button" value="����" onclick="goSave();"/><input type="button" value="���" onclick="goCancle();"/></P>
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
			alert("����(����)�� �Է����ּ���.");
			$("cname").focus();
			return;
		}
		if($("birth").value == "") {
			alert("��������� �Է����ּ���.");
			$("birth1").focus();
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

		$("pform").submit();

	}
	var g_ExistFiles = new Array();
	function OnInnoDSLoad(){
	}
	//�ε���.
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
	// �����о�, ��»���, ���� �׸� �߰� [���� ���� �״�� �����]
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
		if(confirm("��ȸ �������� �̵� �Ͻðڽ��ϱ�?")) {
			document.location.href = "/homepage/lecturer.do?mode=lecturerSearch";
		}
	}
	//-->
	</script>
<jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>