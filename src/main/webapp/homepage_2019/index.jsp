<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
 
<%
	LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");

	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 공지사항 리스트
	DataMap listMap = (DataMap)request.getAttribute("NOTICE_LIST");
	listMap.setNullToInitialize(true);
	
	String sslState = Util.getValue(request.getParameter("ssl"),"");

	StringBuffer sbListHtml = new StringBuffer();
	
	String pageStr = "";
	
	if(listMap.keySize("seq") > 0){		
		for(int i=0; i < listMap.keySize("seq") && i < 5; i++){
			String title = listMap.getString("title", i);
			String newImage = "";
			if(title.length() >= 40) {
				title = title.substring(0,38) + "...";
			}
			if(isNew(listMap.getString("regdate", i).replaceAll("-","")+"000000", 10)) {
				newImage = " <img src=\"../images/main/new.gif\" alt=\"new\" />";
			}
            sbListHtml.append("	<li><a href=\"/homepage/support.do?mode=noticeView&amp;boardId=NOTICE&amp;seq="+listMap.getString("seq", i)+"\">" + title + newImage + "</a><span class='ntcdata'>"+ listMap.getString("regdate", i) + "</span></li>");
                
                
		}
	}
	
	// 사이버교육 리스트
	DataMap cyberListMap = (DataMap)request.getAttribute("CYBER_LIST");
	cyberListMap.setNullToInitialize(true);
	
	
	StringBuffer cyberListHtml = new StringBuffer();
	
	cyberListHtml.append("<tr>");
	cyberListHtml.append("<td class=\"spc\" style=\"\" colspan=\"4\"></td>");
	cyberListHtml.append("</tr>");
	
	if(cyberListMap.keySize("rownum") > 0){		
		int sizeCheck = 0;
		for(int i=0; i < cyberListMap.keySize("rownum"); i++){
			
			//초과 글자 생략처리
			String title = cyberListMap.getString("grcodeniknm", i);
			if(title.length() >= 17)	title = title.substring(0,16) + "...";

			cyberListHtml.append("<tr>");
			cyberListHtml.append("	<td class=\"t3\"> <a href='javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&amp;grcode="+cyberListMap.getString("grcode", i)+"&amp;grseq="+cyberListMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")'>"+ title +"</a></td>");
			cyberListHtml.append("	<td>" + cyberListMap.getString("eapplyst", i) + "~" + cyberListMap.getString("eapplyed", i) +"</td>");
			cyberListHtml.append("	<td>" + cyberListMap.getString("tseat", i) +"</td>");
			cyberListHtml.append("	<td>"+cyberListMap.getString("grtime", i)+"</td>");
			cyberListHtml.append("	<td>" + cyberListMap.getString("started", i) + "~" + cyberListMap.getString("enddate", i) + "</td>");
			cyberListHtml.append("</tr>");
			
			if(i+1 != cyberListMap.keySize("rownum")) {
				cyberListHtml.append("<tr>");
				cyberListHtml.append("<td class=\"dotLine\" colspan=\"5\"></td>");
				cyberListHtml.append("</tr>");	
			}
			
			sizeCheck = i;
		}
		
		for(int j=0; j < 6-sizeCheck; j++) {
			cyberListHtml.append("<tr><td colspan=5>&nbsp;</td></tr>");
			if(j != 5-sizeCheck) {
				cyberListHtml.append("<tr><td class=\"dotLine\" colspan=\"5\"></td></tr>");
			}
		}
		
	}else{
		cyberListHtml.append("<tr height=\"167\"><td colspan=\"5\">수강신청중인 과정이 없습니다.</td></tr>");
	}	
	
	// 집합 교육 리스트
	DataMap nonCyberlistMap = (DataMap)request.getAttribute("NONCYBER_LIST");
	nonCyberlistMap.setNullToInitialize(true);
	
	
	StringBuffer nonCyberListHtml = new StringBuffer();
	
	nonCyberListHtml.append("<tr>");
	nonCyberListHtml.append("<td class=\"spc\" style=\"\" colspan=\"4\"></td>");
	nonCyberListHtml.append("</tr>");
	
	if(nonCyberlistMap.keySize("rownum") > 0){	
		
		int sizeCheck = 0;
		for(int i=0; i < nonCyberlistMap.keySize("rownum"); i++){
			nonCyberListHtml.append("<tr>");
			nonCyberListHtml.append("	<td class=\"t3\"><a href='javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&amp;grcode="+nonCyberlistMap.getString("grcode", i)+"&amp;grseq="+nonCyberlistMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")'>"+nonCyberlistMap.getString("grcodeniknm", i) +"</a></td>");
			nonCyberListHtml.append("	<td>" + nonCyberlistMap.getString("eapplyst", i) + "~" + nonCyberlistMap.getString("eapplyed", i) +"</td>");
			nonCyberListHtml.append("	<td>" + nonCyberlistMap.getString("tseat", i) +"</td>");
			nonCyberListHtml.append("	<td>"+nonCyberlistMap.getString("grtime", i)+"</td>");
			nonCyberListHtml.append("	<td>" + nonCyberlistMap.getString("started", i) + "~" + nonCyberlistMap.getString("enddate", i) + "</td>");
			nonCyberListHtml.append("</tr>");
			
			if(i+1 != nonCyberlistMap.keySize("seq")) {
				nonCyberListHtml.append("<tr>");
				nonCyberListHtml.append("<td class=\"dotLine\" colspan=\"5\"></td>");
				nonCyberListHtml.append("</tr>");	
			}
			
			sizeCheck = i;
		}
		
		for(int j=0; j < 6-sizeCheck; j++) {
			nonCyberListHtml.append("<tr><td colspan=5>&nbsp;</td></tr>");
			if(j != 5-sizeCheck) {
				nonCyberListHtml.append("<tr><td class=\"dotLine\" colspan=\"5\"></td></tr>");
			}
		}

		
	}else{
		nonCyberListHtml.append("<tr height=\"167\"><td colspan=\"5\">수강신청중인 과정이 없습니다.</td></tr>");
	}	
	
	// 이달의 교육 리스트
	DataMap monthlistMap = (DataMap)request.getAttribute("MONTH_LIST");
	monthlistMap.setNullToInitialize(true);	

	StringBuffer monthListHtml = new StringBuffer();

	monthListHtml.append("<ul>");

	if(requestMap.keySize("grcodeniknm") > 0){		
		for(int i=0; i < requestMap.keySize("grcodeniknm"); i++){

			String grcode = requestMap.getString("grcode", i); 
			String gubun = requestMap.getString("gubun", i);
			String checklist = "";
			
			if(checklist.indexOf(grcode) != -1) {
				if("10G0000091".equals(grcode))  {
					gubun = "기본";
				} else { //
					gubun = "혼합";
				}
			}
			
			if("10G0000351".equals(grcode))  { // 건설공사
				gubun = "기본";
			}

			if("전문".equals(gubun)) {
				gubun = "집합";
			}

			String title = requestMap.getString("grcodeniknm", i);
			String subStrTitle = title;
			if(title.length() >= 25 )	subStrTitle = title.substring(0, 24) + "..."; 
			
			
			monthListHtml.append("<li>");
			
			monthListHtml.append("<a href=\"javascript:popWin('/homepage/course.do?mode=courseinfopopup&grcode="+requestMap.getString("grcode", i)+"&grseq="+requestMap.getString("grseq", i)+"','aaa','603','680','yes','yes')\" title=\""+title+"\">" +"<font color='aqua;'>["+gubun+"]</font> &nbsp;&nbsp;"+subStrTitle + "</a><span style='padding-right: 23px;'>" + requestMap.getString("started", i) + "~"+requestMap.getString("enddate", i) +"</span>");
			
			//monthListHtml.append("<a href=\"javascript:popWin('/homepage/course.do?mode=courseinfopopup&grcode="+requestMap.getString("grcode", i)+"&grseq="+requestMap.getString("grseq", i)+"','aaa','603','680','yes','yes')\" title=\""+title+"\">" +"["+gubun+"]"+subStrTitle +requestMap.getString("started", i) + "~"+requestMap.getString("enddate", i)+"</a><span>" + requestMap.getString("started", i) + "~"+requestMap.getString("enddate", i) +"</span>");
			monthListHtml.append("</li> \n");
		}
	}else {
		monthListHtml.append("<li>해당월은 과정이 없습니다.</li>");
	}
	
	monthListHtml.append("</ul>");
	
	

	// 주간일정 리스트
	DataMap weeklistMap = (DataMap)request.getAttribute("WEEK_LIST");
	weeklistMap.setNullToInitialize(true);
	
	StringBuffer weekListHtml = new StringBuffer();
	int index = 1;
	if(weeklistMap.keySize("title") > 0){
		for(int i=0; i < weeklistMap.keySize("title"); i++){
			if(weeklistMap.getString("title",i).indexOf("e-") != -1) {
				if(index == 1) {
					weekListHtml.append(weeklistMap.getString("mm",i)+"월" +weeklistMap.getString("dd",i)+"일 : 사이버교육 시작일입니다.   ");
				}
				index++;
			} else {
				weekListHtml.append(weeklistMap.getString("mm",i)+"월" +weeklistMap.getString("dd",i)+"일 : "+weeklistMap.getString("title",i)+"  " );
			}
		}
		
	}
	

	// 포토 리스트
	DataMap photoListMap = (DataMap)request.getAttribute("PHOTO_LIST");
	photoListMap.setNullToInitialize(true);
	
	StringBuffer photoListHtml = new StringBuffer();
	
	if(photoListMap.keySize("rownum") > 0){
		for(int i=0; i < photoListMap.keySize("rownum"); i++){
			 photoListHtml.append(" <div id='pic01'> ");
			 photoListHtml.append(" 					<dl> ");
			 photoListHtml.append(" 						<dd class='pic'><a href='javascript:popWin(\"/homepage/index.do?mode=showpicture2&amp;photoNo="+photoListMap.getString("photoNo",i)+"\",\"aaa\",\"900\",\"750\",\"yes\",\"yes\")' ><img width=\"57\" height=\"52\" src=\"/pds"+photoListMap.getString("imgPath",i)+"\" alt='.'/></a></dd> ");
			 photoListHtml.append(" 						<dd class='text02'>"+photoListMap.getString("wcomments",i)+"</dd> ");
			 photoListHtml.append(" 					</dl> ");
			 photoListHtml.append(" 				</div> ");
			if(i == 1) {
				break;
			}
		} 
	}
	
	// 과정운영계획 리스트
	
	DataMap grseqPlanListMap = (DataMap)request.getAttribute("GRSEQ_PLAN_LIST");
	grseqPlanListMap.setNullToInitialize(true);	

	StringBuffer grseqPlanListHtml = new StringBuffer();	
	
	//<dt>교육생 숙지사항</dt>
	//<dd>· 교육훈련계획</dd>
	//<dd>· 교육인정시간 기준</dd>
	//<dd>· 사이버교육 운영지침</dd>
	//<dd>· 사이버과정별 안내서</dd>
	
	if(grseqPlanListMap.keySize("rownum") > 0){
		grseqPlanListHtml.append("<dt>과정 시간표</dt>");
		for(int i=0; i < grseqPlanListMap.keySize("rownum"); i++){
			String strName = grseqPlanListMap.getString("grcodeniknm",i);
			if (strName.length() > 10){
				strName = grseqPlanListMap.getString("grcodeniknm",i).substring(0,9)+"..";
			}
			grseqPlanListHtml.append("<dd><a href='javascript:popWin(\"/commonInc/fileDownload.do?mode=popup&amp;groupfileNo="+grseqPlanListMap.getString("groupfileNo",i)+"\",\"aaa\",\"350\",\"280\",\"yes\",\"yes\")' alt=\""+grseqPlanListMap.getString("grcodeniknm",i)+"\">"+strName+"</a></dd>");
		}
	}
	
	DataMap popupZoneListMap = (DataMap)request.getAttribute("POPUPZON_LIST");
	popupZoneListMap.setNullToInitialize(true);
	int popupZoneListSize = popupZoneListMap.keySize("seq") - 1;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="autocomplete" content="off" />
