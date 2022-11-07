<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%

//필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

// 보드 뷰 
DataMap viewMap = (DataMap)request.getAttribute("BOARDVIEW_DATA");
requestMap.setNullToInitialize(true);

StringBuffer innerHtml = new StringBuffer();

if (viewMap.getInt("groupfileNo") > 0){
	
	DataMap fileGroup = (DataMap)viewMap.get("FILE_GROUP_LIST");
	
	if (fileGroup.keySize("groupfileNo") > 0){
		
		for(int i=0,l=fileGroup.keySize("groupfileNo");i<l;i++){
			
			String fileName =  fileGroup.getString("fileName");
			String extName = fileName.substring(fileName.indexOf(".")+1,fileName.length());
			
			if (!extName.equals("hwp") && !extName.equals("jpg")){
				extName = "fileDwn";
			}
			// 권한없음으로 나와서 임시로 처리함
			if (extName.equals("hwp")){
				extName = "han";
			}
						
			innerHtml.append("<a href=\"javascript:fileDownload('"+fileGroup.getInt("groupfileNo")+"', '"+fileGroup.getString("fileNo")+"');\">");
			innerHtml.append("<img src=\"/images/"+ skinDir +"/icon/icon_"+extName+".gif\" /><span class=\"vp2\">"+fileGroup.getString("fileName")+"</span>");
			innerHtml.append("</a>&nbsp;");
			//if ( i != 0 && i%4 == 0){
			//	innerHtml.append("<br />");
			//}
		}
	}
	
}
%>

<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	$("mode").value = "cyberList";
	pform.action = "/homepage/introduce.do";
	pform.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	$("mode").value = "cyberList";
	pform.action = "/homepage/introduce.do";
	pform.submit();
}
//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left6.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual6.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>법률/조례</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; 법률/조례 &gt; <span>시민</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" id="mode" name="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 페이징용 -->
<input type="hidden" id="currPage" name="currPage"	value="<%= requestMap.getString("currPage")%>">
<div id="content">
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="62" />
						</colgroup>
			
						<!-- view -->
						<table class="bView01">
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<td colspan="3">
								<%=viewMap.getString("title", 0) %>
							</td>
						</tr>
						<tr>
							<th class="bl0" width="75"><img src="/images/<%= skinDir %>/table/th_wName01.gif" alt="작성자" /></th>
							<td width="320"><%=viewMap.getString("username", 0) %></td>
							<th width="75"><img src="/images/<%= skinDir %>/table/th_date.gif" alt="작성일" /></th>
							<td width="100"><%=viewMap.getString("regdate", 0) %></td>
						</tr>			
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_addfile01.gif" alt="첨부파일" /></th>
							<td colspan="3">
								<%=innerHtml.toString() %>
								<!-- img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글file 첨부" /><span class="vp2">민법총칙.hwp</span>
								<img src="/images/<%= skinDir %>/icon/icon_jpg.gif" alt="JPG file 첨부" /><span class="vp2">민법총칙.jpg</span> 
								<img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글file 첨부" /><span class="vp2">민법총칙.hwp</span>
								<img src="/images/<%= skinDir %>/icon/icon_jpg.gif" alt="JPG file 첨부" /><span class="vp2">민법총칙.jpg</span><br />
			
								<img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글file 첨부" /><span class="vp2">민법총칙.hwp</span>
								<img src="/images/<%= skinDir %>/icon/icon_jpg.gif" alt="JPG file 첨부" /><span class="vp2">민법총칙.jpg</span> 
								<img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글file 첨부" /><span class="vp2">민법총칙.hwp</span>
								<img src="/images/<%= skinDir %>/icon/icon_jpg.gif" alt="JPG file 첨부" /><span class="vp2">민법총칙.jpg</span --> 
							</td>
						</tr>
						
						<tr>
							<td class="bl0 cont" colspan="4">
							<%=StringReplace.convertHtmlDecode(viewMap.getString("content", 0))%>
							</td>
						</tr>
						</table>	
						<!-- //view -->
			
						<!-- button -->
						<div class="btnRbtt">			
							<a href="javascript:fnList();"><img src="/images/<%= skinDir %>/button/btn_list02.gif" alt="리스트" /></a>
						</div>
						<!-- //button -->
						<div class="h80"></div>
					</div>
</form>



            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>