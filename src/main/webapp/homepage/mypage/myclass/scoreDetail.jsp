<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%
//평가 없는 과정
String checkValue = "10C0000224,10C0000187,10G0000203,10C0000243,10C0000244,10C0000246,10C0000248,10C0000249,10C0000250,10C0000252,10C0000271,10C0000274,10C0000276,10C0000278,10C0000255,10C0000262,10C0000264,10C0000268,10C0000258,10C0000245,10C0000254,10C0000267,10C0000273,10C0000257,10C0000263,10C0000279,10C0000240,10C0000242,10C0000253,10C0000266,10C0000270,10C0000256,10C0000260,10C0000247,10C0000275,10C0000265,10C0000272,10C0000277,10C0000261,10C0000241,10C0000251,10C0000269,10C0000259,10C0000215,10C0000216"; // 평가 없는 과정
String checkJindo = "10C000021,10C0000216";

String type = (String)request.getAttribute("type");
// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

// 테스트 관련 내용
DataMap testMap = (DataMap)requestMap.get("cTest");
testMap.setNullToInitialize(true);

//과정기수 상세정보
DataMap grInfoMap = (DataMap)request.getAttribute("GRINFO_DATA");
grInfoMap.setNullToInitialize(true);

String passYn = (String)request.getAttribute("passYn");
String subj = (String)request.getAttribute("SUBJ_CODE");


