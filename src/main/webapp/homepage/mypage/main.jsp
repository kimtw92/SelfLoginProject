<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%


// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

// 수강중인 전문 과정
DataMap CLMap = (DataMap)request.getAttribute("COURSE_LIST");
CLMap.setNullToInitialize(true);
//수강중인 소양취미 과정
DataMap CBasicMap = (DataMap)request.getAttribute("COURSE_BASIC_LIST");
CBasicMap.setNullToInitialize(true);
// 복습가능한 과정
DataMap RVMap = (DataMap)request.getAttribute("REVIEW_LIST");
RVMap.setNullToInitialize(true);
// 수강신청 처리중인 과정
DataMap AMap = (DataMap)request.getAttribute("APP_LIST");
AMap.setNullToInitialize(true);


StringBuffer clHtml = new StringBuffer();
StringBuffer basicHtml = new StringBuffer();
StringBuffer rvHtml = new StringBuffer();
StringBuffer aHtml = new StringBuffer();
int iNum = 0;
int jNum = 0;
int iBasicNum = 0;

basicHtml.append("");

if(CBasicMap.keySize("userno") > 0){
	for(int i=0; i < CBasicMap.keySize("userno"); i++){
		basicHtml.append("<tr>\n");
		basicHtml.append("<td class=\"bl0 sbj\"><a href=\"javascript:setSub('"+CBasicMap.getString("orgId",i)+"','"+CBasicMap.getString("grcode",i)+"','"+CBasicMap.getString("grseq",i)+"','"+i+"');\" ><img src='/images/"+skinDir +"/icon/icon_plus2.gif' alt='+' align=\"absmiddle\"></a>&nbsp;")
			.append("<a href=\"javascript:setView('"+CBasicMap.getString("grcode",i)+"','"+CBasicMap.getString("grseq",i)+"','"+CBasicMap.getString("grcodeniknm",i)+"','a');\" >"+CBasicMap.getString("grcodeniknm",i)+"("+CBasicMap.getString("grseqStr",i).substring(CBasicMap.getString("grseqStr",i).indexOf("-")+1,CBasicMap.getString("grseqStr",i).length())+"기)</a></td>\n");			
		// 수강기간
		basicHtml.append("<td>"+CBasicMap.getString("regdate",i)+"</td>\n");
				
		// 설문
		if(Util.getIntValue(CBasicMap.getString("pollCnt",i),0) > 0){
			basicHtml.append("<td><a href=\"javascript:onView('"+CBasicMap.getString("grcode",i)+"','"+CBasicMap.getString("grseq",i)+"','"+CBasicMap.getString("grcodeniknm",i)+"','SUB1000025','4');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a></td>\n");
		}else {
			basicHtml.append("<td></td>\n");
		}
		
		if(Util.getIntValue(CBasicMap.getString("notiCnt",i),0) > 0){
			basicHtml.append("<td><a href=\"javascript:onView('"+CBasicMap.getString("grcode",i)+"','"+CBasicMap.getString("grseq",i)+"','"+CBasicMap.getString("grcodeniknm",i)+"','SUB1000025','5');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a></td>\n");
		} else {
			basicHtml.append("<td></td>\n");
		}
		
		
		basicHtml.append("<td><a href=\"javascript:onView('"+CBasicMap.getString("grcode",i)+"','"+CBasicMap.getString("grseq",i)+"','"+CBasicMap.getString("grcodeniknm",i)+"','SUB1000025','7');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a></td>\n");
		
		basicHtml.append("</tr>  \n");
		
		basicHtml.append("<tr id=\"dis"+i+"\" style=\"display:none\">\n")
		.append("	<td class=\"bl0 H2out\" colspan=\"10\">\n")
		.append("		<table class=\"dataH02 head01\">\n") 
		.append("		<colgroup>\n")
		.append("			<col width=\"280\" />\n")
		.append("			<col width=\"130\" />\n")
		.append("			<col width=\"82\" />\n")
		.append("		</colgroup>\n")
		.append("		<thead>\n")
		.append("			<tr>\n")
		.append("				<th class=\"in\">과목명</th>\n")
		.append("				<th class=\"in\">수강기간</th>\n")
		.append("				<th class=\"in\">진도율</th>\n")
		.append("			</tr>\n")
		.append("		</thead>\n")
		.append("		<tbody id=\"show"+i+"\">\n")
		.append("		</tbody>\n")
		.append("		</table>\n")
		.append("	</td>\n");
		
		//사이버일 경우 OnLoad시 목록을 출력을 위한 Hidden 값
		basicHtml.append("<input type=\"hidden\" id=\"isCyber"+i+"\" name=\"isCyber"+i+"\" value="+CBasicMap.getString("fCyber", i)+">\n");
		basicHtml.append("<input type=\"hidden\" id=\"orgId"+i+"\" name=\"orgId"+i+"\" value="+CBasicMap.getString("orgId", i)+">\n");
		basicHtml.append("<input type=\"hidden\" id=\"grcode"+i+"\" name=\"grcode"+i+"\" value="+CBasicMap.getString("grcode", i)+">\n");
		basicHtml.append("<input type=\"hidden\" id=\"grseq"+i+"\" name=\"grseq"+i+"\" value="+CBasicMap.getString("grseq", i)+">\n");
		basicHtml.append("<input type=\"hidden\" id=\"idx"+i+"\" name=\"idx"+i+"\" value="+i+">\n");
		
		basicHtml.append("</tr>\n");
		
	iBasicNum ++;
	}
	
}else{
	basicHtml.append("<tr>\n");
	basicHtml.append("<td class=\"bl0\" colspan=\"5\" align=\"center\">수강중인 과정이 없습니다.</td>\n");			
	basicHtml.append("</tr>  \n");
}	//END if()