<title>인천광역시 인재개발원</title>


<link rel="stylesheet" href="/homepage_2019/bxslider/jquery.bxslider.css" /><!-- bxslider -->
<link rel="stylesheet" href="/homepage_2019/css/common.css" /><!-- 공통css -->
<script src="/homepage_2019/js/jquery-1.8.2.min.js"></script><!-- jquery 버전 -->
<script src="/homepage_2019/js/common.js"></script><!-- 공통jquery -->
<script src="/homepage_2019/bxslider/jquery.bxslider.js"></script><!-- bxslider -->
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<script language=javascript src="/commonInc/js/category.js"></script>


<!-- 키보드 보안 솔루션 start-->

<!-- <script type="text/javascript" src="https://supdate.nprotect.net/nprotect2007/keycrypt/hrdincheon/npkfx.js"></script> -->


<script type="text/javascript" src="/pluginfree/js/nosquery-1.11.3.js"></script>
<!--고객사에서 사용하는 jquery 버전이 1.7.4이상일 경우 해당경로로 변경하여 사용 가능 -->
<script type="text/javascript" src="/pluginfree/jsp/nppfs.script-1.6.0.jsp"></script>
<script type="text/javascript" src="/pluginfree/js/nppfs-1.6.0.js"></script>

 <!--[if IE 9]>
    <script src="/homepage_2019/js/html5shiv.js"></script>
    <script src="/homepage_2019/js/placeholders.min.js"></script>
	<script src="/homepage_2019/ie7/IE9.js"></script>
	<script src="/homepage_2019/ie7/ie7-squish.js"></script> 
  <![endif]-->  
  
  <!--[if IE 8]> <html class="lt-ie9" lang="ko">
    <script src="/homepage_2019/js/html5shiv.js"></script>
    <script src="/homepage_2019/js/placeholders.min.js"></script>
	<script src="/homepage_2019/ie7/IE9.js"></script>
	<script src="/homepage_2019/ie7/ie7-squish.js"></script> 
   <![endif]-->
   
  <!--[if IE 6]> <html class="lt-ie9" lang="ko">
    <script src="/homepage_2019/js/html5shiv.js"></script>
    <script src="/homepage_2019/js/placeholders.min.js"></script>
	<script src="/homepage_2019/ie7/IE9.js"></script>
	<script src="/homepage_2019/ie7/ie7-squish.js"></script> 
   <![endif]-->

  
