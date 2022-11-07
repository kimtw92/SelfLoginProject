<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>

<%

//String checkValue = "10C0000183,10C0000168,10C0000170,10C0000117,10C0000204,10C0000205,10C0000172,10C0000062,10C0000176,10C0000188,10C0000151,10C0000215,10C0000216,10C0000202,10C0000239,10G0000203"; // 중복가능과정

String checkValue = "10C0000117,10C0000151,10C0000168,10C0000170,10C0000176,10C0000188,10C0000202,10C0000205,10C0000223,10G0000203,10C0000239,10C0000214,10C0000291,10C0000281,10C0000282,10C00000962,10C0000293"; // 중복가능과정

String checkValue_social = "10C0000093,10C0000214,10C0000063,10C0000176,10C0000205,10C0000096,10C0000192,10C0000097,10C0000217,10C0000228,10C0000219,10C0000232,10C0000235,10C0000236,10C0000280,10C0000281,10C0000283,10C0000282,10C0000284"; // 사회복지과정

String checkValue_newbie = "10C0000215,10C0000216"; // 신규자 과정



// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);

StringBuffer sbListHtml = new StringBuffer();
StringBuffer sbListHtml2 = new StringBuffer();
StringBuffer sbListHtml3 = new StringBuffer();

StringBuffer sbListHtml4 = new StringBuffer();

