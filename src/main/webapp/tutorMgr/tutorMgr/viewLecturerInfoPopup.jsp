<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr"%>
<%@ page import="ut.lib.util.* "%>
<%@ page import="ut.lib.support.* "%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>��õ������ ���簳�߿�</title>
<link  type="text/css" href="/homepage_new/css/sub.css" rel="stylesheet" charset="euc-kr">
<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<script type="text/javascript">
	<!--
		function goPrint() {
			window.print();
		}
	//-->
</script>
</head>
<%
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
	String seqno = Util.getValue(memberInfo.getString("seqno"));
	String sex = Util.getValue(memberInfo.getString("sex"));
	String job = Util.getValue(memberInfo.getString("job"));
	String degree = Util.getValue(memberInfo.getString("degree"));
	String gubun = Util.getValue(memberInfo.getString("gubun"));
	String email = Util.getValue(memberInfo.getString("email"));
	String hp = Util.getValue(memberInfo.getString("hp"));
	String home_tel = Util.getValue(memberInfo.getString("homeTel"));
	String homePost1 = Util.getValue(memberInfo.getString("homePost1"));
	String homePost2 = Util.getValue(memberInfo.getString("homePost2"));
	String homeAddr = Util.getValue(memberInfo.getString("homeAddr"));
	String officeTel = Util.getValue(memberInfo.getString("officeTel"));
	String officePost1 = Util.getValue(memberInfo.getString("officePost1"));
	String officePost2 = Util.getValue(memberInfo.getString("officePost2"));
	String officeAddr = Util.getValue(memberInfo.getString("officeAddr"));
	String fileStr = "";

	DataMap fileMap = (DataMap)request.getAttribute("FILE_GROUP_LIST");
	if(fileMap == null)
		fileMap = new DataMap();
	fileMap.setNullToInitialize(true);

	if(fileMap.keySize() > 0) {
		for(int i=0; i < fileMap.keySize(); i++){
			fileStr = fileMap.getString("fileNo", i) + " ������ : " + " " + fileMap.getString("fileName", i) +" <a href=\"javascript:fileDownloadPopup("+fileMap.getString("groupfileNo", i)+");\"> <img src=\"/images/skin4/icon/icon_fileDwn.gif\" alt=\"�ѱ�file ÷��\" /></a>";
		}
	} else {
		fileStr = "÷�ε� ������ �����ϴ�.";
	}
