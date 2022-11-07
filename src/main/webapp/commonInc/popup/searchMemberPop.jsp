<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 이름 및 주민등록 번호로 회원 검색 (팝업)
// date : 2008-06-30
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       


    //유저 리스트.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	String selStr = "";
	String tmpStr = "";
	//for(int i = 0; i < listMap.keySize("userno"); i++){
	//	tmpStr = "[" + listMap.getString("name", i)+ "] [" + listMap.getString("resno", i)+ "] [" + listMap.getString("deptnm", i)+ "] [" + listMap.getString("jiknm", i)+ "]";
	//	selStr += "<option value=\"" + listMap.getString("userno", i) + "\">" + tmpStr + "</option>";
	//}
	for(int i = 0; i < listMap.keySize("userno"); i++){
		tmpStr = "[" + listMap.getString("name", i)+ "] [" + listMap.getString("userid", i)+ "] [" + listMap.getString("deptnm", i)+ "] [" + listMap.getString("jiknm", i)+ "]";
		selStr += "<option value=\"" + listMap.getString("userno", i) + "\">" + tmpStr + "</option>";
	}

%>
						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

	<script language="JavaScript">
	<!--	
		//검색
		function go_search(){
			if($F("searchValue") == ""){
				alert("검색어를 입력하세요.");
				return;
			}
			if(IsValidCharSearch($F("searchValue"))){
				go_list();
			}
		}
	
		//리스트
		function go_list(){
			$("mode").value = "list";
			pform.action = "/commonInc/searchMember.do";
			pform.submit();	
		}
		
		//유저 선택시.
		function go_selected(userno){
			if(userno != "")
				opener.go_reloadPop(userno);
		}
		
		function go_formChk(){
			go_search();
		}
	//-->
	</script>

<body>
	<form id="pform" name="pform" method="post" onSubmit="go_formChk();return false;">
	
		<input type="hidden" name="mode" value="<%= requestMap.getString("mode") %>"/>
		
		<table class="pop01">
			<tr>
				<td class="titarea">
					<!-- 타이틀영역 -->
					<div class="tit">
						<h1 class="h1"><img src="/images/bullet_pop.gif" />교육생 검색</h1>
					</div>
					<!--// 타이틀영역 -->
				</td>
			</tr>
			<tr>
				<td class="con">
		
					<!-- date -->
					<div  class="pop_datainput01">
						<select name="qu">
							
							<!-- <option value="resno" < %= requestMap.getString("qu").equals("resno") ? "selected" : "" %>>주민번호</option> -->
							<option value="userid" <%= requestMap.getString("qu").equals("userid") ? "selected" : "" %>>아이디</option>
							
							<option value="name" <%= requestMap.getString("qu").equals("name") ? "selected" : "" %>>이름</option>
						</select>
						<input type="text" class="textfield" name="searchValue" value="<%= requestMap.getString("searchValue") %>" style="width:120px" />
						<input type="button" value="검색" onclick="go_search();return false;" class="boardbtn1"/>
					</div>
					<!-- //date -->
		
					<!-- 리스트  -->
					<table class="datah01">
						<thead>
						<tr>
							<th>[이름]</th>
							
							<!-- 
							<th>[주민번호]</th>
							 -->
							 <th>[아이디]</th>
							
							<th>[기관]</th>
							<th class="br0">[직급]</th>
						</tr>
						</thead>
		
						<tbody>
						<tr>
							<td colspan="100%">
								<select name="selValue" onChange="javascript:go_selected(this.value);">
									<option value="">선택하세요</option>
									<%= selStr %>
								</select>
							</td>
						</tr>
						</tbody>
					</table>
					<!-- //리스트  -->
					<div class="space01"></div>
		
		
		
					<!-- 하단 닫기 버튼  -->
					<table class="btn02">
						<tr>
							<td class="center">
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
