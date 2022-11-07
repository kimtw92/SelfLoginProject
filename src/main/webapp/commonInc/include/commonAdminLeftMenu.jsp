<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%  
// prgnm : 관리자용 좌측 메뉴 생성 include 용
// date : 2008-05-05
// auth : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 좌측 메뉴
	DataMap leftMenuMap = (DataMap)request.getAttribute("LEFTMENU_DATA");
	leftMenuMap.setNullToInitialize(true);

	// 로그인 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");

	StringBuffer sbLeftHtml = new StringBuffer();
	StringBuffer sbAuthHtml = new StringBuffer();
	int intAuthCount = 0;

	// 선택한 메뉴에 대한 ID
	String menuId = requestMap.getString("menuId");
	String hrefClass = "";
	
	///////////////////////////////////
	// 사용자 권한 셀렉트박스
	// 세션에 있는 권한 배열을 가져온다.
	intAuthCount = memberInfo.getSessAuth().length;
	sbAuthHtml.append("<select id=\"cboAuth\" name=\"cboAuth\" style=\"width=190\" onchange=\"fnSelectAuth();\">");
	if(intAuthCount > 0){
		for(int i=0; i < intAuthCount; i++){
			sbAuthHtml.append("<option value='" + memberInfo.getSessAuth()[i][0] + "'>" + memberInfo.getSessAuth()[i][1] + "</option>");
		}
	}else{
		sbAuthHtml.append("<option value=''>권한없음</option>");
	}
	sbAuthHtml.append("</select>");
	
	///////////////////////////////////
	
	
	
	// left menu 생성
    String M_CurrentAuth = memberInfo.getSessCurrentAuth();
	String menuDepthId = "";	// 메뉴ID
	String menuUrl = "";		// 메뉴Url
	String currentMenuDepth1_2 = "";

	sbLeftHtml.append("<table cellspacing='0' cellpadding='0' border='0' width='192'>");
    sbLeftHtml.append("     <tr><td height='20'></td></tr>");
	
	if(leftMenuMap.keySize("menuName") > 0){
		
		String tmpMenuStr = "";
        int threeDepthCnt = 0; //3뎁스 메뉴 확인을 위해.
        
		for(int i=0; i < leftMenuMap.keySize("menuName"); i++){
			
            if (leftMenuMap.getString("menuLevel", i).equals("1")){ //2뎁스 메뉴인지 체크.

                if (threeDepthCnt > 0){ //기존 3뎁스 이상 간것이라면 새로 tr,table새로 열기 위해 닫아준다.
                    sbLeftHtml.append("\n</table></td></tr>");
                    threeDepthCnt = 0;
                }

                sbLeftHtml.append("\n<tr height=\"20\"><td style='cursor:hand' onclick=\"fnMenuShow('" + leftMenuMap.getString("menuDepth1", i)+leftMenuMap.getString("menuDepth2", i) + "');\"><img src='/images/bullet001.gif' width='9' height='9' align='absmiddle'>"+leftMenuMap.getString("menuName", i)+"</td></tr>");

            }else{

            	menuDepthId = leftMenuMap.getString("menuDepth1", i) + "-" + leftMenuMap.getString("menuDepth2", i) + "-" + leftMenuMap.getString("menuDepth3", i);            	            	            	
            	menuUrl = leftMenuMap.getString("menuUrl", i);
            	
            	// 메뉴Url 에  [?] 가 있는지 확인
            	StringTokenizer sToken = new StringTokenizer(menuUrl, "?");
            	if(sToken.countTokens() == 2){
            		menuUrl += "&";
            	}else{
            		menuUrl += "?";
            	}
            	menuUrl += "menuId=" + menuDepthId;
            	
            	// 넘어온 menuId 와 현재 menuId 가 같으면 색상 변경 css 사용
            	if(menuDepthId.equals(menuId)){
                  	hrefClass = "sublink_choice2";
                  	currentMenuDepth1_2 = leftMenuMap.getString("menuDepth1", i) + leftMenuMap.getString("menuDepth2", i);
                }else{
                	hrefClass = "";                	
                }
            	
                // 하위 메뉴 코드가 상위에 속해 있는 것이 아니라면(즉. 각 2뎁스 메뉴별로 처음 들어온 경우일경우.)
                if ( !tmpMenuStr.equals( leftMenuMap.getString("menuDepth1", i)+leftMenuMap.getString("menuDepth2", i)) ){
                
                    threeDepthCnt = 0;
                    String displayBlock = "";                    
                    
                    sbLeftHtml.append("\n<tr id='trMenu" + leftMenuMap.getString("menuDepth1", i)+leftMenuMap.getString("menuDepth2", i) + "' style='display:" + displayBlock + "'><td style='padding:3px 5px;'>");
                    sbLeftHtml.append("\n    <table cellspacing='0' cellpadding='2' border='0'>");
                    sbLeftHtml.append("\n        <tr>");
                    sbLeftHtml.append("\n			<td class='font1'>");
                    sbLeftHtml.append("\n				<img src='/images/bullet002.gif' width='9' height='9' border='0'>");
                    sbLeftHtml.append("\n				<a href='" + menuUrl + "' class='" + hrefClass + "' >" + leftMenuMap.getString("menuName", i) + "</a>");
                    sbLeftHtml.append("\n			</td>");
                    sbLeftHtml.append("\n		</tr>");

                    tmpMenuStr = leftMenuMap.getString("menuDepth1", i)+leftMenuMap.getString("menuDepth2", i); //현재 분류를 임시변수에 넣기.

                }else{
                	
					// 그렇지 않고 연속된 2뎁스 하위메뉴 일경우.              	
                    sbLeftHtml.append("\n        <tr>");
                    sbLeftHtml.append("\n			<td class='font1'>");
                    sbLeftHtml.append("\n				<img src='/images/bullet002.gif' width='9' height='9' border='0'>");
                    sbLeftHtml.append("\n				<a href='" + menuUrl +"' class='" + hrefClass + "'>" + leftMenuMap.getString("menuName", i) + "</a>");
                    sbLeftHtml.append("\n			</td>");
                    sbLeftHtml.append("\n		</tr>");

                }
                
                threeDepthCnt ++;
                
            }			
		}

        if (threeDepthCnt > 0){ //기존 3뎁스 이상 간것이라면 새로 tr,table새로 열기 위해 닫아준다.
            sbLeftHtml.append("</table></td></tr>");
        }
	}

	sbLeftHtml.append("</table>");
	
	
	// 현재 페이지 URL
	String reloadUrl = URLDecoder.decode( (String)request.getAttribute("RELOAD_URL") );
	System.out.println("reloadUrl="+reloadUrl);
	
	
	// 새쪽지
	DataMap newPaperMap = (DataMap)request.getAttribute("NEW_PAPER");
	String newPaperCount = "0";
	if( newPaperMap != null){
		newPaperMap.setNullToInitialize(true);
		newPaperCount = newPaperMap.getString("countPaper");
		
	}
	
	
	
