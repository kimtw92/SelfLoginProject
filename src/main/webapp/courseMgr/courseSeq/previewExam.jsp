<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시험지 미리보기
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//과정 기수 정보.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer sbContentsHtml = new StringBuffer();
	for(int i=0; i<listMap.keySize("nrQ"); i++) {
		sbContentsHtml.append("<SPAN ID=Q_NO>").append(listMap.getString("nrQ",i)).append(".&nbsp;</SPAN>");
		sbContentsHtml.append("<SPAN ID=Q>").append(listMap.getString("q",i)).append("</SPAN><BR><BR>");
		if (!listMap.getString("ex1",i).equals("")) {
			sbContentsHtml.append("<SPAN ID=EX_NO>①&nbsp;</SPAN>").append(listMap.getString("ex1",i)).append("</SPAN><BR>");
		}
		if (!listMap.getString("ex2",i).equals("")) {
			sbContentsHtml.append("<SPAN ID=EX_NO>②&nbsp;</SPAN>").append(listMap.getString("ex2",i)).append("</SPAN><BR>");
		}
		if (!listMap.getString("ex3",i).equals("")) {
			sbContentsHtml.append("<SPAN ID=EX_NO>③&nbsp;</SPAN>").append(listMap.getString("ex3",i)).append("</SPAN><BR>");
		}
		if (!listMap.getString("ex4",i).equals("")) {
			sbContentsHtml.append("<SPAN ID=EX_NO>④&nbsp;</SPAN>").append(listMap.getString("ex4",i)).append("</SPAN><BR>");
		}
		if (!listMap.getString("ex5",i).equals("")) {
			sbContentsHtml.append("<SPAN ID=EX_NO>⑤&nbsp;</SPAN>").append(listMap.getString("ex5",i)).append("</SPAN><BR>");
		}
		sbContentsHtml.append("<BR><BR><BR>");
	}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<STYLE TYPE="text/css">
BODY, TABLE { font-family:굴림, 바탕, Verdana, Arial, MingLiU; font-size:10pt; }
TABLE { border-collapse: collapse; }
TH { background-color:#e7e7cd; }
H3 { font-size:22pt; }
H5 { font-size:13pt;margin-bottom:3px; }
UL { margin-left: 20px; }
#REFTITLE { text-align: left; vertical-align: top; text-indent: 0px; }
#REFBODY { vertical-align: bottom; width: 90%; }
#Q_NO { text-align: left; vertical-align: top; font-weight: bold; width: 20px; font-family:verdana,arial; font-size:15pt; }
#Q { vertical-align: bottom; width: 90%; }
#EX_NO { text-align: left; vertical-align: top; width: 20px; text-indent: 10px; }
#EX { vertical-align: bottom; width: 90%; }
#CA_NO, #EP_NO, #HT_NO, #DF_NO, #USERANS_NO, #AL_NO, #OX_NO, #PT_NO, #CAPCT_NO { text-align: left; vertical-align: top; text-indent: 0px; width: 60px; }
#CA, #EP, #HT, #DF, #USERANS, #AL, #OX, #PT, #CAPCT { vertical-align: bottom; width: 80%; }
#USERANS, #OX, #PT { color: #B70000; }
</STYLE>

<body>
	<%=sbContentsHtml.toString() %>
</body>