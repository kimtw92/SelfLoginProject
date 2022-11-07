<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
// prgnm : 평가담당자 > 평가점수관리 > 가점입력 > 학생장/부학생장 변경 팝업
// date : 2008-08-14
// auth : CHJ
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	 //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
   	 //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
		
	//////////////////////////////////////////////////////////////////////////////////// 
	String personStr="";//학생 리스트
	DataMap personList=(DataMap)request.getAttribute("personList");
	personList.setNullToInitialize(true);
	
	if(!personList.isEmpty()){
		for(int i=0;i<personList.keySize("userno");i++){	
			personStr+="<tr>";
			personStr+="<td>"+personList.getString("userno",i)+"</td>";
			personStr+="<td>"+personList.getString("name",i)+"</td>";
			personStr+="<td>"+personList.getString("deptsub",i)+"</td>";
			personStr+="<td>"+personList.getString("mjiknm",i)+"</td>";			
			personStr+="<td>"+personList.getString("eduno",i)+"</td>";	
			if(requestMap.getString("code").equals("grstumascode_m")){	
				if(personList.getString("stumas",i).equals("M")){
					personStr+="<td class='br0'><a href=\"javascript:submit_send('"+personList.getString("userno",i)+"', 'M', 'deletePerson');\">삭제</a></td>";
				}else if(personList.getString("stumas",i).equals("S")){
					personStr+="<td class='br0'>부학생장</td>";
				}else{
					personStr+="<td class='br0'><a href=\"javascript:submit_send('"+personList.getString("userno",i)+"', 'M','insertPerson');\" >추가</a></td>";
				}
			}else{
				if(personList.getString("stumas",i).equals("M")){
					personStr+="<td class='br0'>학생장</td>";
				}else if(personList.getString("stumas",i).equals("S")){
					personStr+="<td class='br0'><a href=\"javascript:submit_send('"+personList.getString("userno",i)+"', 'S', 'deletePerson');\">삭제</a></td>";
				}else{
					personStr+="<td class='br0'><a href=\"javascript:submit_send('"+personList.getString("userno",i)+"', 'S', 'insertPerson');\">추가</a></td>";
				}				
			}
			personStr+="</tr>";
		}
	}else{
		personStr+="<tr>";
		personStr+="<td bgcolor='#FFFFFF' colspan='6' align='center'>수강신청된 회원이 없습니다.</td>";
		personStr+="</tr>";
	}
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- [s] commonHtmlTop include 필수 -->
<!-- include 됨. -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>

<link href="../commonInc/css/master_style.css" rel="stylesheet" type="text/css">
<link href="../commonInc/css/style2.css" rel="stylesheet" type="text/css">
<link href="../commonInc/css/protoload.css" rel="stylesheet" type="text/css">

<script language="javascript" src="commonInc/js/prototype-1.6.0.2.js"></script>
<script language="javascript" src="commonInc/js/commonJs.js"></script>
<script language="javascript" src="commonInc/js/NChecker.js"></script>
<script language="javascript" src="commonInc/js/category.js"></script>
<script language="javascript" src="commonInc/js/protoload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function go_search(){
		var f = document.pform;		
		document.getElementById("mode").value="findPerson";
		f.action="/member/member.do";
		f.submit();
	}

	function submit_send(userno, stumas, qu){
		var f = document.pform;
		document.getElementById("mode").value="findPersonExec";
		f.userno.value = userno;
		f.stumas.value = stumas;
		f.qu.value = qu;
		f.action="/member/member.do";		
		f.submit();
	}
//-->
</SCRIPT>
</head>
<!-- [e] commonHtmlTop include -->

<body>
<form name="pform" method="post" action="">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="userno" value="">
<input type="hidden" name="stumas" value="">
<input type="hidden" name="del" value="">
<input type="hidden" name="mode" id="mode" value="">
<input type="hidden" name="qu" value="">
<input type="hidden" name="title" value="<%=requestMap.getString("title") %>">
<input type="hidden" name="commGrcode" value="<%=requestMap.getString("commGrcode") %>">
<input type="hidden" name="commGrseq" value="<%=requestMap.getString("commGrseq") %>">
<input type="hidden" name="code" value="<%=requestMap.getString("code") %>">
<input type="hidden" name="name" value="<%=requestMap.getString("name") %>">
<input type="hidden" name="mark" value="<%=requestMap.getString("mark") %>">
<input type="hidden" name="smode" value="<%=requestMap.getString("smode") %>">

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 
					<%if(requestMap.getString("title").equals("stuM")){ %>학생장
					<%}else{ %>부학생장<%} %>
					</h1>
			</div>
			<!--// 타이틀영역 -->			
		</td>
	</tr>
	<tr>
		<td class="con">
			<!-- 검색 -->
			<table class="search01">
				<tr>
					<th class="bl0" width="80">
						<strong>이름</strong>
					</th>
					<td>
						<input type="text" class="textfield" id="search" name="search" value="" style="width:200px;" onKeydown="search"/>
					</td>
					<td width="100" class="btnr">
						<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!-- //검색 -->
			<div class="space01"></div>

			<!-- 리스트  -->
			<table class="datah01">
				<thead>
				<tr>
					<th>주민번호</th>
					<th>이름</th>
					<th>소속</th>
					<th>직급</th>
					<th>교번</th>
					<th class="br0">기능</th>
				</tr>
				</thead>

				<tbody>			
				<%=personStr %>	
				</tbody>
			</table>
			<!-- //리스트  -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="self.close();" class='boardbtn1'>
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>
</form>

</body>
<script language="javascript" type="text/javascript">
	document.getElementById("search").focus();
</script>
