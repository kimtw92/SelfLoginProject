<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>

<%

	LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");

	// �ʼ�, request ����Ÿ
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// �������� ����Ʈ
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
	
	// ���̹����� ����Ʈ
	DataMap cyberListMap = (DataMap)request.getAttribute("CYBER_LIST");
	cyberListMap.setNullToInitialize(true);
	
	
	StringBuffer cyberListHtml = new StringBuffer();
	
	cyberListHtml.append("<tr>");
	cyberListHtml.append("<td class=\"spc\" style=\"\" colspan=\"4\"></td>");
	cyberListHtml.append("</tr>");
	
	if(cyberListMap.keySize("rownum") > 0){		
		int sizeCheck = 0;
		for(int i=0; i < cyberListMap.keySize("rownum"); i++){
			
			//�ʰ� ���� ����ó��
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
		cyberListHtml.append("<tr height=\"167\"><td colspan=\"5\">������û���� ������ �����ϴ�.</td></tr>");
	}	
	
	// ���� ���� ����Ʈ
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
		nonCyberListHtml.append("<tr height=\"167\"><td colspan=\"5\">������û���� ������ �����ϴ�.</td></tr>");
	}	
	
	// �̴��� ���� ����Ʈ
	DataMap monthlistMap = (DataMap)request.getAttribute("MONTH_LIST");
	monthlistMap.setNullToInitialize(true);
	
	
	StringBuffer monthListHtml = new StringBuffer();
	
	// <li><span class="tit">[���̹�]</span><a href="">e-������ ������ ����</a><span class="data">2010-02-10~2010-02-10</span></li>
	
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
			monthListHtml.append("�ش���� ������ �����ϴ�.");
			monthListHtml.append("</li> \n");	
	}

	// �ְ����� ����Ʈ
	DataMap weeklistMap = (DataMap)request.getAttribute("WEEK_LIST");
	weeklistMap.setNullToInitialize(true);
	
	StringBuffer weekListHtml = new StringBuffer();
	if(weeklistMap.keySize("title") > 0){
		for(int i=0; i < weeklistMap.keySize("title"); i++){
			weekListHtml.append(weeklistMap.getString("mm",i)+"��" +weeklistMap.getString("dd",i)+"�� : "+weeklistMap.getString("title",i)+"  " );
		}
	}
	
	// ������� ����Ʈ
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

	// ���� ����Ʈ
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
	
	// �������ȹ ����Ʈ
	
	DataMap grseqPlanListMap = (DataMap)request.getAttribute("GRSEQ_PLAN_LIST");
	grseqPlanListMap.setNullToInitialize(true);	

	StringBuffer grseqPlanListHtml = new StringBuffer();	
	
	//<dt>������ ��������</dt>
	//<dd>�� �����Ʒð�ȹ</dd>
	//<dd>�� ���������ð� ����</dd>
	//<dd>�� ���̹����� ���ħ</dd>
	//<dd>�� ���̹������� �ȳ���</dd>
	
	if(grseqPlanListMap.keySize("rownum") > 0){
		grseqPlanListHtml.append("<dt>���� �ð�ǥ</dt>");
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
<title>���簳�߿�</title>
<link rel="STYLESHEET" type="text/css" href="../commonInc/css/style.css" />
<script type="text/javascript" language="javascript" src="../js/navigation.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/<%= skinDir %>/gnbMenu.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/NChecker.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/protoload.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/homeCategory.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/inno/InnoDS.js"></script>
<script type="text/javascript" language="javascript" src="http://gallerylad.com/lib/js/script.js"></script>
<!-- �߰� -->
<!-- <script type="text/javascript" src="/share/js/common.js"></script> -->
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<script type="text/javascript" language="javascript" src="/homepage_new/js/navigation.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/zoominout.js"></script>

<script language="javascript">
<!--

// ���� ����Ʈ �ڽ� ����
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
		//alert("���ձ����� ��û������ ��� ������ ��ȸ�Ͻ÷��� \n�� ������ more ��ư�� Ŭ���Ͽ� �ֽʽÿ�.");	
	} else if(i == 3) {
		content1.hide();
		content2.hide();
		content3.show();	
		//alert("���̹������� ��û������ ��� ������ ��ȸ�Ͻ÷��� \n�� ������ more ��ư�� Ŭ���Ͽ� �ֽʽÿ�.");	
	}
}

