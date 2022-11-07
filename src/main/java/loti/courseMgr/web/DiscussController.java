package loti.courseMgr.web; 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.courseMgr.service.DiscussService;

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
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class DiscussController extends BaseController {

	@Autowired
	private DiscussService discussService;
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
	
	@RequestMapping(value="/courseMgr/discuss.do")
	public String defaultProcess(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		return list(cm, model);
	}
	/**
	 * 과정 토론방 리스트.
	 */
	@RequestMapping(value="/courseMgr/discuss.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		String grcode = requestMap.getString("commGrcode");
		String grseq = requestMap.getString("commGrseq");
		
		//상위글 리스트
		DataMap topListMap = discussService.selectGrDiscussTopList(grcode, grseq);
		
		//토론 리스트 
		DataMap listMap = discussService.selectGrDiscussBySearchList(grcode, grseq, requestMap.getString("searchKey"), requestMap.getString("searchValue"), requestMap);

		model.addAttribute("TOP_LIST_DATA", topListMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/discuss/discussList";
	}
	
	/**
	 * 과정 토론방 상세보기.
	 */
	@RequestMapping(value="/courseMgr/discuss.do", params = "mode=view")
	public String view(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = discussService.selectGrDiscussRow(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getInt("seq"));
		
		//파일 정보 가져오기.
		try {
			commonService.selectUploadFileList(rowMap);
		} catch(Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/courseMgr/discuss/discussView";
	}
	
	/**
	 * 등록 / 수정 / 답글 폼.
	 */
	@RequestMapping(value="/courseMgr/discuss.do", params = "mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		
		DataMap rowMap = null;	// 상세 내용
		if(qu.equals("insert")){ //등록 폼
			rowMap = new DataMap();
		}else if(qu.equals("update")){ //수정 및 상세보기 폼
			rowMap = discussService.selectGrDiscussRow(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getInt("seq"));
		}else if(qu.equals("reply")){ //수정 및 상세보기 폼
			rowMap = discussService.selectGrDiscussRow(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getInt("seq"));
			if(rowMap == null) rowMap = new DataMap();
			rowMap.setNullToInitialize(true);
			
			rowMap.setString("title", "[답변] "+rowMap.getString("title"));
			rowMap.setString("content", "------ 이전글 ------<br> "+rowMap.getString("content"));
			rowMap.setString("groupfileNo", "-1");
		}
		
		//파일 정보 가져오기.
		try {
			commonService.selectUploadFileList(rowMap);
		} catch(Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/courseMgr/discuss/discussForm";
	}
	
	/**
	 * 과정 토론 등록/ 수정/ 삭제 실행.
	 */
	@RequestMapping(value="/courseMgr/discuss.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		// 결과 메세지.
		String qu = requestMap.getString("qu");
		String msg = ""; 
		
		//등록,수정,답글시만 파일 업로드 처리.
		int fileGroupNo = -1;
		if( qu.equals("insert") || qu.equals("update") || qu.equals("reply")){
			//파일 등록.
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0)
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
		}

		//실제 데이터 처리. 
		if(qu.equals("insert")){ //등록
			requestMap.setString("wuserno", loginInfo.getSessNo());
			requestMap.setString("username", loginInfo.getSessName());
			
			try {
				Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_GRDISCUS); //나모로 넘어온값 처리.
			} catch(Exception e) {
				throw new BizException(e);
			} finally {
				
			}
			int result = discussService.insertGrDiscuss(requestMap, fileGroupNo);
			
			if(result > 0) msg = "등록 되었습니다.";
			else msg = "실패";
		}else if(requestMap.getString("qu").equals("update")){ //수정.
			requestMap.setString("wuserno", loginInfo.getSessNo());
			requestMap.setString("username", loginInfo.getSessName());
			
			try {
				Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_GRDISCUS); //나모로 넘어온값 처리.
			} catch(Exception e) {
				throw new BizException(e);
			} finally {
				
			}
			int result = discussService.updateGrDiscuss(requestMap, fileGroupNo);
			
			if(result > 0) msg = "수정 되었습니다.";
			else msg = "실패";
		}else if(requestMap.getString("qu").equals("reply")){ //답변
			requestMap.setString("wuserno", loginInfo.getSessNo());
			requestMap.setString("username", loginInfo.getSessName());
			try {
				Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_GRDISCUS); //나모로 넘어온값 처리.
			} catch(Exception e) {
				throw new BizException(e);
			} finally {
				
			}
			int result = discussService.insertGrDiscussByReply(requestMap, fileGroupNo);
			
			if(result > 0) msg = "등록 되었습니다.";
			else msg = "실패";
		}else if(requestMap.getString("qu").equals("delete")){ //삭제
			int result = discussService.deleteGrDiscuss(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getInt("seq"));
			if(result > 0) msg = "삭제 되었습니다.";
			else msg = "실패";
		}

		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/discuss/discussExec";
	}
}
