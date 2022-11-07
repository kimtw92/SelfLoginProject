<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%
String type = (String)request.getAttribute("type");
// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);

StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";
int iNum = 0;
if(listMap.keySize("subj") > 0){		
	for(int i=0; i < listMap.keySize("subj"); i++){
		sbListHtml.append("<tr>\n");
		sbListHtml.append("<td class=\"bl0\"><a href=\"javascript:getValue('"+listMap.getString("orgDir",i)+"','"+listMap.getString("orgId",i)+"','"+iNum+"')\"><img src='/images/"+skinDir +"/icon/icon_plus2.gif' alt='+'></a></td>\n");
		sbListHtml.append("<td class=\"bl0\">"+Util.plusZero(listMap.getString("dates",i))+"</td>\n");
		sbListHtml.append("<td class=\"sbj01\">"+listMap.getString("datesNm", i)+"</td>\n"); // grocde, grseq, subj, userno, 
		sbListHtml.append("<td><a href=\"javascript:setValue('"+requestMap.getString("grcode")+"','"+requestMap.getString("grseq")+"','"+listMap.getString("subj", i)+"','"+requestMap.getString("userno")+"','"+listMap.getString("dates", i)+"','");
		sbListHtml.append(listMap.getString("orgId", i)+"','"+listMap.getString("ctId", i)+"','"+listMap.getString("ctSeq", i)+"','"+listMap.getString("orgDir", i)+"','");
		sbListHtml.append(listMap.getString("lcmsWidth", i)+"','"+listMap.getString("lcmsHeight", i)+"','");
		sbListHtml.append(listMap.getString("menuyn", i)+"','"+listMap.getString("menunum", i)+"','");
		sbListHtml.append(listMap.getString("limit", i)+"','"+listMap.getString("limitTime", i)+"','"+listMap.getString("orgDirName",i)+"','"+listMap.getString("scoRatio",i)+"','");
		if (requestMap.getString("review").equals("N")){
			sbListHtml.append("N')\";>");
		} else {
			sbListHtml.append("Y')\";>");
		}
		
		sbListHtml.append("<img src='/images/"+skinDir+"/icon/ico_sound.gif' alt='강의듣기'></a></td>");
		
		// 필수시간		
		int limit_time = Util.getIntValue(listMap.getString("progTime",i),0);

		double dhour = Math.floor((limit_time%(60*60*24))/(60*60)*1);
		double dmin = Math.floor(((limit_time%(60*60*24))%(60*60))/(60)*1);
		double dsec = Math.floor((((limit_time%(60*60*24))%(60*60))%(60))/1);
		
		String strTime = "";
		if(dhour > 0) 
			strTime = dhour+"시간"+dmin+"분";
		else if(dmin > 0)
			strTime = dmin+"분";
		
		sbListHtml.append("<td>"+strTime+"</td>\n");
		
		// 학습시간
		int sco_time=Util.getIntValue(listMap.getString("scoTime",i),0);
		
		int ihour=Math.round((sco_time%(60*60*24))/(60*60)*1);
		int imin=Math.round(((sco_time%(60*60*24))%(60*60))/(60)*1);
		int isec=Math.round((((sco_time%(60*60*24))%(60*60))%(60))/1);

		if(ihour > 9) 
			strTime += ihour + ":";
		else
			strTime += ihour + ":";
		
		if(imin > 9) 
			strTime += imin + ":";
		else
			strTime += "0"+imin + ":";
		
		if(isec > 9) 
			strTime += isec + "";
		else
			strTime += "0"+isec;
		
		sbListHtml.append("<td>"+strTime+" </td>\n");
		
		// {? .sco_time < .prog_time || intval(substr(.sco_ratio, 0, -1)) < 100}X{:}O{/}<
		
		if(!"b".equals(type)) { 
		if (listMap.getString("lcmsProgress").equals("N")){
			sbListHtml.append("<td>"+listMap.getString("scoStatus",i)+"</td>\n");
		} else {
			sbListHtml.append("<td>"+listMap.getString("scoRatio",i)+"%</td>\n");
		}
		}
		if(!"b".equals(type)) { 
		if(Util.getIntValue(listMap.getString("scoTime",i),0) < Util.getIntValue(listMap.getString("progTime",i),0) || Util.getIntValue(listMap.getString("scoRatio",i),0) < 100){
			sbListHtml.append("<td>X</td>\n");
		} else {
			sbListHtml.append("<td>O</td>\n");
		}
		}
		sbListHtml.append("</tr>\n");
		
		// 각 진도율 확인하는 부분
		/*
		sbListHtml.append("<tr style=\"display:none\" id=\"value"+iNum+"\">")
			.append("	<td class=\"bl0 H2out\" colspan=\"10\">\n")
			.append("		<table class=\"dataH02 head01\">\n") 
			.append("					<colgroup>\n")
			.append("			<col width=\"280\" />\n")
			.append("			<col width=\"130\" />\n")
			.append("			<col width=\"82\" />\n")
			.append("					</colgroup>\n")
			.append("					<thead>\n")
			.append("					<tr>\n")
			.append("				<th class=\"in\">학습객체목록</th>\n")
			.append("				<th class=\"in\">학습시간</th>\n")
			.append("				<th class=\"in\">완료여부</th>\n")
			.append("					</tr>\n")
			.append("					</thead>\n")
			.append("					<tbody  id=\"td"+iNum+"\">\n")
								
			.append("					</tbody>\n")
			.append("           </table>")
			.append("		</td>")
			.append("</tr>\n");
		*/
		iNum ++;

	}
}else{
	// 리스트가 없을때
	sbListHtml.append("<tr><td colspan=\"8\">현재 등록된 콘텐츠가  없습니다.</td></tr>");
}
%>

