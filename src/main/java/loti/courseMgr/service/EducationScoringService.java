package loti.courseMgr.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.courseMgr.mapper.CourseSeqMapper;
import loti.courseMgr.mapper.EducationScoringMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Function;
import ut.lib.util.ListUtil;
import ut.lib.util.Message;
import ut.lib.util.OMRReader;
import ut.lib.util.SpringUtils;
import ut.lib.util.Util;
import ut.lib.util.WebUtils;
import common.service.BaseService;

@Service
public class EducationScoringService extends BaseService {

	private final String 	ID_COMPANY = "10034";
	
	@Autowired
	private EducationScoringMapper educationScoringMapper;
	
	@Autowired
	private CourseSeqMapper courseSeqMapper;
	
	public boolean containsExamAnsByKey(Map examAns) throws SQLException{
		examAns.put("idCompany", ID_COMPANY);
		return educationScoringMapper.countExamAnsByKey(examAns) > 0;
	}
	
	public DataMap findExamAnsByKeyExceptUserid(Map params) throws SQLException{
		params.put("idCompany", ID_COMPANY);
		return educationScoringMapper.findExamAnsByKeyExceptUserid(params);
	}
	
	public int saveExamAns(Map examAns) throws SQLException{
		examAns.put("idCompany", ID_COMPANY);
		if(this.containsExamAnsByKey(examAns)){
			return educationScoringMapper.updateExamAns(examAns);
		}else{
			return educationScoringMapper.insertExamAns(examAns);
		}
	}
	
	public int saveExamAns(List<Map> examAnses) throws SQLException{
		int res = 0;
		for(Map m : examAnses){
			res+=this.saveExamAns(m);
		}
		return res;
	}
	
	public int deleteExamAns(Map examAns) throws SQLException{
		examAns.put("idCompany", ID_COMPANY);
		return educationScoringMapper.deleteExamAns(examAns);
	}
	
	public int deleteExamAnsByIdCompanyAndIdExamAndIdSubject(Map examAns) throws SQLException{
		examAns.put("idCompany", ID_COMPANY);
		return educationScoringMapper.deleteExamAnsByIdCompanyAndIdExamAndIdSubject(examAns);
	}

