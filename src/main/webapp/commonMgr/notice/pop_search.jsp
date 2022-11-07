<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 공지사항 개인대상자 검색 팝업창
// date : 2008-08-01
// auth : 최형준
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
	
<%
	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
	//////////////////////////////////////////////////////////////////////////////////// 
	

	//목록리스트
	DataMap listMap = (DataMap)request.getAttribute("personList");
	listMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	DataMap chkAuth = (DataMap)request.getAttribute("chk_auth");

	//공통 권한 체크박스
	String checkAuth="";
	String tmpStr="";
	if(chkAuth != null){
		for(int i=0;i<chkAuth.keySize("auth");i++){			
			if(!checkAuth.equals("")){
				checkAuth += "&nbsp;, &nbsp;";
			}
			tmpStr="";
			if(chkAuth.getString("auth", i).equals(requestMap.getString("searchKey"))){
				tmpStr += "selected";
			}
			
			checkAuth += "<option value='"+chkAuth.getString("auth",i)+"' "+tmpStr+" >"+chkAuth.getString("auth_name",i)+"</option>";
		}
	}
	
	String listStr = "";

	for(int i=0; i < listMap.keySize("npagingRnum"); i++){

		listStr += "<tr bgcolor='#FFFFFF'>";

		listStr += "	<td height='23' align='center' class='tableline11' ><input type='checkbox' name='chkuser[]' value='"+listMap.getString("userno",i)+"'>";
		listStr +="		<input type='hidden' name='chkusername[]' value='"+listMap.getString("name",i)+"'</td>";
		listStr += "	<td height='23' align='center' class='tableline11' >"+listMap.getString("deptnm",i)+"</td>";		
		listStr += "	<td height='23' align='center' class='tableline11' >"+listMap.getString("deptsub",i)+"</td>";
		listStr += "	<td height='23' align='center' class='tableline11' >"+listMap.getString("mjiknm",i)+"</td>";
		listStr += "	<td height='23' align='center' class='tableline11' >"+listMap.getString("gadminnm",i)+"</td>";
		listStr += "	<td height='23' align='center' class='tableline11' >"+listMap.getString("resno",i)+"</td>";
		listStr += "	<td height='23' align='center' class='tableline11' >"+listMap.getString("name",i)+"</td>";
		
		listStr += "</tr>";

	}
	

	if( listMap.keySize("npagingRnum") <= 0){

		listStr += "<tr bgColor='#FFFFFF'>";
		listStr += "	<td align='center' class='tableline11' colspan='100%' height='100'>사용자가 없습니다.</td>";
		listStr += "</tr>";

	}
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("npagingRnum") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
 %>
<!-- [e] commonImport -->
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<html>
<head>
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<script language="JavaScript" type="text/JavaScript">
<!--
	//페이지 이동
	function go_page(page) {
		$("currPage").value = page;
		go_list();
	}

	//리스트
	function go_list(){
		search.submit();
	}

	//추가하기
	function user_add(){
	  var open_form   = opener.document.pform;
	  var form        = document.listForm;
	
	  var check_user      = document.getElementsByName("chkuser[]");
	  var check_username  = document.getElementsByName("chkusername[]");

	  if(check_user.value) {
	    var obj   = opener.document.createElement("option");
	    obj.text  = check_username.value + "(" + check_user.value + ")";
	    obj.value = check_user.value;
	    open_form("noti_part[]").options.add(obj);
	
	    alert('추가되었습니다');

	  } else {	   
	    for(var i=0; i<check_user.length; i++) {
	      if(check_user[i].checked) {
   
	        var obj   = opener.document.createElement("option");
	        obj.text  = check_username[i].value + "(" + check_user[i].value + ")";
	        obj.value = check_user[i].value;
	        open_form("noti_part[]").options.add(obj);
	      }
	    }
	
	    alert('추가되었습니다');	    
	  }
	  clean();
	}
	
	function clean(){
		var form = document.listForm;
	
		var check_user = document.getElementsByName("chkuser[]");
		for(var i=0;i<check_user.length;i++){
			check_user[i].checked=false;
		}
	}
	//-->

</script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<form name="search" method="GET" action="/commonMgr/notice.do">
<input type="hidden" name="currPage" value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="seq" value=''>
<input type="hidden" name="mode" value="searchPerson" />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="49">
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="poptitle" style="padding:0 10 5 0">대상자 검색</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td width="98%">
      <table border="0" align="center" cellpadding="0" cellspacing="0" width="98%">
        <tr>
          <td height="25">
            <div align="center">
              
		검색 : <select name="searchKey">
				<option value='ALL' style="color:red">전체</option>
					<%=checkAuth%>
			</select>&nbsp;
		<select name="searchValue">
			<option value='' style="color:red">선택</option>
			<option value='name'>이름</option>
			<option value='resno'>주민번호</option>
		</select>
              <input name="searchText" type="text" class="textfield" size="13">
              <input type="submit" class="boardbtn1" value="검색" width="34" height="18" border="0" align="absmiddle">&nbsp;
                            
            </div>
          </td>
        </tr>
        <tr>
          <td height="5"><div align="center"></div></td>
        </tr>
        <tr>
          <td height='40'><div align="center">(대상자를 체크하신 후 확인을 누르세요...)</div></td>
        </tr>
        <tr>
          <td>
            <div align="center">
              <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
        	<tr height="28" bgcolor="#5071B4">
				<td align="center" class="tableline11 white"><div align="center"><strong>체크</strong></div></td>
				<td align="center" class="tableline11 white"><div align="center"><strong>기관</strong></div></td>
				<td align="center" class="tableline11 white"><div align="center"><strong>부서</strong></div></td>
				<td align="center" class="tableline11 white"><div align="center"><strong>직급</strong></div></td>
				<td align="center" class="tableline11 white"><div align="center"><strong>구분</strong></div></td>
				<td align="center" class="tableline11 white"><div align="center"><strong>주민번호</strong></div></td>
				<td align="center" class="tableline11 white"><div align="center"><strong>이름</strong></div></td>
			</tr>
                <%=listStr %>
              </table>
            </div>
          </td>
        </tr>
        <tr>
          <td align='center' height='30'><%=pageStr%></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <div align="center">
      <input type='button' value='확인' onClick="user_add();" class="boardbtn1"> <input type='button' value='창닫기' onClick="window.close();" class="boardbtn1">
      </div>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>