<script type="text/javascript">

$(function() {
	
	window.open("/homepage/index.do?mode=usercreateid","pause","scrollbars=no,resizable=no,width=500,height=400")
	
});

nosQuery(document).ready(function(){	

	<% if ((loginInfo.getSessName() == null) && sslState.equals("Y") ) { %> 	    
		location.href="/homepage/support.do?mode=faqView&fno=61";
	<% } %>
	
	
    nosQuery("#userAgent").text(navigator.userAgent);
    var isSupport = npPfsCtrl.IsSupport();
    var isMobile = npPfsDefine.isMobileDevice();
    if(!isSupport && !isMobile)
    {
           //alert("보안프로그램을 지원하지 않는 환경입니다. 접속 가능 환경을 확인하시고 다시 시도하십시오.");
    }
    else
    {
          // npPfsStartup(document.frmSSO, false, true, false, false, "npkencrypt", "on");
    }
});

</script>
<!-- 키보드 보안 솔루션 둥 -->


<script language="javascript">


window.onload=popup();

$(document).ready(function(){
	var mobile_keys = new Array('iPhone','iPod','Android','BlackBerry','Windows Phone','Windows CE','LG','MOT','SAMSUNG','SonyEricsson','Nokia');
    if(document.URL.match('move_pc_screen')) mobile_keys = null; // URL 파라메타에 'move_pc_screen' 가 포함되어 있을땐 적용안함
    for(i in mobile_keys){
    	if(navigator.userAgent.match(mobile_keys[i]) != null){
        	location.href="http://m.hrd.incheon.go.kr/index.do?mode=index"; // 모바일 홈 연결 주소
            break;
        }
    }
	
	var cookie= getCookie('popup0001');
    
	if (cookie!= "end") {
		// window.open("/popup/popup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
	}
	
	var oldpwd = "<%= request.getAttribute("OLDPWD") %>";  
	
	if(oldpwd == "TRUE"){		
		
		location.href="/homepage/renewal.do?mode=newPwd";
	}
	
});

function fnSelectAuth(){
		
	var pauth = $("#cboAuth").val();
	var url = "/commonInc/ajax/currentAuthSet.do?mode=auth";
	var pars = "&cauth=" + pauth;
	
	$.ajax({
		type : "get"
		,url : url + pars
		,dataType: 'html'
		,success: function(result) {
			fnAuthComplete(result);

		}
	});
	
// 	var myAjax = new Ajax.Request(
// 			url, 
// 			{
// 				method: "get", 
// 				parameters: pars, 
// 				onComplete: fnAuthComplete
// 			}
// 		);
}
function fnAuthComplete(originalRequest){

	var cboAuthValue = $("#cboAuth").val();
	var url = "";
	
	url = fnHomeUrl(cboAuthValue);

	url +="&cboAuth="+$("#cboAuth").val();
	location.href = url;
}
function showTab(i) {
	var content1 = $('maintab1');
	var content2 = $('maintab2');
	var content3 = $('maintab3');
	
	if(i == 1) {
		content1.show();
		content2.hide();
		content3.hide();
	} else if(i == 2) {
		content1.hide();
		content2.show();
		content3.hide();
		//alert("집합교육의 신청가능한 모든 과정을 조회하시려면 \n탭 우측의 more 버튼을 클릭하여 주십시오.");	
	} else if(i == 3) {
		content1.hide();
		content2.hide();
		content3.show();	
		//alert("사이버교육의 신청가능한 모든 과정을 조회하시려면 \n탭 우측의 more 버튼을 클릭하여 주십시오.");	
	}
}

function existidcheck() {
	var url = "/homepage/index.do";
	url += "?mode=existid";
	pwinpop = popWin(url,"exidPop","420","350","yes","yes");	
}

function formHandler1(form) {
	// 팝업창의 옵션을 지정할 수 있습니다
	var windowprops = "height=500,width=500,location=no,"
	+ "scrollbars=no,menubars=no,toolbars=no,resizable=yes";

	var URL = form.select1.options[form.select1.selectedIndex].value;
	popup = window.open(URL);
	//form.target = "_blank";
	//form.action = URL;
	//form.submit();
}

function formHandler2(form) {
	// 팝업창의 옵션을 지정할 수 있습니다
	var windowprops = "height=500,width=500,location=no,"
	+ "scrollbars=no,menubars=no,toolbars=no,resizable=yes";

	var URL = form.select2.options[form.select2.selectedIndex].value;
	popup = window.open(URL);
	//form.target = "_blank";
	//form.action = URL;
	//form.submit();
}

function formHandler3(form) {
	// 팝업창의 옵션을 지정할 수 있습니다
	var windowprops = "height=500,width=500,location=no,"
	+ "scrollbars=no,menubars=no,toolbars=no,resizable=yes";

	var URL = form.select3.options[form.select3.selectedIndex].value;
	popup = window.open(URL);
	//form.target = "_blank";
	//form.action = URL;
	//form.submit();
}

function selectOpt(val)
{

}

var mode = 0;
function changeBanner(value)
{
	mode = mode + value;
	if(mode == -1) {
		mode = 1;
	} else if(mode == 2) {
		mode = 0;
	}

	document.getElementById('banner_top').src = "/images/<%= skinDir %>/main/ban0"+(mode*2+1)+".gif";
	document.getElementById('banner_bottom').src = "/images/<%= skinDir %>/main/ban0"+(mode*2+2)+".gif";

	switch(mode) {
		case 0 :
			document.getElementById('banner_link_top').href = "http://www.incheonexpo2009.org/index.asp";
			document.getElementById('banner_link_bottom').href = "http://www.ifez.go.kr/";
			break;
		case 1 :
			document.getElementById('banner_link_top').href = "http://www.incheon2014ag.org/";
			document.getElementById('banner_link_bottom').href = "http://www.incheon.go.kr/";
			break;
	}
}

// function showMonthTab(month) {
// 	for(var i=1;i<=12;i++) {
// 		$("num_" + i).className = "";
// 	}
// 	$("num_" + month).className = "on";
// 	if(month.length == 2 ) {
		
// 	}else{
// 		month = '0'+month;	
// 	}
		
// 	ajax(month);
// }

