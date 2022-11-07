<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String select = request.getParameter("select");
	String keyword = request.getParameter("keyword");
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("TEAM_LIST");
	listMap.setNullToInitialize(true);
	
	StringBuffer list1 = new StringBuffer(); //교육지원과 - 교육지원담당
	StringBuffer list2 = new StringBuffer(); //교육지원과 - 시설관리담당
	StringBuffer list3 = new StringBuffer(); //인재기획과 - 기획평가담당
	StringBuffer list4 = new StringBuffer(); //인재기획과 - 역량개발담당
	
	StringBuffer list7 = new StringBuffer(); //교수실
	
	//사용 중지됨 - 2011.02.07
	StringBuffer list5 = new StringBuffer(); //인재양성과 - 장기교육담당 
	//교육분석팀 사용 중지됨 - 2011.02.07
	StringBuffer list6 = new StringBuffer(); //인재양성과 - 전문교육담당

	
	
	String wonjang = ""; // 원장 이름
	String seomu = "";   // 교육지원과장 이름
	String kyohak = "";  // 인재기획과장 이름
	String susuk = "";   // 인재양성과장 이름
	
	String pageStr = "";

	if(listMap.keySize("phoneNumber") > 0){		
		for(int i=0; i < listMap.keySize("phoneNumber"); i++){
			if(listMap.getString("content", i).equals("인재개발원장")) {
				wonjang = listMap.getString("username", i);
			}else if(listMap.getString("content", i).equals("교육지원과장")) {
				seomu = listMap.getString("username", i);
			}

			//교육운영과장 현재 없는 직책임 - 2011.02.07
			else if(listMap.getString("content", i).equals("인재기획과장")) {
				kyohak = listMap.getString("username", i);
			}
			
			else if(listMap.getString("content", i).equals("인재양성과장")) {
				susuk = listMap.getString("username", i);
			}
			
			//교육지원담당 직원 리스트
			if(listMap.getString("memberPartTeam", i).equals("2")) {
				if(!"교육지원과장".equals(listMap.getString("content", i))) {
					list1.append("<tr> ");
					if( 69 < listMap.getInt("memberJik", i) ) {
						if( 80 > listMap.getInt("memberJik", i) ) {
   							list1.append("<td>주무관</td> ");
						} else {
							list1.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
						}
					} else {
						list1.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
					}
					list1.append("<td>"+listMap.getString("username", i)+"</td> ");
					list1.append(" <td>"+listMap.getString("phoneNumber", i)+"</td> ");
					list1.append("<td class=\"left01\">"+listMap.getString("content", i)+"</td> ");
					list1.append("</tr> ");					
				}
			}
			
			//시설관리담당 직원 리스트
			else if(listMap.getString("memberPartTeam", i).equals("3")) {
				list4.append("<tr> ");				
				if( 69 < listMap.getInt("memberJik", i) ) {
					if( 80 > listMap.getInt("memberJik", i) ) {
						list4.append("<td>주무관</td> ");
					} else {
						list4.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
					}
				} else {
					list4.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
				}
                list4.append("<td>"+listMap.getString("username", i)+"</td> ");
				list4.append(" <td>"+listMap.getString("phoneNumber", i)+"</td> ");
				list4.append("<td class=\"left01\">"+listMap.getString("content", i)+"</td> ");
				list4.append("</tr> ");
			}

			//기획평가팀 직원 리스트
			else if(listMap.getString("memberPartTeam", i).equals("4")) {
				if(!"인재기획과장".equals(listMap.getString("content", i))) {
					list2.append("<tr> ");				
					if( 69 < listMap.getInt("memberJik", i) ) {
						if( 80 > listMap.getInt("memberJik", i) ) {
							list2.append("<td>주무관</td> ");
						} else {
							list2.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
						}
					} else {
						list2.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
					}
					list2.append("<td>"+listMap.getString("username", i)+"</td> ");
					list2.append(" <td>"+listMap.getString("phoneNumber", i)+"</td> ");
					list2.append("<td class=\"left01\">"+listMap.getString("content", i)+"</td> ");
					list2.append("</tr> ");
				}
			}
			
			//역량개발팀 직원리스트
			else if(listMap.getString("memberPartTeam", i).equals("5")) {

				list3.append("<tr> ");				
				if( 69 < listMap.getInt("memberJik", i) ) {
					if( 80 > listMap.getInt("memberJik", i) ) {
						list3.append("<td>주무관</td> ");
					} else {
						list3.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
					}
				} else {
					list3.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
				}
				list3.append("<td>"+listMap.getString("username", i)+"</td> ");
				list3.append(" <td>"+listMap.getString("phoneNumber", i)+"</td> ");
				list3.append("<td class=\"left01\">"+listMap.getString("content", i)+"</td> ");
				list3.append("</tr> ");
			}
			
			else if(listMap.getString("memberPartTeam", i).equals("7")) {
				list6.append("<tr> ");							
				if( 69 < listMap.getInt("memberJik", i) ) {
					if( 80 > listMap.getInt("memberJik", i) ) {
						list6.append("<td>주무관</td> ");
					} else {
						list6.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
					}
				} else {
					list6.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
				}
				list6.append("<td>"+listMap.getString("username", i)+"</td> ");
				list6.append(" <td>"+listMap.getString("phoneNumber", i)+"</td> ");
				list6.append("<td class=\"left01\">"+listMap.getString("content", i)+"</td> ");
				list6.append("</tr> ");
			}
			
			//교수실 직원 리스트
			else if(listMap.getString("memberPartTeam", i).equals("6")) {
				if(!"인재양성과장".equals(listMap.getString("content", i))) {
					list7.append("<tr> ");							
					if( 69 < listMap.getInt("memberJik", i) ) {
						if( 80 > listMap.getInt("memberJik", i) ) {
							list7.append("<td>주무관</td> ");
						} else {
							list7.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
						}
					} else {
						list7.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
					}
					list7.append("<td>"+listMap.getString("username", i)+"</td> ");
					list7.append(" <td>"+listMap.getString("phoneNumber", i)+"</td> ");
					list7.append("<td class=\"left01\">"+listMap.getString("content", i)+"</td> ");
					list7.append("</tr> ");
				}
			}	
			else if(listMap.getString("memberPartTeam", i).equals("8")) {
				list7.append("<tr> ");					
				if( 69 < listMap.getInt("memberJik", i) ) {
					if( 80 > listMap.getInt("memberJik", i) ) {
						list7.append("<td>주무관</td> ");
					} else {
						list7.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
					}
				} else {
					list7.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
				}
				list7.append("<td>"+listMap.getString("username", i)+"</td> ");
				list7.append(" <td>"+listMap.getString("phoneNumber", i)+"</td> ");
				list7.append("<td class=\"left01\">"+listMap.getString("content", i)+"</td> ");
				list7.append("</tr> ");
			}
		}
	}else{

	}
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>