%>


<script language="JavaScript" type="text/JavaScript">

// 권한 셀렉트 박스 변경
function fnSelectAuth(){
	
	var pauth = $F("cboAuth");
	var url = "/commonInc/ajax/currentAuthSet.do?mode=auth&cauth=" + pauth;
	
	var myAjax = new Ajax.Request(
		url, 
		{
			method: "post", 
			onComplete: fnAuthComplete
		}
	);
}

function fnAuthComplete(originalRequest){

	var cboAuthValue = $F("cboAuth");
	var url = "";
	
	url = fnHomeUrl(cboAuthValue);

	url +="&cboAuth="+$F("cboAuth");
	document.location.href = url;
}

// 메뉴 보이기 숨기기 
function fnMenuShow(pindex){

	var tr = document.all.tags('TR');
	var trId = "trMenu" + pindex;
	
	for(i=0; i < tr.length; i++){
	
		if(trId == tr[i].id){
			$(tr[i].id).style.display = "block";
		}else{
			if(tr[i].id != ""){
				$(tr[i].id).style.display = "none";
			}
		}
	}
}

// 과정선택  onoff
function fnCourseTableShowOnOff(){
	var btnCourseShow = $("btnCourseShow");
	var g_table_course = $("g_table_course");
	
	var tmpArySrc = btnCourseShow.src.split("/");
	var fileNm = tmpArySrc[tmpArySrc.length-1];
	var src = "/images/";
	if(fileNm == "btn_select_off.gif"){
		src += "btn_select_on.gif";
		g_table_course.style.display = "none";
	}else{
		src += "btn_select_off.gif";
		g_table_course.style.display = "block";
	}
	
	btnCourseShow.src = src;

}

