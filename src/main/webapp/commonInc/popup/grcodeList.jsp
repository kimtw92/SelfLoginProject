<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%

LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");

String checkValue = "10C0000183,10C0000168,10C0000170,10C0000117,10C0000204,10C0000205,10C0000172,10C0000062,10C0000176,10C0000188,10C0000151,10C0000215,10C0000216,10C0000092"; // 중복가능과정


// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);

StringBuffer sbListHtml = new StringBuffer();

int iNum = 0;
int pNum = 1;
if(listMap.keySize("grcode") > 0) {
	// 체크 리스트
	String checklist = "10C0000183,10C0000168,10C0000170,10C0000117,10C0000204,10C0000205,10C0000172,10C0000062,10C0000176,10C0000188,10C0000151";
	for(int i=0; i < listMap.keySize("grcode"); i++){
		
		//공직자사이버청렴교육이 아닌 경우
		if(!"10C0000055".equals(listMap.getString("grcode", i)) && !"10C0000056".equals(listMap.getString("grcode", i))) {
			sbListHtml.append("<tr>\n");
			
			String seated = listMap.getString("seated",i);
			
			sbListHtml.append("	<td class=\"bl0\">"+ pNum++ +"</td>\n");
			
			
			String gubun = "[사이버]";
			if(listMap.getString("grcodeniknm",i).replaceAll(" ","").indexOf("e-") != -1) {
				gubun = "[사이버]";
			} else {
					if(checklist.indexOf(listMap.getString("grcode", i)) != -1) {
						if("10G0000091".equals(listMap.getString("grcode", i)))  {
							gubun = "[기본]";
						} else {
							gubun = "[혼합]";
						}
					} else {
						gubun = "[집합]";
					}
			}
			
			sbListHtml.append("	<td class=\"bl0\">"+ gubun +"</td>\n");

			if(checkValue.indexOf(listMap.getString("grcode", i)) != -1) {
				sbListHtml.append("	<td class=\"sbj\" style=\"color:red;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");><font color=\"red\">" + listMap.getString("grcodeniknm", i) + "</font></a></td>\n");
			} else {
				sbListHtml.append("	<td class=\"sbj\" style=\"color:blue;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");>" + listMap.getString("grcodeniknm", i) + "</a></td>\n");
			}
			
			sbListHtml.append("	<td>"+listMap.getString("grseq",i)+"기</td>\n");				
			sbListHtml.append("	<td>"+seated+" / "+listMap.getString("tseat",i)+"</td>\n");
			
			sbListHtml.append("	<td>"+listMap.getString("studyDate",i)+"</td>\n");
			
			if (listMap.getString("userno",i).length() > 0){
				sbListHtml.append("	<td><a href=\"javascript:go_cancel('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("grcodeniknm",i)+"','"+listMap.getString("part",i)+"','"+listMap.getString("grgubun", i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_cancel03.gif\" alt=\"취소\" /></a></td>\n");
			} else {
				if (listMap.getString("restrict").length() > 0){
					sbListHtml.append("	<td><a href=\"javascript:alert('귀하는 이전기수 사이버교육을 미수료하여 60일간 수강신청이 제한되어 있습니다.');\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"제한\" /></a></td>\n");
				} else {
					// sbListHtml.append("<td><input type=\"checkbox\" name=\"checkBox\" value=\""+listMap.getString("grcode",i)+"|"+listMap.getString("grseq",i)+"|"+listMap.getString("grcodeniknm",i)+"\"></td>");
					if(checkValue.indexOf(listMap.getString("grcode", i)) != -1) {
						sbListHtml.append("	<td><a href=\"javascript:go_apply1('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+requestMap.getString("userno")+"','"+listMap.getString("grgubun",i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"신청\" /></td>\n");
					}else{
						sbListHtml.append("	<td><a href=\"javascript:go_apply('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+requestMap.getString("userno")+"','"+listMap.getString("grgubun",i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"신청\" /></td>\n");
					}
				}
			}
			
			sbListHtml.append("	<td><strong class=\"txt_org\">"+listMap.getString("applyStatus",i)+"</span></td>\n");
			sbListHtml.append("	<td>"+listMap.getString("appdate",i)+"</td>\n");
			sbListHtml.append("	<td>"+listMap.getString("time",i)+"</td>\n");
			sbListHtml.append("</tr>\n");
			iNum ++;
		}
	}
	
} else {
	sbListHtml.append("<tr>");
	sbListHtml.append("<td colspan=\"10\">수강신청 과정이 없습니다!");
	sbListHtml.append(" </td>");
	sbListHtml.append("</tr>");
	
	
	
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
	pform.action = "/commonInc/popup.do?mode=grcodelist";
	pform.submit();
}
//리스트
function goSearch(){
	pform.action = "/commonInc/popup.do?mode=grcodelist";
	pform.submit();
}
//리스트
function onView(form){
	$("qu").value = "discussView";
	pform.action = "/mypage/myclass.do?mode=discussView&seq="+form;
	pform.submit();
}


