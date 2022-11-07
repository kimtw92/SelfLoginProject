<%@page import="egovframework.rte.psl.dataaccess.util.EgovMap"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.servlet.FrameworkServlet"%>
<%@page import="loti.common.service.CommonService"%>
<%@page import="org.springframework.web.context.ContextLoader"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ut.lib.support.DataMap"%>
<%
	String session_id = (String)request.getSession().getAttribute("sess_userid");
	String menucode = request.getParameter("menucode");
	
	String attr = FrameworkServlet.SERVLET_CONTEXT_PREFIX+"dispatcher";

	WebApplicationContext context =  WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext(),attr);

	CommonService service = context.getBean(CommonService.class);
	
	
	DataMap listMap  = service.selectPageAdminInfo(menucode);
	listMap.setNullToInitialize(true);
%>

<div class="rigthSection">
	<div class="research">
<%
	if(listMap.keySize("menucode") > 0){
		for(int i=0; i < listMap.keySize("menucode"); i++){
			if("Y".equals(listMap.getString("adminUseyn", i))) {
				if(!"".equals(listMap.getString("deptname", i)) && !"".equals(listMap.getString("adminTel", i))) {
%>
			<script language="JavaScript" type="text/JavaScript">
			function checkMax(obj, max, checkMaxID){
			  var sTxt = obj.value;
			  if( sTxt.length > max ) {
				alert(max+'자 이내로 입력해 주십시오.');
				obj.value = obj.value.substring(0, max );
				return false;
			  }
			  var sCheckMaxID = document.getElementById(checkMaxID);
			  sCheckMaxID.innerHTML = sTxt.length;
			  return true;
			}
			</script>
			<h3 class="displayNone">담당자정보</h3>
			<div class="header">
			  <div class="l"></div>
			  <div class="r"></div>
			  <div class="lSec">
				<ul>
				  <li class="pt1"><strong>담당부서</strong> : <%= "".equals(listMap.getString("deptname", i)) ? "입력되지않음":listMap.getString("deptname", i)%></li>
				  <li class="pt2"><strong>담당전화번호</strong> : <%= "".equals(listMap.getString("adminTel", i)) ? "입력되지않음":" " + listMap.getString("adminTel", i)%></li>
				</ul>
			  </div>
			</div>
<%
				}
			}
		}
	}
	if(listMap.keySize("menucode") > 0){
	for(int i=0; i < listMap.keySize("menucode"); i++){
		if("Y".equals(listMap.getString("menuscoreUseyn", i))) {
			if(!"".equals(listMap.getString("deptname", i)) && !"".equals(listMap.getString("adminTel", i))) {
%>
<script language="JavaScript" type="text/JavaScript">
function goSave(){
	if($F("session_id") == "null" || $F("session_id") == "") {
		alert("로그인을 해주세요.");
		return;
	}
	if(confirm($F("menuname") + " 만족도 조사를 저장 하시겠습니까?")) {
		var url = "/homepageMgr/menuScore.do";
		var menuScore = getRadioValue(Form.getInputs('scoreform',  'radio', 'menuScore'));
		var pars = "mode=ajaxSaveMenuScore";
		pars += "&menucode=" + $F("menucode");
		pars += "&menuScore=" + menuScore;
		pars += "&opinion=" + $F("opinion");

		var myAjax = new Ajax.Request(
			url, 
			{
				method: "post", 
				parameters:pars,
				onSuccess : function(data){		
					var result = trim(data.responseText);
					if(result == 'ok'){
						alert($F("menuname") + "설문조사가 저장되었습니다.");
						document.location.reload();
						return;
					} else if(result == 'loginfail'){
						alert("로그인을 해주세요.");
						return;
					} else if(result == 'cnt'){
						alert($F("menuname") + "설문조사에 이미 참여하셧습니다.");
						return;
					}
					alert("저장중 에러가 발생 했습니다. 관리자에게 문의해 주세요.");
				},
				onFailure : function(){
					alert("데이터를 조회하는데 실패하였습니다.");
				}    
			}
		);
	}
    function getRadioValue(obj)  {
        if(obj != null) {
            for(var i = 0; i < obj.length; i++) {
                if(obj[i].checked) {
                    return obj[i].value;
                }
            }
        }        
        return null;
    }
}
</script>
	<div class="body">
	  <div class="l"></div>
	  <div class="r"></div>
	  <table class="outside">
		<tr>
		  <td class="padding1">
			<dl class="text">
			  <!-- dt><strong class="c1">시민 만족도 조사</strong></dt -->
			  <!-- dd>홈페이지의 서비스향상을 위한 시민 여러분들의 만족도 조사를 실시하고 있습니다.<br />이 페이지에서 제공하는 정보에 대하여 어느 정도 만족하셨습니까?</dd -->
			  <dd>이 페이지에서 제공하는 정보에 대하여 어느 정도 만족하셨습니까?</dd>
			</dl>
			<fieldset>
			  <legend>시민 만족도 조사 체크폼</legend>
			  <form name="scoreform" id="scoreform" action="#">
			  <input type="hidden" id="session_id" name="session_id" value="<%=session_id%>"/>
			  <table class="form">
				<tr>
				  <td class="padding2">
					<ul class="check">
					  <li><label for="menuScore1"><input type="radio" id="menuScore1" name="menuScore" class="objCk" checked="checked" value="10" title="선택버튼" /> 매우만족</label></li>
					  <li><label for="menuScore2"><input type="radio" id="menuScore2" name="menuScore" class="objCk" value="7.5" title="선택버튼" /> 만족</label></li>
					  <li><label for="menuScore3"><input type="radio" id="menuScore3" name="menuScore" class="objCk" value="5" title="선택버튼" /> 보통</label></li>
					  <li><label for="menuScore4"><input type="radio" id="menuScore4" name="menuScore" class="objCk" value="2.5" title="선택버튼" /> 불만족</label></li>
					  <li><label for="menuScore5"><input type="radio" id="menuScore5" name="menuScore" class="objCk" value="0" title="선택버튼" /> 매우불만족</label></li>
					</ul>
					<table class="input">
					  <tr>
						<td class="textarea">
						  <input type="hidden" id="menucode" name="menucode" value="<%=menucode%>" />
						  <input type="hidden" id="menuname" name="menuname" value="<%=listMap.getString("menuname", i)%>" />
						  <textarea id="opinion" name="opinion" onkeyup="checkMax(this, 1000, 'opinionlength'); return false;" cols="100" rows="" title="내용입력"></textarea>
						  <div class="lSec"><strong>1,000자 이내</strong>로 입력하여 주십시오.</div>
						  <div class="rSec">현재 <strong class="c2"><span id="opinionlength">0</span></strong>자 (최대 1,000자)</div>
						</td>
						<td class="btn"><input type="image" onclick="goSave(); return false;" src="/homepage_new/images/common/btn_add.gif" alt="의견등록" /></td>
					  </tr>
					</table>
				  </td>
				</tr>
			  </table>
			  </form>
			</fieldset>
		  </td>
		</tr>
	  </table>
	</div>           
	<hr />
<%
				}
			}
		}
	}
%>
	</div>
</div>