StringBuffer htmlTest = new StringBuffer();
String testYN = "NO";
if(testMap.keySize("idExam") > 0 ){
	for(int i=0; testMap.keySize("idExam") > i; i++){
		htmlTest.append("<tr>\n")
			.append("	<td class=\"bl0 sbj\">"+testMap.getString("title",i)+"</td>\n")	
			.append("	<td>"+testMap.getString("examStart1",i)+"<br>~"+testMap.getString("examEnd1",i)+"</td>\n")
			.append("	<td>"+(Util.getIntValue(testMap.getString("limittime",i),0)/60)+"분</td>\n")
			.append("	<td>"+testMap.getString("allotting",i)+"</td>\n");
			if (testMap.getString("examState").equals("1")){
				htmlTest.append("	<td>시험종료</td>\n");
				testYN="YES";
			} else if (testMap.getString("examState").equals("2")){
				htmlTest.append("	<td><a href='javascript:location.reload()'>시험대기</a></td>\n");
			} else if (testMap.getString("examState").equals("3")){

				if("Y".equals(passYn)){
					htmlTest.append("	<td><a href=\"javascript:GoTest('"+testMap.getString("idExam",i)+"','"+testMap.getString("idExamKind",i)+"', '"+testMap.getString("tryNo",i)+"' )\"><img src=\"/images/skin1/button/btn_bu1.gif\" alt=\"미응시\" align=\"absmiddle\" /></a></td>\n");
				} else {
					htmlTest.append("<td><a href=\"javascript:alert('학습진도율이 95% 미만입니다. 학습 진도율을 95%이상 진행해주세요.')\"><img src=\"/images/skin1/button/btn_bu1.gif\" alt=\"미응시\" align=\"absmiddle\" /></a></td>");
				}

			} else if (testMap.getString("examState").equals("4")){

				if("Y".equals(passYn)){
					if (testMap.getInt("idExamKind",i) != 0 && testMap.getInt("idExamKind",i) != '1') {
						if (testMap.getString("rstep",i).equals("FALSE")){
							htmlTest.append("<td><a href=\"javascript:alert('과정진도율이 95%이상이어야만 시험응시가 가능합니다.')\"><img src=\"/images/skin1/button/btn_bu1.gif\" alt=\"미응시\" align=\"absmiddle\" /></a></td>");
						} else {
							htmlTest.append("<td><a href=\"javascript:GoTest('"+testMap.getString("idExam",i)+"','"+testMap.getString("idExamKind",i)+"', '"+testMap.getString("tryNo",i)+"' )\"><img src=\"/images/skin1/button/btn_bu1.gif\" alt=\"미응시\" align=\"absmiddle\" /></a></td>");
						}
					} else {
						htmlTest.append("	<td><a href=\"javascript:GoTest('"+testMap.getString("idExam",i)+"','"+testMap.getString("idExamKind",i)+"', '"+testMap.getString("tryNo",i)+"' )\"><img src=\"/images/skin1/button/btn_bu1.gif\" alt=\"미응시\" align=\"absmiddle\" /></a></td>\n");
					}
				} else {
					htmlTest.append("<td><a href=\"javascript:alert('학습진도율이 95% 미만입니다. 학습 진도율을 95%이상 진행해주세요.')\"><img src=\"/images/skin1/button/btn_bu1.gif\" alt=\"미응시\" align=\"absmiddle\" /></a></td>");
				}

			} else {
				 // 수시평가이면서, 60점미만이고, yn_open_sore_direct Y 인 경우 재응시하기 가능

				//$check_jumsu =0;
				//double check_jumsu = Util.getIntValue(testMap.getString("allotting"),0) * 0.6;
				double check_jumsu = 18;
				//if ( (!testMap.getString("id_exam_kind",i).equals("0") && !testMap.getString("id_exam_kind",i).equals("1") ) && (testMap.getString("yn_open_score_direct",i).equals("Y"))  && (testMap.getString("yn_end",i).equals("Y") && Util.getIntValue(testMap.getString("score",i),0) < check_jumsu ) && Util.getIntValue(testMap.getString("try_no",i),0) == 0 ) {
				//	htmlTest.append("	<td><a href=\"javascript:GoReTest('"+testMap.getString("id_exam",i)+"','"+testMap.getString("id_exam_kind",i)+"' , '"+testMap.getString("try_no",i)+"' )\" >미응시</a></td>");
				//} 
				if(Util.getDoubleValue(testMap.getString("score",i),0) < check_jumsu){
					//testMap.getString("tryNo",i)
					htmlTest.append("	<td><a href=\"javascript:GoReTest('"+testMap.getString("idExam",i)+"','"+testMap.getString("idExamKind",i)+"' , '"+testMap.getString("tryNo",i)+"' )\" >재응시</a></td>");
					testYN="YES";
				}else {
					htmlTest.append("	<td>응시완료</td>");
					testYN="YES";
				}
			}
			htmlTest.append("	<td><img onclick=\"AnsCheck('"+testMap.getString("idExam",i)+"')\" src=\"http://exam.hrd.incheon.go.kr/images/ynsubmit.gif\" border=\"0\" style='cursor:hand'></td>\n")
			.append("</tr>\n");
	}
}else{
	htmlTest.append("<tr>")
		.append("	<td colspan=\"6\"> 등록된 시험이 없습니다. </td>")
		.append("</tr>");
}

//시험점수 관련
DataMap scoreMap = (DataMap)requestMap.get("cScore");
scoreMap.setNullToInitialize(true);

StringBuffer htmlScore = new StringBuffer();

