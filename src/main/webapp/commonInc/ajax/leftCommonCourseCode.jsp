<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : left menu 공통 년도, 과정, 기수, 과목 용 세션저장
// date : 2008-05-13
// auth : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>


<%!
	
	public String createSelectBox(DataMap dm, String pmode, String code){
	
		System.out.println("dm = " + dm.keySize("code"));
		
		StringBuilder sbHtml = new StringBuilder();
		
		if(pmode.equals("grCode")){
			sbHtml.append("<select name=\"selGrCode\" class=\"font1\" onChange=\"createLeftSelectBox('grSeq');\" style=\"width:170px\">");
		}
		if(pmode.equals("grSeq")){
			sbHtml.append("<select name=\"selGrSeq\" class=\"font1\" onChange=\"createLeftSelectBox('subj');\" style=\"width:170px\">");
		}
		if(pmode.equals("subj")){
			sbHtml.append("<select name=\"selSubj\" class=\"font1\" onChange=\"createLeftSelectBox('end');\" style=\"width:170px\">");
		}		
		
		
		if(dm.keySize("code") > 0){
			sbHtml.append("<option value=\"\">** 선택하세요 **</option>");
			for(int i=0; i < dm.keySize("code"); i++){
				
				String selected = "";
				
				if(dm.getString("code",i).equals(code)){
					selected = "selected";
				}else{
					selected = "";
				}
				
				sbHtml.append("<option value=\"" + dm.getString("code",i) + "\" " + selected + ">" + dm.getString("codenm",i) + "</option>");
			}
		}else{
			sbHtml.append("<option value=\"\">** 선택하세요 **</option>");
		}
		
		sbHtml.append("</select>");
	
		return sbHtml.toString();
	}

	

%>
<%

	//필수 코딩 내용 //////////////////////////////////////////////////////////////////////

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
		
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	////////////////////////////////////////////////////////////////////////////////////

	
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_MAP");
	if(listMap != null){
		listMap.setNullToInitialize(true);
	}
	
	String retData = "";
	String pmode = Util.getValue(request.getParameter("pmode"));	// 구분
	String year = Util.getValue(request.getParameter("year"));		// 년도
	String grCode = Util.getValue(request.getParameter("grCode"));	// 과정
	String grSeq = Util.getValue(request.getParameter("grSeq"));	// 기수
	String subj = Util.getValue(request.getParameter("subj"));		// 과목
	
	String findCode = "";
	
	
	
	// 년도 선택시 과정가져오기
	if(pmode.equals("grCode")){
				
		if( !year.equals( Util.getValue( (String)session.getAttribute("sess_year") ) ) ){
			
			session.setAttribute("sess_year", "" );
			session.setAttribute("sess_grcode", "" );
			session.setAttribute("sess_grseq", "" );
			session.setAttribute("sess_subj", "" );
			findCode = grCode;
		}else{
			findCode = Util.getValue( (String)session.getAttribute("sess_grcode") );
		}
		
		session.setAttribute("sess_year", year );				
	}
	
	// 과정 선택시 기수 가져오기
	if(pmode.equals("grSeq")){
						
		if( !grCode.equals( Util.getValue( (String)session.getAttribute("sess_grcode") ) ) ){
			session.setAttribute("sess_grseq", "" );
			session.setAttribute("sess_subj", "" );
			findCode = grSeq;
		}else{
			findCode = Util.getValue( (String)session.getAttribute("sess_grseq") );
		}
		
		session.setAttribute("sess_grcode", grCode );
				
	}
	
	// 기수 선택시
	if(pmode.equals("subj")){
		
		if( !grSeq.equals( Util.getValue( (String)session.getAttribute("sess_grseq") ) ) ){
			session.setAttribute("sess_subj", "" );
		}else{
			findCode = Util.getValue( (String)session.getAttribute("sess_subj") );
		}
		
		session.setAttribute("sess_grseq", grSeq );		
	}
	
	// 과목 선택시
	if(pmode.equals("end")){
		session.setAttribute("sess_subj", subj );
		findCode = Util.getValue( (String)session.getAttribute("sess_subj") );		
	}
	
	if(pmode.equals("clear")){
		session.setAttribute("sess_year", "" );
		session.setAttribute("sess_grcode", "" );
		session.setAttribute("sess_grseq", "" );
		session.setAttribute("sess_subj", "" );
	}
	
	
	// selectbox 만들기
	if(listMap != null){
		retData = createSelectBox(listMap, pmode, findCode);	
	}
	
%>
<%=retData%>