//int iNum = 0;
int pNum1 = 1;
int pNum2 = 1;
int pNum3 = 1;
if(listMap.keySize("grcode") > 0) {
	
	/*
	for(int i=0; i < listMap.keySize("grcode"); i++) {
		if("10C0000055".equals(listMap.getString("grcode", i)) || "10C0000056".equals(listMap.getString("grcode", i))) {
			//임시추가 START
			sbListHtml.append("<tr>\n");
			sbListHtml.append("	<td class=\"bl0\"> "+(pNum++)+" </td>\n");
			sbListHtml.append("	<td class=\"sbj\" style=\"color:blue;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");>" + listMap.getString("grcodeniknm", i) + "</a></td>\n");
			sbListHtml.append("	<td>"+listMap.getString("grseq", i)+"기</td>\n");	
			sbListHtml.append("	<td>"+listMap.getString("seated", i)+" / "+listMap.getString("tseat", i)+"</td>\n");			
			sbListHtml.append("	<td>"+listMap.getString("applyDate", i)+"</td>\n");
			sbListHtml.append("	<td>"+listMap.getString("studyDate", i)+"</td>\n");
			if (listMap.getString("userno", i).length() > 0){
				sbListHtml.append("	<td><a href=\"javascript:go_cancel('"+listMap.getString("grcode", i)+"','"+listMap.getString("grseq", i)+"','"+listMap.getString("grcodeniknm", i)+"','"+listMap.getString("part", i)+"','"+listMap.getString("grgubun", i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_cancel03.gif\" alt=\"취소\" /></a></td>\n");
			} else {
				if(listMap.getString("restrict").length() > 0){
					sbListHtml.append("	<td><a href=\"javascript:alert('귀하는 이전기수 사이버교육을 미수료하여 60일간 수강신청이 제한되어 있습니다.');\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></a></td>\n");
				} else {
					sbListHtml.append("	<td><a href=\"javascript:go_apply('"+listMap.getString("grcode", i)+"','"+listMap.getString("grseq", i)+"','"+requestMap.getString("userno")+"','"+listMap.getString("grgubun", i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></td>\n");
				}
			}
			
			sbListHtml.append("	<td><strong class=\"txt_org\">"+listMap.getString("applyStatus", i)+"</span></td>\n");
			sbListHtml.append("	<td>"+listMap.getString("appdate", i)+"</td>\n");
			sbListHtml.append("	<td>"+listMap.getString("time", i)+"</td>\n");
			sbListHtml.append("</tr>\n");
			//임시추가 END
		}
	}
	*/
	// 체크 리스트
	String checklist = "10C0000183,10C0000168,10C0000170,10C0000117,10C0000204,10C0000205,10C0000172,10C0000062,10C0000176,10C0000188,10C0000151,10C0000291,10C0000281,10C0000282,10C00000962,10C0000293";
	
	for(int i=0; i < listMap.keySize("grcode"); i++){
		
		
		/* if("6280000".equals(listMap.getString("dept"))){
			if(!"10G0000259".equals(listMap.getString("grcode", i)) && !"10G0000257".equals(listMap.getString("grcode", i)) && !"10G0000267".equals(listMap.getString("grcode", i)) && !"10G0000192".equals(listMap.getString("grcode", i))) {
				sbListHtml.append("	<td><a href=\"javascript:alert('기타기관 회원은 학습불가 과정입니다.');\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></a></td>\n");
			}
		} */
		//임시 추가 if
		if (checkValue_newbie.indexOf(listMap.getString("grcode", i)) != -1) {
			
			if(!"10C0000055".equals(listMap.getString("grcode", i)) && !"10C0000056".equals(listMap.getString("grcode", i))) {
							
				sbListHtml4.append("<tr>\n");		
	
				String seated = listMap.getString("seated",i);
				
				sbListHtml4.append("	<td class=\"bl0\">"+ pNum1++ +"</td>\n");
				
				
				if(checkValue.indexOf(listMap.getString("grcode", i)) != -1) {
					sbListHtml4.append("	<td class=\"sbj\" style=\"color:red;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");><font color=\"red\">" + listMap.getString("grcodeniknm", i) + "</font></a></td>\n");					
					
				} else {			
					sbListHtml4.append("	<td class=\"sbj\" style=\"color:blue;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");>" + listMap.getString("grcodeniknm", i) + "</a></td>\n");
				}
				
				sbListHtml4.append("	<td>"+listMap.getString("grseq",i).substring(4,6)+"기</td>\n");
				
				if (Integer.parseInt(seated)>= Integer.parseInt(listMap.getString("tseat",i))) {
					sbListHtml4.append("	<td>"+listMap.getString("tseat",i)+" / "+listMap.getString("tseat",i)+"</td>\n");
				} else {
					sbListHtml4.append("	<td>"+seated+" / "+listMap.getString("tseat",i)+"</td>\n");
				}
				
				
				//sbListHtml.append("	<td>"+listMap.getString("seated",i)+" / "+listMap.getString("tseat",i)+"</td>\n");
				sbListHtml4.append("	<td>"+listMap.getString("applyDate",i)+"<BR>\n");
				sbListHtml4.append("	"+listMap.getString("studyDate",i)+"</td>\n");
				if (listMap.getString("userno",i).length() > 0){
					sbListHtml4.append("	<td><a href=\"javascript:go_cancel('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("grcodeniknm",i)+"','"+listMap.getString("part",i)+"','"+listMap.getString("grgubun", i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_cancel03.gif\" alt=\"취소\" /></a></td>\n");
				} else {
					if (listMap.getString("restrict").length() > 0){
						sbListHtml4.append("	<td><a href=\"javascript:alert('귀하는 이전기수 사이버교육을 미수료하여 60일간 수강신청이 제한되어 있습니다.');\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></a></td>\n");
					} else {
						// sbListHtml.append("<td><input type=\"checkbox\" name=\"checkBox\" value=\""+listMap.getString("grcode",i)+"|"+listMap.getString("grseq",i)+"|"+listMap.getString("grcodeniknm",i)+"\"></td>");
						
						if  (Integer.parseInt(seated)>= Integer.parseInt(listMap.getString("tseat",i))) {
							//사이버 과정이면서 인원 초과이면 마감
							sbListHtml4.append("<td>마감</td>");
						} 
						else
						{
							sbListHtml4.append("	<td><a href=\"javascript:go_apply('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+requestMap.getString("userno")+"','"+listMap.getString("grgubun",i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></td>\n");
						}
						
					}
				}
				
				sbListHtml4.append("	<td><strong class=\"txt_org\">"+listMap.getString("applyStatus",i)+"</span></td>\n");
				sbListHtml4.append("	<td>"+listMap.getString("appdate",i)+"</td>\n");
				sbListHtml4.append("	<td>"+listMap.getString("time",i)+"</td>\n");
				sbListHtml4.append("</tr>\n");
				//iNum ++;
			}
		} else if (checkValue_social.indexOf(listMap.getString("grcode", i)) != -1) {
			if(!"10C0000055".equals(listMap.getString("grcode", i)) && !"10C0000056".equals(listMap.getString("grcode", i))) {
							
				sbListHtml.append("<tr>\n");		
	
				String seated = listMap.getString("seated",i);
				
				sbListHtml.append("	<td class=\"bl0\">"+ pNum1++ +"</td>\n");
				
				
				if(checkValue.indexOf(listMap.getString("grcode", i)) != -1) {
					sbListHtml.append("	<td class=\"sbj\" style=\"color:red;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");><font color=\"red\">" + listMap.getString("grcodeniknm", i) + "</font></a></td>\n");					
					
				} else {			
					sbListHtml.append("	<td class=\"sbj\" style=\"color:blue;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");>" + listMap.getString("grcodeniknm", i) + "</a></td>\n");
				}
				
				sbListHtml.append("	<td>"+listMap.getString("grseq",i).substring(4,6)+"기</td>\n");
				
				if (Integer.parseInt(seated)>= Integer.parseInt(listMap.getString("tseat",i))) {
					sbListHtml.append("	<td>"+listMap.getString("tseat",i)+" / "+listMap.getString("tseat",i)+"</td>\n");
				} else {
					sbListHtml.append("	<td>"+seated+" / "+listMap.getString("tseat",i)+"</td>\n");
				}
				
				
				//sbListHtml.append("	<td>"+listMap.getString("seated",i)+" / "+listMap.getString("tseat",i)+"</td>\n");
				sbListHtml.append("	<td>"+listMap.getString("applyDate",i)+"<BR>\n");
				sbListHtml.append("	"+listMap.getString("studyDate",i)+"</td>\n");
				if (listMap.getString("userno",i).length() > 0){
					sbListHtml.append("	<td><a href=\"javascript:go_cancel('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("grcodeniknm",i)+"','"+listMap.getString("part",i)+"','"+listMap.getString("grgubun", i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_cancel03.gif\" alt=\"취소\" /></a></td>\n");
				} else {
					if (listMap.getString("restrict").length() > 0){
						sbListHtml.append("	<td><a href=\"javascript:alert('귀하는 이전기수 사이버교육을 미수료하여 60일간 수강신청이 제한되어 있습니다.');\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></a></td>\n");
					} else {
						// sbListHtml.append("<td><input type=\"checkbox\" name=\"checkBox\" value=\""+listMap.getString("grcode",i)+"|"+listMap.getString("grseq",i)+"|"+listMap.getString("grcodeniknm",i)+"\"></td>");
	
						if  (Integer.parseInt(seated)>= Integer.parseInt(listMap.getString("tseat",i))) {
							//사이버 과정이면서 인원 초과이면 마감
							sbListHtml.append("<td>마감</td>");
						} else {
							sbListHtml.append("	<td><a href=\"javascript:go_apply('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+requestMap.getString("userno")+"','"+listMap.getString("grgubun",i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></td>\n");
						}
						
					}
				}
				
				sbListHtml.append("	<td><strong class=\"txt_org\">"+listMap.getString("applyStatus",i)+"</span></td>\n");
				sbListHtml.append("	<td>"+listMap.getString("appdate",i)+"</td>\n");
				sbListHtml.append("	<td>"+listMap.getString("time",i)+"</td>\n");
				sbListHtml.append("</tr>\n");
				//iNum ++;
			}
		
		} else  if (listMap.getString("grgubun", i).equals("C")) {
			
			if(!"10C0000055".equals(listMap.getString("grcode", i)) && !"10C0000056".equals(listMap.getString("grcode", i))) {
				
				sbListHtml2.append("<tr>\n");		
	
				String seated = listMap.getString("seated",i);
				
				sbListHtml2.append("	<td class=\"bl0\">"+ pNum2++ +"</td>\n");
				
				if(checkValue.indexOf(listMap.getString("grcode", i)) != -1) {
					sbListHtml2.append("	<td class=\"sbj\" style=\"color:red;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");><font color=\"red\">" + listMap.getString("grcodeniknm", i) + "</font></a></td>\n");
				
				} else {			
					sbListHtml2.append("	<td class=\"sbj\" style=\"color:blue;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");>" + listMap.getString("grcodeniknm", i) + "</a></td>\n");
				}
				
				sbListHtml2.append("	<td>"+listMap.getString("grseq",i).substring(4,6)+"기</td>\n");
				
				if (Integer.parseInt(seated)>= Integer.parseInt(listMap.getString("tseat",i))) {
					sbListHtml2.append("	<td>"+listMap.getString("tseat",i)+" / "+listMap.getString("tseat",i)+"</td>\n");
				} else {
					sbListHtml2.append("	<td>"+seated+" / "+listMap.getString("tseat",i)+"</td>\n");
				}
				
				
				//sbListHtml.append("	<td>"+listMap.getString("seated",i)+" / "+listMap.getString("tseat",i)+"</td>\n");
				sbListHtml2.append("	<td>"+listMap.getString("applyDate",i)+"<BR>\n");
				sbListHtml2.append("	"+listMap.getString("studyDate",i)+"</td>\n");
				if (listMap.getString("userno",i).length() > 0){
					sbListHtml2.append("	<td><a href=\"javascript:go_cancel('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("grcodeniknm",i)+"','"+listMap.getString("part",i)+"','"+listMap.getString("grgubun", i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_cancel03.gif\" alt=\"취소\" /></a></td>\n");
				} else {
					if (listMap.getString("restrict").length() > 0){
						sbListHtml2.append("	<td><a href=\"javascript:alert('귀하는 이전기수 사이버교육을 미수료하여 60일간 수강신청이 제한되어 있습니다.');\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></a></td>\n");
					} else {
						// sbListHtml.append("<td><input type=\"checkbox\" name=\"checkBox\" value=\""+listMap.getString("grcode",i)+"|"+listMap.getString("grseq",i)+"|"+listMap.getString("grcodeniknm",i)+"\"></td>");
	
						if ( (Integer.parseInt(seated)>= Integer.parseInt(listMap.getString("tseat",i)))) {
							//사이버 과정이면서 인원 초과이면 마감
							sbListHtml2.append("<td>마감</td>");
						} else {
							sbListHtml2.append("	<td><a href=\"javascript:go_apply('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+requestMap.getString("userno")+"','"+listMap.getString("grgubun",i)+"','"+listMap.getString("deptnm",i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></td>\n");
						}
						
					}
				}
				
				sbListHtml2.append("	<td><strong class=\"txt_org\">"+listMap.getString("applyStatus",i)+"</span></td>\n");
				sbListHtml2.append("	<td>"+listMap.getString("appdate",i)+"</td>\n");
				sbListHtml2.append("	<td>"+listMap.getString("time",i)+"</td>\n");
				sbListHtml2.append("</tr>\n");
				//iNum ++;
			}
			
		} else if (listMap.getString("grgubun", i).equals("G")) {
			
			if(!"10C0000055".equals(listMap.getString("grcode", i)) && !"10C0000056".equals(listMap.getString("grcode", i))) {
				
				sbListHtml3.append("<tr>\n");		
	
				String seated = listMap.getString("seated",i);
				
				sbListHtml3.append("	<td class=\"bl0\">"+ pNum3++ +"</td>\n");				
			
				
				if(checkValue.indexOf(listMap.getString("grcode", i)) != -1) {
					sbListHtml3.append("	<td class=\"sbj\" style=\"color:red;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");><font color=\"red\">" + listMap.getString("grcodeniknm", i) + "</font></a></td>\n");
					
				} else {			
					sbListHtml3.append("	<td class=\"sbj\" style=\"color:blue;\"><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\");>" + listMap.getString("grcodeniknm", i) + "</a></td>\n");
				}
				
				sbListHtml3.append("	<td>"+listMap.getString("grseq",i).substring(4,6)+"기</td>\n");
			
				sbListHtml3.append("	<td>"+seated+" / "+listMap.getString("tseat",i)+"</td>\n");
				
				//sbListHtml.append("	<td>"+listMap.getString("seated",i)+" / "+listMap.getString("tseat",i)+"</td>\n");
				sbListHtml3.append("	<td>"+listMap.getString("applyDate",i)+"<BR>\n");
				sbListHtml3.append("	"+listMap.getString("studyDate",i)+"</td>\n");
				if (listMap.getString("userno",i).length() > 0){
					sbListHtml3.append("	<td><a href=\"javascript:go_cancel('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("grcodeniknm",i)+"','"+listMap.getString("part",i)+"','"+listMap.getString("grgubun", i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_cancel03.gif\" alt=\"취소\" /></a></td>\n");
				} else {
					if (listMap.getString("restrict").length() > 0){
						sbListHtml3.append("	<td><a href=\"javascript:alert('귀하는 이전기수 사이버교육을 미수료하여 60일간 수강신청이 제한되어 있습니다.');\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></a></td>\n");
					} else {
						// sbListHtml.append("<td><input type=\"checkbox\" name=\"checkBox\" value=\""+listMap.getString("grcode",i)+"|"+listMap.getString("grseq",i)+"|"+listMap.getString("grcodeniknm",i)+"\"></td>");
						sbListHtml3.append("	<td><a href=\"javascript:go_apply('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+requestMap.getString("userno")+"','"+listMap.getString("grgubun",i)+"','"+listMap.getString("deptnm",i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_request03.gif\" alt=\"취소\" /></td>\n");
						
					}
				}
				
				sbListHtml3.append("	<td><strong class=\"txt_org\">"+listMap.getString("applyStatus",i)+"</span></td>\n");
				sbListHtml3.append("	<td>"+listMap.getString("appdate",i)+"</td>\n");
				sbListHtml3.append("	<td>"+listMap.getString("time",i)+"</td>\n");
				sbListHtml3.append("</tr>\n");
				//iNum ++;
			}
			
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
	pform.action = "/homepage/attend.do?mode=attendList";
	pform.submit();
}
//리스트
function goSearch(){
	pform.action = "/homepage/attend.do?mode=attendList";
	pform.submit();
}
//리스트
function onView(form){
	$("qu").value = "discussView";
	pform.action = "/homepage/attend.do?mode=discussView&seq="+form;
	pform.submit();
}


