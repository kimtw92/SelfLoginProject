package loti.evalMgr.web;

import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.evalMgr.service.EvalMasterService;

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
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class EvalMasterController extends BaseController {
	@Autowired
	private EvalMasterService evalMasterService;
	
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
			
			mode = Util.getValue(requestMap.getString("mode"));
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			HttpSession session = request.getSession(); //세션
			if (requestMap.getString("commYear").equals("")) {
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			}
			if (requestMap.getString("commGrcode").equals("")) {
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			}
			if (requestMap.getString("commGrseq").equals("")) {
				requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
			}        
	        if (requestMap.getString("commSubj").equals("")) {
				requestMap.setString("commSubj", (String)session.getAttribute("sess_subj"));
			}
	        if (requestMap.getString("sessNo").equals("")) {
				requestMap.setString("sessNo",(String)session.getAttribute("sess_no"));
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
	 * 평가 마스터 리스트
	 */
	@RequestMapping(value="/evalMgr/evalMaster.do", params = "mode=list")
	public String selectEvalMasterList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap resultMap=new DataMap();
		
		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")){
			resultMap = evalMasterService.selectEvalMasterList(requestMap);
		}
		model.addAttribute("LIST_DATA", resultMap);
		
		return "/evalMgr/evalMaster/evalMasterList";
	}
	
    /**
     * 과정기수 평가마스터 설정 팝업
     */
	@RequestMapping(value="/evalMgr/evalMaster.do", params = "mode=EvlinfoGrseq")
    public String selectEvalMasterEvlinfoGrseq(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
    	DataMap evInfoGrseq = new DataMap();
    	DataMap ptypeMap = new DataMap();
    	DataMap mptypeMap = new DataMap();
    	DataMap closingMap = new DataMap();
    	DataMap grCodenm = new DataMap();
    	
    	if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")){	    	
    		grCodenm = evalMasterService.selectEvalMasterEvlGrcodeNm(requestMap.getString("commGrcode"));
	    	evInfoGrseq = evalMasterService.selectEvalMasterEvlinfoGrseq(requestMap);
	    	ptypeMap = evalMasterService.selectEvalMasterEvlinfoGrseqPtype(requestMap);
	    	mptypeMap = evalMasterService.selectEvalMasterEvlinfoGrseqMtype(requestMap);
	    	closingMap = evalMasterService.selectEvalMasterEvlinfoClosing(requestMap);
    	}
    	model.addAttribute("grCodenm", grCodenm);
    	model.addAttribute("evInfoGrseq", evInfoGrseq);
    	model.addAttribute("ptypeMap", ptypeMap);
    	model.addAttribute("mptypeMap", mptypeMap);
    	model.addAttribute("closingMap", closingMap);
    	
    	return "/evalMgr/evalMaster/evalMasterFormPop3";
    }
	
    /**
     * 과정 평가수 업데이트
     */
	@RequestMapping(value="/evalMgr/evalMaster.do", params = "mode=grevl_edit")
    public String updateEvInfoGrseq(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
    	int result = 0;
		String msg = "";
		String resultType = "";
		
		result = evalMasterService.updateEvInfoGrseq(requestMap);
    	
    	if (result > 0) {			
			msg = "수정 되었습니다.";						
			resultType = "ok";
		} else {			
			msg = "수정시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
    	model.addAttribute("RESULT_MSG", msg);
    	model.addAttribute("RESULT_TYPE", resultType);
		
		return "/evalMgr/evalMaster/evalMasterExec";
	}
	
    /**
     * 과정 평가수 입력
     */
	@RequestMapping(value="/evalMgr/evalMaster.do", params = "mode=grevl_ins")
    public String insertEvInfoGrseq(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
    	DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
    	int result=0;
		String msg="";
		String resultType = "";
		
    	result = evalMasterService.insertEvInfoGrseq(requestMap);
    	
    	if (result > 0) {			
			msg = "저장 되었습니다.";						
			resultType = "ok";
		} else {			
			msg = "저장시 오류가 발생했습니다.";
			resultType = "saveError";			
		}						
    	model.addAttribute("RESULT_MSG", msg);
    	model.addAttribute("RESULT_TYPE", resultType);
    	
    	return "/evalMgr/evalMaster/evalMasterExec";
	}
    
    /**
     * 평가마스터 기능 등록
     */
	@RequestMapping(value="/evalMgr/evalMaster.do", params = "mode=insertSubjSeq")
    public String selectSubjSeq(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
    	DataMap grCodeLecNm = new DataMap();
    	DataMap evInfoGrseq = new DataMap();
    	DataMap closingMap = new DataMap();
    	DataMap subjPtype = new DataMap();
    	
    	if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("") && !requestMap.getString("commSubj").equals("")){
    		grCodeLecNm = evalMasterService.selectGrcodeLecNm(requestMap);
    		evInfoGrseq = evalMasterService.selectEvalMasterEvlinfoGrseq(requestMap);
    		closingMap = evalMasterService.selectEvalMasterEvlinfoClosing(requestMap);
    		subjPtype = evalMasterService.selectEvalMasterSubjPtype(requestMap);
    	}
    	
    	model.addAttribute("grCodeLecNm", grCodeLecNm);
    	model.addAttribute("evInfoGrseq", evInfoGrseq);
    	model.addAttribute("closingMap", closingMap);
    	model.addAttribute("subjPtype", subjPtype);
    	
    	return "/evalMgr/evalMaster/evalMasterFormPop1";
    }
    
    /**
     * 
     */
	@RequestMapping(value="/evalMgr/evalMaster.do", params = "mode=subjevl")
    public String selectEvlSubjSeq(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
    	DataMap grCodeLecNm = new DataMap();
    	DataMap closingMap = new DataMap();
    	DataMap subjType = new DataMap();
    	DataMap datesInfo = new DataMap();
    	DataMap subjInfo = new DataMap();

    	if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("") && !requestMap.getString("commSubj").equals("")){
    		grCodeLecNm = evalMasterService.selectGrcodeLecNm(requestMap);
    		closingMap = evalMasterService.selectEvalMasterEvlinfoClosing(requestMap);
    		subjType = evalMasterService.selectEvalSubjType(requestMap.getString("commSubj"));
    		if(subjType.getString("subjtype").equals("Y")){
    			datesInfo = evalMasterService.selectEvalMasterDates(requestMap.getString("commSubj"));
    		}
    		subjInfo = evalMasterService.selectEvalMasterSubjPtype(requestMap);
    		if(!subjInfo.isEmpty()){
    			for(int i=0;i<subjInfo.keySize("ptype");i++){
    				String ptype=subjInfo.getString("ptype",i);
    				String ptype_nm=ptype_nm(ptype);
    				subjInfo.addString("ptype_nm", ptype_nm);
    			}
    		}
    	}
    	
    	model.addAttribute("grCodeLecNm", grCodeLecNm);
    	model.addAttribute("closingMap", closingMap);
    	model.addAttribute("subjType", subjType);
    	model.addAttribute("datesInfo", datesInfo);
    	model.addAttribute("subjInfo", subjInfo);
    	
    	return "/evalMgr/evalMaster/evalMasterFormPop2";
    }
	
    /**
     * 타입명 반환
     */
    public String ptype_nm(String ptype) {
    	String ptype_nm = "";
    	
    	if (ptype.equals("M")) {
    		ptype_nm = "중간"; 
    	} else if (ptype.equals("M")) {
    		ptype_nm = "중간";
    	} else if (ptype.equals("T")) {
    		ptype_nm = "최종";
    	} else if (ptype.equals("1")) {
    		ptype_nm = "상시1회";
    	} else if (ptype.equals("2")) {
    		ptype_nm = "상시2회";
    	} else if (ptype.equals("3")) {
    		ptype_nm = "상시3회";
    	} else if (ptype.equals("4")) {
    		ptype_nm = "상시4회";
    	} else if (ptype.equals("5")) {
    		ptype_nm = "상시5회";
    	}
	
		return ptype_nm;
    }
    
    /**
     * 설정 정보 삭제/저장/수정 수행
     */
    @RequestMapping(value="/evalMgr/evalMaster.do", params = "mode=subjevlMode")
    public String execSubjevlMode(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
    	DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
    	StringTokenizer ptypeStrT = new StringTokenizer(requestMap.getString("ptypeStr") , "|");
		int rowCount = ptypeStrT.countTokens();
		String ck_ptype = "";
		StringBuffer delete_ptype = new StringBuffer();
		int result = 0;
		String msg = "";
		String resultType = "";
		StringBuffer sb = null;
         
        for(int i=0; i < rowCount; i++){
        	ck_ptype = "";            	
        	ck_ptype = ptypeStrT.nextToken();     
         	        	
         	if(ck_ptype.equals("empty")){
         		ck_ptype = "";
         	}
         	
         	sb = new StringBuffer();
         	sb.append("dates_").append(ck_ptype);
			String iu_dates = requestMap.getString(sb.toString());
			if (iu_dates.equals("")) {
				msg = "<script>alert('평가차시를 입력하세요.');history.back();</script>";
				resultType = "saveError";
			}
			
			sb = new StringBuffer();
         	sb.append("del_").append(ck_ptype);
			if (requestMap.getString(sb.toString()).equals("D")) {
				if (delete_ptype.toString().equals("")) {
					delete_ptype.append("'").append(ck_ptype).append("'");
				} else {
					delete_ptype.append(",'").append(ck_ptype).append("'");
				}
			}			
		}
    	
        if(!delete_ptype.toString().equals("")){
        	//출제된 문제가 있는지 검색한후 없을때만 삭제한다
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("commGrcode", requestMap.getString("commGrcode"));
        	paramMap.put("commGrseq", requestMap.getString("commGrseq"));
        	paramMap.put("commSubj", requestMap.getString("commSubj"));
        	paramMap.put("deletePtype", delete_ptype.toString());
    		DataMap tb_Exchange = evalMasterService.selectEvalMasterExchange(paramMap);
    		if(!tb_Exchange.isEmpty()){
    			msg = "이미 출제된 문제지가 있어서 삭제가 불가능합니다.";
    			resultType = "saveError";			
    		}else{
    			result = evalMasterService.deleteEvalInfoSubj(paramMap);    			
    	    	if(result > 0){			
    				msg = "삭제 되었습니다.";						
    				resultType = "ok";
    			}else{			
    				msg = "삭제시 오류가 발생했습니다.";
    				resultType = "saveError";			
    			}	
    		}
    	}
    	
    	StringTokenizer ptypeStrTT = new StringTokenizer(requestMap.getString("ptypeStr") , "|");
    	
    	int rowCountT = ptypeStrTT.countTokens();
    	ck_ptype="";
    	
    	Map<String, Object> paramMap2 = null;
    	for(int i=0; i < rowCountT; i++) {
    		ck_ptype = "";
    		ck_ptype = ptypeStrTT.nextToken();
    		
    		if (ck_ptype.equals("empty")) {
    			ck_ptype = "";
    		}
    		
    		paramMap2 = new HashMap<String, Object>();
    		paramMap2.put("iu_dates", requestMap.getString("dates_"+ck_ptype));
    		paramMap2.put("iu_partf", requestMap.getString("partf_"+ck_ptype));
    		paramMap2.put("iu_partt", requestMap.getString("partt_"+ck_ptype));
    		paramMap2.put("iu_eval_type", requestMap.getString("eval_type_"+ck_ptype));
    		paramMap2.put("sessNo", requestMap.getString("sessNo"));
    		paramMap2.put("commGrcode", requestMap.getString("commGrcode"));
    		paramMap2.put("commGrseq", requestMap.getString("commGrseq"));
    		paramMap2.put("commSubj", requestMap.getString("commSubj"));
    		paramMap2.put("ck_ptype", ck_ptype);
        	
    		sb = new StringBuffer();
    		sb.append("del_").append(ck_ptype);
    		if (!requestMap.getString(sb.toString()).equals("D")) {
    			if (requestMap.getString("bf_ins_ptype").split(ck_ptype).length > 1) {
    				result = evalMasterService.updateEvalInfoSubj(paramMap2);
    				if(result > 0){
    					msg = "저장 되었습니다.";
    					resultType = "ok";
    				} else {
    					msg = "저장시 오류가 발생했습니다.";
    					resultType = "saveError";
    				}
    			} else {
    				DataMap totalSubj = evalMasterService.selectTotalSubj(paramMap2);
    				if (!totalSubj.getString("total").equals("0")) {
    					msg = "차시는 중복될수 없습니다.";
    					resultType = "saveError";
    				} else {
    					result = evalMasterService.insertEvalInfoSubj(paramMap2);
    					if (result > 0) {
    						msg = "저장 되었습니다.";
    						resultType = "ok";
    					} else {
    						msg = "저장시 오류가 발생했습니다.";
    						resultType = "saveError";
    					}
    				}
    			}
    		}
    	}
    	model.addAttribute("RESULT_MSG", msg);
    	model.addAttribute("RESULT_TYPE", resultType);
    	
    	requestMap.setString("mode", "subjevlExec");
 		
 		return "/evalMgr/evalMaster/evalMasterExec";
    }
}
