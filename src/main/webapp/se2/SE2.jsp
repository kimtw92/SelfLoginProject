<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <script type="text/javascript" src="/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<textarea name="ir1" id="ir1" rows="10" cols="100" style="width:100%; height:412px; min-width:610px; display:none;"><%=request.getParameter("contents") %></textarea> 
	<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "ir1",
	    sSkinURI: "/se2/SmartEditor2Skin.html",
	    fCreator: "createSEditor2",
	 	htParams : {fOnBeforeUnload : function(){}} // 이페이지 나오기 alert 삭제
	});
	
	function removeServerName(contents){
		var res = contents;
		for(;res.indexOf(location.href.substr(0,location.href.indexOf("/",8)+1)) != -1;){
			res = res.replace(location.href.substr(0,location.href.indexOf("/",8)+1), '/');
// 			alert("res : " + res);
		}
		return res;
	}
	
	function getContents(){
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		
		var contents = document.getElementById("ir1").value;
		contents = contents.replace(/^[\s\u00a0\u3000]+|[\s\u00a0\u3000]+$/g, '');
		
		contents = removeServerName(contents);
		
		return contents;
	}
	
	// 키워드 검색
	function SearchKeyword(){
		var url = "/commonInc/daumEditerUtil.do";
		var pars = "mode=checkKeyword"
		pars += "&contents=" + getContents().stripTags().replace(/&nbsp;/g,"").replace(/[\n\r]{1,2}/g,"").replace(/[?]/g,"");
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
	
	</script>