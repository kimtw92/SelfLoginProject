<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 과제물출제 평가 등급 설정
// date : 2008-07-21
// auth : 정 윤철
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
		
	//리스트 데이터
	DataMap rowMap = (DataMap)request.getAttribute("GRADELIST_DATA");
	rowMap.setNullToInitialize(true);

	
	//최대 등급점수
	DataMap maxPointMap = (DataMap)request.getAttribute("MAXPOINT_DATA");
	maxPointMap.setNullToInitialize(true);
	//현재 등급점수
	DataMap pointMap = (DataMap)request.getAttribute("POINT_DATA");
	pointMap.setNullToInitialize(true);

	

	//알파벳 시작값
	char alph = 65;
	StringBuffer option = new StringBuffer();
	for(int i = 2; i < 21; i++  ){
		option.append("<option value=\""+(i-2)+"\">"+i+"등급</option>");
		
	}
	
	
	StringBuffer html = new StringBuffer();
	if(rowMap.keySize("gradeNo") > 0){
		
	String temp = "";
		//등급이 등록이 되어있을때에는 사이즈만큼
		for(int i = 0; i < 21; i++){
			
			if(rowMap.getString("gradePoint", i).equals("")){
				temp = "0";
			}else{
				temp = rowMap.getString("gradePoint", i);
			}
			
			if(rowMap.keySize("gradePoint") < i+1){
				
				html.append("\n	<tr style=\"display:none\" id=\"view_"+i+"\">");
				html.append("\n		<td align=\"center\"> "+  (alph++) +"등급</td>");
				html.append("\n		<td align=\"center\" class=\"br0\"> <input type=\"text\" maxlength=3 id=\"gradePoint_"+i+"\" name=\"gradePoint\" value=\""+temp+"\"></td>");
				html.append("\n	</tr>");
				
			}else{
				html.append("\n	<tr style=\"\" id=\"view_"+i+"\">");
				html.append("\n		<td align=\"center\"> "+  (alph++) +"등급</td>");
				html.append("\n		<td align=\"center\" class=\"br0\"> <input type=\"text\" maxlength=3 id=\"gradePoint_"+i+"\" name=\"gradePoint\" value=\""+temp+"\"></td>");
				html.append("\n	</tr>");
			}
		}	
	}else{
		//없을경우 최소 2개의 입력란을 보여준다.
		for(int i = 0; i < 21; i++){
			if(1 < i){
				html.append("\n	<tr style=\"display:none\" id=\"view_"+i+"\">");
				html.append("\n		<td align=\"center\"> "+  (alph++) +"등급</td>");
				html.append("\n		<td align=\"center\" class=\"br0\"> <input type=\"text\" maxlength=3 id=\"gradePoint_"+i+"\" name=\"gradePoint\" value=\""+0+"\"></td>");
				html.append("\n	</tr>");
			}else{
				html.append("\n	<tr style=\"\" id=\"view_"+i+"\">");
				html.append("\n		<td align=\"center\"> "+  (alph++) +"등급</td>");
				html.append("\n		<td align=\"center\" class=\"br0\"> <input type=\"text\" maxlength=3 id=\"gradePoint_"+i+"\" name=\"gradePoint\" value=\""+0+"\"></td>");
				html.append("\n	</tr>");
			}
		}	
	}

	int point = pointMap.getInt("gradePoint");
	int maxPoint =  maxPointMap.getInt("reportpoint");
	int chkPoint = maxPoint - 0 ;//point
%>
<html>
<head>
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
</head>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

function go_change(){
	var gradeNo = $("gradeNo").value;
	//등급 수에 따른 인풋박스들 보여주기
	for(var i = 0; i < 21; i++){
		if((Number(gradeNo)+1) >= i){
			document.getElementById("view_"+i).style.display = "";
			$("cnt").value = $("gradeNo").value;
		}else{
			document.getElementById("view_"+i).style.display = "none";
			document.getElementById("gradePoint_"+i).value = "";
		}
	}
}

