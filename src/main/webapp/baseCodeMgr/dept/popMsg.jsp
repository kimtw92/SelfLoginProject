  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 기관코드관리와 부서코드관리 등록, 수정, 처리후 메시지 처리 폼
// date : 2008-05-15
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
	//검색어
	var search = "<%=requestMap.getString("search") %>";
	//페이징값
    var currPage = "<%=requestMap.getString("currPage") %>";
    
    var qu="<%=requestMap.getString("qu")%>";
    
    //임시값 등록 성공인지 실패인지 확인.
    var temp = "<%=requestMap.getString("temp")%>";
    //이동할 주소값 저장
    var url = "";
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	
	if(mode=="exec"){
		var qu = "<%=requestMap.getString("qu")%>";
		if(qu =="update"){
			//기관코드 수정 후 이동 주소
			url = "/baseCodeMgr/dept.do?mode=list&menuId="+menuId+"&search="+search+"&currPage="+currPage;
			window.opener.location.href = url;
			self.close();
		}else if(qu =="allDeptUpdate"){
			//전체 기관코드 수정 후 이동 주소
			url = "/baseCodeMgr/dept.do?mode=allDeptCodeList&menuId="+menuId;
			window.opener.location.href = url;
			self.close();
		}else if(qu == "insert"){
			if(temp <= 0){
				//전체 기관코드 등록후 이동
				location.href = "/baseCodeMgr/dept.do?mode=list&menuId="+menuId;
			}else{
				//실패 
				location.href = "/baseCodeMgr/dept.do?mode=allDeptCodeList&menuId="+menuId+"&currPage="+currPage+"&search="+search;
			}
		}else if(qu =="allDeptCodeInsert"){
			//기관코드 등록후 이동
			url = "/baseCodeMgr/dept.do?mode=allDeptCodeList&menuId="+menuId;
			window.opener.location.href = url;
			self.close();
			
		}else if(qu =="deptInsertBack"){
			//기관코드 등록시 중복 기관코드가 있을경우 이동
			location.href = "/baseCodeMgr/dept.do?mode=allDeptCodeList&menuId="+menuId;
			
		}else if(qu == "partInsert" || qu == "partUpdate"){
			//부서코드 등록 & 등록 체크후 이동 경로
			url = "/baseCodeMgr/dept.do?mode=partCodeList&menuId="+menuId+"&dept=<%=requestMap.getString("dept")%>";
			window.opener.location.href = url;
			self.close();
					
		}else if(qu == "partDelete"){
			url = "/baseCodeMgr/dept.do?mode=partCodeList&menuId="+menuId+"&dept=<%=requestMap.getString("dept")%>";
			location.href = url;
			
		}else if(qu == "deptDelete"){
			//기관코드삭제
			url = "/baseCodeMgr/dept.do?mode=list&menuId="+menuId;
			window.opener.location.href = url;
			self.close();		
		}else if(qu == "allDeptDelete"){
			//기관코드삭제
			url = "/baseCodeMgr/dept.do?mode=allDeptCodeList&menuId="+menuId;
			window.opener.location.href = url;
			self.close();		
		}
	}
	
	
	
	
  //-->
  </SCRIPT>
