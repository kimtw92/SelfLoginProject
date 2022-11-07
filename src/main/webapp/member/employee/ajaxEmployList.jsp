<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 직원관리 각 해당 셀렉트박스 리스트
// date : 2008-08-19
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	//request
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	String selectBoxList = "";
	
	if(requestMap.getString("tu").equals("memberDept")){
		if(requestMap.getString("memberDept").equals("1")){
			selectBoxList += "<select style=\"width:100;text-align:center;\" name=\"memberPartTame\" class=\"mr10\">";
			selectBoxList += "<option value=\"1\">원장실</option>";
			
		}else if(requestMap.getString("memberDept").equals("2")){
			selectBoxList += "<select style=\"width:100;text-align:center;\" name=\"memberPartTame\" class=\"mr10\">";
			selectBoxList += "<option value=\"2\">총무관리팀</option>";
			selectBoxList += "<option value=\"7\">관리담당</option>";
		}else if(requestMap.getString("memberDept").equals("3")){
			selectBoxList += "<select style=\"width:100;text-align:center;\" name=\"memberPartTame\" class=\"mr10\">";
			selectBoxList += "<option value=\"6\">교수실</option>";
		}else if(requestMap.getString("memberDept").equals("4")){
			selectBoxList += "<select style=\"width:100;text-align:center;\" name=\"memberPartTame\" class=\"mr10\">";
			selectBoxList += "<option value=\"3\">기획평가팀</option>";
			selectBoxList += "<option value=\"4\">운영팀</option>";
			selectBoxList += "<option value=\"5\">사이버교육팀</option>";
		}

	}else if(requestMap.getString("tu").equals("memberPart")){
		if(requestMap.getString("memberDept").equals("1")){
			selectBoxList += "<select style=\"width:100;text-align:center;\" name=\"memberJiknm\" class=\"mr10\">";
			selectBoxList += "<option value=\"1\">원장</option>";
			
		}else if(!requestMap.getString("memberDept").equals("3")){
			selectBoxList += "<select style=\"width:100;text-align:center;\" name=\"memberJiknm\" class=\"mr10\">";
			selectBoxList += "<option value=\"2\">과장</option>";
			selectBoxList += "<option value=\"3\">교수단장</option>";
			
			selectBoxList += "<option value=\"40\">교수1</option>";
			selectBoxList += "<option value=\"41\">교수2</option>";
			selectBoxList += "<option value=\"42\">교수3</option>";
			selectBoxList += "<option value=\"43\">교수4</option>";
			selectBoxList += "<option value=\"44\">교수5</option>";
			selectBoxList += "<option value=\"45\">교수6</option>";
			selectBoxList += "<option value=\"46\">교수7</option>";
			selectBoxList += "<option value=\"47\">교수8</option>";
			selectBoxList += "<option value=\"48\">교수9</option>";
			selectBoxList += "<option value=\"49\">교수10</option>";
			
			selectBoxList += "<option value=\"5\">팀장</option>";
			
			selectBoxList += "<option value=\"80\">주무관1</option>";
			selectBoxList += "<option value=\"81\">주무관2</option>";
			
			selectBoxList += "<option value=\"82\">실무관1</option>";
			selectBoxList += "<option value=\"83\">실무관2</option>";
			selectBoxList += "<option value=\"84\">실무관3</option>";
			selectBoxList += "<option value=\"85\">실무관4</option>";
			selectBoxList += "<option value=\"86\">실무관5</option>";
			selectBoxList += "<option value=\"87\">실무관6</option>";
			selectBoxList += "<option value=\"88\">실무관7</option>";
			selectBoxList += "<option value=\"89\">실무관8</option>";
			selectBoxList += "<option value=\"90\">실무관9</option>";
			selectBoxList += "<option value=\"91\">실무관10</option>";
			selectBoxList += "<option value=\"92\">실무관11</option>";
			selectBoxList += "<option value=\"93\">실무관12</option>";
			selectBoxList += "<option value=\"94\">실무관13</option>";
			selectBoxList += "<option value=\"95\">실무관14</option>";
			selectBoxList += "<option value=\"96\">실무관15</option>";
			selectBoxList += "<option value=\"97\">실무관16</option>";
			selectBoxList += "<option value=\"98\">실무관17</option>";
			selectBoxList += "<option value=\"99\">실무관18</option>";
		}
	}
	
%>
<%=selectBoxList%>