%>
<body>
    <div id="subContainer">
    <div class="subNavi_area" style="width:4px; margin:5px;padding:0px;">
      </div>
        <div id="contnets_area">
            <div class="local">
              <h2>�Ⱝ�����ȸ</h2>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<div id="content">
			<form id="pform" name="pform" method="post" action="/homepage/lecturer.do" enctype="multipart/form-data">
				<div class="h30"></div>
				<p><img src="/images/skin4/sub/join_tt1.gif" alt="��������" /> </p>
                    <table class="personal" border="1" cellspacing="0" summary="�������� �Է�ǥ">
                        <tr class="first-child">
                            <th>
                                <span>��</span>����(�ѱ�)
                            </th>
                            <td>
                                <div class="help_wrap">
                                    <input type="text" name="name" id="name" class="input_text w157" maxlength="18" value="<%=name%>" readonly="readonly"/>
                                </div>
                            </td>
							<th>
                                <span>��</span>����(����)
                            </th>
                            <td>
                                <div class="help_wrap">
                                    <input type="text" name="cname" id="cname" class="input_text w157" maxlength="18" value="<%=cname%>" readonly="readonly"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>�������
                            </th>
                            <td>
								<input type="text" name="birth" id="birth" class="input_text w157" maxlength="18" value="<%=birth%>" readonly="readonly"/>
                            </td>
							<th>
                                <span>��</span>����
                            </th>
                            <td>
								<select id="sex" name="sex" style="width: 100px; height: 22px" disabled="disabled">
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
									<select id="job" name="job" style="width:150px" disabled="disabled">
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
									<select id="degree" name="degree" style="width:110px" disabled="disabled">
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
									<select id="gubun" name="gubun" style="width:150px" disabled="disabled">
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
                                <div class="pw_mail"><input type="text" style="ime-mode: disabled; height:15px; width:150px;" name="txtEmailID" id="txtEmailID" class="input_text w88" title="�̸��� ID�Է�" maxlength="50" value="<%=email%>" readonly="readonly"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>�ڵ��� 
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="hp" name="hp" style="height:15px;width:120px;" class="input_text w88" title="�ڵ�����ȣ" value="<%=hp%>" readonly="readonly"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>���� ����ó
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="home_tel" name="home_tel" style="height:15px;width:120px;" class="input_text w88" title="��ȭ��ȣ"  value="<%=home_tel%>" readonly="readonly"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span>��</span>���� �ּ�
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" name="homePost1" id="homePost1" maxlength="5" style="width:60px" class="textfield" readonly="readonly" value="<%=homePost1%>" readonly="readonly"/>
									<br />
									<input type="text" name="homeAddr" id="homeAddr" style="width:500px" class="textfield" maxlength="100" readonly="readonly" value="<%=homeAddr%>" readonly="readonly"/>	
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�繫�� ����ó
                            </th>
                            <td  colspan="3">
                                <div class="help_wrap" >
                                    <input maxlength="15" type="text" id="office_tel" name="office_tel" style="height:15px;width:120px;" class="input_text w88" title="�繫�ǹ�ȣ" value="<%=officeTel%>" readonly="readonly"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�繫�� �ּ�
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<input type="text" id="officePost1" name="officePost1" maxlength="5" style="width:60px" class="textfield" readonly="readonly" value="<%=officePost1%>" readonly="readonly"/>
									<input type="text" id="officeAddr" name="officeAddr" style="width:500px" class="textfield" maxlength="100" readonly="readonly" value="<%=officeAddr%>" readonly="readonly"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�з�
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<% if(mapLecturerHistoryList1.keySize("seqno") > 0) { %>
									<input type="text" id="ocinfo1_0" name="ocinfo1" style="width:350px" class="textfield" maxlength="1000" value="<%=Util.getValue(mapLecturerHistoryList1.getString("ocinfo", 0))%>" readonly="readonly"/><br />
									<input type="text" id="ocinfo1_1" name="ocinfo1" style="width:350px" class="textfield" maxlength="1000" value="<%=Util.getValue(mapLecturerHistoryList1.getString("ocinfo", 1))%>" readonly="readonly"/><br />
									<input type="text" id="ocinfo1_2" name="ocinfo1" style="width:350px" class="textfield" maxlength="1000" value="<%=Util.getValue(mapLecturerHistoryList1.getString("ocinfo", 2))%>" readonly="readonly"/>
									<% } else { %>
										����� �з��� �����ϴ�.
									<% }%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�����о�
                            </th>
                            <td colspan="3" id="dyBox2">
                                <div class="help_wrap">
									<% if(mapLecturerHistoryList2.keySize("seqno") > 0) { %>
										<% for(int i=0; i < mapLecturerHistoryList2.keySize("seqno"); i++){ %>
										<%=(i+1)%>. <input type="text" id="ocinfo2_<%=i%>" name="ocinfo2" style="width:350px" class="textfield" value="<%=Util.getValue(mapLecturerHistoryList2.getString("ocinfo", i))%>" readonly="readonly"/><br />
										<% } %>
									<% } else { %>
										����� �����о߰� �����ϴ�.
									<% }%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;��»���
                            </th>
                            <td colspan="3" id="dyBox3">
                                <div class="help_wrap">
								<% if(mapLecturerHistoryList3.keySize("seqno") > 0) { %>
									<% for(int i=0; i < mapLecturerHistoryList3.keySize("seqno"); i++){ %>
									<%=(i+1)%>. <input type="text" id="ocinfo3_<%=i%>" name="ocinfo3" style="width:350px" class="textfield" value="<%=Util.getValue(mapLecturerHistoryList3.getString("ocinfo", i))%>" readonly="readonly"/><br />
									<% } %>
								<% } else { %>
									����� ��»����� �����ϴ�.
								<% }%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;���� �� �ֿ��
                            </th>
                            <td colspan="3" id="dyBox4">
                                <div class="help_wrap">	
									<% if(mapLecturerHistoryList4.keySize("seqno") > 0) { %>
										<% for(int i=0; i < mapLecturerHistoryList4.keySize("seqno"); i++){ %>
										<%=(i+1)%>. <input type="text" id="ocinfo4_<%=i%>" name="ocinfo4" style="width:350px" class="textfield" value="<%=Util.getValue(mapLecturerHistoryList4.getString("ocinfo", i))%>" readonly="readonly"/><br />
										<% } %>
									<% } else { %>
										����� ���� �� �ֿ���� �����ϴ�.
									<% }%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                ��&nbsp;&nbsp;�ڱ�Ұ��� ÷��
                            </th>
                            <td colspan="3">
                                <div class="help_wrap">
									<%=fileStr%>
								</div>
                            </td>
                        </tr>
                    </table>
					<p style="text-align:center;">
						<input type="button" value="���" onclick="goPrint();"/>
						<input type="button" value="�ݱ�" onclick="window.close();"/>
					</P>
					<br />
			</div>
			</form>
            <!-- //contnet -->
          </div>
        </div>
    </div>
</body>
</html>