<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 학적정보 수정 팝업
// date : 2008-06-03
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize() > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}

	StringBuffer html  = new StringBuffer();
	if(listMap.keySize("name") > 0 ){
		for(int i = 0; listMap.keySize()>i; i++){
			
			html.append("<tr bgcolor = \"#FFFFFF\" align='center'>");
			html.append("  	<td height=\"25\" class=\"tableline11\">"+(pageNum - i)+"</td>");
			html.append("  	<td class=\"tableline11\">"+listMap.getString("name",i)+"</td>");
			html.append("  	<td class=\"tableline11\">&nbsp;"+listMap.getString("deptnm",i)+"</td>");
			html.append("		<td class=\"tableline11\">&nbsp;"+listMap.getString("partnm",i)+"</td>");
			html.append("  	<td class=\"tableline11\">"+listMap.getString("gadminnm",i)+"</td>");
			html.append("  	<td class=\"tableline11\">"+listMap.getString("idate",i)+"</td>");
			html.append("  	<td class=\"tableline11\">"+listMap.getString("cdate",i)+"</td>");
			html.append("  	<td class=\"tableline21\">"+listMap.getString("lname",i)+"</td>");
			html.append("</tr>");
		}
	}else if(listMap.keySize("name") <= 0){
		html.append("<tr>");
		html.append("	<td colspan=\"100%\" bgcolor=\"#FFFFFF\" height=\"300\" align=\"center\"> 데이터가 없습니다.</td>");
		html.append("</tr>");
		
	}
	

%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


/*********************************************************** 날짜함수 [s]******************************************************/
// 시작일자
function fnSDate(){

 result = window.showModalDialog("/commonInc/jsp/calendar.jsp","calendar", "dialogWidth:220px; dialogHeight:267px; center:yes; status:no;");
 
 if (result == -1 || result == null || result == "")   return;
 
 
 if (result == "DeleteDate"){
  $("iDate").value = "";
  return;
 }
 
 firstList = result.split(";");
 
 if($("cDate").value != ""){
        if($("cDate").value < firstList[0]){
	       $("iDate").value = "";
            return;
        }
    }
 
 $("iDate").value = firstList[0];
}

// 종료일자
function fnEDate(){

	result = window.showModalDialog("/commonInc/jsp/calendar.jsp","calendar", "dialogWidth:220px; dialogHeight:267px; center:yes; status:no;");
	
	if (result == -1 || result == null || result == "")   return;
	
	if (result == "DeleteDate"){
		$("cDate").value = "";
		return;
	}
	
	firstList = result.split(";");
	
	if($("iDate").value != ""){
	       if($("iDate").value > firstList[0]){
	           alert('종료일이 시작일보다 작습니다. 다시 입력하시기 바랍니다.');
	           $("cDate").value = "";
	           return;
	       }
	   }
	   
	$("cDate").value = firstList[0];
	
}

/*********************************************************** 날 함수 [e]******************************************************/

function report_print() {
  var form  = document.f;
  var p_strdate   = $("iDate").value;
  var p_enddate   = $("cDate").value;

  if(p_strdate == '') {
    alert('시작일을 입력하세요');
    return false;
  }

  if(p_enddate == '') {
    alert('종료일을 입력하세요');
    return false;
  }

  params  = 'init_mode=view';
  popAI("http://152.99.42.130/report/report_1.jsp?p_strdate=" + p_strdate + "&p_enddate=" + p_enddate);
}


//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//리스트
function go_list(mode,qu){
	
	//모드값이 없을경우를 대비하여 만듬
	if(mode == null || mode == ""){
		$("mode").value = "adminFormPop";
	}else{
		$("mode").value = mode;
	}
	
	//검색시 페이징 초기화.
	if(qu == "search"){
		$("currPage").value = "";
	}
	
	if($("iDate").value != null && $("cDate").value ==null || $("iDate").value != "" && $("cDate").value =="") {
		alert("종료일을 선택하여 주십시오");
		return false;
	}else if($("iDate").value == null && $("cDate").value != null || $("iDate").value == "" && $("cDate").value !="") {
		alert("시작일을 선택하여 주십시오");
		return false;
	
	}
	

	pform.action ="/member/member.do";
	pform.submit();
}
//-->
</SCRIPT>