function go_apply(grcode, grseq, userno, grgubun,deptnm){
	
	var limits = "1";
	var limit = "2";
	var url = "/mypage/myclass.do";
    var pars = "mode=ajaxGetGrseq";
	pars += "&grseq="+grseq;
	pars += "&userno="+userno;
	pars += "&grcode="+grcode;
	pars += "&deptnm="+deptnm;
	var myAjax = new Ajax.Request(
		url, 
		{
			method: "post", 
			parameters: pars,
			onSuccess : function(transport){				
				 	
				limits = transport.responseText.trim();				
				limit = limits.split(',');  				
				var limitNumber = limit[1]+','+limit[2]+','+limit[3]+','+limit[4];				
					
				var result = eval(transport.responseText.trim());		

				if(Number(limit[0]) == 6280000 && limitNumber.indexOf('1') != -1){					
					alert('시 공무원은 교육신청 대상이 아닙니다 \r\n회원님의 기관을 확인해주세요');
					
				}else if(Number(limit[0]) <= 3580000 && limitNumber.indexOf('2') != -1){					
					alert('군·구 공무원은 교육신청 대상이 아닙니다 \r\n회원님의 기관을 확인해주세요');
					
				}else if(Number(limit[0]) == 6289999 && limitNumber.indexOf('3') != -1){
					alert('공사,공단 직원은 교육신청 대상이 아닙니다  \r\n회원님의 기관을 확인해주세요');	
					
				}else if(Number(limit[0]) == 9999999 && limitNumber.indexOf('4') != -1){
					alert('기타기관 직원은 교육신청 대상이 아닙니다  \r\n회원님의 기관을 확인해주세요');
					
				}/* else if(Number(limit[0]) == -200){						
					alert("본 과정은 선착순 수강 신청이 마감되었습니다.");
					
				} */else if(Number(limit[0]) == -300){						
					alert("이미 수강했던 과정입니다. 다른과정을 신청해 주세요.");
					
				}else{
					go_apply1(grcode, grseq, userno, grgubun);					
				}				
				
						
		}
			,onFailure : function(){					
				alert("데이타를 가져오지 못했습니다.");
			}				
		}
	); 
	
	
	
	
	

}