<script language="JavaScript" type="text/JavaScript">
<!--

//학습시간 갱신
function setCmiTime(grcode, grseq, subj, orgDir, timeHh, timeMm, timeSs) {
	
	var url  = "/movieMgr/movie.do";
	var pars = "";
	pars	+= "mode=updateCmiTime";
	pars    += "&timeHh="+timeHh;
	pars    += "&timeMm="+timeMm;
	pars    += "&timeSs="+timeSs;
	pars    += "&strGrcode="+grcode;
	pars    += "&strGrseq="+grseq;
	pars    += "&subj="+subj;
	pars    += "&orgDir="+orgDir;

	var myAjax = new Ajax.Request(
			url, 
			{
				method: "get", 
				parameters: pars, 
				onSuccess : function(){
					window.location.reload();
					//window.close();
				},
				onFailure: function() {
					alert("수정에 실패했습니다.");
				}
			}
		);
}


function getValue(orgDir, orgId, divIdForm){
	
	var url = "/mypage/myclass.do";
	var pars = "mode=progressRate&orgDir="+orgDir+"&orgId="+orgId+"&grcode="+$("grcode").value+"&grseq="+$("grseq").value;
	// alert(pars);
	var divID = eval("td"+divIdForm);
	var iNum = <%=iNum%>;
	var find = "";

	for (var i=0;i<iNum;i++){
		if (eval("value"+i).style.display == "")
			find = i;
		eval("value"+i).style.display = "none";
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
					eval("value"+divIdForm).style.display = "";
				},
				onFailure : function(){					
					// window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					alert("데이타를 가져오지 못했습니다.");
				}				
			}
		);
		
	}

}	

	
//-->
</script>
<Script language='javascript'>

