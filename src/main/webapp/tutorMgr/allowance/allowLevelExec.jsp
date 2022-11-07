  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사 레벨 메시지  처리
// date : 2008-07-09
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
    var msg = "<%=requestMap.getString("msg")%>";
    //메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";

    
    var url = "";
	
	//메시지 
	alert("<%=requestMap.getString("msg")%>");

   if(mode == "exec"){
		//강사 등급별 급여지정후 이동 url
		if(qu == "insert"){
			url = "/tutorMgr/allowance.do?menuId="+menuId;
			opener.location.href = url;
			window.close();
		}
		
		//수정후 이동
		if(qu == "modify"){
			url = "/tutorMgr/allowance.do?menuId="+menuId;
			opener.location.href = url;
			window.close();
		}
	}else if(mode == "greadExec"){
		if(qu == "insert"){
			url = "/tutorMgr/allowance.do?menuId="+menuId+"&mode=greadList&tlevel=<%=requestMap.getString("tlevel")%>";
			opener.location.href = url;
			window.close();
			
		}else if(qu == "modify"){
			url = "/tutorMgr/allowance.do?menuId="+menuId+"&mode=greadList&tlevel=<%=requestMap.getString("tlevel")%>";
			opener.location.href = url;
			window.close();
			
		}else if(qu == "delete"){
			url = "/tutorMgr/allowance.do?menuId="+menuId+"&mode=greadList&tlevel=<%=requestMap.getString("tlevel")%>";
			location.href = url;
		}
	}
	
	
  //-->
  </SCRIPT>