	@Transactional
	public DataMap findOneGrseqByKey(DataMap keyMap, LoginInfo loginInfo) throws SQLException, BizException {
		
		DataMap grSeqMap = null;
        
		String year = keyMap.getString("year");
		String grcode = keyMap.getString("grcode");
		String grseq = keyMap.getString("grseq");
		String sessGubun = loginInfo.getSessGubun();
		
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("year", year);
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("sessGubun", sessGubun);
            //과정 기수 목록.
            grSeqMap = educationScoringMapper.findOneGrseqByKey(paramMap);
//            grSeqMap = courseSeqMapper.selectGrSeqList(paramMap);
            if (grSeqMap == null) {
            	grSeqMap = new DataMap();
            }
            grSeqMap.setNullToInitialize(true);
            
            //과목 기수의 과목 목록
            Map<String, Object> paramMap2 = null;
            for(int i=0; i < grSeqMap.keySize("grcode"); i++) {
            	String forGrcode = grSeqMap.getString("grcode", i);
            	String forGrSeq = grSeqMap.getString("grseq", i);
            	
            	//과정 기수의 포함될 과목정보.
            	DataMap addSubjMap = new DataMap("SUBJ");
            	
        		addSubjMap.addString("grcode", forGrcode);
        		addSubjMap.addString("grseq", forGrSeq);
        		addSubjMap.addString("grcodenm", grSeqMap.getString("grcodenm", i));
        		addSubjMap.addString("subjCount", grSeqMap.getString("subjCount", i));
        		addSubjMap.addString("cafeYn", grSeqMap.getString("cafeYn", i));
        		
            	//과정기수의 과목 리스트.
        		paramMap2 = new HashMap<String, Object>();
        		paramMap2.put("grcode", grcode);
        		paramMap2.put("forGrSeq", forGrSeq);
            	DataMap subjMap = courseSeqMapper.selectSubjLecTypeList1(paramMap2);
            	subjMap.setNullToInitialize(true);
            	
            	if (subjMap.keySize("subj") > 0) {
            		for(int j=0; j < subjMap.keySize("subj"); j++) {
            			//기본 과목 정보
        				addSubjMap.addString("refSubjnm", subjMap.getString("subjnm", j));
        				addSubjMap.addString("refSubj", subjMap.getString("subj", j));
        				addSubjMap.addString("lecType", subjMap.getString("lecType", j));
        				addSubjMap.addString("subj", subjMap.getString("subj", j));
        				
        				//상세 과목 정보
            			DataMap addSubjRefMap = new DataMap("SUBJ_REF");
            			
            			if (subjMap.getString("lecType", j).equals("P")) {
            				//선택과목의 서브과목 목록
            				Map<String, Object> paramMap3 = new HashMap<String, Object>();
            				paramMap3.put("grcode", grcode);
            				paramMap3.put("forGrSeq", forGrSeq);
            				paramMap3.put("subj", subjMap.getString("subj", j));
            				paramMap3.put("lecType", subjMap.getString("lecType", j));
            				DataMap refSubjMap = courseSeqMapper.selectSubjLecTypeList1(paramMap3);
            				if (refSubjMap == null) {
            					refSubjMap = new DataMap();
            				}
            				refSubjMap.setNullToInitialize(true);
            				
            				//addSubjMap.addString("REF_SIZE", 	"1");
            				addSubjMap.addString("refSize", refSubjMap.keySize("subj")+"");
            				
            				if (refSubjMap.keySize("subj") <= 0) {
            					addSubjRefMap.addString("grcode", forGrcode);
            					addSubjRefMap.addString("grseq", forGrSeq);
            					addSubjRefMap.addString("subj", subjMap.getString("subj", j));
                				addSubjRefMap.addString("count1", subjMap.getString("count1", j));
                				addSubjRefMap.addString("count2", subjMap.getString("count2", j));
                				addSubjRefMap.addString("count3", subjMap.getString("count3", j));
                				addSubjRefMap.addString("started", subjMap.getString("started", j));
                				addSubjRefMap.addString("enddate", subjMap.getString("enddate", j));
            				}
            				
            				for(int k = 0; k < refSubjMap.keySize("subj"); k++) {
                				addSubjRefMap.addString("subj", refSubjMap.getString("subj", k));
                				addSubjRefMap.addString("subjnm", refSubjMap.getString("subjnm", k));
                				addSubjRefMap.addString("ptype", subjMap.getString("ptype", j));
                				addSubjRefMap.addString("evlYn", subjMap.getString("evlYn", j));
                				addSubjRefMap.addString("subjtype", subjMap.getString("subjtype", j));
                				addSubjRefMap.addString("started", refSubjMap.getString("started", k));
                				addSubjRefMap.addString("enddate", refSubjMap.getString("enddate", k));
                				addSubjRefMap.addString("lecType", refSubjMap.getString("lecType", k));
                				addSubjRefMap.addString("preed", subjMap.getString("preed", j));
                				addSubjRefMap.addString("closing", refSubjMap.getString("closing", k));
                				addSubjRefMap.addString("count1", refSubjMap.getString("count1", k));
                				addSubjRefMap.addString("count2", refSubjMap.getString("count2", k));
                				addSubjRefMap.addString("count3", refSubjMap.getString("count3", k));
        					}
            			} else {
            				addSubjRefMap.addString("refSubjnm", "");
            				addSubjRefMap.addString("refSubj", subjMap.getString("subj", j));
            				addSubjRefMap.addString("subj", subjMap.getString("subj", j));
            				addSubjRefMap.addString("subjnm", subjMap.getString("subjnm", j));
            				addSubjRefMap.addString("ptype", subjMap.getString("ptype", j));
            				addSubjRefMap.addString("ptypenm", subjMap.getString("ptypenm", j));
            				addSubjRefMap.addString("evlYn", subjMap.getString("evlYn", j));
            				addSubjRefMap.addString("subjtype", subjMap.getString("subjtype", j));
            				addSubjRefMap.addString("started", subjMap.getString("started", j));
            				addSubjRefMap.addString("enddate", subjMap.getString("enddate", j));
            				addSubjRefMap.addString("lecType", subjMap.getString("lecType", j));
            				addSubjRefMap.addString("count1", subjMap.getString("count1", j));
            				addSubjRefMap.addString("count2", subjMap.getString("count2", j));
            				addSubjRefMap.addString("count3", subjMap.getString("count3", j));
            				addSubjRefMap.addString("preed", subjMap.getString("preed", j));
            				addSubjRefMap.addString("closing", subjMap.getString("closing", j));
            			}
            			addSubjMap.add("SUBJ_REF_LIST_MAP", addSubjRefMap);
            		}
            	}
            	grSeqMap.add("SUBJ_LIST_MAP", addSubjMap);
            }//end for 과목 기수의 과목 목록
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return grSeqMap;
		
	}