// 진행, 전체 선택
function fnCourseType(pid){

	var url = "/commonInc/ajax/currentCourseGubun.do?mode=courseGubun";
	var pars = "sessGubun=" + pid;
	
	var myAjax = new Ajax.Request(
			url, 
			{
				asynchronous : false,
				method: "get",
				parameters: pars,
				onSuccess : function(originalRequest){
				
					var retUrl = trim(originalRequest.responseText);
					
					fnChangeCourseCurrentImg(pid);
					
					createLeftSelectBox("clear");
					createLeftSelectBox("grCode");
					
					if("<%= reloadUrl %>" != ""){
						location.href="<%= reloadUrl %>";						
					}
				},
				onFailure: function(){
					alert("error");
				}			
			}
		);
}


// 진행, 전체 선택 이미지 변경
function fnChangeCourseCurrentImg(gubun){

	var imgCourseCurrent = $("imgCourseCurrent");	// 진행과정
	var imgCourseAll = $("imgCourseAll");			// 전체과정
	
	switch(gubun){
		case "1":
			// 진행과정
			imgCourseCurrent.src = "/images/tab_m01_on.gif";
			imgCourseAll.src = "/images/tab_m02_off.gif";
			break;
		case "2":
			// 전체과정
			imgCourseCurrent.src = "/images/tab_m01_off.gif";
			imgCourseAll.src = "/images/tab_m02_on.gif";
			break;
	}
}


// 년도 생성
function fnCreateYear(){
	var strYear = "";
	var selYear = $("selYear");
	var currentYear = new Date().getYear();
	                    			
	for(var i=new Date().getYear()+1; i>= 2000; i--){
		selYear.options.add(new Option(i, i));
	}
	
	// 세션에 년도가 있으면 세션년도 아니면 현재년도
	if("<%= Util.getValue(memberInfo.getSessYear()) %>" != ""){
		$("selYear").value = "<%= Util.getValue(memberInfo.getSessYear()) %>"
	}else{
		$("selYear").value = new Date().getYear();
	}
		
	createLeftSelectBox('grCode');
}

// left 공통 과정 셀렉트 박스 만들기
function createLeftSelectBox(pmode){
	switch(pmode){
		
		case "grCode":
			fnAjaxLeftCommonCourseCode(pmode);			
			fnAjaxLeftCommonCourseCode("grSeq");
			fnAjaxLeftCommonCourseCode("subj");					
			break;
			
		case "grSeq":
			fnAjaxLeftCommonCourseCode(pmode);
			fnAjaxLeftCommonCourseCode("subj");
			break;
			
		case "subj":
			fnAjaxLeftCommonCourseCode(pmode);			
			break;
			
		case "end":
			fnAjaxLeftCommonCourseCode(pmode);
			break;
			
		case "clear":
			// 클리어
			fnAjaxLeftCommonCourseCode(pmode);			
			break;				
	}
}

