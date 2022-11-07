<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
	String contents		= Util.getValue(request.getParameter("contents"), "");
%>
<link rel="stylesheet" href="/daumeditor/css/editor.css" type="text/css"/>
<script src="/daumeditor/js/editor.js" type="text/javascript"></script>
<script src="/daumeditor/js/editor_sample.js" type="text/javascript"></script>
	
<style type="text/css">
	body { padding:0;margin:0; background:#fff; font-family:'굴림',gulim,sans-serif; font-size:12px;  }
	
	.header {
		font-size:12px; color:#fff; font-weight:bold; 
		height:23px; margin:0; padding:11px 9px 0 20px; 
		background-image:url(http://icon.daum-img.net/editor/music/bg_top.gif?rv=1.0.1); 
	}
	
	.body { float:left; }
	.wrapper { float:left; }
	.dialog { float:right; }
	
	form { padding:0;margin:0; }
	.field {
		padding: 0; margin:10px 0;
	}
	.field input {
		background:#fafafa; height:14px; padding:2px 0 0 2px;
		border-color:#bdbdbd #d1d1d1 #d1d1d1 #bdbdbd; border-style:solid; border-width:1px;
		color:#666666; font-size:12px;
	}
	.field select { font-size:12px; }
	
	.alert { padding:0; background:url(http://icon.daum-img.net/editor/file/ico_stop.gif?rv=1.0.1) 0 0 no-repeat; margin:14px 36px 21px; color:#999; }
	.alert dt { margin:0; font-size:12px; font-weight:bold; color:#6486e4; padding:8px 0 9px 37px; }
	.alert dd { line-height:17px; margin:0 0 0 36px; padding:0;}
	.alert strong { 
		color:#a7b9ec; font-weight:normal;
	}
	.alert a { color:#666; text-decoration:none; background:url(http://icon.daum-img.net/editor/file/b_link.gif?rv=1.0.1) 100% 50% no-repeat; padding:0 7px 0 0; }
	.alert a:hover { text-decoration:underline; }
	
	.footer {
		padding:10px 0 10px 330px; margin:10px 0 0 0; height:25px; background-color:#e9e9e9; clear:both;
	}
	
	/* width, position  */
	.body { width:100%; }
	.wrapper { width:800px; padding: 0 20px; }
	
</style>
<script type="text/javascript">
// <![CDATA[
	/*-------- 글 등록할 때 필요한 함수들 시작 ----------*/
	
	/* 예제용 함수 */
	function saveContent() {
		Editor.save(); /* 이 함수를 호출하여 글을 등록하면 된다. */
	}
	
	/**
	 * Editor.save()를 호출한 경우 데이터가 유효한지 검사하기 위해 부르는 콜백함수로 
	 * 상황에 맞게 수정하여 사용한다.
	 * 모든 데이터가 유효할 경우에 true를 리턴한다. 
	 * @function
	 * @param {Object} editor - 에디터에서 넘겨주는 editor 객체
	 * @returns {Boolean} 모든 데이터가 유효할 경우에 true
	 */
	function validForm(editor) { 
		/* 제목 필드가 따로 존재할 경우 'tx_article_title'를 해당 아이디로 교체하여 사용. */
		if($tx('tx_article_title').value == ""){
			alert('제목을 입력하세요');
			return false;
		}

		/* 본문 내용이 입력되었는지 검사하는 부분 */
		var _validator = new Trex.Validator();
		var _content = editor.getContent();
		if(!_validator.exists(_content)) {
			alert('내용을 입력하세요');
			return false;
		}
		
		return true;
	}

	/**
	 * Editor.save()를 호출한 경우 데이터가 유효하면
	 * Form Summit을 위해 필드를 생성, 변경하기 위해 부르는 콜백함수로 
	 * 상황에 맞게 수정하여 사용한다.
	 * 정상적인 경우에 true를 리턴한다. 
	 * @function
	 * @param {Object} editor - 에디터에서 넘겨주는 editor 객체
	 * @returns {Boolean} 정상적인 경우에 true
	 */
	function setForm(editor) {
		var _formGen = editor.getForm();
		
		var _content = editor.getContent();
		_formGen.createField(
			tx.textarea({ 
				/* 본문 내용을 필드를 생성하여 값을 할당하는 부분 */
				'name': "tx_content", 
				'style': { 'display': "none" } 
			}, 
			_content)
		);

		/* 아래의 코드는 첨부된 데이터를 필드를 생성하여 값을 할당하는 부분으로 상황에 맞게 수정하여 사용한다.
		 첨부된 데이터 중에 주어진 종류(image,file..)에 해당하는 것만 배열로 넘겨준다. */  
		var _attachments = editor.getAttachments('image');
		for(var i=0,len=_attachments.length;i<len;i++) {
			/* existStage는 현재 본문에 존재하는지 여부 */ 
			if (_attachments[i].existStage) {
				/* data는 팝업에서 execAttach 등을 통해 넘긴 데이터 */
				alert(_attachments[i].data);
				_formGen.createField(
					tx.input({ 
						'type': "hidden", 
						'name': 'tx_attach_image', 
						'value': _attachments[i].data.imageurl /* 예에서는 이미지경로만 받아서 사용 */
					})
				);
			}
		}
		
		return true;
	}

// 키워드 검색
function SearchKeyword(){
	var url = "/commonInc/daumEditerUtil.do";
	var pars = "mode=checkKeyword"
	pars += "&contents=" + $("content").value.stripTags().replace(/&nbsp;/g,"").replace(/[\n\r]{1,2}/g,"").replace(/[?]/g,"");
	var ischeck = false;
	var ajax = new Ajax.Request(
		url, 
		{
			method: "post", 
		    parameters:pars,
			asynchronous : false,
			onSuccess : function(request){									
				if(request.responseText.indexOf("pass") == -1 && request.responseText.indexOf("_RegExp") == -1) {
					ischeck = false;
					alert(trim(request.responseText) + " 은(는) 금지어 입니다.");
				} else if(request.responseText.indexOf("pass") == -1 && request.responseText.indexOf("_RegExp") != -1) {
					ischeck = false;
					alert(trim(request.responseText.replace("_RegExp","")) + "형식은(는) 입력하실수 없습니다.");
				} else {
					ischeck = true;
				}
			},
			onFailure : function(){
				ischeck = false;
				alert("키워드 검색중에 오류가 발생했습니다.");
			}    
		}
	);
	return ischeck ;
}

/*-------- 글 등록할 때 필요한 함수들 끝 ----------*/
	// ]]>
</script>
<div class="body" >
	<!-- 에디터 시작 -->
	<!--
		@decsription 
		등록하기 위한 Form으로 상황에 맞게 수정하여 사용한다. Form 이름은 에디터를 생성할 때 설정값으로 설정한다. 
	-->
	<div class="wrapper" style="width:95%;">
		<div class="field">
			<!-- 제목, 카테고리 영역 시작 -->
			<!-- select name="tx_article_category" id="tx_article_category" style="width:150px;">
				<option value="0">카테고리 선택</option>
				<option value="1">나의 이야기 </option>
				<option value="2">너의 이야기 </option>
				<option value="3">우리들의 이야기 </option>
			</select -->
			<!-- input type="text" name="tx_article_title" id="tx_article_title" value="제목 테스트" size="80"/ -->
			<!-- 제목, 카테고리 영역 끝 -->
		</div>
		<!-- 에디터 컨테이너 시작 -->
		<div id="tx_trex_container" name="tx_trex_container" class="tx-editor-container">
			<!-- 사이드바 -->
			<div id="tx_sidebar" class="tx-sidebar"><div class="tx-sidebar-boundary">
				<!-- 사이드바 / 첨부 -->
				<ul class="tx-bar tx-bar-left tx-nav-attach">
					<!-- 이미지 첨부 버튼 시작 -->
					<!--
						@decsription 
						<li></li> 단위로 위치를 이동할 수 있다. 
					-->
			<!-- li class="tx-list">
				<div unselectable="on" id="tx_image" class="tx-image tx-btn-trans">
					<a href="javascript:;" title="사진" class="tx-text">사진</a>
				</div>
			</li -->
							<!-- 이미지 첨부 버튼 끝 -->
								<!-- li class="tx-list">
				<div unselectable="on" id="tx_file" class="tx-file tx-btn-trans">
					<a href="javascript:;" title="파일" class="tx-text">파일</a>
				</div>
			</li -->
										<!-- li class="tx-list">
				<div unselectable="on" id="tx_media" class="tx-media tx-btn-trans">
					<a href="javascript:;" title="외부컨텐츠" class="tx-text">외부컨텐츠</a>
				</div>
			</li -->
							<!-- li class="tx-list tx-list-extra">
						<div unselectable="on" class="tx-btn-nlrbg tx-extra">
							<a href="javascript:;" class="tx-icon" title="버튼 더보기">버튼 더보기</a>
						</div>
						<ul class="tx-extra-menu tx-menu" style="left:-48px;" unselectable="on">
							<!-- 
								@decsription
								일부 버튼들을 빼서 레이어로 숨기는 기능을 원할 경우 이 곳으로 이동시킬 수 있다. 
							-->
						</ul>
					</li -->
				</ul>
				<!-- 사이드바 / 우측영역 -->
				<ul class="tx-bar tx-bar-right tx-nav-opt">
								<li class="tx-list">
				<div unselectable="on" class="tx-switchtoggle" id="tx_switchertoggle">
					<a href="javascript:;" title="에디터 타입">에디터</a>
				</div>
			</li>
						</ul>
			</div></div>

			<div id="tx_toolbar_basic" class="tx-toolbar tx-toolbar-basic"><div class="tx-toolbar-boundary">
				<ul class="tx-bar tx-bar-left">
				 			<li class="tx-list">
				<div id="tx_fontfamily" unselectable="on" class="tx-slt-70bg tx-fontfamily">
					<a href="javascript:;" title="글꼴">굴림</a>
				</div>
				<div id="tx_fontfamily_menu" class="tx-fontfamily-menu tx-menu" unselectable="on"></div>
			</li>
						 </ul>
				<ul class="tx-bar tx-bar-left">
			 	 			<li class="tx-list">
				<div unselectable="on" class="tx-slt-42bg tx-fontsize" id="tx_fontsize">
					<a href="javascript:;" title="글자크기">9pt</a>
				</div>
				<div id="tx_fontsize_menu" class="tx-fontsize-menu tx-menu" unselectable="on"></div>
			</li>
						</ul>
				<ul class="tx-bar tx-bar-left tx-group-font"> 
				
				 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-lbg 	tx-bold" id="tx_bold">
					<a href="javascript:;" class="tx-icon" title="굵게 (Ctrl+B)">굵게</a>
				</div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-bg 	tx-underline" id="tx_underline">
					<a href="javascript:;" class="tx-icon" title="밑줄 (Ctrl+U)">밑줄</a>
				</div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-bg 	tx-italic" id="tx_italic">
					<a href="javascript:;" class="tx-icon" title="기울임 (Ctrl+I)">기울임</a>
				</div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-bg 	tx-strike" id="tx_strike">
					<a href="javascript:;" class="tx-icon" title="취소선 (Ctrl+D)">취소선</a>
				</div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-slt-tbg 	tx-forecolor" style="background-color:#5c7fb0;" id="tx_forecolor">
					<a href="javascript:;" class="tx-icon" title="글자색">글자색</a>
					<a href="javascript:;" class="tx-arrow" title="글자색 선택">글자색 선택</a>
				</div>
				<div id="tx_forecolor_menu" class="tx-menu tx-forecolor-menu tx-colorpallete" unselectable="on"></div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-slt-brbg 	tx-backcolor" style="background-color:#5c7fb0;" id="tx_backcolor">
					<a href="javascript:;" class="tx-icon" title="글자 배경색">글자 배경색</a>
					<a href="javascript:;" class="tx-arrow" title="글자 배경색 선택">글자 배경색 선택</a>
				</div>
				<div id="tx_backcolor_menu" class="tx-menu tx-backcolor-menu tx-colorpallete" unselectable="on"></div>
			</li>
						</ul>
				<ul class="tx-bar tx-bar-left tx-group-align"> 
				 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-lbg 	tx-alignleft" id="tx_alignleft">
					<a href="javascript:;" class="tx-icon" title="왼쪽정렬 (Ctrl+,)">왼쪽정렬</a>
				</div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-bg 	tx-aligncenter" id="tx_aligncenter">
					<a href="javascript:;" class="tx-icon" title="가운데정렬 (Ctrl+.)">가운데정렬</a>
				</div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-bg 	tx-alignright" id="tx_alignright">
					<a href="javascript:;" class="tx-icon" title="오른쪽정렬 (Ctrl+/)">오른쪽정렬</a>
				</div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-rbg 	tx-alignfull" id="tx_alignfull">
					<a href="javascript:;" class="tx-icon" title="양쪽정렬">양쪽정렬</a>
				</div>
			</li>
						</ul>
				<ul class="tx-bar tx-bar-left tx-group-tab"> 
				 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-lbg 	tx-indent" id="tx_indent">
					<a href="javascript:;" title="들여쓰기 (Tab)" class="tx-icon">들여쓰기</a>
				</div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-rbg 	tx-outdent" id="tx_outdent">
					<a href="javascript:;" title="내어쓰기 (Shift+Tab)" class="tx-icon">내어쓰기</a>
				</div>
			</li>
						</ul>
				<ul class="tx-bar tx-bar-left tx-group-list">
				 			<li class="tx-list">
				<div unselectable="on" class="tx-slt-31lbg tx-lineheight" id="tx_lineheight">
					<a href="javascript:;" class="tx-icon" title="줄간격">줄간격</a>
					<a href="javascript:;" class="tx-arrow" title="줄간격">줄간격 선택</a>
				</div>
				<div id="tx_lineheight_menu" class="tx-lineheight-menu tx-menu" unselectable="on"></div>
			</li>
						 			<!-- li class="tx-list">
				<div unselectable="on" class="tx-slt-31rbg tx-styledlist" id="tx_styledlist">
					<a href="javascript:;" class="tx-icon" title="리스트">리스트</a>
					<a href="javascript:;" class="tx-arrow" title="리스트">리스트 선택</a>
				</div>
				<div id="tx_styledlist_menu" class="tx-styledlist-menu tx-menu" unselectable="on"></div>
			</li-->
						</ul>
				<ul class="tx-bar tx-bar-left tx-group-etc">
							<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-lbg 	tx-emoticon" id="tx_emoticon">
					<a href="javascript:;" class="tx-icon" title="이모티콘">이모티콘</a>
				</div>
				<div id="tx_emoticon_menu" class="tx-emoticon-menu tx-menu" unselectable="on"></div>
			</li>
									<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-bg 	tx-link" id="tx_link">
					<a href="javascript:;" class="tx-icon" title="링크 (Ctrl+K)">링크</a>
				</div>
				<div id="tx_link_menu" class="tx-link-menu tx-menu"></div>
			</li>
									<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-bg 	tx-specialchar" id="tx_specialchar">
					<a href="javascript:;" class="tx-icon" title="특수문자">특수문자</a>
				</div>
				<div id="tx_specialchar_menu" class="tx-specialchar-menu tx-menu"></div>
			</li>
									<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-bg 	tx-table" id="tx_table">
					<a href="javascript:;" class="tx-icon" title="표만들기">표만들기</a>
				</div>
				<div id="tx_table_menu" class="tx-table-menu tx-menu" unselectable="on">
					<div class="tx-menu-inner">
						<div class="tx-menu-preview"></div>
						<div class="tx-menu-rowcol"></div>
						<div class="tx-menu-deco"></div>
						<div class="tx-menu-enter"></div>
					</div>
				</div>
			</li>
									<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-rbg 	tx-horizontalrule" id="tx_horizontalrule">
					<a href="javascript:;" class="tx-icon" title="구분선">구분선</a>
				</div>
				<div id="tx_horizontalrule_menu" class="tx-horizontalrule-menu tx-menu" unselectable="on"></div>
			</li>
						</ul>
				<ul class="tx-bar tx-bar-left"> 
				 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-lbg 	tx-textbox" id="tx_textbox">
					<a href="javascript:;" class="tx-icon" title="글상자">글상자</a>
				</div>		
				<div id="tx_textbox_menu" class="tx-textbox-menu tx-menu"></div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-bg 	tx-quote" id="tx_quote">
					<a href="javascript:;" class="tx-icon" title="인용구 (Ctrl+Q)">인용구</a>
				</div>
				<div id="tx_quote_menu" class="tx-quote-menu tx-menu" unselectable="on"></div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-bg 	tx-background" id="tx_background">
					<a href="javascript:;" class="tx-icon" title="배경색">배경색</a>
				</div>
				<div id="tx_background_menu" class="tx-menu tx-background-menu tx-colorpallete" unselectable="on"></div>
			</li>
						 			<!-- li class="tx-list">
				<div unselectable="on" class="		 tx-btn-rbg 	tx-dictionary" id="tx_dictionary">
					<a href="javascript:;" class="tx-icon" title="사전">사전</a>
				</div>
			</li -->
						</ul> 
				<!-- ul class="tx-bar tx-bar-left tx-group-undo"> 
				 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-lbg 	tx-undo" id="tx_undo">
					<a href="javascript:;" class="tx-icon" title="실행취소 (Ctrl+Z)">실행취소</a>
				</div>
			</li>
						 			<li class="tx-list">
				<div unselectable="on" class="		 tx-btn-rbg 	tx-redo" id="tx_redo">
					<a href="javascript:;" class="tx-icon" title="다시실행 (Ctrl+Y)">다시실행</a>
				</div>
			</li>
						</ul --> 
				<!-- ul class="tx-bar tx-bar-right">
				 			<li class="tx-list">
				<div unselectable="on" class="tx-btn-nlrbg tx-advanced" id="tx_advanced">
					<a href="javascript:;" class="tx-icon" title="툴바 더보기">툴바 더보기</a>
				</div>
			</li>
						</ul -->
			</div></div>
			<!-- 툴바 - 기본 끝 -->
			<!-- 툴바 - 더보기 시작 -->
			<div id="tx_toolbar_advanced" class="tx-toolbar tx-toolbar-advanced"><div class="tx-toolbar-boundary">
				<ul class="tx-bar tx-bar-left tx-group-order">
				
				</ul>
				<!-- ul class="tx-bar tx-bar-right">
				 			<li class="tx-list">
				<div unselectable="on" class="tx-btn-lrbg tx-fullscreen" id="tx_fullscreen">
					<a href="javascript:;" class="tx-icon" title="넓게쓰기 (Ctrl+M)">넓게쓰기</a>
				</div>
			</li>
						</ul -->
			</div></div>
			<!-- 툴바 - 더보기 끝 -->
			<!-- 편집영역 시작 -->
				<!-- 에디터 Start -->
	<div id="tx_canvas" class="tx-canvas">
		<div id="tx_loading" class="tx-loading"><div><img src="/daumeditor/images/icon/loading2.png?rv=1.0.1" width="113" height="21" align="absmiddle"/></div></div>
		<div id="tx_canvas_wysiwyg_holder" class="tx-holder" style="display:block;">
			<iframe id="tx_canvas_wysiwyg" name="tx_canvas_wysiwyg" allowtransparency="true" frameborder="0"></iframe>
		</div>
		<div class="tx-source-deco">
			<div id="tx_canvas_source_holder" class="tx-holder">
				<textarea id="tx_canvas_source" rows="30" cols="30"></textarea>
			</div>
		</div>
		<div id="tx_canvas_text_holder" class="tx-holder">
			<textarea id="tx_canvas_text" rows="30" cols="30"></textarea>
		</div>	
	</div>
					<!-- 높이조절 Start -->
	<div id="tx_resizer" class="tx-resize-bar">
		<div class="tx-resize-bar-bg"></div>
		<img id="tx_resize_holder" src="/daumeditor/images/icon/btn_drag01.gif" width="58" height="12" unselectable="on" alt="" />
	</div>
					<div class="tx-side-bi" id="tx_side_bi">
		<div style="text-align: right;">
			<img hspace="4" height="14" width="78" align="absmiddle" src="/daumeditor/images/icon/editor_bi.png?rv=1.0.1" />
		</div>
	</div>
				<!-- 편집영역 끝 -->
			<!-- 첨부박스 시작 -->
				<!-- 파일첨부박스 Start -->
	<div id="tx_attach_div" class="tx-attach-div" style="display:none;">
		<div id="tx_attach_txt" class="tx-attach-txt">파일 첨부</div>
		<div id="tx_attach_box" class="tx-attach-box">
			<div class="tx-attach-box-inner">
				<div id="tx_attach_preview" class="tx-attach-preview"><p></p><img src="/daumeditor/images/icon/pn_preview.gif" width="147" height="108" unselectable="on"/></div>
				<div class="tx-attach-main">
					<div id="tx_upload_progress" class="tx-upload-progress"><div>0%</div><p>파일을 업로드하는 중입니다.</p></div>
					<ul class="tx-attach-top">
						<li id="tx_attach_delete" class="tx-attach-delete"><a>전체삭제</a></li>
						<li id="tx_attach_size" class="tx-attach-size">
							파일: <span id="tx_attach_up_size" class="tx-attach-size-up"></span>/<span id="tx_attach_max_size"></span>
						</li>
						<li id="tx_attach_tools" class="tx-attach-tools">
						</li>
					</ul>
					<ul id="tx_attach_list" class="tx-attach-list"></ul>
				</div>
			</div>
		</div>
	</div>
				<!-- 첨부박스 끝 -->
		</div>
		<!-- 에디터 컨테이너 끝 -->
	</div>
</div>
<!-- 에디터 끝 -->
<script type="text/javascript">
	new Editor({
		txHost: '',
		txPath: '/daumeditor/',
		txVersion: '5.4.0',
		txService: 'sample', 
		txProject: 'sample', 
		initializedId: "",
		wrapper: "tx_trex_container"+"",
		form: 'tx_editor_form'+"",
		txIconPath: "/daumeditor/images/icon/",
		txDecoPath: "/daumeditor/images/deco/", 
		canvas: {
			styles: {
				color: "#999", 
				fontFamily: "굴림",
				fontSize: "10pt",
				backgroundColor: "#fff",
				lineHeight: "1.5",
				padding: "8px" 
			}
		},
		sidebar: {
			attacher: {
				image: {
				},
				file: {
				}
			}
		},
		size: {
			contentWidth: 700 
		}
	});
</script>


<!--
	저장된 컨텐츠를 불러오기 위한 예제
	내용을 문자열로 입력하거나, 이미 주어진 필드(textarea)가 있을 경우 엘리먼트를 넘겨준다. 
-->

<textarea style="display:none;" id="tx_load_content" name="tx_load_content" cols="80" rows="10"><%=contents%></textarea>
<script type="text/javascript">
// <![CDATA[
	/*-------- 컨텐츠 불러오기 시작 ----------*/
	/* 예제용 함수 */
	function loadContent() {					
		/* 저장된 컨텐츠를 불러오기 위한 함수 호출 */
		try {
			Editor.modify({
				"content": $tx("tx_load_content") /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */ 
			});
		} catch (e) {
		}

	}
	/**/
// ]]>
</script>
