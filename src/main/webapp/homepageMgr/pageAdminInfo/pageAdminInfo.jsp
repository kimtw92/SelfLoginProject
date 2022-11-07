<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 개인정보조회출력
// date : 2008-10-02
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%


	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	StringBuffer html = new StringBuffer();
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	if(listMap.keySize("menucode") > 0){

		for(int i =0; i < listMap.keySize("menucode"); i++){
			html.append("\n	<tr>");
			html.append("\n	<td align='center'><input title='메뉴코드는 변경하실수 없습니다.' readonly='readonly' style='width:100%;' type='text' id='menucode_"+i+"' name='menucode_"+i+"' value='"+listMap.getString("menucode", i)+"' /></td>");
			html.append("\n	<td align='center'><input title='메뉴이름은 변경하실수 없습니다.' readonly='readonly' style='width:100%;' type='text' id='menuname_"+i+"' name='menuname_"+i+"' value='"+listMap.getString("menuname", i)+"' /></td>");
			html.append("\n	<td align='center'><input style='width:100%;' type='text' id='deptname_"+i+"' name='deptname_"+i+"' value='"+listMap.getString("deptname", i)+"' /></td>");
			html.append("\n	<td align='center'><input style='width:100%;' type='text' id='adminName_"+i+"' name='adminName_"+i+"' value='"+listMap.getString("adminName", i)+"' /></td>");
			html.append("\n	<td align='center'><input style='width:100%;' type='text' id='adminTel_"+i+"' name='adminTel_"+i+"' value='"+listMap.getString("adminTel", i)+"' /></td>");
			html.append("\n <td align='center'><input style='width:100%;' type='text' id='updatedate_"+i+"' name='updatedate_"+i+"' value='"+listMap.getString("updatedate", i)+"' readonly='readonly' /></td>");
			html.append("\n	<td align='center'><select style='width:100%;' type='text' id='adminUseyn_"+i+"' name='adminUseyn_"+i+"'>");	
			
			if("Y".equals(listMap.getString("adminUseyn", i))) {
				html.append("<option selected='selected'>Y</option>");	
				html.append("<option>N</option>");	
			} else {
				html.append("<option>Y</option>");	
				html.append("<option selected='selected'>N</option>");	
			}
			html.append("</select></td>");	
			html.append("\n	<td align='center'><input type='button' class='boardbtn1' value='저장' onClick=\"goSave('"+listMap.getString("menucode", i)+"','"+i+"');\" /></td>");
			html.append("\n	</tr>");
		}
	}else{
		html.append("\n	<tr>");
		html.append("\n	<td colspan=\"100%\" align=\"center\" class=\"br0\" style=\"height:100px;\">등록된 데이터가 없습니다.</td>");
		html.append("\n	</tr>");		
	}

%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

//리스트
function go_list(){
	pform.action = "/homepageMgr/pageAdminInfo.do?mode=list&menuId=1-5-6";
	pform.submit();
}

//저장
function goSave(menucode, num) {
	if(!menucode || !num) {
		alert("선택된 데이타가 없습니다.");
		return;
	}
	if($F("deptname_"+num) == "") {
		alert(menucode + "코드 담당부서를 입력해주세요.");
		$("deptname_"+num).focus();
		return;
	}
	if($F("adminName_"+num).replace(/ /g,'') == "") {
		alert(menucode + "코드 담당자를 입력해주세요.");
		$("adminName_"+num).focus();
		return;
	}
	if($F("adminTel_"+num).replace(/ /g,'') == "") {
		alert(menucode + "코드 연락처를 입력해주세요.");
		$("adminTel_"+num).focus();
		return;
	}

	if(confirm(menucode + "코드 담당자를 수정 하시겠습니까?")) {
		var url = "/homepageMgr/pageAdminInfo.do";
		var pars = "mode=ajaxSavePageAdmininfo";
		pars += "&menucode="+menucode;
		pars += "&deptname="+$F("deptname_"+num);
		pars += "&adminName="+$F("adminName_"+num);
		pars += "&adminTel="+$F("adminTel_"+num);
		pars += "&adminUseyn="+$F("adminUseyn_"+num);
		var myAjax = new Ajax.Request(
			url, 
			{
				method: "post", 
				parameters:pars,
				onSuccess : function(data){		
					var result = trim(data.responseText);
					if(result == 'ok'){
						alert("저장되었습니다.");
						go_list();
						return;
					}
					alert("저장중 에러가 발생 했습니다. 관리자에게 문의해 주세요.");
				},
				onFailure : function(){
					alert("데이터를 조회하는데 실패하였습니다.");
				}    
			}
		);
	}
}


</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>            	
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>            
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>페이지별 담당자관리</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                    
                    <!-- search[s] -->
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
						
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
					</table>
                    <!-- search[e] -->
                    					
					<!---[s] content -->
					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						  <tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						  </tr>
						<tr bgcolor="#5071B4">
						  <td height="28" width="10%" align="center" class="tableline11 white" ><strong>메뉴코드</strong></td>
						  <td height="28" width="18%" align="center" class="tableline11 white" ><strong>메뉴명</strong></td>
						  <td class="tableline11 white" align="center" width="12%"><strong>담당부서</strong></td>
  						  <td class="tableline11 white" align="center" width="15%"><strong>담당자</strong></td>
						  <td class="tableline11 white" align="center" width="8%"><strong>연락처</strong></td>
						  <td class="tableline11 white" align="center" width="16%"><strong>수정일</strong></td>
						  <td class="tableline11 white" align="center" width="10%"><strong>사용여부</strong></td>
						  <td class="tableline11 white" align="center" width="6%"><strong>수정여부</strong></td>
						</tr>
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
						</tr>
						<%=html.toString()%>
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
                    </table>
						<div class="h10"></div>
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>
