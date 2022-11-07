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
	
	
	// 공지사항 리스트
	/* DataMap gradurateMap = (DataMap)request.getAttribute("GRADURATE_LIST");
	gradurateMap.setNullToInitialize(true); */
	
	/* String m[] = new String[36];

	if(gradurateMap.keySize("dept1") > 0){		
		for(int i=0; i < gradurateMap.keySize("dept1"); i++){
			m[0] = gradurateMap.getString("dept1", i);
			m[1] = gradurateMap.getString("succSum1", i);
			m[2] = gradurateMap.getString("rate1", i);
			
			m[3] = gradurateMap.getString("dept2", i);
			m[4] = gradurateMap.getString("succSum2", i);
			m[5] = gradurateMap.getString("rate2", i);
			
			m[6] = gradurateMap.getString("dept3", i);
			m[7] = gradurateMap.getString("succSum3", i);
			m[8] = gradurateMap.getString("rate3", i);
			
			m[9] = gradurateMap.getString("dept4", i);
			m[10] = gradurateMap.getString("succSum4", i);
			m[11] = gradurateMap.getString("rate4", i);
			
			m[12] = gradurateMap.getString("dept5", i);
			m[13] = gradurateMap.getString("succSum5", i);
			m[14] = gradurateMap.getString("rate5", i);
			
			m[15] = gradurateMap.getString("dept6", i);
			m[16] = gradurateMap.getString("succSum6", i);
			m[17] = gradurateMap.getString("rate6", i);
			
			m[18] = gradurateMap.getString("dept7", i);
			m[19] = gradurateMap.getString("succSum7", i);
			m[20] = gradurateMap.getString("rate7", i);
			
			m[21] = gradurateMap.getString("dept8", i);
			m[22] = gradurateMap.getString("succSum8", i);
			m[23] = gradurateMap.getString("rate8", i);
			
			m[24] = gradurateMap.getString("dept9", i);
			m[25] = gradurateMap.getString("succSum9", i);
			m[26] = gradurateMap.getString("rate9", i);
			
			m[27] = gradurateMap.getString("dept10", i);
			m[28] = gradurateMap.getString("succSum10", i);
			m[29] = gradurateMap.getString("rate10", i);
			
			m[30] = gradurateMap.getString("dept11", i);
			m[31] = gradurateMap.getString("succSum11", i);
			m[32] = gradurateMap.getString("rate11", i);
			
			m[33] = gradurateMap.getString("dept12", i);
			m[34] = gradurateMap.getString("succSum12", i);
			m[35] = gradurateMap.getString("rate12", i);
			
			   
		}
	} */
		
	
	
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
	
	// <li><span class="tit">[사이버]</span><a href="">e-공무원 노사관계 과정</a><span class="data">2010-02-10~2010-02-10</span></li>
	
	if(monthlistMap.keySize("grcodeniknm") > 0){		
		for(int i=0; i < monthlistMap.keySize("grcodeniknm"); i++){
			//if( i+1 != monthlistMap.keySize("grcodeniknm") ) {
				//monthListHtml.append("<li>");					
			//}else {
			//	monthListHtml.append("<li class=\"end\">");
			//}
			
			String grcode = monthlistMap.getString("grcode", i); 
			String gubun = monthlistMap.getString("gubun", i);
			String checklist = "";
			
			if(checklist.indexOf(grcode) != -1) {
				if("10G0000091".equals(grcode))  {
					gubun = "기본";
				} else {
					gubun = "혼합";
				}
			}

			if("전문".equals(gubun)) {
				gubun = "집합";
			}
			
			String title = monthlistMap.getString("grcodeniknm", i);
			String subStrTitle = title;
			if(title.length() >= 25 )	subStrTitle = title.substring(0, 24) + "...";
			
			monthListHtml.append("<li>");
			monthListHtml.append("	[" + "화상" + "] <a href=\"javascript:popWin('/homepage/course.do?mode=courseinfopopup&amp;grcode="+monthlistMap.getString("grcode", i)+"&amp;grseq="+monthlistMap.getString("grseq", i)+"','aaa','603','680','yes','yes')\" title=\""+title+"\">"+ subStrTitle +"</a><span>" + monthlistMap.getString("started", i) + "~"+monthlistMap.getString("enddate", i) +"</span>");
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
	
	// 우수강의 리스트
	/*
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
		*/
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
<!-- <meta http-equiv="X-UA-Compatible" content="IE=7" /> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<meta name="autocomplete" content="off" />
<title>인천광역시 인재개발원</title>
<!-- <link rel="STYLESHEET" type="text/css" href="../commonInc/css/style.css" /> -->
<link rel="STYLESHEET" type="text/css" href="/2017/css/common3.css" />
<%-- <script type="text/javascript" language="javascript" src="/commonInc/js/<%= skinDir %>/gnbMenu.js"></script> --%>
<!-- <script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script> -->
<!-- <script type="text/javascript" language="javascript" src="/commonInc/js/NChecker.js"></script> -->
<!-- <script type="text/javascript" language="javascript" src="/commonInc/js/protoload.js"></script> -->
<script type="text/javascript" language="javascript" src="/commonInc/js/homeCategory.js"></script>
<!-- <script type="text/javascript" language="javascript" src="/commonInc/inno/InnoDS.js"></script> -->
 <script type="text/javascript" src="/2017/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/2017js/jquery-ui.min.js"></script>
<!-- 추가 -->
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<script type="text/javascript" language="javascript" src="/homepage_new/js/navigation.js"></script>
<!-- <script type="text/javascript" language="javascript" src="/commonInc/js/zoominout.js"></script> -->

<!-- 키보드 보안 솔루션 start-->

<!-- <script type="text/javascript" src="https://supdate.nprotect.net/nprotect2007/keycrypt/hrdincheon/npkfx.js"></script> -->

<%-- <%/* --%>
<script type="text/javascript" src="/pluginfree/js/nosquery-1.11.3.js"></script>
<!--고객사에서 사용하는 jquery 버전이 1.7.4이상일 경우 해당경로로 변경하여 사용 가능 -->
<script type="text/javascript" src="/pluginfree/jsp/nppfs.script-1.6.0.jsp"></script>
<script type="text/javascript" src="/pluginfree/js/nppfs-1.6.0.js"></script>

<script type="text/javascript">
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
<%-- */%> --%>


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
				$('#mex').empty();
				$('#mex').append(result);
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
				window.open("/homepage/index.do?mode=usercreateid","createId","scrollbars=no,resizable=no,width=460,height=300").focus();
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
		window.open("/homepage/index.do?mode=eduInfo","eduInfo","scrollbars=no,resizable=no,width=710,height=600").focus();
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

</style>

</head>
<body>
<div id="icWrapper">

<div id="headerFrame">
			<!-- topmenu -->
			<div id="topmenuDiv">
				<h1 class="logo"><a href="/"><img src="/2017/images/logo.gif" alt="LOGO"/></a></h1>
					<ul class="topu">
						<li><a href="/"><img src="/2017/images/top_util01.gif" alt="home" /></a></li>
						<!-- <li><a href="#"><img src="/2017/images/top_02.gif" alt="sitemap" /></a></li> -->
						<li class="none"><a href="/homepage/index.do?mode=sitemap"><img src="/2017/images/top_util02.gif" alt="sitemap" /></a></li>
					</ul>
			 </div>
			<!-- topmenu End -->


<!-- GNB -->
			<div id="gnbFrame" class="gnbFrame">
				<ul class="topNavi">
					<li class="navi01">
						<a class="d1" href="javascript:fnGoMenu('1','main');"><img src="/2017/images/img_gnb01_off.png" alt="마이페이지" /> </a>
						<div style="display: none;" class="depth02 dpn">
							<div class="depth_wrap">
							<p class="tit"><img src="/2017/images/gnb_lt_01.gif" alt="마이페이지" /></p>
							<dl>
								<dt><a href="javascript:fnGoMenu('1','main');">나의강의실</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu('1','attendList');">교육신청 및 취소</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu('1','completionList');">수료내역</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu('1','myquestion');">개인정보</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu('1','memberout');">회원탈퇴</a></dt>
							
							</dl>
							<p class="btn_gnbclose btn"><a href="#"><img src="/2017/images/btn_gnbclose.gif" alt="닫기" /></a></p>
							</div>
						</div>
					</li>
					<li class="navi02">
					  <a class="d1" href="javascript:fnGoMenu(2,'eduinfo2-1');"><img src="/2017/images/img_gnb02_off.png" alt="교육과정" /></a>
						<div style="display: none;" class="depth02 dpn">
						 <div class="depth_wrap">
							<p class="tit"><img src="/2017/images/gnb_lt_02.gif" alt="교육과정" /></p>
							<dl>
								<dt><a href="javascript:fnGoMenu(2,'eduinfo2-1');">입교안내</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu(2,'eduinfo2-2');">교육훈련체계</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu(2,'eduinfo2-3');">연간교육일정</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu(3,'eduinfo3-1');">집합교육</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu(3,'eduinfo3-4');">사이버교육</a></dt>
							</dl>
							<p class="btn_gnbclose btn"><a href="#"><img src="/2017/images/btn_gnbclose.gif" alt="닫기" /></a></p>
							</div>
						</div>
					</li>
					<li class="navi03">
						<a class="d1" href="javascript:fnGoMenu(4,'attendList');"> <img src="/2017/images/img_gnb03_off.png" alt="교육신청" /> </a>
						<div style="display: none;" class="depth02 dpn">
						<div class="depth_wrap">
							<p class="tit"><img src="/2017/images/gnb_lt_03.gif" alt="교육신청" /></p>
							<dl>
								<dt><a href="javascript:fnGoMenu(4,'attendList');">집합교육 신청 및 취소</a></dt>																
							</dl>
							<dl>
								<dt><a href="javascript:popupEduInfo();">사이버외국어교육</a></dt>
							</dl>
							<dl>
								<dt><a href="http://incheon.nhi.go.kr/">사이버전문교육</a></dt>		
								<!-- <dt><a href="/statisMgr/stats.do?mode=2016">수료현황 및 추천과정</a></dt> -->
							</dl>
							<p class="btn_gnbclose btn"><a href="#"><img src="/2017/images/btn_gnbclose.gif" alt="닫기" /></a></p>
							</div>
						</div>
					</li>
					<li class="navi04">
						<a class="d1" href="javascript:fnGoMenu(5,'requestList');"> <img src="/2017/images/img_gnb04_off.png" alt="참여공간" /></a>
						<div style="display: none;" class="depth02 dpn">
						<div class="depth_wrap">
							<p class="tit"><img src="/2017/images/gnb_lt_04.gif" alt="참여공간" /></p>
							<dl>
								<dt><a href="javascript:fnGoMenu(5,'requestList');">묻고답하기</a></dt>
							</dl>
							<dl>
								<!-- <dt><a href="javascript:fnGoMenu(5,'webzine');">포토갤러리-</a></dt> -->
								<dt><a href="javascript:fnGoMenu('5','epilogueList');">수강후기</a></dt>
							</dl>
<!-- 							<dl> -->
<!-- 								<dt><a href="javascript:fnGoMenu(6,'eduinfo6-1');">E-Book</a></dt> -->
<!-- 							</dl> -->
<!-- 							<dl> -->
<!-- 								<dt><a href="#">수강후기</a></dt> -->
<!-- 							</dl> -->
							<!-- <dl>
								<dt><a href="#">교육신청5</a></dt>
							</dl> -->
							<p class="btn_gnbclose btn"><a href="#"><img src="/2017/images/btn_gnbclose.gif" alt="닫기" /></a></p>
							</div>
						</div>
					</li>
					<li class="navi05">
						<a class="d1" href="/homepage/renewal.do?mode=eduinfo8-1"> <img src="/2017/images/img_gnb05_off.png" alt="교육지원" /> </a>
						<div style="display: none;" class="depth02 dpn">
						<div class="depth_wrap">
							<p class="tit"><img src="/2017/images/gnb_lt_05.gif" alt="교육지원" /></p>
							<dl>
								<dt><a href="/homepage/renewal.do?mode=eduinfo8-1">분야별 교육안내</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu(5,'faqList');">자주하는질문</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu(5,'educationDataList');">자료실</a></dt>
							</dl>
							<dl>
								<dt><a href="/homepage/renewal.do?mode=eduinfotel">과정별 안내전화</a></dt>
							</dl>
							<dl>
								<!-- <dt><a href="http://152.99.42.138/">e-도서관 - -</a></dt> -->
							</dl>
							<dl>
								<dt><a href="/homepage/renewal.do?mode=readingList">교육생숙지사항</a></dt>
							</dl>
							<dl>
								<!-- <dt><a href="/homepage/renewal.do?mode=courseTimetable">과정시간표</a></dt> -->
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu(7,'eduinfo7-4');">식단표</a></dt>
							</dl>
							<p class="btn_gnbclose btn"><a href="#"><img src="/2017/images/btn_gnbclose.gif" alt="닫기" /></a></p>
						</div>
					</div>
					</li>

						<li class="navi06">
						<a class="d1" href="javascript:fnGoMenu('7','eduinfo7-1');"> <img src="/2017/images/img_gnb06_off.png" alt="인재개발원소개" /> </a>
						<div style="display: none;" class="depth02 dpn">
						<div class="depth_wrap">
							<p class="tit"><img src="/2017/images/gnb_lt_06.gif" alt="인재개발원소개" /></p>
							<dl>
								<dt><a href="javascript:fnGoMenu('7','eduinfo7-1');">인사말</a></dt>
							</dl>
							<dl>
								<dt><a href="/homepage/renewal.do?mode=introduction02">비전 및 목표</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu('7','eduinfo7-2');">연혁</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu('7','eduinfo7-3');">조직 및 업무</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu('5','noticeList');">인재개발원 알림</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu('7','lawsList');">법률/조례</a></dt>
							</dl>
							<dl>
								<dt><a href="javascript:fnGoMenu('7','eduinfo7-6');">시설현황</a></dt>
							</dl>
							<p class="btn_gnbclose btn"><a href="#"><img src="/2017/images/btn_gnbclose.gif" alt="닫기" /></a></p>
							</div>
						</div>
					</li>

					<li class="navi07">
						<a class="d1" href="javascript:fnGoMenu('5','epilogueList');"><img src="/2017/images/img_gnb07_off.png" alt="수강후기" /></a>
						<div style="display: none;" class="depth02 dpn">
						<div class="depth_wrap">
							<p class="tit"><img src="/2017/images/gnb_lt_07.gif" alt="수강후기" /></p>
							<dl>
								<dt><a href="javascript:fnGoMenu('5','epilogueList');">수강후기</a></dt>
							</dl>
							<p class="btn_gnbclose2 btn"><a href="#"><img src="/2017/images/btn_gnbclose.gif" alt="닫기" /></a></p>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<!-- gnb End -->
			 <script type="text/javascript" src="/2017/js/ixGnb2.js"></script>
</div>
	<!-- header End -->


		<form name="frmSSO" action="http://www.dongabiz.com/ASP/Incheon/SSOlogin.php" method="post" target="_blank">
			<div class="nppfs-elements" style="display:none;"></div>
			<div class="nppfs-keypad-div" style="display:none;"></div>
		
			<!--필수-->
			<input type="hidden" name="depcode" value="Incheon01">			<!-- 고정값. depcode 값 -->
			<input type="hidden" name="depkey" value="ekqkcs3ks0ldxjqkw1">	 <!-- 고정값. depkey 값 -->

			<input type="hidden" name="name"  value="<%=loginInfo.getSessName() %>">			<!-- 이름 -->
			<input type="hidden" name="userkey1" value="<%=loginInfo.getSessUserId() %>">			<!-- User Number -->
			<!--필수-->
		</form>

		<form id="globalForwardPage" name="globalForwardPage" target='globalForward' method="POST" action="http://b2b.global21.co.kr/incheon/sso_processExe.asp">
			<div class="nppfs-elements" style="display:none;"></div>
			<div class="nppfs-keypad-div" style="display:none;"></div>
			<input type="hidden" id="login_id" name="login_id" value="<%=loginInfo.getSessUserId() %>" />
			<input type="hidden" id="login_pass" name="login_pass"/>
		</form>
		<iframe name="globalForward" id="globalForward" frameborder=0 style='display:none;'></iframe>

		<form id="forwardPage" name="forwardPage" method="post" action="">
			<div class="nppfs-elements" style="display:none;"></div>
			<div class="nppfs-keypad-div" style="display:none;"></div>
			<input type="hidden" name="kvt" value="" />
			<input type="hidden" name="anm" value="" />
			<input type="hidden" name="pkey" value="" />
		</form>
	

	<div class="mainFrame" style=""><!-- MainFrame start -->
	
		<div style="" class="mvFrame">
		
				<ul class="mvf">
						<li>
								<ul>
										<li><a href="javascript:popupEduInfo();"><img src="/2017/images/m_md_bn1.jpg" alt="공무원 사이버외국어 교육센터"></a></li>
										<!-- <li><a href="javascript:popupBasicList();"><img src="/2017/images/m_md_bn2.jpg" alt="공무원 소양취미 사이버교육"></a></li> -->
										<li><a href="http://hrd.incheon.go.kr/homepage/attend.do?mode=attendList" target="_blank"><img src="/2017/images/m_md_bn2.jpg" alt="공무원 소양취미 사이버교육"></a></li>
										<li><a href="javascript:popupGrcodeList();"><img src="/2017/images/m_md_bn3.jpg" alt="신임인재양성과정 사이버교육"></a></li>

								</ul>
						</li>
						<li>
								<div class="mvVisual">
									<!--<img src="/2017/images/m_md_visual.jpg"> -->
									<a href="http://incheon.nhi.go.kr/" target="_blank"><img src="/2017/images/20190225banner.png"></a>
								</div>
						</li>
						<li class="mvRight">
									<ul>
										<li><a href="http://www.cyber.incheon.kr/" target="_blank"><img src="/2017/images/m_md_bn4.jpg" alt="시민 사이버센터"></a></li>
										<li><a href="/homepage/introduce.do?mode=eduinfo7-6-4" target="_blank" ><img src="/2017/images/m_md_bn5.jpg" alt="시설대여안내"></a></li>
										<li><a href="/homepage/support.do?mode=faqView&fno=60" target="_blank"><img src="/2017/images/m_md_bn6.jpg" alt="학습장애시 환경설정 필수조치사항"></a></li>

								</ul>
						</li>
				</ul>

		</div><!-- //mvFrame -->

		 <!-- <div class="gcBanner">
			<div class="leTtle" >
				 <img src="/2017/images/sp_lf_title1.jpg"> 
			</div>
			<div class="spl" >
				<img src="/2017/images/sp_arrow.jpg">
			</div>  -->

<!-- rolling banner st -->

<!-- <script type="text/javascript" src="/2017/js/jquery.flexisel.js"></script>
<script type="text/javascript">

$(window).load(function() {
    $("#flexiselDemo1").flexisel();

    $("#flexiselDemo2").flexisel({
        visibleItems: 4,
        itemsToScroll: 3,
        animationSpeed: 200,
        infinite: true,
        navigationTargetSelector: null,
        autoPlay: {
            enable: false,
            interval: 5000,
            pauseOnHover: true
        },
        responsiveBreakpoints: { 
            portrait: { 
                changePoint:480,
                visibleItems: 1,
                itemsToScroll: 1
            }, 
            landscape: { 
                changePoint:640,
                visibleItems: 2,
                itemsToScroll: 2
            },
            tablet: { 
                changePoint:768,
                visibleItems: 3,
                itemsToScroll: 3
            }
        },
        loaded: function(object) {
            console.log('Slider loaded...');
        },
        before: function(object){
            console.log('Before transition...');
        },
        after: function(object) {
            console.log('After transition...');
        }
    });
    
    $("#flexiselDemo3").flexisel({
        visibleItems: 3,
        itemsToScroll: 1,         
        autoPlay: {
            enable: true,
            interval: 5000,
            pauseOnHover: true
        }        
    });
    
    $("#flexiselDemo4").flexisel({
        infinite: false     
    });    
    
});

</script> -->
<!-- 
		<ul id="flexiselDemo3">
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/1.jpg" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:5,979명/수료인원:13,630명</span><br>수료과정수:2.28</h4>
					</li>
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/2.gif" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:661명/수료인원:632명</span><br>수료과정수:0.96</h4>
					</li>
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/3.gif" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:527명/수료인원:976명</span><br>수료과정수:1.85</h4>
					</li>
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/4.gif" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:894명/수료인원:1,548명</span><br>수료과정수:1.73</h4>
					</li>                                                 
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/5.jpg" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:685명/수료인원:2,292명</span><br>수료과정수:3.35</h4>
					</li>                                                 
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/6.jpg" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:920명/수료인원:2,360명</span><br>수료과정수:2.57</h4>
					</li>                                                 
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/7.jpg" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:1,077명/수료인원:1,397명</span><br>수료과정수:1.30 </h4>
					</li>                                                 
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/8.jpg" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:727명/수료인원:764명</span><br>수료과정수:1.02</h4>
					</li>                                                 
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/9.gif" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:948명/수료인원:1,094명</span><br>수료과정수:1.15</h4>
					</li>                                                 
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/10.gif" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:660명/수료인원:1,185명</span><br>수료과정수:1.80</h4>
					</li>                                                 
					<li>
						<a href="#"  onClick="location.href='/statisMgr/stats.do?mode=2016'"><img src="/images/depart/11.jpg" /></a>
						<h3>2016년 운영결과 </h3><h4><span>현재인원:536명/수료인원:641명</span><br>수료과정수:1.20</h4>
					</li>                                                 
		</ul>    
 -->
		<div class="clearout"></div>
					

		<!-- rolling banner end -->

				
		</div><!-- //gcBanner end. -->

		<div class="logSection" >

				<jsp:include page="/login/login_main.jsp" flush="false"/>

					<div id="" class="ntcFrame">
							<div class="ntctab">
								  <button class="tablinks" onclick="openAlim(this, 'alim1')" id="defaultOpen">인재개발원알림</button>
								  <button class="tablinks" onclick="openAlim(this, 'alim2')">집합교육</button>
								  <a href="http://incheon.nhi.go.kr" target="_blank"><button class="tablinks" onclick="openAlim(this, 'alim3')">인천시 나라배움터</button></a>
								</div>

								<div id="alim1" class="ntctabcontent">
								  <!-- <h3>London</h3>
								  <p>London is the capital city of England.</p> -->
									<ul>
										<%=sbListHtml%>
										<li class="more"><a href="/homepage/support.do?mode=noticeList"><img src="/2017/images/btn_plus.gif"></a></li>
									</ul>
								</div>

								<div id="alim2" class="ntctabcontent">
								<span class="pmore"> <img src="/2017/images/btn_plus.gif"> </span>
								<div class="flowc">
									<table>
										<colgroup>
											<col width="">
											<col width="78">
											<col width="38">
											<col width="58">
											<col width="78">
										</colgroup>
										<thead>
										<tr>
												<th>과정명</th>
												<th>신청기간</th>
												<th>인원</th>
												<th>이수시간</th>
												<th>교육기간</th>
										</tr>
										</thead>
										<tbody>
											<%= nonCyberListHtml %>
										</tbody>
									</table>
								</div>
								</div>

								<div id="alim3" class="ntctabcontent">
								<span class="pmore"> <img src="/2017/images/btn_plus.gif"> </span>
								<div class="flowc">
									<table>
										<colgroup>
											<col width="">
											<col width="78">
											<col width="38">
											<col width="58">
											<col width="78">
										</colgroup>
										<thead>
										<tr>
												<th>과정명</th>
												<th>신청기간</th>
												<th>인원</th>
												<th>이수시간</th>
												<th>교육기간</th>
										</tr>
										</thead>
										<tbody>
											<%= cyberListHtml %>
										</tbody>
									</table>
								</div>
							</div>
					</div>
<script>
function openAlim(evt, cityName) {
    var i, ntctabcontent, tablinks;
    //tabcontent = document.getElementsByClassName("tabcontent");
    //for (i = 0; i < tabcontent.length; i++) {
    //    tabcontent[i].style.display = "none";
    //}
	$(".ntctabcontent").each(function(){
		$(this).css("display","none");
	});
   // tablinks = document.getElementsByClassName("tablinks");
   // for (i = 0; i < tablinks.length; i++) {
   //     tablinks[i].className = tablinks[i].className.replace(" active", "");
    //}

	$(".tablinks").each(function(){
	var new_class = new String($(this).attr("class")).replace(" active","");
	//alert(new_class);
	$(this).attr("class", new_class);
		
	});

    document.getElementById(cityName).style.display = "block";
	$(evt).attr("class",$(evt).attr("class")+" active");

    //evt.currentTarget.className += " active";
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();
</script>

				<div class="popZone">
					<h1 class="zoneTtle">팝업존</h1>
						<div class="asanMn-section section0401" id="js-asanMn-banner" style="margin:0 auto;text-align:center">
								<!-- <h2 class="tts">배너영역1</h2> -->
								<ul class="list">
									<li class="control">
										<button class="auto" type="button"><span class="tts">자동롤링</span></button>
										<button class="stop" type="button"><span class="tts">정지</span></button>
									</li>
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
			                			<li class="item">
											<button class="anchor"><span class="tts"><%=popupZoneListMap.getString("fileAlt", i)%></span></button>
											<div class="thum">		
												<a href="<%=linkUrl%>" target="<%=popupZoneListMap.getString("linkTarget", i)%>"><img src="http://hrd.incheon.go.kr/pds/popupZone/<%=popupZoneListMap.getString("fileName", i)%>" title="<%=popupZoneListMap.getString("fileAlt", i)%>" alt='.' border="0" /></a>			
											</div>
										</li>
			                			<%
			                		}
			                	}
			                	%>
								</ul>
<script type="text/javascript" src="/2017/js/jquery-carousel_1.1.js"></script>
<script type="text/javascript" src="/2017/js/template.js"></script>

			<script type="text/javascript">
			$(function(){
				$("#js-asanMn-banner").bnnrRolling({ auto : true, speed : 4000 });
			});
			</script>


					</div>

				</div>

				<div class="recmBanner">
						<div class="leTtle" >
							<img src="/2017/images/sp_lf_title2.jpg">
						</div>
						<div class="spl" >
							<img src="/2017/images/sp_arrow.jpg">
						</div>

						<div class="reccBox">
								<ul>
									<li class="fst"><a href="http://incheon.nhi.go.kr" target="_blank"><img src="/2017/images/2019recom1.jpg" width="110px" height="80px"></a><h3>e-공공빅데이터 업무적용 길라잡이</h3></li>
									<li><a href="http://incheon.nhi.go.kr" target="_blank"><img src="/2017/images/2019recom2.jpg" width="110px" height="80px"></a><h3>e-장애인차별예방교육</h3></li>
									<li><a href="http://incheon.nhi.go.kr" target="_blank"><img src="/2017/images/2019recom3.png" width="110px" height="80px"></a><h3>부패앞에 단호해지기</h3></li>
									<li><a href="http://incheon.nhi.go.kr" target="_blank"><img src="/2017/images/2019recom4.png" width="110px" height="80px"></a><h3>e-한글,엑셀,파워포인트 활용 TIP</h3></li>
									<li><a href="http://incheon.nhi.go.kr" target="_blank"><img src="/2017/images/2019recom5.jpg" width="110px" height="80px"></a><h3>e-공무원의 행복한 미래설계</h3></li> 
								</ul>
				
						</div>
				</div>

		</div><!-- //logSection end -->

		<div id="" class="eduSection">
				<div class="phoneBox">
					<h1 class="phoneTtle">
						교육안내
					</h1>
						<table class="tb_lf_phone">
								<tr>
									<td class="stitle">집합교육(신청,승인)안내</td>
									<td class="nums">032-440-7676</td>
								</tr>
								<tr>
									<td class="stitle">사이버외국어교육안내</td>
									<td class="nums">032-440-7682</td>
								</tr>
								<tr>
									<td class="stitle">사이버전문교육안내</td>
									<td class="nums">032-440-7684</td>
								</tr>
								<tr>
									<td class="stitle">강사관련문의</td>
									<td class="nums">032-440-7663</td>
								</tr>
								<tr>
									<td>  </td> 
									<td class="nums">032-440-7683,5</td>
								</tr>
								<tr>
									<td class="stitle">중견간부양성과정</td>
									<td class="nums">032-440-7674</td>
								</tr>
								<tr>
									<td class="stitle">외국어 정예과정</td>
									<td class="nums">032-440-7675</td>
								</tr>
							
						</table>
					<h1 class="phoneTtle2">
						시설안내
					</h1>
						<table class="tb_lf_phone">
								<tr>
									<td class="stitle"><strong>시설대관</strong></td>
									<td class="nums"><strong>032-440-7632</strong></td>
								</tr>
								<tr>
									<td class="stitle">도서대출 및 열람실</td>
									<td class="nums">032-440-7743</td>
								</tr>
							
						</table>

				</div>
			
				<div id="" class="ntcFrame">
					
						<div class="motab">
								<h2 class="frst">이달의학습</h2>
									<!-- <button class=" frst" >이달의 학습</button> -->
						<%
							int month = Integer.parseInt(requestMap.getString("month"));
						%>
								  <button class="motablinks" onclick="openMonth(this, '1')" <%if(month==1){%>id="defaultOpen2"<%} %>>1월</button>
								  <button class="motablinks" onclick="openMonth(this, '2')" <%if(month==2){%>id="defaultOpen2"<%} %>>2월</button>
								  <button class="motablinks" onclick="openMonth(this, '3')" <%if(month==3){%>id="defaultOpen2"<%} %>>3월</button>
								  <button class="motablinks" onclick="openMonth(this, '4')" <%if(month==4){%>id="defaultOpen2"<%} %>>4월</button>
								  <button class="motablinks" onclick="openMonth(this, '5')" <%if(month==5){%>id="defaultOpen2"<%} %>>5월</button>
								  <button class="motablinks" onclick="openMonth(this, '6')" <%if(month==6){%>id="defaultOpen2"<%} %>>6월</button>
								  <button class="motablinks" onclick="openMonth(this, '7')" <%if(month==7){%>id="defaultOpen2"<%} %>>7월</button>
								  <button class="motablinks" onclick="openMonth(this, '8')" <%if(month==8){%>id="defaultOpen2"<%} %>>8월</button>
								  <button class="motablinks" onclick="openMonth(this, '9')" <%if(month==9){%>id="defaultOpen2"<%} %>>9월</button>
								  <button class="motablinks" onclick="openMonth(this, '10')" <%if(month==10){%>id="defaultOpen2"<%} %>>10월</button>
								  <button class="motablinks" onclick="openMonth(this, '11')" <%if(month==11){%>id="defaultOpen2"<%} %>>11월</button>
								  <button class="motablinks" onclick="openMonth(this, '12')" <%if(month==12){%>id="defaultOpen2"<%} %>>12월</button>

							
								</div>

									<div id="mex" class="montabcontent">
										<ul>
											<%= monthListHtml%>
										</ul>
									</div>


<script>
function openMonth(evt, cityName) {
    var i, montabcontent, motablinks;
    var month;
   
	$(".montabcontent").each(function(){			
		$(this).css("display", "none");		
	});
  
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

   document.getElementById("mex").style.display = "block";
   $(evt).attr("class",$(evt).attr("class")+" active");
  
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen2").click();
</script>
								
					</div>

				<div class="conver">
					<h1 class="conTtle">교육생 숙지사항</h1>
					<ul>
<% if(loginInfo.isLogin()) {%>
							<li><a href="/down/2019_eduplan_1.pdf" target="_blank">교육훈련계획</a></li> 
							<li><a href="/down/02.hwp">교육인정시간 기준</a></li>
							<li><a href="/down/03.hwp">사이버교육 운영지침</a></li>
							<li><a href="/down/2019_eduplan_2.pdf">사이버과정별 안내서</a></li>
<% } else { %>
							<li><a href="/down/2019_eduplan_1.pdf">교육훈련계획</a></li>
							<li><a href="/down/02.hwp">교육인정시간 기준</a></li>
							<li><a href="/down/03.hwp">사이버교육 운영지침</a></li>
							<li><a href="/down/2019_eduplan_2.pdf">사이버과정별 안내서</a></li>
<% } %>
					</ul>

				</div><!-- //conver end.숙지사항 -->
		</div>

			<div class="quickBanner">
						<div class="leTtle" >
							<img src="/2017/images/sp_lf_title3.jpg">
						</div>
						<div class="spl" >
							<img src="/2017/images/sp_arrow.jpg">
						</div>

						<div class="quickBox">
								<ul>
									<li class="fst"><a href='javascript:popWin("/homepage/studyhelp/learning_guide01.html","ddd","820","515","no","no")'><img src="/2017/images/m_qk_flat1.png" alt="학습도우미"></a></li>
			                        <li><a href="/homepage/infomation.do?mode=eduinfo2-3"><img src="/2017/images/m_qk_flat2.png" alt="연간교육인정"></a></li>
			                        <li><a href="/homepage/support.do?mode=faqList"><img src="/2017/images/m_qk_flat3.png" alt="자주하는 질문"></a></li>
			                        <li><a href="javascript:popWin('http://152.99.42.151:81/','ccc','658','540','yes','yes')"><img src="/2017/images/m_qk_flat4.png" alt="PC 원격지원"></a></li>
			                        <li><a href="/homepage/introduce.do?mode=eduinfo7-7"><img src="/2017/images/m_qk_flat5.png" alt="찾아오시는길"></a></li>
			                        <li><a href="javascript:move_cyber();"><img src="/2017/images/m_qk_flat7.png" alt="인천시민사이버교육센터"></a></li>
			                        <li><a href="http://www.logodi.go.kr/competency/ic" target="_blank"><img src="/2017/images/m_qk_flat6.png" alt="역량 시스템"></a></li>
								</ul>
				
						</div>
				</div>

	</div><!-- //mainFrame end -->
<!-- footer start -->
	
		<div id="footerFrame" class="" >
				
				<div  class="footerDiv">

							<div id="" class="footerLogo">
								<img src="/2017/images/logo_bt.png">
							</div>
							<div id="" class="footLst">
									<ul>
										<li><a href="/homepage/introduce.do?mode=eduinfo7-7">찾아오시는길</a></li>
										<li><a href="/homepage/index.do?mode=worktel">업무별연락처</a></li>
										<li><a href="/homepage/index.do?mode=policy" style="color: red;font-weight: bold;">개인정보처리방침</a></li>
										<li><a href="/homepage/index.do?mode=videopolicy">영상정보처리기기운영관리 방침</a></li>
										<li><a href="/homepage/index.do?mode=spam">이메일 무단수집거부</a></li>
										<li><a href="http://incheon.nhi.go.kr" style="color: blue;font-weight: bold;">인천시 나라배움터</a></li>
									</ul>
							</div>
							<div id="" class="footerText">
								22711 인천광역시 서구 심곡로 98 / 집합교육안내 032)440-7676, 사이버교육안내 032)440-7684, <B>시설대관 440-7632</B> / FAX (032)440-8795<br>
								홈페이지에 게시된 이메일주소가 자동 수집되는 것을 거부하며, 위반시 정보통신 관련법령에 의거해 처벌됩니다.<br>
								CopyRightⓒ2007 인천광역시인재개발원, All rights Reserved. 이 사이트의 콘텐츠를 무단 사용할 수 없습니다.
							</div>
							<div id="" class="footerQcode">
								<img src="/2017/images/bt_qr_code.gif">
							</div>

			</div>
		</div>
		<!--// footer end -->

</div><!-- //icWrapper -->


<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-68570344-3', 'auto');
  ga('send', 'pageview');

</script>
<!--// footer -->
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
