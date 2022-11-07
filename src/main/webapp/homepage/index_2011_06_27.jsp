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
			
			// <li><a href="#">2010년 제2기 신규채용자과정 교육안내</a> <span>2010-04-01</span></li>
			
			
			sbListHtml.append("<li>");
			
			String title = listMap.getString("title", i);
			if(title.length() >= 34) {
				title = title.substring(0,32) + "...";
			}
			sbListHtml.append("	<a href=\"/homepage/support.do?mode=noticeView&boardId=NOTICE&seq="+listMap.getString("seq", i)+"\">" + title+"</a>");
			sbListHtml.append("	<span>" + listMap.getString("regdate", i) +"</span>");
			sbListHtml.append("</li>");

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
			//cyberListHtml.append("	<td class=\"bl0 sbj\"> <a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+cyberListMap.getString("grcode", i)+"&grseq="+cyberListMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")>"+cyberListMap.getString("grcodeniknm", i) +"</a></td>");
			cyberListHtml.append("	<td class=\"bl0 sbj\"> <a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+cyberListMap.getString("grcode", i)+"&grseq="+cyberListMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")>"+ title +"</a></td>");
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
			nonCyberListHtml.append("	<td class=\"bl0 sbj\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+nonCyberlistMap.getString("grcode", i)+"&grseq="+nonCyberlistMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")>"+nonCyberlistMap.getString("grcodeniknm", i) +"</a></td>");
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
			if(title.length() >= 31 )	title = title.substring(0, 30) + "...";
			
			monthListHtml.append("<li>");
			monthListHtml.append("	<span class=\"tit\">[" + monthlistMap.getString("gubun", i) + "]</span><a href=\"javascript:popWin('/homepage/course.do?mode=courseinfopopup&grcode="+monthlistMap.getString("grcode", i)+"&grseq="+monthlistMap.getString("grseq", i)+"','aaa','603','680','yes','yes')\">"+ title +"</a>");
			monthListHtml.append("	<span class=\"data\">" + monthlistMap.getString("started", i) + "~"+monthlistMap.getString("enddate", i) +"</span>");
			monthListHtml.append("</li> \n");	
		}
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
				goodLectureListHtml.append("	<dt><a href=\""+goodLectureListMap.getString("url",i)+"\"><img width=\"57\" height=\"52\" src=\"/pds"+goodLectureListMap.getString("filePath",i)+"\" /></a></dt> ");				
			}else if(goodLectureListMap.getString("gubun",i).equals("2")){
				goodLectureListHtml.append("	<dt><a href=javascript:popWin(\""+goodLectureListMap.getString("url",i)+ "\",\"aaa\",\"430\",\"440\",\"yes\",\"yes\")><img width=\"57\" height=\"52\" src=\"/pds"+goodLectureListMap.getString("filePath",i)+"\" /></a></dt> ");
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
			photoListHtml.append("");
			photoListHtml.append("<dl>");
			photoListHtml.append("<dt><a href=javascript:popWin(\"/homepage/index.do?mode=showpicture2&photoNo="+photoListMap.getString("photoNo",i)+"\",\"aaa\",\"900\",\"750\",\"yes\",\"yes\") ><img width=\"57\" height=\"52\" src=\"/pds"+photoListMap.getString("imgPath",i)+"\"/></a></dt>");
			photoListHtml.append("<dd>"+photoListMap.getString("wcomments",i)+"</dd>");
			//photoListHtml.append("<dd class=\"cont\"></dd>");
			photoListHtml.append("</dl>");
			if(i == 0) {
				photoListHtml.append("<div class=\"spc\"></div>");
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
		grseqPlanListHtml.append("<dt>교육생 숙지사항</dt>");
		for(int i=0; i < grseqPlanListMap.keySize("rownum"); i++){
			String strName = grseqPlanListMap.getString("grcodeniknm",i);
			if (strName.length() > 10){
				strName = grseqPlanListMap.getString("grcodeniknm",i).substring(0,9)+"..";
			}
			grseqPlanListHtml.append("<dd>· <a href=javascript:popWin(\"/commonInc/fileDownload.do?mode=popup&groupfileNo="+grseqPlanListMap.getString("groupfileNo",i)+"\",\"aaa\",\"350\",\"280\",\"yes\",\"yes\") alt=\""+grseqPlanListMap.getString("grcodeniknm",i)+"\">"+strName+"</a></dd>");
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>공무원</title>
<link rel="STYLESHEET" type="text/css" href="/share/css/main.css" />
<!--[if IE]>
<link rel="STYLESHEET" type="text/css" href="/share/css/ie.css" />
<![endif]-->
<!-- 추가 -->


<link href="/commonInc/css/protoload.css" rel="stylesheet" type="text/css">

<script type="text/javascript" language="javascript" src="/commonInc/js/<%= skinDir %>/gnbMenu.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/NChecker.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/protoload.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/homeCategory.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/inno/InnoDS.js"></script>
<!-- 추가 -->
<script type="text/javascript" src="/share/js/common.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
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
	//주석-hwani / firefox debug
	
// /*
	var strTable ="<select name='select2' class='select01' onChange='formHandler(this.form)'>";
		strTable += "<option>시 산하기관 홈페이지</option>";
		strTable += "<option>--------------------</option>";
		strTable += "<option>[ 시청 ]</option>";
		strTable += "<option value='http://www.incheon.go.kr'>인천광역시</option>";
		strTable += "<option>--------------------</option>";
		strTable += "<option>[ 군,구 ]</option>";
		strTable += "<option value='http://www.icjg.go.kr'>중 구</option>";
		strTable += "<option value='http://www.dong-gu.incheon.kr'>동 구</option>";
		strTable += "<option value='http://www.namgu.incheon.kr'>남 구</option>";
		strTable += "<option value='http://www.yeonsu.incheon.kr'>연수구</option>";
		strTable += "<option value='http://www.namdong.go.kr'>남동구</option>";
		strTable += "<option value='http://www.icbp.go.kr'>부평구</option>";
		strTable += "<option value='http://www.gyeyang.go.kr'>계양구</option>";
		strTable += "<option value='http://www.seo.incheon.kr'>서 구</option>";
		strTable += "<option value='http://www.ganghwa.incheon.kr'>강화군</option>";
		strTable += "<option value='http://gun.ongjin.incheon.kr'>옹진군</option>";
		strTable += "<option>--------------------</option>";
		strTable += "<option>[ 직속기관 ]</option>";
		strTable += "<option value='http://www.inchon.ac.kr'>인천대학교</option>";
		strTable += "<option value='http://www.icc.ac.kr'>인천전문대학</option>";
		strTable += "<option value='http://www.nambufire.incheon.kr'>남부소방서</option>";
		strTable += "<option value='http://www.bukbu119.incheon.kr'>북부소방서</option>";
		strTable += "<option value='http://www.gy119.go.kr'>계양소방서</option>";
		strTable += "<option value='http://user.chollian.net/~west119'>서부소방서</option>";
		strTable += "<option value='http://ecopia.incheon.go.kr'>보건환경연구원</option>";
		strTable += "<option value='http://agro.incheon.go.kr'>농업기술센터</option>";
		strTable += "<option>--------------------</option>";
		strTable += "<option>[ 사업소 ]</option>";
		strTable += "<option value='http://waterworksh.inchon.kr'>상수도사업본부</option>";
		strTable += "<option value='http://uda.incheon.go.kr'>도시개발본부</option>";
		strTable += "<option value='http://jonggeon.incheon.go.kr'>종합건설본부</option>";
		strTable += "<option value='http://art.incheon.go.kr'>종합문화예술회관</option>";
		strTable += "<option value='http://grandpark.incheon.go.kr'>동부공원사업소</option>";
		strTable += "<option value='http://women-center.incheon.go.kr'>여성복지관</option>";
		strTable += "<option value='http://www.michuhollib.go.kr'>인천광역시 미추홀도서관</option>";
		strTable += "<option value='http://museum.incheon.go.kr'>인천시립박물관</option>";
		strTable += "<option value='http://work.incheon.go.kr'>근로청소년복지회관</option>";
		strTable += "<option value='http://youth.incheon.go.kr'>청소년회관</option>";
		strTable += "<option value='http://www.wolmipark.net'>서부공원사업소</option>";
		strTable += "<option value='http://green.incheon.go.kr'>녹지관리사업소</option>";
		strTable += "<option value='http://guwol-market.incheon.go.kr'>구월농축산물도매시장</option>";
		strTable += "<option value='http://samsan-market.incheon.go.kr'>삼산농산물도매시장</option>";
		strTable += "<option value='http://i-youth.incheon.go.kr'>청소년수련관</option>";
		strTable += "</select>";

	var strTable2 ="<select name='select2' class='select01' onChange='formHandler(this.form)'>";
		strTable2 += "<option>교육관련기관</option>";
		strTable2 += "<option>--------------------</option>";
		strTable2 += "<option>[ 중 앙 ]</option>";
		strTable2 += "<option>--------------------</option>";
		strTable2 += "<option value='http://www.coti.go.kr'>중앙공무원교육원</option>";
		strTable2 += "<option value='http://www.logodi.go.kr'>지방행정연수원</option>";
		strTable2 += "<option value='http://lms.klid.or.kr'>한국지역정보개발원</option>";
		strTable2 += "<option value='http://www.bai-edu.go.kr'>감사교육원</option>";
		strTable2 += "<option value='http://taxstudy.nts.go.kr'>국세공무원교육원</option>";
		strTable2 += "<option value='http://www.fire.or.kr'>중앙소방학교</option>";
		strTable2 += "<option value='http://www.pca.go.kr'>경찰종합학교</option>";
		strTable2 += "<option value='http://www.lrti.go.kr'>법무연수원</option>";
		strTable2 += "<option value='http://www.icoti.go.kr'>지식경제공무원교육원</option>";
		strTable2 += "<option value='http://cyber.korail.go.kr'>Korail 인재개발원</option>";
		strTable2 += "<option value='http://www.ifans.go.kr'>외교안보연구원</option>";
		strTable2 += "<option value='http://www.fhi.go.kr'>산림인력개발원</option>";
		strTable2 += "<option value='http://www.e-academy.go.kr'>정부정보화교육센터</option>";
		strTable2 += "<option value='http://www.nier.go.kr'>국립환경과학원</option>";
		strTable2 += "<option value='http://www.nih.go.kr'>질병관리본부</option>";
		strTable2 += "<option>--------------------</option>";
		strTable2 += "<option>[ 지방자치단체 ]</option>";
		strTable2 += "<option>--------------------</option>";
		strTable2 += "<option value='http://hrd.seoul.go.kr'>서울특별시시인재개발원</option>";
		strTable2 += "<option value='http://hrd.busan.go.kr'>부산광역시인재개발원</option>";
		strTable2 += "<option value='http://www.daegu.go.kr/Loti/Default.aspx'>대구광역시공무원교육원</option>";
		strTable2 += "<option value='http://edu.gjcity.net/'>광주광역시지방공무원교육원</option>";
		strTable2 += "<option value='http://www.daejeon.go.kr/edu'>대전광역시공무원교육원</option>";
		strTable2 += "<option value='http://edu.gyeonggi.go.kr/'>경기도인재개발원</option>";
		strTable2 += "<option value='http://edu.provin.gangwon.kr/'>강원도인재개발원</option>";
		strTable2 += "<option value='http://loti.cb21.net/'>충청북도자치연수원</option>";
		strTable2 += "<option value='http://www.chungnam.net/content/busi/educ/index.jsp'>충청남도지방공무원교육원</option>";
		strTable2 += "<option value='http://loti.jeonbuk.go.kr/index.jsp'>전라북도지방공무원교육원</option>";
		strTable2 += "<option value='http://www.loti.jeonnam.kr'>전라남도지방공무원교육원</option>";
		strTable2 += "<option value='http://www.gboti.go.kr'>경상북도지방공무원교육원</option>";
		strTable2 += "<option value='http://loti.gsnd.net/'>경상남도지방공무원교육원</option>";
		strTable2 += "<option value='http://www.edu.jeju.kr'>제주특별자치도인력개발원</option>";
		strTable2 += "</select>";

	var strTable3	="<select name='select2' class='select01' onChange='formHandler(this.form)'>";
		strTable3	+= "<option selected>시 산하 유관기관 홈페이지</option>";
		strTable3 += "<option value='http://www.iudc.co.kr'>인천도시개발공사</option>";
		strTable3 += "<option value='http://www.ice.go.kr'>인천시교육청</option>";
		strTable3 += "<option value='http://www.icpolice.go.kr/'>인천지방경찰청</option>";
		strTable3 += "<option value='http://incheon.dppo.go.kr'>인천지방검찰청</option>";
		strTable3 += "<option value='http://nd.icpolice.go.kr'>인천남동경찰서</option>";
		strTable3 += "<option value='http:/incheon.nmpa.go.kr'>인천해양경찰서</option>";
		strTable3 += "<option value='http://www.mma.go.kr/kor/l_suwon/index.html'>인천/경기지방병무청</option>";
		strTable3 += "<option value='http://ic.election.go.kr/'>인천선거관리위원회</option>";
		strTable3 += "<option value='http://inchon.nso.go.kr/'>인천통계사무소</option>";
		strTable3 += "<option value='http://www.icmc.or.kr'>인천의료원</option>";
		strTable3 += "<option value='http://www.ictr.or.kr'>인천교통공사</option>";
		strTable3 += "<option value='http://www.into.or.kr'>인천관광공사</option>";
		strTable3 += "<option value='http://www.insiseol.net'>인천시설관리공단</option>";
		strTable3 += "<option value='http://www.idi.re.kr'>인천발전연구원</option>";
		strTable3 += "<option value='http://www.irtc.co.kr'>인천메트로</option>";
		strTable3 += "<option value='http://www.portincheon.go.kr'>인천지방해양수산청</option>";
		strTable3 += "<option value='http://www.sarok.go.kr/'>인천지방조달청</option>";
		strTable3 += "<option value='http://www.airport.or.kr'>인천국제공항</option>";
		strTable3 += "<option value='http://www.iit.or.kr'>인천정보산업진흥원</option>";
		strTable3 += "<option value='http://www.step.or.kr/'>송도테크노파크</option>";
		strTable3 += "<option value='http://www.kah.or.kr/'>한국건강관리협회</option>";
		strTable3 += "<option value='http://www.fsc.go.kr/'>금융감독위원회</option>";
		strTable3 += "<option value='http://www.ppfk.or.kr/'>대한가족보건복지협회</option>";
		strTable3 += "<option value='http://www.icsinbo.or.kr/'>인천신용보증재단</option>";
		strTable3 += "<option value='http://www.ehhosp.com/'>시립노인치매요양병원</option>";
		strTable3 += "<option value='http://www.kgs.or.kr/'>한국가스안전공사</option>";
		strTable3 += "<option value='http://www.kemco.or.kr'>에너지관리공단</option>";
		strTable3 += "<option value='http://www.kesco.or.kr'>한국전기안전공사</option>";
		strTable3 += "<option value='http://www.incci.or.kr'>인천상공회의소</option>";
		strTable3 += "</select>";

	if(val == 1) {
		site_tab("site1");
		site_tab("sub1");
		selOpt1.innerHTML = strTable;
		
		//stie_tab.innerHTML = "<a href='javascript:selectOpt(1)' class='city' onFocus='this.blur();'>시관련기관</a><a href='javascript:selectOpt(2);' class='edu' onFocus='this.blur();'>교육기관</a><a href='javascript:selectOpt(3);'class='relat' onFocus='this.blur();'>유관기관</a>"
		//document.getElementById("linkimg1").src="/images/<%= skinDir %>/main/leftTab1_on.gif";
		//document.getElementById("linkimg2").src="/images/<%= skinDir %>/main/leftTab2.gif";
		//document.getElementById("linkimg3").src="/images/<%= skinDir %>/main/leftTab3.gif";		
	} else if(val == 2) {
		selOpt2.innerHTML = strTable2;
		site_tab("site2");
		site_tab("sub2");
		//stie_tab.innerHTML = "<a href='javascript:selectOpt(1)' class='city' onFocus='this.blur();'>시관련기관</a><a href='javascript:selectOpt(2);' class='edu' onFocus='this.blur();'>교육기관</a><a href='javascript:selectOpt(3);'class='relat' onFocus='this.blur();'>유관기관</a>"
		//document.getElementById("linkimg1").src="/images/<%= skinDir %>/main/leftTab1.gif";
		//document.getElementById("linkimg2").src="/images/<%= skinDir %>/main/leftTab2_on.gif";
		//document.getElementById("linkimg3").src="/images/<%= skinDir %>/main/leftTab3.gif";
	} else {
		selOpt3.innerHTML = strTable3;
		site_tab("site3");
		site_tab("sub3");
		//document.getElementById("linkimg1").src="/images/<%= skinDir %>/main/leftTab1.gif";
		//document.getElementById("linkimg2").src="/images/<%= skinDir %>/main/leftTab2.gif";
		//document.getElementById("linkimg3").src="/images/<%= skinDir %>/main/leftTab3_on.gif";
	}
//*/	
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

			if(month == i) {
				$(i+"").setStyle({background:'transparent url(../images/main/tab_m_on.gif)',color:'#ffffff'});
			}else {
				$(i+"").setStyle({background:'transparent url(../images/main/tab_m.gif)',color:'#838383'});
			}
		}

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
			alert('준비중 입니다.');
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
		alert('준비중 입니다.');
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
	open ("http://incheon.winglish.com","NewWindow",
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
</script>
</head>
<body onload="init();popup();" id="zoom">
<!-- 메뉴이동 -->
<ul id="accessibility_menu">
	<li><a href="#content">본문으로 넘어가기</a></li>
	<li><a href="#header">대 메뉴로 넘어가기</a></li>
	<li><a href="#footer">카피라이터로 넘어가기</a></li>
</ul>
<!--// 메뉴이동 -->
<hr />

<!-- header -->
<div id="header">
	<div class="header">
		<div class="flash"><img src="/images/main/top.jpg" alt="" width="1030" height="347" />
			<!-- <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="1030" height="347" id="top1" align="middle">
			<param name="allowScriptAccess" value="sameDomain" />
			<param name="movie" value="flash/visual.swf" />
			<param name="quality" value="high" />
			<param name="wmode" value="transparent" />
			<embed src="flash/visual.swf" wmode="transparent" quality="high" width="1030" height="347" name="top1" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
			</object> -->
		</div>
		<div class="toparea">
			<h1><a href="/">인천광역시 인재개발원</a></h1>
			<div id="menu">
			<dl>
				<dd><a href="/homepage/index.do?mode=sitemap" class="sitemap">sitemap</a></dd>
				<dd><a href="/foreign/english/index.html" class="english">English</a></dd>
				<dd><a href="http://www.cyber.incheon.kr/" target="_blank" class="cyberedu">시민 사이버교육</a></dd>
			</dl>
			<ul class="gnb" id="cssmenu1">
				<li class="menu1"><a href="javascript:fnGoMenu(1,'main');" id="menu1_" onmouseover="openSub('sub1');" onfocus="openSub('sub1');">마이페이지</a></li>
					<ul id="sub1">
					</ul>
				<li class="menu2"><a href="javascript:fnGoMenu(2,'eduinfo2-1');" id="menu2_" onmouseover="openSub('sub2');" onfocus="openSub('sub2');">교육안내</a>
					<ul id="sub2">
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-1');" id="sub2_1">입교안내</a></li>
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-2');" id="sub2_2">교육훈련체계</a></li>
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-4');" id="sub2_3">교육현황</a></li>
					</ul>
				</li>
				<li class="menu3"><a href="javascript:fnGoMenu(2,'eduinfo2-3');" id="menu3_" onmouseover="openSub('sub3');" onfocus="openSub('sub3');">교육과정</a>
					<ul id="sub3">
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-3');" id="sub3_1">연간교육일정</a></li>
						<li><a href="javascript:fnGoMenu(3,'eduinfo3-1');" id="sub3_2">기본교육</a></li>
						<li><a href="javascript:fnGoMenu(3,'eduinfo3-3');" id="sub3_3">전문교육</a></li>
						<li><a href="javascript:fnGoMenu(3,'eduinfo3-2');" id="sub3_4">기타교육</a></li>
					</ul>
				</li>
				<li class="menu4"><a href="javascript:fnGoMenu(4,'attendList');" id="menu4_" onmouseover="openSub('sub4');" onfocus="openSub('sub4');">수강신청</a>
					<ul id="sub4">
						<li><a href="javascript:fnGoMenu(4,'attendList');" id="sub4_1">수강신청</a></li>
						<li><a href="javascript:fnGoMenu(5,'opencourse');" id="sub4_2">공개강의</a></li>
					</ul>
				</li>
				<li class="menu5"><a href="javascript:fnGoMenu('5','faqList');" id="menu5_" onmouseover="openSub('sub5');" onfocus="openSub('sub5');">학습지원</a>
					<ul id="sub5">
						<li><a href="javascript:fnGoMenu(5,'faqList');" id="sub5_1">열린광장</a></li>
						<li><a href="javascript:fnGoMenu(5,'educationDataList');" id="sub5_2">자료실</a></li>
						<li><a href="javascript:fnGoMenu(5,'webzine');" id="sub5_3">포토갤러리</a></li>
						<li><a href="http://152.99.42.138/" target="_blank"  id="sub5_4">e-도서관</a></li>
					</ul>
				</li>
				<li class="menu6"><a href="javascript:fnGoMenu(6,'eduinfo6-1');" id="menu6_" onmouseover="openSub('sub6');" onfocus="openSub('sub6');">e-book</a></li>
					<ul id="sub6">
					</ul>
				<li class="menu7"><a href="javascript:fnGoMenu('7','eduinfo7-1');" id="menu7_" onmouseover="openSub('sub7');" onfocus="openSub('sub7');">인재개발원 소개</a>
					<ul id="sub7">
						<li><a href="javascript:fnGoMenu('7','eduinfo7-1');" id="sub7_1">인사말</a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-8');" id="sub7_8">안내동영상</a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-2');" id="sub7_2">일반현황</a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-3');" id="sub7_3">조직 및 업무</a></li>
						<li><a href="javascript:fnGoMenu('7','lawsList');" id="sub7_4">법률/조례</a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-6');" id="sub7_5">시설현황</a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-4');" id="sub7_6">식단표</a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-7');" id="sub7_7">찾아오시는 길</a></li>
					</ul>
				</li>
			</ul>
			</div>
		</div>
<!-- 교육생숙지사항,분야별교육안내,과정운영계획 -->
		
		<div class="box_layer">
			<dl class="box1">
				<dt>교육생 숙지사항</dt>
				<dd><a href="/down/01.hwp">· 교육훈련계획</a></dd>
				<dd><a href="/down/02.hwp">· 교육인정시간 기준</a></dd>
				<dd><a href="/down/03.hwp">· 사이버교육 운영지침</a></dd>
				<dd><a href="/down/04.hwp">· 사이버과정별 안내서</a></dd>
			</dl>
			<dl class="box2">
				<dt>교육생 숙지사항</dt>
				<dd><a href="javascript:fnGoMenu(3,'eduinfo3-1')">· 기본교육(신규)</a></dd>
				<dd><a href="javascript:fnGoMenu(3,'eduinfo3-2')">· 장기교육(핵심,외국어)</a></dd>
				<dd><a href="javascript:fnGoMenu(3,'eduinfo3-3')">· 전문교육</a></dd>
				<dd><a href="javascript:fnGoMenu(3,'eduinfo3-4')">· 사이버교육</a></dd>
			</dl>
			<dl class="box3" id="test">
				<%=grseqPlanListHtml%>
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

<form id="forwardPage" name="forwardPage" method="post" >
	<input type="hidden" name="kvt" value="" />
	<input type="hidden" name="anm" value="" />
	<input type="hidden" name="pkey" value="" />
</form>
<form id="pform" name="pform" method="post">	
<!-- container -->
<div id="container">
	<div id="aside">
	
		<!-- login -->
		<jsp:include page="/login/main_login.jsp" flush="false"/>					
		<!-- //login -->

		<p class="goto">
			<a href="javascript:move_winglish();">사이버 어학센터</a>
			<a href="javascript:popWin('http://152.99.42.151:81/','ccc','658','540','yes','yes')">PC 원격접속</a>
			<a href="http://152.99.42.138/" target="_blank">e 도서관</a>
			<a href="/homepage/support.do?mode=opencourse">공개강의</a>
			<%if(loginInfo.isLogin()){%>
			<a href="/movieMgr/movieUse.do?mode=movList" target="_balnk" >동영상 강좌</a>
			<!-- <a href="javascript:goDongaBiz();">동아 비지니스 리뷰</a> -->
			<a href="javascript:goLogodi();">역량 진단 시스템</a>
			<%} else { %>
			<a href="javascript:alert('로그인후 이용하세요');">동영상 강좌</a>
			<!-- <a href="javascript:alert('로그인후 이용하세요');">동아 비지니스 리뷰</a> -->
			<a href="javascript:goLogodi();">역량 진단 시스템</a>
			<%} %>
		</p>

		<div id="phone1" class="phone_tab">
			<p><a class="eduinfo">교육안내</a><a class="facinfo" onmouseover="phone_tab('phone2');" onfocus="phone_tab('phone2');">시설안내</a> <a href="/homepage/support.do?mode=requestList" class="more">more</a></p>
			<ul>
				<li>교육일정 및 신청	032) 440-7655</li>
				<li>사이버교육	           032) 440-7673 </li>
				<li>강사 관련 문의             032) 440-7666</li>
				<li>핵심중견간부양성과정   032) 440-7663</li>
				<li>외국어 정예과정	           032) 440-7653</li>
			</ul>
		</div>
		<div id="phone2" class="phone_tab">
			<p><a class="eduinfo" onmouseover="phone_tab('phone1');" onfocus="phone_tab('phone1');">교육안내</a><a class="facinfo">시설안내</a> <a href="/homepage/support.do?mode=requestList" class="more">more</a></p>
			<ul>
				<li>시설대여	        032) 440-7632 </li>
				<li>도서대출 및 열람실	032) 440-7743 </li>
				<li>셔틀버스 운행            032) 440-7741 </li>
				<li>기타 문의                      032) 562-5814 </li>
			</ul>
		</div>
		<div id="site1" class="site_tab">
			<h2><a class="city">시관련기관</a><a class="edu" onmouseover="site_tab('site2');" onfocus="site_tab('sub2');">교육기관</a><a class="relat" onmouseover="site_tab('site3');" onfocus="site_tab('sub3');">유관기관</a></h2>
			<p>
				<select name="select1" id="select1" style="width:170px;" onChange='formHandler1(this.form)'>
				<option>시 산하기관 홈페이지</option>
				<option>--------------------</option>
				<option>[ 시청 ]</option>
				<option value='http://www.incheon.go.kr'>인천광역시</option>
				<option>--------------------</option>
				<option>[ 군,구 ]</option>
				<option value='http://www.icjg.go.kr'>중 구</option>
				<option value='http://www.dong-gu.incheon.kr'>동 구</option>
				<option value='http://www.namgu.incheon.kr'>남 구</option>
				<option value='http://www.yeonsu.incheon.kr'>연수구</option>
				<option value='http://www.namdong.go.kr'>남동구</option>
				<option value='http://www.icbp.go.kr'>부평구</option>
				<option value='http://www.gyeyang.go.kr'>계양구</option>
				<option value='http://www.seo.incheon.kr'>서 구</option>
				<option value='http://www.ganghwa.incheon.kr'>강화군</option>
				<option value='http://gun.ongjin.incheon.kr'>옹진군</option>
				<option>--------------------</option>
				<option>[ 직속기관 ]</option>
				<option value='http://www.inchon.ac.kr'>인천대학교</option>
				<option value='http://www.icc.ac.kr'>인천전문대학</option>
				<option value='http://www.nambufire.incheon.kr'>남부소방서</option>
				<option value='http://www.bukbu119.incheon.kr'>북부소방서</option>
				<option value='http://www.gy119.go.kr'>계양소방서</option>
				<option value='http://user.chollian.net/~west119'>서부소방서</option>
				<option value='http://ecopia.incheon.go.kr'>보건환경연구원</option>
				<option value='http://agro.incheon.go.kr'>농업기술센터</option>
				<option>--------------------</option>
				<option>[ 사업소 ]</option>
				<option value='http://waterworksh.inchon.kr'>상수도사업본부</option>
				<option value='http://uda.incheon.go.kr'>도시개발본부</option>
				<option value='http://jonggeon.incheon.go.kr'>종합건설본부</option>
				<option value='http://art.incheon.go.kr'>종합문화예술회관</option>
				<option value='http://grandpark.incheon.go.kr'>동부공원사업소</option>
				<option value='http://women-center.incheon.go.kr'>여성복지관</option>
				<option value='http://www.michuhollib.go.kr'>인천광역시 미추홀도서관</option>
				<option value='http://museum.incheon.go.kr'>인천시립박물관</option>
				<option value='http://work.incheon.go.kr'>근로청소년복지회관</option>
				<option value='http://youth.incheon.go.kr'>청소년회관</option>
				<option value='http://www.wolmipark.net'>서부공원사업소</option>
				<option value='http://green.incheon.go.kr'>녹지관리사업소</option>
				<option value='http://guwol-market.incheon.go.kr'>구월농축산물도매시장</option>
				<option value='http://samsan-market.incheon.go.kr'>삼산농산물도매시장</option>
				<option value='http://i-youth.incheon.go.kr'>청소년수련관</option>
				</select>
			</p>
		</div>
		<div id="site2" class="site_tab">
			<h2><a class="city" onmouseover="site_tab('site1');" onfocus="site_tab('site1');">시관련기관</a><a  class="edu">교육기관</a><a class="relat" onmouseover="site_tab('site3');" onfocus="site_tab('site3');">유관기관</a></h2>
			<p>
				<select name="select2" id="select2" style="width:170px;" onChange='formHandler2(this.form)'>
					<option>교육관련기관</option>
					<option>--------------------</option>
					<option>[ 중 앙 ]</option>
					<option>--------------------</option>
					<option value='http://www.coti.go.kr'>중앙공무원교육원</option>
					<option value='http://www.logodi.go.kr'>지방행정연수원</option>
					<option value='http://lms.klid.or.kr'>한국지역정보개발원</option>
					<option value='http://www.bai-edu.go.kr'>감사교육원</option>
					<option value='http://taxstudy.nts.go.kr'>국세공무원교육원</option>
					<option value='http://www.fire.or.kr'>중앙소방학교</option>
					<option value='http://www.pca.go.kr'>경찰종합학교</option>
					<option value='http://www.lrti.go.kr'>법무연수원</option>
					<option value='http://www.icoti.go.kr'>지식경제공무원교육원</option>
					<option value='http://cyber.korail.go.kr'>Korail 인재개발원</option>
					<option value='http://www.ifans.go.kr'>외교안보연구원</option>
					<option value='http://www.fhi.go.kr'>산림인력개발원</option>
					<option value='http://www.e-academy.go.kr'>정부정보화교육센터</option>
					<option value='http://www.nier.go.kr'>국립환경과학원</option>
					<option value='http://www.nih.go.kr'>질병관리본부</option>
					<option>--------------------</option>
					<option>[ 지방자치단체 ]</option>
					<option>--------------------</option>
					<option value='http://hrd.seoul.go.kr'>서울특별시시인재개발원</option>
					<option value='http://hrd.busan.go.kr'>부산광역시인재개발원</option>
					<option value='http://www.daegu.go.kr/Loti/Default.aspx'>대구광역시공무원교육원</option>
					<option value='http://edu.gjcity.net/'>광주광역시지방공무원교육원</option>
					<option value='http://www.daejeon.go.kr/edu'>대전광역시공무원교육원</option>
					<option value='http://edu.gyeonggi.go.kr/'>경기도인재개발원</option>
					<option value='http://edu.provin.gangwon.kr/'>강원도인재개발원</option>
					<option value='http://loti.cb21.net/'>충청북도자치연수원</option>
					<option value='http://www.chungnam.net/content/busi/educ/index.jsp'>충청남도지방공무원교육원</option>
					<option value='http://loti.jeonbuk.go.kr/index.jsp'>전라북도지방공무원교육원</option>
					<option value='http://www.loti.jeonnam.kr'>전라남도지방공무원교육원</option>
					<option value='http://www.gboti.go.kr'>경상북도지방공무원교육원</option>
					<option value='http://loti.gsnd.net/'>경상남도지방공무원교육원</option>
					<option value='http://www.edu.jeju.kr'>제주특별자치도인력개발원</option>
					</select>
			</p>
		</div>
		<div id="site3" class="site_tab">
			<h2><a class="city" onmouseover="site_tab('site1');" onfocus="site_tab('site1');">시관련기관</a><a class="edu" onmouseover="site_tab('site2');" onfocus="site_tab('site2');">교육기관</a><a class="relat">유관기관</a></h2>
			<p>
				<select name="select3" id="select3" style="width:170px;" onChange='formHandler3(this.form)'>
					<option selected>시 산하 유관기관 홈페이지</option>
					<option value='http://www.iudc.co.kr'>인천도시개발공사</option>
					<option value='http://www.ice.go.kr'>인천시교육청</option>
					<option value='http://www.icpolice.go.kr/'>인천지방경찰청</option>
					<option value='http://incheon.dppo.go.kr'>인천지방검찰청</option>
					<option value='http://nd.icpolice.go.kr'>인천남동경찰서</option>
					<option value='http:/incheon.nmpa.go.kr'>인천해양경찰서</option>
					<option value='http://www.mma.go.kr/kor/l_suwon/index.html'>인천/경기지방병무청</option>
					<option value='http://ic.election.go.kr/'>인천선거관리위원회</option>
					<option value='http://inchon.nso.go.kr/'>인천통계사무소</option>
					<option value='http://www.icmc.or.kr'>인천의료원</option>
					<option value='http://www.ictr.or.kr'>인천교통공사</option>
					<option value='http://www.into.or.kr'>인천관광공사</option>
					<option value='http://www.insiseol.net'>인천시설관리공단</option>
					<option value='http://www.idi.re.kr'>인천발전연구원</option>
					<option value='http://www.irtc.co.kr'>인천메트로</option>
					<option value='http://www.portincheon.go.kr'>인천지방해양수산청</option>
					<option value='http://www.sarok.go.kr/'>인천지방조달청</option>
					<option value='http://www.airport.or.kr'>인천국제공항</option>
					<option value='http://www.iit.or.kr'>인천정보산업진흥원</option>
					<option value='http://www.step.or.kr/'>송도테크노파크</option>
					<option value='http://www.kah.or.kr/'>한국건강관리협회</option>
					<option value='http://www.fsc.go.kr/'>금융감독위원회</option>
					<option value='http://www.ppfk.or.kr/'>대한가족보건복지협회</option>
					<option value='http://www.icsinbo.or.kr/'>인천신용보증재단</option>
					<option value='http://www.ehhosp.com/'>시립노인치매요양병원</option>
					<option value='http://www.kgs.or.kr/'>한국가스안전공사</option>
					<option value='http://www.kemco.or.kr'>에너지관리공단</option>
					<option value='http://www.kesco.or.kr'>한국전기안전공사</option>
					<option value='http://www.incci.or.kr'>인천상공회의소</option>
					</select>
			</p>
		</div>
		
		
	</div>

	<div id="content_warp">
		<p class="schedule">
			<span class="tit">주간일정</span>
			<input type="text" class="inbox" size="32" title="scheduletxt" value="<%=weekListHtml %>" />
			<!-- //교육과정검색 -->
			<select  name="searchSelect" title="select"  onChange="selectNotice(value);">
				<option value="1" selected="selected">교육과정검색</option>
				<option value="2" >직원이름검색</option>
				<option value="3" >직원업무검색</option>
			</select>
			<input type="text" name="keyword" class="txt_search" size="22" title="searchtxt"   />
			<input type="button" class="btn_search" title="btn_search" alt="search" onClick="doSearch(document.pform.searchSelect.value)" />
		</p>

		<div id="content">
			<div id="board1" class="board_tab">
				<h2><a class="notice">공지사항</a><a class="setedu" onmouseover="board_tab('board2');" onfocus="board_tab('board2');">집합 교육</a><a class="cyberedu" onmouseover="board_tab('board3');" onfocus="board_tab('board3');">사이버 교육</a> </h2>
				<ul>
					<%=sbListHtml %>
				</ul>
			</div>
			<div id="board2" class="board_tab board_scroll">
				<h2><a class="notice" onmouseover="board_tab('board1');" onfocus="board_tab('board1');">공지사항</a><a class="setedu">집합 교육</a><a class="cyberedu" onmouseover="board_tab('board3');" onfocus="board_tab('board3');">사이버 교육</a> </h2>
				<div>
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
			</div>
			<div id="board3" class="board_tab board_scroll">
				<h2><a class="notice" onmouseover="board_tab('board1');" onfocus="board_tab('board1');">공지사항</a><a class="setedu" onmouseover="board_tab('board2');" onfocus="board_tab('board2');">집합 교육</a><a class="cyberedu">사이버 교육</a> </h2>
				<div>
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
			</div>
		

			<div class="month_tab">
				<div class="scrolling">
					<h2>
						<span>이달의 학습</span>
						<p id="month" class="tab1">