<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

	<script>
	
		function showNotice(i) {
			if(i == '업무') {
				alert('업무내용을 키워드로 입력하여 주십시오.\n 예) 교육, 인사, 강의 등...')
			}
		}
	
		function showTeam(i) {
			if(i==0) {
				$('team0100').hide();
				$('team0101').hide();
				$('team0102').hide();

				//$('team0200').hide();
				//$('team0201').hide();
				//$('team0202').hide();
				//$('team0203').hide();
				//$('team0204').hide();
				
				$('team0103').hide();
				$('team0104').hide();
				
				$('team0300').hide();
				$('team0301').hide();
				$('teamajax').hide();			
			}else if(i==1) {
				$('team0100').show();
				$('team0101').show();
				$('team0102').hide();
				$('team0400').hide();
				//$('team0200').hide();
				//$('team0201').hide();
				//$('team0202').hide();
				//$('team0203').hide();
				//$('team0204').hide();
				
				$('team0103').hide();
				$('team0104').hide();

				$('team0300').hide();
				$('team0301').hide();
				$('team0401').hide();
				$('teamajax').hide();
			}else if(i==2) {
				$('team0400').show();
				$('team0100').hide();
				$('team0101').hide();
				$('team0102').show();

				//$('team0200').hide();
				//$('team0201').hide();
				//$('team0202').hide();
				//$('team0203').hide();
				//$('team0204').hide();
				
				$('team0103').hide();
				$('team0104').hide();

				$('team0300').hide();
				$('team0301').hide();
				$('team0401').hide();
				$('teamajax').hide();
			}else if(i==3) {
				$('team0400').show();
				$('team0100').hide();
				$('team0101').hide();
				$('team0102').hide();

				//$('team0200').show();
				//$('team0201').show();
				//$('team0202').hide();
				//$('team0203').hide();	
				
				$('team0103').show();
				$('team0104').hide();

				$('team0300').hide();
				$('team0301').hide();
				$('team0401').hide();
				$('teamajax').hide();
			}else if(i==4) {
				$('team0400').show();
				$('team0100').show();
				$('team0101').hide();
				$('team0102').hide();

				//$('team0200').show();
				//$('team0201').hide();
				//$('team0202').show();
				//$('team0203').hide();
				//$('team0204').hide();	
				
				$('team0103').hide();
				$('team0104').show();

				$('team0300').hide();
				$('team0301').hide();
				$('team0400').hide();
				$('team0401').hide();
				$('teamajax').hide();
			}else if(i==5) {
				$('team0100').hide();
				$('team0101').hide();
				$('team0102').hide();

				//$('team0200').show();
				//$('team0201').hide();
				//$('team0202').hide();
				//$('team0203').show();
				//$('team0204').hide();
				
				$('team0103').hide();
				$('team0104').hide();
				$('team0400').hide();

				$('team0300').show();
				$('team0301').show();
				$('teamajax').hide();
			}else if(i==6) {
				$('team0100').hide();
				$('team0101').hide();
				$('team0102').hide();

				//$('team0200').show();
				//$('team0201').hide();
				//$('team0202').hide();
				//$('team0203').hide();
				//$('team0204').show();	
				
				$('team0103').show();
				$('team0104').hide();

				$('team0300').hide();
				$('team0301').hide();
				$('teamajax').hide();
			}else if(i==7) {
				$('team0100').hide();
				$('team0400').hide();
				$('team0101').hide();
				$('team0102').hide();

				$('team0300').show();				
				$('team0103').hide();
				$('team0104').hide();
				$('team0401').show();

				$('team0301').show();
				$('teamajax').hide(); 
			}else if(i==8) {

				$('team0401').show();
//				$('team0102').show();
				$('team0100').show();
				$('team0400').hide();
				$('team0101').hide();
				$('team0102').hide();
                $('team0103').hide();
				$('team0104').hide();
				$('team0301').hide();
				$('team0300').hide();
				$('teamajax').hide();
			}else if(i==10) {


				$('team0100').show();
				$('team0101').show();

				$('team0100').show();

				$('team0401').hide();
				$('team0400').hide();

				$('team0300').hide();
				$('team0301').hide();
				$('teamajax').hide();

				$('team0102').hide();
				$('team0103').hide();
				$('team0104').show();

			}else if(i==11) {
                $('team0100').hide();
				$('team0400').show();
				$('team0102').show();
				$('team0103').show();
                $('team0104').hide();
				$('team0401').hide();
				$('team0101').hide();
				$('team0300').hide();
				$('team0301').hide();
				$('teamajax').hide();
			}else if(i==12) {
				$('team0100').hide();
				$('team0400').hide();
				$('team0101').hide();
				$('team0102').hide();

				$('team0300').show();				
				$('team0103').hide();
				$('team0104').hide();
				$('team0401').hide();

				$('team0301').show();
				$('teamajax').hide(); 
			}else if(i==13) {
				$('team0100').hide();
				$('team0400').hide();
				$('team0101').hide();
				$('team0102').hide();

				$('team0300').show();				
				$('team0103').hide();
				$('team0104').hide();
				$('team0401').show();

				$('team0301').hide();
				$('teamajax').hide(); 
			}else if(i==99) {
				$('team0100').show();
				$('team0101').show();
				$('team0102').show();
				$('team0400').show();
				

				//$('team0200').show();
				//$('team0201').show();
				//$('team0202').show();
				//$('team0203').show();
				//$('team0204').show();
				
				$('team0103').show();
				$('team0104').show();
				$('team0401').show();
				$('team0300').show();
				$('team0301').show();
				$('teamajax').show();
			}else if(i==100) {
				if( $F('selectCondition') == '이름' && $F('keyword') != "") {
					$('team0100').hide();
					$('team0101').hide();
					$('team0102').hide();

					//$('team0200').hide();
					//$('team0201').hide();
					//$('team0202').hide();
					//$('team0203').hide();
					//$('team0204').hide();
					
					$('team0103').hide();
					$('team0104').hide();

					$('team0300').hide();
					$('team0301').hide();
					$('teamajax').show();
					nameFindAjax($F('keyword'));
				}else if( $F('selectCondition') == '업무' && $F('keyword') != "") {
					$('team0100').hide();
					$('team0101').hide();
					$('team0102').hide();

					//$('team0200').hide();
					//$('team0201').hide();
					//$('team0202').hide();
					//$('team0203').hide();
					//$('team0204').hide();
					
					$('team0103').hide();
					$('team0104').hide();

					$('team0300').hide();
					$('team0301').hide();
					$('teamajax').show();
					workFindAjax($F('keyword'));
				}else {
					alert("검색어를 입력해 주십시오.");
				}
			}
		}
	
		function nameFindAjax(name) {	
			var url = "introduce.do";
			pars = "mode=teamfindbyname&name=" + name;
			var divID = "teamajax"; 
			var myAjax = new Ajax.Updater(
				{success: divID },
				url, 
				{
					method: "post", 
					parameters: pars,
					onLoading : function(){
						
					},
					onSuccess : function(){
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);						
					},
					onFailure : function(){					
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						alert("데이타를 가져오지 못했습니다.");
					}				
				}
			);
		}
	
		function workFindAjax(work) {
			var url = "introduce.do";
			pars = "mode=teamfindbywork&work=" + work;
			var divID = "teamajax"; 			
			var myAjax = new Ajax.Updater(
				{success: divID },
				url, 
				{
					method: "post", 
					parameters: pars,
					onLoading : function(){
						
					},
					onSuccess : function(){
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);						
					},
					onFailure : function(){					
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						alert("데이타를 가져오지 못했습니다.");
					}				
				}
			);
		}
	
		var select = '<%= select %>';
		var keyword = '<%= keyword %>';
	
		
		document.observe("dom:loaded", function() {
			if(select == 'name') {
				nameFindAjax(keyword);
			}else if(select == 'work') {
				workFindAjax(keyword);
			}
		});
	</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left6.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual6">인재개발원 소개</div>
            <div class="local">
              <h2>조직 및 업무</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; <span>조직 및 업무</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            <form id="pform" name="pform" method="post">
			<div id="content">
			<!-- contnet -->
              <!-- 조직 및 업무 시작 -->
              <h3>조직도</h3>
                  <p class="content_center">
                  <img src="/homepage_new/images/contents/ct_007.gif" alt="조직도" usemap="#map1" />
                  </p>
                
                <div class="board_search02">
                <img src="/homepage_new/images/contents/ct_003.gif" alt="직원검색">
              <select name="selectCondition" id="selectCondition" class="select02 w67" onChange="showNotice(value);">
					                	<option value="이름" selected="selected">이름</option>
					               		<option value="업무">업무</option>
					                </select>

              <input type="text" class="" name="keyword" id="keyword" style="width:80px;" value="" /> 

              
               <img src="/homepage_new/images/contents/ct_004.gif" alt="조직별검색">
               <select class="select02 w130" onChange="showTeam(value)">
						                <option value="0" selected="selected">=== 선택하세요 ===</option>
						                <option value="99">전체</option>
						                <!-- option value="10">교육지원과 </option -->
						                
						             	<!-- <option value="1">교육지원과 - 총괄지원팀</option>
						                <option value="2">교육지원과  - 관리팀</option>
						                <option value="20">교육운영과</option>
						                <option value="3">교육운영과 - 기획팀</option>
						                <option value="4">교육운영과- 운영팀</option>
						                <option value="5">교육운영과 - 사이버교육팀</option>
					   	                <option value="6">교육운영과 - 교육분석팀</option>
						                <option value="7">교수단</option> -->
						                
						                <option value="1">교육지원과 - 교육지원담당</option>
						                <option value="4">교육지원과 - 시설관리담당</option>
						                <option value="2">인재기획과 - 기획평가담당</option>
						                <option value="3">인재기획과 - 역량개발담당</option>
						                <option value="12">인재양성과 - 장기교육담당</option>
						                <option value="13">인재양성과 - 전문교육담당</option>
					   	           </select>

		      <a href="javascript:showTeam(100);"><img id="btnSeach" src="/homepage_new/images/board/btn_search.gif" border="0" align="absmiddle" style="cursor:hand;"></a>
            </div>
                
                
                <h3>담당업무</h3>
                <div class="or_tb">
                  <div class="NONE">
                  <table class="table_st3" style="width:670px;" cellpadding="0" cellspacing="0">
			        <thead>
			          <tr>
			            <th>원장실</th>
			          </tr>
			            </thead>
			            <tbody>
			          <tr>
			            <td><b>인재개발원장 : <%=wonjang%></b></td>
			          </tr>
			          <tr>
			            <td>전화 : 032)440-7600</td>
			          </tr>
			          <tr>
			            <td>팩스 : 032)440-8795</td>
			          </tr>
                    </tbody>                        
                  </table>
                  </div>
                  <div class="NONE">
                  <table class="table_st3" style="width:670px;" cellpadding="0" cellspacing="0">
					<colgroup>
						<col width="33%" />
						<col width="33%" />
						<col width="33%" />
					</colgroup>
			        <thead>
			          <tr>
			            <th>교육지원과</th>
			            <th>인재기획과</th>
			            <th>인재양성과</th>
			          </tr>
			            </thead>
			            <tbody>
			          <tr>
			            <td><b>교육지원과장 : <%= seomu%></b></td>
			            <td><b>인재기획과장 : <%= kyohak%></b></td>
			            <td><b>인재양성과장 : <%= susuk%></b></td>
			          </tr>
			          <tr>
			            <td>전화 : 032)440-7610</td>
			            <td>전화 : 032)440-7612</td>
			            <td>전화 : 032)440-7614</td>
			          </tr>
			          <tr>
			            <td>팩스 : 032)440-8795</td>
			            <td>팩스 : 032)440-8794</td>
			            <td>팩스 : 032)440-8794</td>
			          </tr>
                    </tbody>
                  </table>
                  </div>
                </div>
	<!-- 조직 및 업무 마감 -->
            <!-- //contnet -->
					            
					            <div class="h30"></div>
		
					            <!-- 교육지원과title --> 
					            <div id="team0100" style="display:none;">
					            	<h3 class="h3Ltxt01">교육지원과
					            	</h3>
					            	<div class="h15"></div>
					            </div>
					            <!-- 교육지원과title --> 

								<!-- //교육지원과title -->
		
					            <!-- 총무관리팀 s --> 
					            <div id="team0101" style="display:none;">
						            <!-- title --> 
						            <h4 class="h4RecLtxt">교육지원담당</h4>