if(CLMap.keySize("userno") > 0){		

	for(int i=0; i < CLMap.keySize("userno"); i++){
		
		clHtml.append("<tr>\n");
		clHtml.append("<td class=\"bl0 sbj\"><a href=\"javascript:setSub('"+CLMap.getString("orgId",i)+"','"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+i+"');\" ><img src='/images/"+skinDir +"/icon/icon_plus2.gif' alt='+' align=\"absmiddle\"></a>&nbsp;")
			.append("<a href=\"javascript:setView('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+CLMap.getString("grcodeniknm",i)+"','a');\" >"+CLMap.getString("grcodeniknm",i)+"("+CLMap.getString("grseqStr",i).substring(CLMap.getString("grseqStr",i).indexOf("-")+1,CLMap.getString("grseqStr",i).length())+"기)</a></td>\n");			
		// 수강기간
		clHtml.append("<td>"+CLMap.getString("regdate",i)+"</td>\n");
		// 수강기간
		clHtml.append("<td>"+CLMap.getString("examTime",i)+"</td>\n");
		// 과제물
		if(Util.getIntValue(CLMap.getString("repCnt",i),0) > 0){
			clHtml.append("<td><a href=\"javascript:onView('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+CLMap.getString("grcodeniknm",i)+"','SUB1000025','1');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a></td>\n");
		} else {
			clHtml.append("<td></td>\n");
		}
		// 시간표
		clHtml.append("<td><a href=\"javascript:viewTimeTable('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+CLMap.getString("grcodeniknm",i)+" "+CLMap.getString("grseqStr",i).substring(CLMap.getString("grseqStr",i).indexOf("-")+1,CLMap.getString("grseqStr",i).length())+"기');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a></td>\n");
		// clHtml.append("<td></td>\n");
		// 평가
		//clHtml.append("<td><a href=\"javascript:onView('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+CLMap.getString("grcodeniknm",i)+"','SUB1000025','3');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a></td>\n");
		// 설문
		if (CLMap.getString("grcode",i).equals("10G0000417")){ // 5급직무역량강화 교육과정 일경우 평가...
			String testStr = CLMap.getString("regdate",i);
			//testStr = "03.30 ~ 04.01";
			String dateStartStr = "";
			String dateEndStr = "";
			dateStartStr = testStr.substring(0, 5);
			dateEndStr = testStr.substring(9, 13);
			SimpleDateFormat dateformat = new SimpleDateFormat("MM.dd");
			Date time = new Date();
			String timestr = dateformat.format(time);
			Date toDay = dateformat.parse(timestr);	// 오늘
			Date enddate = dateformat.parse(dateEndStr);	// 수강 종료일
			Date strdate = dateformat.parse(dateStartStr);	// 수강 시작일
						
			Calendar startcal = new GregorianCalendar(Locale.KOREA);
			startcal.setTime(strdate);
			startcal.add(Calendar.DATE, -8);
			String startStr = dateformat.format(startcal.getTime());// 수강시작 7일전
			Date startDate = startcal.getTime();
			
			Calendar startendcal = new GregorianCalendar(Locale.KOREA);
			startendcal.setTime(strdate);
			startendcal.add(Calendar.DATE, +1); 
			String startendstr = dateformat.format(startendcal.getTime());// 수강 시작 종료일
			Date startendDate = startendcal.getTime();

			String subj = "0";
			int start = toDay.compareTo(startDate);
			int end = toDay.compareTo(startendDate);
			int sub = enddate.compareTo(toDay);
			if(start > 0 && end < 0){
				// 수강 시작일 7일전부터 수강 시작 다음날까지.
				subj = "1";
				clHtml.append("<td><a href=\"javascript:onPollView('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+subj+"');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"설문\" /></a></td>\n");
			}else if (sub == 0) {
				subj = "2";
				clHtml.append("<td><a href=\"javascript:onPollView('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+subj+"');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"설문\" /></a></td>\n");
			}else{
				clHtml.append("<td></td>\n");
			}
			
			
		}else if (CLMap.getString("grcode",i).equals("10G0000381")){ // 4급 승진후보자 역량강화 일경우 평가...
			String testStr = CLMap.getString("regdate",i);
			//testStr = "03.30 ~ 04.01";
			String dateStartStr = "";
			String dateEndStr = "";
			dateStartStr = testStr.substring(0, 5);
			dateEndStr = testStr.substring(testStr.indexOf("~")+1, 13);
			SimpleDateFormat dateformat = new SimpleDateFormat("MM.dd");
			Date time = new Date();
			String timestr = dateformat.format(time);
			Date toDay = dateformat.parse(timestr);	// 오늘
			Date enddate = dateformat.parse(dateEndStr);	// 수강 종료일
			Date strdate = dateformat.parse(dateStartStr);	// 수강 시작일
						
			Calendar startcal = new GregorianCalendar(Locale.KOREA);
			startcal.setTime(strdate);
			startcal.add(Calendar.DATE, -7);
			String startStr = dateformat.format(startcal.getTime());// 수강시작 7일전
			Date startDate = startcal.getTime();
			
			Calendar startendcal = new GregorianCalendar(Locale.KOREA);
			startendcal.setTime(strdate);
			startendcal.add(Calendar.DATE, +1); 
			String startendstr = dateformat.format(startendcal.getTime());// 수강 시작 종료일
			Date startendDate = startendcal.getTime();

			String subj = "0";
			int start = toDay.compareTo(startDate);
			int end = toDay.compareTo(startendDate);
			int sub = enddate.compareTo(toDay);
			if(start > 0 && end < 0){
				// 수강 시작일 7일전부터 수강 시작 다음날까지.
				subj = "1";
				clHtml.append("<td><a href=\"javascript:onPoll4View('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+subj+"');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"설문\" /></a></td>\n");
			}else if (sub == 0) {
				subj = "2";
				clHtml.append("<td><a href=\"javascript:onPoll4View('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+subj+"');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"설문\" /></a></td>\n");
			}else{
				clHtml.append("<td></td>\n");
			}
			
			
		}else if(Util.getIntValue(CLMap.getString("pollCnt",i),0) > 0){
			clHtml.append("<td><a href=\"javascript:onView('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+CLMap.getString("grcodeniknm",i)+"','SUB1000025','4');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a></td>\n");
		}else {
			clHtml.append("<td></td>\n");
		}
		
		if(Util.getIntValue(CLMap.getString("notiCnt",i),0) > 0){
			clHtml.append("<td><a href=\"javascript:onView('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+CLMap.getString("grcodeniknm",i)+"','SUB1000025','5');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a></td>\n");
		} else {
			clHtml.append("<td></td>\n");
		}
		
		clHtml.append("<td><a href=\"javascript:onView('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+CLMap.getString("grcodeniknm",i)+"','SUB1000025','6');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a></td>\n");
		
		clHtml.append("<td><a href=\"javascript:onView('"+CLMap.getString("grcode",i)+"','"+CLMap.getString("grseq",i)+"','"+CLMap.getString("grcodeniknm",i)+"','SUB1000025','7');\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a></td>\n");
		
		clHtml.append("</tr>  \n");
		
		clHtml.append("<tr id=\"dis"+i+"\" style=\"display:none\">\n")
		.append("	<td class=\"bl0 H2out\" colspan=\"10\">\n")
		.append("		<table class=\"dataH02 head01\">\n") 
		.append("		<colgroup>\n")
		.append("			<col width=\"280\" />\n")
		.append("			<col width=\"130\" />\n")
		.append("			<col width=\"82\" />\n")
		.append("		</colgroup>\n")
		.append("		<thead>\n")
		.append("			<tr>\n")
		.append("				<th class=\"in\">과목명</th>\n")
		.append("				<th class=\"in\">수강기간</th>\n")
		.append("				<th class=\"in\">진도율</th>\n")
		.append("			</tr>\n")
		.append("		</thead>\n")
		.append("		<tbody id=\"show"+i+"\">\n")
		.append("		</tbody>\n")
		.append("		</table>\n")
		.append("	</td>\n");
		
		//사이버일 경우 OnLoad시 목록을 출력을 위한 Hidden 값
		clHtml.append("<input type=\"hidden\" id=\"isCyber"+i+"\" name=\"isCyber"+i+"\" value="+CLMap.getString("fCyber", i)+">\n");
		clHtml.append("<input type=\"hidden\" id=\"orgId"+i+"\" name=\"orgId"+i+"\" value="+CLMap.getString("orgId", i)+">\n");
		clHtml.append("<input type=\"hidden\" id=\"grcode"+i+"\" name=\"grcode"+i+"\" value="+CLMap.getString("grcode", i)+">\n");
		clHtml.append("<input type=\"hidden\" id=\"grseq"+i+"\" name=\"grseq"+i+"\" value="+CLMap.getString("grseq", i)+">\n");
		clHtml.append("<input type=\"hidden\" id=\"idx"+i+"\" name=\"idx"+i+"\" value="+i+">\n");
		
		clHtml.append("</tr>\n");
		
	iNum ++;
	
	}	//END for()
}else{
	clHtml.append("<tr>\n");
	clHtml.append("<td class=\"bl0\" colspan=\"9\" align=\"center\">수강중인 과정이 없습니다.</td>\n");			
	clHtml.append("</tr>  \n");
}	//END if()

if(RVMap.keySize("userno") > 0){		

	for(int i=0; i < RVMap.keySize("userno"); i++){
	if(RVMap.getString("grcodeniknm",i).replaceAll(" ","").indexOf("e-") == -1) {
		continue;
	}
		rvHtml.append("<tr>\n");
		rvHtml.append("<td class=\"bl0\"><a href=\"javascript:setView('"+RVMap.getString("grcode",i)+"','"+RVMap.getString("grseq",i)+"','"+RVMap.getString("grcodeniknm",i)+"','b');\">"+RVMap.getString("grcodeniknm",i)+"("+RVMap.getString("grseqStr",i)+")</a></td>\n");			
		rvHtml.append("<td>"+RVMap.getString("regdate",i)+"</td>\n");
		rvHtml.append("</tr>\n");
	}
				
}else{
	rvHtml.append("<tr>\n");
	rvHtml.append("<td class=\"bl0\" colspan=\"6\" align=\"center\">현재 복습가능한 과정이 없습니다.</td>\n");			
	rvHtml.append("</tr>  \n");
}

if(AMap.keySize("userno") > 0){		

	for(int i=0; i < AMap.keySize("userno"); i++){
		aHtml.append("<tr>\n");
		aHtml.append("	<td class=\"bl0 sbj\">"+AMap.getString("grcodeniknm",i)+"</td>\n");			
		aHtml.append("	<td>"+AMap.getString("grseqStr",i)+"</td>\n");
		aHtml.append("	<td>"+AMap.getString("appdate",i)+"</td>\n");
		aHtml.append("	<td>"+AMap.getString("deptchk",i)+"</td>\n");
		aHtml.append("	<td>"+AMap.getString("grchk",i)+"</td>\n");
		aHtml.append("	<td>-</td>\n");
		aHtml.append("	<td>"+AMap.getString("applyStatus",i)+"</td>\n");
		aHtml.append("</tr> \n");
		
		
	}
				
}else{
	aHtml.append("<tr>\n");
	aHtml.append("<td class=\"bl0\" colspan=\"7\" align=\"center\">신청중인 과정이 없습니다.</td>\n");			
	aHtml.append("</tr>  \n");
	
}
%>

<script language="JavaScript" type="text/JavaScript">
<!--

function replaceChoice(grcode,grseq,subj){
	PopWin(200,450,'/mypage/myclass.do?mode=selectSubLecture&grcode='+grcode+'&grseq='+grseq+'&subj='+subj);
}

function setNoitce(form){

	var url = "/mypage/myclass.do";
	pars = "mode=mainSubstring&kind="+form;
	// alert(pars);
	var divID = "myNotice";
	// alert("확인");
	var myAjax = new Ajax.Updater(
		{success: divID },
		url, 
		{
			method: "post", 
			parameters: pars,
			onLoading : function(){
				// $(document.body).startWaiting('bigWaiting');
			},
			onSuccess : function(){
				// window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
				// alert("데이타주세요");
			},
			onFailure : function(){					
				// window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
				alert("데이타를 가져오지 못했습니다.");
			}				
		}
	);
}

function go_move(grcode,grseq,subj,classno,lec_type){
	if(lec_type == "P"){ //선택과목선택창이 띄워짐
		PopWin(200,450,'/mypage/myclass.do?mode=selectSubLecture&grcode='+grcode+'&grseq='+grseq+'&subj='+subj);
		return;
	}else{  //강의실로 이동
		document.pform.grcode.value=grcode;
		document.pform.grseq.value=grseq;
		document.pform.subj.value=subj;
		document.pform.action="/mypage/myclass.do?mode=courseDetail&classno="+classno;
	    document.pform.submit();
	  }
	}



function setSub(orgId, grcode, grseq, divIdForm){
	
	var url = "/mypage/myclass.do";
	pars = "mode=subList&orgId="+orgId+"&grcode="+grcode+"&grseq="+grseq;
	// alert(pars);
	var divID = eval("show"+divIdForm);
	var iNum = <%=iNum%>;
	var find = "";

	for (var i=0;i<iNum;i++){
		// alert(eval("dis"+i).style.display);
		if (eval("dis"+i).style.display == "")
			find = i;
		eval("dis"+i).style.display = "none";
	}

	if (find != divIdForm){	

		var myAjax = new Ajax.Updater(
			{success: divID },
			url, 
			{
				method: "post", 
				parameters: pars,
				onLoading : function(){
					// $(document.body).startWaiting('bigWaiting');
				},
				onSuccess : function(){
					// window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					eval("dis"+divIdForm).style.display = "";
				},
				onFailure : function(){					
					// window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					alert("데이타를 가져오지 못했습니다.");
				}				
			}
		);
		
	}

}	

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	pform.action = "/mypage/paper.do";
	pform.submit();
}

//상세보기
function setView(form1, form2, form3, type){

	$("type").value = type;
	$("grcode").value = form1;
	$("grseq").value = form2;
	$("coursenm").value = form3;
	$("mode").value = "selectCourseList";
	pform.action = "/mypage/myclass.do";
	pform.submit();
}

function PopWin(he, wi, go_url){
	var optstr;
	optstr="height="+he+",width="+wi+",location=0,menubar=0,resizable=1,scrollbars=1,status=0,titlebar=0,toolbar=0,screeny=0,left=0,top=0";
	window.open(go_url, "study", optstr);
}

function viewTimeTable(grcode, grseq, subjnm){
	var url = "/mypage/timeReport.do?mode=list&searchKey=MORNING&commGrcode="+grcode+"&commGrseq="+grseq+"&subjnm="+encodeURIComponent(subjnm);
	PopWin(700,600,url);
}

//상세보기
function onView(grcode, grseq, grcodeniknm, subj, kind){

	$("grcode").value = grcode;
	$("grseq").value = grseq;
	$("coursenm").value = grcodeniknm;
	$("subj").value = subj;

	if (kind == "1"){
		$("mode").value = "selectReportList";
	} else if (kind == "2"){
		$("mode").value = "selectReportList";
	} else if (kind == "3"){
		$("mode").value = "testView";
	} else if (kind == "4"){
		$("mode").value = "pollList";
	} else if (kind == "5"){
		$("mode").value = "selectGrnoticeList";
	}else if (kind == "6"){
		$("mode").value = "sameClassView";
	}	else if (kind == "7"){
		$("mode").value = "courseInfoDetail";
	}	
	
	pform.action = "/mypage/myclass.do";
	pform.submit();
}

function onPollView(grcode, grseq, subj){
	var url = "/poll/capacityDiagnosisPoll.do?mode=view&grcode="+grcode+"&grseq="+grseq+"&banda="+subj;
	PopWin(500, 800, url);
}

function onPoll4View(grcode, grseq, subj){
	var url = "/poll/capacityDiagnosisPoll4.do?mode=view&grcode="+grcode+"&grseq="+grseq+"&banda="+subj;
	PopWin(500, 800, url);
}

function setForm(form){
	$("mode").value = form;
	$("viewNo").value = "";
	pform.action = "/mypage/paper.do";
	pform.submit();
}

function setDelAll(){
	
	$("mode").value = "delAll";
	$("rMode").value = "<%=requestMap.getString("mode")%>";
	pform.action = "/mypage/paper.do";
	pform.submit();
}

function init(){
	//setNoitce("notice");
	var iNum = <%=iNum%>;

	//사이버일 경우 OnLoad시 과목목록을 출력 한다.
	for(var i=0; i < iNum; i++) {
		if("Y" == eval("document.pform.isCyber"+i+".value")) {
			setSub('', eval("document.pform.grcode"+i+".value"), eval("document.pform.grseq"+i+".value"), eval("document.pform.idx"+i+".value"));
		}
	}
}
//-->
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
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    

<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left1.jsp" flush="true" ></jsp:include>
    
      </div>
    	<form id="pform" name="pform" method="post">
			<!-- 필수 -->
			<input type="hidden" name="type" 		id="type"		>
			<input type="hidden" name="mode" 		id="mode"		>
			<input type="hidden" name="coursenm" 	id="coursenm"	>
			<input type="hidden" name="grcode"		id="grcode"		>
			<input type="hidden" name="grseq"		id="grseq"		>
			<input type="hidden" name="subj"		id="subj"		>
			<input type="hidden" name="viewNo"		>
        <div id="contnets_area">
          <div class="sub_visual1">마이페이지</div>
            <div class="local">
              <h2>나의강의실</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; <span>나의강의실</span></div>
            </div>
            <div style="margin-top: -1px;" class="contnets">
            <!-- contnet -->
           <!--  <div id="content">

			공지사항,개인공지,나의질문
			<div class="myNotice" id="myNotice">
				
			</div> -->
			<!-- //공지사항,개인공지,나의질문 -->

			<!-- 나의 카페 
			<div class="myCafeSet">
				<div class="myCafeT">
					<h3><img src="/images/<%= skinDir %>/title/tit_mycafe.gif" alt="나의 카페" /></h3>
					<div class="cont">
						<ul>
							<li>제4기 교육카페</li>
							<li>인천광역시를 사랑하는 사람의 모임</li>
							<li>공무원을 사랑하는 사람의 모임</li>
						</ul>
					</div>
				</div>
			</div>
			 //나의 카페 -->
			<div class="space01"></div>
			
			<h3>공무원 e-러닝(전문)</h3>
			<a href="http://incheon.nhi.go.kr/"><font color="red"> 2019년부터 공무원 e-러닝(전문)은 인천시 나라배움터 사이트에서 학습가능 <br/>나라배움터 학습 사이트 바로가기 : incheon.nhi.go.kr</font></a>
			<br/><br/>
			
			
			<h3>수강중인 과정[전문교육]</h3>	
					<!--  ※ 사이버 과정을 <font color="red">95% 이상</font> 수강하신 분은 <font color="red">21일까지 과정평가와 과정설문을 완료</font>하셔야 합니다. <font color="blue">(21일 이후 일괄 이수처리)</font><br />
					※ 교육기간 중에만 학습이 가능하며, 1일 최대 학습분량은 <font color="blue">20차시 이상은 7차시, 20차시 미만은 5차시로 </font>제한합니다.<br />
					※ <b><font color="blue">학습관련 장애</font></b>(진도율 0%인 경우 등) 시  <b><font color="blue">「인터넷 환경설정 필수 조치사항」</font></b> 안내에 따라 조치하여 주시기 바랍니다.(<a href="http://hrd.incheon.go.kr/homepage/support.do?mode=faqView&fno=60" target="_blank"><b>조치방법 보기</b></a>)<br />
					※동영상 진도율 체크 관련 : <b><font color="blue">인터넷 익스플로러 웹브라우저</font></b>로 동영상 강의 수강해주시기 바랍니다.<br /> -->		
					<!--※ <font color="red"> 학습기간(매월 1일~21일)내 진도율 95% 이상, 과정평가 및 과정설문 완료 필수</font>(일괄 수료처리 후 매월23일경 수료<br />  결과통보)<br />-->
					
					※ <font color="red"> 진도율 올라가지 않는 등</font> 학습장애시  (<a href="http://hrd.incheon.go.kr/homepage/support.do?mode=faqView&fno=63" target="_blank"><font color="blue"><b>「학습관련 장애시 대처방법」</b></font></a>)안내 참고
					<!-- (<a href="http://hrd.incheon.go.kr/homepage/support.do?mode=faqView&info=54" target="_blank"><font color="blue"><b>「학습관련 장애시 대처방법」</b></font></a>) -->
					<!-- http://hrd.incheon.go.kr/homepage/support.do?mode=faqView&info=63 -->
			<!--div class="h2Set">
				<h2 class="h2L"><img src="/images/<%= skinDir %>/title/tit_processList.gif" alt="과정리스트" /></h2>
			</div>
			< div class="btnR">
				<img src="/images/<%= skinDir %>/button/btn_taster.gif" alt="맛보기" />
				<img src="/images/<%= skinDir %>/button/btn_request01.gif" alt="수강신청" />
				<img src="/images/<%= skinDir %>/button/btn_list01.gif" alt="리스트" />
			</div -->
			<div class="h9"></div>

			<!-- data -->
			<table class="bList01"> 
			<colgroup>
				<col width="180" />
				<col width="80" />
				<col width="75" />
				<col width="55" />
				<col width="50" />
				<col width="45" />
				<col width="45" />
				<col width="45" />
				<col width="50" />
				<col width="60" />
			</colgroup>

			<thead>
			<tr>
 
				<th class="bl0">과정명</th>
				<th>수강기간</th>
				<th>평가기간</th>
				<th>과제물</th>
				<th>시간표</th>
				<!-- <th>평가</th> -->
				<th>설문</th>
				<!-- <th><a href="javascript:onPoll4View('10G0000351','202001', '1');">설문</a></th> -->
				<th>공지</th>
				<th>주소록</th>
				<th>교육안내</th>
			</tr>
			</thead>

			<tbody>
			<%=clHtml.toString() %>  
			</tbody>
			</table>
			<!-- //data -->
			<div class="BtmLine"></div>
			<div class="space"></div>	

			<!-- //data -->
			<table class="dataH02"> 
			<colgroup>
			<col width="*" />
			<col width="125" />
			</colgroup>

			<!-- thead>
			<tr>
				<th class="bl0"><img src="/images/<%= skinDir %>/table/th_process.gif" alt="과정명" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_date09.gif" alt="학습기간" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_notice.gif" alt="공지" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_progress.gif" alt="진도율" /></th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td class="sbj bl0"><a href="">신예나의 감잡는 생활영어</a></td>
				<td>07.04.02~08.12.31</td>
				<td></td>
				<td class="no">100%</td>
			</tr>
			<tr>
				<td class="sbj bl0"><a href="">신예나의 감잡는 생활영어</a></td>
				<td>07.04.02~08.12.31</td>
				<td></td>
				<td class="no">100%</td>
			</tr>
			<tr>
				<td class="sbj bl0"><a href="">신예나의 감잡는 생활영어</a></td>
				<td>07.04.02~08.12.31</td>
				<td></td>
				<td class="no">100%</td>
			</tr>
			<tr>
				<td class="sbj bl0"><a href="">신예나의 감잡는 생활영어</a></td>
				<td>07.04.02~08.12.31</td>
				<td></td>
				<td class="no">100%</td>
			</tr>
			<tr>
				<td class="sbj bl0"><a href="">신예나의 감잡는 생활영어</a></td>
				<td>07.04.02~08.12.31</td>
				<td></td>
				<td class="no">100%</td>
			</tr>
			<tr>
				<td class="sbj bl0"><a href="">신예나의 감잡는 생활영어</a></td>
				<td>07.04.02~08.12.31</td>
				<td></td>
				<td class="no">100%</td>
			</tr>
			<tr>
				<td class="tail" colspan="4"></td>
			</tr>
			</tbody-->
			</table>
			
			
			
			<!-- //data -->
			<div class="space"></div>
			
			
			
			
			
			
			
			
<%-- 
			<h3>수강중인 과정[소양취미]</h3>
					
			<div class="h9"></div>

			<!-- data -->
			<table class="bList01"> 
			<colgroup>
				<col width="180" />
				<col width="80" />
				<col width="45" />
				<col width="45" />
				<col width="60" />
			</colgroup>

			<thead>
			<tr>
 
				<th class="bl0">과정명</th>
				<th>수강기간</th>
				<th>설문</th>
				<th>공지</th>
				<th>교육안내</th>
			</tr>
			</thead>

			<tbody>
			<%=basicHtml.toString() %>  
			</tbody>
			</table>
			<!-- //data -->
			<div class="BtmLine"></div>
			<div class="space"></div>	
			 --%>
			
			
			
			
			
			
			
			
			
			
			
			
			
			

			<h3>교육수료과정(복습 가능한 과정)</h3>	
			<div class="h9"></div>

			<!-- data -->
			<table class="bList01">	
			<colgroup>
				<col width="211" />
				<col width="*" />
			</colgroup>

			<thead>
			<tr>
				<th class="bl0"><img src="/images/<%= skinDir %>/table/th_process.gif" alt="과정명" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_eduCom01.gif" alt="교육수료후 90일간 복습가능" /></th>
			</tr>
			</thead>

			<tbody>
			<%=rvHtml.toString() %>
			</tbody>
			</table>
			<!-- //data -->
			<div class="BtmLine"></div>
			<div class="space"></div>	

			<h3>수강처리중인 과정</h3>	
			<div class="h9"></div>

			<!-- data -->
			<table class="bList01">	
			<colgroup>
				<col width="*" />
				<col width="60" />
				<col width="72" />
				<col width="72" />
				<col width="72" />
				<col width="87" />
				<col width="85" />
			</colgroup>

			<thead>
			<tr>
				<th class="bl0"><img src="/images/<%= skinDir %>/table/th_process.gif" alt="과정명" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_num.gif" alt="기수" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_date10.gif" alt="신청일" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_agree01.gif" alt="1차승인" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_agree02.gif" alt="2차승인" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_comp01.gif" alt="이전기수 수료여부" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_state.gif" alt="상태" /></th>
			</tr>
			</thead>

			<tbody>
			<%=aHtml.toString() %>
			</tbody>
			</table>
			<!-- //data -->
			<div class="BtmLine"></div>
			<div class="h80"></div>
		</div>
            <!-- //contnet -->
          </div>
        </div>
    
    </form>
    </div>


    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>