function ajax(month) {

		var url = "index.do";
		//pars = "?month=" + month + "&mode=ajax";
		//var divID = "monthajax";
		
		$.ajax({
			type : "POST"
			,url : "/homepage/index.do"
			,data : {
				"month" : month,
				"mode"  : 'ajax'
			}
			,dataType: 'html'
			,success: function(result) {
				
				  
				
				$('#mex'+month).empty();
				$('#mex'+month).append(result);
// 				$('#monthAjax').innerHTML;

			}
		});
		
// 		new Ajax.Request(url,
// 				{
// 					method: 'post',  
// 					parameters: { 
// 									"month" : month,
// 									"mode"  : 'ajax'
// 								 },
// 					onLoading : function(){
// 						$('monthajax').startWaiting('bigWaiting');
// 						//$("monthajax").startWaiting();
// 						//window.setTimeout(E.stopWaiting.bind(E),3000);
// 					},
// 					onSuccess : function(transport){

// 						$('monthajax').update(transport.responseText);
// 						$('monthajax').innerHTML;
										
// 					},
// 					onFailure : function(){					
// 						//window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 3000);
// 						alert("데이타를 가져오지 못했습니다.");
// 					},
// 					onComplete : function() {
// 						window.setTimeout( $('monthajax').stopWaiting.bind( $('monthajax') ), 3000);
// 						//$('monthajax').stopWaiting('bigWaiting');
// 					}				
// 				}
// 			);
}

function doSearch(i) {
	if(i=='1') {
		if($("keyword").value != "") {
			pars = encodeURIComponent($("keyword").value);			
			location.href='/homepage/course.do?mode=searchcourse&coursename='+pars
		}else {
			alert('검색어를 입력해 주십시오.');
		}
	}else if(i=='2'){
		if($("keyword").value != "") {
			pars = escape(encodeURIComponent($("keyword").value));
			location.href='/homepage/introduce.do?mode=eduinfo7-3&select=name&keyword='+pars
		}else {
			alert('검색어를 입력해 주십시오.');
		}
	}else if(i=='3'){
		if($("keyword").value != "") {
			pars = escape(encodeURIComponent($("keyword").value));
			location.href='/homepage/introduce.do?mode=eduinfo7-3&select=work&keyword='+pars
		}else {
			alert('검색어를 입력해 주십시오.');
		}
	}else if(i=='4'){
		if($("keyword").value != "") {
			pars = escape(encodeURIComponent($("keyword").value));
			location.href='/homepage/support.do?mode=faqList&question='+pars
		}else {
			alert('검색어를 입력해 주십시오.');
		}
	}
	
}

function selectNotice(i){
	if(i=='1') {
		alert('교육과정을 키워드로 입력하여 주십시오.\n 보통 교육과정에 포함되어있는 키워드는 다음과 같습니다.\n 예) 과정, 행정, 영어, 컴퓨터, 야간, 실무 등...');
	}
	if(i=='2'){
		alert('이름을 키워드로 입력하여 주십시오.\n 예) 홍길동을 검색 할 경우\n 검색어 : 홍, 길동, 홍길동');
	}
	if(i=='3'){
		alert('업무내용을 키워드로 입력하여 주십시오.\n 예) 교육, 인사, 강의 등...');
	}
	if(i=='4'){
		alert('질문을 키워드로 입력하여 주십시오.\n 예) IE, 동영상, 진도율 등...');
	}
}

function init(){
	// selectOpt(1);
}	



	 function getCookie(name) { //쿠키 가져오기
		  var Found = false;
		  var start, end;
		  var i = 0;
		  
		  while(i <= document.cookie.length) { 
		   start = i 
		   end = start + name.length 
		  
		   if(document.cookie.substring(start, end) == name) {
		    Found = true;
		    break;
		   }
		   i++;
		  } 
		  
		  if(Found == true) {
		   start = end + 1;
		   end = document.cookie.indexOf(";", start);
		  
		   if(end < start) {
		    end = document.cookie.length;
		   }
		   return document.cookie.substring(start, end)
		  }
		  return "";
		 }

	function popup() {
<% if( loginInfo.getSessName() != null ) { %>
	<% if(loginInfo.getSessUserId() == "" || loginInfo.getSessUserId() == null || loginInfo.getSessUserId() == "null") { %>
	
			 var userid = "<%=loginInfo.getSessUserId()%>";
			if(userid == "" || userid == null || userid == "null") {
				//window.open("/homepage/index.do?mode=usercreateid","createId","scrollbars=no,resizable=no,width=460,height=300").focus();				
				<% session.invalidate(); %>				
				return;
			}
	
	<% } %>
<% } %>
	
			
<%
	DataMap popupListMap = (DataMap)request.getAttribute("POPUP_LIST");
	popupListMap.setNullToInitialize(true);
	
	if(popupListMap.keySize("no") > 0){
		for(int i=0; i < popupListMap.keySize("no"); i++){	
%>
		var cookie= getCookie('CookieName<%=i+1%>');
		if (cookie!= "noPopup_<%=i+1%>") {
			window.open('<%="/homepage/index.do?mode=popup"+(i+1)+"&no="+popupListMap.getString("no",i)%>','<%="pop"+(i+1)%>','left=<%=popupListMap.getString("popupLeft",i)%>,top=<%=popupListMap.getString("popupTop",i)%>,scrollbars=no,resizable=no,width=<%=popupListMap.getString("popupWidth",i)%>,height=<%=(Integer.parseInt(popupListMap.getString("popupHeight",i)) + 25)%>');
		}	 
<%
		}
	}	
%>
}
	//2010.01.04 - woni82 (메시지 변경)
	//사이버 어학센터 바로 가기
	function move_winglish() {
		open ("http://cyber.ybmsisa.com/incheon/","NewWindow",
		"left=0, top=0, toolbar=yes, location=yes, directories=no, status=yes, menubar=yes, scrollbars=yes, resizable=yes, width=1024, height=768");
		/*
		alert("개강일은 2012년 04월 01일부터입니다.");
		return;
		 //http://incheon.winglish.com
		 */
	}
	function move_cyber_mobile() {
		open ("http://m.cyber.incheon.kr","NewWindow2",
		"left=0, top=0, toolbar=yes, location=yes, directories=no, status=yes, menubar=yes, scrollbars=yes, resizable=yes, width=1024, height=768");
	}
	
	function move_cyber() {
		open ("http://incheon.hunet.co.kr","NewWindow3",
		"left=0, top=0, toolbar=yes, location=yes, directories=no, status=yes, menubar=yes, scrollbars=yes, resizable=yes, width=1024, height=768");
	}

function goUrl(url, form){
	
	document.charset="euc-kr";
	
	document.forwardPage.action = url;
	document.forwardPage.target = "_blank";
    document.forwardPage.kvt.value = "<%=loginInfo.getSessUserId() %>";
    document.forwardPage.anm.value = "<%=loginInfo.getSessName() %>";
    document.forwardPage.pkey.value = form;
    document.forwardPage.submit();
    
    document.charset="utf-8"; 
}

function goDongaBiz(){
	document.frmSSO.submit();
}

