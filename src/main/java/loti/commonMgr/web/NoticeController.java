package loti.commonMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;
import loti.commonMgr.service.NoticeService;

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
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class NoticeController extends BaseController {

	@Autowired
	private NoticeService noticeService;
	
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
		LoginInfo memberInfo = new LoginInfo();
		String mode = requestMap.getString("mode");
//		관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		System.out.println(mode);
		if(mode.equals("searchPerson") ){
			memberInfo = LoginCheck.adminCheckPopup(request, response);			
		}else{
			memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId") );
		}
		
		if (memberInfo == null){			
			return null;
		}
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	@RequestMapping(value="/commonMgr/notice.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		
		//개인 그룹 공지 관리 리스트
		DataMap listMap = noticeService.selectNotiPerGrpList(requestMap.getString("searchKey"), requestMap.getString("searchValue"), loginInfo.getSessNo(), requestMap);

		model.addAttribute("LIST_DATA", listMap);
		
		return "/commonMgr/notice/noticeList";
	}
	
	@RequestMapping(value="/commonMgr/notice.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		
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
		
		
		//service Instance
		
		String qu = requestMap.getString("qu");
		
		DataMap rowMap = null;	//개인 그룹 공지 관리 상세 내용
		
		if(qu.equals("insert")){
			rowMap = new DataMap();
		}else if(qu.equals("update")){
			rowMap = noticeService.selectNotiPerGrpRow(requestMap.getInt("seq"),qu);
		}else if(qu.equals("reply")){
			rowMap = noticeService.selectNotiPerGrpRow(requestMap.getInt("seq"),qu);
		}else if(qu.equals("view")){
			rowMap = noticeService.selectNotiPerGrpRow(requestMap.getInt("seq"),qu);
		}
		
		model.addAttribute("chk_auth",chkAuthMap);
		//파일 정보 가져오기.
		commonService.selectUploadFileList(rowMap);
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/commonMgr/notice/noticeForm";
	}
	
	@RequestMapping(value="/commonMgr/notice.do", params="mode=view")
	public String view(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		form(cm, model);
		
		return "/commonMgr/notice/noticeView";
	}
	
	@RequestMapping(value="/commonMgr/notice.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		
		// 결과 메세지.
		
		String qu = requestMap.getString("qu");
		String msg = ""; 
		
		//등록 및 수정시만 파일 업로드 처리.
		int fileGroupNo = -1;		
		if( qu.equals("insert") || qu.equals("update")){
			
			//파일 등록.
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0)
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
			
		}
		String noti_part="";
		if(requestMap.getString("notiGubun").equals("P")){
			for(int i=0;i<requestMap.keySize("noti_part[]");i++){
				noti_part += "["+requestMap.getString("noti_part[]",i)+"]";
			}
		}else if(requestMap.getString("notiGubun").equals("G")){
			for(int i=0;i<requestMap.keySize("noti_group[]");i++){
				noti_part += "["+requestMap.getString("noti_group[]",i)+"]";
			}
		}	
		requestMap.setString("notiPart",noti_part);
		//실제 데이터 처리. 
		if(qu.equals("insert")){ //등록
			Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE); //나모로 넘어온값 처리.
			noticeService.insertNotice(requestMap, fileGroupNo, loginInfo.getSessNo());
			msg = "등록 되었습니다.";
			
		}else if(requestMap.getString("qu").equals("update")){ //수정.
			
			Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE); //나모로 넘어온값 처리.
			noticeService.updateNotice(requestMap, fileGroupNo);
			msg = "수정 되었습니다.";
			
		}else if(requestMap.getString("qu").equals("delete")){ //삭제
			
			noticeService.deleteNotice(requestMap.getString("seq"), loginInfo.getSessNo());
			msg = "삭제 되었습니다.";
		}
		model.addAttribute("RESULT_MSG", msg);

		return "/commonMgr/notice/noticeExec";
	}
	
	@RequestMapping(value="/commonMgr/notice.do", params="mode=searchPerson")
	public String searchPerson(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();		
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
		
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		//대상자 찾기
		DataMap listMap = noticeService.selectSearchPerList(requestMap.getString("searchKey"), requestMap.getString("searchValue"), requestMap.getString("searchText"), requestMap);
		
		model.addAttribute("chk_auth",chkAuthMap);
		model.addAttribute("personList",listMap);
		
		return "/commonMgr/notice/pop_search";
	}
		
}
