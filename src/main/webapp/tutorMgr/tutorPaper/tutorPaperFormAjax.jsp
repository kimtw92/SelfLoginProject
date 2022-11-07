<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사용자 게시판 글 수정
// date : 2008-06-05
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
	
	//과정기수
	DataMap grseqMap = (DataMap)request.getAttribute("GRSEQTLIST_DATA");
	grseqMap.setNullToInitialize(true);
	
	//과목코드
	DataMap subjMap = (DataMap)request.getAttribute("SUBJTLIST_DATA");
	subjMap.setNullToInitialize(true);
	
	//지정강사코드
	DataMap tutorNameMap = (DataMap)request.getAttribute("TUTORNAMETLIST_DATA");
	tutorNameMap.setNullToInitialize(true);
	
	StringBuffer grseq = new StringBuffer();
	StringBuffer subj = new StringBuffer();
	StringBuffer tutorName = new StringBuffer();
	String qu = requestMap.getString("qu");
	
	if(qu.equals("grcode")){
		if(grseqMap.keySize("grseq") > 0){
			for(int i = 0; grseqMap.keySize() > i; i++){
				grseq.append("<option value=\""+grseqMap.getString("grseq", i)+"\">"+grseqMap.getString("grseq", i)+"</option>");
			}
		}
	}

	if(qu.equals("grseq")){
		if(subjMap.keySize("subj") > 0){
			for(int i = 0; subjMap.keySize("subj") > i; i++){
				subj.append("<option value=\""+subjMap.getString("subj", i)+"\">"+subjMap.getString("lecnm" ,i)+"</option>");
			}
		}
	}
	
	if(qu.equals("subj")){
		if(tutorNameMap.keySize("tuserno") > 0){
			for(int i = 0; tutorNameMap.keySize("tuserno") > i; i++){
				tutorName.append("<option value=\""+tutorNameMap.getString("tuserno", i)+"\">"+tutorNameMap.getString("name", i)+"</option>");
			}
		}
	}
	
	
%>

<%
	//과정기수
	if(qu.equals("grcode")){
%>
<select name="grseq" onchange="go_change('grseq', this.value)">
<option value="">**** 선택하세요 ****</option>
<%=grseq.toString()%>
<%} %>


<%
	//과목코드
	if(qu.equals("grseq") || qu.equals("clearGrseq")){
%>
<select name="subj" onchange="go_change('subj', this.value)">
<option value="">**** 선택하세요 ****</option>
<%=subj.toString() %>
<%} %>


<%
	//지정강사
	if(qu.equals("subj") || qu.equals("clearSubj")){
%>
<select name="tutorName">
<option value="">**** 선택하세요 ****</option>
<%=tutorName.toString() %>
<%	} %>
</select>