function existidcheck() {
	var url = "/homepage/index.do";
	url += "?mode=existid";
	pwinpop = popWin(url,"exidPop","420","350","yes","yes");	
}

function formHandler1(form) {
	// �˾�â�� �ɼ��� ������ �� �ֽ��ϴ�
	var windowprops = "height=500,width=500,location=no,"
	+ "scrollbars=no,menubars=no,toolbars=no,resizable=yes";

	var URL = form.select1.options[form.select1.selectedIndex].value;
	popup = window.open(URL);
	//form.target = "_blank";
	//form.action = URL;
	//form.submit();
}

function formHandler2(form) {
	// �˾�â�� �ɼ��� ������ �� �ֽ��ϴ�
	var windowprops = "height=500,width=500,location=no,"
	+ "scrollbars=no,menubars=no,toolbars=no,resizable=yes";

	var URL = form.select2.options[form.select2.selectedIndex].value;
	popup = window.open(URL);
	//form.target = "_blank";
	//form.action = URL;
	//form.submit();
}

function formHandler3(form) {
	// �˾�â�� �ɼ��� ������ �� �ֽ��ϴ�
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
						alert("����Ÿ�� �������� ���߽��ϴ�.");
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
			alert('�˻�� �Է��� �ֽʽÿ�.');
		}
	}else if(i=='2'){
		if($("keyword").value != "") {
			pars = escape(encodeURIComponent($("keyword").value));
			location.href='/homepage/introduce.do?mode=eduinfo7-3&select=name&keyword='+pars
		}else {
			alert('�˻�� �Է��� �ֽʽÿ�.');
		}
	}else if(i=='3'){
		if($("keyword").value != "") {
			pars = escape(encodeURIComponent($("keyword").value));
			location.href='/homepage/introduce.do?mode=eduinfo7-3&select=work&keyword='+pars
		}else {
			alert('�˻�� �Է��� �ֽʽÿ�.');
		}
	}else if(i=='4'){
		if($("keyword").value != "") {
			pars = escape(encodeURIComponent($("keyword").value));
			location.href='/homepage/support.do?mode=faqList&question='+pars
		}else {
			alert('�˻�� �Է��� �ֽʽÿ�.');
		}
	}
	
}

function selectNotice(i){
	if(i=='1') {
		alert('���������� Ű����� �Է��Ͽ� �ֽʽÿ�.\n ���� ���������� ���ԵǾ��ִ� Ű����� ������ �����ϴ�.\n ��) ����, ����, ����, ��ǻ��, �߰�, �ǹ� ��...');
	}
	if(i=='2'){
		alert('�̸��� Ű����� �Է��Ͽ� �ֽʽÿ�.\n ��) ȫ�浿�� �˻� �� ���\n �˻��� : ȫ, �浿, ȫ�浿');
	}
	if(i=='3'){
		alert('���������� Ű����� �Է��Ͽ� �ֽʽÿ�.\n ��) ����, �λ�, ���� ��...');
	}
	if(i=='4'){
		alert('������ Ű����� �Է��Ͽ� �ֽʽÿ�.\n ��) IE, ������, ������ ��...');
	}
}