<body leftmargin="0" topmargin=0>
	<form name="pform">
	<input type="hidden" name="mode">
	<input type="hidden" name="qu">
	<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
	<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId")%>">
	<input type="hidden" name="userno" value="<%=requestMap.getString("userno") %>">
	
    <table cellspacing="0"  cellpadding="0" border="0" style="padding:0 0 0 0" width="100%" height="100%">
        <tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
        <tr>
            <td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
                <!-- [s]타이틀영역-->
                <table cellspacing="0" cellpadding="0" border="0">
                    <tr>
                    	<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
						<td><font color="#000000" style="font-weight:bold; font-size:13px">특수권한자 이력현황</font></td>
                    </tr>
                </table>
                <!-- [e]타이틀영역-->
            </td>
        </tr>
        
        <tr>
            <td height="100%" class="popupContents " valign="top">
                <!-- [s]본문영역-->
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC">
					<tr>
						<td height="2" colspan="100%" bgcolor="#5071B4" style="" ></td>
					</tr>
					<tr>
						<td colspan="100%">
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="">
								<tr>
									<td height="30" colspan=3  align="center" bgcolor="#F7F7F7" class="tableline11"><strong>검색 기간 : </strong></td>
									<td width="40%" bgcolor="#ffffff" align="center" class="tableline11">
										<input type = text name ="iDate" onclick="fnSDate();" size = 8 maxlength = 8 value = "<%=requestMap.getString("iDate") %>" readonly>
										<a href = "javascript:void(0)" onclick="fnSDate();">
										<img src = "/images/icon_calendar.gif" border = 0 align = absmiddle></a> ~
										<input type = text name ="cDate" onclick="fnEDate();" size = 8 maxlength = 8 value = "<%=requestMap.getString("cDate") %>" readonly>
										<a href = "javascript:void(0)" onclick="fnEDate();">
										<img src = "/images/icon_calendar.gif" border = 0 align = absmiddle></a>
									</td>
									<td bgcolor="#FFFFFF" align="center">
										<input type="button" class="boardbtn1" value="검색" onclick="go_list('adminFormPop','search')">
										&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="button" class="boardbtn1" value="출력" onclick="report_print();">
									</td>		
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td height="2" colspan="100%" bgcolor="#5071B4" style="" ></td>
					</tr>
					<tr>
						<td height="30" colspan="100%" bgcolor="#FFFFFF" style="" ></td>
					</tr>
					<tr>
						<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
					</tr>
					<tr align = center bgcolor="#5071B4">
					  	<td height = 28 class="tableline11 white"><strong>연번</strong></td>
					  	<td class="tableline11 white"><strong>성명</strong></td>
					  	<td class="tableline11 white"><strong>담당기관</strong></td>
						<td class="tableline11 white"><strong>부서</strong></td>
					  	<td class="tableline11 white"><strong>권한</strong></td>
					  	<td class="tableline11 white"><strong>지정일</strong></td>
					  	<td class="tableline11 white"><strong>삭제일</strong></td>
					  	<td class="tableline21 white"><strong>지정인</strong></td>	
					  </tr>
					  <%=html.toString() %>
					  <tr>
						<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
					</tr>
				</table>
				 <!-- space --><table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable"><tr><td height="10"></td></tr></table>
				<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
               		<tr>
               			<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
               		</tr>
               	</table>
				<!-- [E]본문영역-->		
            </td>
        </tr>
	    
	</table>
	</form>
</body>
<script language="JavaScript">
document.write(tagAIGeneratorOcx);
</script>

	