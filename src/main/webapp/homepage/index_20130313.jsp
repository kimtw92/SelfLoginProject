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
	
	
	StringBuffer sbListHtml = new StringBuffer();
	
	String pageStr = "";
	
	if(listMap.keySize("seq") > 0){		
		for(int i=0; i < listMap.keySize("seq") && i < 4; i++){
			String title = listMap.getString("title", i);
			String newImage = "";
			if(title.length() >= 34) {
				title = title.substring(0,32) + "...";
			}
			if(isNew(listMap.getString("regdate", i).replaceAll("-","")+"000000", 10)) {
				newImage = " <img src=\"../images/main/new.gif\" alt=\"new\" />";
			}
            sbListHtml.append("	<li><a href=\"/homepage/support.do?mode=noticeView&amp;boardId=NOTICE&amp;seq="+listMap.getString("seq", i)+"\">" + title + newImage + "</a> <span class=\"date\"> "+ listMap.getString("regdate", i) + "</span> </li>");
                
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
			cyberListHtml.append("	<td class=\"bl0 sbj\"> <a href='javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&amp;grcode="+cyberListMap.getString("grcode", i)+"&amp;grseq="+cyberListMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")'>"+ title +"</a></td>");
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
			nonCyberListHtml.append("	<td class=\"bl0 sbj\"><a href='javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&amp;grcode="+nonCyberlistMap.getString("grcode", i)+"&amp;grseq="+nonCyberlistMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")'>"+nonCyberlistMap.getString("grcodeniknm", i) +"</a></td>");
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
	
	// <li><span class="tit">[사이버]</span><a href="">e-공무원 노사관계 과정</a><span class="data">2010-02-10~2010-02-10</span></li>
	
	if(monthlistMap.keySize("grcodeniknm") > 0){		
		for(int i=0; i < monthlistMap.keySize("grcodeniknm"); i++){
			//if( i+1 != monthlistMap.keySize("grcodeniknm") ) {
				//monthListHtml.append("<li>");					
			//}else {
			//	monthListHtml.append("<li class=\"end\">");
			//}
			
			String title = monthlistMap.getString("grcodeniknm", i);
			String subStrTitle = title;
			if(title.length() >= 17 )	subStrTitle = title.substring(0, 16) + "...";
			
			monthListHtml.append("<li>");
			monthListHtml.append("	<span style=\"text-align:left;\" class=\"tit\">[" + monthlistMap.getString("gubun", i) + "]</span><a href=\"javascript:popWin('/homepage/course.do?mode=courseinfopopup&amp;grcode="+monthlistMap.getString("grcode", i)+"&amp;grseq="+monthlistMap.getString("grseq", i)+"','aaa','603','680','yes','yes')\" title=\""+title+"\">"+ subStrTitle +"</a>");
			monthListHtml.append("	<span class=\"data\">" + monthlistMap.getString("started", i) + "~"+monthlistMap.getString("enddate", i) +"</span>");
			monthListHtml.append("</li> \n");	
		}
	} else {
			monthListHtml.append("<li style=\"text-align:left;\">");
			monthListHtml.append("해당월은 과정이 없습니다.");
			monthListHtml.append("</li> \n");	
	}

	// 주간일정 리스트
	DataMap weeklistMap = (DataMap)request.getAttribute("WEEK_LIST");
	weeklistMap.setNullToInitialize(true);
	
	StringBuffer weekListHtml = new StringBuffer();
	if(weeklistMap.keySize("title") > 0){
		for(int i=0; i < weeklistMap.keySize("title"); i++){
			weekListHtml.append(weeklistMap.getString("mm",i)+"월" +weeklistMap.getString("dd",i)+"일 : "+weeklistMap.getString("title",i)+"  " );
		}
	}
	
	// 우수강의 리스트
	DataMap goodLectureListMap = (DataMap)request.getAttribute("GOOD_TEACHER_LIST");
	goodLectureListMap.setNullToInitialize(true);
	
	StringBuffer goodLectureListHtml = new StringBuffer();
	
	if(goodLectureListMap.keySize("rownum") > 0){
		for(int i=0; i < goodLectureListMap.keySize("rownum"); i++){

			goodLectureListHtml.append("<dl> ");
			
			if(goodLectureListMap.getString("gubun",i).equals("1")) {
				goodLectureListHtml.append("	<dt><a href=\""+goodLectureListMap.getString("url",i)+"\"><img width=\"57\" height=\"52\" src=\"/pds"+goodLectureListMap.getString("filePath",i)+"\" alt='.' /></a></dt> ");				
			}else if(goodLectureListMap.getString("gubun",i).equals("2")){
				goodLectureListHtml.append("	<dt><a href=javascript:popWin(\""+goodLectureListMap.getString("url",i)+ "\",\"aaa\",\"430\",\"440\",\"yes\",\"yes\")><img width=\"57\" height=\"52\" src=\"/pds"+goodLectureListMap.getString("filePath",i)+"\" alt='.'/></a></dt> ");
			}
			goodLectureListHtml.append("	<dd>"+goodLectureListMap.getString("title",i)+" ("+goodLectureListMap.getString("ldate",i)+")</dd> ");
			goodLectureListHtml.append("</dl> ");
			if(i ==0) {
				goodLectureListHtml.append("<div class=\"spc\"></div>");
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
<title>인재개발원</title>
<link rel="STYLESHEET" type="text/css" href="../commonInc/css/style.css" />
<script type="text/javascript" language="javascript" src="../js/navigation.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/<%= skinDir %>/gnbMenu.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/NChecker.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/protoload.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/homeCategory.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/inno/InnoDS.js"></script>

<!-- 추가 -->
<!-- <script type="text/javascript" src="/share/js/common.js"></script> -->
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<script type="text/javascript" language="javascript" src="/homepage_new/js/navigation.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/zoominout.js"></script>

<script language="javascript">
<!--

// 권한 셀렉트 박스 변경
function fnSelectAuth(){
		
	var pauth = $F("cboAuth");
	var url = "/commonInc/ajax/currentAuthSet.do?mode=auth";
	var pars = "cauth=" + pauth;
	
	var myAjax = new Ajax.Request(
			url, 
			{
				method: "get", 
				parameters: pars, 
				onComplete: fnAuthComplete
			}
		);
}
function fnAuthComplete(originalRequest){

	var cboAuthValue = $F("cboAuth");
	var url = "";
	
	url = fnHomeUrl(cboAuthValue);

	url +="&cboAuth="+$F("cboAuth");
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

function showMonthTab(month) {
	for(var i=1;i<=12;i++) {
		$("num_" + i).className = "";
	}
	$("num_" + month).className = "on";
	if(month.length == 2 ) {
		
	}else{
		month = '0'+month;	
	}
		
	ajax(month);
}

function ajax(month) {

		var url = "index.do";
		//pars = "?month=" + month + "&mode=ajax";
		//var divID = "monthajax";
		
		new Ajax.Request(url,
				{
					method: 'post',  
					parameters: { 
									"month" : month,
									"mode"  : 'ajax'
								 },
					onLoading : function(){
						$('monthajax').startWaiting('bigWaiting');
						//$("monthajax").startWaiting();
						//window.setTimeout(E.stopWaiting.bind(E),3000);
					},
					onSuccess : function(transport){

						$('monthajax').update(transport.responseText);
						$('monthajax').innerHTML;
										
					},
					onFailure : function(){					
						//window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 3000);
						alert("데이타를 가져오지 못했습니다.");
					},
					onComplete : function() {
						window.setTimeout( $('monthajax').stopWaiting.bind( $('monthajax') ), 3000);
						//$('monthajax').stopWaiting('bigWaiting');
					}				
				}
			);
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
<%
	DataMap popupListMap = (DataMap)request.getAttribute("POPUP_LIST");
	popupListMap.setNullToInitialize(true);
	
	if(popupListMap.keySize("no") > 0){
		for(int i=0; i < popupListMap.keySize("no"); i++){	
%>
		var cookie= getCookie('CookieName<%=i+1%>');
		if (cookie!= "noPopup<%=i+1%>") {
			window.open('<%="/homepage/index.do?mode=popup"+(i+1)+"&no="+popupListMap.getString("no",i)%>','<%="pop"+(i+1)%>','left=<%=popupListMap.getString("popupLeft",i)%>,top=<%=popupListMap.getString("popupTop",i)%>,scrollbars=no,resizable=no,width=<%=popupListMap.getString("popupWidth",i)%>,height=<%=popupListMap.getString("popupHeight",i)%>');
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
		open ("http://www.cyber.incheon.kr","NewWindow3",
		"left=0, top=0, toolbar=yes, location=yes, directories=no, status=yes, menubar=yes, scrollbars=yes, resizable=yes, width=1024, height=768");
	}

	//function move_winglish() {
		//if(<%=loginInfo.isLogin()%> != false) {
			//alert("로그인 되었어용^^");
			//location.href="/homepage/index.do?mode=gowinglish";
			//location.href="http://incheon.winglish.com";
			//alert("2011년 공무원 사이버외국어교육 3월중 개시할 예정입니다.");
		//}else {
			//alert("로그인 후 사용하세요.");
			//alert("2011년 공무원 사이버외국어교육 3월중 개시할 예정입니다.");
		//}
	//}

// http://sehouse.edu9.co.kr/eduhouse/member/check.asp?kvt=<%=loginInfo.getSessUserId() %>&anm=<%=loginInfo.getSessName() %>&pkey=eduhouse
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
<!--

function fnGoMenu(menuNum,htmlId){
	//location.href = "/homepage/html.do?mode=ht&htmlId=" + htmlId;
	if(menuNum == '1') {
		location.href = "/mypage/myclass.do?mode=" + htmlId;	
	} else if(menuNum == '2') {
		location.href = "/homepage/infomation.do?mode=" + htmlId;
	}else if(menuNum == '3') {
		location.href = "/homepage/course.do?mode=" + htmlId;
	}else if(menuNum == '4') {
		location.href = "/homepage/attend.do?mode=" + htmlId;
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

//-->

<!-- 팝업존
var inx=0,timer;
var bannerSize = <%=popupZoneListSize%>;
function ChangeImg(){
	
	$$('div.popbtn img').each(function(obj) {
		if(obj.src.indexOf("_on") > 0)
			obj.src = obj.src.replace("_on", "");
	});
	if($('popbtn'+inx).src.indexOf("_on") < 0)
		$('popbtn'+inx).src = $('popbtn'+inx).src.replace(".gif", "_on.gif");
	
	$$('div.pic img').each(function(obj) {
		obj.hide();
	});
	$('pop'+inx).show();

	inx+=1;
	if(inx>bannerSize){inx=0;}
}

function startSlide(){
	timer=setInterval("ChangeImg();",3000);
}

document.observe("dom:loaded", function() {
	startSlide();
	
	$$('div.popbtn img').each(function(obj) {
		obj.style.cursor = "hand";
	    Event.observe(obj, 'mouseover', function() {   
	    	
	    	$$('div.popbtn img').each(function(obj2) {
	    		if(obj2.src.indexOf("_on") > 0)
	    			obj2.src = obj2.src.replace("_on", "");
	    	});
	    	if(obj.src.indexOf("_on") < 0)
    			obj.src = obj.src.replace(".gif", "_on.gif");
	    	
	    	$$('div.pic img').each(function(obj3) {
	    		obj3.hide();
	    	});
	    	$('pop'+obj.id.substring(6)).show();
	    	inx = eval(obj.id.substring(6));
		}); 
	});

	Event.observe($('popupStart'), 'click', function(obj) {  
		if($('popupStart').src.indexOf("04") > 0){
			$('popupStart').src = $('popupStart').src.replace("04", "02");
			clearInterval(timer);
		}else if($('popupStart').src.indexOf("02") > 0){
			$('popupStart').src = $('popupStart').src.replace("02", "04");
			startSlide();
		}
		
	});
	
	/*Event.observe($('popupLeft'), 'mouseover', function() {  
		clearInterval(timer);
	});
	Event.observe($('popupLeft'), 'mouseout', function() {  
		startSlide();
	});*/
	Event.observe($('popupLeft'), 'click', function() {  
		var inx2 = inx-1;
		if(inx2>bannerSize)
			inx2=0;
		if(inx2<0)
			inx2=<%=popupZoneListSize%>;
		inx = inx2;
		
		$$('div.popbtn img').each(function(obj) {
			if(obj.src.indexOf("_on") > 0)
				obj.src = obj.src.replace("_on", "");
		});
		if($('popbtn'+inx).src.indexOf("_on") < 0)
			$('popbtn'+inx).src = $('popbtn'+inx).src.replace(".gif", "_on.gif");
		
		$$('div.pic img').each(function(obj) {
			obj.hide();
		});
		$('pop'+inx).show();
	});
	
	/*Event.observe($('popupRight'), 'mouseover', function() {  
		clearInterval(timer);
	});
	Event.observe($('popupRight'), 'mouseout', function() {  
		startSlide();
	});*/
	Event.observe($('popupRight'), 'click', function() {  
		var inx2 = inx+1;
		if(inx2>bannerSize)
			inx2=0;
		if(inx2<0)
			inx2=<%=popupZoneListSize%>;
		inx = inx2;
		$$('div.popbtn img').each(function(obj) {
			if(obj.src.indexOf("_on") > 0)
				obj.src = obj.src.replace("_on", "");
		});
		if($('popbtn'+inx).src.indexOf("_on") < 0)
			$('popbtn'+inx).src = $('popbtn'+inx).src.replace(".gif", "_on.gif");
		
		$$('div.pic img').each(function(obj) {
			obj.hide();
		});
		$('pop'+inx).show();
	});
});
//-->
</script>
</head>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init();popup();" id="zoom" style = "overflow-x:hidden;">
	<div id="wrap">
			<!-- header-->
			<div id="header">
				<div class="header">
					<div class="toparea">
					<h1><a href="/">인천광역시 인재개발원</a></h1>
					<div id="menu">
						<dl class="gnb01">
							<dd>
								<a href="http://www.facebook.com/cyberincheon" target="_blank" class="link_area1"><img src="/images/fc.gif" border="0" width="23" height="23"/></a>
								</dd>
								<dd class="link_area">
								<a href="https://twitter.com/cyberincheon" target="_blank"  class="link_area2"><img src="/images/tw.gif" border="0" width="23" height="23"/></a>
								</dd>
								<dd>
								<a href="#" class="link_area3">
								<iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.facebook.com%2Fcyberincheon&send=false&layout=button_count&width=180&show_faces=false&action=like&colorscheme=light&font=arial&height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:90px; height:21px;" allowTransparency="true"></iframe>
								</a>
								</dd> 
								<dd>
								<a href="https://twitter.com/share" class="twitter-share-button link_area4" data-url="https://twitter.com/cyberincheon" data-via="cyberincheon" data-lang="ko">트윗하기</a>
								<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="http://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
							</dd> 
							<dd><a href="javascript:yangZoom();" class="font_basic">기본</a></dd>
							<dd><a href="javascript:zoomIn();" class="font_up">글자크게</a></dd>
							<dd><a href="javascript:zoomOut();" class="font_down">글자작게</a></dd>
							<dd><a href="/homepage/index.do?mode=sitemap" class="sitemap">sitemap</a></dd>
							<dd><a href="/foreign/english/index.html" class="english">English</a></dd>
							<dd><a href="http://www.cyber.incheon.kr/" target="_blank" class="cyberedu">시민 사이버교육</a></dd>
						</dl>

						<div id="TopMenu">
					<div id="TopMenuSub">
						<ul>
							<li class="menu1">
								<a href="javascript:fnGoMenu(1,'main');"><img id = "menu1Btn" src="/homepage_new/images/main/menua_off.jpg" alt="마이페이지" /></a>
								<div class="TopSubMenu">					
									<ul>
										<li class="first"><a href="#" ></a></li>
									</ul>
								</div>
							</li>
							<li class="menu2">
								<a href="javascript:fnGoMenu(2,'eduinfo2-1');"><img src="/homepage_new/images/main/menub_off.jpg" alt="교육과정" /></a>
								<div class="TopSubMenu">					
									<ul>
										<li class="first"><a href="javascript:fnGoMenu(2,'eduinfo2-1');" >입교안내</a></li>
                            			<li><a href="javascript:fnGoMenu(2,'eduinfo2-2');" >교육훈련체계</a></li>
                            			<li><a href="javascript:fnGoMenu(2,'eduinfo2-3');" >연간교육일정</a></li>
                            			<li><a href="javascript:fnGoMenu(3,'eduinfo3-1');" >집합교육</a></li>
                            			<li><a href="javascript:fnGoMenu(3,'eduinfo3-4');" >사이버교육</a></li>
                            			<li><a href="javascript:fnGoMenu(5,'opencourse');" >공개강의</a></li>
									</ul>
								</div>
							</li>
							<li class="menu3">
								<a href="javascript:fnGoMenu(4,'attendList');"><img src="/homepage_new/images/main/menuc_off.jpg" alt="교육신청" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="javascript:fnGoMenu(4,'attendList');" >교육신청 및 취소</a></li>
									</ul>
								</div>
							</li>
							<li class="menu4">
								<a href="javascript:fnGoMenu(5,'requestList')"><img src="/homepage_new/images/main/menud_off.jpg" alt="참여공간" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="javascript:fnGoMenu(5,'requestList');">묻고답하기</a></li>
										<li><a href="javascript:fnGoMenu(5,'webzine');">포토갤러리</a></li>
										<li><a href="javascript:fnGoMenu(6,'eduinfo6-1');">E-book</a></li>
									</ul>
								</div>
							</li>
							<li class="menu5">
								<a href="/homepage/renewal.do?mode=eduinfo8-1"><img src="/homepage_new/images/main/menue_off.jpg" alt="교육지원" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="/homepage/renewal.do?mode=eduinfo8-1" title="분야별교육안내">분야별교육안내</a></li>
                            			<li><a href="javascript:fnGoMenu(5,'faqList');" >자주하는질문</a></li>
                            			<li><a href="javascript:fnGoMenu(5,'educationDataList');" >자료실</a></li>
                            			<li><a href="/homepage/renewal.do?mode=eduinfotel" >과정별 안내전화</a></li>
                            			<li><a href="http://152.99.42.138/" target = "_blank" >e-도서관</a></li>
                            			<li><a href="/homepage/renewal.do?mode=readingList" >교육생숙지사항</a></li>
                            			<li><a href="/homepage/renewal.do?mode=courseTimetable" >과정시간표</a></li>
                            			<li><a href="javascript:fnGoMenu(7,'eduinfo7-4');" >식단표</a></li>
									</ul>
								</div>
							</li>
							<li class="menu6">
								<a href="javascript:fnGoMenu('7','eduinfo7-1');"><img src="/homepage_new/images/main/menuf_off.jpg" alt="인재개발원 소개" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="javascript:fnGoMenu('7','eduinfo7-1');" >인사말</a></li>
                            			<li><a href="/homepage/renewal.do?mode=introduction02" >비전 및 목표</a></li>
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-8');" >안내동영상</a></li>
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-2');" >연혁</a></li>
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-3');" >조직 및 업무</a></li>
                            			<li><a href="javascript:fnGoMenu('5','noticeList');" >인재개발원 알림</a></li>
                            			<li><a href="javascript:fnGoMenu('7','lawsList');" >법률/조례</a></li>
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-6');" >시설현황</a></li>
                            			<!-- <li><a href="javascript:fnGoMenu('7','eduinfo7-7');" >찾아오시는길</a></li> -->
									</ul>
								</div>
							</li>
						</ul>
					</div>
			</div>
			
				</div>
			</div>
			<div class="visual"><img src="/images/main/main_view.jpg" alt="대한민국의 심장 경제수도 인천" width="990" height="252" /></div>
			<!-- 공지 -->
					<div class="box_layer">
					<dl>
					<dd><div class="schedule"><marquee scrolldelay="150"><%=weekListHtml %></marquee></div></dd>
					</dl>
					</div>

					<!-- 탑 최근게시글 -->
					<div class="box_layer2">
						<dl class="box1">
							<dt>교육생 숙지사항</dt>
							<dd><a href="/down/1_1.pdf">교육훈련계획</a></dd>
							<dd><a href="/down/02.hwp">교육인정시간 기준</a></dd>
							<dd><a href="/down/03.hwp">사이버교육 운영지침</a></dd>
							<dd><a href="/down/04.hwp">사이버과정별 안내서</a></dd>
						</dl>
						<dl class="box2">
							<%=grseqPlanListHtml%>
						</dl>
					</div>
					<!-- //탑 최근게시글 -->
                    <div class="box_layer3">
					<dl>
					<dd><select id="search" name="search" style="width:85px;height:20px;" onChange="selectNotice(value);">
                        <option value="1" selected>교육과정</option>
                        <option value="2">직원이름</option>
                        <option value="3" >직원업무</option>
                        <option value="4" >묻고답하기</option>
                    	</select> </dd>
                    <dd><input class="input02" type="text" id="keyword" name="keyword" style="width:185px"/></dd>
                    <dd><a href="javascript:doSearch($F('search'));"><img src="../images/main/search02.gif" alt="search" /></a></dd>
					</dl>
					</div>
		</div>
	</div>
		<!--// header -->

		<hr />
		<form name="frmSSO" action="http://www.dongabiz.com/ASP/Incheon/SSOlogin.php" method="post" target="_blank">
			<!--필수-->
			<input type="hidden" name="depcode" value="Incheon01">			<!-- 고정값. depcode 값 -->
			<input type="hidden" name="depkey" value="ekqkcs3ks0ldxjqkw1">	 <!-- 고정값. depkey 값 -->

			<input type="hidden" name="name"  value="<%=loginInfo.getSessName() %>">			<!-- 이름 -->
			<input type="hidden" name="userkey1" value="<%=loginInfo.getSessUserId() %>">			<!-- User Number -->
			<!--필수-->
		</form>

		<form id="forwardPage" name="forwardPage" method="post" action="">
			<input type="hidden" name="kvt" value="" />
			<input type="hidden" name="anm" value="" />
			<input type="hidden" name="pkey" value="" />
		</form>

		<div class="main_wrap">
		
		<!-- container -->
        <div id="container">
          <div id="aside">
			<!-- login -->
			<jsp:include page="/login/login.jsp" flush="false"/>					
			<!-- //login -->
			<div class="goto1">
                <!-- a href="javascript:move_winglish();"><img src="../images/main/ich_baner_03.jpg" alt="사이버 어학센터"/></a -->
                <a href="javascript:alert('4월 01일 오픈 예정입니다.');"><img src="../images/main/ich_baner_03.jpg" alt="사이버 어학센터"/></a>
                <a href="javascript:move_cyber_mobile();"><img src="../images/main/ich_baner_08.jpg" alt="사이버교육센터 모바일"/></a>
                <a href="javascript:move_cyber();"><img src="../images/main/ich_baner_06.jpg" alt="사이버교육센터 PC"/></a>
            </div>
		
			<div class="ptab">
			  <ul>
				<li id="li_tabmenu1_atea"><img id="tabmenu1" src="../images/main/tab01_on.gif" alt="교육안내" style = "cursor:hand" onClick="tabmenu(1, 'tabmenu1');"/></li>
				<li id="li_tabmenu2_atea"><img id="tabmenu2" src="../images/main/tab02.gif" alt="시설안내" style = "cursor:hand" onClick="tabmenu(1, 'tabmenu2');"/></li>
			  </ul>
			</div>
			<div id="info_1">
				<img src="../images/main/tab01_11.gif" alt="교육안내 전화안내"/>
			</div>
			<div id="info_2" style="display:none;">
				<img id="info_2" src="../images/main/tab01_12.gif" alt="시설안내"/>
			</div>
          </div>
          <form id="pform" name="pform" method="post">
          <div id="content">
            <!-- Notice Start -->
            <div id="notice">
              <div id="tablist_area">
				  <span><img id="tabmenu3" src="../images/main/notice_tab1_on.gif" alt="공지사항" style = "cursor:hand" onClick="tabmenu(2, 'tabmenu3');"/></span>
					<span><img id="tabmenu4" src="../images/main/notice_tab2.gif" alt="집합교육" style = "cursor:hand" onClick="tabmenu(2, 'tabmenu4');"/></span>
					<span><img id="tabmenu5" src="../images/main/notice_tab3.gif" alt="사이버교육" style = "cursor:hand" onClick="tabmenu(2, 'tabmenu5');"/></span>
			  </div>
              <div id="tab1c1_area">
                <ul>
					<%=sbListHtml%>
                </ul>
              </div>
			  <div id="more_1"><a href="/homepage/support.do?mode=noticeList"><img src="../images/main/more.gif" alt="더보기"></a></div>

              <div id="tab1c2_area" style="display:none;" class="board_tab board_scroll">
				<table summary="집합교육 과정명별 신청기간, 인원, 이수시간, 교육시간 입니다.">
					<caption>집합교육 과정</caption>
					<colgroup><col /><col width="91" /><col width="35" /><col width="53" /><col width="77" /></colgroup>
					<thead>
						<tr>
							<th><p><img src="/images/main/board_tit1.gif" alt="과정명" /></p></th>
							<th><p><img src="/images/main/board_tit2.gif" alt="신청기간" /></p></th>
							<th><p><img src="/images/main/board_tit3.gif" alt="인원" /></p></th>
							<th><p><img src="/images/main/board_tit4.gif" alt="이수시간" /></p></th>
							<th><p class="bgn"><img src="/images/main/board_tit5.gif" alt="교육기간" /></p></th>
						</tr>
					</thead>
					<tbody>
						<%= nonCyberListHtml %>
					</tbody>
				</table>
              </div>
			  <div id="more_2" style="display:none;"><a href="/homepage/infomation.do?mode=eduinfo2-3"><img src="../images/main/more.gif" alt="더보기"></a></div>

              <div id="tab1c3_area" style="display:none;" class="board_tab board_scroll">
				<table summary="집합교육 과정명별 신청기간, 인원, 이수시간, 교육시간 입니다.">
					<caption>집합교육 과정</caption>
					<colgroup><col /><col width="91" /><col width="35" /><col width="53" /><col width="77" /></colgroup>
					<thead>
						<tr>
							<th><p><img src="/images/main/board_tit1.gif" alt="과정명" /></p></th>
							<th><p><img src="/images/main/board_tit2.gif" alt="신청기간" /></p></th>
							<th><p><img src="/images/main/board_tit3.gif" alt="인원" /></p></th>
							<th><p><img src="/images/main/board_tit4.gif" alt="이수시간" /></p></th>
							<th><p class="bgn"><img src="/images/main/board_tit5.gif" alt="교육기간" /></p></th>
						</tr>
					</thead>
					<tbody>
						<%= cyberListHtml %>
					</tbody>
				</table>
              </div>
			  <div id="more_3" style="display:none;"><a href="/homepage/course.do?mode=eduinfo3-3"><img src="../images/main/more.gif" alt="더보기"></a></div>
            </div>
            <!-- Notice End -->
            
            <!-- month -->
            <div class="month_tab">
                <div class="month01"><span class="title_m">이달의 학습</span><span id="month" class="tab1">
<%
	int month = Integer.parseInt(requestMap.getString("month"));
%>
					<a id="num_1" href="javascript:showMonthTab('1');" <%if(month==1){%>class="on"<%} %>>1월</a>
					<a id="num_2" href="javascript:showMonthTab('2');" <%if(month==2){%>class="on"<%} %>>2월</a>
					<a id="num_3" href="javascript:showMonthTab('3');" <%if(month==3){%>class="on"<%} %>>3월</a>
					<a id="num_4" href="javascript:showMonthTab('4');" <%if(month==4){%>class="on"<%} %>>4월</a>
					<a id="num_5" href="javascript:showMonthTab('5');" <%if(month==5){%>class="on"<%} %>>5월</a>
					<a id="num_6" href="javascript:showMonthTab('6');" <%if(month==6){%>class="on"<%} %>>6월</a>
					<a id="num_7" href="javascript:showMonthTab('7');" <%if(month==7){%>class="on"<%} %>>7월</a>
					<a id="num_8" href="javascript:showMonthTab('8');" <%if(month==8){%>class="on"<%} %>>8월</a>
					<a id="num_9" href="javascript:showMonthTab('9');" <%if(month==9){%>class="on"<%} %>>9월</a>
					<a id="num_10" href="javascript:showMonthTab('10');" <%if(month==10){%>class="on"<%} %>>10월</a>
					<a id="num_11" href="javascript:showMonthTab('11');" <%if(month==11){%>class="on"<%} %>>11월</a>
					<a id="num_12" href="javascript:showMonthTab('12');" <%if(month==12){%>class="on"<%} %>>12월</a>			
				</span>
                </div>
				<div class="scrolling">
                <ul class="list" id="monthajax">
					<%= monthListHtml%>
                </ul>
              </div>
            </div>
            <!--//month-->
          </div>
          
          <div id="banner">
			<div class="btn01">
				<ul>
					<li><img src="../images/main/popupzone.gif" alt="팝업존"/></li>
					<li><img id = "popupLeft" style = "cursor:hand" src="/homepage_new/images/main/arrow01.gif" alt="왼쪽 클릭버튼"/></li>
					<li><img id = "popupStart" style = "cursor:hand" src="/homepage_new/images/main/arrow04.gif" alt="정지버튼"/></li>
					<li><img id = "popupRight" style = "cursor:hand" src="/homepage_new/images/main/arrow03.gif" alt="오른쪽 클릭버튼"/></li>
				</ul>
			</div>

           	<div class="popbox">
            	<div class="popscreen">
                	<div class="pic">
                	<%
                	if(popupZoneListMap.keySize("seq") > 0){
                		String linkUrl = "";
                		for(int i= popupZoneListSize; i >= 0; i--){
                			if(popupZoneListMap.getString("linkYn", i).equals("Y")){
                				linkUrl = popupZoneListMap.getString("linkUrl", i);
                			}else{
                				linkUrl = "#";
                			}
                			%>
                			<a href="<%=linkUrl%>" <%if(popupZoneListMap.getString("linkYn", i).equals("Y")){%>target = "<%=popupZoneListMap.getString("linkTarget", i)%>" <%} %>><img id = "pop<%=i %>" <%if(i != 0){ %>style = "display:none"<%} %> src="/pds/popupZone/<%=popupZoneListMap.getString("fileName", i)%>" title="<%=popupZoneListMap.getString("fileAlt", i)%>" alt='.'/></a>
                			<%
                		}
                	}
                	%>
                	</div>
                    <div class="popbtn">
						<ul>
						<%
                	if(popupZoneListMap.keySize("seq") > 0){
                		for(int i= popupZoneListSize; i >= 0; i--){
                			%>
                			<li><img id = "popbtn<%=i %>" src="../images/main/pno0<%=i+1 %><%if(i == 0){ %>_on<%} %>.gif" /></li>
                			<%
                		}
                	}
                	%>
						</ul>
					</div>
                </div>
            </div> 
                

            <div class="banner1"><a href="javascript:goLogodi();"><img src="../images/main/ban05.gif" alt="역량 진단 시스템"/></a></div>
			<div class="banner2"><a href="javascript:fnGoMenu('7','eduinfo7-8');"><img src="../images/main/ban06.gif" alt="안내동영상"/></a></div>
            
            <div class="ttab">
              <ul>
                <li><img id="tabmenu6" style = "cursor:hand" src="../images/main/ttab01_on.gif" alt="오늘의 한마디" onClick="tabmenu(3, 'tabmenu6');"/></li -->
                <li><img id="tabmenu7" style = "cursor:hand" src="../images/main/ttab02.gif" alt="포토갤러리" onClick="tabmenu(3, 'tabmenu7');"/></li>
                <!-- li><img id="tabmenu7" style = "cursor:hand" src="../images/main/ttab02.gif" alt="포토갤러리"/></li -->
              </ul>
            </div>
            <div id="winglish_area">
				<!-- div id="winglish_area01">
					<dl>
						<iframe src="http://www.winglish.com/study/openfree/main/incheon_main_en.asp" width="100%" height="66" frameborder="0" scrolling="no" name="winen">윈글리쉬 데이타 불러오기</iframe>
					</dl>
				</div>
				<div id="winglish_area02">
					<dl>
						<iframe src="http://www.winglish.com/study/openfree/main/incheon_main_ch.asp" width="100%" height="66" frameborder="0" scrolling="no" name="winch">윈글리쉬 데이타 불러오기</iframe>
					</dl>
				</div -->
                <a href="http://m.hrd.incheon.go.kr/index.do?mode=index" target="_blank"><img src="/images/qrbarcode.jpg" alt="인재개발원 모바일 QR바코드" width="130" height="130"/></a>
            </div>
           <div id="photo_area" style="display:none;">
				<dl>
				<%=photoListHtml%>
				</dl>
            </div>
            
          </div>
			  <div class="wrap_right">
			  <!-- 퀵메뉴 -->
			  	<div id="quick_menu">
                    <p><img src="../images/common/quick_title.gif" alt="메뉴 바로가기"></p>
                    <ul>
                        <li><a href='javascript:popWin("/homepage/studyhelp/learning_guide01.html","ddd","820","515","no","no")'><img src="../images/common/quick_menu1.gif" alt="."></a></li>
                        <li><a href="/homepage/infomation.do?mode=eduinfo2-3"><img src="../images/common/quick_menu2.gif" alt="."></a></li>
                        <li><a href="/homepage/support.do?mode=faqList"><img src="../images/common/quick_menu3.gif" alt="."></a></li>
                        <li><a href="javascript:popWin('http://152.99.42.151:81/','ccc','658','540','yes','yes')"><img src="../images/common/quick_menu4.gif" alt="."></a></li>
                        <li><a href="/homepage/introduce.do?mode=eduinfo7-7"><img src="../images/common/quick_menu5.gif" alt="."></a></li>
                    </ul>
                    <p><a href="#"><img src="../images/common/quick_bt.gif" alt="페이지 상단으로 이동"></a></p>
                </div>
				<script type="text/javascript">initMoving(document.getElementById("quick_menu"), 1, 1, 1)</script>
            <!-- 퀵메뉴 -->
            </div>
			</form>
        </div>
	<!-- //container -->
	
	</div>

    <hr />
     </div>
     
<script language="JavaScript">

// 스크롤러의 가로크기
var sliderwidth=600
// 스크롤러의 높이 (이미지의 높이와 맞추어 주세요)
var sliderheight=55
// 스크롤 속도 (클수록 빠릅니다 1-10)
var slidespeed=1
// 배경색상
slidebgcolor="#ffffff"

 

// 배열
var leftrightslide=new Array()
var finalslide=''
leftrightslide[0]='<a href = "http://www.nosmokeguide.or.kr" target="_blank"><img src="../images/main/b_s072.gif" alt="." border=0/></a>';
leftrightslide[1]='<a href = "http://www.ifez.go.kr/front.do" target="_blank"><img src="../images/main/b_s02.gif" alt="." border=0/></a>';
leftrightslide[2]='<a href = "http://traffic.incheon.go.kr/index.jsp" target="_blank"><img src="../images/main/b_s03.gif" alt="." border=0/></a>';
leftrightslide[3]='<a href = "http://consumer.incheon.go.kr/www/html/main.asp" target="_blank"><img src="../images/main/b_s04.gif" alt="." border=0/></a>';
leftrightslide[4]='<a href = "http://www.incheon2014ag.org" target="_blank"><img src="../images/main/b_s05.gif" alt="." border=0/></a>';
leftrightslide[5]='<a href = "http://etax.incheon.go.kr/" target="_blank"><img src="../images/main/b_s06.gif" alt="." border=0/></a>';
leftrightslide[6]='<a href = "http://www.juso.go.kr" target="_blank"><img src="../images/main/b_s07.gif" alt="." border=0/></a>';
leftrightslide[7]='<a href = "http://privacy.go.kr" target="_blank"><img src="../images/main/b_s071.gif" alt="." border=0/></a>';


// 밑에는 손대지 마삼
var copyspeed=slidespeed
leftrightslide='<nobr>'+leftrightslide.join(" ")+'</nobr>'
var iedom=document.all||document.getElementById
if (iedom)
document.write('<span id="temp" style="visibility:hidden;position:absolute;top:-100;left:-1000">'+leftrightslide+'</span>')
var actualwidth=''
var cross_slide, ns_slide

function fillup(){
if (iedom){
cross_slide=document.getElementById? document.getElementById("rollingBanner1") : document.all.rollingBanner1
cross_slide2=document.getElementById? document.getElementById("rollingBanner2") : document.all.rollingBanner2
cross_slide.innerHTML=cross_slide2.innerHTML=leftrightslide
actualwidth=document.all? cross_slide.offsetWidth : document.getElementById("temp").offsetWidth
cross_slide2.style.left=actualwidth+20
}
else if (document.layers){
ns_slide=document.ns_slidemenu.document.ns_slidemenu2
ns_slide2=document.ns_slidemenu.document.ns_slidemenu3
ns_slide.document.write(leftrightslide)
ns_slide.document.close()
actualwidth=ns_slide.document.width
ns_slide2.left=actualwidth+20
ns_slide2.document.write(leftrightslide)
ns_slide2.document.close()
}
lefttime=setInterval("slideleft()",30)
}
window.onload=fillup

function slideleft(){
if (iedom){
if (parseInt(cross_slide.style.left)>(actualwidth*(-1)+8))
cross_slide.style.left=parseInt(cross_slide.style.left)-copyspeed
else
cross_slide.style.left=parseInt(cross_slide2.style.left)+actualwidth+30

if (parseInt(cross_slide2.style.left)>(actualwidth*(-1)+8))
cross_slide2.style.left=parseInt(cross_slide2.style.left)-copyspeed
else
cross_slide2.style.left=parseInt(cross_slide.style.left)+actualwidth+30

}
else if (document.layers){
if (ns_slide.left>(actualwidth*(-1)+8))
ns_slide.left-=copyspeed
else
ns_slide.left=ns_slide2.left+actualwidth+30

if (ns_slide2.left>(actualwidth*(-1)+8))
ns_slide2.left-=copyspeed
else
ns_slide2.left=ns_slide.left+actualwidth+30
}
}

</script>
     
     <div id="bn" style="position:relative;width:600;height:55;overflow:hidden;">
     	<br><br>
     	<div class="bs" style="position:relative;width:600;height:55;background-color:#ffffff" onMouseover="copyspeed=0" onMouseout="copyspeed=slidespeed" >
     		<div id="rollingBanner1" style="position:absolute;left:0;top:0"></div>
            <div id="rollingBanner2" style="position:relative;left:-1000;top:0"></div>
     	</div>
        </div>
        
		
     
    <!-- footer -->
    <div id="footer">
      <div class="fo">
        <p class="logo">인천광역시 인재개발원</p>
        <ul>
          <li class="fir"><a href="/homepage/introduce.do?mode=eduinfo7-7">찾아오시는길(셔틀버스이용안내)</a></li>
          <li><a href="/homepage/index.do?mode=worktel">업무별연락처</a></li>
          <li><a href="/homepage/index.do?mode=policy" class="bold">개인정보처리방침</a></li>
          <li class="end"><a href="/homepage/index.do?mode=spam">이메일 무단수집거부</a></li>
          <li class="add" style="width:670px;">404-190 인천광역시 서구 심곡로 98 (심곡동 307) / 교육안내 032)440-7656, 사이버교육 안내 440-7673, 시설안내 440-7630 / FAX (032)440-8795<br />
            홈페이지에 게시된 이메일주소가 자동 수집되는 것을 거부하며, 위반시 정보통신 관련법령에 의해 처벌됩니다.<br />
            Copyright@2007 인천광역시인재개발원, All rights Reserved. 이 사이트의 콘텐츠를 무단 사용할 수 없습니다.</li>
        </ul>
      </div>
</div>

<!--// footer -->
<script language = "javascript">
  var TopMenu1 = new fnTopMenu1_Type1;
	TopMenu1.DivName = "TopMenuSub";
	TopMenu1.fnName = "TopMenu1";
	TopMenu1.DefaultMenu = 0;
	TopMenu1.DefaultSubMenu = 0;
	TopMenu1.MenuLength = 6;
	TopMenu1.Start();
  </script>
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
