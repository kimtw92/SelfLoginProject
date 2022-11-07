package loti.homepageMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;
import loti.homepageMgr.service.MoveLectService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.exception.BizException;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import common.controller.BaseController;

@Controller
public class MoveLectController extends BaseController {

	@Autowired
	private MoveLectService moveLectService;
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, Model model
			) throws Exception{
		
		//요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();
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
	
	@RequestMapping(value="/homepageMgr/moveLect.do")
	public String defaultProcess(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		return list(cm, model);
	}
	
	/**
	 * 식단관리 리스트
	 */
	@RequestMapping(value="/homepageMgr/moveLect.do", params="mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
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
		
		DataMap listMap = moveLectService.selectMovelectList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepageMgr/moveLect/moveLectList";
	}

	/**
	 * 식단관리 폼, 뷰데이터
	 * @throws Exception 
	 */
	public void form_com(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;
		if(requestMap.getString("qu").equals("modify") || requestMap.getString("mode").equals("view")){
			listMap = moveLectService.selectMovelectRow(requestMap);
		}else{
			listMap = new DataMap();
			listMap.setInt("groupfileNo", 0);
		}
		//파일 정보 가져오기.
		commonService.selectUploadFileList(listMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	/**
	 * 식단관리 폼, 뷰데이터
	 * @throws Exception 
	 */
	@RequestMapping(value="/homepageMgr/moveLect.do", params="mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception {
		form_com(cm, model);
		
		return "/homepageMgr/moveLect/moveLectForm";
	}
	
	/**
	 * 식단관리 폼, 뷰데이터
	 * @throws Exception 
	 */
	@RequestMapping(value="/homepageMgr/moveLect.do", params="mode=view")
	public String view(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception {
		form_com(cm, model);
		
		return "/homepageMgr/moveLect/moveLectForm";
	}
	
	/**
	 * 식단관리 리스트
	 */
	@RequestMapping(value="/homepageMgr/moveLect.do", params="mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		int returnValue = 0;
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String qu = requestMap.getString("qu");
		//등록 및 수정시만 파일 업로드 처리.
		int fileGroupNo = -1;
		if( qu.equals("insert") || qu.equals("modify")){
			//파일 등록.
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0)
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
		}
		
		requestMap.setInt("filegroupNo", fileGroupNo);
		
		if(requestMap.getString("qu").equals("insert")){
			returnValue = moveLectService.insertMovelect(requestMap);
			
			if(returnValue > 0){
				requestMap.setString("msg","저장하였습니다.");
			}else{
				requestMap.setString("msg","실패하였습니다.");
			}
		}else if(requestMap.getString("qu").equals("modify")){
			returnValue = moveLectService.updateMovelect(requestMap);
			
			if(returnValue > 0){
				requestMap.setString("msg","저장하였습니다.");
			}else{
				requestMap.setString("msg","실패하였습니다.");
			}
		}else if(requestMap.getString("qu").equals("delete")){
			returnValue = moveLectService.deleteMovelect(requestMap);
			
			if(returnValue > 0){
				requestMap.setString("msg","삭제하였습니다.");
			}else{
				requestMap.setString("msg","실패하였습니다.");
			}
		}
		
		return "/homepageMgr/moveLect/moveLectExec";
	}
	
	@RequestMapping(value="/homepageMgr/moveLect.do", params="mode=preview")
	public String preview(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		return "/homepageMgr/moveLect/moveLectPreview";
	}
}
