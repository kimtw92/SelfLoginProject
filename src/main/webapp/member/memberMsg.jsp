  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 학적부관리 처리 실행 후 메시지 처리
// date : 2008-06-04
// auth : 정 윤철
%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
%>
  <SCRIPT LANGUAGE="JavaScript">
  <!--
    //모드값 저장
    var mode = "<%=requestMap.getString("mode")%>";
	var qu = "<%=requestMap.getString("qu")%>";
    //이동할 주소값 저장
    var url = "";
    //메개변수모음
    var currPage = "<%=requestMap.getString("currPage")%>";
    var dept = "<%=requestMap.getString("searchDept")%>";
    var name = "<%=requestMap.getString("searchName")%>";
    var resno = "<%=requestMap.getString("searchResno")%>";
    var auth = "<%=requestMap.getString("searchAuth")%>";
    
    //출력내역서 관련 변수
    var userno = "<%=requestMap.getString("userno")%>";
    var grcode = "<%=requestMap.getString("grcode")%>";
    var grseq = "<%=requestMap.getString("grseq")%>";
    var breakDownName = "<%=requestMap.getString("name")%>";
	var breakDownGubun = "<%=requestMap.getString("breakDownGubun")%>";
	var searchResno = "<%=requestMap.getString("searchResno")%>";
	var searchName = "<%=requestMap.getString("searchName")%>";
	
	//출력내역서가 아닐경우
	if(mode !="breakeDownExec"){
    	//메시지 
		alert("<%=requestMap.getString("msg")%>");
	}
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	
	if(mode =="breakeDownExec"){
	//출력 내역서 등록 후 이동 
		
		if(breakDownGubun == 1){
			//학적부조회후 이동 주소
			url = "/member/member.do?mode=studyPersonList&menuId="+menuId+"&currPage="+currPage+"&userno="+userno+"&grcode="+grcode+"&grseq="+grseq+"&name="+encodeURI(breakDownName);
		}else if(breakDownGubun == 2){
			//강의기록입력후 이동
			url = "/tutorMgr/lecHistory.do?&menuId="+menuId+"&currPage="+currPage+"&mode=list&userno="+userno+"&breakDownGubun="+breakDownGubun+"&searchName="+encodeURI(searchName)+"&searchResno="+searchResno;
		}
		
		window.opener.location.href = url
		self.close();
		
	}else if(qu == "update"){
		//멤버 수정후 이동
		url ="/member/member.do?mode=list&menuId="+menuId+"&currPage="+currPage+"&dept="+dept+"&name="+encodeURI(name);
		location.href = url;
		
	}else{
		url = "/member/member.do?&menuId="+menuId;
		location.href = url;
		
	}
	
	
	
  //-->
  </SCRIPT>
