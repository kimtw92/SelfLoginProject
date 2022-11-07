package loti.homepageMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.homepageMgr.service.PopupZoneService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.exception.BizException;
import ut.lib.file.FileUtil;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.support.RequestUtil;
import ut.lib.util.Constants;
import ut.lib.util.SpringUtils;
import common.controller.BaseController;

@Controller("homepageMgrPopupZoneController")
public class PopupZoneController extends BaseController {

	@Autowired
	@Qualifier("homepageMgrPopupZoneService")
	private PopupZoneService popupZoneService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, Model model
			) throws Exception{
		
		//요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = RequestUtil.getRequest(request);
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		
		if (memberInfo == null) return null;
		//default mode
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
		
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	@RequestMapping(value="/homepageMgr/popzone.do", params="mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 15);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap listMap = popupZoneService.selectPopupZoneList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepageMgr/popupZone/popupZoneList";
	}
	
	@RequestMapping(value="/homepageMgr/popzone.do", params="mode=insert")
	public String insert(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);

		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//파일 등록.
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");	
		if(fileMap == null) fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		String fileName = "";
		/*if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0){
			
		}*/
		fileName = (String)fileMap.getString("popupImg_fileName", 0);	
		
		//파일넘버값을 셋시킨다	
		requestMap.setString("fileName", fileName);
		requestMap.setString("regId",loginInfo.getSessUserId());
		
		popupZoneService.insert(requestMap);
		requestMap.setString("msg","등록하였습니다.");
		
		return "redirect:/homepageMgr/popzone.do?mode=list";
	}
	
	@RequestMapping(value="/homepageMgr/popzone.do", params="mode=delete")
	public String delete(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String sysFileName = requestMap.getString("sysFileName");
		if(!sysFileName.equals("")){
			String dir = "/popupZone";
			sysFileName = requestMap.getString("sysFileName");
			FileUtil.deleteFile(SpringUtils.getRealPath() + Constants.UPLOAD + dir, sysFileName);
		}
		popupZoneService.delete(requestMap.getString("seq"));
		requestMap.setString("msg","삭제하였습니다.");
		
		return "redirect:/homepageMgr/popzone.do?mode=list";
	}
	
	public void modForm_com(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = new DataMap();
		String seq = requestMap.getString("seq");
		rowMap = popupZoneService.selectPopupZone(seq);
		model.addAttribute("BOARDROW_DATA", rowMap);
	}
	
	@RequestMapping(value="/homepageMgr/popzone.do", params="mode=modForm")
	public String modForm(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		modForm_com(cm, model);
		
		return "/homepageMgr/popupZone/popupZoneForm";
	}
	
	@RequestMapping(value="/homepageMgr/popzone.do", params="mode=fileDelete")
	public String fileDelete(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		requestMap.setString("regId",loginInfo.getSessUserId());
		int result = popupZoneService.fileDelete(requestMap);
		if(result > 0){
			String dir = "/popupZone";
			String sysFileName = requestMap.getString("sysFileName");
			FileUtil.deleteFile(SpringUtils.getRealPath() + Constants.UPLOAD + dir, sysFileName);
		}
		
		requestMap.setString("msg","삭제하였습니다.");
		modForm_com(cm, model);
		requestMap.setString("mode", "modForm");
		
		return "/homepageMgr/popupZone/popupZoneForm";
	}
	
	@RequestMapping(value="/homepageMgr/popzone.do", params="mode=update")
	public String update(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);

		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//파일 등록.
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		if(fileMap == null) fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		String fileName = "";
		fileName = (String)fileMap.getString("popupImg_fileName", 0);	
		
		//파일넘버값을 셋시킨다	
		requestMap.setString("fileName", fileName);
		requestMap.setString("modId",loginInfo.getSessUserId());
		
		popupZoneService.update(requestMap);
		
		requestMap.setString("msg","수정하였습니다.");
		modForm_com(cm, model);
		requestMap.setString("mode", "modForm");
		
		return "redirect:/homepageMgr/popzone.do?mode=list";
	}
	
	@RequestMapping(value="/homepageMgr/popzone.do", params="mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return "/homepageMgr/popupZone/popupZoneForm";
	}
}