function goLogodi() {
	open ("http://www.logodi.go.kr/competency/ic","NewWindow",
		"left=0, top=0, toolbar=yes, location=yes, directories=no, status=yes, menubar=yes, scrollbars=yes, resizable=yes, width=1024, height=768");
}
function tabmenu(tab_order, element) {
	var obj = $(element);
	if(tab_order == 1) {
		$('tabmenu1').src = $('tabmenu1').src.replace("_on", "");
		$('tabmenu2').src = $('tabmenu2').src.replace("_on" ,"");
		$("info_1").style.display = "none";
		$("info_2").style.display = "none";
		if($(element).id == "tabmenu1") {
			$("info_1").style.display = "block";
		} else {
			$("info_2").style.display = "block";
		}
	} else if(tab_order == 2) {
		$('tabmenu3').src = $('tabmenu3').src.replace("_on", "");
		$('tabmenu4').src = $('tabmenu4').src.replace("_on" ,"");
		$('tabmenu5').src = $('tabmenu5').src.replace("_on" ,"");
		$("tab1c1_area").style.display = "none";
		$("tab1c2_area").style.display = "none";
		$("tab1c3_area").style.display = "none";
		$("more_1").style.display = "none";
		$("more_2").style.display = "none";
		$("more_3").style.display = "none";

		if($(element).id == "tabmenu3") {
			$("tab1c1_area").style.display = "block";
			$("more_1").style.display = "block";
		} else if($(element).id == "tabmenu4") {
			$("tab1c2_area").style.display = "block";
			$("more_2").style.display = "block";
		} else if($(element).id == "tabmenu5") {
			$("tab1c3_area").style.display = "block";
			$("more_3").style.display = "block";
		}
	} else if(tab_order == 3) {
		$('tabmenu6').src = $('tabmenu6').src.replace("_on", "");
		$('tabmenu7').src = $('tabmenu7').src.replace("_on" ,"");
		$("winglish_area").style.display = "none";
		$("photo_area").style.display = "none";
		if($(element).id == "tabmenu6") {
			$("winglish_area").style.display = "block";
		} else if($(element).id == "tabmenu7") {
			$("photo_area").style.display = "block";
		}
	}
	obj.src = obj.src.replace(".gif", "_on.gif");
}
//-->
</script>
<script language="JavaScript" type="text/JavaScript">




window.onload = function thisMonth() {
	
	var thisMonth = <%=request.getAttribute("THISMONTH") %>;
	
	if(thisMonth.length < 2){		
		thisMonth ="0"+thisMonth;
	}	
	var monthNumber = document.getElementById('thismonth'+thisMonth);
	var monthtitle = document.getElementById('defaultOpen2');
	
	monthtitle.classList.add('month_title_on');	
	monthNumber.style.display = 'block';
	
}

function fnGoMenu(menuNum,htmlId){
	//location.href = "/homepage/html.do?mode=ht&htmlId=" + htmlId;
	if(menuNum == '1') {
		location.href = "/mypage/myclass.do?mode=" + htmlId;	
	} else if(menuNum == '2') {
		location.href = "/homepage/infomation.do?mode=" + htmlId;
	}else if(menuNum == '3') {
		location.href = "/homepage/course.do?mode=" + htmlId;
	}else if(menuNum == '4') {
		
		if (htmlId == 'yearof2015') {
			location.href = "/statisMgr/stats.do?mode=2015";		
		} else {
			location.href = "/homepage/attend.do?mode=" + htmlId;
		}
		
				
	}else if(menuNum == '5') {
		location.href = "/homepage/support.do?mode=" + htmlId;
	}else if(menuNum == '6') {
		location.href = "/homepage/ebook.do?mode=" + htmlId;
	}else if(menuNum == '7') {
		location.href = "/homepage/introduce.do?mode=" + htmlId;
	}else if(menuNum == '8') {
		location.href = "/mypage/paper.do?mode=" + htmlId;
	}else if(menuNum == '9') {
		location.href = "/homepage/index.do?mode=" + htmlId;
	}else if(menuNum == '10') {
		location.href = "/homepage/join.do?mode=" + htmlId;
	}	
}


function popupEduInfo() {
	

	if(<%=loginInfo.isLogin()%> == true) {
		window.open("/homepage/index.do?mode=eduInfo","eduInfo","scrollbars=no,resizable=no,width=710,height=600").focus(); // 공무원 e러닝 외국어 신청
	} else {
		alert("로그인후 사용하실수 있습니다.");
	}
	
}

function goGlobalContents() {
	if(<%=loginInfo.isLogin()%> == true) {
		var userid = "<%=loginInfo.getSessUserId()%>";
		var name = "<%=loginInfo.getSessName() %>";
		var paramname = escape(encodeURIComponent(name));

		if(userid == "" || userid == null || userid == "null") {
			window.open("/homepage/index.do?mode=createid","createId","scrollbars=no,resizable=no,width=460,height=300").focus();
			return;
		}

		var memberCheck = false;
		var checkUrl1 = '/commonInc/include/ajaxRequestText.jsp?ID=' + userid + '&NAME=' + paramname + '&JOIN=1';
		new Ajax.Request( checkUrl1, {
			method     : 'post',
			parameters : {
			},
			asynchronous:false,
			onSuccess : function(request) {
				try {
					if(request.responseText.indexOf("FALSE") != -1) {
						memberCheck = true;
					}
				} catch(e) {
					alert(e.description);
				}
			},
			on401: function() {
				alert("세션이 종료되었습니다.");
				return;
			},
			onFailure : function(request) {
				alert(request.responseText);
				alert("오류 발생");
				return;
			}
		});
		if(memberCheck) {
			document.globalForwardPage.target = "_blank";
			document.globalForwardPage.login_pass.value = escape(name);
			document.globalForwardPage.submit();
			return;
		}

		var popupObj = window.showModalDialog("/mypage/myclass.do?mode=memberUpdate", self, "dialogHeight=790px;dialogWidth=500px; scroll=yes; status=yes; help=no; center=yes");
		
		var hp1 = "";
		var hp2 = "";
		var hp3 = "";
		var email = "";
		var dept = "";
		var deptsub = "";
		var jiknm = "";
		var check = "N";

		var useragent = navigator.userAgent;

		if((useragent.indexOf('MSIE 6')  > 0) || (useragent.indexOf('MSIE 7')  > 0) || (useragent.indexOf('MSIE 8')  > 0)) {
			try {
				hp1 = popupObj.hp1;
				hp2 = popupObj.hp2;
				hp3 = popupObj.hp3;
				email = popupObj.email;
				dept = escape(encodeURIComponent(popupObj.dept_name));
				deptsub = escape(encodeURIComponent(popupObj.deptsub));
				jiknm = escape(encodeURIComponent(popupObj.degreename));
				check = popupObj.close;				
			} catch (e) {
				check = "N";
			}
		} else if((useragent.indexOf('MSIE 9')  > 0) || (useragent.indexOf('MSIE 10')  > 0)) {
			try {
				hp1 = popupObj["hp1"];
				hp2 = popupObj["hp2"];
				hp3 = popupObj["hp3"];
				email = popupObj["email"];
				dept = escape(encodeURIComponent(popupObj["dept_name"]));
				deptsub = escape(encodeURIComponent(popupObj["deptsub"]));
				jiknm = escape(encodeURIComponent(popupObj["degreename"]));
				check = popupObj["close"];
			} catch (e) {
				check = "N";
			}
		} else {
			try {
				hp1 = popupObj.hp1;
				hp2 = popupObj.hp2;
				hp3 = popupObj.hp3;
				email = popupObj.email;
				dept = escape(encodeURIComponent(popupObj.dept_name));
				deptsub = escape(encodeURIComponent(popupObj.deptsub));
				jiknm = escape(encodeURIComponent(popupObj.degreename));
				check = popupObj.close;				
			} catch (e) {
				check = "N";
			}
		}

		if(check == "Y") {			
			var checkUrl2 = '/commonInc/include/ajaxRequestText.jsp?ID=' + userid + '&NAME=' + paramname + '&JOIN=0&EMAIL=' + email + '&HP1='  + hp1 + '&HP2='  + hp2 + '&HP3='  + hp3 + '&COMPANY_BU='  + deptsub + '&COMPANY_JIKGUB='  + jiknm + "&COMPANY_NAME=" + dept;

			new Ajax.Request(checkUrl2, {
				method     : 'post',
				parameters : {
				},
				asynchronous:false,
				onSuccess : function(request) {
					try {

						if(request.responseText.indexOf("TRUE") != -1) {
							document.globalForwardPage.target = "_blank";
							document.globalForwardPage.login_pass.value = escape(name);
							document.globalForwardPage.submit();
							return;
						} else {
							alert("등록 실패 관리자에게 문의해주세요.");
						}
					} catch(e) {
						alert(e.description);
					}
				},
				on401: function() {
					alert("세션이 종료되었습니다.");
					return;
				},
				onFailure : function() {
					alert("오류 발생");
					return;
				}
			});

			return;
		}

	} else {
		alert("로그인후 사용하실수 있습니다.");
		return;
	}    
}