function setValue(grcode, grseq, subj, userno, dates,orgId,ctId,ctSeq,orgDir,lcms_width,lcms_height,menuYn,menunum,limit,limitTime,orgDirName,scoRatio, review){
	// subj,dates,orgId,ctId,ctSeq,orgDir,lcms_width,lcms_height,menuYn,menunum,limit,limitTime,orgDirName
	// alert("1");
	var url = "/mypage/myclass.do";
	// alert("2");
    var pars = "mode=ajaxReadCnt";
    pars += "&grcode="+grcode;
	pars += "&grseq="+grseq;
	pars += "&subj="+subj;
	pars += "&userno="+userno;
	// alert(pars);
	
	var myAjax = new Ajax.Request(
		url, 
		{
			method: "post", 
			parameters: pars,
			onSuccess : function(transport){
			    
				if(eval(transport.responseText.trim())){
					go_view(subj,dates,orgId,ctId,ctSeq,orgDir,lcms_width,lcms_height,menuYn,menunum,limit,limitTime,orgDirName, review);
				} else {
					if (scoRatio != "0"){
						go_view(subj,dates,orgId,ctId,ctSeq,orgDir,lcms_width,lcms_height,menuYn,menunum,limit,limitTime,orgDirName, review);
					} else {
						alert("하루에 학습하실수 있는 차시수는 최대 "+limit+"개 입니다.");
					}
				}
			},
			onFailure : function(){					
				alert("데이타를 가져오지 못했습니다.");
			}				
		}
	);
}


function PopWin(he, wi, go_url){
	var optstr;
	optstr="height="+he+",width="+wi+",location=0,menubar=0,resizable=1,scrollbars=auto,status=0,titlebar=0,toolbar=0,screeny=0,left=0,top=0";

	window.open(go_url, "study", optstr);
}