	public DataMap findAnsBySubjAndGrcodeAndGrseqAndIdExam(DataMap requestMap) throws SQLException {
		
		/**
		 * 페이징 필수
		 */
		// 페이지
		if (requestMap.getString("currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 99999); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		String stareType = requestMap.getString("stareType");
		DataMap resultMap = null;
		

		
    	int totalCnt = 0;
    	if("4".equals(stareType)){
    		totalCnt = educationScoringMapper.findBakAnsBySubjAndGrcodeAndGrseqAndIdExamCount(requestMap);
    	}else{
    		totalCnt = educationScoringMapper.findAnsBySubjAndGrcodeAndGrseqAndIdExamCount(requestMap);
    	}
    	
    	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
    	
    	requestMap.set("page", pageInfo);
    	
		if("4".equals(stareType)){
			resultMap = educationScoringMapper.findBakAnsBySubjAndGrcodeAndGrseqAndIdExam(requestMap);
		}else{
			resultMap = educationScoringMapper.findAnsBySubjAndGrcodeAndGrseqAndIdExam(requestMap);
		}
        
       	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
    				
       	resultMap.set("PAGE_INFO", pageNavi);
		
		return resultMap;
	}
	
	public DataMap exportAnsToExcel(DataMap dataMap, HttpServletRequest request, HttpServletResponse response) throws Exception{

		WebUtils.setExcelHeader("응시 현황", request, response);
		
		return this.findAnsBySubjAndGrcodeAndGrseqAndIdExam(dataMap);
	}

	@Transactional
	public int saveOmrAns(DataMap dataMap, LoginInfo loginInfo) throws Exception {
		
		Map params = new HashMap();
		
		params.put("grcode", dataMap.getString("grcode"));
		params.put("grseq", dataMap.getString("grseq"));
		params.put("examUnit", 1);
		
//		String idExam = null;
		List<Map> list = null;
		int cnt = 0;
		
		
		if(dataMap.keySize("UPLOAD_FILE") == 0){
			return 0;
		}
		
		DataMap fileMap = (DataMap)dataMap.get("UPLOAD_FILE");
		if(fileMap == null) fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		
		StringBuilder sb = new StringBuilder();
		sb.append(SpringUtils.getRealPath()).append(Constants.UPLOAD).append(fileMap.getString("file_filePath")).append(fileMap.getString("file_fileName"));
		String root = sb.toString();
		
		File omr = new File(root);
		
		InputStream is = new FileInputStream(omr);
			
		list = OMRReader.read(is, OMRReader.parseAnswer());
		
		omr.delete();
		
		params.put("idSubject", dataMap.getString("subj"));
		
		// idCourse : idSubject, courseYear : grcode, courseNo : grseq
//		idExam = educationScoringMapper.findOneExamIdByIdCourseAndCourseYearAndCourseNo(params);
		
		params.put("idExam", dataMap.getString("idExam"));
		
		this.deleteExamAnsByIdCompanyAndIdExamAndIdSubject(params);
		
		for(Map m : list){
			m.putAll(params);
			m.put("nrSet", m.get("paperType").toString().charAt(0) - ('A'-1));  	// A:1, B:2, C:3
			m.put("userid", educationScoringMapper.findUsernoInAppInfoByGrcodeAndGrseqAndEduNo(m));
			if(m.get("userid") == null){
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				return -1;
			}
			cnt+=this.saveExamAns(m);
		}
		
		return cnt;
	}

	public List<Map> exportAnsScoringListToExcel(DataMap dataMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		WebUtils.setExcelHeader("채점 대사리스트", request, response);
		
		dataMap.setString("ynEnd", "Y");
		
		List<Map> anses =  educationScoringMapper.findAnsBySubjAndGrcodeAndGrseqAndYnEnd(dataMap);
		
		anses = ListUtil.map(anses, new Function<Map, Map>() {

			@Override
			public Map apply(Map m) {
				
				List<String> oxs = Arrays.asList(m.get("OXS").toString().split("\\{:\\}"));
				List<String> answers = Arrays.asList(m.get("ANSWERS").toString().split("\\{:\\}"));
				
				char min = '①'-1;
				String ox = null;
				String ans = null;
				String temp = null;
				String ansTemp = null;
				for(int i=1; i<=oxs.size(); i++){
					
					ox = oxs.get(i-1);
					try{
						ans = answers.get(i-1);
					}catch(ArrayIndexOutOfBoundsException aioobe){
						ans = "";
					}
					if(ans.length() != 0){
						ansTemp = (char)(Integer.valueOf(ans)+min) + "";
					}else{
						ansTemp = "";
					}
					 
					temp = ansTemp + "(" + ox + ")";
					
					m.put("문제"+i, temp);
				}
				
				m.put("size", oxs.size());
				
				return m;
			}
		});
		
		return anses;
	}

	public boolean containsExresult(Map exresult) throws SQLException{
		return educationScoringMapper.countExresult(exresult) > 0;
	}
	
	public int insertExresult(Map exresult) throws SQLException{
		return educationScoringMapper.insertExresult(exresult);
	}
	
	public int updateExresult(Map exresult) throws SQLException{

		return educationScoringMapper.updateExresult(exresult);
	}
	
	public int saveExresult(Map exresult) throws SQLException{

		exresult.put("apageType", "A");
		exresult.put("examgubun", "O");
		exresult.put("evalType", "G");
		if(this.containsExresult(exresult)){
			return this.updateExresult(exresult);
		}else{
			return this.insertExresult(exresult);
		}
	}
	
	// sendToLms 에서 시험결과를 토대로 과목별 점수 계산 및 ox 구분 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> calcExamData(List<Map> examPaper, List<Map> anses, String suserno){
		
		List<Map> result = new ArrayList<Map>();
		
		for(Map m : anses){
			
			m.put("suserno", suserno);
			m.put("grcode", m.get("GRCODE"));
			m.put("grseq", m.get("GRSEQ"));
			m.put("userno", m.get("USERNO"));
			
			List<String> oxs = Arrays.asList(m.get("OXS").toString().split("\\{:\\}"));
			List<String> courseCodes = ListUtil.pluck(examPaper, "COURSE_CODE");
			Map<String, Map> courseData = new HashMap();
			for(String key : courseCodes){
				courseData.put(key, new HashMap());
			}
			
			String courseCode = null;
			// oxs 답안 개수와 examPaper의 사이즈는 같다
			for(int i=0; i<oxs.size(); i++){
				
				courseCode = (String)examPaper.get(i).get("COURSE_CODE");
				int idQtype = ((BigDecimal)examPaper.get(i).get("ID_QTYPE")).intValue();			// 문제 형태 1,2,3 : 객관식 / 4,5 : 주관식
				double allotting = ((BigDecimal)examPaper.get(i).get("ALLOTTING")).doubleValue();	// 배점
				Map data = courseData.get(courseCode);
				
				switch (idQtype) {
				case 1:	case 2:	case 3:	// 객관식
					String gakoxgubun = Util.nvl(data.get("gakoxgubun"));
					gakoxgubun = gakoxgubun+oxs.get(i);
					data.put("gakoxgubun", gakoxgubun);
					if(!"O".equals(oxs.get(i))){
						break;
					}
					Integer gakcount = (Integer)data.get("gakcount");
					data.put("gakcount", gakcount == null ? 0 : gakcount+1);
					Double gakpoint = (Double)data.get("gakpoint");
					data.put("gakpoint", gakpoint == null ? allotting : gakpoint+allotting);
					break;
				case 4: case 5:	// 주관식
					String juoxgubun = Util.nvl(data.get("juoxgubun"));
					juoxgubun = juoxgubun+oxs.get(i);
					data.put("juoxgubun", juoxgubun);
					if(!"O".equals(oxs.get(i))){
						break;
					}
					Integer jucount = (Integer)data.get("jucount");
					data.put("jucount", jucount == null ? 0 : jucount+1);
					Double jupoint = (Double)data.get("jupoint");
					data.put("jupoint", jupoint == null ? allotting : jupoint+allotting);
					break;
				}
				courseData.put(courseCode, data);
			}
			
			for(Entry<String, Map> data : courseData.entrySet()){
				Map temp = data.getValue();
				temp.put("subj", data.getKey());
				temp.putAll(m);
				result.add(temp);
			}
			
		}
		
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Transactional
	public int sendToLms(DataMap dataMap, LoginInfo loginInfo) throws SQLException {
		
		dataMap.setString("ynEnd", "Y");
		dataMap.setString("idSubject", dataMap.getString("subj"));
		
		List<Map> anses =  educationScoringMapper.findAnsBySubjAndGrcodeAndGrseqAndYnEnd(dataMap);
		// idExam, idSubject
		List<Map> examPaper = educationScoringMapper.findExamPaper2ByIdExamAndIdSubject(dataMap);
		
		List<Map> insertData = this.calcExamData(examPaper, anses, loginInfo.getSessNo());

		Integer examKind = educationScoringMapper.selectOneExamKindOfExamM(dataMap.getString("idExam"));
		
		String onoffType = "C".equals(dataMap.getString("grgubun")) ? "O" : "M";
		String ptype = null;
		switch (examKind) {
		case 0:
			ptype = "M";
			break;
		case 1:
			ptype = "T";
			break;
		case 2:case 3:case 4:case 5:case 6:
			ptype = String.valueOf(examKind-1);
			break;

		default:
			ptype = String.valueOf(examKind-1);
			break;
		}
		
		int cnt = 0;
		
		for(Map m : insertData){
			m.put("onoffType", onoffType);
			m.put("ptype", ptype);
			cnt+=this.saveExresult(m);
		}
		
		return cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getCorrectAns(List<Map> examPaper){
		
		List<Map> list = new ArrayList<Map>();
		
		List<BigDecimal> nrSetList = ListUtil.pluck(examPaper, "NR_SET");
		Set<BigDecimal> nrSet = ListUtil.uniq(nrSetList);
		
		Map m = new HashMap();
		List<Map> oxs = null;
		for(final BigDecimal ns : nrSet){
			
			oxs = ListUtil.select(examPaper, new Function<Map, Boolean>(){

				@Override
				public Boolean apply(Map t) {
					BigDecimal nrSet = (BigDecimal) t.get("NR_SET");
					if(nrSet == null){
						return false;
					}
					return nrSet.intValue() == ns.intValue();
				}
				
			});
			
			m.put(ns.intValue(), oxs);
			
		}
		
		return m;
	}
	
	public boolean isAns(String ca, String ans){
		
		/*
		 {^}		 {|}
		 위 구분자를 사용하는 답은 42건밖에 없음.
		 복수답안을 사용하는지?
		 */
		if(ca.indexOf("{") == -1){
			return ca.equals(ans);
		}
		
		if(ca.indexOf("{^}") != -1){
			List<String> cas = Arrays.asList(ca.split("\\{\\^\\}"));
			for(String c : cas){
				if(c.equals(ans)){
					return true;
				}
			}
		}
		
		if(ca.indexOf("{|}") != -1){
			List<String> cas = Arrays.asList(ca.split("\\{\\|\\}"));
			boolean chk = false;
//			for(String c : cas){
//				for(Integer.valueOf(c));
//			}
			return chk;
		}
		return false;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Transactional
	public int scoringAns(DataMap requestMap) throws SQLException {
		
		Map params = new HashMap();
		
		params.put("idSubject", requestMap.getString("subj"));
		params.put("grcode", requestMap.getString("grcode"));
		params.put("grseq", requestMap.getString("grseq"));
		
		// idCourse : idSubject, courseYear : grcode, courseNo : grseq
//		String idExam = educationScoringMapper.findOneExamIdByIdCourseAndCourseYearAndCourseNo(params);
		
		params.put("idExam", requestMap.getString("idExam"));
		
		// idExam, idSubject
		List<Map> examPaper = educationScoringMapper.findExamPaper2ByIdExamAndIdSubject(params);
		
		Map correctAns = this.getCorrectAns(examPaper);
		
		List<String> checkedUserno = null;
		
		if("true".equals(requestMap.getString("total"))){
			checkedUserno = new ArrayList<String>();
			for(int i=0; i<requestMap.keySize("userno"); i++){
				checkedUserno.add(requestMap.getString("userno", i));
			}
		}

		
		DataMap ans = this.findAnsBySubjAndGrcodeAndGrseqAndIdExam(requestMap);
		
		List<Map> updateList = new ArrayList<Map>();
		
		String answers = null;
		Integer nrSet = null;
		List<Map> cAns = null;
		Map updateAns = null;
		StringBuilder oxs = null;
		StringBuilder points = null;
		BigDecimal allotting = null;
		double score = 0;
		List<String> tempAns = null;
		
		for(int i=0; i<ans.keySize("subj"); i++){
			
			if(checkedUserno != null && !checkedUserno.contains(ans.getString("userno", i))){
				continue;
			}
			
			answers = ans.getString("answers", i);
			nrSet = ans.getInt("nrSet", i);
			
			if(answers == null){
				continue;
			}
			
			cAns = (List<Map>) correctAns.get(nrSet);
			tempAns = Arrays.asList(answers.split("\\{:\\}",cAns.size()));
			
			oxs = new StringBuilder();
			points = new StringBuilder();
			score = 0;
			
			for(int j=0; j<cAns.size(); j++){
				if(j!=0){
					oxs.append("{:}");
					points.append("{:}");
				}
				try{
					if("2".equals(cAns.get(j).get("ID_VALID_TYPE").toString()) || this.isAns(Util.nvl(cAns.get(j).get("CA")), tempAns.get(j))){
	//				if(cAns.get(j).get("CA").equals(tempAns.get(j))){
						allotting = (BigDecimal)cAns.get(j).get("ALLOTTING");
						score += allotting.doubleValue();
						oxs.append("O");
						points.append(allotting.doubleValue());
					}else{
						oxs.append("X");
						points.append("0.0");
					}
				}catch(ArrayIndexOutOfBoundsException aioobe){
					//log.debug("교육생이 시험을 끝까지 보지 않음.");
					oxs.append("X");
					points.append("0.0");
				}
			}
			
			updateAns = new HashMap();
			
			updateAns.put("idCompany", ID_COMPANY);
			updateAns.put("userid", ans.getString("userno", i));
			updateAns.put("idExam", ans.getString("idExam", i));
			updateAns.put("subj", ans.getString("subj", i));
			
			updateAns.put("oxs", oxs.toString());
			updateAns.put("points", points.toString());
			updateAns.put("score", score);
			
			updateList.add(updateAns);
			
		}

		return this.updateExamAnsScoring(updateList);
	}
	
	@SuppressWarnings("rawtypes")
	public int updateExamAnsScoring(List<Map> updateList) throws SQLException{
		
		int cnt = 0;
		
		for(Map m : updateList){
			cnt += educationScoringMapper.updateExamAnsScoring(m);
		}
		
		return cnt;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Transactional
	public int completeAns(DataMap requestMap) throws SQLException {
		
		Map params = new HashMap();
		
		params.put("idCompany", ID_COMPANY);
		params.put("idSubject", requestMap.getString("subj"));
		params.put("grcode", requestMap.getString("grcode"));
		params.put("grseq", requestMap.getString("grseq"));
		
		// idCourse : idSubject, courseYear : grcode, courseNo : grseq
//		String idExam = educationScoringMapper.findOneExamIdByIdCourseAndCourseYearAndCourseNo(params);
		
		params.put("idExam", requestMap.getString("idExam"));
		params.put("ynEnd", requestMap.getString("ynEnd"));
		
		int cnt = 0;
		
		for(int i=0; i<requestMap.keySize("userno"); i++){
			params.put("userno", requestMap.getString("userno", i));
			cnt += educationScoringMapper.updateExamAnsYnEnd(params);
		}
		
		return cnt;
		
	}

	public DataMap findExamMByGrcodeAndGrseq(DataMap requestMap) throws SQLException {
		
		return educationScoringMapper.findExamMByGrcodeAndGrseq(requestMap);
	}

	public DataMap selectOneExamAns(Map params) throws SQLException{
		params.put("idCompany", ID_COMPANY);
		return educationScoringMapper.selectOneExamAns(params);
	}
	
	public boolean containsBakExamAnsByKey(Map params) throws SQLException{
		params.put("idCompany", ID_COMPANY);
		return educationScoringMapper.countBakExamAnsByKey(params) > 0;
	}
	public int saveBakExamAns(Map params) throws SQLException{
		params.put("idCompany", ID_COMPANY);
		if(this.containsBakExamAnsByKey(params)){
			return educationScoringMapper.updateBakExamAns(params);
		}else{
			return educationScoringMapper.insertBakExamAns(params);
		}
	}
	
	@SuppressWarnings("unchecked")
	@Transactional
	public int deleteAns(DataMap requestMap) throws SQLException {
		
//		ID_COMPANY
//		USERID
//		ID_EXAM
//		ID_SUBJECT
		
		Map params = new HashMap();
		
		params.put("idExam", requestMap.getString("idExam"));
		params.put("idSubject", requestMap.getString("subj"));
		
		int cnt = 0;
		DataMap examAns = null;
		for(int i=0; i<requestMap.keySize("userno"); i++){
			params.put("userid", requestMap.getString("userno"));
			examAns = this.selectOneExamAns(params);
			this.saveBakExamAns(examAns);
			cnt+=this.deleteExamAns(params);
		}
		
		return cnt;
	}

	public int deleteBakExamAns(Map params) throws SQLException{
		params.put("idCompany", ID_COMPANY);
		return educationScoringMapper.deleteBakExamAns(params);
	}
	
	@Transactional
	public int deleteBakAns(DataMap requestMap) throws SQLException {
		
		Map params = new HashMap();
		
		params.put("idExam", requestMap.getString("idExam"));
		params.put("idSubject", requestMap.getString("subj"));
		
		int cnt = 0;
		DataMap examAns = null;
		for(int i=0; i<requestMap.keySize("userno"); i++){
			params.put("userno", requestMap.getString("userno"));
			cnt+=this.deleteBakExamAns(params);
		}
		
		return cnt;
	}
	
	public DataMap selectOneBakExamAns(Map params) throws SQLException{
		params.put("idCompany", ID_COMPANY);
		return educationScoringMapper.selectOneBakExamAns(params);
	}

	@Transactional
	public int restoreAns(DataMap requestMap) throws SQLException {
		
		Map params = new HashMap();
		
		params.put("idExam", requestMap.getString("idExam"));
		params.put("idSubject", requestMap.getString("subj"));
		
		int cnt = 0;
		DataMap examAns = null;
		for(int i=0; i<requestMap.keySize("userno"); i++){
			params.put("userid", requestMap.getString("userno", i));
			examAns = this.selectOneBakExamAns(params);
//			if(examAns.get("score") instanceof BigDecimal){
//				examAns.setDouble("score", ((BigDecimal)examAns.get("score")).doubleValue());
//			}
			this.saveExamAns(examAns);
			cnt+=this.deleteBakExamAns(params);
		}
		
		return cnt;
	}

	@Transactional
	public List<String> containsAnsByUserno(DataMap requestMap) throws SQLException {
		
		Map params = new HashMap();
		
		params.put("idExam", requestMap.getString("idExam"));
		params.put("idSubject", requestMap.getString("subj"));
		
		List<String> usernos = new ArrayList<String>();
		for(int i=0; i<requestMap.keySize("userno"); i++){
			params.put("userid", requestMap.getString("userno", i));
			if(this.containsExamAnsByKey(params)){
				usernos.add(requestMap.getString("userno", i));
			}
		}
		
		return usernos;
	}

	public List<Map> selectAnswers(DataMap requestMap) throws SQLException {
		
		Map params = new HashMap();
		
		params.put("idCompany", ID_COMPANY);
		params.put("idExam", requestMap.getString("idExam"));
		params.put("idSubject", requestMap.getString("subj"));
		params.put("userid", requestMap.getString("userno"));
		
		DataMap ans = educationScoringMapper.selectOneExamAns(params);
		ans.setNullToInitialize(true);
		
		params.put("nrSet", ans.getString("nrSet"));
		requestMap.setString("nrSet", ans.getString("nrSet"));
		
		// idExam, idSubject, nrSet
		List<Map> examPaper = educationScoringMapper.findExamPaper2ByIdExamAndIdSubjectAndNrSet(params);
		
		String[] ansarr = ans.getString("answers").split("\\{:\\}", examPaper.size());
		
		List<String> answers = Arrays.asList(ans.getString("answers").split("\\{:\\}", examPaper.size()));
		
		for(int i=0; i<examPaper.size(); i++){
//			System.out.println(examPaper.get(i).get("CA"));
			try{
				examPaper.get(i).put("answer", answers.get(i));
			}catch(ArrayIndexOutOfBoundsException aioobe){
				//log.debug("교육생이 시험을 끝까지 보지 않음.");
				examPaper.get(i).put("answer", "");
			}
		}
		
		return examPaper;
	}

	public int updateAns(DataMap requestMap) throws SQLException {
		
		String prefix = "Mark_ANS_";
		
		TreeMap<Integer, String> tm = new TreeMap<Integer, String>();
		
		for(Object key : requestMap.keySet()){
			if(key.toString().startsWith(prefix)){
				tm.put(Integer.parseInt(key.toString().replace(prefix, "")), requestMap.getString(key));
			}
		}
		String separator = "{:}";
		StringBuilder serializedAns = new StringBuilder();
		boolean isFirst = true;
		for(Integer key : tm.keySet()){
			if(!isFirst){
				serializedAns.append(separator);
			}
			serializedAns.append(tm.get(key));
			if(isFirst) isFirst = false;
		}
		
		requestMap.setString("answers", serializedAns.toString());
		
//		AND ID_COMPANY = #{idCompany}
//		AND USERID = #{userid}
//		AND ID_EXAM = #{idExam}
//		AND ID_SUBJECT = #{idSubject}
		requestMap.setString("idCompany", ID_COMPANY);
		requestMap.setString("userid", requestMap.getString("userno"));
		requestMap.setString("idSubject", requestMap.getString("subj"));
		
		int cnt = educationScoringMapper.updateAnswersExamAns(requestMap);
		
		if(cnt > 0){
			return this.scoringAns(requestMap);
		}
		
		return 0;
	}
	
	
}
