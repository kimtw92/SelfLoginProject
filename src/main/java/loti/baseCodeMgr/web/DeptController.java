package loti.baseCodeMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.baseCodeMgr.service.DeptService;

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
public class DeptController extends BaseController {
	
	@Autowired
	private DeptService deptService;
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm
			              , Model model
			              , HttpServletRequest request
			              , HttpServletResponse response
			              , @RequestParam(value="mode", required=false, defaultValue="") String mode
			              , @RequestParam(value="menuId", required=false, defaultValue="") String menuId) throws BizException {
		
		try {
			DataMap requestMap = cm.getDataMap();
			requestMap.setNullToInitialize(true);
			
			if (mode.equals("")) {
				mode = "list";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 기관코드 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/dept.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		selectDeptCodeList(cm, model);
		
		return "/baseCodeMgr/dept/deptList";
	}
	
	/**
	 * 전체 기관 코드 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/dept.do", params = "mode=allDeptCodeList")
	public String allDeptCodeList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		selectDeptCodeList(cm, model);
		
		return "/baseCodeMgr/dept/deptList";
	}
	
	/**
	 * 부서코드 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/dept.do", params = "mode=partCodeList")
	public String partCodeList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		selectDeptCodeList(cm, model);
		
		return "/baseCodeMgr/dept/subList";
	}
	
	/** 
	 * 기관코드 리스트,전체기관 리스트,부서관리 리스트
	 */
	public void selectDeptCodeList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;
		DataMap rowMap = null;
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1); //페이지
		}
		
		if(requestMap.getString("mode").equals("list") ){
			//기관코드관리 페이지는 리스트 갯수 기준이 15개
			if (requestMap.getString("rowSize").equals("")) {
				requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
			}
		} else {
			//전체 기관코드관리 페이지는 리스트갯수 기준 10개
			if (requestMap.getString("rowSize").equals("")) {
				requestMap.setInt("rowSize", 10); //페이지당 보여줄 갯수
			}
		}
		
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		}
		
		if(requestMap.getString("mode").equals("list")){
			//기관코드 리스트
			listMap = deptService.selectDeptCodeList(requestMap);
		}else if(requestMap.getString("mode").equals("partCodeList")){
			//부서코드 리스트
			listMap = deptService.partCodeList(requestMap.getString("dept"));
			rowMap = deptService.selectAllDeptCodeRow(requestMap.getString("dept"));
		}else if(requestMap.getString("mode").equals("allDeptCodeList")){
			//전체 기관 코드 리스트
			listMap = deptService.allDeptCodeList(requestMap);
		}
		
		model.addAttribute("DEPTNMROW_DATA", rowMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	/**
	 * 기관코드 폼
	 */
	@RequestMapping(value="/baseCodeMgr/dept.do", params = "mode=form")
	public String deptCodeForm(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//리스트멥 선언
		DataMap rowMap = null;
		
		if(requestMap.getString("qu").equals("update") || requestMap.getString("qu").equals("allDeptUpdate")){
			String dept = requestMap.getString("dept");
			
			if (requestMap.getString("qu").equals("update")) {
				//기관코드 수정 폼
				rowMap = deptService.selectDeptCodeRow(dept);
			} else if(requestMap.getString("qu").equals("allDeptUpdate")) {
				//전체 기관코드 수정 폼
				rowMap = deptService.selectAllDeptCodeRow(dept);
			}
		} else {
			rowMap = new DataMap();
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/baseCodeMgr/dept/deptForm";
	}
	
	/**
	 * 기관코드관리 등록 수정
	 */
	@RequestMapping(value="/baseCodeMgr/dept.do", params = "mode=exec")
	public String deptCodeExec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if(requestMap.getString("qu").equals("insert") || requestMap.getString("qu").equals("allDeptCodeInsert") || requestMap.getString("qu").equals("partInsert")){
			//insert			: DEPT테이블에 등록 
			//allDeptInsert 	: ALLDEPT테이블에 등록
			//partInsert 		: 부서관리 인서트 
			if(requestMap.getString("qu").equals("insert")) {
				deptService.insertDept(requestMap);
			} else if(requestMap.getString("qu").equals("allDeptCodeInsert")) {
				deptService.insertAllDept(requestMap);
			} else if(requestMap.getString("qu").equals("partInsert")) {
				deptService.partInsert(requestMap);
			}
		} else if(requestMap.getString("qu").equals("update") || requestMap.getString("qu").equals("allDeptUpdate") || requestMap.getString("qu").equals("partUpdate")){
			//UPDATE : DEPT테이블이용
			//ALLDEPTUPDATE : ALLDEPT테이블 이용
			//partInsert 		: 부서관리 수정
			if(requestMap.getString("qu").equals("update")){
				deptService.modifyDeptCode(requestMap);
			}else if(requestMap.getString("qu").equals("allDeptUpdate")) {
				deptService.modifyAllDeptCode(requestMap);
			}else if(requestMap.getString("qu").equals("partUpdate")) {
				deptService.partUpdate(requestMap);
			}
			requestMap.setString("msg", "수정하였습니다.");
		} else if(requestMap.getString("qu").equals("partDelete")) {
			//부서 삭제
			deptService.partDelete(requestMap);
			requestMap.setString("msg", "삭제 하였습니다.");
		} else if(requestMap.getString("qu").equals("deptDelete")) {
			//기관삭제
			deptService.deptDelete(requestMap);
		} else if(requestMap.getString("qu").equals("allDeptDelete")) {	
			//전체 조회에서의 기관삭제
			deptService.allDeptDelete(requestMap);
		}
		
		return "/baseCodeMgr/dept/popMsg";
	}
	
	/**
	 * 부서관리 등록 수정
	 */
	@RequestMapping(value="/baseCodeMgr/dept.do", params = "mode=subForm")
	public String partCodeForm(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		//insert 리스트 데이타 없음
		if(requestMap.getString("qu").equals("insert")){
			rowMap = new DataMap();
			model.addAttribute("ROW_DATA", rowMap);
		}else if(requestMap.getString("qu").equals("update")){
			rowMap = deptService.selectPartRow(requestMap);
			model.addAttribute("ROW_DATA", rowMap);
		}
		
		return "/baseCodeMgr/dept/subFormPop";
	}
}