function popupGrcodeList() { 
	
	if(<%=loginInfo.isLogin()%> == true) {
		popWin('/commonInc/popup.do?mode=grcodelist','newpopup','720','550','yes','yes');
	} else {
		alert("로그인후 이용 가능합니다.");
	}
}

function popupBasicList() { 
	
	if(<%=loginInfo.isLogin()%> == true) {
		 popWin('/homepage/attend.do?mode=attendList','baiscpopup','1020','850','yes','yes');  		
		 /* popWin('/commonInc/popup.do?mode=basiclist','baiscpopup','1020','850','yes','yes');  */
	} else {
		alert("로그인후 이용 가능합니다.");
	}
}

//-->
</script>
<style type="text/css">

.phoneTtle2{

	margin-bottom: -10px;
}

.bodycenter{
  position:absolute;

}

</style>
</head>
  <body>
        <div class="skip">
            <a href="#content">메뉴 건너뛰기</a>
        </div>
        <div class="wrap bodycenter">
            <header>
				<div class="header_area">
					<h1><a href="/"><img src="/homepage_2019/images/common/logo.png" alt="인천광역시 인재개발원 로고" /></a></h1>
					<ul id="gnb">
						<li><a href="javascript:fnGoMenu('1','myquestion');">마이페이지</a></li>
						<li><a href="/homepage/index.do?mode=sitemap">사이트맵</a></li>
					</ul>
				</div>
			</header>
			<div class="lnb_box">
				<ul id="lnb">
					<li class="depth1_list">
						<a href="#none" class="depth1" style="padding-left: 10px;">인재개발원 소개</a>
						<ul class="depth2_box">
							<li class="depth2_list">
								<a href="javascript:fnGoMenu('7','eduinfo7-1');" class="depth2">인사말</a>
							</li>
							<li class="depth2_list">
								<a href="/homepage/renewal.do?mode=introduction02" class="depth2">비전 및 목표</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu('7','eduinfo7-2');" class="depth2">연혁</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu('7','eduinfo7-3');" class="depth2">조직 및 업무</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu('5','noticeList');" class="depth2">인재개발원 알림</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu('7','lawsList');" class="depth2">법률/조례</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu('7','eduinfo7-6');" class="depth2">시설현황</a>
							</li>
						</ul>
					</li>
					<li class="depth1_list">
						<a href="#none" class="depth1">교육과정</a>
						<ul class="depth2_box">
							<li class="depth2_list">
								<a href="javascript:fnGoMenu(2,'eduinfo2-1');" class="depth2">입교안내</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu(2,'eduinfo2-2');" class="depth2">교육훈련체계</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu(2,'eduinfo2-3');" class="depth2">연간교육일정</a>
							</li>
							<li class="depth2_list">
								<a href="https://hrd.incheon.go.kr/homepage/course.do?mode=eduinfo3-3" class="depth2">집합교육</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu(3,'eduinfo3-4');" class="depth2">e-러닝</a>
							</li>
						</ul>
					</li>
					<li class="depth1_list">
						<a href="#none" class="depth1">교육신청</a>
						<ul class="depth2_box">
							<li class="depth2_list">
								<a href="javascript:fnGoMenu(4,'attendList');" class="depth2">집합교육 신청 및 취소</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:popupEduInfo();" class="depth2">e-러닝(외국어)</a>
							</li>
							<li class="depth2_list">
								<a href="http://incheon.nhi.go.kr/" class="depth2" target="_blink">e-러닝(전문)</a>
							</li>
						</ul>
					</li>
					<li class="depth1_list">
						<a href="#none" class="depth1">교육지원</a>
						<ul class="depth2_box">
							<li class="depth2_list">
								<a href="/homepage/renewal.do?mode=eduinfo8-1" class="depth2">분야별 교육안내</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu(5,'faqList');" class="depth2">자주하는질문</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu(5,'educationDataList');" class="depth2">자료실</a>
							</li>
							<li class="depth2_list">
								<a href="/homepage/renewal.do?mode=eduinfotel" class="depth2">과정별 안내전화</a>
							</li>
							<li class="depth2_list">
								<a href="/homepage/renewal.do?mode=readingList" class="depth2">교육생 숙지사항</a>
							</li>
							<li class="depth2_list">
								<a href="/homepage/renewal.do?mode=courseTimetable" class="depth2">과정시간표</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu(7,'eduinfo7-4');" class="depth2">식단표</a>
							</li>
						</ul>
					</li>
					<li class="depth1_list">
						<a href="#none" class="depth1">참여공간</a>
						<ul class="depth2_box">
							<li class="depth2_list">
								<a href="javascript:fnGoMenu('5','uploadbbsList');" class="depth2">신임인재평가</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu(5,'requestList');" class="depth2">묻고답하기</a>
							</li>
							<li class="depth2_list">
								<a href="javascript:fnGoMenu('5','epilogueList');" class="depth2">수강후기</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
			<div id="content" class="content">
				<div class="visual_box">
					<ul id="visual">