function go_apply(grcode, grseq, userno, grgubun){

	var url = "/mypage/myclass.do";
    var pars = "mode=ajaxGetGrseq";
	pars += "&grseq="+grseq;
	pars += "&userno="+userno;
	pars += "&grcode="+grcode;
	// alert(pars);
	var myAjax = new Ajax.Request(
		url, 
		{
			method: "post", 
			parameters: pars,
			onSuccess : function(transport){
				//사이버
				if (grgubun == 'C'){
					//수강신청이 가능한 과정인 경우
					var result = eval(transport.responseText.trim());
					if(result == '1'){
						go_apply1(grcode, grseq, userno, grgubun);

					//수강신청이 불가능한 경우
					} else {
						if(result == '-1') { // 올해 수강신청한 이력이 있으면 신청불가
							alert("이미 수강했던 과정입니다. 다른과정을 신청해 주세요.");
						} else if(result == '-200') { // 올해 수강신청한 이력이 있으면 신청불가
							alert("본 과정은 선착순 수강 신청이 마감되었습니다.");
						} else { // 수강신청은 1년에 3개까지만 가능
							alert("한 기수당  1개 이상의 과정은 신청하실 수 없습니다.");
						}
					}
					
				} else {
					go_apply1(grcode, grseq, userno, grgubun);
				}
			},
			onFailure : function(){					
				alert("데이타를 가져오지 못했습니다.");
			}				
		}
	);
}

//수강신청팝업
function go_apply1(grcode, grseq, userno, grgubun){
	var chkBox = document.pform.checkBox;
	var chkNum = 0;
	var url = "/mypage/myclass.do";
	url += "?mode=attendPopup";
	url += "&grcode="+grcode;
	url += "&grseq="+grseq;
	url += "&userno="+userno;
	url += "&grgubun="+grgubun;
	pwinpop = popWin(url,"attendPop","500","480","yes","yes");

}

//과정 신청
function go_applyInfo(grcode,grseq,userno,deptcode,deptnm,deptsub,degreename,jik,hp,email,upsdate,ldapcode,grgubun){
	
		var url = "/mypage/myclass.do";

		if(grgubun == "C") {
			pars = "mode=applyInfo2";
		} else {
			pars = "mode=applyInfo";
		}
		
		pars += "&grcode="+grcode+"&grseq="+grseq+"&userno="+userno+"&deptcode="+deptcode
		+"&deptnm="+deptnm+"&deptsub="+deptsub+"&degreename="+degreename+"&hp="+hp+"&email="+email+"&jik="+jik+"&upsdate="+upsdate+"&ldapcode="+ldapcode;
		// alert(pars);
		var myAjax = new Ajax.Request(
					
			url, 
				{
					method: "post", 
					parameters: pars,
					onComplete : showResponse
				}
		);
}

