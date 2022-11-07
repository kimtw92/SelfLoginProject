  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 레포트관리 메시지 처리
// date : 2008-07-22
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
	
	var subj = "<%=requestMap.getString("subj")%>";
	var grcode = "<%=requestMap.getString("grcode")%>";
	var grseq = "<%=requestMap.getString("grseq")%>";
	var classno = "<%=requestMap.getString("classno")%>";
	var year = "<%=requestMap.getString("year")%>";
	var dates = "<%=requestMap.getString("dates")%>";
	var urlGubun = "<%=requestMap.getString("urlGubun")%>";
    //이동할 주소값 저장
    var url = "";
    
    var  menuId = "";
    
    if(urlGubun == "reportGradeAppList"){
    	menuId = "3-4-1";
    }else{
    	menuId = "3-4-2";
    }

    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	
	if(mode=="exec"){
		if(qu == "insert" || qu == "modify"){
			//과제물 수정
			url = "/subjMgr/report.do?mode=reportGradeAppList&menuId="+menuId+"&subj="+subj+"&grcode="+grcode+"&grseq="+grseq+"&classno="+classno+"&year="+year+"&qu=modify&dates="+dates;
			location.href = url;
		}else if(qu == "delete"){
			//삭제
			url = "/subjMgr/report.do?mode=reportList&menuId="+menuId+"&subj="+subj+"&grcode="+grcode+"&grseq="+grseq+"&classno="+classno+"&year="+year+"&qu=modify&dates="+dates;
			location.href = url;		
		}
	}else if(mode == "reportAppExec"){
			//과제물 평가 등록, 수정
			url = "/subjMgr/report.do?mode="+urlGubun+"&menuId="+menuId+"&subj="+subj+"&grcode="+grcode+"&grseq="+grseq+"&classno="+classno+"&year="+year+"&qu=modify&dates="+dates;
			location.href = url;
	}else if(mode == "reportGradeExec"){
			//과제물 평가 등급 수정
			url = "/subjMgr/report.do?mode="+urlGubun+"&menuId="+menuId+"&subj="+subj+"&grcode="+grcode+"&grseq="+grseq+"&classno="+classno+"&year="+year+"&qu=modify&dates="+dates;
			location.href = url;
			self.close();	
	}
	
  //-->
  </SCRIPT>
