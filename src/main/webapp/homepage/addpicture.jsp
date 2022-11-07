<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천광역시인재개발원</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />

</head>
 
<!-- popup size 400x220 -->
<body>
<div class="top">
	<h1 class="h1">사진등록</h1>
</div>

<form method="post" action="uploadmemberimage.jsp" enctype="multipart/form-data">
<div class="contents">
	<!-- data -->
	<div class="popBoxWrap01">
		<div class="drBoxTop01">
			<h3>사진 이미지 규격 및 크기</h3>
			<div class="h5"></div>

			<ul class="hyTxt">
				<li>사진크기 : 5*7cm<br />
					반드시 증명(명함판)사진을 스캔하셔야 합니다.
				</li>
				<li>해상도 150dpi~200dpi</li>
				<li>최대파일용량 : 120kb미만</li>
				<li>파일저장형태 : jpg</li>
			</ul>
			<div class="space02"></div>

			<p>
				아래 경우의 사진은 허용되지 않습니다.<br />
				아래 경우의 해당하지 않는 명함 사진을 스캐닝 하셔서 <br />
				올려주시기 바랍니다.
			</p>
			<div class="space02"></div>

			<ul class="hyTxt">
				<li>사람이외에 동물, 자연등을 찍은 사진</li>
				<li>전신사진</li>
				<li>전면이 아닌 측면사진</li>
				<li>타인 사진</li>
				<li>신분증의 사진 스캔한 사진</li>
				<li>수영복 사진, 장비를 착용한채 찍은사진</li>
				<li>여러 사람이 함께 찍은 단체사진</li>
				<li>스티커 사진(괴기영화 주인공처럼 나옴)</li>
				<li>배경이 있는 사진</li>
				<li>단체 사진</li>
				<li>본인 여부를 확익할 수 없는 너무 오래된 사진</li>
				<li>HADURI등의 화상캠으로 찍은 사진</li>
			</ul>
		</div>
	</div>
	<!-- //data -->
	<div class="space02"></div>

	<!-- search -->
	<div class="popBoxWrap">
		<div class="drBoxTop">
			<img src="/images/skin1/common/txt_ptFile.gif" class="vm1" alt="사진파일" /> 
			
			<input name="picfile" id="picfile" type="file" >
			<!-- <img src="/images/skin1/button/btn_prView01.gif" class="vm3" alt="미리보기" /> -->
		</div>
	</div>
	<!-- //search -->

	<!-- button -->
	<div class="btnC" style="width:375px;">
		<input type="image" src="/images/skin1/button/btn_save01.gif" alt="저장" />
		<a href="javascript:window.close();"><img src="/images/skin1/button/btn_cancel01.gif" alt="취소" /></a>
	</div>	
	<!-- //button -->
</div>
</form>
</body>
</html>