if(scoreMap.keySize("idExam") > 0 ){
	for(int i=0; scoreMap.keySize("idExam") > i; i++){
		
		htmlScore.append("<tr>\n")
			.append("<td class=\"bl0 sbj\">"+scoreMap.getString("title",i)+"</td>\n")
			.append("<td>");
		if (scoreMap.getString("ynOpenQa").equals("N")){
			htmlScore.append("성적비공개");
		} else if (!scoreMap.getString("statStart",i).equals("")){
			htmlScore.append(scoreMap.getString("statStart",i)+"~"+scoreMap.getString("statEnd",i));
		} else {
			htmlScore.append("기간설정 없음");
		}
		htmlScore.append("</td>\n")
			.append("<td><span class=\"txt_red\">"+scoreMap.getString("checkment",i)+"</span></td>\n")
			.append("<td>");

		if (scoreMap.getString("ynOpenQa",i).equals("N")){
			htmlScore.append("성적비공개");
		} else if (!scoreMap.getString("score").equals("")){
			htmlScore.append(scoreMap.getString("score",i)+"점");
		} else {
			htmlScore.append("<img src=\"/images/skin1/button/btn_bu1.gif\" alt=\"미응시\" align=\"absmiddle\" />");
		}
		htmlScore.append("</td>");
		htmlScore.append("<td>");
		
		if (scoreMap.getString("score",i).equals("")){
			htmlScore.append("<img src=\"/images/skin1/button/btn_bu1.gif\" alt=\"미응시\" align=\"absmiddle\" />");
		} else if (scoreMap.getString("ynOpenQa",i).equals("N")){
			htmlScore.append("비공개");
		} else if (scoreMap.getString("ynOpenQa",i).equals("D")){
			htmlScore.append("<a href=\"javascript:openQA('"+scoreMap.getString("examUnit",i)+"','"+scoreMap.getString("idSubject",i)+"','"+scoreMap.getString("idExam",i)+"')\"><img src=\"/images/"+ skinDir+"/button/btn_corrAnswr.gif\" alt=\"정답확인\" /></a>");
		} else if (!scoreMap.getString("statStart",i).equals("")){
			if (scoreMap.getString("daycheck",i).equals("Y")){
					htmlScore.append("<a href=\"javascript:openQA('"+scoreMap.getString("examUnit",i)+"','"+scoreMap.getString("idSubject",i)+"','"+scoreMap.getString("idExam",i)+"')\"><img src=\"/images/"+ skinDir+"/button/btn_corrAnswr.gif\" alt=\"정답확인\" /></a>");	
			} else{
				htmlScore.append("<a href=\"javascript:alert('정답 해설 및 조회 기간이 아닙니다.')\"><img src=\"/images/"+ skinDir+"/button/btn_corrAnswr.gif\" alt=\"정답확인\" /></a>");
			}
		} else {
			htmlScore.append("<a href=\"javascript:alert('정답 해설 및 조회 기간이 아닙니다.')\"><img src=\"/images/"+ skinDir+"/button/btn_corrAnswr.gif\" alt=\"정답확인\" /></a>");
		}
		htmlScore.append("</td>\n")
			.append("</tr>\n");
	}
}else{
	htmlScore.append("<tr>")
		.append("	<td colspan=\"5\"> 등록된 성적이 없습니다. </td>")
		.append("</tr>");
}

%>

<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	pform.action = "/mypage/myclass.do?mode=discussList";
	pform.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	pform.action = "/mypage/myclass.do?mode=discussList";
	pform.submit();
}
//리스트
function onView(form){
	$("qu").value = "discussView";
	pform.action = "/mypage/myclass.do?mode=discussView&seq="+form;
	pform.submit();
}
//글쓰기
function goWrite(){
	$("qu").value = "insertDiscuss";
	pform.action = "/mypage/myclass.do?mode=discussWrite";
	pform.submit();
}

// 재시험 처리 모듈
function GoReTest(idExam,  idExamKind, try_no){


	if(try_no > 2) {
		alert('이미 재 응시 하셨습니다.');
		return; 
	}
	
	if(answer = confirm("재응시하시겠습니까? 재응시 기회는 2번입니다.")){
		
	}else {
		return;
	}

	var url = "/mypage/myclass.do?mode=reExamTest";
	var pars = "idExam=" + idExam;
	pars += "&userId=<%=requestMap.getString("userno")%>";
	var userId = "<%=requestMap.getString("userno")%>";
	
	var myAjax = new Ajax.Request(
		url, 
		{
			method: "post", 
			parameters: pars,
			onSuccess : function(){
				//var pNum = eval(transport.responseText);
				//alert(pNum);
				var url = "http://exam.hrd.incheon.go.kr/paper/1fraTest.jsp?id_company=10034&id_exam="+idExam + "&userid="+userId+"&id_exam_kind="+idExamKind+"&try_no="+(try_no+1);
				window.open(url, "exampaper", "fullscreen=yes, scrollbars=yes");
			},
			onFailure : function(){					
				alert("데이타를 가져오지 못했습니다.");
			}				
		}
	);
	
}