<%
							int month = Integer.parseInt(requestMap.getString("month"));
%>
							<a id="1" href="javascript:showMonthTab('1');" <%if(month==1){%>class="on"<%} %>>1월</a>
							<a id="2" href="javascript:showMonthTab('2');" <%if(month==2){%>class="on"<%} %>>2월</a>
							<a id="3" href="javascript:showMonthTab('3');" <%if(month==3){%>class="on"<%} %>>3월</a>
							<a id="4" href="javascript:showMonthTab('4');" <%if(month==4){%>class="on"<%} %>>4월</a>
							<a id="5" href="javascript:showMonthTab('5');" <%if(month==5){%>class="on"<%} %>>5월</a>
							<a id="6" href="javascript:showMonthTab('6');" <%if(month==6){%>class="on"<%} %>>6월</a>
							<a id="7" href="javascript:showMonthTab('7');" <%if(month==7){%>class="on"<%} %>>7월</a>
							<a id="8" href="javascript:showMonthTab('8');" <%if(month==8){%>class="on"<%} %>>8월</a>
							<a id="9" href="javascript:showMonthTab('9');" <%if(month==9){%>class="on"<%} %>>9월</a>
							<a id="10" href="javascript:showMonthTab('10');" <%if(month==10){%>class="on"<%} %>>10월</a>
							<a id="11" href="javascript:showMonthTab('11');" <%if(month==11){%>class="on"<%} %>>11월</a>
							<a id="12" href="javascript:showMonthTab('12');" <%if(month==12){%>class="on"<%} %>>12월</a>
						</p>
					</h2>
					<ul class="list" id="monthajax">
						<%= monthListHtml%>
						
					</ul>
				</div>
			</div>

					
			<div class="today_list">
				<h2>오늘의 한마디</h2>

				<div class="box">
					<dl>
						<iframe src="http://www.winglish.com/study/openfree/main/incheon_main_en.asp" width="100%" height="66" frameborder="0" scrolling="no" name="winen">윈글리쉬 데이타 불러오기</iframe>
					</dl>
					<dl>
						<iframe src="http://www.winglish.com/study/openfree/main/incheon_main_ch.asp" width="100%" height="66" frameborder="0" scrolling="no" name="winch">윈글리쉬 데이타 불러오기</iframe>
					</dl>
				</div>
			</div>
		</div>

		<div id="banner">
			<div class="banner3">
				<a href="javascript:fnGoMenu('7','eduinfo7-8');">인천인재개발원동영상소개</a>
			</div>
			<div class="goto_photolist">
				<h2><span class="photo">포토갤러리</span> <a href="/homepage/support.do?mode=webzine" class="more">more</a></h2>
				<%=photoListHtml %>

				<h2><span class="edu">교육원 명강의</span> <!-- <a href="" class="more">more</a> --></h2>
				<%=goodLectureListHtml%> 
			</div>
			<div class="banner1">
				<a href="http://www.incheon2014ag.org/">2014 인천아시아경기대회</a>
			</div>
			<div class="banner2">
				<a href="http://www.ifez.go.kr/">인천경제자유구역</a>
			</div>
			<div class="banner4">
				<a href="http://cleanwave.incheon.go.kr/icweb/html/web34/034.html">청렴한세상</a>
			</div>
			<!--
			<p class="banner">
				<h2><a href="http://152.99.42.138/" target="_blank"><img src="/images/<%= skinDir %>/main/banRt01.gif" alt="e-도서관" /></a></h2>
				<h2><a href="/homepage/support.do?mode=opencourse"><img src="/images/<%= skinDir %>/main/banRt02.gif" class="mt" alt="공개강의" /></a></h2>
				<h2><a href="http://logodi.go.kr/media.do?method=getList&gcd=S01&siteCmscd=CM0001&topCmscd=CM00058&cmscd=CM0278&pnum=7&cnum=5" target="_blank"><img src="/images/<%= skinDir %>/main/banRt03.gif" class="mt" alt="지방행정연수원 명강의코너" /></a></h2>
			</p>
			
			
			<p class="banner">
				<a href="http://www.incheon2014ag.org/">2014 인천아시아경기대회</a>
				<a href="http://www.ifez.go.kr/">인천경제자유구역</a>
				<a href="javascript:fnGoMenu('7','eduinfo7-8');">인천인재개발원동영상소개</a>
			</p>
			-->
		</div>
	</div>
