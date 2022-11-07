package loti.homepageMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;
import loti.homepageMgr.service.NoticeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import common.controller.BaseController;

@Controller("homepageMgrNoticeController")
public class NoticeController extends BaseController {
	
	@Autowired
	@Qualifier("homepageMgrNoticeService")
	private NoticeService noticeService;
	
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
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/homepageMgr/notice.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
		) throws Exception{
		return list(cm, model);
	}
	
	/**
	 * 개인 그룹 공지 관리 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void list(
			Model model,
			DataMap requestMap,
			LoginInfo loginInfo
			) throws Exception {
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		
		//개인 그룹 공지 관리 리스트
		DataMap listMap = noticeService.selectNotiPerGrpList(requestMap.getString("searchKey"), requestMap.getString("searchValue"), loginInfo.getSessNo(), requestMap);

		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/homepageMgr/notice.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		list(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/homepageMgr/notice/noticeList");
	}
	
	/**
	 * 개인 그룹 공지 관리 상세 내용
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void form(
			Model model,
			DataMap requestMap,
			LoginInfo loginInfo
			) throws Exception {
		
		//공통으로 사용할 체크 박스 권한 맵
		boolean tmpBool = false;
		DataMap chkAuthMap = new DataMap();
		for (int i = 0; i < Constants.ADMIN_SESS_INFO.length ; i++){
			if(Constants.ADMIN_SESS_INFO[i].equals(loginInfo.getSessClass())){
				tmpBool = true;
				continue;
			}
			
			if(tmpBool){
				chkAuthMap.add("auth", Constants.ADMIN_SESS_INFO[i]);
				chkAuthMap.add("auth_name", Constants.ADMIN_SESS_INFO_NAME[i]);
			}
				
			
		}
		
		String qu = requestMap.getString("qu");
		
		DataMap rowMap = null;	//개인 그룹 공지 관리 상세 내용
		
		
		if(qu.equals("insert")){
			rowMap = new DataMap();
		}else if(qu.equals("update")){
			rowMap = noticeService.selectNotiPerGrpRow(requestMap.getInt("seq"));
		}else if(qu.equals("reply")){
			rowMap = noticeService.selectNotiPerGrpRow(requestMap.getInt("seq"));
		}else if(qu.equals("view")){
			rowMap = noticeService.selectNotiPerGrpRow(requestMap.getInt("seq"));
		}
		
		
		//파일 정보 가져오기.
		commonService.selectUploadFileList(rowMap);
		
		model.addAttribute("ROW_DATA", rowMap);
		
	}
	
	@RequestMapping(value="/homepageMgr/notice.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		form(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/homepageMgr/notice/noticeForm");
	}
	
	@RequestMapping(value="/homepageMgr/notice.do", params="mode=view")
	public String view(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		form(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/homepageMgr/notice/noticeView");
	}
	
	/**
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void exec(
			Model model
			, DataMap requestMap
			, LoginInfo loginInfo
			) throws Exception {
		
		// 결과 메세지.
		String msg = ""; 
		//파일 등록.
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		if(fileMap == null)
			fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("fileUploadOk") > 0 )
			commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());

		//등록.
		//service.insertGrSeq(requestMap, grSeqListMap, loginInfo.getSessNo());
		
		msg = "기수가 추가 되었습니다.";
			
		model.addAttribute("RESULT_MSG", msg);
		
		
	}
	
	@RequestMapping(value="/homepageMgr/notice.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		exec(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/homepageMgr/notice/noticeExec");
	}
	
	
}
