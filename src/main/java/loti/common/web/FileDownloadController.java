package loti.common.web;

import loti.common.service.CommonService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;

import common.controller.BaseController;

@Controller
@RequestMapping("/commonInc/fileDownload.do")
public class FileDownloadController extends BaseController{

	@Autowired
	private CommonService commonService;
	
	/**
	 * 파일 다운로드 팝업.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void popup(
			Model model
			, DataMap requestMap) throws Exception {
		
		
		DataMap listMap = commonService.selectUploadFileList(requestMap.getInt("groupfileNo"));
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping
	public String index(CommonMap cm, Model model) throws Exception{
		return popup(cm, model);
	}
	
	@RequestMapping(params="mode=popup")
	public String popup(CommonMap cm, Model model) throws Exception{
		popup(model, cm.getDataMap());
		return "/commonInc/popup/commonFiledown";
	}
	
	
}
