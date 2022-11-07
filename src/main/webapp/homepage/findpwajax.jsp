<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>





<%

// date	: 2008-08-26
// auth 	: 양정환

%>

<%
	DataMap requestMap = (DataMap)request.getAttribute("FIND_PW");
	requestMap.setNullToInitialize(true);
	StringBuffer listHtml = new StringBuffer();

	String resno = (String)request.getAttribute("resno");
	
	//이메일 앳(@)기준으로 앞 문자의 끝 3자리 아스트리크로(*)문자로 치환 
	String email = requestMap.getString("email", 0);
	String email_show = "";
	String sp_front    = "";
	String sp_back     = "";
	if(email != "" && email.indexOf("@") != -1) {
		String[] sp = email.split("@");
		
		//앳(@) 앞 문자열의 길이가 3초과인 경우
		if(sp[0].length() > 3) {
			sp_front = sp[0].substring(0, sp[0].length()-3);
			sp_back  = sp[0].substring(sp[0].length()-3);
			sp_back = sp_back.replaceAll("([\\w-/])", "\\*");
			email_show = sp_front + sp_back + "@" + sp[1];
		
		//앳(@) 앞 문자열의 길이가 3이하인 경우 모두 아스트리크로 치환
		} else {
			email_show = sp[0].replaceAll("([\\w-/])", "\\*") + sp[1]; 
		}
	}
	
	//휴대폰 끝 4자리 아스트리크로(*) 치환
	String hp = requestMap.getString("hp", 0);
	String hp_show  = "";
	String hp_front = "";
	String hp_back  = "";
	
	//전화번호 전체 문자열의 길이가 4 초과인 경우
	if(hp.length() > 4) {
		hp_front = hp.substring(0, hp.length()-4);
		hp_back  = hp.substring(hp.length()-4);
		hp_back  = hp_back.replaceAll("[\\w-/]", "\\*");
		hp_show  = hp_front + hp_back;
	} else {
		hp_show  = hp_front + hp_back.replaceAll("[\\w-/]", "\\*");
	}
	
	if(requestMap.keySize("userno") > 0){
		if(requestMap.getString("userId", 0).equals("")) {
			listHtml.append("<form id=\"pform\" name=\"pform\" method=\"post\"> ");
			listHtml.append("<input type=\"hidden\" id=\"getresno\" name=\"resno\" value="+resno+"> ");
			listHtml.append("<div class=\"textSet01\" style=\"width:372px;\">");
			listHtml.append("고객님은 이미 가입되어 있는 이전 가입자입니다.<br />");
			listHtml.append("아아디와 패스워드를 새로 입력해 주십시오.<br />");
			listHtml.append("<span class=\"txt_org\">아이디 및 패스워드는 6자 이상입니다.</span>");
			listHtml.append("</div>");
			
			listHtml.append("<div class=\"popBoxWrap\">");
			listHtml.append("<div class=\"drBoxTop\">");
			listHtml.append("<dl>");
			listHtml.append("<dt><img src=\"/images/skin1/common/txt_id.gif\" class=\"vm2\" alt=\"아이디\" /></dt>");
			listHtml.append("<dd>");
			listHtml.append(" <input type=\"text\" id=\"alreadyuserid\" name=\"alreadyuserid\" class=\"input01 w158\" /> ");
			listHtml.append("<a href=\"javascript:idcheck();\"><img src=\"/images/skin1/button/btn_submit01.gif\" class=\"vm3\" alt=\"중복확인\" /></a>");
			listHtml.append("</dd>");
			listHtml.append(" </dl>");
			listHtml.append(" <dl>");
			listHtml.append(" <dt><img src=\"/images/skin1/common/txt_pw.gif\" class=\"vm2\" alt=\"패스워드\" /></dt>");
			listHtml.append(" <dd>");
			listHtml.append(" <input type=\"password\" id=\"alreadypassword\" name=\"alreadypassword\"  class=\"input01 w158\" /> ");
			listHtml.append("<a href=\"javascript:goRejoin();\"><img src=\"/images/skin1/button/btn_join02.gif\" class=\"vm3\" alt=\"가입하기\" /></a>");
			listHtml.append(" </dd>");
			listHtml.append("</dl>");
			listHtml.append("</div>");
			listHtml.append("</div>");
			listHtml.append("<div class=\"btnC\" style=\"width:372px;\"><a href=\"javascript:self.close();\"><img src=\"/images/skin1/button/btn_close01.gif\" alt=\"닫기\" /></a></div>	");
			listHtml.append("</form>");
		}else {
			listHtml.append("<div class=\"textSet01\" style=\"width:372px;\">");
			listHtml.append("고객님의 임시 비밀번호를 E-mail 혹은 휴대폰 문자메시지로 <br />");
			listHtml.append("보내드립니다. 원하시는 방법을 선택해주세요.<br />");
			listHtml.append("<span class=\"txt_org\">메일 및 문자는 5분이내에 발송됩니다.</span>");
			listHtml.append("</div>");
			listHtml.append("<div class=\"h10\"></div>");
			listHtml.append("<div class=\"popBoxWrap\">");
			listHtml.append("<div class=\"drBoxTop\">");
			listHtml.append("<dl>");
			listHtml.append("<dt><img src=\"/images/skin1/common/txt_email.gif\" class=\"vm1\" alt=\"E-mail\" /></dt>");
			listHtml.append("<dd>");
			listHtml.append("<input type=\"hidden\" name=\"userno\" value=\""+requestMap.getString("userno", 0)+"\">");
			listHtml.append("<input type=\"hidden\" name=\"email\" value=\""+email+"\"class=\"input01 w158\" /> ");
			listHtml.append("<input type=\"text\" name=\"email_show\" value=\""+email_show+"\"class=\"input01 w158\" disabled=\"disabled\" /> ");
			listHtml.append("<a href=\"javascript:sendEmail();\"><img src=\"/images/skin1/button/btn_select.gif\" class=\"vm3\" alt=\"선택\" /></a>");
			listHtml.append("</dd>");
			listHtml.append("</dl>");
			listHtml.append("<dl>");
			listHtml.append("<dt><img src=\"/images/skin1/common/txt_mobile.gif\" class=\"vm1\" alt=\"휴대폰\" /></dt>");
			listHtml.append("<dd>");
			listHtml.append("<input type=\"hidden\" name=\"hp\" value=\""+hp+"\" class=\"input01 w158\" /> ");
			listHtml.append("<input type=\"text\" name=\"hp_show\" value=\""+hp_show+"\" class=\"input01 w158\" disabled=\"disabled\" /> ");
			listHtml.append("<a href=\"javascript:sendHp();\"><img src=\"/images/skin1/button/btn_select.gif\" class=\"vm3\" alt=\"선택\" /></a>");
			listHtml.append("</dd>");
			listHtml.append("</dl>");
			listHtml.append("</div>");
			listHtml.append("</div>");
			listHtml.append("<div class=\"h10\"></div>");
			listHtml.append("<div class=\"textSet02\" style=\"width:372px;\">");
			listHtml.append("회원정보에 입력해두신 E-mail/휴대폰으로 비밀번호를 받을 수 없는 <br />");
			listHtml.append("상황이라면 인재개발원<strong class=\"txt_blue\">[032)440-7674]</strong>으로 문의하시기 바랍니다.  ");      
			listHtml.append("</div>");
			listHtml.append("<div class=\"btnC\" style=\"width:372px;\">");
			listHtml.append("<a href=\"javascript:self.close();\"><img src=\"/images/skin1/button/btn_close01.gif\" alt=\"닫기\" /></a>		");
			listHtml.append("</div>	");
			listHtml.append("</div>");			
		}

	} else {
		listHtml.append("<div class=\"textSet01\" style=\"width:372px;\">검색결과가 없습니다  </div>");
		listHtml.append("<div class=\"h10\"></div>");
		listHtml.append("<div class=\"btnC\" style=\"width:372px;\">");
		listHtml.append("<img src=\"/images/skin1/button/btn_research.gif\" alt=\"다시검색하기\" onclick=\"document.location.reload();\" onkeypress=\"document.location.reload();\"></a>");
		listHtml.append("<a href=\"javascript:self.close();\"><img src=\"/images/skin1/button/btn_close01.gif\" alt=\"닫기\" /></a>");
		listHtml.append("</div>	");
	
	}

%>

<%=listHtml %>