<!-- 						            <div class="txtR02">주요업무계획, 예산편성 운영, 서무관리, 인사관리, 복무관리, 식당운영</div> -->
						            <!-- //title -->
						            <div class="h9"></div>
						            <!-- data -->
						            <table class="dataH07">	
							            <colgroup>
							                <col width="100" />
							                <col width="138" />
							                <col width="130" />
							                <col width="*" />
							            </colgroup>
							            <thead>
								            <tr>
								                <th class="bl0 thB">직급</th>
								                <th class="thB">이름</th>
								                <th class="thB">전화번호</th>
								                <th class="thB">업 무</th>
								            </tr>
							            </thead>
							            <tbody>                
											<%=list1 %>
							            </tbody>
						            </table>
						            <!-- //data --> 
						            <div class="h25"></div>
					            </div>
					            <!-- //총무관리팀 s --> 
 <!-- 사이버교육팀 s --> 
					            <div id="team0104" style="display:none;">
						            <!-- title --> 
						            <h4 class="h4RecLtxt">시설관리담당</h4>
<!-- 						            <div class="txtR02"> </div> -->
						            <!-- //title -->
						            <div class="h9"></div>
						            <!-- data -->
						            <table class="dataH07">	
							            <colgroup>
							                <col width="100" />
							                <col width="138" />
							                <col width="130" />
							                <col width="*" />
							            </colgroup>
							            <thead>
								            <tr>
								                <th class="bl0 thB">직급</th>
								                <th class="thB">이름</th>
								                <th class="thB">전화번호</th>
								                <th class="thB">업 무</th>
								            </tr>
							            </thead>
							            <tbody> 
											<%=list4 %>               
										</tbody>
						            </table>
						            <div class="h25"></div>
					            </div>
					            <!-- //사이버교육팀 e --> 		
								<div id="team0400" style="display:none;">
					            	<h3 class="h3Ltxt01">인재기획과
					            	</h3>
					            	<div class="h15"></div>
					            </div>
						
		            		    <!-- 기획평가팀 s --> 
					            <div id="team0102" style="display:none;">
						            <!-- title --> 
						            <h4 class="h4RecLtxt">기획평가담당</h4>