<!-- 						<li> 
						<a href="http://incheon.nhi.go.kr" target="_blink">
							<img src="/homepage_2019/banner/banner08.jpg" alt="첫 번째 이미지" />
						</a>
						</li> -->

						<li>
						<a href="/homepage/introduce.do?mode=eduinfo7-6-4">
							<img src="/homepage_2019/banner/banner09.jpg" alt="두 번째 이미지" />
						</a>
						
						</li>
						  
						<li>
							<img src="/homepage_2019/banner/banner10.jpg" alt="세 번째 이미지" />
						</a>
						</li>
						
					</ul>
				</div>
				<div class="quick_login_box">
					<ul class="quick_box">
						<li><a href="javascript:fnGoMenu(4,'attendList');"><font style="color: #0079BA; font-weight: bold; ">공무원 집합<br />교육 신청</font></a></li>
						<li><a href="http://incheon.nhi.go.kr/" target="_blink"><font style="color: #0079BA; font-weight: bold; ">공무원 e-러닝<br />(전문) 신청</font></a></li>
						<li><a href="javascript:popupEduInfo();"><font style="color: #0079BA; font-weight: bold; ">공무원 e-러닝<br />(외국어) 신청</font></a></li>
						<li><a href="javascript:move_cyber();">인천시민<br />사이버교육센터</a></li> 
						<li><a href="/homepage/introduce.do?mode=eduinfo7-6-4">시설대관 안내</a></li> 
					</ul>
					
					<jsp:include page="/login/login_main.jsp" flush="false"/>
					
				</div>	
				<div class="tab_link_box">
					<div class="tab_box">
						<ul id="tab">
							<li class="tab_list">								
								<a href="#none" class="tab_title tablinks" onclick="openAlim(this, 'alim1')">인재개발원알림</a>
								
								<ul class="ntctabcontent tab_content_box tab_notice" id="alim1">
									<%=sbListHtml%>
									<li class="tab_more">
										<a href="/homepage/support.do?mode=noticeList"><img src="/homepage_2019/images/main/icon_more.png" alt="더보기" /></a>
									</li>
								</ul>
								
							</li>
							
							
							<li class="tab_list">
								<a href="#none" class="tab_title tablinks" onclick="openAlim(this, 'alim2')">집합교육</a>
								<div class="tab_content_box tab_study ntctabcontent" id="alim2" >
									<div class="tab_scroll_area">
										<table class="study">
											<colgroup>
												<col />
												<col />
												<col />
												<col />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="row">과정명</th>
													<th scope="row">신청기간</th>
													<th scope="row">인원</th>
													<th scope="row">이수시간</th>
													<th scope="row">교육기간</th>
												</tr>
											</thead>
											<tbody>
											<%= nonCyberListHtml %>												
											</tbody>
										</table>
									</div>
									<a href="/homepage/course.do?mode=eduinfo3-1" class="tab_more"><img src="/homepage_2019/images/main/icon_more.png" alt="더보기" /></a>
								</div>
							</li>
							<li class="tab_list">
								<a href="http://incheon.nhi.go.kr" target="_blink;" class="tab_title tablinks">인천시 나라배움터</a>								
<%--							<a href="http://incheon.nhi.go.kr" onclick="openAlim(this, 'alim3')" class="tab_title tablinks">인천시 나라배움터</a>
 								<div class="tab_content_box tab_study ntctabcontent" id="alim3" >
									<div class="tab_scroll_area">
										<table class="study">
											<colgroup>
												<col />
												<col />
												<col />
												<col />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="row">과정명</th>
													<th scope="row">신청기간</th>
													<th scope="row">인원</th>
													<th scope="row">이수시간</th>
													<th scope="row">교육기간</th>
												</tr>
											</thead>
											<tbody>
											<%= cyberListHtml %>									
											</tbody>
										</table>
									</div>
									<a href="http://incheon.nhi.go.kr" class="tab_more"><img src="images/main/icon_more.png" alt="더보기" /></a>
								</div> --%>
							</li>
						</ul>
					</div>
					
					
					<div class="tab_link">
						<h3 class="link_title">교육생 숙지사항</h3>
						<ul class="link">
							<li><a href="/commonInc/fileDownload.do?mode=popup&groupfileNo=20778" target="_blink;">강사수당 지급기준</a></li>
							<li><a href="/down/2021_recg_edu.hwp">교육인정시간 기준</a></li>
						</ul>                               
					</div>                                              
				</div>     
				
				                                

				<div class="year_phone_box">
					<div class="year_box">
					<h3 class="link_title"><a href="#none">연간교육일정</a></h3>
						<%
							int month = Integer.parseInt(requestMap.getString("month")); 
						%>
						<ul id="month">
							<li class="month_list">					 
								   <a class="month_title" onclick="openMonth(this, '1')" <%if(month==1){%>id="defaultOpen2"<%} %>>1월</a>
							    <div class="month_scroll_area" id="thismonth01">
							    <ul id="mex01" class="month_content_box">
																			
								</ul>							    									
								</div>						  									
							</li>
							
							<li class="month_list">					 
								   <a class="month_title" onclick="openMonth(this, '2')" <%if(month==2){%>id="defaultOpen2"<%} %>>2월</a>
							    <div class="month_scroll_area" id="thismonth02">
									<ul id="mex02" class="month_content_box">																			
									</ul>
								</div>								
							</li>
							
							<li class="month_list">					 
								   <a class="month_title" onclick="openMonth(this, '3')" <%if(month==3){%>id="defaultOpen2"<%} %>>3월</a>
							    <div class="month_scroll_area" id="thismonth03">
									<ul id="mex03" class="month_content_box">																			
									</ul>
								</div>								
							</li>
							
							<li class="month_list">					 
								   <a class="month_title" onclick="openMonth(this, '4')" <%if(month==4){%>id="defaultOpen2"<%} %>>4월</a>
							    <div class="month_scroll_area" id="thismonth04">
									<ul id="mex04" class="month_content_box">																			
									</ul>
								</div>								
							</li>
							
							<li class="month_list">					  
								   <a class="month_title" onclick="openMonth(this, '5')" <%if(month==5){%>id="defaultOpen2"<%} %>>5월</a>
							    <div class="month_scroll_area" id="thismonth05">
									<ul id="mex05" class="month_content_box">	 																		
									</ul>
								</div>								
							</li>
							
							<li class="month_list">					 
								   <a class="month_title test06" onclick="openMonth(this, '6')" <%if(month==6){%>id="defaultOpen2"<%} %>>6월</a>
							    <div class="month_scroll_area" id="thismonth06">
									<ul id="mex06" class="month_content_box">																							 							  																
									</ul>
								</div>								
							</li>
							
							
							<li class="month_list">					 
								   <a class="month_title" onclick="openMonth(this, '7')" <%if(month==7){%>id="defaultOpen2"<%} %>>7월</a>
							    <div class="month_scroll_area" id="thismonth07">
									<ul id="mex07" class="month_content_box">																			
									</ul>
								</div>								 
							</li>
							
							<li class="month_list">					 
								   <a class="month_title" onclick="openMonth(this, '8')" <%if(month==8){%>id="defaultOpen2"<%} %>>8월</a>
							    <div class="month_scroll_area" id="thismonth08">
									<ul id="mex08" class="month_content_box">																			
									</ul>
								</div>								
							</li>
							
							<li class="month_list">					 
								   <a class="month_title" onclick="openMonth(this, '9')" <%if(month==9){%>id="defaultOpen2"<%} %>>9월</a>
							    <div class="month_scroll_area" id="thismonth09">
									<ul id="mex09" class="month_content_box">																			
									</ul>
								</div>								
							</li>
							
							<li class="month_list">					 
								   <a class="month_title" onclick="openMonth(this, '10')" <%if(month==10){%>id="defaultOpen2"<%} %>>10월</a>
							    <div class="month_scroll_area" id="thismonth10">
									<ul id="mex10" class="month_content_box">
																										
									</ul>
								</div>								
							</li>
							
							<li class="month_list">					 
								   <a class="month_title" onclick="openMonth(this, '11')" <%if(month==11){%>id="defaultOpen2"<%} %>>11월</a>
							    <div class="month_scroll_area" id="thismonth11">
									<ul id="mex11" class="month_content_box">																			
									</ul>
								</div>								
							</li>
							
							<li class="month_list">					 
								   <a class="month_title" onclick="openMonth(this, '12')" <%if(month==12){%>id="defaultOpen2"<%} %>>12월</a>
							    <div class="month_scroll_area" id="thismonth12">
									<ul id="mex12" class="month_content_box">																			
									</ul>
								</div>								
							</li>
							
							<li class="month_more">
								<a href="#none"><img src="/homepage_2019/images/main/icon_more.png" alt="더보기" /></a>
							</li>
						</ul>
					</div>
