package loti.common.web;

import loti.common.service.CommonService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;

import common.RegExpUtil;
import common.controller.BaseController;

@Controller
public class DaumEditUtilController extends BaseController {

	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value="/commonInc/daumEditerUtil", params="mode=checkKeyword")
	public String checkKeyword(CommonMap cm, Model model) throws Exception{
		 //요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		//default mode
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
		String mode = requestMap.getString("mode");
		if("checkKeyword".equals(mode)) {
			checkKeyword(model, cm.getDataMap());
		}
		return "/commonInc/ajax/ajaxCheckKeyword";
	}
	
	void checkKeyword(Model model, DataMap requestMap) throws Exception{

		// 신용카드
		if(RegExpUtil.isValidCreditCard(requestMap.getString("contents"), true)) {
			model.addAttribute("returnValue", "신용카드_RegExp");
			return;
		}
		// 건강보험번호
		if(RegExpUtil.isValidHealthInsurance(requestMap.getString("contents"), true)) {
			model.addAttribute("returnValue", "건강보험번호_RegExp");
			return;
		}
		// 계좌번호
		if(RegExpUtil.isValidAccountNumber(requestMap.getString("contents"), true)) {
			model.addAttribute("returnValue", "계좌번호_RegExp");
			return;
		}
		// 여권번호
		if(RegExpUtil.isValidPassEport(requestMap.getString("contents"), true)) {
			model.addAttribute("returnValue", "여권번호_RegExp");
			return;
		}
		// 주민번호
		if(RegExpUtil.isValidJuMin(requestMap.getString("contents"), true)) {
			model.addAttribute("returnValue", "주민번호_RegExp");
			return;
		}
		// 면허증
		if(RegExpUtil.isValidDriversLicense(requestMap.getString("contents"), true)) {
			model.addAttribute("returnValue", "면허증_RegExp");
			return;
		}
		String returnValue = commonService.checkKeyword(requestMap.getString("contents"));
		model.addAttribute("returnValue", returnValue);
	}
}