//과정 취소
function go_cancel(grcode,grseq,grcodename,part,grgubun){
	if(part == "Y"){
		if(grcode=="" || grseq==""){
			alert('필요정보가 전달되지 않았습니다. 관리자에게 문의하세요.');
			return;
		}
		if(confirm("다음과정의 수강 취소를 하시겠습니까?\n"+grcodename+" "+grseq+"기수") == true){
			var url = "/mypage/myclass.do";
			pars = "mode=cancelAttend&grcode=" + grcode + "&grseq="+grseq+"&userno=<%=requestMap.getString("userno")%>";
			// alert(pars);
			var divID = "part";
				
			var myAjax = new Ajax.Request(				
				url, 
					{
						method: "post", 
						parameters: pars,
						onComplete : showResponse
					}
			);
			return;
			
		}else{

		}

	}else if(part == "C"){
		alert('수강신청 기간이 지났으므로 수강취소 불가합니다');
		return;
	}else{
		if(grgubun == "C") {
			if(confirm("다음과정의 수강 취소를 하시겠습니까?\n"+grcodename+" "+grseq+"기수") == true){
			var url = "/mypage/myclass.do";
			pars = "mode=autoCancelAttend&grcode=" + grcode + "&grseq="+grseq+"&userno=<%=requestMap.getString("userno")%>";
			var divID = "part";
				
			var myAjax = new Ajax.Request(				
				url, 
					{
						method: "post", 
						parameters: pars,
						onComplete : showResponse
					}
			);
			return;
			
			}
		} else {
			alert('현재 취소 불가능합니다');
		}
		return;
	}
}

function showResponse(oRequest){
	alert(oRequest.responseText);
	fnList();
}

//리스트
function goDetail(){
	pform.action = "/mypage/myclass.do?mode=attendDetail";
	pform.submit();
}

function fileDownloadOpen(groupfileNo, fileNo) {
    if(groupfileNo == "18872") {
        if(<%=loginInfo.isLogin()%> == true) {
            fileDownload('20266', '1');
        } else {
            alert("로그인후 다운로드 가능합니다.");
        }
    } else {
        fileDownload(groupfileNo, fileNo);
    }
}
//-->
</script>
 
    <div id="subContainer">
    
    <div id="contnet">
		  <form id="pform" name="pform" method="post">
			<!-- 필수 -->
			<input type="hidden"  name="qu" >
			<!-- 페이징용 -->
			<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
			<div class="h15"></div>
				
						<!-- title --> 
						<center>
						<h2>2019년 신규임용공무원 대상 교육과정 안내</h2><br />
						<h3><font color="blue">< 신규채용자 이외의 신청자는 통보없이 취소 ></font></h3>
						<br /><br />
						</center>	
						※ 아래과정은 신규임용공무원 대상 집합교육과정 신청입니다. 
						<!-- (붉은색 과정은 복수 수강 가능) -->
						<br />
					

						<!-- //title -->
						<!-- <div class="btnR"><a href="javascript:goDetail();"><img src="/images/<%= skinDir %>/button/btn_reqList01.gif" alt="수강신청취소/상세확인" /></a></div> -->
						<div class="h9">집합교육 신청</div>
			
						<!-- data -->
						<table class="bList01" style="font-size: 8pt;">	
						<colgroup>
							<col width="30" />
							<col width="50" />
							<col width="*" />
							<col width="56" />
							<col width="80" />
							<col width="80" />
							<col width="48" />
							<col width="48" />
							<col width="80" />
							<col width="80" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>	
							<th>분류</th>			
							<th>과정명</th>
							<th>기수</th>
							<th>수강신청기간</th>
							<th>학습기간</th>
							<th>신청</th>
<!-- 							<th>상태</th>
							<th>신청일</th> -->
							<th>교육시간</th>
						</tr>							
						<!-- tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_no.gif" alt="번호" /></th>				
							<th><img src="/images/<%= skinDir %>/table/th_process.gif" alt="과정명" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_num.gif" alt="기수" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_seated.gif" alt="수강신청기간" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_date09.gif" alt="학습기간" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_req.gif" alt="신청" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_state.gif" alt="상태" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_date10.gif" alt="신청일" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_date13.gif" alt="교육시간" /></th>
						</tr -->
						</thead>
			
						<tbody>
							<%-- <%=sbListHtml.toString() %> --%>							
							<TR>
							<TD class=bl0>1</TD>
							<TD>[집합]</TD>
							<TD class=sbj style="COLOR: blue; text-align: center;">							
							<A href='javascript:popWin("/homepage/course.do?mode=courseinfopopup&amp;grcode=10G0000231&amp;grseq=201903","aaa","603","680","yes","yes");'>신임인재양성과정 3기</A>
							</TD>
							<TD>03기</TD>
							<TD>19.10.02~10.27</TD>
							<TD>10.21~11.01</TD>
							<TD><A href="javascript:go_apply('10G0000231','201903','<%=requestMap.getString("userno") %>','G','인천광역시')"><IMG alt=취소 src="/images/skin4/button/btn_request03.gif"></A></TD>
