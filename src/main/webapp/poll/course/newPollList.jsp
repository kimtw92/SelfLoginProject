<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    
    <%@ include file="/commonInc/include/commonImport.jsp" %> 
    
    <title>설문조사</title>

    <!-- 부트스트랩 -->    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
<%


	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	//list
	StringBuffer listStr = new StringBuffer();

	for(int i=0; i < listMap.keySize("titleNo"); i++){

		if( !listMap.getString("titleNo", i).equals("") ){
			
			listStr.append("\n<tr>");
			
			listStr.append("\n<td> <font color='CC6600'>과정명 : " + listMap.getString("title", i) + "</font> <input type='button' class='btn btn-info' value='설문조사 하기' onclick=\"goQnA('"+listMap.getString("grcode", i)+"','"+listMap.getString("grseq", i)+"','"+listMap.getString("titleNo", i)+"','"+listMap.getString("setNo", i)+"');\"/></td>");			
/* 			listStr.append("\n  <input type='hidden' name='titleNo' value='"+listMap.getString("titleNo", i)+"'/>");
			listStr.append("\n  <input type='hidden' name='grcode' value='"+listMap.getString("grcode", i)+"'/>");
			listStr.append("\n  <input type='hidden' name='grseq' value='"+listMap.getString("grseq", i)+"'/>");
			listStr.append("\n  <input type='hidden' name='setNo' value='"+listMap.getString("setNo", i)+"'/>"); */
			listStr.append("\n</tr>");
		} 

	}
%>
  <body>
  <script type="text/javascript">

function goQnA(grcode,grseq,titleno,setNo) {		
	
	
	//alert('grseq = '+grcode+'// titleno = '+titleno);
	
	
	document.getElementById("grcode").value = grcode;
	document.getElementById("grseq").value = grseq;
	document.getElementById("setNo").value = setNo; 
	document.getElementById("titleNo").value = titleno; 
	
	
	document.pform.submit();

}

</script>
  
  
  <div class="container-fluid">
	<form id="pform" name="pform" method="post" action="/poll/coursePoll.do">	
	<input type="hidden" id="mode" name="mode" value="new_poll_preview"/>
	<input type="hidden" id="titleNo" name="titleNo"/>
	<input type="hidden" id="grcode" name="grcode"/>
	<input type="hidden" id="grseq" name="grseq"/>
	<input type="hidden" id="setNo" name="setNo"/>
	
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped">
					<tbody>
						<tr>
							<td>			
								<h1 class="h1"><img src="/images/bullet_pop.gif" /> 설문조사 목록</h1>	
								<h5>※ 집합교육 대상자만 설문이 가능합니다</h5>		
							</td>
						</tr>
						<%= listStr.toString() %>
					</tbody>
				</table>
			</div>
		</div>
	</form>   
   </div>
   

    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    
  </body>
</html>