function SetCookie(name, value, expiredays) {
	var expire_date = new Date();
	expire_date.setDate(expire_date.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; expires=" + expire_date.toGMTString() + "; path=/";
	} 

function go_view(subj,dates,orgId,ctId,ctSeq,orgDir,lcms_width,lcms_height,menuYn,menunum,limit,limitTime,orgDirName, review){
	//alert("go_view()");
	//쿠키설정 시작
	//	SetCookie("lms_func01","/mypage/myclass.do?mode=lcmsproecss",1); 
	//	SetCookie("lms_func02","/mypage/myclass.do?mode=lcmsnotice",1); 
	//	SetCookie("lms_func04","/baseCodeMgr/dic.do?mode=dicView",1); 
		SetCookie("lms_func05","/mypage/myclass.do?mode=suggestionList",1);
	/*
	String c_subj = (String)session.getAttribute("s_subj"); 
	String c_year = (String)session.getAttribute("s_year"); 
	String c_subjseq = (String)session.getAttribute("s_subjseq"); 
	String c_resno = (String)session.getAttribute("userid"); 
	*/ 
	SetCookie("c_subj",subj,1);
	SetCookie("c_year","<%=requestMap.getString("Grseq")%>",1);
	SetCookie("c_subjseq","<%=requestMap.getString("Grseq")%>",1);
	SetCookie("c_resno","<%=requestMap.getString("UserId")%>",1);
	SetCookie("c_name","<%=requestMap.getString("UserName")%>",1);
	//쿠키설정 끝
	
	var subjType = "";
	
	if(subj != "")	subjType = subj.substring(0, 3);
	
	if(subjType == "NUM") {	//동영상

		var url = "/lcms/lecture/lecture.jsp?subj="+subj+"&ctId="+ctId+"&orgDir="+orgDir+"&orgDirName="+orgDirName+"&review="+review+"&menuYn="+menuYn+"&skinId="+menunum+"&orgId="+orgId+"&Grseq=<%=requestMap.getString("Grseq")%>&Grcode=<%=requestMap.getString("Grcode")%>&UserId=<%=requestMap.getString("UserId")%>&UserName=<%=requestMap.getString("UserName")%>";
				
		//var url = "/movieMgr/movie.do?mode=movView&contCode=" + orgDir;
		//returnValue = window.showModalDialog(url, "pop_mov", "dialogWidth: 800px; dialogHeight: 440px;");	//height, weight, url
		//alert(returnValue);
		PopWin("400", "800", url);
		
	} else {	//LCMS
	
		var url = "/lcms/lecture/lecture.jsp?subj="+subj+"&ctId="+ctId+"&orgDir="+orgDir+"&orgDirName="+orgDirName+"&review="+review+"&menuYn="+menuYn+"&skinId="+menunum+"&orgId="+orgId+"&Grseq=<%=requestMap.getString("Grseq")%>&Grcode=<%=requestMap.getString("Grcode")%>&UserId=<%=requestMap.getString("UserId")%>&UserName=<%=requestMap.getString("UserName")%>";
	
		//var url = "/lcms/lecture/lecture.jsp?subj="+subj+"&ctId="+ctId+"&orgDir="+orgDir+"&orgDirName="+orgDirName+"&review=N&menuYn="+menuYn+"&skinId="+menunum+"&orgId="+orgId;
	
		if(lcms_height=="")lcms_height="746";
		if(lcms_width=="")lcms_width="1020";
		PopWin(lcms_height,lcms_width,url);
	}
}

</script>

<SCRIPT language=javascript>
var old_menu = '';
var old_cell = '';

function menuclick( submenu ,cellbar) {
	if( old_menu != submenu ) {
	
		if( old_menu !='' ) {
			old_menu.style.display = 'none';
		}
	
		submenu.style.display = 'block';
		old_menu = submenu;
		old_cell = cellbar;
	
	} else {
		submenu.style.display = 'none';
		old_menu = '';
		old_cell = '';
	}
}
</SCRIPT>
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
            <div class="mytab01">
              <ul>
                <li><a href="/mypage/myclass.do?mode=selectCourseList&type=<%=type%>"><img src="/homepage_new/images/M1/tab01_on.gif" alt="과정리스트"/></a></li>
                <li><a href="/mypage/myclass.do?mode=selectGrnoticeList&type=<%=type%>"><img src="/homepage_new/images/M1/tab02.gif" alt="과정공지"/></a></li>
                <li><a href="/mypage/myclass.do?mode=pollList&type=<%=type%>"><img src="/homepage_new/images/M1/tab03.gif" alt="과정설문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=testView&type=<%=type%>"><img src="/homepage_new/images/M1/tab04.gif" alt="과정평가"/></a></li>
                <li><a href="/mypage/myclass.do?mode=discussList&type=<%=type%>"><img src="/homepage_new/images/M1/tab05.gif" alt="과정토론방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=suggestionList&type=<%=type%>"><img src="/homepage_new/images/M1/tab06.gif" alt="과정질문방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=courseInfoDetail&type=<%=type%>"><img src="/homepage_new/images/M1/tab07.gif" alt="교과안내문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=sameClassList&type=<%=type%>"><img src="/homepage_new/images/M1/tab08.gif" alt="동기모임"/></a></li>
              </ul>
              </div>

			<form id="pforam" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" name="grcode"  value="<%=requestMap.getString("grcode") %>">
<input type="hidden" name="grseq"  value="<%=requestMap.getString("grseq") %>">
<input type="hidden" name="subj">
<input type="hidden" name="classno">
<input type="hidden" name="goto">
				<div id="content">
						<div class="h15"></div>
			
						<!-- title --> 
						<h4 class="h4Ltxt"><%=requestMap.getString("coursenm") %> - <%=listMap.getString("subjnm") %> <!-- a href="#">(진도율 확인하기)</a--></h4>
						<!-- //title -->
						<div class="h9"></div>
			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="60" />
							<col width="200" />
							<col width="70" />
							<col width="70" />
							<col width="70" />
							<col width="70" />
							<col width="70" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_progress.gif" alt="진도확인" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_ti.gif" alt="차시" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_chname.gif" alt="차시명" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_sound.gif" alt="강의듣기" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_times.gif" alt="필수시간" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_edutime.gif" alt="학습시간" /></th>
							<% if(!"b".equals(type)) { %>
							<th class=""><img src="/images/<%= skinDir %>/table/th_progress2.gif" alt="진도율" /></th>
							<th class=""><img src="/images/<%= skinDir %>/table/th_completion2.gif" alt="완료여부" /></th>
							<% } %>
						</tr>
						</thead>
			
						<tbody>
						<%=sbListHtml.toString() %>
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>
						
						<div class="TbBttTxt01"></div>
						<div class="spaceNone"></div>
			
						<div class="space"></div>
					</div>
</form>
              
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>