<!-- 						            <div class="txtR02">교육훈련 계획수립, 수요조사 및 평가분석, 외국어과정 운영</div> -->
						            <!-- //title -->
						            <div class="h9"></div>
						            <!-- data -->
						            <table class="dataH07">	
							            <colgroup>
							                <col width="100" />
							                <col width="138" />
							                <col width="130" />
							                <col width="*" />
							            </colgroup>				
							            <thead>
								            <tr>
								                <th class="bl0 thB">직급</th>
								                <th class="thB">이름</th>
								                <th class="thB">전화번호</th>
								                <th class="thB">업 무</th>
								            </tr>
							            </thead>
							            <tbody>                
											<%=list2 %>
							            </tbody>
						            </table>
						            <!-- //data --> 
						            <div class="h30"></div>
					            </div>
					            <!-- //기획평가팀 s -->    
		
								<!-- 서무과 title --> 
					            <!-- <div id="team0200" style="display:none;">
					            	<h3 class="h3Ltxt01"><img src="../../../images/skin1/title/tit_05030104.gif" alt="서무과" /></h3>
									
					            	<div class="h15"></div>
					            </div> -->
					            <!-- //서무과 title -->				        	
					            
					            <!-- 운영팀 s --> 
					            <div id="team0103" style="display:none;">
						            <!-- title --> 
						            <h4 class="h4RecLtxt">역량개발담당</h4>
