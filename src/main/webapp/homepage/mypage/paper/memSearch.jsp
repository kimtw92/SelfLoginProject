<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 회원정보 검색
// date		: 2008-09-30
// auth 	: jong03
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<link rel="stylesheet" type="text/css" href="/commonInc/css/<%=skinDir %>/popup.css" />
<%


// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);
StringBuffer strHtml = new StringBuffer();

String pageStr = "";
int iNum = 0;
if (requestMap.getString("search").length() > 0){
		
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	
	// 페이징 필수
	FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	
	if(listMap.keySize("userno") > 0){		
		for(int i=0; i < listMap.keySize("userno"); i++){
		
			strHtml.append("<tr>\n");
			strHtml.append("<input type='hidden' name='username' value='"+listMap.getString("name",i)+"'>\n");
			strHtml.append("<td><input type='checkbox' name='userno' value='"+listMap.getString("userno",i)+"'></td>\n");
			strHtml.append("<td>"+listMap.getString("userId",i)+"</td>\n");
			strHtml.append("<td class=\"sbj\">"+listMap.getString("name",i)+"</td>\n");
			strHtml.append("</tr>\n");
			
			iNum ++;
		}
		pageStr = pageNavi.FrontPageStr();
		
	}else{
		
		strHtml.append("<tr>\n")
			.append("<td colspan=\"3\">검색결과가 없습니다.</td>\n")
			.append("</tr>\n");
	}
}
%>
<script language="JavaScript" type="text/JavaScript">
<!--

function goSearch(){
	// alert("확인");
	pform.action = "/mypage/paper.do?mode=memberList";
	pform.submit();
}

function setMember(){

	var chkNo = document.pform.userno;
	var chkName = document.pform.username;

	var noVal = "";
	var nameVal = "";

	var chkNum = 0;
	
<%	if (iNum > 1){%>
	for (var i=0,l=chkNo.length;i<l;i++){
		if (chkNo[i].checked == true){
			noVal = noVal + chkNo[i].value + ";";
			nameVal = nameVal + chkName[i].value + ";";
			chkNum ++;
		}
	}
<%} else {%>
	if (chkNo.checked == true){
		noVal = chkNo.value + ";";
		nameVal = chkName.value + ";";
		chkNum ++;
	}
<%}%>
	
	if (chkNum > 0){
		opener.pform.recieveNo.value += noVal;
		opener.pform.recieveName.value += nameVal;
	} else {
		alert("선택후 확인을 눌러주세요");
	}
	window.close();
}

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	pform.action = "/mypage/paper.do?mode=memberList";
	pform.submit();
}

//-->
</script>

</head>

<!-- popup size 400x300 -->
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pforam" name="pform" method="post">
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">

<div class="top">
	<h1 class="h1">사람찾기</h1>
</div>
<div class="contents">
    <div class="h10"></div>

	<!-- search -->
	<div class="popBoxWrap">
		<div class="drBoxTop">
            <dl>
                <dt><img src="/images/<%=skinDir %>/common/txt_name2.gif" class="vm2" alt="이름" /></dt>
                <dd>
                    <input type="text"  name="search" class="input01 w165"  value="<%=requestMap.getString("search") %>"> 
					<a href="javascript:goSearch();"><img src="/images/<%=skinDir %>/button/btn_search04.gif" class="vm3" alt="검색" /></a>
                </dd>
            </dl>
		</div>
	</div>
	<!-- //search -->

<!-- //text -->	
	<div class="h10"></div>

	<!-- data -->
	<table class="dataH01" style="width:362px;">	
	<colgroup>
		<col width="40" />
		<col width="186" />
		<col width="186" />
	</colgroup>

	<thead>
	<tr>
		<th colspan="3">검색결과</th>
	</tr>
	<tr>
		<th><input type="checkbox" value=""></th>
		<th>아이디</th>
		<th>이 름</th>
	</tr>
	</thead>
	                                                                        
	<tbody>
	<%=strHtml.toString() %>
	</tbody>

	</table>
	<!-- //data --> 
	<div class="paging_pt"  style="width:362px;">
		<%=pageStr.toString() %>
	</div>
	<!-- button -->
	<div class="btnC" style="width:372px;">
	    <a href="javascript:setMember();"><img src="/images/<%=skinDir %>/button/btn_suffer.gif" alt="받는사람 추가" /></a>
		<a href="javascript:window.close();"><img src="/images/<%=skinDir %>/button/btn_close01.gif" alt="닫기" /></a>		
	</div>	
	<!-- //button -->
</div>
	
</form>
</body>

</html>