// left 공통 과정 셀렉트 박스 Ajax
function fnAjaxLeftCommonCourseCode(pmode){

	var url = "/commonInc/ajax/leftCommonCourseCode.do?pmode=" + pmode;
	var pars = "";
	var divId = "";
		
	switch(pmode){
		case "grCode":
			// 과정코드 가져오기			
			pars += "&year=" + nullToEmpty($F("selYear"));		
			divId = "divSelGrCode";
			break;
			
		case "grSeq":
			// 기수 가져오기
			pars += "&year=" + $F("selYear");						
			pars += "&grCode=" + nullToEmpty($F("selGrCode"));
			
			divId = "divSelGrSeq";
			break;
			
		case "subj":
		
			// 과목가져오기						
			pars += "&grCode=" + nullToEmpty($F("selGrCode"));			
			pars += "&grSeq=" + nullToEmpty($F("selGrSeq"));
			
			divId = "divSelSubj";
			break;
			
		case "end":
			// 과목 선택시			
			pars += "&subj=" + nullToEmpty($F("selSubj"));
			
			break;
	}
	
	
	switch(pmode){
		case "grCode":
		case "grSeq":
		case "subj":
		case "clear":		
			var myAjax = new Ajax.Updater(
				{success:divId},
				url + pars, 
				{
					asynchronous : false,
					method: "post", 
					onFailure: fnFailureByAjaxLeftCommonCourseCode
				}
			);
			
			break;
			
		case "end":
			// 과목선택시 해당 권한 home 으로 이동
			var myAjax = new Ajax.Request(
				url + pars, 
				{
					asynchronous : false,
					method: "post", 
					onSuccess: fnAuthComplete,
					onFailure: fnFailureByAjaxLeftCommonCourseCode
				}
			);
			
			break;			
	}
			
}
function fnFailureByAjaxLeftCommonCourseCode(request){
	alert("좌측 코드 생성시 오류가 발생했습니다.");
}

function fnGIndex(){
	location.href = "/index/sysAdminIndex.do?mode=sysAdmin&cboAuth=" + $F("cboAuth");
}

// 쪽지함
function fnGoPaper(){
	location.href = "/homepage/login.do?mode=userPaper";
}

function createHiddenInput(name, value){
	var input = document.createElement("input");
	input.type = "hidden";
	input.name = name;
	input.value = value;
	return input;
}

function fnGoNmail(){
	
// 	<form id="nmailLogin" name="nmailLogin" method="post" action="https://nbuilder.net/login_ok.php" target="_blank">
// 		<input type="hidden" name="m_id" maxlength=50 value="admin">
// 		<input type="hidden" name="m_pwd" maxlength=50 value="1111">
// 	</form>
	
	var hiddenFrame = document.getElementById("hiddenNmailLogin");
	
	function goWritePage(){
		if(this.detachEvent){
			this.detachEvent("onload", goWritePage, false);
		}else{
			this.onload = null;
		}
		var nmail = window.open('', "nmailWindow");
		nmail.document.location.href = "http://152.99.42.129/mail_write.php";
	};
	
	if(hiddenFrame.attachEvent){
		hiddenFrame.attachEvent("onload", goWritePage, false);
	}else{
		hiddenFrame.onload = goWritePage;
	}

	
	var nmailLogin = document.createElement("form");
	
	nmailLogin.method = "post";
	nmailLogin.action = "http://152.99.42.129/login_ok.php";
	nmailLogin.target = "hiddenNmailLogin";
	
	nmailLogin.appendChild(createHiddenInput("m_id", "postmaster"));
	nmailLogin.appendChild(createHiddenInput("m_pwd", "dptmdpaxl7100!"));
	
	document.body.appendChild(nmailLogin);
	nmailLogin.submit();
	document.body.removeChild(nmailLogin);
}

