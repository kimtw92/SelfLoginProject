package loti.baseCodeMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import loti.baseCodeMgr.service.PositionService;

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
import ut.lib.util.Constants;
import ut.lib.util.SpringUtils;
import common.controller.BaseController;

@Controller
public class PositionController extends BaseController {
	@Autowired
	private PositionService positionService;
	
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
			LoginInfo memberInfo = null;
			if (mode.equals(requestMap.getString("guBunCodeForm"))) {
				memberInfo = LoginCheck.adminCheckPopup(request, response);
			} else {
				memberInfo = LoginCheck.adminCheck(request, response, menuId);
			}
			
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
	
	@RequestMapping(value="/baseCodeMgr/position.do")
	public String defaultProcess(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		return selectPositionList(cm, model);
	}
	/**
	 * 직급코드 관리 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/position.do", params = "mode=list")
	public String selectPositionList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1); //페이지
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 10); //페이지당 보여줄 갯수
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		}
		//리스트
		DataMap listMap = positionService.selectPositionList(requestMap);
		
		model.addAttribute("POSITION_LIST_DATA", listMap);
		
		return "/baseCodeMgr/position/positionList";
	}
	
	/**
	 * 직급코드 셀렉트박스 팝업폼 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/position.do", params = "mode=form")
	public String selectPositionPopList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//직급코드 셀렉트 박스 리스트 시작
		DataMap listMap = positionService.selectPositionPopList(requestMap);
		
		model.addAttribute("POSITION_SELECTLIST_DATA", listMap);
		
		return "/baseCodeMgr/position/positionForm";
	}
	
	/**
	 * 직급코드 등록, 수정 실행 메소드
	 */
	@RequestMapping(value="/baseCodeMgr/position.do", params = "mode=positionExec")
	public String positionExec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String userNo = loginInfo.getSessNo();
		//인서트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(requestMap.getString("qu").equals("insert")){
			if (requestMap.getString("jikGubun").equals("1")) {
				paramMap.put("mcodeName", requestMap.getString("mcodeName"));
				paramMap.put("jikGubun", requestMap.getString("jikGubun"));
				paramMap.put("jiknm", requestMap.getString("jiknm"));
				paramMap.put("jikjnm", requestMap.getString("jikjnm"));
				paramMap.put("jikrnm", requestMap.getString("jikrnm"));
				paramMap.put("dogsnm", requestMap.getString("dogsnm"));
				paramMap.put("useYn", requestMap.getString("useYn"));
				paramMap.put("userNo", userNo);
				paramMap.put("jiklnm", requestMap.getString("jiklnm"));
			} else if(requestMap.getString("jikGubun").equals("2")) {
				paramMap.put("mcodeName", requestMap.getString("mcodeName"));
				paramMap.put("jikGubun", requestMap.getString("jikGubun"));
				paramMap.put("jiknm", requestMap.getString("goverJiknm"));
				paramMap.put("jikjnm", "");
				paramMap.put("jikrnm", "");
				paramMap.put("dogsnm", "");
				paramMap.put("useYn", requestMap.getString("useYn"));
				paramMap.put("userNo", userNo);
				paramMap.put("jiklnm", "");
			}
			
			positionService.insertPosition(paramMap);
			
