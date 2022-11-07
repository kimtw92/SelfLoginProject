<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%

// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMEM = (DataMap)request.getAttribute("MEM_DATA");
listMEM.setNullToInitialize(true);

DataMap deptMap = (DataMap)request.getAttribute("DEPT_DATA");
deptMap.setNullToInitialize(true);

DataMap listPART = (DataMap)request.getAttribute("PART_DATA");
listPART.setNullToInitialize(true);

DataMap infoMap = (DataMap)request.getAttribute("USER_INFO");
infoMap.setNullToInitialize(true);

//소속기관
StringBuffer deptListHtml = new StringBuffer();
if(deptMap.keySize("dept") > 0) {
	String selected = "";
	for(int i=0; i < deptMap.keySize("dept"); i++) {
		selected = deptMap.getString("dept",i).equals(infoMap.getString("dept")) ? "selected='selected'":"";
		deptListHtml.append("<option "+selected+" value = \""+deptMap.getString("dept",i)+"\">"+deptMap.getString("deptnm",i)+"</option>");
	}
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천광역시 인재개발원에 오신 것을 환영합니다.</title>
<link rel="stylesheet" href="/commonInc/css/pop.css" type="text/css" />

<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/NChecker.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/protoload.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/homeCategory.js"></script>

<script language="javascript" src="/commonInc/js/commonJs.js"></script>

<Script language='javascript'>
<!--
	window.onload = deptSelected;
	
	/* window.onload = on_apply(); */
	/* window.onload = setInterval(on_apply, 500); */
	
	
	window.onload = on_apply;
	
	function deptSelected() {
		var dept_data_code = '<%=infoMap.getString("dept")%>';
		if(dept_data_code != null || dept_data_code != "") {
			try {
				getMemSelDept(dept_data_code);
			} catch (e) {
			}
		}
	}

	function getMemSelDept(form) {
		var DEPTSUB = '<%=infoMap.getString("deptsub")%>';
		var url = "/mypage/myclass.do";
		pars = "dept=" + form + "&mode=searchPart3&deptsub=" + DEPTSUB;
		var divID = "part";
		var myAjax = new Ajax.Updater(
			{success: divID },
			url, 
			{
				method: "post", 
				parameters: pars,
				onLoading : function(){
					$(document.body).startWaiting('bigWaiting');
				},
				onSuccess : function(){
					window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
				},
				onFailure : function(){					
					window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					alert("데이타를 가져오지 못했습니다.");
				}				
			}
		);
	}

	function findJik(){
		var url="/homepage/join.do";
		url += "?mode=findjik&data1=2";
		pwinpop = popWin(url,"jik","420","350","yes","yes");
	}

	function on_apply(){
		<%
			String ssocompany = "";
			if(request.getParameter("ssocompany") != null){
				ssocompany = request.getParameter("ssocompany");				
			}
		%>
		var dept_data_code = "";
		var dept_name = "";

		try	{
			dept_data_code = document.pForm.DEPT_DATA.options[document.pForm.DEPT_DATA.selectedIndex].value;
		} catch (e) {
			dept_data_code = "";
		}

		try	{
			dept_name = $("deptSelect").options[$("deptSelect").selectedIndex].text;
		} catch (e) {
			dept_name = "";
		}

		if ($("checkyn").checked == false){
			$("checkyn").focus();
			alert("동의가 체크되지 않았습니다.");
			return;
		} else if ($("degreename").value == ""){
			$("degreename").focus();
			alert("직급을 등록해 주세요");			
			return;
		} else if (dept_data_code == ""){
			alert("소속기관을 선택해 주세요");			
			return;
		} else if ($("PART_DATA").value == "" && dept_data_code == "6289999"){
			alert("공사공단 부서명을 선택해주세요.");
			return;
		} else if (document.pForm.DEPTSUB.value == ""){
			document.pForm.DEPTSUB.focus();
			alert("부서명을 등록해 주세요");			
			return;
		} else if ($("hp1").value == "" || $("hp2").value == "" || $("hp3").value == ""){
			$("hp1").focus();
			alert("핸드폰 번호를 등록해 주세요");
			return;
		} else if ($("email").value == ""){
			$("email").focus();
			alert("메일주소를 등록해 주세요");
			return;
		} else if ($("email").value.indexOf("@")  ==  -1){
			$("email").focus();
			alert("올바른 메일주소가 아닙니다");
			return;
		}

		var deptsub = "";

		try	{
			deptsub = document.pForm.DEPTSUB.value;
			
		} catch (e) {
			deptsub = "";
		}

		var useragent = navigator.userAgent;

		if((useragent.indexOf('MSIE 6')  > 0) || (useragent.indexOf('MSIE 7')  > 0) || (useragent.indexOf('MSIE 8')  > 0)) {
			window.returnValue = {
				close : "Y",
				hp1 : $("hp1").value,
				hp2 : $("hp2").value,
				hp3 : $("hp3").value,
				dept_name : dept_name,
				deptsub : deptsub,
				degreename : $("degreename").value,
				email : $("email").value
			}
		} else if((useragent.indexOf('MSIE 9')  > 0) || (useragent.indexOf('MSIE 10')  > 0) || (useragent.indexOf('MSIE 11')  > 0)) {
			var returnValues = new Array();
			returnValues["close"] = "Y";
			returnValues["hp1"] = $("hp1").value;
			returnValues["hp2"] = $("hp2").value;
			returnValues["hp3"] = $("hp3").value;
			returnValues["dept_name"] = dept_name;
			returnValues["deptsub"] = deptsub; //부서명
			returnValues["degreename"] = $("degreename").value; //직급명
			returnValues["email"] = $("email").value;
			window.returnValue = returnValues;
		} else {
			window.returnValue = {
				close : "Y",
				hp1 : $("hp1").value,
				hp2 : $("hp2").value,
				hp3 : $("hp3").value,
				dept_name : dept_name,
				deptsub : deptsub,
				degreename : $("degreename").value,
				email : $("email").value
			}		
		}

		new Ajax.Request("/mypage/myclass.do?mode=ajaxMemberUpdate", {
			method     : 'post',
			parameters : {
				mode : "ajaxMemberUpdate",
				hp : $("hp1").value + "-" + $("hp2").value + "-" + $("hp3").value,
				email : $("email").value,
				dept : dept_data_code,
				deptnm : dept_name,
				deptsub : deptsub,
				jik : $("jik").value,
				jiknm : $("degreename").value,
				ssocompany : '<%=ssocompany%>'
			},
			asynchronous:false,
			onSuccess : function(request) {
				
			},
			on401: function() {
				alert("세션이 종료되었습니다.");
			},
			onFailure : function() {
			}
		});

		window.close();

	}

	function getPart(objValue, objText) {
		if(objValue == ""){
			document.pForm.DEPTSUB.value = "";
			document.pForm.DEPTSUB.focus();
		}else{
			document.pForm.DEPTSUB.value = objText;
		}
	}

	function closeWindows() {
		var useragent = navigator.userAgent;

		if((useragent.indexOf('MSIE 6')  > 0) || (useragent.indexOf('MSIE 7')  > 0) || (useragent.indexOf('MSIE 8')  > 0)) {
			window.returnValue = {
				close : "N"
			}			
		} else if((useragent.indexOf('MSIE 9')  > 0) || (useragent.indexOf('MSIE 10')  > 0)) {
			var returnValues = new Array();
			returnValues["close"] = "N";
			window.returnValue = returnValues;
		} else {
			window.returnValue = {
				close : "N"
			}
		}
		window.close();
	}
//-->
</script>
</head>

<body>
<form method="post"  name="pForm" ID="pForm">
	<input type="hidden" name="userno" id="userno" value="<%=requestMap.getString("userno") %>">
<div id="wrap" style="text-align:center;width:100%;">
  <h3 class="infor_h3_b">개인정보 이용에 대한 동의</h3>
  <p class="infor_p_text" style="text-align:left;width:90%;margin:13px;">
    2019년 인천광역시 공무원 사이버외국어 위탁교육과 관련하여 인재개발원 홈페이지에 저장되어있는 교육생의 ID, 이름,소속,핸드폰번호,
이메일 등의 개인정보를 위탁업체인 <%="1".equals(requestMap.getString("code")) ? "휴넷":"로제타스톤" %>에 제공 
및 활용하는것에 동의합니다.
  </p>
  <div class="infor_table_box">
    <table cellpadding="0" cellspacing="0" border="1">
      <thead>
        <tr> 
          <th>구분</th>
          <th>내용</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>개인정보 항목</td>
          <td>ID, 소속기관, 부서명, 직급, 핸드폰번호, 이메일, 성별</td>
        </tr>
        <tr>
          <td>이용목적</td>
          <td>수강생 학습 관리</td>
        </tr>
        <tr>
          <td>보유기간</td>
          <td>위탁교육 종료시 까지</td>
        </tr>
      </tbody>
    </table>
  </div>

  <p class="infor_bt_b">
	<input type="checkbox" id="checkyn" name="checkyn" checked/> 동의 체크
    <!-- span><a href=""><img src="/commonInc/css/img/pop_information_bt_18.gif" alt="동의" /></a></span>
    <span><a href=""><img src="/commonInc/css/img/pop_information_bt_20.gif" alt="동의안함" /></a></span -->
    
  </p>

<br />
<br />
  <h1>개인정보확인</h1>
  <h3 class="infor_h3_a">개인정보 확인 후 수정해 주세요.</h3>
  <div class="infor_div1" style="text-align:left;width:90%;">
    <ul class="infor_ul">
      <li><label>이름<span class="infor_ul_s1"><%=listMEM.getString("name") %></span></label></li>
      <li><label>직급
	    <input type="text" id="degreename" name="degreename" class="infor_ul_in1" readonly value="<%=infoMap.getString("jiknm")%>"/>
	    <input type="hidden" id="jik" name="jik" value="<%=infoMap.getString("jik")%>"/>
	    <input type="hidden" id="hiddenjik" name="hiddenjik"/>
	    <input type="button" value="직급검색"  class="infor_ulbt" onclick="findJik();"/></label></li>
      <li>
		<label>소속기관&nbsp;
			<select id="deptSelect" name="DEPT_DATA" class="infor_ul_sel1" onChange="getMemSelDept(this.options[this.selectedIndex].value)">
					<option value = "" selected>--- 소속기관 선택 ---</option>
					<%= deptListHtml.toString() %>
             </select>
          </label>
      </li>
      <li>
		<div id="part">
		<label>부서명
		<input type="text" id="DEPTSUB" name="DEPTSUB" class="infor_ul_in2" value="<%=infoMap.getString("deptsub")%>"/>
		<select name="PART_DATA" id="PART_DATA" class="infor_ul_sel2" onChange="getPart(this.options[this.selectedIndex].value,this.options[this.selectedIndex].text)">
			 <option value = "" selected>직접입력</option> 
		</select>
	  </label>
	  </div>
	  </li>
      <li>
	  <%
		String hp = infoMap.getString("hp");
		String hp1 = "";
		String hp2 = "";
		String hp3 = "";

		String [] hpTemp =  {"","",""};

		try {
			if(hp.indexOf("-") != -1) {
				hpTemp = hp.split("-");
				hp1 = hpTemp[0];
				hp2 = hpTemp[1];
				hp3 = hpTemp[2];
			} else {
				hp1 = "";
				hp2 = "";
				hp3 = "";
			}
		} catch(Exception e) {

		}
	   %>
	  
		<label>핸드폰&nbsp;<input type="text" class="infor_ul_in3" id="hp1" name="hp1" value="<%=hp1%>"/> -<input type="text" class="infor_ul_in4" id="hp2" name="hp2" value="<%=hp2%>"/> -<input type="text" class="infor_ul_in4" id="hp3" name="hp3" value="<%=hp3%>"/></label>
	  </li>
      <li><label>이메일&nbsp;<input type="text" id="email" name="email" class="infor_ul_in5" value="<%=listMEM.getString("email") %>"/></label></li>
    </ul>
    <p  class="infor_bt_a">
      <span><a href="javascript:on_apply();"><img src="/commonInc/css/img/pop_information_bt_08.gif" alt="확인" /></a></span>
      <span><a href="javascript:closeWindows();"><img src="/commonInc/css/img/pop_information_bt_10.gif" alt="닫기" /></a></span>
    </p>
  </div>
</div>

</form>
</body>
</html>