</div>
</form>
<!--// container -->
<hr />

<!-- footer -->
<div id="footer">
	<p class="logo">인천광역시 인재개발원</p>

	<ul>
		<li class="fir"><a href="/homepage/introduce.do?mode=eduinfo7-7">오시는길(셔틀버스이용안내)</a></li>
		<li><a href="/homepage/index.do?mode=worktel">업무별연락처</a></li>
		<li><a href="/homepage/index.do?mode=policy">개인정보보호정책</a></li>
		<li class="end"><a href="/homepage/index.do?mode=spam">이메일 무단수집거부</a></li>
		<li class="add">404-190 인천광역시 서구 심곡로 98 (심곡동 307) / 교육안내 032)440-7650, 시설안내 032)440-7630 / FAX (032)562-0821 <br />홈페이지에 게시된 이메일주소가 자동 수집되는 것을 거부하며, 위반시 정보통신 관련법령에 의해 처벌됩니다.<br />Copyright@2007 인천광역시인재개발원, All rights Reserved. 이 사이트의 콘텐츠를 무단 사용할 수 없습니다.</li>
	</ul>

	<div class="logozone">
		<p class="fly">fly Incheon</p>
		<p class="gei">GEI</p>
	</div>
</div>
<!--// footer -->

</body>
</html>