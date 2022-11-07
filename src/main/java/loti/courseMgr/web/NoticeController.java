package loti.courseMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.courseMgr.service.NoticeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller("courseMgrNoticeController")
public class NoticeController extends BaseController {

	@Autowired
	@Qualifier("courseMgrNoticeService")
	private NoticeService noticeServicece;
	@Autowired
	private CommonService commonService;
	
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
			
			//공통 Comm Select Box 값 초기 셋팅.
			HttpSession session = request.getSession(); //세션
			if(requestMap.getString("commYear").equals(""))
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			if(requestMap.getString("commGrcode").equals(""))
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			if(requestMap.getString("commGrseq").equals(""))
				requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 과정공지사항 리스트.
	 */
	@RequestMapping(value="/courseMgr/notice.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		String grCode = requestMap.getString("commGrcode");
		String grSeq = requestMap.getString("commGrseq");
		
		//리스트
		DataMap listMap = noticeServicece.selectGrNoticeList(grCode, grSeq, requestMap.getString("searchKey"), requestMap.getString("searchValue"), requestMap);

		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/notice/noticeList";
	}
	
	/**
	 * 과정 공지 등록/ 수정 폼.
	 */
	public void form_com(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		String grCode = requestMap.getString("commGrcode");
		String grSeq = requestMap.getString("commGrseq");
		
		DataMap rowMap = null;	//과정 공지 관리 상세 내용
		
		if(qu.equals("insert")){ //등록 폼
			rowMap = new DataMap();
		}else if(qu.equals("update") || qu.equals("view")){ //수정 및 상세보기 폼
			rowMap = noticeServicece.selectGrNoticeRow(grCode, grSeq, requestMap.getInt("no"));
		}else if(qu.equals("reply")){ //답글
			rowMap = noticeServicece.selectGrNoticeRow(grCode, grSeq, requestMap.getInt("no"));
		}
		
		try {
			//파일 정보 가져오기.
			commonService.selectUploadFileList(rowMap);
		} catch(Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		model.addAttribute("ROW_DATA", rowMap);
	}
	
	/**
	 * 과정 공지 등록/ 수정 폼.
	 */
	@RequestMapping(value="/courseMgr/notice.do", params = "mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		form_com(cm, model);
		
		return "/courseMgr/notice/noticeForm";
	}
	
	/**
	 * 과정 공지 등록/ 수정 폼.
	 */
	@RequestMapping(value="/courseMgr/notice.do", params = "mode=view")
	public String view(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		form_com(cm, model);
		
		return "/courseMgr/notice/noticeView";
	}
	
	/**
	 * 과정 공지 등록/ 수정/ 삭제 실행.
	 */
	@RequestMapping(value="/courseMgr/notice.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
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

		//실제 데이터 처리. 
		if(qu.equals("insert")){ //등록
			try {
				Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_GRNOTICE); //나모로 넘어온값 처리.
			} catch(Exception e) {
				throw new BizException(e);
			} finally {
				
			}
			noticeServicece.insertGrNotice(requestMap, fileGroupNo, loginInfo.getSessNo());
			msg = "등록 되었습니다.";
		}else if(requestMap.getString("qu").equals("update")){ //수정.
			try {
				Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_GRNOTICE); //나모로 넘어온값 처리.
			} catch(Exception e) {
				throw new BizException(e);
			} finally {
				
			}
			noticeServicece.updateGrNotice(requestMap, fileGroupNo, loginInfo.getSessNo());
			msg = "수정 되었습니다.";
		}else if(requestMap.getString("qu").equals("delete")){ //삭제
			noticeServicece.deleteGrNotice(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), requestMap.getInt("no"));
			msg = "삭제 되었습니다.";
		}

		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/notice/noticeExec";
	}
}
