<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 검색창에서 사용하는 SelectBox 만들기 (Single 용)
// date  : 2008-05-30
// auth  : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>


<%!
	
	// prgNM : 검색창에서 사용하는 SelectBox 만들기 (Single 용)
	// auth  : kang
	// date  : 08.05.30
	// dm: DataMap, objId: 셀렉트박스명
	// code: 쿼리결과에서 코드에 해당하는 컬럼명, codeNm: 쿼리결과에서 명칭에 해당하는 컬럼명
	// findCode: 셀렉트박스에서 선택하고자 하는 코드
	// isOneData : true= findCode에 해당하는 하나의 값만 나타남
	public String createSelectBox(DataMap dm, 
								String objId, 
								String code, 
								String codeNm, 
								String findCode, 
								String width, 
								String isOneData){
	
		StringBuilder sbHtml = new StringBuilder();
		
		String paramWidth = "";
		String disabled = "";
		
		if(!width.equals("")){
			paramWidth = " style=\"width:" + width + "\" ";
		}
		
		
		sbHtml.append("<select name=\"" + objId + "\" " + paramWidth + disabled + " >");
				
		if(dm.keySize(code) > 0){
			
			if(!isOneData.equals("true")){
				sbHtml.append("<option value=\"\">**선택하세요**</option>");
			}
			
			for(int i=0; i < dm.keySize(code); i++){
				
				String selected = "";
				
				if(dm.getString(code,i).equals(findCode)){
					selected = "selected";
				}else{
					selected = "";
				}
				
				if(isOneData.equals("true")){
					if(dm.getString(code,i).equals(findCode)){
						sbHtml.append("<option value=\"" + dm.getString(code,i) + "\" " + selected + ">" + dm.getString(codeNm,i) + "</option>");						
					}
					
				}else{									
					sbHtml.append("<option value=\"" + dm.getString(code,i) + "\" " + selected + ">" + dm.getString(codeNm,i) + "</option>");	
				}				
				
			}
		}else{
			sbHtml.append("<option value=\"\">데이타 없음</option>");
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

	
	String mode = requestMap.getString("mode");
	String objId = requestMap.getString("objId");
	String code = requestMap.getString("code");
	String codeNm = requestMap.getString("codeNm");
	String findCode = requestMap.getString("findCode");
	String width = requestMap.getString("width");
	String isOneData = requestMap.getString("isOneData").toLowerCase();

	
	String retData = "";
	DataMap listMap = (DataMap)request.getAttribute("LIST_MAP");
	
	if(listMap != null){
		listMap.setNullToInitialize(true);
		retData = createSelectBox(listMap, objId, code, codeNm, findCode, width, isOneData);	
	}

%>
<%= retData %>