//저장
function go_save(){
var count = 0;
var grade = "<%=maxPointMap.getString("reportpoint")%>";

if(grade == "" || grade == null){
	alert("과목에 대한 과제물 점수을 먼저 입력해 주십시오.");
	return false;
}

	for(i=0; i < 21; i++){  

		//선택된 갯수만큼 루프 
		if(i > ( Number($("gradeNo").value) + 1) ){
			break;
		}
		

		
		if(document.getElementById("gradePoint_"+i).value > <%=chkPoint%>){
			alert("과제물에 부여된 최대점수 "+<%=chkPoint%>+"점을 초과할수 없습니다.");
			return false;
			break;
		}
		
		count=1;
		if(count == 1){
			for(var j=i; j < 21; j++){
			//greadeNo는 현재 선택 갯수 셀렉트박스 값
				if(i >= 1 ){
					if(Number(document.getElementById("gradePoint_"+(Number(i)-1)).value) <= Number(document.getElementById("gradePoint_"+ j).value)){
						alert("등급에 부여된 점수가 상위등급보다 높가나 같을수 없습니다.");
						return false;
						break;
					}
				}
				count++;
			}
		}
		
	}
	
	if(NChecker($("pform"))){
		if(confirm("저장하시겠습니까?")){
			$("mode").value = "reportGradeExec";
			$("qu").value = "insert";
			pform.submit();
		}
	}
}


//-->
</script>

<body>
<form name="pform">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu">
<!-- 현재 과제물에대한 기본 정보 모음 -->
<input type="hidden" name="subj" value="<%=requestMap.getString("subj")%>">
<input type="hidden" name="grcode" value="<%=requestMap.getString("grcode")%>">
<input type="hidden" name="grseq" value="<%=requestMap.getString("grseq")%>">
<input type="hidden" name="classno" value="<%=requestMap.getString("classno")%>">
<input type="hidden" name="dates" value="<%=requestMap.getString("dates")%>">
<input type="hidden" name="year" value="<%=requestMap.getString("year")%>">
<input type="hidden" name="sessNo" value="<%=memberInfo.getSessNo()%>">
<!-- 현재리스트 갯수 -->
<input type="hidden" name="totalCnt" value="<%=rowMap.keySize("gradePoint")%>">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">
<!-- 과제물평가관리와 출제 관리에서 수정하였을때에 자신이 온곳으로리턴시켜주기위한 구분값 -->
<input type="hidden" name="urlGubun" value="<%=requestMap.getString("urlGubun") %>">
<!-- 현재 선택된 갯수 저장 -->
<input type="hidden" name="cnt" 	value="">
<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 과제물 평가 등급설정</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	

	<tr>
		<td class="con">
			<table class="search01">
				<tr>
					<th class="bl0" align="center">등급 &nbsp;&nbsp;&nbsp;</th>
					<td class="br0">
						<select name="gradeNo"><%=option.toString() %></select>
						<input type="button" onclick="go_change();" class="boardbtn1" value="적용">
					</td>
				</tr>
			</table>
			
			<table><tr><td height="10">&nbsp;</td></tr></table>
			
			<!-- 리스트  -->
			<table class="datah01">
				<tr>
					<th class="br10">
						등급
					</th>
					<th class="br0">
						점수						
					</th>
				</tr>
				<%=html.toString() %>
			</table>
			<!--//리스트  -->
			
			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" 	value="저장" onclick="go_save();" class="boardbtn1">
						<input type="button" value="닫기" onclick="self.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>
</form>

</body>
<script language="Javascript" type="text/JavaScript">

var size = "<%=rowMap.keySize("gradeNo")%>";

if(size == 0){
	size = 2;
}

for(var i=0; i < Number(size)-1; i++){
	document.getElementById("view_"+i).style.display = "";
}


	//등급 셀렉티드
	//기존로직에는 포함이 안되어있다.
	var gradeNo = "<%=rowMap.keySize("gradePoint")%>";
	gradeNo = gradeNo-2;
	gradeNolen = $("gradeNo").options.length;

	for(var i=0; i < gradeNolen; i++) {
		if($("gradeNo").options[i].value == gradeNo){
			$("gradeNo").selectedIndex = i;
		 }
 	 }
</script>