</script>

	<iframe id="hiddenNmailLogin" name="hiddenNmailLogin" width="0" height="0"></iframe>

	<!--[s] 사용자 권한 셀렉트 박스 -->
	<table cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td height="35">
				<%= sbAuthHtml.toString() %>
			</td>
		</tr>
	</table>
	<!--[e] 사용자 권한 셀렉트 박스 -->

	<!-- 쪽지 -->
	<table cellspacing="0" cellpadding="0" border="0" width="185">
		<tr height="18">
			<td style="padding-right:15px; padding-top:3px" nowrap><font color="#333333">안녕하세요. <b><%= memberInfo.getSessName() %>님</b></font></td>
		</tr>
		<tr height="18">
			<td style="padding-right:15px; padding-top:3px" class="font1" nowrap>
				<img src="/images/ico_notice.gif" width="13" height="12" align="middle">새쪽지: <a href="javascript:fnGoPaper();"><font color="#FF3600" style="font-weight:bold"><%= newPaperCount %></font></a>개
			</td>
		</tr>
		<tr><td height="20"></td></tr>
	</table>
	<!-- /쪽지 -->

	<!--[s] 과정선택, 운영본부, EON -->
	<table cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td width="76"><a href="javascript:fnCourseTableShowOnOff();"><img src="/images/btn_select_off.gif" id="btnCourseShow" width="70" height="22" border="0" alt="과정선택"></a></td>
			<td width="59"><a href="javascript:fnGIndex();"><img src="/images/sbtn_01.gif" width="55" height="22" border="0" alt="운영본부"></a></td>
<!-- 			<td width="57"><a href="http://hrd.incheon.go.kr:8090/weom/servlet/servlet.WSOMZ000P0?flag=pnrelay4&userId=140100" target="_blank"><img src="/images/sbtn_02.gif" width="54" height="22" border="0" alt="EON"></a></td> -->
			<td width="57"><a href="javascript:fnGoNmail()"><img src="/images/sbtn_02.gif" width="54" height="22" border="0" alt="EON"></a></td>
		</tr>
	</table>
	<!--[e] 과정선택, 운영본부, EON -->

	<table cellspacing="0" cellpadding="0" border="0" width="192"><tr><td height="10"></td></tr></table>
            
	<!--[s] 과정선택   -->
	<table id="g_table_course" style="display:block" cellspacing="0" cellpadding="0" border="0" width="187">
	    <tr>
	        <td width="65"><img src="/images/tab_m01_on.gif" id="imgCourseCurrent" width="65" height="28" border="0" alt="진행과정" onclick="fnCourseType('1');" style="cursor:hand"></td>
	        <td width="65" align="left"><img src="/images/tab_m02_off.gif" id="imgCourseAll" width="65" height="28" border="0" alt="전체과정" onclick="fnCourseType('2');" style="cursor:hand"></td>
	        <td valign="bottom"><img src="/images/tab_m.gif" width="57" height="1" border="0"></td>
	    </tr>
	    <tr>
	        <td height="110" colspan="3" align="center" valign="top" style="background:#FFFFFF URL(../../images/tab_boxbg.gif) no-repeat">
	
	            <!--[s] 년도 과정 기수 과목 코드  -->
	            <table cellspacing="0" cellpadding="0" border="0">
	                <tr><td height="8"></td></tr>
	                <tr>
	                    <td height="22">
	                        <select name="selYear" class="font1" style="width:170px" onchange="createLeftSelectBox('grCode');">
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <td height="22">
	                    	<div id="divSelGrCode">
	                    		<select name="selGrCode" class="font1" onChange="" style="width:170px">	                            
	                        	</select>
	                    	</div>	                        
	                    </td>
	                </tr>
	                <tr>
	                    <td height="22">
	                    	<div id="divSelGrSeq">
		                        <select name="selGrSeq" class="font1" onChange="" style="width=170">
		                        </select>
	                        </div>
	                    </td>
	                </tr>
	                <tr>
	                    <td height="22">
	                    	<div id="divSelSubj">
		                        <select name="selSubj" class="font1" onChange="" style="width=170">	                        
		                        </select>
		                    </div>
	                    </td>
	                </tr>
	
	            </table>
	            <!--[e] 년도 과정 기수 과목 코드  -->
	
	        </td>
	    </tr>
	</table>
	<!--[e] 과정선택   -->
            

	<!--[s] left menu -->
	<%= sbLeftHtml.toString() %>
	<!--[e] left menu -->


<script language="JavaScript" type="text/JavaScript">

	fnMenuShow("<%=currentMenuDepth1_2%>");

	$("cboAuth").value = "<%= memberInfo.getSessCurrentAuth() %>";
	
	// 년도 생성
	fnCreateYear();
	fnChangeCourseCurrentImg("<%= memberInfo.getSessGubun() %>");
	
</script>