//-->
</script>
<script language="javascript" src="http://exam.hrd.incheon.go.kr/js/PopWindowModal.js"></script>
<script language="JavaScript">
<!--
	function GoTest(id_exam, id_exam_kind, try_no)
	{
		var url = "http://exam.hrd.incheon.go.kr/paper/1fraTest.jsp?id_company=10034&id_exam="+id_exam+"&userid=<%=requestMap.getString("userno")%>&id_exam_kind="+id_exam_kind+"&try_no="+try_no;
		window.open(url, "exampaper", "fullscreen=yes, scrollbars=yes");
		// window.open(url, "exampaper", "fullscreen=no, scrollbars=yes, status=yes, top=0, left=0, width=1000, height=670");
	}


	function AnsCheck(id_exam)
	{
		var url = "http://exam.hrd.incheon.go.kr/exam/ansCheck.jsp?id_company=10034&id_exam="+id_exam+"&userid=<%=requestMap.getString("userno")%>";
		var retVal = PopModal(url, "", 300, 175);
	}

	function openQA(exam_unit, id_subject, id_exam)
	{
		if(<%=testYN.equals("NO")%>) {
			alert("시험 응시중에는 정답을 확인할 수 없습니다.");
			return;
		}
		var url = "http://exam.hrd.incheon.go.kr/score/qa.jsp?id_company=10034&userid=<%=requestMap.getString("userno")%>&id_exam=" + id_exam + "&id_subject=" + id_subject + "&exam_unit=" + exam_unit;
		PopWindowM(url);
	}
//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left1.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual1.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>나의강의실</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; <span>나의강의실</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<div style="margin:1px;">					<!-- ※ 사이버 과정을 <font color="red">95% 이상</font> 수강하신 분은 <font color="red">21일까지 과정평가와 과정설문을 완료</font>하셔야 합니다. <font color="blue">(21일 이후 일괄 이수처리)</font><br />
					※ 교육기간 중에만 학습이 가능하며, 1일 최대 학습분량은 <font color="blue">20차시 이상은 7차시, 20차시 미만은 5차시로 </font>제한합니다.<br />
					※ <b><font color="blue">학습관련 장애</font></b>(진도율 0%인 경우 등) 시  <b><font color="blue">「인터넷 환경설정 필수 조치사항」</font></b> 안내에 따라 조치하여 주시기 바랍니다.(<a href="http://hrd.incheon.go.kr/homepage/support.do?mode=faqView&fno=60" target="_blank"><b>조치방법 보기</b></a>)<br /></div> -->
					※ <font color="red"> 학습기간(매월 1일~21일)내 진도율 95% 이상, 과정평가 및 과정설문 완료 필수</font>(일괄 수료처리 후 매월23일경 수료<br />  결과통보)<br />
					※ <font color="red"> 진도율 올라가지 않는 등</font> 학습장애시  (<a href="http://hrd.incheon.go.kr/homepage/support.do?mode=faqView&fno=63" target="_blank"><font color="blue"><b>「학습관련 장애시 대처방법」</b></font></a>)안내 참고
			</div>		
            <div class="mytab01">
              <ul>
                <li><a href="/mypage/myclass.do?mode=selectCourseList&type=<%=type%>"><img src="/homepage_new/images/M1/tab01.gif" alt="과정리스트"/></a></li>
                <li><a href="/mypage/myclass.do?mode=selectGrnoticeList&type=<%=type%>"><img src="/homepage_new/images/M1/tab02.gif" alt="과정공지"/></a></li>
                <li><a href="/mypage/myclass.do?mode=pollList&type=<%=type%>"><img src="/homepage_new/images/M1/tab03.gif" alt="과정설문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=testView&type=<%=type%>"><img src="/homepage_new/images/M1/tab04_on.gif" alt="과정평가"/></a></li>
                <li><a href="/mypage/myclass.do?mode=discussList&type=<%=type%>"><img src="/homepage_new/images/M1/tab05.gif" alt="과정토론방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=suggestionList&type=<%=type%>"><img src="/homepage_new/images/M1/tab06.gif" alt="과정질문방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=courseInfoDetail&type=<%=type%>"><img src="/homepage_new/images/M1/tab07.gif" alt="교과안내문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=sameClassList&type=<%=type%>"><img src="/homepage_new/images/M1/tab08.gif" alt="동기모임"/></a></li>
              </ul>
              </div>
              
              <form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden"  name="qu" >