<!-- 						            <div class="txtR02"></div> -->
						            <!-- //title -->
						            <div class="h9"></div>
						            <!-- data -->
						            <table class="dataH07">	
							            <colgroup>
							                <col width="100" />
							                <col width="138" />
							                <col width="130" />
							                <col width="*" />
							            </colgroup>
							            <thead>
								            <tr>
								                <th class="bl0 thB">직급</th>
								                <th class="thB">이름</th>
								                <th class="thB">전화번호</th>
								                <th class="thB">업 무</th>
								            </tr>
							            </thead>
							            <tbody> 
											<%=list3 %>               
										</tbody>
						            </table>
						            <div class="h25"></div>
					            </div>
					            <!-- //운영팀 e --> 
		
					           
					          
					            <!-- 교수실title --> 
					            <div id="team0300" style="display:none;">
						            <h3 class="h3Ltxt01">인재양성과</h3>
						            <div class="h15"></div>
					            </div>
					            <!-- //교수실title --> 
		
					            <!-- 교수실 s --> 
					            <div id="team0301" style="display:none;">
						            <!-- title --> 
									<h4 class="h4RecLtxt">장기교육담당</h4>
<!-- 						            <div class="txtR02">교육 강의 및 교재연구</div> -->
						            <!-- //title -->
						            <div class="h9"></div>
						            <!-- data -->
						            <table class="dataH07">	
							            <colgroup>
							                <col width="100" />
							                <col width="138" />
							                <col width="130" />
							                <col width="*" />
							            </colgroup>
							            <thead>
								            <tr>
								                <th class="bl0 thB">직급</th>
								                <th class="thB">이름</th>
								                <th class="thB">전화번호</th>
								                <th class="thB">업 무</th>
								            </tr>
							            </thead>
							            <tbody> 
											<%=list7 %>               
										</tbody>
						            </table>
						            <div class="h25"></div>
					            </div>
					            <!-- 인재양성 s --> 
					            <div id="team0401" style="display:none;">
						            <!-- title --> 
									<h4 class="h4RecLtxt">전문교육담당</h4>