//글쓰기
function go_apply1(grcode, grseq, userno, grgubun){
	var chkBox = document.pform.checkBox;
	var chkNum = 0;
	var url = "/homepage/attend.do";
	url += "?mode=attendPopup";
	url += "&grcode="+grcode;
	url += "&grseq="+grseq;
	url += "&userno="+userno;
	url += "&grgubun="+grgubun;
	pwinpop = popWin(url,"attendPop","500","530","yes","yes");

}




//과정 신청
function go_applyInfo(grcode,grseq,userno,deptcode,deptnm,deptsub,degreename,jik,hp,email,upsdate,ldapcode,grgubun){
		var url = "/homepage/attend.do";
		if(grgubun == "C") {
			pars = "mode=applyInfo2";
		} else {
			pars = "mode=applyInfo";
		}

		pars += "&grcode="+grcode+"&grseq="+grseq+"&userno="+userno+"&deptcode="+deptcode
		+"&deptnm="+deptnm+"&deptsub="+deptsub+"&degreename="+degreename+"&hp="+hp+"&email="+email+"&jik="+jik+"&upsdate="+upsdate+"&ldapcode="+ldapcode;
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

			var url = "/homepage/attend.do";

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
	pform.action = "/homepage/attend.do?mode=attendDetail";
	pform.submit();
}