<script>
function openMonth(evt, cityName) {
		
    var i, montabcontent, motablinks;
    var month;
  
   
/* 	$(".montabcontent").each(function(){			
		$(this).css("display", "none");		
	}); */
  
	$(".motablinks").each(function(){
		var new_class = new String($(this).attr("class")).replace(" active","");	
		$(this).attr("class", new_class);	
	}); 
	
	if(cityName.length == 2 ) {
		month = cityName;
	}else{
		month = '0'+cityName;	
	}

	ajax(month);
   //document.getElementById("mex"+month).style.display = "block";    
   $(evt).attr("class",$(evt).attr("class")+" active");
  
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen2").click();
</script>
			
					<div class="tab_phone">
						<h3 class="link_title">교육 및 시설 안내</h3>
						<ul class="phone">
							<li>집합교육안내<span>032-440-7676</span></li>
							<li>e-러닝(외국어)안내<span>032-440-7682</span></li>
							<li>e-러닝(전문)안내<span>032-440-7684</span></li>
							<li>강사관련문의<span>032-440-7663/7685</span></li>
							<li>중견간부 양성과정<span>032-440-7674</span></li>
							<li>외국어 정예과정<span>032-440-7675</span></li>
							<li>시설대관문의<span>032-440-7633</span></li>
						</ul>
					</div>
				</div>
				<div class="foot_link">
				 <!-- <span><a href="javascript:popupGrcodeList();">신임인재양성과정 교육안내</a></span> -->
				 <span><a href="/homepage/support.do?mode=noticeView&boardId=NOTICE&seq=394">신임인재양성과정 교육안내</a></span>
					<span><a href="http://incheon.nhi.go.kr" target="_blank">인천시 나라배움터 e-러닝</a></span>
					<span><a href="/homepage/support.do?mode=faqView&fno=64">홈페이지 환경설정 필수조치사항</a></span>
				</div>
				<div class="menu_quick_box">
					<div class="menu_title"><span>메뉴 바로가기</span></div>
					<div class="menu_quick">
						<span><a href='javascript:popWin("/homepage/studyhelp/learning_guide01.html","ddd","820","515","no","no")'>학습도우미</a></span>
						<span><a href="/homepage/infomation.do?mode=eduinfo2-3">연간교육일정</a></span>
						<span><a href="/homepage/support.do?mode=faqList">자주하는 질문</a></span>
						<span><a href="javascript:popWin('http://152.99.42.151/','ccc','658','540','yes','yes')">PC원격지원</a></span>
						<span><a href="https://cad.logodi.go.kr/dc" target="_blank">역량진단시스템</a></span>
						<span><a href="/homepage/introduce.do?mode=eduinfo7-7">찾아오시는길</a></span>
					</div>
				</div>
			</div>
            <footer>
				<div class="footer_area">
					<div class="footer_link">
						<span><a href="/homepage/index.do?mode=policy">개인정보처리방침</a></span>
						<span><a href="/homepage/introduce.do?mode=eduinfo7-7">찾아오시는길</a></span>
						<span><a href="/homepage/index.do?mode=worktel">업무별연락처</a></span>
						<span><a href="/homepage/index.do?mode=videopolicy">영상정보처리기기운영관리 방침</a></span>
						<span><a href="/homepage/index.do?mode=spam">이메일 무단수집거부</a></span>
					</div>
					<address>22711 인천광역시 서구 심곡로 98&nbsp;<span>&nbsp;FAX (032)440-8795</span></address>
					<p>홈페이지에 게시된 이메일주소가 자동 수집되는 것을 거부하며, 위반시 정보통신 관련법령에 의거해 처벌됩니다.</p>
					<small>CopyRight &copy; 2007 인천광역시인재개발원, All rights Reserved.&nbsp;<span>&nbsp;이 사이트의 콘텐츠를 무단 사용할 수 없습니다.</span></small>
					<div class="qrcode"><img src="/homepage_2019/images/main/qrcode.png" alt="QR코드" /></div>
				</div>
            </footer>
        </div>
    </body>
</html>
<%!
	public static boolean isNew(String regday, int interval) {
		Calendar today = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
		Calendar regCal = Calendar.getInstance();
		Date current;
		Date regdate;
		int diffDay;
		boolean isnew;
		try {
			int regYear = Integer.parseInt(regday.substring(0, 4));
			int regMonth = Integer.parseInt(regday.substring(4, 6)) - 1;
			int regDay = Integer.parseInt(regday.substring(6, 8));
			int regHour = Integer.parseInt(regday.substring(8, 10));
			int regMinute = Integer.parseInt(regday.substring(10, 12));
			int regSecond = Integer.parseInt(regday.substring(12, 14));
			regCal.set(regYear, regMonth, regDay, regHour, regMinute, regSecond);
			current = today.getTime();
			regdate = regCal.getTime();
			diffDay = Math.abs((int) ((current.getTime() - regdate.getTime()) / 1000.0 / 60.0 / 60.0 / 24.0));
			isnew = (diffDay < interval) ? true : false;
		} catch (Exception e) {
			isnew = false;
		}
		return isnew;
	}
%>
