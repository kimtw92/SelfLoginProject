<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 인천시민이 바라는 공무원 교육 팝업
// date : 2020-09-10
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
%>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="viewport" content="initial-scale=1, viewport-fit=cover">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>인천광역시 인재개발원</title>
		<link rel="stylesheet" href="/homepageMgr/popup/css/reset.css">
		<script type="text/javascript" language="javascript" src="/pluginfree/js/jquery-1.11.0.min.js"></script>		
		
	
		<script language="JavaScript" type="text/JavaScript">
		
		function setInsert(){
			console.log("=========================== setInsert =======================" + $("#q_10").val() );
			if($("input[name='q_1']:checked").val() == "" || $("input[name='q_1']:checked").val() == null){
				return alert("문_1 문항에 체크 부탁드립니다.");
			}
			
			if($("input[name='q_1_1']:checked").val() == "" || $("input[name='q_1_1']:checked").val() == null){
				return alert("문_1_1 문항에 체크 부탁드립니다.");
			}

			if($("input[name='q_2']:checked").val() == "" || $("input[name='q_2']:checked").val() == null){
				return alert("문_2 문항에 체크 부탁드립니다.");
			}
			if($("input[name='q_3']:checked").val() == "" || $("input[name='q_3']:checked").val() == null){
				return alert("문_3 문항에 체크 부탁드립니다.");
			}
			if($("input[name='q_4']:checked").val() == "" || $("input[name='q_4']:checked").val() == null){
				return alert("문_4 문항에 체크 부탁드립니다.");
			}
			if($("input[name='q_5']:checked").val() == "" || $("input[name='q_5']:checked").val() == null){
				return alert("문_5 문항에 체크 부탁드립니다.");
			}
			if($("input[name='q_6_1']:selected").val() == ""){
				return alert("문_6_1 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_6_2']:selected").val() == ""){
				return alert("문_6_2 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_6_3']:selected").val() == ""){
				return alert("문_6_3 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_7_1']:selected").val() == ""){
				return alert("문_7_1 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_7_2']:selected").val() == ""){
				return alert("문_7_2 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_7_3']:selected").val() == ""){
				return alert("문_7_3 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_8_1']:selected").val() == ""){
				return alert("문_8_1 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_8_2']:selected").val() == ""){
				return alert("문_8_2 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_8_3']:selected").val() == ""){
				return alert("문_8_3 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_9_1']:selected").val() == ""){
				return alert("문_9_1 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_9_2']:selected").val() == ""){
				return alert("문_9_2 문항에 선택 부탁드립니다.");
			}
			if($("input[name='q_9_3']:selected").val() == ""){
				return alert("문_9_3 문항에 선택 부탁드립니다.");
			}
			if($("#q_10").val() == "" || $("#q_10").val() == null){
				return alert("문_10 문항에 체크 부탁드립니다.");
			}
			if(confirm('등록하시겠습니까?')) {
				//var pform = $("pform");			
				pform.mode.value = "etcexce";
				pform.action = "/homepage/support.do";
				pform.submit();

			}
		}
		
		$("#Pop_Cancel").click(function(){
	        self.close(); 
		}) 
		
		$(document).ready(function(){
			
			$("input:radio[name='q_1']").click(function(){
				
				if($("input[name='q_1']:checked").val() == "2"){		
					pform.mode.value = "etcCancel";
					pform.action = "/homepage/support.do";
					pform.submit();
				}
			});
		});
		</script>
	</head>