//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left3.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual3">교육과정</div>
            <div style="margin-bottom: -15px;" class="local">
              <h2>교육신청 및 취소</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육신청 &gt; <span>교육신청 및 취소</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
<!-- ※ 인재개발원 공무원 사이버전문교육과정은 <font color="blue">월 1개 과정만 수강신청이 가능</font>합니다.<br />
(단, 정부 정책 부응을 위해 <font color="red">붉은색 표기 과정은 중복신청 가능</font>)<br /> -->
			<h3>사이버 전문교육 학습안내</h3>
			<a href="http://incheon.nhi.go.kr/"><font color="red"> 2019년부터 사이버 전문교육은 인천시 나라배움터 사이트에서 학습가능 <br/>나라배움터 학습 사이트 바로가기 : incheon.nhi.go.kr</font></a>
<br/><br/>
            <ol class="TabSub">
            <li class="TabOn"><a href="javascript:fnGoMenu('4','attendList')">교육신청</a></li>
            <li class="last"><a href="javascript:fnGoMenu('4','attendDetail')">교육신청이력</a></li>
          </ol>

			  <form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden"  name="qu" >
<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
					<div id="content">
						<%-- <div class="btnR"><a href="javascript:goDetail();"><img src="/images/<%= skinDir %>/button/btn_reqList01.gif" alt="수강신청취소/상세확인" /></a></div> --%>
						
						<% if (!sbListHtml.toString().trim().isEmpty())  {%>
						
						<div class="h9"></div>
						<p padding-top:"20px"><B>[사이버교육 / 사회복지 분야]</B></p>
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="30" />
							<col width="*" />
							<col width="40" />
							<col width="57" />
							<col width="90" />
							<col width="40" />
							<col width="48" />
							<col width="70" />
							<col width="30" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>	
							<th>과정명</th>
							<th>기수</th>
							<th>신청현황</th>
							<th>신청기간<BR>학습기간</th>
							<th>신청</th>
							<th>상태</th>
							<th>신청일</th>
							<th>교육시간</th>
						</tr>
						</thead>
			
						<tbody>
							<%=sbListHtml.toString() %>
						</tbody>						
						</table>
						
						<% } %> 
						
						<!-- data -->
						
						<% if (!sbListHtml2.toString().trim().isEmpty())  {%>
						
						<div class="h9"></div>
						<p padding-top:"20px"><B>[사이버교육]</B></p>
						<table class="bList01">	
						<colgroup>
							<col width="30" />
							<col width="*" />
							<col width="56" />
							<col width="57" />
							<col width="80" />
							<col width="40" />
							<col width="48" />
							<col width="70" />
							<col width="30" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>	
							<th>과정명</th>
							<th>기수</th>
							<th>신청현황</th>
							<th>신청기간<BR>학습기간</th>
							<th>신청</th>
							<th>상태</th>
							<th>신청일</th>
							<th>교육시간</th>
						</tr>
						</thead>
			
						<tbody>
							<%=sbListHtml2.toString() %>
						</tbody>
						
						</table>
						<% } %> 
						
						
						<%-- 
						<% if (!sbListHtml4.toString().trim().isEmpty())  {%>
						
						<div class="h9"></div>
						<p padding-top:"20px"><B>[사이버교육  / 신규채용자과정 ]</B></p>
						<table class="bList01">	
						<colgroup>
							<col width="30" />
							<col width="*" />
							<col width="56" />
							<col width="57" />
							<col width="80" />
							<col width="40" />
							<col width="48" />
							<col width="70" />
							<col width="30" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>	
							<th>과정명</th>
							<th>기수</th>
							<th>신청현황</th>
							<th>신청기간<BR>학습기간</th>
							<th>신청</th>
							<th>상태</th>
							<th>신청일</th>
							<th>교육시간</th>
						</tr>
						</thead>
			
						<tbody>
							<%=sbListHtml4.toString() %>
						</tbody>
						
						</table>
						<% } %> 
						 --%>
						
						
						
						<% if (!sbListHtml3.toString().trim().isEmpty())  {%>
						
						<div class="h9"></div>						
						<p padding-top:"20px"><B>[집합교육]</B></p>
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="30" />
							<col width="*" />
							<col width="56" />
							<col width="57" />
							<col width="80" />
							<col width="40" />
							<col width="48" />
							<col width="70" />
							<col width="30" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>	
							<th>과정명</th>
							<th>기수</th>
							<th>신청현황</th>
							<th>신청기간<BR>학습기간</th>
							<th>신청</th>
							<th>상태</th>
							<th>신청일</th>
							<th>교육시간</th>
						</tr>
						</thead>
			
						<tbody>
							<%=sbListHtml3.toString() %>
						</tbody>
						</table>
						
						<% }%>
						
						
						
						<div class="BtmLine"></div>
						<div class="space"></div>						
						              						
					</div>
					
				</form>
				<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100013" /></jsp:include>
				<div class="h80"></div>
              
            <!-- //contnet -->
          </div>
        </div>
    	
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>