<!-- 						            <div class="txtR02"></div> -->
						            <!-- //title -->
						            <div class="h9"></div>
						            <!-- data -->
						            <table class="dataH07">	
							            <colgroup>
							                <col width="100" />
							                <col width="138" />
							                <col width="130" />
							                <col width="*" />
							            </colgroup>
							            <thead>
								            <tr>
								                <th class="bl0 thB">직급</th>
								                <th class="thB">이름</th>
								                <th class="thB">전화번호</th>
								                <th class="thB">업 무</th>
								            </tr>
							            </thead>
							            <tbody> 
											<%=list6 %>               
										</tbody>
						            </table>
						            <div class="h25"></div>
					            </div>
					            <!-- //교수실 e --> 
					
					            <!-- 검색 s --> 
					            <div id="team0400" style="display:'';">
									<div id="teamajax">           
									</div>
								</div>
					            <!-- //검색 e --> 
							
			
							</div>

			</form>
			<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100035" /></jsp:include>
			<div class="h80"></div>
            <!-- //contnet -->
          </div>
        </div>  
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>

<map name="map1" id="map1">
	  <area alt="교육지원과" shape="rect" coords="25,90,187,138" href="javascript:showTeam(10);" />
	  <area alt="인재양성과" shape="rect" coords="480,90,648,138" href="javascript:showTeam(7);" />
	  <area alt="교육지원담당" shape="rect" coords="12,173,102,232" href="javascript:showTeam(1);" />
	  <!-- area alt="관리담당" shape="rect" coords="125,171,219,234" href="javascript:showTeam(8);" / -->
	  <area alt="기획평가담당" shape="rect" coords="240,173,330,232" href="javascript:showTeam(2);" />
	  <area alt="역량개발담당" shape="rect" coords="340,173,432,232" href="javascript:showTeam(3);" />
	  <area alt="인재기획과" shape="rect" coords="254,90,416,138" href="javascript:showTeam(11);">
      <area alt="시설관리담당" shape="rect" coords="113,173,203,232" href="javascript:showTeam(4);">
      <area shape="rect" coords="570,173,661,232" href="javascript:showTeam(13);" alt="스마트교육담당" />
	  <area shape="rect" coords="470,173,560,232" href="javascript:showTeam(12);" alt="장기교육담당" />
</map>


