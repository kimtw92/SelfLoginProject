package loti.baseCodeMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.baseCodeMgr.service.MainCodeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import common.controller.BaseController;

@Controller
public class MainCodeController extends BaseController {
	
	@Autowired
	private MainCodeService mainCodeService;
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm
			              , Model model
			              , HttpServletRequest request
			              , HttpServletResponse response
			              , @RequestParam(value="mode", required=false, defaultValue="") String mode
			              , @RequestParam(value="menuId", required=false, defaultValue="") String menuId) throws BizException {
		
		try {
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			if (mode.equals("")) {
				mode = "mainCodelist";
				cm.getDataMap().setString("mode", mode);
			}
			
			model.addAttribute("REQUEST_DATA", cm.getDataMap());
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * mode 가 없을 경우 기본 처리
	 */
	@RequestMapping(value="/baseCodeMgr/mainCode.do")
	public String defaultProcess(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		return selectMainCodeListRtn(cm, model);
	}
	
	/**
	 * 과정 분류 코드 관리 메인 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/mainCode.do", params = "mode=mainCodelist")
	public String selectMainCodeListRtn(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		selectMainCodeList(cm, model);
		
		return "/baseCodeMgr/mainCode/mainCodeList";
	}
	
	/**
	 * 과정 분류 코드 관리 메인 리스트
	 */
	public void selectMainCodeList(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//서브리스트 데이터맵
		DataMap subListMap = null;
		//서브 리스트시 과정분류코드와 과정 분류명을 가져온다.
		DataMap mainCodeRowMap = null;
		
		//리스트
		DataMap listMap = (DataMap)mainCodeService.selectMainCodeList();
		
		//subCodeList 및 rowData (구분값이 있을경우. 상세 수정 페이지 열때 사용 되는 코드)
		if (!requestMap.getString("majorCode").equals("")) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("cdGubun", requestMap.getString("cdGubun")); //대분류코드
			paramMap.put("majorCode", requestMap.getString("majorCode")); //중분류코드
			
			subListMap = (DataMap)mainCodeService.selectSubCodeList(paramMap);
			mainCodeRowMap = (DataMap)mainCodeService.selectMajorPopFormList(paramMap);
		} else {
			subListMap 		= new DataMap();
			mainCodeRowMap 	= new DataMap();
		}

		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SUBLIST_DATA", subListMap);
		model.addAttribute("ROW_DATA", mainCodeRowMap);
	}
	
	/**
	 * 사용 : 과정분류 메인코드 
	 * 기능 : 업데이트, 인서트 폼
	 */
	@RequestMapping(value="/baseCodeMgr/mainCode.do", params = "mode=majorForm")
	public String selectMajorPopFormList(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		
		if (requestMap.getString("tu").equals("update")) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("cdGubun", requestMap.getString("cdGubun")); //대분류 코드
			paramMap.put("majorCode", requestMap.getString("majorCode")); //중분류 코드
			//업데이트 모드 : 선택된 값을 가져온다.
			rowMap = (DataMap)mainCodeService.selectMajorPopFormList(paramMap);
		} else if (requestMap.getString("tu").equals("insert")) {
			// 등록폼 모드
			rowMap = new DataMap();
		} else {
			// 둘다아닐경우
			rowMap = new DataMap();
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/baseCodeMgr/mainCode/majorFormPop";
	}
	
	/**
	 * 과정분류 코드관리 메인 코드 등록,수정 메소드
	 */
	@RequestMapping(value="/baseCodeMgr/mainCode.do", params = "mode=majorExec")
	public String majorExec(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if(requestMap.getString("tu").equals("insert")){
			//과정 코드 등록 시작
			mainCodeService.insertMainCode(requestMap);
			requestMap.setString("msg", "등록하였습니다.");
			
		}else if(requestMap.getString("tu").equals("update")){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("cdGubun", requestMap.getString("cdGubun")); //대분류코드
			paramMap.put("majorCode", requestMap.getString("majorCode")); //중분류 코드
			paramMap.put("useYn", requestMap.getString("useYn")); //코드 사용 여부 
			
			mainCodeService.updateMainCode(paramMap);
			requestMap.setString("msg", "수정 하였습니다.");	
		}
		
		return "/baseCodeMgr/mainCode/popMsg";
	}
	
	@RequestMapping(value="/baseCodeMgr/mainCode.do", params = "mode=minorForm")
	public String selectMinorForm(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("tu").equals("subCodeInsert")) {
			selectMainCodeList(cm, model);
		} else {
			selectMinorFormList(cm, model);
		}
		
		return "/baseCodeMgr/mainCode/minorFormPop";
	}
	
	/**
	 * 과정 분류코드관리 팝업 상세 리스트
	 */
	public void selectMinorFormList(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		DataMap mainCodeListMap = null;
		
		if(requestMap.getString("tu").equals("update")){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("cdGubun", requestMap.getString("cdGubun")); //대분류 코드
			paramMap.put("majorCode", requestMap.getString("majorCode")); //중분류 코드
			paramMap.put("minorCode", requestMap.getString("minorCode")); //소분류 코드
			
			rowMap = (DataMap)mainCodeService.selectMinorPopFormList(paramMap);
			mainCodeListMap = new DataMap();
		}else if(requestMap.getString("tu").equals("insert")){
			rowMap = new DataMap();
			mainCodeListMap = (DataMap)mainCodeService.selectMainCodeList();
		}else{
			mainCodeListMap = new DataMap();
			rowMap = new DataMap();
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("MAINCODE_LIST_DATA", mainCodeListMap);
	}
	
	/**
	 * 과정분류 코드관리 상세  등록 메소드
	 */
	@RequestMapping(value="/baseCodeMgr/mainCode.do", params = "mode=minorExec")
	public String minorExec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//상세 등록을 할때에는 셀렉박스의 값이 g/1 식으로 되어있어서 글자를 잘라야한다.
		//그래서 수정당시의 변수가 겹치는 상황이 생겨서 따로 선언을 하여서 사용을 한다.
		String cdGubun = "";
		String majorCode ="";
		
		//소분류 코드
		String minorCode 	=  requestMap.getString("minorCode");
		//코드 사용 여부 
		String useYn		=  requestMap.getString("useYn");
		
		
		//등록값할때에 메인코드값과 중분류 코드값은 팝업창의 셀렉박스에 넣어져 있다. 이값을 스프릿을 사용하여 자른다.
        if(requestMap.getString("tu").equals("insert")){
        	//가져온 대분류값과 중분류값을 분리한다.
			String mainCode = requestMap.getString("mainCode");
	        String[] mainCodeArry = new String[2];
	        mainCodeArry =mainCode.split("[/]");
	        //대분류
	        cdGubun = mainCodeArry[0];
	        //중분류
	        majorCode = mainCodeArry[1];
	        
	        // 과정코드 인서트 메소드 시작
	        Map<String, Object> paramMap = new HashMap<String, Object>();
	        paramMap.put("cdGubun", cdGubun);
	        paramMap.put("majorCode", majorCode);
	        paramMap.put("scodeName", requestMap.getString("scodeName"));
	        paramMap.put("useYn", useYn);
	        mainCodeService.insertSubCode(paramMap);
	        requestMap.setString("msg", "등록 하였습니다.");
        
        }else if(requestMap.getString("tu").equals("update")){
        	//대분류 코드
    		cdGubun 		= requestMap.getString("cdGubun");
    		//중분류 코드
    		majorCode 	=  requestMap.getString("majorCode");

			//과정코드 수정 메서드 시작 
    		Map<String, Object> paramMap = new HashMap<String, Object>();
    		paramMap.put("cdGubun", cdGubun);
    		paramMap.put("majorCode", majorCode);
    		paramMap.put("minorCode", minorCode);
    		paramMap.put("useYn", useYn);
    		mainCodeService.updateSubCode(paramMap);
			requestMap.setString("msg", "수정 하였습니다.");
        }
		
		//등록,수정한 후 리스트 페이지를 보여주기 위해서 대분류와 중분류 코드값을 셋시킨다.
		requestMap.setString("cdGubun",cdGubun);
		requestMap.setString("majorCode",majorCode);
		
		return "/baseCodeMgr/mainCode/popMsg";
	}
	
	/**
	 * 상세 분류 리스트..
	 */
	@RequestMapping(value="/baseCodeMgr/mainCode.do", params = "mode=ajaxSubcode")
	public String ajaxSubcode(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		//상세분류 리스트.
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = (DataMap)mainCodeService.selectMainSubCodeList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/baseCodeMgr/mainCode/mainSubCodeAjax";
	}
}
