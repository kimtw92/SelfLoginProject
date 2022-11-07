<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// date	: 2008-08-26
// auth 	: 양정환
%>


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
	
	sbListHtml.append("<tr>");
	sbListHtml.append("<td class=\"spc\" style=\"\" colspan=\"3\"></td>");
	sbListHtml.append("</tr>");
	
	if(listMap.keySize("seq") > 0){		
		for(int i=0; i < listMap.keySize("seq"); i++){
			sbListHtml.append("<tr>");
			
			String title = listMap.getString("title", i);
			if(title.length() >= 34) {
				title = title.substring(0,33) + "...";
			}
			sbListHtml.append("	<td class=\"bl0 sbj\"><a href=\"/homepage/support.do?mode=noticeView&boardId=NOTICE&seq="+listMap.getString("seq", i)+"\">" + title + "</td>");
			sbListHtml.append("	<td>" + listMap.getString("regdate", i) +"</td>");
			sbListHtml.append("</tr>");
			
			if(i+1 != listMap.keySize("seq")) {
				sbListHtml.append("<tr>");
				sbListHtml.append("<td class=\"dotLine\" colspan=\"3\"></td>");
				sbListHtml.append("</tr>");	
			}
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
	
	if(monthlistMap.keySize("grcodeniknm") > 0){		
		for(int i=0; i < monthlistMap.keySize("grcodeniknm"); i++){
			if( i+1 != monthlistMap.keySize("grcodeniknm") ) {
				monthListHtml.append("<li>");					
			}else {
				monthListHtml.append("<li class=\"end\">");
			}
			
			String title = monthlistMap.getString("grcodeniknm", i);
			if(title.length() >= 31 )	title = title.substring(0, 30) + "...";
			
			monthListHtml.append("	<span><strong>[" + monthlistMap.getString("gubun", i) + "]</strong>&nbsp;<a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+monthlistMap.getString("grcode", i)+"&grseq="+monthlistMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")>"+ title +"</a></span>");
			monthListHtml.append("	<span class=\"date\">" + monthlistMap.getString("started", i) + "~"+monthlistMap.getString("enddate", i) +"</span>");
			monthListHtml.append("</li>");	
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
			goodLectureListHtml.append("	<dt>"+goodLectureListMap.getString("title",i)+"</dt> ");
			
			if(goodLectureListMap.getString("gubun",i).equals("1")) {
				goodLectureListHtml.append("	<dd><a href=\""+goodLectureListMap.getString("url",i)+"\"><img width=\"57\" height=\"52\" src=\"/pds"+goodLectureListMap.getString("filePath",i)+"\" /></a></dd> ");				
			}else if(goodLectureListMap.getString("gubun",i).equals("2")){
				goodLectureListHtml.append("	<dd><a href=javascript:popWin(\""+goodLectureListMap.getString("url",i)+ "\",\"aaa\",\"430\",\"440\",\"yes\",\"yes\")><img width=\"57\" height=\"52\" src=\"/pds"+goodLectureListMap.getString("filePath",i)+"\" /></a></dd> ");
			}
			
			
			goodLectureListHtml.append("	<dd class=\"cont\">["+goodLectureListMap.getString("ldate",i)+"]</dd> ");
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
			photoListHtml.append("<dt>"+photoListMap.getString("wcomments",i)+"</dt>");
			photoListHtml.append("<dd><a href=javascript:popWin(\"/homepage/index.do?mode=showpicture&path="+photoListMap.getString("imgPath",i)+"\",\"aaa\",\"900\",\"750\",\"yes\",\"yes\") ><img width=\"57\" height=\"52\" src=\"/pds"+photoListMap.getString("imgPath",i)+"\"/></a></dd>");
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
	
	if(grseqPlanListMap.keySize("rownum") > 0){
		for(int i=0; i < grseqPlanListMap.keySize("rownum"); i++){
			String strName = grseqPlanListMap.getString("grcodeniknm",i);
			if (strName.length() > 10){
				strName = grseqPlanListMap.getString("grcodeniknm",i).substring(0,10)+"..";
			}
			grseqPlanListHtml.append("<a href=javascript:popWin(\"/commonInc/fileDownload.do?mode=popup&groupfileNo="+grseqPlanListMap.getString("groupfileNo",i)+"\",\"aaa\",\"350\",\"280\",\"yes\",\"yes\") alt=\""+grseqPlanListMap.getString("grcodeniknm",i)+"\"><li>"+strName+"</li></a>");
		}
	}
%>


<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="main" />
</jsp:include>



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

function formHandler(form) {
	// 팝업창의 옵션을 지정할 수 있습니다
	var windowprops = "height=500,width=500,location=no,"
	+ "scrollbars=no,menubars=no,toolbars=no,resizable=yes";

	var URL = form.select2.options[form.select2.selectedIndex].value;
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
		selOpt1.innerHTML = strTable;
		//document.getElementById("linkimg1").src="/images/<%= skinDir %>/main/leftTab1_on.gif";
		//document.getElementById("linkimg2").src="/images/<%= skinDir %>/main/leftTab2.gif";
		//document.getElementById("linkimg3").src="/images/<%= skinDir %>/main/leftTab3.gif";		
	} else if(val == 2) {
		selOpt2.innerHTML = strTable2;
		//document.getElementById("linkimg1").src="/images/<%= skinDir %>/main/leftTab1.gif";
		//document.getElementById("linkimg2").src="/images/<%= skinDir %>/main/leftTab2_on.gif";
		//document.getElementById("linkimg3").src="/images/<%= skinDir %>/main/leftTab3.gif";
	} else {
		selOpt3.innerHTML = strTable3;
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

		if(month.length == 2 ) {
		
		}else{
			month = '0'+month;	
		}
	
		for(var i=1;i<=12;i++) {
			var a = document.getElementById('monthtab'+i);
			if(eval(month) == i) {
				a.src="/images/<%= skinDir %>/main/month"+i+"_on.gif";
			}else {
				a.src="/images/<%= skinDir %>/main/month"+i+".gif";
			}
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
	selectOpt(1);
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
	
	
	function move_winglish() {
		if(<%=loginInfo.isLogin()%> != false) {
			//alert("로그인 되었어용^^");
			location.href="/homepage/index.do?mode=gowinglish";
		}else {
			alert("로그인 후 사용하세요.");
		}
	}

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
-->
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onload="init();popup();" id="zoom">
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

<div id="wrapper">
	<!-- dvwhset s  ######################################## -->
	<div id="dvwhset">
		<div id="dvwh">
		
			<!--[s] header -->
			<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
				<jsp:param name="topMenu" value="main" />
			</jsp:include>
			<!--[e] header -->	

			<!-- dvmiddle s  ######################################## -->
			<div id="middle">
				<!-- mainLeft s ############ -->
				<div class="mainLeft">
				
					<!-- login -->
					<jsp:include page="/login/login.jsp" flush="false"/>					
					<!-- //login -->
					<div class="space01"></div>
					
		
					

					<!-- ID발급여부확인, pc원격접속, 사이버어학센터, 공개강좌 -->
					<div class="banLeft01">
						<ul>
							<li><a href="javascript:existidcheck();"><img src="/images/<%= skinDir %>/main/banLeft01.gif" alt="ID발급여부확인" /></a></li>
							<li><a href="javascript:popWin('http://152.99.42.151:81/','ccc','658','540','yes','yes')"><img src="/images/<%= skinDir %>/main/banLeft02.gif" alt="PC원격접속" /></a></li>
						
						</ul>
						<ul>
							<li><a href="javascript:move_winglish()"><img src="/images/<%= skinDir %>/main/banLeft03.gif" alt="사이버어학센터" /></a></li>
							<li><a href="/homepage/support.do?mode=opencourse"><img src="/images/<%= skinDir %>/main/banLeft04.gif" alt="공개강좌" /></a></li>
						</ul>
						
						<!-- 공개강좌 -->
						<div class="weeklyScd">
							<h3 style="margin: 20px 0 0 0;"><img src="/images/<%= skinDir %>/main/tit_freestudy.gif" alt="공개강좌" /></h3>
						</div>
						<!-- //공개강좌 -->
						
						
						<%if(loginInfo.isLogin()){%>
						<ul>
							<li><a href="/movieMgr/movieUse.do?mode=movList" target="_balnk" ><img src="/images/<%= skinDir %>/main/banLeft07.gif" alt="동영상강좌" /></a></li>
							
							<li><a href="javascript:goDongaBiz();"><img src="/images/<%= skinDir %>/main/banLeft08.gif" alt="" /></a></li>
						</ul>
						
						<%} else { %>
						<ul>
							<li><a href="javascript:alert('로그인후 이용하세요');"><img src="/images/<%= skinDir %>/main/banLeft07.gif" alt="동영상강좌" /></a></li>
							<li><a href="javascript:alert('로그인후 이용하세요');"><img src="/images/<%= skinDir %>/main/banLeft08.gif" alt="동아비지니스리뷰" /></a></li>
						</ul>
						<%} %>
					</div>
					<!-- //ID발급여부확인, pc원격접속, 사이버어학센터, 공개강좌 -->
					<div class="space01"></div>
					
					
			
					<!-- 주간일정 -->
					<div class="weeklyScd">
						<h3><img src="/images/<%= skinDir %>/main/tit_weeklyScd.gif" alt="주간일정" /></h3>
						<div class="schedule"><marquee scrolldelay="150"><%=weekListHtml %></marquee></div>
					</div>
					<!-- //주간일정 -->
					<div class="space01"></div>
					
					

					<!-- 전화문의, 학습문의 -->
					<div class="ques">			
						<div class="tab01">
							<ul>
								<li><img src="/images/<%= skinDir %>/main/quTab1_on.gif" alt="전화문의" /></li>
								<li><a href="/homepage/support.do?mode=requestList"><img src="/images/<%= skinDir %>/main/quTab2.gif" alt="학습문의" /></a></li>
							</ul>
						</div>
						<div class="more" ><a href="/homepage/support.do?mode=requestList"><img src="/images/<%= skinDir %>/main/icon_more.gif" alt="MORE" /></a></div>
						<div class="cont">
							<ul class="infoTel">
								<li>
									<span>교육일정 및 신청</span>
									<span class="tel">032)440-7655</span>
								</li>
								<li>
									<span>외국어 전문과정</span>
									<span class="tel">032)440-7653</span>
								</li>
								<li>
									<span>홈페이지,사이버교육</span>
									<span class="tel">032)440-7673</span>
								</li>
								<li>
									<span>강사 관련 문의</span>
									<span class="tel">032)440-7666</span>
								</li>
								<li>
									<span>핵심중견간부과정</span>
									<span class="tel">032)440-7662</span>
								</li>
								<li>
									<span>시설대여</span>
									<span class="tel">032)440-7632</span>
								</li>
								<li>
									<span>도서대출 및 열람실</span>
									<span class="tel">032)440-7743</span>
								</li>
								<li>
									<span>셔틀버스 운행</span>
									<span class="tel">032)440-7741</span>
								</li>
								<li>
									<span>기타 문의</span>
									<span class="tel">032)562-5814</span>
								</li>
							</ul>
						</div>
					</div>
					<!-- //전화문의, 학습문의 -->
					<div class="space01"></div>

					<!-- TAB 기관,교육,유관 -->
					
					<div class="leftTabSet">
						<ul class="tab">
							<li><a href="javascript:selectOpt(1)" onFocus="this.blur();"><img id="linkimg1" src="/images/<%= skinDir %>/main/leftTab1_on.gif" alt="기관" /></a></li>
							<li><a href="javascript:selectOpt(2)" onFocus="this.blur();"><img id="linkimg2" src="/images/<%= skinDir %>/main/leftTab2.gif" alt="교육" /></a></li>
							<li><a href="javascript:selectOpt(3)" onFocus="this.blur();"><img id="linkimg3" src="/images/<%= skinDir %>/main/leftTab3.gif" alt="유관" /></a></li>
						</ul>
						<div id="selOpt"></div>
					</div>
					
					<!-- //TAB 기관,교육,유관 -->
				</div>
				<!-- //mainLeft e ############ -->

				<!-- mainCenter s ############ -->
				<div class="mainCenter">
					<!-- 교육과정검색 -->
					
					<div class="mainSch">
						<select name="searchSelect" class="select01" onChange="selectNotice(value);">
						<option value="1" selected="selected">교육과정검색</option>
						<option value="2" >직원이름검색</option>
						<option value="3" >직원업무검색</option>
						<!-- <option value="4" >차시검색</option> -->
						</select>
						<input type="text" value=""  name="keyword" class="input01" />
						<img src="/images/<%= skinDir %>/button/btn_go.gif" alt="GO" onClick="doSearch(document.pform.searchSelect.value)"/>
					</div>
					
					<!-- //교육과정검색 -->
					<div class="space04"></div>

					<!-- 공지사항 -->
					<div id="maintab1" class="training" style="display:'';">			
						<div class="tab01">
							<ul style="">
								<li><a href="javascript:showTab(1);"><img src="/images/<%= skinDir %>/main/trTab1_on.gif" alt="공지사항" /></a></li>
								<li><a href="javascript:showTab(2);"><img src="/images/<%= skinDir %>/main/trTab2.gif" alt="집합교육" /></a></li>
								<li><a href="javascript:showTab(3);"><img src="/images/<%= skinDir %>/main/trTab3.gif" alt="사이버교육" /></a></li>
							</ul>
							<div class="more"><a href="/homepage/support.do?mode=noticeList"><img src="/images/<%= skinDir %>/main/icon_more.gif" alt="MORE" /></a></div>
						</div>
						
						<div class="cont">
							<table class="List01">
								<colgroup>
									<col width="*" />
									<col width="110" />
								</colgroup>
			
								<tbody>
								<%=sbListHtml %>
								</tbody>
							</table>
						</div>
					</div>
					<!-- //공지사항 -->

					<!-- //집합교육 -->
					<div id="maintab2" class="training" style="display:none; height:200px; overflow-x:hidden; overflow-y:scroll;">			
						<div class="tab01">
							<ul>
								<li><a href="javascript:showTab(1);"><img src="/images/<%= skinDir %>/main/trTab1.gif" alt="공지사항" /></a></li>
								<li><a href="javascript:showTab(2);"><img src="/images/<%= skinDir %>/main/trTab2_on.gif" alt="집합교육" /></a></li>
								<li><a href="javascript:showTab(3);"><img src="/images/<%= skinDir %>/main/trTab3.gif" alt="사이버교육" /></a></li>
							</ul>
							<!-- <div class="more"><a href="javascript:popWin('/homepage/index.do?mode=allnoncyber','ccc','603','680','yes','yes')"><img src="/images/<%//= skinDir %>/main/icon_more.gif" alt="MORE" /></a></div> -->
						</div>
			
						<div class="cont">
							<table class="List01">
								<colgroup>
									<!-- 
									<col width="*" />
									<col width="95" />
									<col width="33" />
									<col width="50" />
									<col width="65" />
									-->
									<col width="130" />
									<col width="55" />
									<col width="20" />
									<col width="43" />
									<col width="75" />
								</colgroup>
			
								<thead>
								<tr>
									<th class="bl0"><img src="/images/<%= skinDir %>/main/th_sbj01.gif" alt="과정명" /></th>
									<th><img src="/images/<%= skinDir %>/main/th_date01.gif" alt="신청기간" /></th>
									<th><img src="/images/<%= skinDir %>/main/th_no01.gif" alt="인원" /></th>
									<th><img src="/images/<%= skinDir %>/main/th_completion01.gif" alt="이수시간" /></th>
									<th><img src="/images/<%= skinDir %>/main/th_date02.gif" alt="교육기간" /></th>
								</tr>
								</thead>
			
								<tbody>
									<%= nonCyberListHtml %>
								</tbody>
							</table>
						</div>
					</div>
					<!-- 집합교육 -->

					<!-- 사이버교육 -->
					<div id="maintab3" class="training" style="display:none; height:200px; overflow-x:hidden; overflow-y:scroll;">			
						<div class="tab01">
							<ul>
								<li><a href="javascript:showTab(1);"><img src="/images/<%= skinDir %>/main/trTab1.gif" alt="공지사항" /></a></li>
								<li><a href="javascript:showTab(2);"><img src="/images/<%= skinDir %>/main/trTab2.gif" alt="집합교육" /></a></li>
								<li><a href="javascript:showTab(3);"><img src="/images/<%= skinDir %>/main/trTab3_on.gif" alt="사이버교육" /></a></li>
							</ul>
							<!-- <div class="more"><a href="javascript:popWin('/homepage/index.do?mode=allcyber','ccc','603','680','yes','yes')"><img src="/images/<%//= skinDir %>/main/icon_more.gif" alt="MORE" /></a></div> -->
						</div>
						
						<div class="cont">
							<table class="List01">
								<colgroup>
									<!-- 
									<col width="*" />
									<col width="95" />
									<col width="33" />
									<col width="50" />
									<col width="65" />
									-->
									
									<col width="130" />
									<col width="55" />
									<col width="20" />
									<col width="43" />
									<col width="75" />
								</colgroup>
			
								<thead>
								<tr>
									<th class="bl0"><img src="/images/<%= skinDir %>/main/th_sbj01.gif" alt="과정명" /></th>
									<th><img src="/images/<%= skinDir %>/main/th_date01.gif" alt="신청기간" /></th>
									<th><img src="/images/<%= skinDir %>/main/th_no01.gif" alt="인원" /></th>
									<th><img src="/images/<%= skinDir %>/main/th_completion01.gif" alt="이수시간" /></th>
									<th><img src="/images/<%= skinDir %>/main/th_date02.gif" alt="교육기간" /></th>
								</tr>
								</thead>
			
								<tbody>
									<%= cyberListHtml %>
								</tbody>
							</table>
						</div>
					</div>
					<!-- //사이버교육 -->
					<div class="space02"></div>

					<!-- 이달의교육 -->
					<div class="monthIn" style="height:200px; overflow-x:scroll; overflow-y:scroll;">
						<h3 style="width:70px;"><img src="/images/<%= skinDir %>/main/tit_monthTr.gif" alt="이달의 교육" /></h3>
						<div class="tab03">
							<ul>
								<%
									int month = Integer.parseInt(requestMap.getString("month"));
					
								%>
								
									<li><a href="javascript:showMonthTab('1');"><img id="monthtab1" src="/images/<%= skinDir %>/main/month1<%if(month==1){%>_on<%}%>.gif" alt="1월" /></a></li>
									<li><a href="javascript:showMonthTab('2');"><img id="monthtab2" src="/images/<%= skinDir %>/main/month2<%if(month==2){%>_on<%}%>.gif" alt="2월" /></a></li>
									<li><a href="javascript:showMonthTab('3');"><img id="monthtab3" src="/images/<%= skinDir %>/main/month3<%if(month==3){%>_on<%}%>.gif" alt="3월" /></a></li>
									<li><a href="javascript:showMonthTab('4');"><img id="monthtab4" src="/images/<%= skinDir %>/main/month4<%if(month==4){%>_on<%}%>.gif" alt="4월" /></a></li>
									<li><a href="javascript:showMonthTab('5');"><img id="monthtab5" src="/images/<%= skinDir %>/main/month5<%if(month==5){%>_on<%}%>.gif" alt="5월" /></a></li>
									<li><a href="javascript:showMonthTab('6');"><img id="monthtab6" src="/images/<%= skinDir %>/main/month6<%if(month==6){%>_on<%}%>.gif" alt="6월" /></a></li>
									<li><a href="javascript:showMonthTab('7');"><img id="monthtab7" src="/images/<%= skinDir %>/main/month7<%if(month==7){%>_on<%}%>.gif" alt="7월" /></a></li>
									<li><a href="javascript:showMonthTab('8');"><img id="monthtab8" src="/images/<%= skinDir %>/main/month8<%if(month==8){%>_on<%}%>.gif" alt="8월" /></a></li>
									<li><a href="javascript:showMonthTab('9');"><img id="monthtab9" src="/images/<%= skinDir %>/main/month9<%if(month==9){%>_on<%}%>.gif" alt="9월" /></a></li>
									<li><a href="javascript:showMonthTab('10');"><img id="monthtab10" src="/images/<%= skinDir %>/main/month10<%if(month==10){%>_on<%}%>.gif" alt="10월" /></a></li>
									<li><a href="javascript:showMonthTab('11');"><img id="monthtab11" src="/images/<%= skinDir %>/main/month11<%if(month==11){%>_on<%}%>.gif" alt="11월" /></a></li>
									<li><a href="javascript:showMonthTab('12');"><img id="monthtab12" src="/images/<%= skinDir %>/main/month12<%if(month==12){%>_on<%}%>.gif" alt="12월" /></a></li>
								
							</ul>
						</div>
						<div class="cont">
							<ul>
								<div id="monthajax">
									<%= monthListHtml%>
								</div>
								<li class="mBtn">
									<!-- <a href="/homepage/infomation.do?mode=eduinfo2-3"><img src="/images/<%//= skinDir %>/icon/btn_dtView.gif" alt="자세히 보기" /></a> -->	
								</li>
							</ul>
						</div>
					</div>
					<!-- //이달의교육 -->
					<div class="space02"></div>
			
					<!-- 오늘의한마디 -->
					<div class="todayTalk" title="오늘의 한마디">
						<!--이미지삭제하고 데이터 불러옵니다-->
						<div class="todayTalkL">	
											
						<iframe src="http://www.winglish.com/study/openfree/main/incheon_main_en.asp" width="100%" height="66" frameborder="0" scrolling="no" name="winen">윈글리쉬 데이타 불러오기</iframe>
						
						</div>
						<div class="todayTalkR">
						<iframe src="http://www.winglish.com/study/openfree/main/incheon_main_ch.asp" width="100%" height="66" frameborder="0" scrolling="no" name="winch">윈글리쉬 데이타 불러오기</iframe>
						</div>
						<!--//이미지삭제하고 데이터 불러옵니다-->
					</div>
					<!-- //오늘의한마디 -->
				</div>
				<!-- //mainCenter e ############ -->

				<!-- mainRight s ############ -->
				<div class="mainRight" style="float:left;">
		<!-- 포토앨범 -->
		<div class="photoGell">
			<h3><img src="/images/<%= skinDir %>/main/tit_photoGell.gif" alt="포토앨범" /></h3>
		<div class="moreR"><a href="/homepage/support.do?mode=webzine"><img src="/images/skin1/main/icon_smore.gif" alt="more" /></a></div>
			<div class="spc"></div>
				<%=photoListHtml %>
			<div class="spaceN"></div>
		</div>
		<!-- //포토앨범 -->
		<div class="space03"></div>

		<!-- 신규동기교지 
		<div class="photoGell">
			<h3><img src="/images/<%= skinDir %>/main/tit_newPa.gif" alt="신규동기교지" /></h3>
			<dl>
				<dt>07년 06기</dt>
				<dd><img src="/images/<%= skinDir %>/temp/img_newPa.jpg" alt="" /></dd>
				<dd class="cont">거침없이 6분임</dd>
			</dl>
		</div>
		 //신규동기교지 -->
		<!-- div class="space03"></div-->

		<!-- 해외연수보고서
		<div class="photoGell">
			<h3><img src="/images/<%= skinDir %>/main/tit_report.gif" alt="해외연수보고서" /></h3>
			<dl>
				<dt>07년 1기</dt>
				<dd><img src="/images/<%= skinDir %>/temp/img_report.jpg" alt="" /></dd>
				<dd class="cont">중국어과정<br>해외연수보고서</dd>
			</dl>
		</div>
		//해외연수보고서 -->
		<!-- div class="space03"></div-->

		<!-- 교육원명강의 -->
		<div class="fLecture">
			<h3><img src="/images/<%= skinDir %>/main/tit_fLecture.gif" alt="해외연수보고서" /></h3>
			<!--div class="icon">
				<a href=""><img src="/images/<%= skinDir %>/main/icon_prv01.gif" alt="이전" /></a>
				<a href=""><img src="/images/<%= skinDir %>/main/icon_nxt01.gif" alt="다음" /></a>
			</div-->
			<div class="spc"></div>

			<%=goodLectureListHtml%>

		</div>
		<!-- //교육원명강의 -->
		<div class="space03"></div>

		<!-- e도서관,공개강의 배너 -->
		<div class="banRight01">
			<ul>
				<li><a href="http://152.99.42.138/" target="_blank"><img src="/images/<%= skinDir %>/main/banRt01.gif" alt="e-도서관" /></a></li>
				<li><a href="/homepage/support.do?mode=opencourse"><img src="/images/<%= skinDir %>/main/banRt02.gif" class="mt" alt="공개강의" /></a></li>
				<li><a href="http://logodi.go.kr/media.do?method=getList&gcd=S01&siteCmscd=CM0001&topCmscd=CM00058&cmscd=CM0278&pnum=7&cnum=5" target="_blank"><img src="/images/<%= skinDir %>/main/banRt03.gif" class="mt" alt="지방행정연수원 명강의코너" /></a></li>
			</ul>
		</div>
		<!-- //도서관,공개강의 배너 -->
			
					<!-- 인천행사 및 배너 SET -->
					<div class="banset01">
						<ul class="ban01">
							<li><a id="banner_link_top" href="http://www.incheon2014ag.org/" target="_blank" onFocus="this.blur();"><img id="banner_top" src="/images/<%= skinDir %>/main/ban01.gif" alt="2014인천아시아경기대회" /></a></li>
							<li><a id="banner_link_bottom" href="http://www.ifez.go.kr/" target="_blank" onFocus="this.blur();"><img id="banner_bottom" src="/images/<%= skinDir %>/main/ban02.gif" alt="인천경제자유구역 IFEZ" /></a></li>
						</ul>
						<div class="icon01">
							<p class="frv"><img src="/images/<%= skinDir %>/main/icon_prv.gif" style="cursor:hand" alt="이전" /></p>
							<p class="nxt"><img src="/images/<%= skinDir %>/main/icon_nxt.gif" style="cursor:hand" alt="다음" /></p>
						</div>
					</div>
					<!-- //인천행사 및 배너 SET -->
					<!--img src="/images/<%= skinDir %>/temp/conten01.gif" alt="" /-->
					
				</div>
				<!-- //mainRight e ############ -->
			</div>
			<!-- dvmiddle e  ######################################## -->
		</div>

		<div id="divQuickMenu" style="position:absolute; top:10; left:89%; width:90px; height:264px; z-index:1">
			<!--[s] quick -->
			<!-- jsp:include page="/commonInc/include/comQuick.jsp" flush="false"/-->
			<!--[e] quick -->
		</div>
		
	</div>
<div class="space03"></div>

	<!--[s] footer -->
	<jsp:include page="/commonInc/include/comFoot.jsp" flush="false"/>
	<!--[e] footer -->
</div>

<script language="javascript">InitializeStaticMenu();</script>

</form>
</body>
<script>
<%// 이 스크립트  테스트  아니에요. 주석 닫지 말아주시길...양정환%>
	var divB=document.getElementById("test");
	var text="";
	text ='<%=grseqPlanListHtml%>';	

	divB.innerHTML=text;
	
</script>