package loti.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
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
import ut.lib.util.Constants;
import ut.lib.util.SpringUtils;
import common.controller.BaseController;

@Controller
public class SearchZipController extends BaseController {

	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{
		
		 //요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		//관리자단의 폼페이지를 열기위한  임시 문장...
		//if(!requestMap.getString("joinform").equals("")) 
		if(requestMap.getString("menuId").equals("6-1-4")) {
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
			if (memberInfo == null) return null;
		}
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	@RequestMapping(value="/search/searchZip.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		return form(cm, model);
	}
	
	@RequestMapping(value="/search/searchZip.do", params="mode=form")
	public String form(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			){
		//우편번호폼은 데이터가 없기때문에 전부다 널처리한다.
		DataMap listMap = null;
		
		listMap = new DataMap();
		model.addAttribute("LIST_DATA", listMap);
		
		return "/commonInc/search/searchZipPop";
	}
	
	@RequestMapping(value="/search/searchZip.do", params="mode=list")
	public String list(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		DataMap listMap = null;
		
		 if(requestMap.getString("qu").equals("search1")){
			 
			 //qu = search1 처음 검색 리스트
			 listMap = commonService.selectSearchZip(requestMap.getString("addr3"));
			 
		 } if(requestMap.getString("qu").equals("search2")){
			 
			 //qu = search2 두번째 검색 리스트 처음 리스트에서 특정 주소를 확인한 후 집코드를 검색값으로 한다.
			 
			 //실제 첫번째 집코드 필드명
			 String zipCode1 = "";
			 //실제 두번째 집코드 필드명
			 String zipCode2 = "";
			 String zip = requestMap.getString("zipValue");
			 
			 String[] zipCode = zip.split("-"); 
			 for(int i = 0; i < zipCode.length; i++) {
				 zipCode1 = zipCode[0];
				 zipCode2 = zipCode[1];
			 } 
			 listMap = commonService.selectSearchZip(zipCode1,zipCode2);
		 }
		model.addAttribute("LIST_DATA", listMap);
		
		return "/commonInc/search/searchZipPop";
	}
	
	@RequestMapping(value="/search/searchZip.do", params="mode=zipUploadExec")
	public String zipUploadExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//엑셀데이터 사용 
		Workbook workbook = null;
		Sheet sheet = null;
		Cell cell = null;
		//처리과정 확인 리턴밸류
		int returnValue = 0;
		//우편번호를 자르기위한 구분 변수
		String zipCode = "";
		String[] zipCode1 = null;
		
		try{
			
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			String root = SpringUtils.getRealPath() + Constants.UPLOAD + fileMap.getString("file" + "_filePath") + fileMap.getString("file" + "_fileName");
			//엑셀파일을 인식 
			workbook = Workbook.getWorkbook( new java.io.File(root));
			
		    if( workbook != null)
		    {
		        //엑셀파일에서 첫번째 Sheet를 인식
		        sheet = workbook.getSheet(0);
		
		        if( sheet != null)
		        {
					int sheetRowCnt = sheet.getRows();

					for(int i = 2; i < sheetRowCnt; i++ ) {
						Cell[] cells = sheet.getRow(i);
						//집코드가 잘못되었을경우를 대비하여 예외처리 잘못되었을경우 에러 메시지 후 롤백 returnValue = 9
						try{
							zipCode = cells[0].getContents();
							zipCode1 = zipCode.split("/");
						}catch( Exception e){
							returnValue = 9;
							break;
						}
						
						//등록이 잘못되었을때에 에러가 발생하는 경우가 있음. 그래서 예외 처리함. returnValue = 8
						try{
							requestMap.addString("zipCode1", zipCode1[0]);
							requestMap.addString("zipCode2", zipCode1[1]);
							requestMap.addString("addr1", cells[2].getContents());
							requestMap.addString("addr2", cells[3].getContents());
							requestMap.addString("addr3", cells[4].getContents());
							requestMap.addString("addr4", cells[5].getContents()+" "+cells[12].getContents());
							requestMap.addString("addr5", cells[8].getContents()+" "+cells[10].getContents());
							
						}catch( Exception e){
							returnValue = 8;
							break;
						}
					}
					
					if(returnValue != 8 || returnValue != 9){
						returnValue = commonService.insertAllZipcode(requestMap);
						
					}
					
					if(returnValue == 8){
						requestMap.setString("msg", "엑셀 데이터가 잘못되었습니다. 확인하시고 다시 입력하여 주십시오.");
						
					}else if(returnValue == 9){
						requestMap.setString("msg", "우편번호가 잘못되었습니다. 다시 입력하여 주십시오.");
						
					}else if(returnValue == 1){
						requestMap.setString("msg", "저장하였습니다.");
						
					}else if(returnValue == 0){
						requestMap.setString("msg", "저장에 실패하였습니다.");
						
					}else if(returnValue == 2){
						requestMap.setString("msg", "우편번호가 잘못되었습니다. 다시 입력하여 주십시오.");
						
					}else if(returnValue == 7){
						requestMap.setString("msg", (requestMap.getInt("rowCnt")+3)+"행의 우편번호가 잘못되었습니다. 다시 입력하여 주십시오.");
					}
					

					
		        } else
		        {
		            System.out.println( "Sheet is null!!" );
		        }
		    }
		}  catch( Exception e){
		    e.printStackTrace();
		}
		finally{
		    if( workbook != null)
		    {
		        workbook.close();
		    }
		}
		
		return "/baseCodeMgr/zip/uploadZipExec";
	}
	
	/**
	 * 우편번호 일괄 등록
	 */
	@RequestMapping(value="/baseCodeMgr/zip.do", params="mode=form")
	public String formBaseCodeMgr(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception{
		//우편번호폼은 데이터가 없기때문에 전부다 널처리한다.
		DataMap listMap = null;
		
		listMap = new DataMap();
		model.addAttribute("LIST_DATA", listMap);
				
		return "/baseCodeMgr/zip/zipUpload";
	}
}