<body>
<article>
	<form id="pform" name="pform" method="post">
	<input type="hidden" id="mode" name="mode" value="">
	<div class="cont_in">
		<div class="cont_in_wrap">
			<h2>인천시민이 바라는<br/>공무원 교육 조사 안내</h2>
			<div class="point_box mgb_30">
				<p class="box_img"><span><img src="https://hrd.incheon.go.kr/homepage_new/images/common/box_point.gif" alt=""></span></p>
				<div class="list">
					<p class="mgb_30">안녕하십니까? 인천광역시인재개발원입니다.</p>
	 
					<p class="mgb_30">저희는 인천광역시 공무원 교육에 대한 인천시민 여러분의 의견을 조사하고 있습니다.<br>
					이 조사는 ‘20.9.16. ~ 9. 22. 칠일간 인재개발원 홈페이지에서 인천시민을 대상으로 온라인과 오프라인 상에서 진행되며, 별도 회원가입없이 참여가 가능합니다.<br>
					본 조사에 응답하신 내용은 인천시 발전과 공무원 교육정책 개발에 귀중한 자료로 활용될 예정이고, 
					귀하께서 응답하신 내용은 통계작성만을 위해 사용되며, 통계법 제33조에 의해 철저히 비밀이 보장됩니다.<br>
					바쁘시겠지만 잠시 시간을 내어, 조사에 협조해 주시면 대단히 감사하겠습니다.<br>
					(인천에 거주하시는 시민이 아니신 경우 이번 조사대상에 해당하지 않으니 양해바랍니다.)</p>

					<p>조사기관 : 인천광역시 인재개발원<br>
					주소 : 인천 서구 심곡로 98 인재개발원 인재기획과<br>
					담당 : 임지연  TEL 032-440-7653  FAX 032-440-8621</p>
				</div>
			</div>

			<h3>Ⅰ. 작성전 안내사항</h3>
			<div class="con_box mgb_30">
				<p class="t_center t_bold t_size_16 mgb_20">본 조사에 앞서 인천광역시 공무원 인재상과 인재개발원을 소개드립니다.</P>
				<ul class="list_style">
					<li>인천광역시 공무원 인재상 : 300만 인천특별시대를 선도할 미래지향적 인재</li>
					<li>인천광역시 인재개발원 주요기능 : 지역발전을 주도하고 시민에게 봉사하는 전문행정인 양성</li>
					<li>2019년 인재개발원 교육훈련 성과
						<ul>
							<li>공무원대상 71개 집합교육과정과 112개 사이버교육과정 등 47,132명 교육 실시</li>
							<li>시민대상 193개 사이버교육과정을 통해 242,398명에게 교육콘텐츠 제공</li>
						</ul>
					</li>
					<li>2020년도 공무원 교육훈련 추진
						<ul>
							<li>집합교육 54개 과정, 사이버교육 147개 과정 등 총201개 과정 109,025명 교육 운영
								<ul>
									<li>기본교육 : 신규공무원에게 조직적응과 업무능력 향상을 위한 직무교육, 친절·청렴 등 소양교육</li>
									<li>장기교육 : 핵심중견간부 양성 교육 및 글로벌인재 양성을 위한 외국어 교육</li>
									<li>국정·시정교육 : 국정과제와 시정 핵심가치를 공유하고 정책실행력을 높이기 위한 교육 </li>
									<li>리더십역량교육 : 4급·5급 공무원과 동장·면장의 리더십을 키우고 공무원 역량강화를 위한 교육</li>
									<li>전문교육 : 직무별 전문성을 강화하고 행정환경 변화에 대응하기 위한 교육<br>
									* 또한, 법령에 따라 장애인식개선, 청렴, 인권, 통일, 아동학대예방, 성인지 및 4대폭력예방교육 등은 법령에 의거 의무적으로 교육하고 있음</li>
									<li>사이버교육 : 외국어, 직무 전문과정 및 소양교육 등</li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
			</div>

		
			<h3>Ⅱ. 응답자 유형 질문</h3>

			<div class="list_table">
				<table>
					<colgroup>
						<col style="width: 80px;">
						<col style="width: *">
					</colgroup>
					<tbody>
						<tr>
							<th>[문1]</th>
							<td><p>귀하께서는 현재 주민등록 주소가 ‘인천’이십니까?</p>
								<div>
									<ul>
										<li><label><input type="radio" name="q_1" value="1">①예</label></li>
										<li><label><input type="radio" name="q_1" value="2">②아니오</label></li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th>[문1-1]</th>
							<td><p>귀하께서는 현재 인천시 어느 구/군에 거주하고 계십니까?</p>
								<div>
									<ul>
										<li><label><input type="radio" name="q_1_1" value="1">①중구</label></li>
										<li><label><input type="radio" name="q_1_1" value="2">②동구</label></li>
										<li><label><input type="radio" name="q_1_1" value="3">③미추홀구</label></li>
										<li><label><input type="radio" name="q_1_1" value="4">④연수구</label></li>
										<li><label><input type="radio" name="q_1_1" value="5">⑤남동구</label></li>
										<li><label><input type="radio" name="q_1_1" value="6">⑥부평구</label></li>
										<li><label><input type="radio" name="q_1_1" value="7">⑦계양구</label></li>
										<li><label><input type="radio" name="q_1_1" value="8">⑧서구</label></li>
										<li><label><input type="radio" name="q_1_1" value="9">⑨강화군</label></li>
										<li><label><input type="radio" name="q_1_1" value="10">⑩옹진구</label></li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th>[문2]</th>
							<td><p>귀하께서는 여성이십니까? 남성이십니까?</p>
								<div>
									<ul>
										<li><label><input type="radio" name="q_2" value="1">①여성</label></li>
										<li><label><input type="radio" name="q_2" value="2">②남성</label></li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th>[문3]</th>
							<td><p>귀하의 연세는 올해 만으로 어떻게 되십니까?</p>
								<div>
									<ul>
										<li><label><input type="radio" name="q_3" value="1">①만18세이하</label></li>
										<li><label><input type="radio" name="q_3" value="2">②만19세~만29세</label></li>
										<li><label><input type="radio" name="q_3" value="3">③만30세~만39세</label></li>
										<li><label><input type="radio" name="q_3" value="4">④만40세~만49세</label></li>
										<li><label><input type="radio" name="q_3" value="5">⑤만50세~만59세</label></li>
										<li><label><input type="radio" name="q_3" value="6">⑥만60세이상</label></li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th>[문4]</th>
							<td><p>귀하께서는 현재 인천시 또는 군구 위원회 위원 또는 시민·사회단체 회원이십니까?<br>
								다음 보기중에서 가장 가까운 답변에 1개만  표시하여 주시기 바랍니다.</p>
									<div>
									<ul>
										<li><label><input type="radio" name="q_4" value="1">①시 또는 군·구 위원회 위원</label></li>
										<li><label><input type="radio" name="q_4" value="2">②시민·사회단체 회원</label></li>
										<li><label><input type="radio" name="q_4" value="3">③일반시민</label></li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th>[문5]</th>
							<td><p>귀하께서는 인천광역시인재개발원에 대하여 들어본 적이 있거나 알고 있으십니까?</p>
								<div>
									<ul>
										<li><label><input type="radio" name="q_5" value="1">①유(들어본 적 있거나 알고 있음)</label></li>
										<li><label><input type="radio" name="q_5" value="2">②무(모름)</label></li>
									</ul>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<h3>Ⅲ. 공무원 교육에 대한 질문</h3>

			<div class="list_table">
				<table>
					<colgroup>
						<col style="width: 80px;">
						<col style="width: *">
					</colgroup>
					<tbody>
						<tr>
							<th>[문6]</th>
							<td>
								<p>귀하께서는 교육이 가장 필요한 인천광역시 공무원이 누구라고 생각하십니까?<br/>
								다음 중에서 필요한 순서대로 선택해 주세요</p>
								<div>
								<ul>
									<li>(1순위)
										<select name="q_6_1">
											<option value="">-선택해주세요-</option>
											<option value="1">시청 공무원</option>
											<option value="2">구(군)청 공무원</option>
											<option value="3">행정복지센터 공무원</option>
										</select>,
									</li>
									<li>(2순위)
										<select name="q_6_2">
											<option value="">-선택해주세요-</option>
											<option value="1">시청 공무원</option>
											<option value="2">구(군)청 공무원</option>
											<option value="3">행정복지센터 공무원</option>
										</select>,
									</li>
									<li>(3순위)
										<select name="q_6_3">
											<option value="">-선택해주세요-</option>
											<option value="1">시청 공무원</option>
											<option value="2">구(군)청 공무원</option>
											<option value="3">행정복지센터 공무원</option>
										</select>
									</li>
								</ul>
								</div>
								<div>
									<ul>
										<li>①시청 공무원&nbsp;&nbsp;②구(군)청 공무원&nbsp;&nbsp;③행정복지센터 공무원(舊 주민자치센터 공무원)</li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th>[문7]</th>
							<td>
								<p>귀하께서는 인천시청 공무원에게 가장 필요하다고(부족하다고) 생각하는 교육분야는 무엇입니까?<br>
								다음 중에서 필요한 순서대로 선택해 주세요</p>
								<div>
								<ul>
									<li>(1순위)
										<select name="q_7_1">
											<option value="">-선택해주세요-</option>
											<option value="1">친절교육</option>
											<option value="2">청렴교육</option>
											<option value="3">정보화·변화대응교육</option>
											<option value="4">직무전문교육</option>
											<option value="5">역량개발교육</option>
											<option value="6">외국어교육</option>
											<option value="7">보기에 없음</option>
										</select>,
									</li>
									<li>(2순위)
										<select name="q_7_2">
											<option value="">-선택해주세요-</option>
											<option value="1">친절교육</option>
											<option value="2">청렴교육</option>
											<option value="3">정보화·변화대응교육</option>
											<option value="4">직무전문교육</option>
											<option value="5">역량개발교육</option>
											<option value="6">외국어교육</option>
											<option value="7">보기에 없음</option>
										</select>,
									</li>
									<li>(3순위)
										<select name="q_7_3">
											<option value="">-선택해주세요-</option>
											<option value="1">친절교육</option>
											<option value="2">청렴교육</option>
											<option value="3">정보화·변화대응교육</option>
											<option value="4">직무전문교육</option>
											<option value="5">역량개발교육</option>
											<option value="6">외국어교육</option>
											<option value="7">보기에 없음</option>
										</select>,
									</li>
								</ul>
								</div>
								<div>
									<ul>
										<li>①친절교육</li>
										<li>②청렴교육</li>
										<li>③정보화·변화대응교육</li>
										<li>④직무전문교육</li>
										<li>⑤역량개발교육</li>
										<li>⑥외국어교육</li>
										<li>⑦보기에 없음</li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th>[문8]</th>
							<td>
								<p>귀하께서는 군·구청 공무원에게 가장 필요하다고(부족하다고) 생각하는 교육분야는 무엇입니까?<br>
								다음 중에서 필요한 순서대로 선택해 주세요</p>
								<div>
								<ul>
									<li>(1순위)
										<select name="q_8_1">
											<option value="">-선택해주세요-</option>
											<option value="1">친절교육</option>
											<option value="2">청렴교육</option>
											<option value="3">정보화·변화대응교육</option>
											<option value="4">직무전문교육</option>
											<option value="5">역량개발교육</option>
											<option value="6">외국어교육</option>
											<option value="7">보기에 없음</option>
										</select>,
									</li>
									<li>(2순위)
										<select name="q_8_2">
											<option value="">-선택해주세요-</option>
											<option value="1">친절교육</option>
											<option value="2">청렴교육</option>
											<option value="3">정보화·변화대응교육</option>
											<option value="4">직무전문교육</option>
											<option value="5">역량개발교육</option>
											<option value="6">외국어교육</option>
											<option value="7">보기에 없음</option>
										</select>,
									</li>
									<li>(3순위)
										<select name="q_8_3">
											<option value="">-선택해주세요-</option>
											<option value="1">친절교육</option>
											<option value="2">청렴교육</option>
											<option value="3">정보화·변화대응교육</option>
											<option value="4">직무전문교육</option>
											<option value="5">역량개발교육</option>
											<option value="6">외국어교육</option>
											<option value="7">보기에 없음</option>
										</select>,
									</li>
								</ul>
								</div>
								<div>
									<ul>
										<li>①친절교육</li>
										<li>②청렴교육</li>
										<li>③정보화·변화대응교육</li>
										<li>④직무전문교육</li>
										<li>⑤역량개발교육</li>
										<li>⑥외국어교육</li>
										<li>⑦보기에 없음</li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th>[문9]</th>
							<td>
								<p>귀하께서는 행정복지센터(舊 주민자치센터) 공무원에게 가장 필요하다고(부족하다고) 생각하는 교육분야는 무엇입니까?<br>
								다음 중에서 필요한 순서대로 선택해 주세요</p>
								<div>
								<ul>
									<li>(1순위)
										<select name="q_9_1">
											<option value="">-선택해주세요-</option>
											<option value="1">친절교육</option>
											<option value="2">청렴교육</option>
											<option value="3">정보화·변화대응교육</option>
											<option value="4">직무전문교육</option>
											<option value="5">역량개발교육</option>
											<option value="6">외국어교육</option>
											<option value="7">보기에 없음</option>
										</select>,
									</li>
									<li>(2순위)
										<select name="q_9_2">
											<option value="">-선택해주세요-</option>
											<option value="1">친절교육</option>
											<option value="2">청렴교육</option>
											<option value="3">정보화·변화대응교육</option>
											<option value="4">직무전문교육</option>
											<option value="5">역량개발교육</option>
											<option value="6">외국어교육</option>
											<option value="7">보기에 없음</option>
										</select>,
									</li>
									<li>(3순위)
										<select name="q_9_3">
											<option value="">-선택해주세요-</option>
											<option value="1">친절교육</option>
											<option value="2">청렴교육</option>
											<option value="3">정보화·변화대응교육</option>
											<option value="4">직무전문교육</option>
											<option value="5">역량개발교육</option>
											<option value="6">외국어교육</option>
											<option value="7">보기에 없음</option>
										</select>,
									</li>
								</ul>
								</div>
								<div>
								<ul>
									<li>①친절교육</li>
									<li>②청렴교육</li>
									<li>③정보화·변화대응교육</li>
									<li>④직무전문교육</li>
									<li>⑤역량개발교육</li>
									<li>⑥외국어교육</li>
									<li>⑦보기에 없음</li>
								</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th>[문10]</th>
							<td><p>귀하께서는 시민으로서 공무원 교육방식이나 교육내용이 어떻게 바뀌어야 한다고 생각하십니까?<br>
							50자 이내로 자유롭게 작성해 주세요</p>
							<input id="q_10" name="q_10" type="text" maxlength="100" class="in_length98pro" >
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="survey">
				<a href="javascript:setInsert();" id="setInsert" class="submit">설문등록</a>
				<a href="#" id="Pop_Cancel" class="cancel">설문취소</a>
			</div>
		</div>
	</div>
	</form>
</article>
</body>
</html>
