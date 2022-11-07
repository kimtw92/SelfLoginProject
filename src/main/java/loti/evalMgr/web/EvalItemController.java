package loti.evalMgr.web;

import java.text.DecimalFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.evalMgr.service.EvalItemService;
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
public class EvalItemController extends BaseController {

	@Autowired
	private EvalItemService evalItemService;
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
			//default mode		
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
			if (requestMap.getString("commYear").equals("")) {
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			}
			if (requestMap.getString("commGrcode").equals("")) {
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			}
			if (requestMap.getString("commGrseq").equals("")) {
				requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
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
	 * 평가항목 관리 리스트
	 */
	@RequestMapping(value="/evalMgr/evalItem.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String commGrcode = requestMap.getString("commGrcode");
		String commGrseq= requestMap.getString("commGrseq");
		
		//mevalYn,levalYn,nevalCnt
		DataMap evalItemEvalCnt = new DataMap();
		// 자식과목의 부모과목정보 refSubj,cCnt,lecnm
		DataMap evalItemChildParent = new DataMap();
		DataMap childCnt = new DataMap();
        DataMap parentNm = new DataMap();
        DataMap recordList = new DataMap();
        //특수과목 리스트
        DataMap srecordList = new DataMap();        
        //과제물 리스트
        DataMap reprecord = new DataMap();
        DataMap gradeInfo = new DataMap();
        DataMap classinfo = new DataMap();
        DataMap reportList = new DataMap();
        
        int nevalCnt = 0;
        int reportCnt = 0;
        int count = 0;
        
		if (!commGrcode.equals("") && !commGrseq.equals("")) {
			DataMap evalItemClosing = evalItemService.selectEvalItemClosing(requestMap);
			if (!evalItemClosing.isEmpty()) {
				reportCnt=Integer.parseInt(evalItemClosing.getString("reportCnt"));
			}
			
			evalItemEvalCnt = evalItemService.selectEvalItemEvalCnt(requestMap);
			if(!evalItemEvalCnt.isEmpty()){
				nevalCnt=Integer.parseInt(evalItemEvalCnt.getString("nevalCnt"));
			}
			
			//자식과목의 부모과목정보
			evalItemChildParent = evalItemService.selectEvalItemChildParent(requestMap);			
            for(int i=0;i<evalItemChildParent.keySize("lecnm");i++) {            
            	childCnt.addString(evalItemChildParent.getString("refSubj",i),evalItemChildParent.getString("cCnt",i));
            	parentNm.addString(evalItemChildParent.getString("refSubj",i),evalItemChildParent.getString("lecnm",i));            
            }       
            
            //리스트 가져옴
            DataMap recordTemp = evalItemService.selectEvalItemRecordList(requestMap);           
            
            String bf_ref_subj ="";
            
            if (!recordTemp.isEmpty()) {
            	for(int i=0;i<recordTemp.keySize("subj");i++) {
            		count=count+1;
            		recordList.addString("j",String.valueOf(count));
            		recordList.addString("subj",recordTemp.getString("subj",i));
            		recordList.addString("lecnm",recordTemp.getString("lecnm",i));
            		recordList.addString("lecType", recordTemp.getString("lecType",i));
            		recordList.addString("subjType", recordTemp.getString("subjtype",i));
            		recordList.addString("refSubj", recordTemp.getString("refSubj",i));
            		recordList.addString("evlCnt",recordTemp.getString("evlCnt",i));
            		recordList.addString("ptypem",recordTemp.getString("ptypem",i));
            		recordList.addString("ptypet",recordTemp.getString("ptypet",i));
            		recordList.addString("ptype1",recordTemp.getString("ptype1",i));
            		recordList.addString("ptype2",recordTemp.getString("ptype2",i));
            		recordList.addString("ptype3",recordTemp.getString("ptype3",i));
            		recordList.addString("ptype4",recordTemp.getString("ptype4",i));
            		recordList.addString("ptype5",recordTemp.getString("ptype5",i));
            		
            		StringBuffer subjGnm = new StringBuffer();            		
            		if (Integer.parseInt(recordTemp.getString("evlCnt",i)) >= 1) {
            			subjGnm.append("<font color=blue>평가지정과목</font><br>");
            		} else {
            			subjGnm.append("일반과목<br>");
            		}
            		
            		if (recordTemp.getString("lecType",i).equals("S")) {
            			recordList.addString("rowspan","1");
            			subjGnm.append("단일");
            		} else if (recordTemp.getString("lecType",i).equals("C") ) {
            			if (!recordTemp.getString("refSubj",i).equals(bf_ref_subj)) {
            				recordList.addString("rowspan",childCnt.getString(recordTemp.getString("refSubj",i)));	
            			} else {
            				recordList.addString("rowspan","0");
            			}
            			
            			subjGnm.append("선택<br>(").append(parentNm.getString(recordTemp.getString("refSubj",i))).append(")");
            		}
            		
            		recordList.addString("subjGnm",subjGnm.toString());
            		recordList.addInt("mgakpoint", recordTemp.getInt("mgakpoint", i));
            		recordList.addInt("mjupoint", recordTemp.getInt("mjupoint", i));
            		recordList.addInt("lgakpoint", recordTemp.getInt("lgakpoint", i));
            		recordList.addInt("ljupoint", recordTemp.getInt("ljupoint", i));
            		recordList.addInt("ngakpoint1", recordTemp.getInt("ngakpoint1", i));
            		recordList.addInt("njupoint1", recordTemp.getInt("njupoint1", i));
            		recordList.addInt("ngakpoint2", recordTemp.getInt("ngakpoint2", i));
            		recordList.addInt("njupoint2", recordTemp.getInt("njupoint2", i));
            		recordList.addInt("ngakpoint3", recordTemp.getInt("ngakpoint3", i));
            		recordList.addInt("njupoint3", recordTemp.getInt("njupoint3", i));
            		recordList.addInt("ngakpoint4", recordTemp.getInt("ngakpoint4", i));
            		recordList.addInt("njupoint4", recordTemp.getInt("njupoint4", i));
            		recordList.addInt("ngakpoint5", recordTemp.getInt("ngakpoint5", i));
            		recordList.addInt("njupoint5", recordTemp.getInt("njupoint5", i));
            		recordList.addFloat("mgakweight", Float.valueOf(recordTemp.getInt("mgakweight", i))/100);
            		recordList.addFloat("mjuweight", Float.valueOf(recordTemp.getInt("mjuweight", i))/100);
            		recordList.addFloat("lgakweight", Float.valueOf(recordTemp.getInt("lgakweight", i))/100);
            		recordList.addFloat("ljuweight", Float.valueOf(recordTemp.getInt("ljuweight", i))/100);
            		recordList.addFloat("ngakweight1", Float.valueOf(recordTemp.getInt("ngakweight1", i))/100);
            		recordList.addFloat("njuweight1", Float.valueOf(recordTemp.getInt("njuweight1", i))/100);
            		recordList.addFloat("ngakweight2", Float.valueOf(recordTemp.getInt("ngakweight2", i))/100);
            		recordList.addFloat("njuweight2", Float.valueOf(recordTemp.getInt("njuweight2", i))/100);
            		recordList.addFloat("ngakweight3", Float.valueOf(recordTemp.getInt("ngakweight3", i))/100);
            		recordList.addFloat("njuweight3", Float.valueOf(recordTemp.getInt("njuweight3", i))/100);
            		recordList.addFloat("ngakweight4", Float.valueOf(recordTemp.getInt("ngakweight4", i))/100);
            		recordList.addFloat("njuweight4", Float.valueOf(recordTemp.getInt("njuweight4", i))/100);
            		recordList.addFloat("ngakweight5", Float.valueOf(recordTemp.getInt("ngakweight5", i))/100);
            		recordList.addFloat("njuweight5", Float.valueOf(recordTemp.getInt("njuweight5", i))/100);
            		recordList.addFloat("reportpoint", Float.valueOf(recordTemp.getInt("reportpoint", i))/100);
            		recordList.addFloat("steppoint", Float.valueOf(recordTemp.getInt("steppoint", i))/100);
            		recordList.addFloat("grastep", Float.valueOf(recordTemp.getInt("grastep", i))/100);
            		/*recordList.addFloat("quizpoint",Float.valueOf(recordTemp.getInt("quizpoint", i))/100);
            		recordList.addFloat("graquiz",Float.valueOf(recordTemp.getInt("graquiz", i))/100);*/
            		recordList.addFloat("totpoint", Float.valueOf(recordTemp.getInt("totpoint", i))/100);

            		if (!recordTemp.getString("subjtype",i).equals("Y")) {
						recordList.addString("readReport", "readonly style='width:30px;border-color:black;border-width:1px'");
						recordList.addString("readSteppoint", "readonly style='width:30px;border-color:black;border-width:1px'");
						recordList.addString("readGrastep", "readonly style='width:30px;border-color:black;border-width:1px'");
						/*recordList.addString("readQuizpoint","readonly style='width:30px;border-color:black;border-width:1px'");
						recordList.addString("readGraquiz","readonly style='width:30px;border-color:black;border-width:1px'");*/
						recordList.addString("readTotpoint", "readonly style='width:30px;border-color:black;border-width:1px'");
					} else {
						recordList.addString("readReport", "style='width:30px;background:yellow'");
						recordList.addString("readSteppoint", "style='width:30px;background:yellow'");
						recordList.addString("readGrastep", "style='width:30px;background:yellow'");
						/*recordList.addString("readQuizpoint","style='width:30px;background:yellow'");
						recordList.addString("readGraquiz","style='width:30px;background:yellow'");*/
						recordList.addString("readTotpoint", "style='width:30px;background:yellow'");
					}
					
					if(recordTemp.getString("ptypem",i).equals("1") || recordTemp.getInt("mgakpoint", i) > 0 || recordTemp.getInt("mjupoint", i) > 0 || recordList.getFloat("mgakweight",i) > 0 || recordList.getFloat("mjuweight",i) > 0) {
						recordList.addString("calMgak", new DecimalFormat("######.##").format(recordTemp.getInt("mgakpoint", i)*recordList.getFloat("mgakweight",i)));
						recordList.addString("calMju", new DecimalFormat("######.##").format(recordTemp.getInt("mjupoint", i)*recordList.getFloat("mjuweight",i)));
            			recordList.addString("readM", "style='width:30px;background:yellow'");
					} else {
						recordList.addString("readM", "readonly style='width:30px;border-color:black;border-width:1px'");
					}

					if(recordTemp.getString("ptypet",i).equals("1") || recordTemp.getInt("lgakpoint", i) > 0 || recordTemp.getInt("ljupoint", i) > 0 || recordList.getFloat("lgakweight", i) > 0 || recordList.getFloat("ljuweight", i) > 0){
						recordList.addString("calLgak", new DecimalFormat("######.##").format(recordTemp.getInt("lgakpoint", i)*recordList.getFloat("lgakweight", i)));
						recordList.addString("calLju", new DecimalFormat("######.##").format(recordTemp.getInt("ljupoint", i)*recordList.getFloat("ljuweight", i)));            		  	
            			recordList.addString("readL", "style='width:30px;background:yellow'");
					} else {
						recordList.addString("readL", "readonly style='width:30px;border-color:black;border-width:1px'");
					}
					
					if(recordTemp.getString("ptype1",i).equals("1") || recordTemp.getInt("ngakpoint1", i) > 0 || recordTemp.getInt("njupoint1", i) > 0 || recordList.getFloat("ngakweight1", i) > 0 || recordList.getFloat("njuweight1", i) > 0){
						recordList.addString("calNgak1", new DecimalFormat("######.##").format(recordTemp.getInt("ngakpoint1", i)*recordList.getFloat("ngakweight1", i) ));
						recordList.addString("calNju1", new DecimalFormat("######.##").format(recordTemp.getInt("njupoint1", i)*recordList.getFloat("njuweight1", i)));            		  	
            			recordList.addString("read1", "style='width:30px;background:yellow'");
					} else {
						recordList.addString("read1", "readonly style='width:30px;border-color:black;border-width:1px'");
					}
					
					if(recordTemp.getString("ptype2",i).equals("1") || recordTemp.getInt("ngakpoint2", i) > 0 || recordTemp.getInt("njupoint2", i) > 0 || recordList.getFloat("ngakweight2", i) > 0 || recordList.getFloat("njuweight2", i) > 0){
						recordList.addString("calNgak2", new DecimalFormat("######.##").format(recordTemp.getInt("ngakpoint2", i)*recordList.getFloat("ngakweight2", i)));
						recordList.addString("calNju2", new DecimalFormat("######.##").format(recordTemp.getInt("njupoint2", i)*recordList.getFloat("njuweight2", i)));            		  	
            			recordList.addString("read2", "style='width:30px;background:yellow'");
					} else {
						recordList.addString("read2", "readonly style='width:30px;border-color:black;border-width:1px'");
					}
					
					if(recordTemp.getString("ptype3",i).equals("1") || recordTemp.getInt("ngakpoint3", i) > 0 || recordTemp.getInt("njupoint3", i) > 0 || recordList.getFloat("ngakweight3", i) > 0 || recordList.getFloat("njuweight3", i) > 0){
						recordList.addString("calNgak3", new DecimalFormat("######.##").format(recordTemp.getInt("ngakpoint3", i)*recordList.getFloat("ngakweight3", i)));
						recordList.addString("calNju3", new DecimalFormat("######.##").format(recordTemp.getInt("njupoint3", i)*recordList.getFloat("njuweight3", i)));            		  	
            			recordList.addString("read3","style='width:30px;background:yellow'");
					} else {
						recordList.addString("read3", "readonly style='width:30px;border-color:black;border-width:1px'");
					}
					
					if(recordTemp.getString("ptype4",i).equals("1") || recordTemp.getInt("ngakpoint4", i) > 0 || recordTemp.getInt("njupoint4", i) > 0 || recordList.getFloat("ngakweight4", i) > 0 || recordList.getFloat("njuweight4", i) > 0){
						recordList.addString("calNgak4", new DecimalFormat("######.##").format(recordTemp.getInt("ngakpoint4", i)*recordList.getFloat("ngakweight4", i)));
						recordList.addString("calNju4", new DecimalFormat("######.##").format(recordTemp.getInt("njupoint4", i)*recordList.getFloat("njuweight4", i)));            		  	
            			recordList.addString("read4","style='width:30px;background:yellow'");
					} else {
						recordList.addString("read4", "readonly style='width:30px;border-color:black;border-width:1px'");
					}
					
					if(recordTemp.getString("ptype5",i).equals("1") || recordTemp.getInt("ngakpoint5", i) > 0 || recordTemp.getInt("njupoint5", i) > 0 || recordList.getFloat("ngakweight5", i) > 0 || recordList.getFloat("njuweight5", i) > 0){
						recordList.addString("calNgak5", new DecimalFormat("######.##").format(recordTemp.getInt("ngakpoint5", i)*recordList.getFloat("ngakweight5", i)));
						recordList.addString("calNju5", new DecimalFormat("######.##").format(recordTemp.getInt("njupoint5", i)*recordList.getFloat("njuweight5", i)));            		  	
            			recordList.addString("read5", "style='width:30px;background:yellow'");
					} else {
						recordList.addString("read5", "readonly style='width:30px;border-color:black;border-width:1px'");	
					}
					
					bf_ref_subj = recordTemp.getString("refSubj", i);
            	}//end for
            }//end if
            
            //특수과목 리스트            
            srecordList = evalItemService.selectEvalItemSrecordList(requestMap);
            int ssubjcnt = srecordList.keySize("subj");
            requestMap.setInt("ssubjcnt", ssubjcnt);
            
            //과제물 리스트
            DataMap reportpointMap = evalItemService.selectEvalItemReportpoint(requestMap);
            if (!reportpointMap.isEmpty()) {
            	reprecord.addString("reportpoint", reportpointMap.getString("reportpoint"));
            	reprecord.addString("reportYn", "Y");
            } else {
            	reprecord.addString("reportpoint", "0");
            	reprecord.addString("reportYn", "N");
            }
            
            //과제물 출제 횟수
            DataMap cntMap = evalItemService.selectEvalItemReportCnt(requestMap);
            int minSprpcnt = 0;
            if (!cntMap.isEmpty()) {
            	reprecord.addString("minSprpcnt", cntMap.getString("cnt"));
            	minSprpcnt=Integer.parseInt(cntMap.getString("cnt"));
            } else {
            	reprecord.addString("minSprpcnt","0");            
            }
            
            StringBuffer spreportCntopt = new StringBuffer();
            for(int i=minSprpcnt; i <= 5; i++) {
            	if (reportCnt == i) {
            		spreportCntopt.append("<option value='").append(String.valueOf(i)).append("' selected>").append(String.valueOf(i)).append("회</option>");
            	} else {
            		spreportCntopt.append("<option value='").append(String.valueOf(i)).append("'>").append(String.valueOf(i)).append("회</option>");
            	}
            }            
            reprecord.addString("spreportCntopt", spreportCntopt.toString());
            
            //과제물 리스트
            gradeInfo = evalItemService.selectEvalItemGradeInfo(requestMap);
            gradeInfo.setNullToInitialize(true);
            classinfo = evalItemService.selectEvalItemClassInfo(requestMap);
            classinfo.setNullToInitialize(true);
            
            String dates="";
            String classno="";
            String bf_dates="";
            Boolean flag=false;
            for(int i=1; i<=reportCnt; i++) {
            	for(int j=0; j<classinfo.keySize("classno"); j++) {
            		flag = false;
            		dates = String.format("%02d", i);
            		classno = classinfo.getString("classno",j);
            		reportList.addString("dates", dates);
            		reportList.addString("classno", classno);
            		reportList.addString("classnm", classinfo.getString("classnm", j));
            		
            		for(int k=0;k<gradeInfo.keySize("dates");k++) {
            			if (gradeInfo.getString("dates",k).equals(dates) && gradeInfo.getString("classno",k).equals(classno)) {
            				flag = true;
            				reportList.addString("apoint", gradeInfo.getString("apoint", k));
            				reportList.addString("grdCnt", gradeInfo.getString("grdCnt", k));
            			}            			
            		}
            		
            		if (flag==false) {
            			reportList.addString("apoint","");
            			reportList.addString("grdCnt","");
            		}
            		
            		if (bf_dates.equals(gradeInfo.getString("dates",i))) {
            			reportList.addString("rowspan","0");	       				
    	       		}else{
    	       			reportList.addString("rowspan", String.valueOf(classinfo.keySize("classno")));
    	       		}
            		
            		bf_dates=gradeInfo.getString("dates",i);            		
            	}
            }  
		}//end if
		
		model.addAttribute("evalItemEvalCnt", evalItemEvalCnt);
		model.addAttribute("recordList", recordList);
		model.addAttribute("srecordList", srecordList);
		model.addAttribute("reprecord", reprecord);
		model.addAttribute("gradeInfo", gradeInfo);
		model.addAttribute("reportCnt", reportCnt);
		model.addAttribute("reportList", reportList);
		
		requestMap.setInt("nevalCnt", nevalCnt);	
		requestMap.setInt("subjcnt", count);
		
		return "/evalMgr/evalItem/evalItemList";
	}
	
	/**
	 * 평가항목관리 점수 저장
	 */
	@RequestMapping(value="/evalMgr/evalItem.do", params = "mode=edit")
	public String edit(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		HttpServletRequest request = cm.getRequest();
		int result = 0;
		String msg = "";
		String resultType = "";
		
		StringBuffer sbTmp = null;
		
		String commGrcode = requestMap.getString("commGrcode");
		String commGrseq = requestMap.getString("commGrseq");
		//상시 횟수
		int nevalCnt = Integer.parseInt(requestMap.getString("nevalCnt"));
		
		if (Integer.parseInt(requestMap.getString("p_sumtotal")) > 100) {
			msg = "총점은 100점 만점이어야 합니다.";
			resultType = "saveError";			
		} else {			
			//과정 이수여부
			DataMap seqClosing = evalItemService.selectEvalItemClosing(requestMap);
			seqClosing.setNullToInitialize(true);
			//과정 이수여부
			DataMap subjSeqClosing = evalItemService.selectEvalItemSubjClosing(requestMap);
			subjSeqClosing.setNullToInitialize(true);
			
			if (seqClosing.getString("closing").equals("Y")) {
				msg = "이수된 과정기수는 배점변경이 불가능합니다.";
				resultType = "saveError";
			} else if (subjSeqClosing.getString("closing").equals("Y")) {
				msg = "이수된 과정기수는 배점변경이 불가능합니다.";
				resultType = "saveError";
			} else {//조건에 걸리는 것이 없을경우
				//과목명리스트				
				String[] pSubj = request.getParameterValues("p_subj[]");
				
				if(pSubj != null){
					int subjLength = pSubj.length;
				
					//특수과목명리스트
					String[] pSubj2 = request.getParameterValues("p_subj2[]");
					String[] totpoint2 = request.getParameterValues("p_totpoint2[]");
					//과제물과목 평가배점
					String spReportpoint = request.getParameter("sp_reportpoint");
					//리포트 출제회수
					String spreportCnt = request.getParameter("spreport_cnt");
					//점수
					String[] mgakpoint = request.getParameterValues("p_mgakpoint[]");
					String[] mgakweight = request.getParameterValues("p_mgakweight[]");
					String[] mjupoint = request.getParameterValues("p_mjupoint[]");
					String[] mjuweight = request.getParameterValues("p_mjuweight[]");
					String[] lgakpoint = request.getParameterValues("p_lgakpoint[]");
					String[] lgakweight = request.getParameterValues("p_lgakweight[]");	
					String[] ljupoint = request.getParameterValues("p_ljupoint[]");
					String[] ljuweight = request.getParameterValues("p_ljuweight[]");		
					String[] reportpoint = request.getParameterValues("p_reportpoint[]");
					String[] steppoint = request.getParameterValues("p_steppoint[]");
					//String[] quizpoint = request.getParameterValues("p_quizpoint[]");
					String[] totpoint = request.getParameterValues("p_totpoint[]");
					String[] grastep = request.getParameterValues("p_grastep[]");
					//String[] graquiz = request.getParameterValues("p_graquiz[]");
					String[][] ngakpoint = new String[5][subjLength];
					String[][] ngakweight = new String[5][subjLength];
					String[][] njupoint = new String[5][subjLength];
					String[][] njuweight = new String[5][subjLength];
	
					//상시 횟수 만큼 등록
					for(int i=1; i<=nevalCnt; i++){
						sbTmp = new StringBuffer();
						sbTmp.append("p_ngakpoint").append(String.valueOf(i)).append("[]");
						ngakpoint[i-1] = request.getParameterValues(sbTmp.toString());
						sbTmp = new StringBuffer();
						sbTmp.append("p_ngakweight").append(String.valueOf(i)).append("[]");
						ngakweight[i-1] = request.getParameterValues(sbTmp.toString());
						sbTmp = new StringBuffer();
						sbTmp.append("p_njupoint").append(String.valueOf(i)).append("[]");
						njupoint[i-1] = request.getParameterValues(sbTmp.toString());
						sbTmp = new StringBuffer();
						sbTmp.append("p_njuweight").append(String.valueOf(i)).append("[]");
						njuweight[i-1] = request.getParameterValues(sbTmp.toString());
					}
					
					// 비어 있는 상시 부분을 초기화 시켜준다
					for(int m=nevalCnt+1 ;m<=5; m++){
						for(int n=0; n<subjLength; n++){
							ngakpoint[m-1][n] = "0";
							ngakweight[m-1][n] = "0";
							njupoint[m-1][n] = "0";
							njuweight[m-1][n] = "0";
						}			
					}
					
					DataMap parameter = new DataMap();
					String si = "";				
					for(int i=0;i<pSubj.length;i++) {
						si=String.valueOf(i);
						//점수
						parameter.addString(si, mgakpoint[i]);
						parameter.addString(si, mjupoint[i]);
						parameter.addString(si, lgakpoint[i]);
						parameter.addString(si, ljupoint[i]);
						//배점
						parameter.addString(si, mgakweight[i]);
						parameter.addString(si, mjuweight[i]);
						parameter.addString(si, lgakweight[i]);	
						parameter.addString(si, ljuweight[i]);
						parameter.addString(si, reportpoint[i]);
						parameter.addString(si, steppoint[i]);
						parameter.addString(si, totpoint[i]);
						//parameter.addString(si, quizpoint[i]);					
						parameter.addString(si, grastep[i]);
						//parameter.addString(si, graquiz[i]);
						//상시
						for(int j=0;j<5;j++) {
							parameter.addString(si, ngakpoint[j][i]);
							parameter.addString(si, njupoint[j][i]);
							parameter.addString(si, ngakweight[j][i]);
							parameter.addString(si, njuweight[j][i]);		
						}
						//조건절 정보
						parameter.addString(si, commGrcode);
						parameter.addString(si, commGrseq);
						parameter.addString(si, pSubj[i]);										
					}
					
					//점수 저장
					//System.out.println("@@@@@@@@@@@@@@@@@");
					//System.out.println(parameter);
					//System.out.println("@@@@@@@@@@@@@@@@@");
					result = evalItemService.updateEvalItemSubjList(parameter, subjLength, pSubj2, totpoint2, commGrcode, commGrseq, spReportpoint, spreportCnt);
					//System.out.println(result);
					
					if (result > 0) {			
						msg = "저장 되었습니다.";						
						resultType = "ok";
					} else {			
						msg = "저장시 오류가 발생했습니다.";
						resultType = "saveError";			
					}
				} else {
					//특수과목명리스트
					String[] pSubj2 = request.getParameterValues("p_subj2[]");
					String[] totpoint2 = request.getParameterValues("p_totpoint2[]");
					//과제물과목 평가배점
					String spReportpoint = request.getParameter("sp_reportpoint");
					//리포트 출제회수
					String spreportCnt = request.getParameter("spreport_cnt");
					//점수 저장
					result = evalItemService.updateEvalItemSubjListSubj2(pSubj2, totpoint2, commGrcode, commGrseq, spReportpoint, spreportCnt);
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
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/evalMgr/evalItem/evalItemExec";
	}			
	
	/**
	 * 과제물 출제 횟수변경
	 */
	@RequestMapping(value="/evalMgr/evalItem.do", params = "mode=repcntEdit")
	public String repcntEdit(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		int result = 0;
		String msg = "";
		String resultType = "";
		
		result = evalItemService.updateEvalItemReportCnt(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), requestMap.getString("spreport_cnt"));
		if (result > 0) {			
			msg = "과제물 출제회수가 변경되었습니다.";						
			resultType = "ok";
		} else {			
			msg = "과제물 출제회수 변경시 오류가 발생하였습니다.";
			resultType = "saveError";			
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/evalMgr/evalItem/evalItemExec";
	}
	
	/**
	 * 평가배점변경 
	 */
	@RequestMapping(value="/evalMgr/evalItem.do", params = "mode=batchExpoint")
	public String batchExpoint(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String grcodenm = "";
		String mevalYn = "N";
		String levalYn = "N";
		String nevalCnt = "0";
		String closing = "";
		String confButton = "";
		DataMap exam = new DataMap();
		
		StringBuffer sbTmp = null;
		
		//과정명 가져옴
		DataMap grcodeNmMap = evalMasterService.selectEvalMasterEvlGrcodeNm(requestMap.getString("commGrcode"));
		grcodeNmMap.setNullToInitialize(true);
		if (!grcodeNmMap.isEmpty()) {
			grcodenm = grcodeNmMap.getString("grcodenm");
		}		
		
		//평가 출제유무,상시평가횟수
		DataMap temp = evalItemService.selectEvalItemEvalCnt(requestMap);
		temp.setNullToInitialize(true);
		if (!temp.isEmpty()) {
			mevalYn = temp.getString("mevalYn");
			levalYn = temp.getString("levalYn");
			nevalCnt = temp.getString("nevalCnt");
		}
		
		//과정 개설 여부
		DataMap closingMap = evalItemService.selectEvalItemClosing(requestMap);
		closingMap.setNullToInitialize(true);
		if (!closingMap.isEmpty()) {
			closing = closingMap.getString("closing");
		}

		int exCnt = 0;
		if (!mevalYn.equals("") && mevalYn.equals("Y")) {
			exam.addString("exType", "mgakpoint");
			exam.addString("exName", "중간평가(객관식)배점");
			exam.addString("exType","mjupoint");
			exam.addString("exName","중간평가(주관식)배점");
			exCnt = exCnt +2;
		}
		
		if (!levalYn.equals("") && levalYn.equals("Y")) {
			exam.addString("exType","lgakpoint");
			exam.addString("exName","최종평가(객관식)배점");
			exam.addString("exType","ljupoint");
			exam.addString("exName","최종평가(주관식)배점");
			exCnt = exCnt +2;
		}
		
		String si = "";
		for (int i=1; i<=Integer.parseInt(nevalCnt); i++) {
			si = String.valueOf(i);
			sbTmp = new StringBuffer();
			sbTmp.append("ngakpoint").append(si);
			exam.addString("exType", sbTmp.toString());
			sbTmp = new StringBuffer();
			sbTmp.append("상시").append(si).append("회(객관식)배점");
			exam.addString("exName", sbTmp.toString());
			exam.addString("exType", "njupoint");
			sbTmp = new StringBuffer();
			sbTmp.append("상시").append(si).append("회(주관식)배점");
			exam.addString("exName", sbTmp.toString());
			exCnt = exCnt +2;
		}
		
		if (!closing.equals("") && closing.equals("Y")) {
			confButton = "";
		} else {
			confButton = "<input type=button class='boardbtn1'  value='확인' onClick=\"javascript:go_action('batch');\">";
		}
		exam.addString("grcodenm", grcodenm);
		exam.addInt("exCnt", exCnt);
		exam.addString("confButton", confButton);		
		
		model.addAttribute("exam", exam);
		
		return "/evalMgr/evalItem/evalPointPop";
	}
	
	/**
	 * 교육훈련평가 AI 리포트
	 */
	@RequestMapping(value="/evalMgr/evalItem.do", params = "mode=eduTrain")
	public String eduTrain(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String r_mexampropose = "";	// 중간평가 일정
		String r_lexampropose = "";	// 최종평가 일정
		String r_closing = "";
		String r_gun_evalment = "";	// 근태 평가멘트
		String r_step_evalment = "";	// 진도율 평가멘트
		String r_quiz_evalment = "";
		
		int sum_exam_point = 0;
		int sum_reportpoint = 0;
		int sum_steppoint = 0;
		int sum_quizpoint = 0;
		
		String sum_mexam_point = "";
		String sum_lexam_point = "";
		//String sum_nexam_point1 = "";
		//String sum_nexam_point2 = "";
		//String sum_nexam_point3 = "";
		//String sum_nexam_point4 = "";
		//String sum_nexam_point5 = "";
		
		int r_gunpoint = 0;
		int count = 0;
		String tpl_mode = requestMap.getString("tpl_mode");
		
		//과정기수별 중간-기말평가 배점정보
		DataMap pointInfo = evalItemService.selectEvalItemPointInfo(requestMap);
		pointInfo.setNullToInitialize(true);
		if (!pointInfo.isEmpty()) {
			r_mexampropose = pointInfo.getString("mexampropose");
			r_lexampropose = pointInfo.getString("lexampropose");
			r_closing = pointInfo.getString("closing");
			r_gun_evalment = pointInfo.getString("gunEvalment");
			r_step_evalment = pointInfo.getString("stepEvalment");
			r_quiz_evalment = pointInfo.getString("grcodenquizEvalmentiknm");
		}
		
		//과제물과목 or 일반과목(온라인, 오프라인) 강의별 평가 배점정보
		DataMap subjPointInfo = evalItemService.selectEvalItemSubjPointInfo(requestMap);
		subjPointInfo.setNullToInitialize(true);
		if (!subjPointInfo.isEmpty()) {
			sum_exam_point = subjPointInfo.getInt("examPoint");
			sum_reportpoint = subjPointInfo.getInt("reportpoint");
			sum_steppoint = subjPointInfo.getInt("steppoint");
			sum_quizpoint = subjPointInfo.getInt("quizpoint");
			sum_mexam_point = subjPointInfo.getString("mexamPoint");
			sum_lexam_point = subjPointInfo.getString("lexamPoint");
			//sum_nexam_point1 = subjPointInfo.getString("nexamPoint1");
			//sum_nexam_point2 = subjPointInfo.getString("nexamPoint2");
			//sum_nexam_point3 = subjPointInfo.getString("nexamPoint3");
			//sum_nexam_point4 = subjPointInfo.getString("nexamPoint4");
			//sum_nexam_point5 = subjPointInfo.getString("nexamPoint5");
		}
		
		//근태과목 평가정보
		DataMap guntaePoint = evalItemService.selectEvalItemGunTaePoint(requestMap);
		guntaePoint.setNullToInitialize(true);
		if (!guntaePoint.isEmpty()) {
			r_gunpoint = guntaePoint.getInt("gunpoint");
		}
		//중간필답평가 정보
		DataMap mPoint = evalItemService.selectEvalItemMpoint(requestMap);
		mPoint.setNullToInitialize(true);
		
		StringBuffer m_point_ment = new StringBuffer();	
		if (!mPoint.isEmpty()) {
			for(int i=0; i<mPoint.keySize("subj"); i++) {
				if (i == 0) {
					m_point_ment.append("<b>□ 중간평가 (").append(sum_mexam_point).append("점)</b> : ").append(r_mexampropose).append("<br>");
				}
				m_point_ment.append("&nbsp;&nbsp;&nbsp;○").append(mPoint.getString("lecnm", i)).append("&nbsp;(").append(mPoint.getString("mPoint", i)).append("점)<br>");
			}						
		}
		
		//최종필답평가 정보
		DataMap lPoint = evalItemService.selectEvalItemLpoint(requestMap);
		lPoint.setNullToInitialize(true);
		StringBuffer l_point_ment = new StringBuffer();
		if (!lPoint.isEmpty()) {
			for(int i=0; i<lPoint.keySize("subj"); i++) {
				if (i == 0) {
					l_point_ment.append("<b>□ 종합평가 (").append(sum_lexam_point).append("점)</b> : ").append(r_lexampropose).append("<br>");
				}
				l_point_ment.append("&nbsp;&nbsp;&nbsp;○").append(lPoint.getString("lecnm", i)).append("&nbsp;(").append(lPoint.getString("lPoint", i)).append("점)<br>");
			}						
		}
		
		//분임평가 (과제물과 근태)를 제외한 특수과목
		DataMap sSubjPoint = evalItemService.selectEvalItemSsubjPoint(requestMap);
		sSubjPoint.setNullToInitialize(true);
		StringBuffer grp_point_ment = new StringBuffer();
		int sum_grp_point = 0;
		if (!sSubjPoint.isEmpty()) {
			for(int i=0; i<sSubjPoint.keySize("subj"); i++) {				
				grp_point_ment.append("<b>□ ").append(sSubjPoint.getString("lecnm", i)).append(" (").append(sSubjPoint.getString("grpPoint", i)).append("점)</b> : ").append(sSubjPoint.getString("examtime", i)).append("</font><br>");
				sum_grp_point += Integer.parseInt(sSubjPoint.getString("grpPoint", i));
			}						
		}
		
		DataMap reportPointMap = evalItemService.selectEvalItemReportPoint(requestMap);
		reportPointMap.setNullToInitialize(true);
		StringBuffer rep_point_ment = new StringBuffer();
		if (sum_reportpoint > 0) {
			if (!reportPointMap.isEmpty()) {
				for(int i=0; i<reportPointMap.keySize("title"); i++) {					
					rep_point_ment.append("<br><b>□ 과제명</b><br>");
					rep_point_ment.append("&nbsp;-").append(reportPointMap.getString("title", i)).append("</b><br>");
					rep_point_ment.append("&nbsp;제출기간 : ").append(reportPointMap.getString("submstDate", i)).append("(").append(reportPointMap.getString("stDay", i)).append(") ~ ").append(reportPointMap.getString("submedDate",i)+"("+reportPointMap.getString("edDay",i)+")"+reportPointMap.getString("submedHhmi", i)).append("까지<br>");
					rep_point_ment.append(reportPointMap.getString("content", i));
				}
			}
		}
		
		String gun_point_ment = "<b>□ 교육원 학생수칙규정에 의하여 평가</b>";
		
		if (!r_gun_evalment.equals("")) {
			gun_point_ment = r_gun_evalment;
		}
		
		//근태과목이 아닌 과목중 진도율점수가 0 을 초과하는 경우
		DataMap stepPoint = evalItemService.selectEvalItemStepPoint(requestMap);
		stepPoint.setNullToInitialize(true);
		StringBuffer step_point_ment = new StringBuffer();
		count = 0;
		for(int i=0; i<stepPoint.keySize("lecnm"); i++) {			
			if (count == 0) {
				step_point_ment.append("□ 사이버교육 교과목(");
				step_point_ment.append(stepPoint.getString("lecnm", i));
			} else {
				step_point_ment.append(",").append(stepPoint.getString("lecnm", i));	
			}			
			count++;
		}
		
		if (stepPoint.keySize("lecnm") > 0) {
			step_point_ment.append(") 진도율<br>");
			step_point_ment.append("&nbsp;&nbsp;&nbsp;○ 진도율 : 80%이상 과목당 1점씩(총").append(sum_steppoint).append("점), ").append(stepPoint.keySize("lecnm")).append("과목 80%미만(0점)");
		}
		
		if (!r_step_evalment.equals("")) {
			step_point_ment = new StringBuffer();
			step_point_ment.append(r_step_evalment);
		}
		
		//차시평가 점수가 0 을 초과하는 경우
		DataMap quizPoint = evalItemService.selectEvalItemQuizPoint(requestMap);
		quizPoint.setNullToInitialize(true);
		StringBuffer quiz_point_ment = new StringBuffer();
		count = 0;
		for(int i=0; i<quizPoint.keySize("lecnm"); i++) {			
			if (count == 0) {
				quiz_point_ment.append("□ 사이버교육 교과목(");
				quiz_point_ment.append(quizPoint.getString("lecnm", i));
			} else {
				quiz_point_ment.append(",").append(quizPoint.getString("lecnm", i));	
			}		
			count++;
		}
		
		if (quizPoint.keySize("lecnm") > 0) {
			quiz_point_ment.append(") 정답률<br>");
			quiz_point_ment.append("&nbsp;&nbsp;&nbsp;○ 정답률 : 80%이상 과목당 1점씩(총").append(sum_steppoint).append("점), ").append(quizPoint.keySize("lecnm")).append("과목 80%미만(0점)");
		}
		
		if (!r_quiz_evalment.equals("")) {
			quiz_point_ment = new StringBuffer();
			quiz_point_ment.append(r_quiz_evalment);
		}
		
		String conf_button = "";
		if (r_closing.equals("N") || r_closing.equals("")) {
			if (tpl_mode.equals("edit")) {
				conf_button ="<input type=button value='저장' class='boardbtn1' onclick=\"go_action('eduTrainEdit');\">";
			} else {
				conf_button ="<input type=button value='수정하기' class='boardbtn1' onclick=\"go_editform();\">";
			}
		} else {
			conf_button ="이수처리되어 수정할 수 없습니다.";
		}

		if (tpl_mode.equals("edit")) {
			conf_button ="<input type=button value='저장' class='boardbtn1' onclick=\"go_action('eduTrainEdit');\">";
		} else {
			conf_button ="<input type=button value='수정하기' class='boardbtn1' onclick=\"go_editform();\">";
		}
		
		int tot_sumpoint = sum_exam_point + sum_reportpoint + sum_steppoint + sum_quizpoint + r_gunpoint + sum_grp_point;
		
		String popjs_tag = "";
		String tm_ment = "";
		if (!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("") && !tpl_mode.equals("edit")) {
			popjs_tag ="window.setTimeout(\"report_dis1()\", 500)";
		} else {
			tm_ment = "<center><br>과정명, 기수명을 선택하세요.<br></center>";
		}	

		requestMap.setString("tpl_mode", tpl_mode);
		requestMap.setString("conf_button", conf_button);
		requestMap.setString("m_point_ment", m_point_ment.toString());
		requestMap.setString("l_point_ment", l_point_ment.toString());
		
		requestMap.setInt("sum_exam_point", sum_exam_point);
		requestMap.setInt("sum_reportpoint", sum_reportpoint);
		requestMap.setInt("sum_steppoint", sum_steppoint);
		requestMap.setInt("sum_quizpoint", sum_quizpoint);
		requestMap.setInt("gunpoint", r_gunpoint);
		
		requestMap.setInt("sum_grp_point", sum_grp_point);
		requestMap.setString("grp_point_ment", grp_point_ment.toString());
		requestMap.setString("gun_point_ment", gun_point_ment);
		requestMap.setString("step_point_ment", step_point_ment.toString());
		requestMap.setString("quiz_point_ment", quiz_point_ment.toString());
		requestMap.setString("rep_point_ment", rep_point_ment.toString());
		requestMap.setInt("tot_sumpoint", tot_sumpoint);
		requestMap.setString("tm_ment", tm_ment);
		requestMap.setString("popjs_tag", popjs_tag);
		
		return "/evalMgr/evalItem/eduTrain";
	}			
	
	/**
	 * 교육훈련 평가 항목 수정수정
	 */
	@RequestMapping(value="/evalMgr/evalItem.do", params = "mode=eduTrainEdit")
	public String eduTrainEdit(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		int result=0;
		String msg="";
		String resultType="";
		
		if (!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")) {
			result = evalItemService.updateEvalItemEduTrain(requestMap);
			if (result > 0) {
				msg = "저장되었습니다";
				resultType = "ok";
			} else {
				msg = "저장시 오류가 발생하였습니다";
				resultType = "saveError";
			}
		} else {
			msg = "과정,기수가 올바르지 않습니다";
			resultType = "saveError";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/evalMgr/evalItem/evalItemExec";
	}
}
