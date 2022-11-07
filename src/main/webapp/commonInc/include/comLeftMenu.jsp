<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commonInc/include/comInclude.jsp" %>

<%
	
	String leftMenu = request.getParameter("leftMenu");
	if (leftMenu == null) leftMenu = "1";
	String leftIndex = request.getParameter("leftIndex");
	if (leftIndex == null) leftIndex = "1";
	String leftSubIndex = request.getParameter("leftSubIndex");
	if (leftSubIndex == null) leftSubIndex = "1";
	// 세션 값 가져오기
	
	//out.println("leftMenu="+leftMenu);
	//out.println("leftIndex="+leftIndex);
	// out.println((String)session.getAttribute("sess_grcode")+","+(String)session.getAttribute("sess_grseq")); 
%>

<script>


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
		strTable += "<option value='http://seunggi.incheon.go.kr'>승기수질환경사업소</option>";
		strTable += "<option value='http://www.incheonlib.or.kr'>인천시립도서관</option>";
		strTable += "<option value='http://museum.incheon.go.kr'>인천시립박물관</option>";
		strTable += "<option value='http://work.incheon.go.kr'>근로청소년복지회관</option>";
		strTable += "<option value='http://youth.incheon.go.kr'>청소년회관</option>";
		strTable += "<option value='http://car.incheon.go.kr'>차량등록사업소</option>";
		strTable += "<option value='http://www.wolmipark.net'>서부공원사업소</option>";
		strTable += "<option value='http://songlim.incheon.go.kr'>송림위생환경사업소</option>";
		strTable += "<option value='http://yuldo.incheon.go.kr'>율도위생환경사업소</option>";
		strTable += "<option value='http://green.incheon.go.kr'>녹지관리사업소</option>";
		strTable += "<option value='http://guwol-market.incheon.go.kr'>구월농축산물도매시장</option>";
		strTable += "<option value='http://samsan-market.incheon.go.kr'>삼산농산물도매시장</option>";
		strTable += "<option value='http://i-youth.incheon.go.kr'>청소년수련관</option>";
		strTable += "</select>";

	var strTable2 ="<select name='select2' class='select01' onChange='formHandler(this.form)'>";
		strTable2 += "<option>교육관련기관</option>";
		strTable2 += "<option>--------------------</option>";
		strTable2 += "<option>--------------------</option>";
		strTable2 += "<option value='http://www.coti.go.kr'>중앙공무원교육원</option>";
		strTable2 += "<option value='http://www.logodi.go.kr'>지방혁신인력개발원</option>";
		strTable2 += "<option value='http://www.e-academy.go.kr'>정보화능력개발센터</option>";
		strTable2 += "<option value='http://www.nier.go.kr'>국립환경연구원</option>";
		strTable2 += "<option value='http://www.nih.go.kr'>국립보건원</option>";
		strTable2 += "<option>--------------------</option>";
		strTable2 += "<option value='http://edu.seoul.go.kr'>서울특별시시인재개발원</option>";
		strTable2 += "<option value='http://edu.metro.busan.kr'>부산광역시공무원교육원</option>";
		strTable2 += "<option value='http://www.daegu.go.kr/Loti/Default.aspx'>대구광역시인재개발원</option>";
		strTable2 += "<option value='http://edu.gjcity.net/'>광주시공무원교육원</option>";
		strTable2 += "<option value='http://edu.daejeon.go.kr'>대전광역시공무원교육원</option>";
		strTable2 += "<option value='http://edu.gyeonggi.go.kr/'>경기도공무원교육원</option>";
		strTable2 += "<option value='http://edu.provin.gangwon.kr/'>강원도공무원교육원</option>";
		strTable2 += "<option value='http://loti.cb21.net/'>충청북도자치연수원</option>";
		strTable2 += "<option value='http://cyber.chungnam.net/index.html'>충청남도공무원교육원</option>";
		strTable2 += "<option value='http://loti.jeonbuk.go.kr/index.jsp'>전라북도공무원교육원</option>";
		strTable2 += "<option value='http://www.loti.jeonnam.kr'>전라남도공무원교육원</option>";
		strTable2 += "<option value='http://www.gboti.go.kr'>경상북도공무원교육원</option>";
		strTable2 += "<option value='http://loti.gsnd.net/'>경상남도공무원교육원</option>";
		strTable2 += "<option value='http://www.edu.jeju.kr/2007/default.asp'>제주특별자치도인력개발원</option>";
		strTable2 += "</select>";

	var strTable3	="<select name='select2' class='select01' onChange='formHandler(this.form)'>";
		strTable3	+= "<option selected>시 산하 유관기관 홈페이지</option>";
		strTable3 += "<option value='http://www.iudc.co.kr'>인천도시개발공사</option>";
		strTable3 += "<option value='http://www.ice.go.kr'>인천시교육청</option>";
		strTable3 += "<option value='http://www.icpolice.go.kr/'>인천지방경찰청</option>";
		strTable3 += "<option value='http://incheon.dppo.go.kr'>인천지방검찰청</option>";
		strTable3 += "<option value='http://nd.icpolice.go.kr'>인천남동경찰서</option>";
		strTable3 += "<option value='http:/incheon.nmpa.go.kr'>인천해양경찰서</option>";
		strTable3 += "<option value='http://www.mma.go.kr/doc/p_navi1100004.html'>인천/경기병무청</option>";
		strTable3 += "<option value='http://ic.election.go.kr/'>인천선거관리위원회</option>";
		strTable3 += "<option value='http://inchon.nso.go.kr/'>인천통계사무소</option>";
		strTable3 += "<option value='http://www.icmc.or.kr'>인천의료원</option>";
		strTable3 += "<option value='http://www.icter.co.kr'>인천종합터미널</option>";
		strTable3 += "<option value='http://www.insiseol.net'>인천시설관리공단</option>";
		strTable3 += "<option value='http://www.sanrimjohab.co.kr/index_main.html'>인천산림조합</option>";
		strTable3 += "<option value='http://www.idi.re.kr'>인천발전연구원</option>";
		strTable3 += "<option value='http://www.irtc.co.kr'>인천지하철공사</option>";
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
		selOpt.innerHTML = strTable;
		document.getElementById("linkimg1").src="/images/<%= skinDir %>/main/leftTab1_on.gif";
		document.getElementById("linkimg2").src="/images/<%= skinDir %>/main/leftTab2.gif";
		document.getElementById("linkimg3").src="/images/<%= skinDir %>/main/leftTab3.gif";		
	} else if(val == 2) {
		selOpt.innerHTML = strTable2;
		document.getElementById("linkimg1").src="/images/<%= skinDir %>/main/leftTab1.gif";
		document.getElementById("linkimg2").src="/images/<%= skinDir %>/main/leftTab2_on.gif";
		document.getElementById("linkimg3").src="/images/<%= skinDir %>/main/leftTab3.gif";
	} else {
		selOpt.innerHTML = strTable3;
		document.getElementById("linkimg1").src="/images/<%= skinDir %>/main/leftTab1.gif";
		document.getElementById("linkimg2").src="/images/<%= skinDir %>/main/leftTab2.gif";
		document.getElementById("linkimg3").src="/images/<%= skinDir %>/main/leftTab3_on.gif";
	}
}


