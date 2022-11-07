package loti.evalMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.evalMgr.service.ScoreService;

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
import ut.lib.util.Util;
import common.controller.BaseController;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

@Controller
public class ScoreController extends BaseController {

	@Autowired
	private ScoreService scoreService;
	
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
			if (mode.equals("")) {
				mode = "list";
				requestMap.setString("mode", mode);
			}
			if (requestMap.getString("qu").equals("")) {
				requestMap.setString("qu","list");
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
			if (requestMap.getString("sessClass").equals("")) {
				requestMap.setString("sessClass", (String)session.getAttribute("sess_class"));
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
	//person,class,langClass일 경우의 점수입력
	@RequestMapping(value="/evalMgr/score.do", params = "mode=person")
	public String person(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		update(cm, model);
		return "/evalMgr/score/scoreExec";
	}
	@RequestMapping(value="/evalMgr/score.do", params = "mode=langClass")
	public String langClass(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		update(cm, model);
		return "/evalMgr/score/scoreExec";
	}
	@RequestMapping(value="/evalMgr/score.do", params = "mode=class")
	public String clazz(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		update(cm, model);
		return "/evalMgr/score/scoreExec";
	}
	
	/**
	 * 평가점수 입력 메뉴별 리스트를 뽑아오는 함수
	 */
	@RequestMapping(value="/evalMgr/score.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		//LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//service Instance
		String commSubj = requestMap.getString("commSubj");
		String a_eval_method = requestMap.getString("a_eval_method");
		
		String optionStr="";//과목 select Box리스트
		String infoStr = "";// 과목 설명정보 포함
		String lang_option = "";// 어학점수평가 select Box option
		int stu_cnt = 0; //학생수
		String conf_button = "";//저장 버튼
		StringBuffer sbTmp = null;
		DataMap personList = new DataMap();//개인별평가 학생 리스트

		if (!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")) {
			DataMap optionList = scoreService.selectScoreOption(requestMap);// 특수과목이고 과제물과목이 아닌리스트
			sbTmp = new StringBuffer();
			for(int i=0;i<optionList.keySize("subj");i++) {				
				if (requestMap.getString("commSubj").equals(optionList.getString("subj",i))) {
					sbTmp.append("<option value='").append(optionList.getString("subj", i)).append("' selected>").append(optionList.getString("lecnm",i)).append("</option>");
				} else {
					sbTmp.append("<option value='").append(optionList.getString("subj", i)).append("' >").append(optionList.getString("lecnm",i)).append("</option>");
				}
			}
			optionStr = sbTmp.toString();
			//특수과목이 아닌데 값이 잘못 넘어 왔으 경우 과목값을 널로 만들어 잘못된 리스트를 뽑아오지 못하도록 한다
			DataMap subjMap = scoreService.selectScoreSubj(requestMap);
			if(subjMap.isEmpty()){
				requestMap.setString("commSubj", "");
				commSubj="";
			}
		}
		
		//모든 select box가 올바르게 선택되었을경우
		if (!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("") && !requestMap.getString("commSubj").equals("")) {
			//과목에 대한 정보를 뽑아서 infoStr에 넣어 화면에 뿌려준다
			DataMap infoMap = scoreService.selectScoreInfo(requestMap);
			sbTmp = new StringBuffer();
			if (!infoMap.getString("grcodeniknm").equals("")) {
				sbTmp.append(infoMap.getString("grcodeniknm")).append(requestMap.getString("commGrseq").substring(0, 4)).append("년 ").append(requestMap.getString("commGrseq").substring(5, 6)).append("기&nbsp;").append(infoMap.getString("lecnm"));
			} else {
				sbTmp.append("");
			}
			infoStr = sbTmp.toString();
			//어학점수 평가 옵션 리스트 작성
			DataMap langClass = scoreService.selectLangClass(commSubj);
			if (langClass.getString("subjtype").equals("S") && langClass.getString("language").equals("Y")) {
				if (a_eval_method == "langclass") {
					lang_option = "<option value='langClass' selected>어학점수평가</option>";
				} else {
					lang_option = "<option value='langClass' >어학점수평가</option>";
				}
			}
			//클래스 갯수 카운팅을 하여 기본으로 뿌려줄 a_eval_method값을 넣어준다
			DataMap classCnt = scoreService.selectClassCnt(requestMap);		
			if (classCnt.keySize("classCnt") > 1 && a_eval_method.equals("")) {
				a_eval_method = "class";
			} else if (a_eval_method.equals("")) {
				a_eval_method = "person";			
			}
			requestMap.setString("a_eval_method",a_eval_method);
			
			//Bf_Pcnt
			DataMap bf_pcntMap = scoreService.selectBf_Pcnt(requestMap);
			int bf_pcnt = bf_pcntMap.keySize("bf_pcnt");
			
			if (a_eval_method.equals("person")) {//개인별 조회
				DataMap listMap = scoreService.selectPersonList(requestMap);
				//personList=new DataMap();
				String bf_classno = "0";
				String cur_classno = "";
				//String cur_classnm = "";
				int class_cnt = 0;
				for(int i=0; i<listMap.keySize("classno");i++) {
					stu_cnt++;
					cur_classno = listMap.getString("classno",i);
					//cur_classnm = listMap.getString("classnm",i);
					
					personList.addInt("stu_cnt", stu_cnt);
					personList.addString("classno", cur_classno);
					personList.addString("eduno", listMap.getString("eduno",i));
					personList.addString("userno", listMap.getString("userno",i));
					if (listMap.getString("resno",i) == null) {
						personList.addString("resno", "-XXXXXXX");
					} else {
						personList.addString("resno",listMap.getString("resno",i).substring(0, 6)+"-XXXXXXX");
					}					
					personList.addString("name", listMap.getString("name",i));
					personList.addString("deptnm", listMap.getString("deptnm",i));
					personList.addString("jiknm", listMap.getString("jiknm",i));
					personList.addString("cur_avlcount", listMap.getString("avlcount",i));
					if (bf_pcnt == 0) {						
						if (listMap.getString("avlcount",i).equals("") || listMap.getString("avlcount",i).equals("0")) {							
							personList.addString("avlcount", infoMap.getString("totpoint"));
						} else {							
							personList.addString("avlcount", listMap.getString("avlcount",i));
						}
					}					
					if (!bf_classno.equals(cur_classno)) {
						class_cnt++;
					}	
					bf_classno = cur_classno;
				}				
				requestMap.setInt("class_cnt",class_cnt);
				requestMap.setString("spsubj_totpoint", infoMap.getString("totpoint"));
				//request.setAttribute("personList",personList);
			} else if (a_eval_method.equals("langClass")) {//어학과목 클래스별 조회
				StringBuffer langbodyList = new StringBuffer();
				DataMap listMap = scoreService.selectLangClassCount(requestMap);
				Map<String, Object> paramMap = null;
				if (!listMap.isEmpty()) {
					for(int i=0;i<listMap.keySize("classno");i++) {
						paramMap = new HashMap<String, Object>();
						paramMap.put("classno", listMap.getString("classno",i));
						paramMap.put("commGrcode", requestMap.getString("commGrcode"));
						paramMap.put("commGrseq", requestMap.getString("commGrseq"));
						paramMap.put("commSubj", requestMap.getString("commSubj"));
						DataMap langClassList = scoreService.selectLangClassList(paramMap);
						if(!langClassList.isEmpty()){
							langbodyList.append("<tr  bgcolor='ffffff'><td height='10' colspan='8'></td></tr><tr bgcolor='ffffff'>"); 
							langbodyList.append("<td colspan='8'>");
							langbodyList.append("<input type='hidden' NAME='h_classno[]' VALUE='").append(listMap.getString("classno",i)).append("'>");
							langbodyList.append("<input type='hidden' name='lang_classno[]' size='5' value='").append(listMap.getString("classno",i)).append("'>");
							langbodyList.append(listMap.getString("classnm",i)).append(" 어학만점 점수: <input type='text' name='lang_spoint[]' size='5' value='");
							if (listMap.getString("langSpoint",i).equals("")) {
								langbodyList.append("0");
							} else {
								langbodyList.append(listMap.getString("langSpoint",i));
							}
							langbodyList.append("'>");							
							if (listMap.getString("classno",i).equals("1")) {
								langbodyList.append("<input type=button class='boardbtn1' value='환산점수계산' onClick='point_change();'>");
							}
							langbodyList.append("</td>");
							langbodyList.append("</tr>");
							for(int j=0;j<langClassList.keySize("classno");j++) {
								stu_cnt++;							
								langbodyList.append("<tr>");
								langbodyList.append("<tr bgcolor='#FFFFFF'>");
								langbodyList.append("<td class='tableline11'><div align='center'>").append(stu_cnt).append("</div></td>");
								langbodyList.append("<td class='tableline11'><div align='center'>").append(langClassList.getString("eduno",j)).append("</div></td>");
								langbodyList.append("<td class='tableline11'><div align='center'>").append(langClassList.getString("name",j)).append("</div></td>");
								if (langClassList.getString("resno",j) == null) {
									langbodyList.append("<td class='tableline11'><div align='center'>-XXXXXXX</div></td>");									
								} else {
									langbodyList.append("<td class='tableline11'><div align='center'>").append(langClassList.getString("resno",j).substring(0, 6)).append("-XXXXXXX"+"</div></td>");
								}								
								langbodyList.append("<td class='tableline11'><div align='center'>").append(langClassList.getString("deptnm",j)).append("</div></td>");
								langbodyList.append("<td class='tableline11'><div align='center'>").append(langClassList.getString("jiknm",j)).append("</div></td>");
								langbodyList.append("<td class='tableline11'><div align='center'><input type='text' name='h_lang_point[]' value='").append(langClassList.getString("langPoint",j)).append("' size='5'></div></td>");
								langbodyList.append("<td class='tableline11'><div align='center'><input type='hidden' name='h_userno[]' value='").append(langClassList.getString("userno",j)).append("'><input type='hidden' name='h_stuclass[]' value='").append(listMap.getString("classno",i)).append("'>");
								langbodyList.append("<input type='text' name='h_point[]' value='").append(langClassList.getString("avlcount",j)).append("' size='5'></div></td>");		
								langbodyList.append("</tr>");
							}
						}
					}
				}else{
					langbodyList.append("<tr bgcolor='#FFFFFF'>");
					if (requestMap.getString("sessClass").equals("7")) {
						langbodyList.append("<td align='center' colspan='8' height='30'>지정된 과목이 없습니다</td>");
					} else {
						langbodyList.append("<td align='center' colspan='8' height='30'>검색된 내역이 없습니다</td>");
					}
					langbodyList.append("</tr>");
				}
				requestMap.setString("langClassList",langbodyList.toString());
			} else {//클래스별 조회				
				StringBuffer bodyList = new StringBuffer();			
				DataMap listMap = scoreService.selectClassCount(requestMap);
				Map<String, Object> paramMap = null;
				
				if (!listMap.isEmpty()) {
					paramMap = new HashMap<String, Object>();
					for(int i=0;i<listMap.keySize("classno");i++) {	
						paramMap.put("commGrcode", requestMap.getString("commGrcode"));
						paramMap.put("commGrseq", requestMap.getString("commGrseq"));
						paramMap.put("commSubj", requestMap.getString("commSubj"));
						paramMap.put("classno", listMap.getString("classno",i));
						DataMap classList = scoreService.selectClassList(paramMap);
						
						if (!classList.isEmpty()) {							
							//엑셀 출력이 아닐경우에만 점수입력 부분을 넣는다
							if (!requestMap.getString("excelMode").equals("ok")) {
								bodyList.append("<tr  bgcolor='ffffff'><td height='10' colspan='7'></td></tr><tr bgcolor='ffffff'>"); 
								bodyList.append("<td colspan='7'>");
								bodyList.append("<INPUT TYPE='hidden' NAME='h_classno[]' VALUE='").append(listMap.getString("classno",i)).append("'>");
								bodyList.append(listMap.getString("classnm",i)).append(" 조점수: <input type='text' name='classPoint[]' size='5' value='");
								if(classList.getString("avlcount").equals("") || classList.getString("avlcount").equals("0")){
									bodyList.append(infoMap.getString("totpoint"));
								}else{
									bodyList.append(classList.getString("avlcount"));
								}
								bodyList.append("'>");
								bodyList.append("</td>");
								bodyList.append("</tr>");
							}	
							
							for(int j=0;j<classList.keySize("classno");j++) {
								stu_cnt++;							
								bodyList.append("<tr bgcolor='#FFFFFF'>");
								bodyList.append("<td class='tableline11'><div align='center'>").append(stu_cnt).append("</div></td>");
								bodyList.append("<td class='tableline11'><div align='center'>").append(classList.getString("eduno",j)).append("</div></td>");
								bodyList.append("<td class='tableline11'><div align='center'>").append(classList.getString("name",j)).append("</div></td>");								
								if (classList.getString("resno",j) == null) {
									bodyList.append("<td class='tableline11'><div align='center'>-XXXXXXX</div></td>");									
								} else {
									bodyList.append("<td class='tableline11'><div align='center'>").append(classList.getString("resno",j).substring(0, 6)).append("-XXXXXXX"+"</div></td>");
								}
								bodyList.append("<td class='tableline11'><div align='center'>").append(classList.getString("deptnm",j)).append("</div></td>");
								bodyList.append("<td class='tableline11'><div align='center'>").append(classList.getString("jiknm",j)).append("</div></td>");
								bodyList.append("<td class='tableline11'><div align='center'>").append(classList.getString("avlcount",j)).append("</div></td>");
								bodyList.append("</tr>");
							}
						}
					}
				} else {
					bodyList.append("<tr bgcolor='#FFFFFF'>");
					if (requestMap.getString("sessClass").equals("7")) {
						bodyList.append("<td align='center' colspan='8' height='30'>지정된 과목이 없습니다</td>");
					} else {
						bodyList.append("<td align='center' colspan='8' height='30'>검색된 내역이 없습니다</td>");
					}
					bodyList.append("</tr>");
				}
				
				requestMap.setString("classList", bodyList.toString());
			}
			
			if (stu_cnt > 0) {				
				conf_button ="OK";
			}			
		}
		model.addAttribute("personList", personList);
		model.addAttribute("OPTION_LIST", optionStr);
		model.addAttribute("INFO_STR", infoStr);
		model.addAttribute("LANG_OPTION", lang_option);
		model.addAttribute("CONF_BUTTON", conf_button);
		
		String rtnString = "/evalMgr/score/specialScoreList";
		if (requestMap.getString("a_eval_method").equals("person")) {
			if (requestMap.getString("excelMode").equals("ok")) {
				requestMap.setString("mode","personListExcel");//개인별 엑셀 출력
				rtnString = "/evalMgr/score/specialScoreListExcel";
			} else {
				requestMap.setString("mode","personList");//개인별
				rtnString = "/evalMgr/score/specialScoreList";
			}
		} 
		if (requestMap.getString("a_eval_method").equals("class")) {
			if (requestMap.getString("excelMode").equals("ok")) {
				requestMap.setString("mode","classExcel");//반별 엑셀 출력
				rtnString = "/evalMgr/score/specialScoreList2Excel";
			} else {
				requestMap.setString("mode","class");//반별
				rtnString = "/evalMgr/score/specialScoreList2";
			}
		}
		if (requestMap.getString("a_eval_method").equals("langClass")) {
			requestMap.setString("mode","langClass");//어학점수평가
			rtnString = "/evalMgr/score/specialScoreList3";
		}
		
		return rtnString;
	}
	
	/**
	 * 평가점수입력 메뉴별 업데이트 실행
	 */
	public String update(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		int result=0;
		String msg="";
		String resultType = "";
		
		String mode=requestMap.getString("mode");
		if (mode.equals("person")) {//개인별
			result = scoreService.updatePerson(requestMap);
		} else if(mode.equals("langClass")) {//어학점수평가
			result = scoreService.updateLangClass(requestMap);
		} else {//반별
			result = scoreService.updateClass(requestMap);
		}			
		if(result > 0) {			
			msg = "저장 되었습니다.";						
			resultType = "ok";
		} else {			
			msg = "저장시 오류가 발생했습니다.";
			resultType = "saveError";			
		}						
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		requestMap.setString("mode","save");
		
		return "/evalMgr/score/scoreExec";
	}
	
	/**
	 * 성적별> 성적일람표 리스트 출력
	 */
	@RequestMapping(value="/evalMgr/score.do", params = "mode=score")
	public String scoreList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")) {
			//grcode명 입력
			DataMap resultMap = scoreService.selectScoreReport(requestMap);		
			requestMap.setString("grcodeniknm", resultMap.getString("grcodeniknm"));
			
			//정렬순서 값 입력
			if(requestMap.getString("orderby").equals("eduno")){
				requestMap.setString("ordernm","교번순");
			}else if(requestMap.getString("orderby").equals("seqno")){
				requestMap.setString("ordernm","성적순(가점포함)");
			}else if(requestMap.getString("orderby").equals("disadd")){
				requestMap.setString("ordernm","성적순(가점제외)");
			}
		}
		
		return "/evalMgr/score/scoreReport";
	}
	
	/**
	 * 가점입력
	 */
	@RequestMapping(value="/evalMgr/score.do", params = "mode=pointUp")
	public String pointUp(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//가점입력 대상자 리스트
		DataMap resultMap = scoreService.selectPointUpList(requestMap);
		//해당 과정에 대한 가점입력 가능 여부
		DataMap closing = scoreService.selectPointUpClosing(requestMap);
		
		model.addAttribute("pointUpList", resultMap);
		model.addAttribute("closing", closing);
		
		return "/evalMgr/score/pointUpList";
	}
	
	/**
	 * 가점 입력 포인트 저장
	 */
	@RequestMapping(value="/evalMgr/score.do", params = "mode=pointUpExec")
	public String insertPoint(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		int result=0;
		String msg="";
		String resultType = "";
		
		result = scoreService.updatePoint(requestMap);
					
		if (result > 0) {			
			msg = "저장 되었습니다.";						
			resultType = "ok";
		} else {			
			msg = "저장시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		requestMap.setString("mode","pointSave");
		
		return "/evalMgr/score/scorePointExec";
	}
	
	
}