<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
				<div id="content">
						<div class="h15"></div>
			
						<!-- title --> 
						<h3 class="h3Ltxt"> <%= grInfoMap.getString("grcodenm") %> </h3>
						<!-- //title -->
						<div class="h15"></div>
						
						
						<%-- <%  if (grInfoMap.getString("grcode").equals("10C0000224") || grInfoMap.getString("grcode").equals("10C0000187") || grInfoMap.getString("grcode").equals("10G0000203"))  { %> --%>
						
						<% if (checkValue.indexOf(grInfoMap.getString("grcode")) != -1) { %>
						
						<div class="point_box">
						<p class="box_img"><span><img src="/homepage_new/images/common/box_point.gif" alt=""></span></p>
						<div class="list">
						<font size="3px">
							  [<%=grInfoMap.getString("grcodenm") %>] </font><font size="4px">과정은 <font color=red><b> 과정평가가 없습니다.</b></font> <p/><br/><p/>
							<% if(checkJindo.indexOf(grInfoMap.getString("grcode")) != -1){ %>
							<font color=red><b>학습 진도율 100%만 완료 </b></font> 하시면 수료 처리됩니다.
							<% }else{ %>
							<font color=red><b>학습 진도율 100% 및 과정 설문만 완료 </b></font> 하시면 수료 처리됩니다.
							<% } %>
							</font> 
							<p/><br/>
						</div>
						</div>
						<div class="h15"></div>
						
						<% } else { %>
			
						<!-- title --> 
						<h4 class="h4Ltxt">시험응시 [<font color="blue">30점 만점에 18점이상 수료입니다.</font>]</h4>
						<!-- //title -->
						<div class="h9"></div>
			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="*" />
							<col width="110" />
							<col width="110" />
							<col width="74" />
							<col width="74" />
							<col width="74" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_sbj04.gif" alt="시험명" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_date07.gif" alt="시험일자" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_time04.gif" alt="시험시간(분)" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_fullMk.gif" alt="만점점수" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_examinatn.gif" alt="시험응시" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_submit.gif" alt="제출확인" /></th>
						</tr>
						</thead>
			
						<tbody>
						<%=htmlTest.toString() %>

						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>
						<div class="space"></div>
			
						<!-- title --> 
						<h4 class="h4Ltxt">성적확인</h4>
						<!-- //title -->
						<div class="h9"></div>
			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="*" />
							<col width="110" />
							<col width="110" />
							<col width="74" />
							<col width="74" />
							<col width="74" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_sbj04.gif" alt="시험명" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_schDate01.gif" alt="성적조회일자" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_stdrd.gif" alt="이수기준점수" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_myMk.gif" alt="본인점수" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_corrAnswr.gif" alt="정답 및 해설" /></th>
						</tr>
						</thead>
			
						<tbody>
						<%=htmlScore.toString() %>
						<!--데이터 없을 경우--tr>
							<td class="bl0" colspan="5">등록된 시험이 없습니다.</td>
						</tr-->
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>
			
						<!-- button 
						<div class="btnRbtt">			
							<img src="/images/<%=skinDir %>/button/btn_write01.gif" alt="글쓰기" />
						</div>
						//button -->
			
						<div class="space"></div>						
						<% } %>
						
					</div>

</form>
            <!-- //contnet -->


          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>