</script>

<div id="subLeft">
	<!-- login -->
	<jsp:include page="/login/login.jsp" flush="false"/>
	<!-- //login -->
	<div class="spaceL"></div>

	<!-- leftMenu -->
	<div id="leftMenuSet01">
<%
	if(leftMenu.equals("1")){
		// 교육안내
%>
		<h1 class="tit"><img src="/images/skin1/menu/leftMu_tit1.gif" alt="교육안내" /></h1>
		<ul class="dth1">
		    <li><a href="javascript:fnGoMenu(2,'eduinfo2-1');" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg11','','/images/skin1/menu/leftMu_1d11_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d11<%= leftIndex.equals("1") ? "_on":"" %>.gif" id="leftImg11" alt="입교안내" /></a></li>    
		    <li><a href="javascript:fnGoMenu(2,'eduinfo2-2');" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg12','','/images/skin1/menu/leftMu_1d12_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d12<%= leftIndex.equals("2") ? "_on":"" %>.gif" id="leftImg12" alt="교육훈련체계" /></a></li>    
		    <li class="endM"><a href="javascript:fnGoMenu(2,'eduinfo2-4');" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg13','','/images/skin1/menu/leftMu_1d13_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d13<%= leftIndex.equals("3") ? "_on":"" %>.gif" id="leftImg13" alt="교육현황" /></a>
		       <%//if(leftIndex.equals("3")){ %>
				<!-- ul class="dth2">
		            <li><a href="javascript:fnGoMenu(2,'eduinfo2-3');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg14','','/images/skin1/menu/leftMu_1d14_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d14<%= leftSubIndex.equals("1") ? "_on":"" %>.gif" id="leftImg14" alt="연간교육일정" /></a></li>
					<li><a href="javascript:fnGoMenu(2,'eduinfo2-4');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg15','','/images/skin1/menu/leftMu_1d15_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d15<%= leftSubIndex.equals("2") ? "_on":"" %>.gif" id="leftImg15" alt="교육실적" /></a></li>
		        </ul-->
				<%//} %>
			</li>
		</ul>
<%
	}else if(leftMenu.equals("2")){
		// 교육과정
%>
		<h1 class="tit"><img src="/images/skin1/menu/leftMu_tit2.gif" alt="교육과정" /></h1>
		<ul class="dth1">
			<li><a href="javascript:fnGoMenu(2,'eduinfo2-3');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('1leftImg20','','/images/skin1/menu/leftMu_1d20_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d20<%= leftIndex.equals("1") ? "_on":"" %>.gif" id="1leftImg20" alt="연간교육일정" /></a></li>
		    <li><a href="javascript:fnGoMenu(3,'eduinfo3-1');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('1leftImg21','','/images/skin1/menu/leftMu_1d21_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d21<%= leftIndex.equals("2") ? "_on":"" %>.gif" id="1leftImg21" alt="기본교육" /></a></li>    
		    <li><a href="javascript:fnGoMenu(3,'eduinfo3-3');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('1leftImg23','','/images/skin1/menu/leftMu_1d23_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d23<%= leftIndex.equals("3") ? "_on":"" %>.gif" id="1leftImg23" alt="전문교육" /></a></li> 
			<%if(leftIndex.equals("3")){ %>
				<ul class="dth2">
		            <li><a href="javascript:fnGoMenu(3,'eduinfo3-3');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg888','','/images/skin1/menu/leftMu_1d255_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d255<%= leftSubIndex.equals("1") ? "_on":"" %>.gif" id="leftImg888" alt="집합교육" /></a></li>
					<li><a href="javascript:fnGoMenu(3,'eduinfo3-4');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg889','','/images/skin1/menu/leftMu_1d256_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d256<%= leftSubIndex.equals("2") ? "_on":"" %>.gif" id="leftImg889" alt="사이버교육" /></a></li>
		        </ul>
			<%} %>	   
		    <li class="endM"><a href="javascript:fnGoMenu(3,'eduinfo3-2');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('1leftImg25','','/images/skin1/menu/leftMu_1d25_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d25<%= leftIndex.equals("4") ? "_on":"" %>.gif" id="1leftImg25" alt="기타교육" /></a>
			<%if(leftIndex.equals("4")){ %>
				<ul class="dth2">
		            <li><a href="javascript:fnGoMenu(3,'eduinfo3-2');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg751','','/images/skin1/menu/leftMu_1d251_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d251<%= leftSubIndex.equals("1") ? "_on":"" %>.gif" id="leftImg751" alt="장기교육" /></a></li>
					<li><a href="javascript:fnGoMenu(3,'eduinfo3-5');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg752','','/images/skin1/menu/leftMu_1d252_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d252<%= leftSubIndex.equals("2") ? "_on":"" %>.gif" id="leftImg752" alt="야간교육" /></a></li>
					<li><a href="javascript:fnGoMenu(3,'eduinfo3-7');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg753','','/images/skin1/menu/leftMu_1d257_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d257<%= leftSubIndex.equals("3") ? "_on":"" %>.gif" id="leftImg753" alt="특별교육" /></a></li>
		        </ul>
			<%} %>
			</li>
		</ul>
<%
	}else if(leftMenu.equals("3")){
		// 수강신청
%>
		<h1 class="tit"><img src="/images/skin1/menu/leftMu_tit3.gif" alt="수강신청" /></h1>
		<ul class="dth1">
		    <li class="endM"><a href="javascript:fnGoMenu(4,'attendList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg31','','/images/skin1/menu/leftMu_1d31_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d31<%= leftIndex.equals("1") ? "_on":"" %>.gif" id="leftImg31" alt="수강신청" /></a></li>
				<ul class="dth2">
		          	<li><a href="javascript:fnGoMenu('4','attendList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg751','','/images/skin1/menu/leftMu_1d680_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d680<%= leftSubIndex.equals("1") ? "_on":"" %>.gif" id="" alt="수강신청" /></a></li>
					<li><a href="javascript:fnGoMenu('5','opencourse');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg752','','/images/skin1/menu/leftMu_1d681_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d681<%= leftSubIndex.equals("2") ? "_on":"" %>.gif" id="" alt="공개강의" /></a></li>
	       		</ul>
		</ul>

<%
	}else if(leftMenu.equals("4")){
		// 학습지원
%>
		<h1 class="tit"><img src="/images/skin1/menu/leftMu_tit4.gif" alt="학습지원" /></h1>
		<ul class="dth1">
		    <li><a href="javascript:fnGoMenu('5','faqList');" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg41','','/images/skin1/menu/leftMu_1d41_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d41<%= leftIndex.equals("1") ? "_on":"" %>.gif" id="leftImg41" alt="열린광장" /></a>
				<%if(leftIndex.equals("1")) {%>
			        <ul class="dth2">
			            <li><a href="javascript:fnGoMenu('5','faqList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg411','','/images/skin1/menu/leftMu_1d410_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d410<%= leftSubIndex.equals("1") ? "_on":"" %>.gif" id="leftImg411" alt="문의답변" /></a></li>
						<li><a href="javascript:fnGoMenu('5','requestList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg411','','/images/skin1/menu/leftMu_1d411_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d411<%= leftSubIndex.equals("2") ? "_on":"" %>.gif" id="leftImg411" alt="문의답변" /></a></li>
						<li><a href="javascript:fnGoMenu('5','freeBoardList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg412','','/images/skin1/menu/leftMu_1d412_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d412<%= leftSubIndex.equals("3") ? "_on":"" %>.gif" id="leftImg412" alt="자유게시판" /></a></li>
						<li><a href="javascript:fnGoMenu('5','noticeList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg413','','/images/skin1/menu/leftMu_1d413_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d413<%= leftSubIndex.equals("4") ? "_on":"" %>.gif" id="leftImg413" alt="공지사항" /></a></li>
						<li><a href="javascript:fnGoMenu('5','readList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg414','','/images/skin1/menu/leftMu_1d414_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d414<%= leftSubIndex.equals("5") ? "_on":"" %>.gif" id="leftImg414" alt="공지사항" /></li>
			        </ul>
				<%} %>
		    </li>
		    <li><a href="javascript:fnGoMenu(5,'educationDataList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg42','','/images/skin1/menu/leftMu_1d42_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d42<%= leftIndex.equals("2") ? "_on":"" %>.gif" id="leftImg42" alt="자료실" /></a>
				<%if(leftIndex.equals("2")) {%>
					<ul class="dth2">
			            <li><a href="javascript:fnGoMenu(5,'educationDataList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg421','','/images/skin1/menu/leftMu_1d421_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d421<%= leftSubIndex.equals("1") ? "_on":"" %>.gif" id="leftImg421" alt="교육자료" /></a></li>
						<li><a href="javascript:fnGoMenu(5,'lectureList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg422','','/images/skin1/menu/leftMu_1d422_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d422<%= leftSubIndex.equals("2") ? "_on":"" %>.gif" id="leftImg422" alt="강의교재" /></a></li>
						<li><a href="javascript:fnGoMenu(5,'programList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg423','','/images/skin1/menu/leftMu_1d423_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d423<%= leftSubIndex.equals("3") ? "_on":"" %>.gif" id="leftImg423" alt="프로그램자료실" /></a></li>
						<!-- <li><a href="javascript:alert('준비중입니다.')"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg424','','/images/skin1/menu/leftMu_1d424_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d424< %= leftSubIndex.equals("4") ? "_on":"" % >.gif" id="leftImg424" alt="관련사이트" /></a></li>  -->
			        </ul>
				<%} %>
			</li>    
		    <li><a href="javascript:fnGoMenu(5,'webzine');" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg43','','/images/skin1/menu/leftMu_1d43_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d43<%= leftIndex.equals("3") ? "_on":"" %>.gif" id="leftImg43" alt="웹진" /></a>
				<%if(leftIndex.equals("3")) {%>
				<ul class="dth2">
		            <li><a href="javascript:fnGoMenu(5,'webzine');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg431','','/images/skin1/menu/leftMu_1d431_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d431<%= leftSubIndex.equals("1") ? "_on":"" %>.gif" id="leftImg431" alt="포토갤러리" /></a></li>
		        </ul>
				<%} %>
			</li>
		    <li class="endM"><a href="http://152.99.42.138/" target="_blank" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg43','','/images/skin1/menu/leftMu_1d43_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d49<%= leftIndex.equals("3") ? "_on":"" %>.gif" id="leftImg49" alt="e-도서관" /></a>
			</li>
		</ul>
<%
	}else if(leftMenu.equals("5")){
		// E-book
%>
		<h1 class="tit"><img src="/images/skin1/menu/leftMu_tit5.gif" alt="eBook" /></h1>
		<ul class="dth1">
		    <li class="endM"><a href="javascript:fnGoMenu(6,'eduinfo6-1');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg51','','/images/skin1/menu/leftMu_1d51_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d51<%= leftIndex.equals("1") ? "_on":"" %>.gif" id="leftImg51" alt="e-Book" /></a></li>
		</ul>
<%
	}else if(leftMenu.equals("6")){
		// 교육원 소개
%>
		<h1 class="tit"><img src="/images/skin1/menu/leftMu_tit6.gif" alt="교육원소개" /></h1>
		<ul class="dth1">
		    <li><a href="javascript:fnGoMenu('7','eduinfo7-1');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg61','','/images/skin1/menu/leftMu_1d61_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d61<%= leftIndex.equals("1") ? "_on":"" %>.gif" id="leftImg61" alt="인사말" /></a></li>    
		    <!-- li><a href="javascript:fnGoMenu('7','eduinfo7-8');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg68','','/images/main/leftMu_1d68_on.gif',1)"><img src="/images/main/leftMu_1d68<%= leftIndex.equals("8") ? "_on":"" %>.gif" id="leftImg68" alt="안내동영상" /></a></li -->
		    <li><a href="javascript:fnGoMenu('7','eduinfo7-2');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg62','','/images/skin1/menu/leftMu_1d62_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d62<%= leftIndex.equals("2") ? "_on":"" %>.gif" id="leftImg62" alt="일반형황" /></a></li>    
		    <li><a href="javascript:fnGoMenu('7','eduinfo7-3');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg63','','/images/skin1/menu/leftMu_1d63_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d63<%= leftIndex.equals("3") ? "_on":"" %>.gif" id="leftImg63" alt="조직및업무" /></a></li>    
		        
		    <li><a href="javascript:fnGoMenu('7','lawsList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg65','','/images/skin1/menu/leftMu_1d65_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d65<%= leftIndex.equals("5") ? "_on":"" %>.gif" id="leftImg65" alt="법률/조례" /></a></li>
			<li><a href="javascript:fnGoMenu('7','eduinfo7-6');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg66','','/images/skin1/menu/leftMu_1d66_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d66<%= leftIndex.equals("6") ? "_on":"" %>.gif" id="leftImg66" alt="시설현황" /></a>
			<%if(leftIndex.equals("6")){ %>	
				<ul class="dth2">
		          	<li><a href="javascript:fnGoMenu('7','eduinfo7-6');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg751','','/images/skin1/menu/leftMu_1d661_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d661<%= leftSubIndex.equals("1") ? "_on":"" %>.gif" id="leftImg751" alt="시설개요" /></a></li>
					<li><a href="javascript:fnGoMenu('7','eduinfo7-6-2');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg752','','/images/skin1/menu/leftMu_1d662_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d662<%= leftSubIndex.equals("2") ? "_on":"" %>.gif" id="leftImg752" alt="층별안내" /></a></li>
					<li><a href="javascript:fnGoMenu('7','eduinfo7-6-3');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg753','','/images/skin1/menu/leftMu_1d663_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d663<%= leftSubIndex.equals("3") ? "_on":"" %>.gif" id="leftImg753" alt="편의시설" /></a></li>
					<li><a href="javascript:fnGoMenu('7','eduinfo7-6-4');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg754','','/images/skin1/menu/leftMu_1d664_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d664<%= leftSubIndex.equals("4") ? "_on":"" %>.gif" id="leftImg754" alt="시설대여안내" /></a></li>
					<li><a href="javascript:fnGoMenu('7','reservation');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg755','','/images/skin1/menu/leftMu_1d670_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d670<%// leftSubIndex.equals("5") ? "_on":"" %>.gif" id="leftImg755" alt="시설대여신청" /></a></li>
					 <li><a href="javascript:fnGoMenu('7','reservationConfirm');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg756','','/images/skin1/menu/leftMu_1d671_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d671<%// leftSubIndex.equals("6") ? "_on":"" %>.gif" id="leftImg756" alt="시설대여예약확인" /></a></li>
					<!-- <li><a href="javascript:alert('온라인 시설대여신청은 2009년 1월부터 서비스합니다.');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg755','','/images/skin1/menu/leftMu_1d670_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d670<%= leftSubIndex.equals("5") ? "_on":"" %>.gif" id="leftImg755" alt="시설대여신청" /></a></li> -->
					<!--<li><a href="javascript:alert('준비중입니다.');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg756','','/images/skin1/menu/leftMu_1d671_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d671<%= leftSubIndex.equals("6") ? "_on":"" %>.gif" id="leftImg756" alt="시설대여예약확인" /></a></li> -->

	       		</ul>
			<%}%>

			</li>
			<li><a href="javascript:fnGoMenu('7','eduinfo7-4');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg64','','/images/skin1/menu/leftMu_1d64_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d64<%= leftIndex.equals("4") ? "_on":"" %>.gif" id="leftImg64" alt="식단표" /></a></li>	
			<li class="endM"><a href="javascript:fnGoMenu('7','eduinfo7-7');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg67','','/images/skin1/menu/leftMu_1d67_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d67<%= leftIndex.equals("7") ? "_on":"" %>.gif" id="leftImg67" alt="찾아오시는길" /></a></li>
		</ul>
<%
	}else if(leftMenu.equals("7")){
		// 마이페이지
%>
		<h1 class="tit"><img src="/images/skin1/menu/leftMu_tit7.gif" alt="마이페이지" /></h1>
		<ul class="dth1">
		    <li><a href="javascript:fnGoMenu('1','main');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg71','','/images/skin1/menu/leftMu_1d71_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d71<%= leftIndex.equals("1") ? "_on":"" %>.gif" id="leftImg71" alt="나의 강의실" /></a>

<% if ( session.getAttribute("sess_grcode")!=null && session.getAttribute("sess_grcode")!=null && ((String)session.getAttribute("sess_grcode")).length() > 0 && ((String)session.getAttribute("sess_grseq")).length() > 0){%>
	<%if(leftIndex.equals("1")){ %>

		        <ul class="dth2">
		            <li><a href="javascript:fnGoMenu('1','selectCourseList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg711','','/images/skin1/menu/leftMu_1d711_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d711<%= leftSubIndex.equals("1") ? "_on":"" %>.gif" id="leftImg711" alt="과정리스트" /></a></li>
					<li><a href="javascript:fnGoMenu('1','selectGrnoticeList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg712','','/images/skin1/menu/leftMu_1d712_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d712<%= leftSubIndex.equals("2") ? "_on":"" %>.gif" id="leftImg712" alt="과정공지" /></a></li>
					<li><a href="javascript:fnGoMenu('1','pollList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg713','','/images/skin1/menu/leftMu_1d713_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d713<%= leftSubIndex.equals("3") ? "_on":"" %>.gif" id="leftImg713" alt="과정설문" /></a></li>
					<li><a href="javascript:fnGoMenu('1','testView');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg714','','/images/skin1/menu/leftMu_1d714_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d714<%= leftSubIndex.equals("4") ? "_on":"" %>.gif" id="leftImg714" alt="과정평가" /></a></li>
					<li><a href="javascript:fnGoMenu('1','discussList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg715','','/images/skin1/menu/leftMu_1d715_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d715<%= leftSubIndex.equals("5") ? "_on":"" %>.gif" id="leftImg715" alt="과정토론방" /></a></li>
					<li><a href="javascript:fnGoMenu('1','suggestionList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg716','','/images/skin1/menu/leftMu_1d716_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d716<%= leftSubIndex.equals("6") ? "_on":"" %>.gif" id="leftImg716" alt="과정질문방" /></a></li>
					<li><a href="javascript:fnGoMenu('1','courseInfoDetail');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg717','','/images/skin1/menu/leftMu_1d717_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d717<%= leftSubIndex.equals("7") ? "_on":"" %>.gif" id="leftImg717" alt="교과안내문" /></a></li>
					<li><a href="javascript:fnGoMenu('1','sameClassList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg718','','/images/skin1/menu/leftMu_1d718_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d718<%= leftSubIndex.equals("8") ? "_on":"" %>.gif" id="leftImg718" alt="동기모임" /></a></li>
		        </ul>
	<% } %>
<%} %>
		    </li>
		    <li><a href="javascript:fnGoMenu('1','attendList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg72','','/images/skin1/menu/leftMu_1d72_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d72<%= leftIndex.equals("2") ? "_on":"" %>.gif" id="leftImg72" alt="수강신청 및 취소" /></a></li>    
		    <li><a href="javascript:fnGoMenu('1','completionList');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg73','','/images/skin1/menu/leftMu_1d73_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d73<%= leftIndex.equals("3") ? "_on":"" %>.gif" id="leftImg73" alt="수료내역" /></a></li>
			<!-- <li><a href="javascript:"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg74','','/images/skin1/menu/leftMu_1d74_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d74.gif" id="leftImg74" alt="카페" /></a></li> -->
			<li><a href="/mypage/myclass.do?mode=personalnotice" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg75','','/images/skin1/menu/leftMu_1d75_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d75<%= leftIndex.equals("4") ? "_on":"" %>.gif" id="leftImg75" alt="개인정보" /></a>
				<%if(leftIndex.equals("4")) { %>
				<ul class="dth2">
		            <li><a href="/mypage/myclass.do?mode=personalnotice"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg751','','/images/skin1/menu/leftMu_1d751_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d751<%= leftSubIndex.equals("1")? "_on":"" %>.gif" id="leftImg751" alt="개인공지" /></a></li>
					<li><a href="/mypage/myclass.do?mode=myquestion"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg752','','/images/skin1/menu/leftMu_1d752_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d752<%= leftSubIndex.equals("2")? "_on":"" %>.gif" id="leftImg752" alt="나의질문" /></a></li>
					<li><a href="/mypage/myclass.do?mode=personalinfomodify"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg753','','/images/skin1/menu/leftMu_1d753_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d753<%= leftSubIndex.equals("3")? "_on":"" %>.gif" id="leftImg753" alt="개인정보변경" /></a></li>
					<li><a href="javascript:fnGoMenu('8','recieve');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg754','','/images/skin1/menu/leftMu_1d754_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d754<%= leftSubIndex.equals("4")? "_on":"" %>.gif" id="leftImg754" alt="쪽지함" /></a></li>
					<li><a href="/homepage/support.do?mode=programList"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg755','','/images/skin1/menu/leftMu_1d755_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d755<%= leftSubIndex.equals("5")? "_on":"" %>.gif" id="leftImg755" alt="학습프로그램" /></a></li>
					<li><a href="/mypage/myclass.do?mode=memberout"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg756','','/images/skin1/menu/leftMu_1d756_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d756<%= leftSubIndex.equals("6")? "_on":"" %>.gif" id="leftImg756" alt="회원탈퇴" /></a></li>
		        </ul>
				<%} %>
			</li>
			<li class="endM"><a href="http://152.99.42.138/" target="_blank" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg76','','/images/skin1/menu/leftMu_1d76_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d76.gif" id="leftImg76" alt="디지털도서관" /></a></li>
		</ul>
<%
	}else if(leftMenu.equals("8")){
	// 고객지원	
%>

		<h1 class="tit"><img src="/images/skin1/menu/leftMu_tit8.gif" alt="고객지원" /></h1>
		
		<ul class="dth1">
		    <li><a href="/homepage/index.do?mode=policy"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg800','','/images/skin1/menu/leftMu_1d800_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d800<%= leftIndex.equals("1") ? "_on":"" %>.gif" id="leftImg800" alt="개인정보보호정책" /></a></li>
			<li><a href="/homepage/index.do?mode=worktel"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg810','','/images/skin1/menu/leftMu_1d810_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d810<%= leftIndex.equals("2") ? "_on":"" %>.gif" id="leftImg810" alt="업무별연락처" /></a></li>
		    <li><a href="/homepage/index.do?mode=spam"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg820','','/images/skin1/menu/leftMu_1d820_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d820<%= leftIndex.equals("3") ? "_on":"" %>.gif" id="leftImg820" alt="이메일 무단수집거부" /></a></li>
		    <li class="endM"><a href="/homepage/index.do?mode=sitemap"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg830','','/images/skin1/menu/leftMu_1d830_on.gif',1)"><img src="/images/skin1/menu/leftMu_1d830<%= leftIndex.equals("4") ? "_on":"" %>.gif" id="leftImg830" alt="사이트맵" /></a></li>
		</ul>
	

<%}

%>
		<img src="/images/skin1/menu/leftMu_btt.gif" alt="" />
	</div>				
	<!-- //leftMenu -->
	<div class="spaceL"></div>
	

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
	<div class="space"></div>
	
</div>

<script language="JavaScript" type="text/JavaScript">
<!--

selectOpt(1);

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

//-->
</script>