<!-- 							<TD><STRONG class=txt_org> </SPAN></STRONG></TD>
							<TD></TD> -->
							<TD>85</TD></TR>	
						</tbody>
						</table>
						<br/>
						
						<table>
							<tbody>						
								<TR>
									
<TD class="bl0 cont" colSpan=4><P class=0 style="LETTER-SPACING: -1.2pt;  mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><STRONG><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조">□ </SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">교육개요</SPAN></STRONG></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-FAMILY: 한양신명조; LETTER-SPACING: -1.2pt"><?xml:namespace prefix = "o" /></SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt; mso-font-width: 100%; mso-text-raise: 0pt"><STRONG><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">&nbsp;&nbsp;○ </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">기간 </SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">: 2019. 10. 21.(</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">월</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">) ~ 11. 1.(</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">금</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">) [2</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">주</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">, </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">비합숙</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">]</SPAN></STRONG></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-FAMILY: 한양신명조; LETTER-SPACING: -1.2pt"><o:p></o:p></SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt; mso-font-width: 100%; mso-text-raise: 0pt"><SPAN lang=EN-US style="FONT-FAMILY: 한양신명조; LETTER-SPACING: -1.2pt"></SPAN><STRONG><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #3a32c3; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ※ </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #3a32c3; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">입교식</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #3a32c3; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">(10.21.) :&nbsp; 8:30</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #3a32c3; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">분까지 입교</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프"><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #3a32c3">.</SPAN> </SPAN></STRONG><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">단정한 복장</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">(</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">가능하면 정장</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">)</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-FAMILY: 한양신명조; LETTER-SPACING: -1.2pt"><o:p></o:p></SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt; mso-font-width: 100%; mso-text-raise: 0pt"><STRONG><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">&nbsp;<SPAN style="FONT-FAMILY: 돋움,dotum; COLOR: #000000">&nbsp;○ </SPAN></SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">장소 </SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">: </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">인재개발원 대강당</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">(2</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">층</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">) </SPAN></STRONG></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-FAMILY: 한양신명조; LETTER-SPACING: -1.2pt"><o:p></o:p></SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">&nbsp;&nbsp;○ 교육대상</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조"> </SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">: </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">시</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">,</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">군</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">·</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">구 신규 공무원 394</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">명</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-FAMILY: 한양신명조; LETTER-SPACING: -1.2pt"><o:p></o:p></SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프"><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">&nbsp;&nbsp;○&nbsp;</SPAN> </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">내용 </SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-FAMILY: 한양신명조; LETTER-SPACING: -1.2pt"><o:p></o:p></SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN lang=EN-US style="FONT-FAMILY: 한양신명조; LETTER-SPACING: -1.2pt"></SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; - 1</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">주차 </SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">: </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">입교식</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">, </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">회계실무</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">, </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">민원실무</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">, </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">지방자치제도</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">, </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">청렴교육 등</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-FAMILY: 한양신명조; LETTER-SPACING: -1.2pt"><o:p></o:p></SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN lang=EN-US style="FONT-FAMILY: 한양신명조; LETTER-SPACING: -1.2pt"></SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;2</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">주차 </SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">: </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">예산 및 기획실무</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">, </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">필답평가</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">, </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">소양교육</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">, </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">수료식 등</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-SIZE: 11pt; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조"></SPAN><SPAN style="FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></P><SPAN style="FONT-SIZE: 11pt; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><STRONG><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 굴림체,gulimche; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조"></SPAN></STRONG><SPAN style="FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><STRONG><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조">□ </SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">교육신청</SPAN></STRONG></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"></SPAN><FONT size=3><SPAN style="FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></FONT></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-SIZE: 11pt"><STRONG><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #0c0cff; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 휴먼명조; mso-hansi-font-family: 휴먼명조">&nbsp; ○ </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #0c0cff; mso-fareast-font-family: 휴먼명조">집 합 교 육 &nbsp; 신 청&nbsp;</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #0c0cff; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 휴먼명조">:<SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 돋움,dotum"> </SPAN></SPAN></STRONG><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; FONT-WEIGHT: bold; COLOR: #0c0cff; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 휴먼명조"><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 돋움,dotum">2019.10.2.(수)~10.7</SPAN><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 돋움,dotum">.(월)</SPAN> <SPAN onclick=popupGrcodeList() style="FONT-FAMILY: 돋움,dotum; COLOR: #ff0000"></SPAN></SPAN></SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-SIZE: 11pt"><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; FONT-WEIGHT: bold; COLOR: #0c0cff; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 휴먼명조"></SPAN></SPAN><SPAN style="FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt; mso-font-width: 100%; mso-text-raise: 0pt"><SPAN><STRONG>&nbsp;<SPAN style="FONT-SIZE: 11pt">&nbsp;&nbsp;</SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; BACKGROUND-COLOR: #ffffff">&nbsp;</SPAN></STRONG><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; BACKGROUND-COLOR: #ffffff">&nbsp; ※ 집합교육 신청은 인재개발원 홈페이지 </SPAN><A href="http://hrd.incheon.go.kr/" target=_self><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; BACKGROUND-COLOR: #ffffff">(hrd.incheon.go.kr)</SPAN></A><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; BACKGROUND-COLOR: #ffffff"> 회원가입 필요</SPAN></SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt; mso-font-width: 100%; mso-text-raise: 0pt"><STRONG><SPAN style="FONT-SIZE: 11pt; COLOR: #3a32c3; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조"></SPAN></STRONG><SPAN style="FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum"><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 휴먼명조; FONT-WEIGHT: bold; COLOR: #0c0cff; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 휴먼명조"><SPAN style="FONT-SIZE: 11pt"><SPAN style="FONT-SIZE: 11pt; COLOR: #0c0cff; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 휴먼명조; mso-hansi-font-family: 휴먼명조"><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #0e24ed">&nbsp; ○ 사이버교육 수강 : 2019.10.2.(수)~10.27.(일) </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000"><SPAN style="COLOR: #ff0000"><A href="https://incheon.nhi.go.kr/" target=_blank><SPAN style="FONT-FAMILY: 돋움,dotum; COLOR: #ff0000">[바</SPAN><SPAN style="FONT-FAMILY: 돋움,dotum; COLOR: #ff0000">로가기]</SPAN></A></SPAN></SPAN></SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 돋움,dotum; COLOR: #0e24ed"></SPAN>&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum"><SPAN style="FONT-SIZE: 14pt; COLOR: #0c0cff"><FONT color=#000000></FONT>&nbsp;</P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt; mso-font-width: 100%; mso-text-raise: 0pt"><SPAN><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;</STRONG><SPAN style="FONT-FAMILY: 돋움,dotum; COLOR: #000000"><STRONG>&nbsp;<SPAN style="FONT-SIZE: 11pt"> </SPAN></STRONG><SPAN style="FONT-SIZE: 11pt">※ 사이버교육 신청은&nbsp;인천시 나라배움터&nbsp;</SPAN></SPAN><A href="http://incheon.nhi.go.kr/" target=_self><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000">(incheon.nhi.go.kr)</SPAN></A><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000"> 별도 회원가입 후 학습</SPAN></SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt">&nbsp;</P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><STRONG><SPAN style="FONT-SIZE: 11pt; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 굴림체,gulimche; COLOR: #000000"></SPAN></SPAN></STRONG><SPAN style="FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><STRONG><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000">□ 정책연구과제 제출&nbsp;</SPAN>:&nbsp;</SPAN></STRONG><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 휴먼명조"> </SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; FONT-WEIGHT: bold; COLOR: #000000; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 휴먼명조">2019. 10. 21.(월) 17:00 까지</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 휴먼명조; FONT-WEIGHT: bold; COLOR: #0c0cff; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 휴먼명조"><SPAN style="FONT-SIZE: 11pt; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조"><SPAN style="FONT-SIZE: 11pt; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조"></SPAN></SPAN></SPAN><SPAN style="FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 휴먼명조; FONT-WEIGHT: bold; COLOR: #0c0cff; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 휴먼명조"><SPAN style="FONT-SIZE: 11pt; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조"><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조">&nbsp;&nbsp;&nbsp;&nbsp; <SPAN style="FONT-FAMILY: 돋움,dotum">○&nbsp;</SPAN><SPAN style="FONT-FAMILY: 돋움,dotum">&nbsp;교번 부여된 최종 교육생 명단은&nbsp;10.10.(목) 공지 예정</SPAN></SPAN></SPAN></P>
<P class=0 style="FONT-SIZE: 12pt; LETTER-SPACING: 0pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; mso-font-width: 100%; mso-text-raise: 0pt">&nbsp;</P>
<P class=0 style="FONT-SIZE: 12pt; LETTER-SPACING: 0pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; mso-font-width: 100%; mso-text-raise: 0pt"><SPAN style="FONT-SIZE: 11pt; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조"><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN></SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조"><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조">&nbsp;&nbsp; </SPAN>정책과제물 제출 </SPAN><SPAN style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">시 공지된 교번으로 제출 요망</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">.</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"></SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 휴먼명조; FONT-WEIGHT: bold; COLOR: #0c0cff; LETTER-SPACING: 0pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 휴먼명조"></SPAN></SPAN><FONT face=굴림><SPAN style="FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></FONT></P><SPAN id=husky_bookmark_end_1568791271314></SPAN></SPAN>
<P class=0 style="LETTER-SPACING: -1.2pt; LINE-HEIGHT: 2; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조">※ </SPAN><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000">붙임 교육안내문에 따라&nbsp; 집합교육신청 및 사이버강의 수강</SPAN><SPAN lang=EN-US style="FONT-SIZE: 12pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">, </SPAN><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">정책과제물 작성</SPAN><SPAN lang=EN-US style="FONT-SIZE: 12pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프">· </SPAN><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">제출</SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프"></SPAN><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 돋움,dotum">&nbsp;</SPAN></P>
<P class=0 style="LETTER-SPACING: -1.2pt; LINE-HEIGHT: 2; TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프"></SPAN><SPAN lang=EN-US style="FONT-SIZE: 11pt; FONT-FAMILY: 돋움,dotum; COLOR: #ff0000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-ascii-font-family: 산세리프"><STRONG><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-font-width: 100%; mso-text-raise: 0pt; mso-fareast-font-family: 한양신명조; mso-hansi-font-family: 한양신명조">□ </SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 돋움,dotum; COLOR: #000000; LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조">문의사항 : 교육관련 (440-7673),&nbsp; 홈페이지 및 사이버교육(440-7684)</SPAN></STRONG></SPAN></P>
<P class=0 style="TEXT-AUTOSPACE: ; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt; tab-stops: left middot 424.4pt"><SPAN style="LETTER-SPACING: -1.2pt; mso-fareast-font-family: 한양신명조"></SPAN><SPAN style="FONT-FAMILY: 돋움,dotum; COLOR: #0e24ed">&nbsp;</SPAN></P>
<P class=0 style="TEXT-AUTOSPACE: ; tab-stops: left middot 424.4pt; mso-pagination: none; mso-padding-alt: 0pt 0pt 0pt 0pt"><SPAN style="font-size: 1em;  COLOR: #000000;" >첨부 파일 : <A href="javascript:fileDownloadOpen('20316', '1');"><SPAN style="font-size: 1.5em;">제3기 신임인재양성과정 안내문.hwp</SPAN></A> </SPAN></P>
<P>&nbsp;</P></TD>
									
													 					
						
									
								</TR>	
						</tbody>						
					</table>
		
					</form>
				</div>
			</div>  