function init(){
	// selectOpt(1);
}	



	 function getCookie(name) { //��Ű ��������
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
	//2010.01.04 - woni82 (�޽��� ����)
	//���̹� ���м��� �ٷ� ����
	function move_winglish() {
		open ("http://cyber.ybmsisa.com/incheon/","NewWindow",
		"left=0, top=0, toolbar=yes, location=yes, directories=no, status=yes, menubar=yes, scrollbars=yes, resizable=yes, width=1024, height=768");
		/*
		alert("�������� 2012�� 04�� 01�Ϻ����Դϴ�.");
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

<!-- 
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


<% if("B000000008065".equals(loginInfo.getSessNo()) || "A000000008411".equals(loginInfo.getSessNo())) { %>
function goGlobalContents() {
	if(<%=loginInfo.isLogin()%> == true) {
		var userid = "<%=loginInfo.getSessUserId()%>";
		var name = "<%=loginInfo.getSessName() %>";
		var paramname = escape(encodeURIComponent(name));

		if(userid == "" || userid == null) {
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
						alert(request.responseText);
					if(request.responseText.indexOf("FALSE") != -1) {
						memberCheck = true;
					}
				} catch(e) {
					alert(e.description);
				}
			},
			on401: function() {
				alert("������ ����Ǿ����ϴ�.");
				return;
			},
			onFailure : function(request) {
				alert(request.responseText);
				alert("���� �߻�");
				return;
			}
		});
		if(memberCheck) {
			document.globalForwardPage.target = "_blank";
			document.globalForwardPage.login_pass.value = escape(name);
			document.globalForwardPage.submit();
			return;
		}

		var popupObj = showModalDialog("/mypage/myclass.do?mode=memberUpdate", self, "dialogHeight=790px;dialogWidth=500px; scroll=yes; status=yes; help=no; center=yes");

		if(popupObj["close"] == "Y") {
			
			var hp1 = popupObj["hp1"];
			var hp2 = popupObj["hp2"];
			var hp3 = popupObj["hp3"];
			var email = popupObj["email"];
			var dept = escape(encodeURIComponent(popupObj["dept_name"]));
			var deptsub = escape(encodeURIComponent(popupObj["deptsub"]));
			var jiknm = escape(encodeURIComponent(popupObj["degreename"]));

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
							alert("��� ���� �����ڿ��� �������ּ���.");
						}
					} catch(e) {
						alert(e.description);
					}
				},
				on401: function() {
					alert("������ ����Ǿ����ϴ�.");
					return;
				},
				onFailure : function() {
					alert("���� �߻�");
					return;
				}
			});

			return;
		}
	} else {
		alert("�α����� ����ϽǼ� �ֽ��ϴ�.");
		return;
	}    
}
<% } else { %>
function goGlobalContents() {
	alert("4�� 01�� ���� �����Դϴ�.");
}
<% } %>
//-->
</script>
</head>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init();popup();" id="zoom" style = "overflow-x:hidden;">
	<div id="wrap">
			<!-- header-->
			<div id="header">
				<div class="header">
					<div class="toparea">
					<h1><a href="/">��õ������ ���簳�߿�</a></h1>
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
								<a href="https://twitter.com/share" class="twitter-share-button link_area4" data-url="https://twitter.com/cyberincheon" data-via="cyberincheon" data-lang="ko">Ʈ���ϱ�</a>
								<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="http://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
							</dd> 
							<dd><a href="javascript:yangZoom();" class="font_basic">�⺻</a></dd>
							<dd><a href="javascript:zoomIn();" class="font_up">����ũ��</a></dd>
							<dd><a href="javascript:zoomOut();" class="font_down">�����۰�</a></dd>
							<dd><a href="/homepage/index.do?mode=sitemap" class="sitemap">sitemap</a></dd>
							<dd><a href="/foreign/english/index.html" class="english">English</a></dd>
							<dd><a href="http://www.cyber.incheon.kr/" target="_blank" class="cyberedu">�ù� ���̹�����</a></dd>
						</dl>

						<div id="TopMenu">
					<div id="TopMenuSub">
						<ul>
							<li class="menu1">
								<a href="javascript:fnGoMenu(1,'main');"><img id = "menu1Btn" src="/homepage_new/images/main/menua_off.jpg" alt="����������" /></a>
								<div class="TopSubMenu">					
									<ul>
										<li class="first"><a href="#" ></a></li>
									</ul>
								</div>
							</li>
							<li class="menu2">
								<a href="javascript:fnGoMenu(2,'eduinfo2-1');"><img src="/homepage_new/images/main/menub_off.jpg" alt="��������" /></a>
								<div class="TopSubMenu">					
									<ul>
										<li class="first"><a href="javascript:fnGoMenu(2,'eduinfo2-1');" >�Ա��ȳ�</a></li>
                            			<li><a href="javascript:fnGoMenu(2,'eduinfo2-2');" >�����Ʒ�ü��</a></li>
                            			<li><a href="javascript:fnGoMenu(2,'eduinfo2-3');" >������������</a></li>
                            			<li><a href="javascript:fnGoMenu(3,'eduinfo3-1');" >���ձ���</a></li>
                            			<li><a href="javascript:fnGoMenu(3,'eduinfo3-4');" >���̹�����</a></li>
                            			<li><a href="javascript:fnGoMenu(5,'opencourse');" >��������</a></li>
									</ul>
								</div>
							</li>
							<li class="menu3">
								<a href="javascript:fnGoMenu(4,'attendList');"><img src="/homepage_new/images/main/menuc_off.jpg" alt="������û" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="javascript:fnGoMenu(4,'attendList');" >������û �� ���</a></li>
									</ul>
								</div>
							</li>
							<li class="menu4">
								<a href="javascript:fnGoMenu(5,'requestList')"><img src="/homepage_new/images/main/menud_off.jpg" alt="��������" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="javascript:fnGoMenu(5,'requestList');">������ϱ�</a></li>
										<li><a href="javascript:fnGoMenu(5,'webzine');">���䰶����</a></li>
										<li><a href="javascript:fnGoMenu(6,'eduinfo6-1');">E-book</a></li>
									</ul>
								</div>
							</li>
							<li class="menu5">
								<a href="/homepage/renewal.do?mode=eduinfo8-1"><img src="/homepage_new/images/main/menue_off.jpg" alt="��������" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="/homepage/renewal.do?mode=eduinfo8-1" title="�оߺ������ȳ�">�оߺ������ȳ�</a></li>
                            			<li><a href="javascript:fnGoMenu(5,'faqList');" >�����ϴ�����</a></li>
                            			<li><a href="javascript:fnGoMenu(5,'educationDataList');" >�ڷ��</a></li>
                            			<li><a href="/homepage/renewal.do?mode=eduinfotel" >������ �ȳ���ȭ</a></li>
                            			<li><a href="http://152.99.42.138/" target = "_blank" >e-������</a></li>
                            			<li><a href="/homepage/renewal.do?mode=readingList" >��������������</a></li>
                            			<li><a href="/homepage/renewal.do?mode=courseTimetable" >�����ð�ǥ</a></li>
                            			<li><a href="javascript:fnGoMenu(7,'eduinfo7-4');" >�Ĵ�ǥ</a></li>
									</ul>
								</div>
							</li>
							<li class="menu6">
								<a href="javascript:fnGoMenu('7','eduinfo7-1');"><img src="/homepage_new/images/main/menuf_off.jpg" alt="������Ұ�" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="javascript:fnGoMenu('7','eduinfo7-1');" >�λ縻</a></li>
                            			<li><a href="/homepage/renewal.do?mode=introduction02" >���� �� ��ǥ</a></li>
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-8');" >�ȳ�������</a></li>
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-2');" >����</a></li>
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-3');" >���� �� ����</a></li>
                            			<li><a href="javascript:fnGoMenu('5','noticeList');" >����� �˸�</a></li>
                            			<li><a href="javascript:fnGoMenu('7','lawsList');" >����/����</a></li>
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-6');" >�ü���Ȳ</a></li>
                            			<!-- <li><a href="javascript:fnGoMenu('7','eduinfo7-7');" >ã�ƿ��ô±�</a></li> -->
									</ul>
								</div>
							</li>
						</ul>
					</div>
			</div>
			
				</div>
			</div>
			<div class="visual"><img src="/images/main/main_view.jpg" alt="���ѹα��� ���� �������� ��õ" width="990" height="252" /></div>
			<!-- ���� -->
					<div class="box_layer">
					<dl>
					<dd><div class="schedule"><marquee scrolldelay="150"><%=weekListHtml %></marquee></div></dd>
					</dl>
					</div>

					<!-- ž �ֱٰԽñ� -->
					<div class="box_layer2">
						<dl class="box1">
							<dt>������ ��������</dt>
							<dd><a href="/down/1_1.pdf">�����Ʒð�ȹ</a></dd>
							<dd><a href="/down/02.hwp">���������ð� ����</a></dd>
							<dd><a href="/down/03.hwp">���̹����� ���ħ</a></dd>
							<dd><a href="/down/04.hwp">���̹������� �ȳ���</a></dd>
						</dl>
						<dl class="box2">
							<%=grseqPlanListHtml%>
						</dl>
					</div>
					<!-- //ž �ֱٰԽñ� -->
                    <div class="box_layer3">
					<dl>
					<dd><select id="search" name="search" style="width:85px;height:20px;" onChange="selectNotice(value);">
                        <option value="1" selected>��������</option>
                        <option value="2">�����̸�</option>
                        <option value="3" >��������</option>
                        <option value="4" >������ϱ�</option>
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
			<!--�ʼ�-->
			<input type="hidden" name="depcode" value="Incheon01">			<!-- ������. depcode �� -->
			<input type="hidden" name="depkey" value="ekqkcs3ks0ldxjqkw1">	 <!-- ������. depkey �� -->

			<input type="hidden" name="name"  value="<%=loginInfo.getSessName() %>">			<!-- �̸� -->
			<input type="hidden" name="userkey1" value="<%=loginInfo.getSessUserId() %>">			<!-- User Number -->
			<!--�ʼ�-->
		</form>

		<form id="globalForwardPage" name="globalForwardPage" target='globalForward' method="POST" action="http://b2b.global21.co.kr/incheon/sso_processExe.asp">
			<input type="hidden" id="login_id" name="login_id" value="<%=loginInfo.getSessUserId() %>" />
			<input type="hidden" id="login_pass" name="login_pass"/>
		</form>
		<iframe name="globalForward" id="globalForward" frameborder=0 style='display:none;'></iframe>

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
                <!-- a href="javascript:move_winglish();"><img src="../images/main/ich_baner_03.jpg" alt="���̹� ���м���"/></a -->
                <a href="javascript:goGlobalContents();"><img src="../images/main/ich_baner_03.jpg" alt="���̹� ���м���"/></a>
                <a href="javascript:move_cyber_mobile();"><img src="../images/main/ich_baner_08.jpg" alt="���̹��������� �����"/></a>
                <a href="javascript:move_cyber();"><img src="../images/main/ich_baner_06.jpg" alt="���̹��������� PC"/></a>
            </div>
		
			<div class="ptab">
			  <ul>
				<li id="li_tabmenu1_atea"><img id="tabmenu1" src="../images/main/tab01_on.gif" alt="�����ȳ�" style = "cursor:hand" onClick="tabmenu(1, 'tabmenu1');"/></li>
				<li id="li_tabmenu2_atea"><img id="tabmenu2" src="../images/main/tab02.gif" alt="�ü��ȳ�" style = "cursor:hand" onClick="tabmenu(1, 'tabmenu2');"/></li>
			  </ul>
			</div>
			<div id="info_1">
				<img src="../images/main/tab01_11.gif" alt="�����ȳ� ��ȭ�ȳ�"/>
			</div>
			<div id="info_2" style="display:none;">
				<img id="info_2" src="../images/main/tab01_12.gif" alt="�ü��ȳ�"/>
			</div>
          </div>
          <form id="pform" name="pform" method="post">
          <div id="content">
            <!-- Notice Start -->
            <div id="notice">
              <div id="tablist_area">
				  <span><img id="tabmenu3" src="../images/main/notice_tab1_on.gif" alt="��������" style = "cursor:hand" onClick="tabmenu(2, 'tabmenu3');"/></span>
					<span><img id="tabmenu4" src="../images/main/notice_tab2.gif" alt="���ձ���" style = "cursor:hand" onClick="tabmenu(2, 'tabmenu4');"/></span>
					<span><img id="tabmenu5" src="../images/main/notice_tab3.gif" alt="���̹�����" style = "cursor:hand" onClick="tabmenu(2, 'tabmenu5');"/></span>
			  </div>
              <div id="tab1c1_area">
                <ul>
					<%=sbListHtml%>
                </ul>
              </div>
			  <div id="more_1"><a href="/homepage/support.do?mode=noticeList"><img src="../images/main/more.gif" alt="������"></a></div>

              <div id="tab1c2_area" style="display:none;" class="board_tab board_scroll">
				<table summary="���ձ��� ������ ��û�Ⱓ, �ο�, �̼��ð�, �����ð� �Դϴ�.">
					<caption>���ձ��� ����</caption>
					<colgroup><col /><col width="91" /><col width="35" /><col width="53" /><col width="77" /></colgroup>
					<thead>
						<tr>
							<th><p><img src="/images/main/board_tit1.gif" alt="������" /></p></th>
							<th><p><img src="/images/main/board_tit2.gif" alt="��û�Ⱓ" /></p></th>
							<th><p><img src="/images/main/board_tit3.gif" alt="�ο�" /></p></th>
							<th><p><img src="/images/main/board_tit4.gif" alt="�̼��ð�" /></p></th>
							<th><p class="bgn"><img src="/images/main/board_tit5.gif" alt="�����Ⱓ" /></p></th>
						</tr>
					</thead>
					<tbody>
						<%= nonCyberListHtml %>
					</tbody>
				</table>
              </div>
			  <div id="more_2" style="display:none;"><a href="/homepage/infomation.do?mode=eduinfo2-3"><img src="../images/main/more.gif" alt="������"></a></div>

              <div id="tab1c3_area" style="display:none;" class="board_tab board_scroll">
				<table summary="���ձ��� ������ ��û�Ⱓ, �ο�, �̼��ð�, �����ð� �Դϴ�.">
					<caption>���ձ��� ����</caption>
					<colgroup><col /><col width="91" /><col width="35" /><col width="53" /><col width="77" /></colgroup>
					<thead>
						<tr>
							<th><p><img src="/images/main/board_tit1.gif" alt="������" /></p></th>
							<th><p><img src="/images/main/board_tit2.gif" alt="��û�Ⱓ" /></p></th>
							<th><p><img src="/images/main/board_tit3.gif" alt="�ο�" /></p></th>
							<th><p><img src="/images/main/board_tit4.gif" alt="�̼��ð�" /></p></th>
							<th><p class="bgn"><img src="/images/main/board_tit5.gif" alt="�����Ⱓ" /></p></th>
						</tr>
					</thead>
					<tbody>
						<%= cyberListHtml %>
					</tbody>
				</table>
              </div>
			  <div id="more_3" style="display:none;"><a href="/homepage/course.do?mode=eduinfo3-3"><img src="../images/main/more.gif" alt="������"></a></div>
            </div>
            <!-- Notice End -->
            
            <!-- month -->
            <div class="month_tab">
                <div class="month01"><span class="title_m">�̴��� �н�</span><span id="month" class="tab1">
<%
	int month = Integer.parseInt(requestMap.getString("month"));
%>
					<a id="num_1" href="javascript:showMonthTab('1');" <%if(month==1){%>class="on"<%} %>>1��</a>
					<a id="num_2" href="javascript:showMonthTab('2');" <%if(month==2){%>class="on"<%} %>>2��</a>
					<a id="num_3" href="javascript:showMonthTab('3');" <%if(month==3){%>class="on"<%} %>>3��</a>
					<a id="num_4" href="javascript:showMonthTab('4');" <%if(month==4){%>class="on"<%} %>>4��</a>
					<a id="num_5" href="javascript:showMonthTab('5');" <%if(month==5){%>class="on"<%} %>>5��</a>
					<a id="num_6" href="javascript:showMonthTab('6');" <%if(month==6){%>class="on"<%} %>>6��</a>
					<a id="num_7" href="javascript:showMonthTab('7');" <%if(month==7){%>class="on"<%} %>>7��</a>
					<a id="num_8" href="javascript:showMonthTab('8');" <%if(month==8){%>class="on"<%} %>>8��</a>
					<a id="num_9" href="javascript:showMonthTab('9');" <%if(month==9){%>class="on"<%} %>>9��</a>
					<a id="num_10" href="javascript:showMonthTab('10');" <%if(month==10){%>class="on"<%} %>>10��</a>
					<a id="num_11" href="javascript:showMonthTab('11');" <%if(month==11){%>class="on"<%} %>>11��</a>
					<a id="num_12" href="javascript:showMonthTab('12');" <%if(month==12){%>class="on"<%} %>>12��</a>			
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
					<li><img src="../images/main/popupzone.gif" alt="�˾���"/></li>
					<li><img id = "popupLeft" style = "cursor:hand" src="/homepage_new/images/main/arrow01.gif" alt="���� Ŭ����ư"/></li>
					<li><img id = "popupStart" style = "cursor:hand" src="/homepage_new/images/main/arrow04.gif" alt="������ư"/></li>
					<li><img id = "popupRight" style = "cursor:hand" src="/homepage_new/images/main/arrow03.gif" alt="������ Ŭ����ư"/></li>
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
                

            <div class="banner1"><a href="javascript:goLogodi();"><img src="../images/main/ban05.gif" alt="���� ���� �ý���"/></a></div>
			<div class="banner2"><a href="javascript:fnGoMenu('7','eduinfo7-8');"><img src="../images/main/ban06.gif" alt="�ȳ�������"/></a></div>
            
            <div class="ttab">
              <ul>
                <li><img id="tabmenu6" style = "cursor:hand" src="../images/main/ttab01_on.gif" alt="������ �Ѹ���" onClick="tabmenu(3, 'tabmenu6');"/></li -->
                <li><img id="tabmenu7" style = "cursor:hand" src="../images/main/ttab02.gif" alt="���䰶����" onClick="tabmenu(3, 'tabmenu7');"/></li>
                <!-- li><img id="tabmenu7" style = "cursor:hand" src="../images/main/ttab02.gif" alt="���䰶����"/></li -->
              </ul>
            </div>
            <div id="winglish_area">
				<!-- div id="winglish_area01">
					<dl>
						<iframe src="http://www.winglish.com/study/openfree/main/incheon_main_en.asp" width="100%" height="66" frameborder="0" scrolling="no" name="winen">���۸��� ����Ÿ �ҷ�����</iframe>
					</dl>
				</div>
				<div id="winglish_area02">
					<dl>
						<iframe src="http://www.winglish.com/study/openfree/main/incheon_main_ch.asp" width="100%" height="66" frameborder="0" scrolling="no" name="winch">���۸��� ����Ÿ �ҷ�����</iframe>
					</dl>
				</div -->
                <a href="http://m.hrd.incheon.go.kr/index.do?mode=index" target="_blank"><img src="/images/qrbarcode.jpg" alt="���簳�߿� ����� QR���ڵ�" width="130" height="130"/></a>
            </div>
           <div id="photo_area" style="display:none;">
				<dl>
				<%=photoListHtml%>
				</dl>
            </div>
            
          </div>
			  <div class="wrap_right">
			  <!-- ���޴� -->
			  	<div id="quick_menu">
                    <p><img src="../images/common/quick_title.gif" alt="�޴� �ٷΰ���"></p>
                    <ul>
                        <li><a href='javascript:popWin("/homepage/studyhelp/learning_guide01.html","ddd","820","515","no","no")'><img src="../images/common/quick_menu1.gif" alt="."></a></li>
                        <li><a href="/homepage/infomation.do?mode=eduinfo2-3"><img src="../images/common/quick_menu2.gif" alt="."></a></li>
                        <li><a href="/homepage/support.do?mode=faqList"><img src="../images/common/quick_menu3.gif" alt="."></a></li>
                        <li><a href="javascript:popWin('http://www.hc119.com/hc4_user.asp','ccc','658','540','yes','yes')"><img src="../images/common/quick_menu4.gif" alt="."></a></li>
                        <li><a href="/homepage/introduce.do?mode=eduinfo7-7"><img src="../images/common/quick_menu5.gif" alt="."></a></li>
                    </ul>
                    <p><a href="#"><img src="../images/common/quick_bt.gif" alt="������ ������� �̵�"></a></p>
                </div>
				<script type="text/javascript">initMoving(document.getElementById("quick_menu"), 1, 1, 1)</script>
            <!-- ���޴� -->
            </div>
			</form>
        </div>
	<!-- //container -->
	
	</div>

    <hr />
     </div>
     
<script language="JavaScript">

// ��ũ�ѷ��� ����ũ��
var sliderwidth=600
// ��ũ�ѷ��� ���� (�̹����� ���̿� ���߾� �ּ���)
var sliderheight=55
// ��ũ�� �ӵ� (Ŭ���� �����ϴ� 1-10)
var slidespeed=1
// ������
slidebgcolor="#ffffff"

 

// �迭
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


// �ؿ��� �մ��� ����
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
        <p class="logo">��õ������ ���簳�߿�</p>
        <ul>
          <li class="fir"><a href="/homepage/introduce.do?mode=eduinfo7-7">ã�ƿ��ô±�(��Ʋ�����̿�ȳ�)</a></li>
          <li><a href="/homepage/index.do?mode=worktel">����������ó</a></li>
          <li><a href="/homepage/index.do?mode=policy" class="bold">��������ó����ħ</a></li>
          <li class="end"><a href="/homepage/index.do?mode=spam">�̸��� ���ܼ����ź�</a></li>
          <li class="add" style="width:670px;">22711 ��õ������ ���� �ɰ�� 98 (�ɰ 307) / �����ȳ� 032)440-7656, ���̹����� �ȳ� 440-7673, �ü��ȳ� 440-7630 / FAX (032)440-8795<br />
            Ȩ�������� �Խõ� �̸����ּҰ� �ڵ� �����Ǵ� ���� �ź��ϸ�, ���ݽ� ������� ���ù��ɿ� ���� ó���˴ϴ�.<br />
            Copyright@2007 ��õ���������簳�߿�, All rights Reserved. �� ����Ʈ�� �������� ���� ����� �� �����ϴ�.</li>
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