			requestMap.setString("msg", "등록하였습니다.");
		} else if(requestMap.getString("qu").equals("modify")) {
			paramMap.put("jiknm", requestMap.getString("jiknm"));
			paramMap.put("jikGubun", requestMap.getString("jikGubun"));
			paramMap.put("jikjnm", requestMap.getString("jikjnm"));
			paramMap.put("jikrnm", requestMap.getString("jikrnm"));
			paramMap.put("dogsnm", requestMap.getString("dogsnm"));
			paramMap.put("useYn", requestMap.getString("useYn"));
			paramMap.put("userNo", userNo);
			paramMap.put("jiklnm", requestMap.getString("jiklnm"));
			paramMap.put("mcodeName", requestMap.getString("mcodeName"));
			
			positionService.modifyPosition(paramMap);
			
			requestMap.setString("msg", "수정하였습니다.");
		}
		
		return "/baseCodeMgr/position/positionMsg";
	}
	
	/**
	 * 직급구분코드 관리 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/position.do", params = "mode=guBunCodeList")
	public String selectGuBunCodeList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1); //페이지
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 10); //페이지당 보여줄 갯수
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		}
		
		String guBun = requestMap.getString("guBun");
		
		//본문 리스트
		DataMap listMap = positionService.selectGuBunCodeList(guBun,requestMap);
		
		//직급 구분별 셀렉트박스 리스트
		DataMap selectBoxListMap = positionService.selectGuBunCodeSelectBoxList();
		
		model.addAttribute("GUBUNLIST_DATA", listMap);
		model.addAttribute("SELECTBOX_DATA", selectBoxListMap);
		
		return "/baseCodeMgr/position/gubunList";
	}
	
	/**
	 * 직급구분코드 셀렉트 팝업 폼
	 */
	@RequestMapping(value="/baseCodeMgr/position.do", params = "mode=guBunCodeForm")
	public String selectGuBunCodePopForm(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//직급 구분별 셀렉트박스 리스트
		DataMap selectBoxListMap = positionService.selectGuBunCodeSelectBoxList();
		
		model.addAttribute("SELECTBOX_DATA", selectBoxListMap);
		
		return "/baseCodeMgr/position/gubunForm";
	}
	
	/**
	 * 직급구분관리 코드 일관등록 폼
	 */
	@RequestMapping(value="/baseCodeMgr/position.do", params = "mode=guBunCodeUploadForm")
	public String guBunCodeUploadForm(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//직급 구분별 셀렉트박스 리스트
		DataMap selectBoxListMap = positionService.selectGuBunCodeSelectBoxList();
		
		model.addAttribute("SELECTBOX_DATA", selectBoxListMap);
		
		return "/baseCodeMgr/position/gubunUpload";
	}
	
	/**
	 * 직급구분코드 등록, 수정 실행 메소드
	 */
	@RequestMapping(value="/baseCodeMgr/position.do", params = "mode=guBunCodeExec")
	public String guBunCodeExec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String userNo = loginInfo.getSessNo();
		
		int retValue = 0;
		
		//인서트
		if(requestMap.getString("qu").equals("insert")){
			retValue = positionService.insertGubunCode(requestMap,userNo);
			
			if (retValue == 2) {
				requestMap.setString("msg", "코드가 중복됩니다.");
			} else {
				requestMap.setString("msg", "등록하였습니다.");
			}
		}
		
		return "/baseCodeMgr/position/positionMsg";
	}
	
	/**
	 * 직급코드 일괄등록, 중복된 데이터가 들어올경우 무조건 디비 롤백 후 다시 입력하도록 한다.
	 */	
	@RequestMapping(value="/baseCodeMgr/position.do", params = "mode=positionAllUpload")
	public String positionAllUpload(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		Workbook workbook = null;
		Sheet sheet = null;
		//Cell cell = null;
		int returnValue = 0;
		
		try {
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			String root = SpringUtils.getRealPath() + Constants.UPLOAD + fileMap.getString("file" + "_filePath") + fileMap.getString("file" + "_fileName");
			//엑셀파일을 인식 
			workbook = Workbook.getWorkbook( new java.io.File(root));
			
		    //엑셀파일에 포함된 sheet의 배열을 리턴한다.
		    //workbook.getSheets();
			
			//사용자 정보 추출.
			LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
			
			String userNo = loginInfo.getSessNo();
			
		    if( workbook != null) {
		        //엑셀파일에서 첫번째 Sheet를 인식
		        sheet = workbook.getSheet(0);
		
		        if( sheet != null) {
					int sheetRowCnt = sheet.getRows();
					System.out.println(sheetRowCnt);
					for(int i = 1; i < sheetRowCnt; i++ ) {
						Cell[] cells = sheet.getRow(i);
						
						if (cells[0].getContents().equals("")) {
							requestMap.setString("msg", (i+1) + "행의 직급코드를 입력하여 주십시오.");						
							break;
						} else if(cells[10].getContents().equals("")) {
							requestMap.setString("msg", (i+1) + "행의 구분을 입력하여 주십시오.");						
							break;
						}
						
						requestMap.addString("jik", cells[0].getContents());
						
						// 공사,공단 데이터일경우 직급명만 들어간다.
						// 이경우 엑셀에서 데이터를 가져올때 없을경우 널포인트가 발생하므로 예외 처리를 해준다.
						/** 예외처리 시작[s]------------------->*/
						try{
							requestMap.addString("jiknm", cells[8].getContents());
						}catch( Exception e){
							requestMap.addString("jiknm", "");
						}
						
						try{
							requestMap.addString("jikj", cells[2].getContents());
						}catch( Exception e){
							requestMap.addString("jikj", "");
						}
						
						try{
							requestMap.addString("jikr", cells[5].getContents());
						}catch( Exception e){
							requestMap.addString("jikr", "");
						}
						
						try{
							requestMap.addString("dogs", cells[7].getContents());
						}catch( Exception e){
							requestMap.addString("dogs", "");
						}
						/** <---------------------------------------  예외처리[e]*/
						requestMap.addString("jikGubun", cells[10].getContents());
					}
		        } else {
		            System.out.println( "Sheet is null!!" );
		        }
		    }
		    
		    if(!requestMap.getString("jik").equals("")){
			    //일괄등록 시작
			    returnValue = positionService.insertAllPosition(requestMap, userNo);
		    }else{
		    	returnValue = 3;
		    }
		    
		    if (returnValue == 0) {
		    	requestMap.setString("msg", "저장 실행을 하지 못하였습니다.");
		    } else if(returnValue == 1) {
		    	requestMap.setString("msg", "저장하였습니다.");
		    } else if(returnValue == 2) {
		    	requestMap.setString("msg", requestMap.getInt("returnValue")+"번째 행의 데이터가 이미 등록되어 있습니다. 다시 확인하시고 등록하여 주십시오.");
		    } else if(returnValue == 3) {
		    	requestMap.setString("msg", "엑셀데이터를 입력하시고 다시 입력 하여 주십시오.");
		    }
		} catch( Exception e) {	
			requestMap.setString("msg", "엑셀 데이터가 잘못 입력 되었습니다. /n 다시 확인하신 후 등록 하여 주십시오.");
		    e.printStackTrace();
		} finally {
		    if( workbook != null) {
		        workbook.close();
		    }
		}
		
		return "/baseCodeMgr/position/positionMsg";
	}
	
	/**
	 * 직급구분코드 일괄등록, 중복된 데이터가 들어올경우 무조건 디비 롤백 후 다시 입력하도록 한다.
	 */	
	@RequestMapping(value="/baseCodeMgr/position.do", params = "mode=guBunCodeUpload")
	public String gubunCodeAllUpload(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		Workbook workbook = null;
		Sheet sheet = null;
		//Cell cell = null;
		//리턴값
		int returnValue = 0;
		//에러난 행의 번지수 변수
		int chkCnt = 0;
		try {
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			String root = SpringUtils.getRealPath() + Constants.UPLOAD + fileMap.getString("file" + "_filePath") + fileMap.getString("file" + "_fileName");
			//엑셀파일을 인식 
			workbook = Workbook.getWorkbook( new java.io.File(root));

			//엑셀파일에 포함된 sheet의 배열을 리턴한다.
		    //workbook.getSheets();
			
			//사용자 정보 추출.
			LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
			
			String userNo = loginInfo.getSessNo();
			int chk = 0;
		    if (workbook != null) {
		        //엑셀파일에서 첫번째 Sheet를 인식
		        sheet = workbook.getSheet(0);
		
		        if (sheet != null) {
					int sheetRowCnt = sheet.getRows();

					for(int i = 1; i < sheetRowCnt; i++ ) {
						Cell[] cells = sheet.getRow(i);
						
						try {
							requestMap.addString("code", cells[0].getContents());
							requestMap.addString("codenm", cells[1].getContents());
							requestMap.addString("orders", cells[2].getContents());
							chk = 1; 
						} catch( Exception e) {
							chk = 2;
							chkCnt = i;
						}
					}
		        } else {
		            System.out.println( "Sheet is null!!" );
		        }
		    }
		    
		    if (chk == 1) {
			    //일괄등록 시작
			    returnValue = positionService.insertGubunCode(requestMap, userNo);
		    } else if(chk == 2) {
		    	returnValue = 3;
		    }
		    
		    if(returnValue == 0) {
		    	requestMap.setString("msg", "저장 실행을 하지 못하였습니다.");
		    } else if(returnValue == 1) {
		    	requestMap.setString("msg", "저장하였습니다.");
		    } else if(returnValue == 2) {
		    	requestMap.setString("msg", requestMap.getInt("returnValue")+"번째 행의 데이터가 이미 등록되어 있습니다. 다시 확인하시고 등록하여 주십시오.");
		    } else if(returnValue == 3) {
		    	requestMap.setString("msg", chkCnt+"번째행의 내용이 잘못되었습니다. 다시 확인하시고 입력하여 주십시오.");
		    }
		} catch( Exception e) {
		    e.printStackTrace();
		} finally {
		    if (workbook != null) {
		        workbook.close();
		    }
		}
		return "/baseCodeMgr/position/positionMsg";
	}
	
	/**
	 * 직급구분코드관리 일괄 입력
	 */	
	@RequestMapping(value="/baseCodeMgr/position.do", params = "mode=uploadForm")
	public String uploadForm(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		return "/baseCodeMgr/position/positionUpload";
	}
}
