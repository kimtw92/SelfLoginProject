<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%


String checkValue = "10C0000183,10C0000168,10C0000170,10C0000117,10C0000204,10C0000205,10C0000172,10C0000062,10C0000176,10C0000188,10C0000151,10C0000215,10C0000216"; // 중복가능과정


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
			
			sbListHtml.append("	<td class=\"sbj\" style=\"color:blue;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");>" + listMap.getString("grcodeniknm", i) + "</a></td>\n");
			
			sbListHtml.append("	<td>"+seated+" / "+listMap.getString("tseat",i)+"</td>\n");
			sbListHtml.append("	<td>"+listMap.getString("applyDate",i)+"</td>\n");			
			sbListHtml.append("	<td>"+listMap.getString("studyDate",i)+"</td>\n");
			
			if (listMap.getString("userno",i).length() > 0){
				sbListHtml.append("	<td><a href=\"javascript:go_cancel('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("grcodeniknm",i)+"','"+listMap.getString("part",i)+"','"+listMap.getString("grgubun", i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_cancel03.gif\" alt=\"취소\" /></a></td>\n");
			} else {
				if (listMap.getString("restrict").length() > 0){
					sbListHtml.append("	<td><a href=\"javascript:alert('귀하는 이전기수 사이버교육을 미수료하여 60일간 수강신청이 제한되어 있습니다.');\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"제한\" /></a></td>\n");
				} else {
					// sbListHtml.append("<td><input type=\"checkbox\" name=\"checkBox\" value=\""+listMap.getString("grcode",i)+"|"+listMap.getString("grseq",i)+"|"+listMap.getString("grcodeniknm",i)+"\"></td>");
					sbListHtml.append("	<td><a href=\"javascript:go_apply('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+requestMap.getString("userno")+"','"+listMap.getString("grgubun",i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"신청\" /></td>\n");
				}
			}
			
			sbListHtml.append("	<td><strong class=\"txt_org\">"+listMap.getString("applyStatus",i)+"</span></td>\n");
			sbListHtml.append("	<td>"+listMap.getString("appdate",i)+"</td>\n");
			if (listMap.getString("time",i).equals("0")) {
				sbListHtml.append("	<td><b><font color=red>없음</font></b></td>\n");
			} else {
				sbListHtml.append("	<td><b>"+listMap.getString("time",i)+"시간 "+listMap.getString("minute",i)+"분</b></td>\n");
			}
			
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
	pform.action = "/commonInc/popup.do?mode=basiclist";
	pform.submit();
}
//리스트
function goSearch(){
	pform.action = "/commonInc/popup.do?mode=basiclist";
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
						<h2>2018년 공무원집합사이버교육 과정</h2><br />
						<br />
						</center>
						
						<h4>※ 교육시간은<B><font color="red"> 교육시간관리시스템(인사행정시스템)에 개별등록</font></B> 하시기 바랍니다. <br />
						※ 일부 과정은 교육시간 인정이 안됩니다.  <br />
						&nbsp;&nbsp;&nbsp;&nbsp;(공사 공단은 각기관 교육 담당자에게 문의바람)
					   	</h4>

						<!-- //title -->
						<!-- <div class="btnR"><a href="javascript:goDetail();"><img src="/images/<%= skinDir %>/button/btn_reqList01.gif" alt="수강신청취소/상세확인" /></a></div> -->
						<div class="h9"></div>
			
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
							<th>인원</th>
							<th>신청기간</th>
							<th>학습기간</th>
							<th>신청</th>
							<th>상태</th>
							<th>신청일</th>
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
							<%=sbListHtml.toString() %>
						</tbody>
						
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>
						<div class="space"></div>						
						              
			
						
						<div class="h80"></div>
						</form>
				</div>
		  
        </div> 
    </div>