package loti.index.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.support.CommonMap;
import common.controller.BaseController;

@Controller("index")
public class IndexController extends BaseController {

	@RequestMapping("/index.do")
	public String index(CommonMap cm, Model model){
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", cm.getDataMap());
		return "/index";
	}
}
