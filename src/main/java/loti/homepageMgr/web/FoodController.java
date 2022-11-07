package loti.homepageMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.homepageMgr.service.FoodService;

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
public class FoodController extends BaseController {

	@Autowired
	private FoodService foodService;
	
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
	
	@RequestMapping(value="/homepageMgr/food.do")
	public String defaultProcess(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return list(cm, model);
	}
	/**
	 * 식단관리 리스트
	 */
	@RequestMapping(value="/homepageMgr/food.do", params="mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 50);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap listMap = foodService.selectFoodList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepageMgr/food/foodList";
	}
	
	/**
	 * 식단관리 폼
	 */
	@RequestMapping(value="/homepageMgr/food.do", params="mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;
		
		if(requestMap.getString("qu").equals("modify")){
			listMap = foodService.selectFoodRow(requestMap);
		}else{
			listMap = new DataMap();
		}
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepageMgr/food/foodForm";
	}
	
	/**
	 * 식단관리 등록
	 */
	@RequestMapping(value="/homepageMgr/food.do", params="mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		int returnValue = 0;
		
		if(requestMap.getString("qu").equals("delete")){
			//삭제
			returnValue = foodService.deleteFood(requestMap);
			
			if(returnValue == 1 ){
				requestMap.setString("msg", "삭제하였습니다.");
			}else{
				requestMap.setString("msg", "실패하였습니다.");
			}
		}else{
			if(requestMap.getString("qu").equals("deleteInsert")){
				//삭제
				foodService.deleteFood(requestMap);
				//등록 모드로 전환
				requestMap.setString("qu", "insert");
			}
			//등록,수정
			returnValue = foodService.insertFood(requestMap);
			
			if(returnValue == 1 ){
				requestMap.setString("msg", "저장하였습니다.");
			}else{
				requestMap.setString("msg", "실패하였습니다.");
			}
		}
		
		return "/homepageMgr/food/foodExec";
	}
	
	/**
	 * 식단관리 중복체크
	 */
	@RequestMapping(value="/homepageMgr/food.do", params="mode=ajaxCountChechk")
	public String ajaxCountChechk(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		int returnValue = 0;
		
		returnValue = foodService.ajaxCountChechk(requestMap);
		requestMap.setString("count", String.valueOf(returnValue));
		
		return "/homepageMgr/food/foodAjax";
	}
	
	/**
	 *  이하의 메소드는 기존 소스의 매핑정보를 구현한 것이며, 실제 소스 상에는 없음.
	 */
	/***** START *****/
	
	@RequestMapping(value="/homepageMgr/foods.do", params="mode=lists")
	public String lists(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return "/homepageMgr/food/foodLists";
	}
	
	@RequestMapping(value="/homepageMgr/foods.do", params="mode=forms")
	public String forms(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return "/homepageMgr/food/foodForms";
	}
	
	@RequestMapping(value="/homepageMgr/foods.do", params="mode=execs")
	public String execs(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return "/homepageMgr/food/foodExecs";
	}
	
	@RequestMapping(value="/homepageMgr/foods.do", params="mode=ajaxCountChechks")
	public String ajaxCountChechks(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return "/homepageMgr/food/foodAjaxs";
	}
	
	/***** END *****/ 
}
