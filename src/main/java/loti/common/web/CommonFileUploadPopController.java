package loti.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class CommonFileUploadPopController extends BaseController {

	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String mode = Util.getValue(requestMap.getString("mode"));		
		System.out.println("mode="+mode);
		
		//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		LoginInfo memberInfo = LoginCheck.adminCheckPopup(request, response);
		if (memberInfo == null) return null;
		
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	@RequestMapping(value="/commonInc/commonFileUploadPop.do", params="mode=form")
	public String form(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws NumberFormatException, Exception{
		
		String groupfileNo = Util.getValue( cm.getDataMap().getString("groupfileNo"), "0");

		DataMap listMap = commonService.selectUploadFileList( Integer.parseInt(groupfileNo) );
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/commonInc/popup/commonFileUploadPop";
	}
	
	@RequestMapping(value="/commonInc/commonFileUploadPop.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws NumberFormatException, Exception{
		
		
		DataMap requestMap = cm.getDataMap();
		
		int fileGroupNo = -1;
		String msg = "";
		String resultType = "";
		
		
		LoginInfo loginInfo = cm.getLoginInfo();
		
		
		
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		if(fileMap == null) fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		
		if( fileMap.keySize("fileSysName") > 0 || 
				fileMap.keySize("existFile") > 0 || 
				fileMap.keySize("deleteFile") > 0|| 
				fileMap.keySize("fileUploadOk") > 0){
			
			fileGroupNo = commonService.insertInnoUploadFile(fileMap, 
					requestMap.getString("INNO_SAVE_DIR"), 
					loginInfo.getSessNo());
			
			
			if(fileGroupNo < 0){
				msg = "파일이 삭제되었습니다.";
			}else{
				msg = "업로드가 완료되었습니다.";
			}
			
			resultType = "ok";
			
		}else{
			msg = "업로드된 파일이 없습니다.";
			resultType = "nonfile";			
		}
		
		model.addAttribute("FILEGROUPNO", String.valueOf( fileGroupNo ) );
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
		
		return "/commonInc/popup/commonFileUploadExec";
	}
}
