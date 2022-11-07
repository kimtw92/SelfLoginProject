package loti.courseMgr.service;

import gov.mogaha.gpin.sp.util.StringUtil;

import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.LectureApplyMapper;
import loti.courseMgr.mapper.StuEnterMapper;
import loti.courseMgr.mapper.StuOutMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Util;
import common.service.BaseService;

@Service("courseMgrStuEnterService")
public class StuEnterService extends BaseService {
	
	@Autowired
	@Qualifier("courseMgrStuEnterMapper")
	private StuEnterMapper stuEnterMapper;
	@Autowired
	private LectureApplyMapper lectureApplyMapper;
	@Autowired
	@Qualifier("courseMgrStuOutMapper")
	private StuOutMapper stuOutMapper;

	
	/**
	 * 간략한 유저 정보 가져오기. (주민등록검색 및 로그인 등급에 따라.)
	 */
	public DataMap selectMemberSimpleByResnoRow(String resno, String sessClass, String sessDept) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr = " AND dept = '" + sessDept + "' ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("resno", resno);
            paramMap.put("whereStr", whereStr);
            
            resultMap = stuEnterMapper.selectMemberSimpleByResnoRow(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	//2010.01.12 - woni82
	//관리자가 회원의 수강신청을 관리자 페이지에서 하여 줌.
	//회원의 주민등록번호 조회에서 아이디 조회로 변경함.
	/**
	 * 간략한 유저 정보 가져오기. (userid 및 로그인 등급에 따라.)
	 */
	public DataMap selectMemberSimpleByUseridRow(String userid, String sessClass, String sessDept, String ldapcode) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr = " AND dept = '" + sessDept + "' ";
		    if("6289999".equals(sessDept)) {
		    	whereStr += "  AND LDAPCODE = '" + ldapcode + "'  ";
            }
		    
		    Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("userid", userid);
            paramMap.put("whereStr", whereStr);
            
            resultMap = stuEnterMapper.selectMemberSimpleByUseridRow(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	//
	/**
	 * 간략한 유저 정보 가져오기. (이름검색 및 로그인 등급에 따라.)
	 */
	public DataMap selectMemberSimpleByNameRow(String name, String sessClass, String sessDept, String ldapcode) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr = " AND dept = '" + sessDept + "' ";
            
		    if("6289999".equals(sessDept)) {
		    	whereStr += "  AND LDAPCODE = '" + ldapcode + "'  ";
            }
		    
		    Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("name", name);
            paramMap.put("whereStr", whereStr);
            
            resultMap = stuEnterMapper.selectMemberSimpleByNameRowAndUserid(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 수강신청 기간 확인.
	 */
	public int selectGrseqEapplyedChk(String grcode, String grseq) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
        	resultValue = stuEnterMapper.selectGrseqEapplyedChk(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultValue;
	}
	
	/**
	 * 1차 승인기간 확인
	 */
	public int selectGrseqEndsentChk(String grcode, String grseq) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
        	resultValue = stuEnterMapper.selectGrseqEndsentChk(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultValue;
	}
	
	/**
	 * 회원정보 수정.
	 */
	public int updateMemberSimple(DataMap userMap) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("name", userMap.getString("name"));
            paramMap.put("homeTel", userMap.getString("homeTel"));
            paramMap.put("email", userMap.getString("email"));
            paramMap.put("jik", userMap.getString("jik"));
            paramMap.put("deptsub", userMap.getString("deptsub"));
            paramMap.put("dept", userMap.getString("dept"));
            paramMap.put("deptnm", userMap.getString("deptnm"));
            paramMap.put("PART_DATA", userMap.getString("PART_DATA"));
            paramMap.put("ldapname", "".equals(StringUtil.nvl(userMap.getString("PART_DATA"),"")) ? null:userMap.getString("deptsub"));
            paramMap.put("userno", userMap.getString("userno"));
            
        	resultValue = stuEnterMapper.updateMemberSimple2(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultValue;
	}
	
	/**
	 * 회원 주민등록 번호로 중복 확인.
	 */
	public int selectMemberResnoChk(String resno)  throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = stuEnterMapper.selectMemberResnoChk(resno);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultValue;
	}
	
	/**
	 * 교육생 직접 입력 실행.
	 */
	public int execStuEnter(DataMap requestMap, String sessClass, String sessUserno) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
        try {
        	if(!requestMap.getString("userno").equals("")){ //userno가 있으면 update
				//개인정보 업데이트 체크시
				if(requestMap.getString("memberUpdateYN").equals("Y")){
					//회원 정보 수정.
					paramMap = new HashMap<String, Object>();
		            paramMap.put("name", requestMap.getString("name"));
		            paramMap.put("homeTel", requestMap.getString("homeTel"));
		            paramMap.put("email", requestMap.getString("email"));
		            paramMap.put("jik", requestMap.getString("jik"));
		            paramMap.put("deptsub", requestMap.getString("deptsub"));
		            paramMap.put("dept", requestMap.getString("dept"));
		            paramMap.put("deptnm", requestMap.getString("deptnm"));
		            paramMap.put("PART_DATA", requestMap.getString("PART_DATA"));
		            paramMap.put("ldapname", "".equals(StringUtil.nvl(requestMap.getString("PART_DATA"),"")) ? null:requestMap.getString("deptsub"));
		            paramMap.put("userno", requestMap.getString("userno"));
		            
					stuEnterMapper.updateMemberSimple2(paramMap);
				}
			}else{
				//이미 입력한 교육생이면 경고창 뿌려줌..
				resultValue = stuEnterMapper.selectMemberResnoChk(requestMap.getString("resno"));
				if(resultValue > 0 ){
					resultValue = -1;
				}else{
					//간이 회원 등록
					//관리자가 수강신청을 하면서 회원을 등록한다.
					requestMap.setString("userno", stuEnterMapper.selectMemberMaxUserNo());
					//requestMap.setString("pwd", StringReplace.subString(requestMap.getString("resno").trim(), 6) + "a");
					//2010.01.28 주민등록번호와 관련되어 있던 내용 변경됨.
					requestMap.setString("pwd", requestMap.getString("userid").trim() + "a");
					
					//회원 등록.
					resultValue = stuEnterMapper.insertMemberSimple(requestMap);
					
					if(resultValue <= 0){
						resultValue = -2;
					}
				}
			}
			
			//이상없이 여기 까지 왔다면.
			if(resultValue >= 0){
				paramMap = new HashMap<String, Object>();
	            paramMap.put("grcode", requestMap.getString("grcode"));
	            paramMap.put("grseq", requestMap.getString("grseq"));
	            paramMap.put("userno", requestMap.getString("userno"));
	            
				int tmpResult = stuEnterMapper.selectAppInfoMemberChk(paramMap);
				
				if(tmpResult > 0){ //수강신청정보 있으면 update
					String updateStr = "";
					
					//과정운영자,시스템관리자일 경우엔 최종승인
					if( sessClass.equals(Constants.ADMIN_SESS_CLASS_ADMIN) 
						|| sessClass.equals(Constants.ADMIN_SESS_CLASS_COURSE)
						|| sessClass.equals(Constants.ADMIN_SESS_CLASS_COURSEMAN)){
						updateStr = " GRCHK = 'Y', ";
					}else if ( sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT) ){ //기관 담당자 일경우.
						updateStr = " DEPTCHK = 'Y', ";
					}
					
					//수강신청 테이블 업데이트
					paramMap = new HashMap<String, Object>();
		            paramMap.put("updateStr", updateStr);
		            paramMap.put("dept", requestMap.getString("dept"));
		            paramMap.put("grcode", requestMap.getString("grcode"));
		            paramMap.put("grseq", requestMap.getString("grseq"));
		            paramMap.put("userno", requestMap.getString("userno"));
		            
					resultValue = stuEnterMapper.updateAppInfoDirect(paramMap);
				}else{ //수강신청정보 없으면 insert
					DataMap appInfoMap = new DataMap();
					appInfoMap.setNullToInitialize(true);
					
					//과정운영자,시스템관리자일 경우엔 최종승인
					if( sessClass.equals(Constants.ADMIN_SESS_CLASS_ADMIN) 
							|| sessClass.equals(Constants.ADMIN_SESS_CLASS_COURSE)
							|| sessClass.equals(Constants.ADMIN_SESS_CLASS_COURSEMAN)){
						appInfoMap.setString("grchk", "Y");
					}else if ( sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT) ){ //기관 담당자 일경우.
						appInfoMap.setString("deptchk", "Y");
					}

					appInfoMap.setString("grcode", requestMap.getString("grcode"));
					appInfoMap.setString("grseq", requestMap.getString("grseq"));
					appInfoMap.setString("userno", requestMap.getString("userno"));
					
					appInfoMap.setString("dept", requestMap.getString("dept"));
					appInfoMap.setString("name", requestMap.getString("name"));
					appInfoMap.setString("telno", requestMap.getString("homeTel"));
					appInfoMap.setString("jik", requestMap.getString("jik"));
					appInfoMap.setString("luserno", sessUserno);
					
					//수강 신청 정보 등록.
					resultValue = stuEnterMapper.insertAppInfoDirect(appInfoMap);
				}
				
				//과정운영자,시스템관리자일 경우에만 등록.
				if( resultValue > 0 && 
						(sessClass.equals(Constants.ADMIN_SESS_CLASS_ADMIN) 
						|| sessClass.equals(Constants.ADMIN_SESS_CLASS_COURSE)
						|| sessClass.equals(Constants.ADMIN_SESS_CLASS_COURSEMAN)) ){
					requestMap.setString("luserno", sessUserno);
					//과목 수강 정보 테이블에 등록.
					resultValue = lectureApplyMapper.insertStuLecUserSpec(requestMap);
				}
			}
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultValue;
	}
	
	/**
	 * 교육생(입교자) 리스트 - 부서기관 where
	 */
	public DataMap selectAppInfoBySessAndDeptList(String grcode, String grseq, String ldapcode, String sessClass, String sessDept, DataMap pagingInfoMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT) || sessClass.equals(Constants.ADMIN_SESS_CLASS_PART))
            	whereStr += " AND B.DEPT = '" + sessDept + "' ";
            
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_PART))
            	whereStr += " AND A.PARTCD = '" + sessDept + "' ";
            
            if(!pagingInfoMap.getString("dept").equals(""))
            	whereStr += " AND B.DEPT = '" + pagingInfoMap.getString("dept") + "' ";
		    
            if("6289999".equals(sessDept)) {
            	whereStr += "  AND C.LDAPCODE = '" + ldapcode + "'  ";
            }
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("whereStr", whereStr);
            
            int appInfoBySessAndDeptList2Count = stuEnterMapper.selectAppInfoBySessAndDeptList2Count(paramMap);
            
            Map<String, Object> pageInfo = Util.getPageInfo(appInfoBySessAndDeptList2Count, pagingInfoMap);
            pageInfo.put("grcode", grcode);
			pageInfo.put("grseq", grseq);
			pageInfo.put("whereStr", whereStr);
            
            resultMap = stuEnterMapper.selectAppInfoBySessAndDeptList2(pageInfo);
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            
            resultMap.set("PAGE_INFO", pageNavi);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 교육생(입교자) 리스트 - no pageing
	 */
	public DataMap selectAppInfoBySessAndDeptList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
        	
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("whereStr", whereStr);

            resultMap = stuEnterMapper.selectAppInfoBySessAndDeptList(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 교육생(입교자) 조회 리스트 페이징 제외한(엑셀)
	 */
	public DataMap selectAppInfoBySessAndDeptList(String grcode, String grseq, String sessClass, String sessDept, String parmsDept) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT) || sessClass.equals(Constants.ADMIN_SESS_CLASS_PART))
            	whereStr += " AND A.DEPT = '" + sessDept + "' ";
            
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_PART))
            	whereStr += " AND A.PARTCD = '" + sessDept + "' ";
            
            if(!parmsDept.equals(""))
            	whereStr += " AND A.DEPT = '" + parmsDept + "' ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("whereStr", whereStr);
            
            resultMap = stuEnterMapper.selectAppInfoBySessAndDeptList(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	public DataMap selectAppInfoBySessAndDeptList2(String grcode, String grseq, String ldapcode, String sessClass, String sessDept, String parmsDept) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT) || sessClass.equals(Constants.ADMIN_SESS_CLASS_PART))
            	whereStr += " AND B.DEPT = '" + sessDept + "' ";
            
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_PART))
            	whereStr += " AND A.PARTCD = '" + sessDept + "' ";
            
            if(!parmsDept.equals(""))
            	whereStr += " AND B.DEPT = '" + parmsDept + "' ";

		    if("6289999".equals(sessDept)) {
		    	whereStr += "  AND C.LDAPCODE = '" + ldapcode + "'  ";
            }
            
		    Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("whereStr", whereStr);
            
            resultMap = stuEnterMapper.selectAppInfoBySessAndDeptList(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 수강생정보 수정 및 회원 정보 수정.
	 */
	public int updateAppInfo(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//수강신청 기관 및 부서 정보수정.
        	stuEnterMapper.updateAppInfoByDeptAndJik(requestMap);
            
            //회원정보 수정 (직급, 기관, 소속)
        	stuEnterMapper.updateMemberByDept(requestMap);
            
            resultValue++;
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultValue;
	}
	
	/**
	 * 수강생의 기관 리스트
	 */
	public DataMap selectDeptByAppInfoList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
        	resultMap = stuEnterMapper.selectDeptByAppInfoList(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 기관/계급명 CROSS 통계
	 */
	public DataMap selectDeptDogsCrossList(String grcode, String grseq, DataMap deptMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String sumStr = "";
            String decodeDeptStr = "";
            String decodeDogsStr = "";
            
            for(int i = 0; i < deptMap.keySize("dept"); i++){
            	sumStr += " SUM(DEPT"+(i+1)+") AS DEPT"+(i+1)+",  ";
            	decodeDeptStr += " DECODE(C.DEPT,'"+deptMap.getString("dept", i)+"', C.COUNT_SUM, 0) AS DEPT"+(i+1)+", ";
            	decodeDogsStr += " DECODE(A.DEPT,'"+deptMap.getString("dept", i)+"', A.COUNT_USER, 0) AS DEPT"+(i+1)+", ";
            }
            
            if(deptMap.keySize("dept") > 0) {
            	Map<String, Object> paramMap = new HashMap<String, Object>();
                paramMap.put("grcode", grcode);
                paramMap.put("grseq", grseq);
                paramMap.put("sumStr", sumStr);
                paramMap.put("decodeDeptStr", decodeDeptStr);
                paramMap.put("decodeDogsStr", decodeDogsStr);
                
            	resultMap = stuEnterMapper.selectDeptDogsCrossList(paramMap);
            } else
            	resultMap = new DataMap();
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 수강생의 직렬 리스트 
	 */
	public DataMap selectJikrByAppInfoList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
        	resultMap = stuEnterMapper.selectJikrByAppInfoList(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 직렬/계급명 CROSS 통계
	 */
	public DataMap selectJikrDogsCrossList(String grcode, String grseq, DataMap jikrMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String sumStr = "";
            String decodeJikrStr = "";
            
            for(int i = 0; i < jikrMap.keySize("code"); i++){
            	//SUM(JIKR1) JIKR1
            	sumStr += " SUM(JIKR"+(i+1)+") AS JIKR"+(i+1)+",  ";
            	
            	//DECODE(A.CODE,'007',A.COUNT_USER,0) JIKR1
            	decodeJikrStr += " DECODE(A.CODE,'"+jikrMap.getString("code", i)+"', A.COUNT_USER, 0) AS JIKR"+(i+1)+", ";
            }
            
            if(jikrMap.keySize("code") > 0){
            	sumStr += " SUM(ETC) AS ETC,  ";
            	decodeJikrStr += " DECODE(A.CODE,'ETC',A.COUNT_USER,null, A.COUNT_USER, 0) AS ETC, ";
            	
            	Map<String, Object> paramMap = new HashMap<String, Object>();
                paramMap.put("grcode", grcode);
                paramMap.put("grseq", grseq);
                paramMap.put("sumStr", sumStr);
                paramMap.put("decodeJikrStr", decodeJikrStr);
                
            	resultMap = stuEnterMapper.selectJikrDogsCrossList(paramMap);
            }else
            	resultMap = new DataMap();
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 수강신청 회원의 수강일 이후 임용일의 경과일 및 임용일 (신규채용자 과정에서 사용.)
	 */
	public DataMap selectAppInfoUpsdateRow(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
        	DataMap listMap = stuEnterMapper.selectAppMemberUpsdateList(paramMap);
            if(listMap == null) listMap = new DataMap();
            listMap.setNullToInitialize(true);
            
            int[] countArr = {0, 0, 0, 0, 0, 0, 0, 0};
            int totCnt = 0;
            
            for(int i=0; i < listMap.keySize("userno"); i++){
            	if(listMap.getString("upsdate", i).equals(""))
            		countArr[0]++;
            	else if(listMap.getInt("upsdateCnt", i) <= 0)
            		countArr[0]++;
            	else if(listMap.getInt("upsdateCnt", i) <= 30)
            		countArr[2]++;
            	else if(listMap.getInt("upsdateCnt", i) <= 91)
            		countArr[3]++;
            	else if(listMap.getInt("upsdateCnt", i) <= 182)
            		countArr[4]++;
            	else if(listMap.getInt("upsdateCnt", i) <= 365)
            		countArr[5]++;
            	else if(listMap.getInt("upsdateCnt", i) <= 730)
            		countArr[6]++;
            	else
            		countArr[7]++;
            	
            	totCnt ++;
            }
            
            resultMap.addInt("sum", totCnt);
            resultMap.addInt("y0", countArr[0]);
            resultMap.addInt("y2", countArr[2]);
            resultMap.addInt("y3", countArr[3]);
            resultMap.addInt("y4", countArr[4]);
            resultMap.addInt("y5", countArr[5]);
            resultMap.addInt("y6", countArr[6]);
            resultMap.addInt("y7", countArr[7]);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 수강신청자 재직기간별 경과일 리스트.
	 */
	public DataMap selectAppInfoUpsdateRowBySysdate(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
            resultMap = stuEnterMapper.selectAppInfoUpsdateRowBySysdate(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 수강신청자 연령별 정보
	 */
	public DataMap selectAppInfoStatisticsByAgeRow(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
            resultMap = stuEnterMapper.selectAppInfoStatisticsByAgeRowBirthdate(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 수강신청자 학력별 리스트
	 */
	public DataMap selectAppInfoStatisticsBySchoolRow(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
        	DataMap schTmpMap = stuEnterMapper.selectAppInfoStatisticsBySchoolList(paramMap);
                                    
    		if(schTmpMap == null) schTmpMap = new DataMap();
    		schTmpMap.setNullToInitialize(true);
    		
    		resultMap = new DataMap();
    		int totCnt = 0;
    		for(int i = 0; i < schTmpMap.keySize("school"); i++){
    			resultMap.addString(schTmpMap.getString("school", i), schTmpMap.getString("schCnt", i));
    			totCnt += schTmpMap.getInt("schCnt", i);
    		}
    		resultMap.addInt("sum", totCnt);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 수강신청자 거주지별 리스트
	 */
	public DataMap selectAppInfoStatisticsByAddrRow(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
        	DataMap tmpMap = stuEnterMapper.selectAppInfoStatisticsByAddrList(paramMap);
    		if(tmpMap == null) tmpMap = new DataMap();
    		tmpMap.setNullToInitialize(true);
    		
    		resultMap = new DataMap();
    		resultMap.setNullToInitialize(true);
    		int totCnt = 0;
    		
    		for(int i = 0; i < tmpMap.keySize("homeAddr"); i++){
    			if( tmpMap.getString("homeAddr", i).indexOf(" 중구") > -1 )
    				resultMap.setInt("a1", resultMap.getInt("a1")+1 );
    			else if( tmpMap.getString("homeAddr", i).indexOf(" 동구") > -1 )
    				resultMap.setInt("a2", resultMap.getInt("a2")+1 );
    			else if( tmpMap.getString("homeAddr", i).indexOf(" 남구") > -1 )
    				resultMap.setInt("a3", resultMap.getInt("a3")+1 );
    			else if( tmpMap.getString("homeAddr", i).indexOf(" 연수구") > -1 )
    				resultMap.setInt("a4", resultMap.getInt("a4")+1 );
    			else if( tmpMap.getString("homeAddr", i).indexOf(" 남동구") > -1 )
    				resultMap.setInt("a5", resultMap.getInt("a5")+1 );
    			else if( tmpMap.getString("homeAddr", i).indexOf(" 부평구") > -1 )
    				resultMap.setInt("a6", resultMap.getInt("a6")+1 );
    			else if( tmpMap.getString("homeAddr", i).indexOf(" 계양구") > -1 )
    				resultMap.setInt("a7", resultMap.getInt("a7")+1 );
    			else if( tmpMap.getString("homeAddr", i).indexOf(" 서구") > -1 )
    				resultMap.setInt("a8", resultMap.getInt("a8")+1 );
    			else if( tmpMap.getString("homeAddr", i).indexOf(" 강화군") > -1 )
    				resultMap.setInt("a9", resultMap.getInt("a9")+1 );
    			else if( tmpMap.getString("homeAddr", i).indexOf(" 옹진군") > -1 )
    				resultMap.setInt("a10", resultMap.getInt("a10")+1 );
    			else 
    				resultMap.setInt("a11", resultMap.getInt("a11")+1 );
    			
    			totCnt++;
    		}
    		resultMap.addInt("sum", totCnt);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 사이버교육이 종료 여부
	 */
	public int selectSubjSeqEndDateChkByCyber(String grcode, String grseq) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
        	resultValue = stuEnterMapper.selectSubjSeqEndDateChkByCyber(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultValue;
	}
	
	/**
	 * 집합 교육 입과 대상자 리스트
	 */
	public DataMap selectAppInfoByMemberList(String grcode, String grseq, String grchk) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("grchk", grchk);
            
        	resultMap = stuEnterMapper.selectAppInfoByMemberList(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 교육생 복원
	 */
	public int execReStuEnter(DataMap requestMap, String luserno) throws BizException{
		int resultValue = 0;
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            String userno = requestMap.getString("userno");
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("userno", userno);
            
            //수강신청 정보 등록 (퇴소 테이블에서)
            stuOutMapper.insertStuLecByRejSpec(requestMap); 
            
            //수강생의 과제 등록 (퇴소 테이블에서)
            stuOutMapper.insertReportSubmitByRejSpec(requestMap); 
            
            //수강생의 과제 등록 (퇴소 테이블에서)
            stuOutMapper.insertExResultByRejSpec(requestMap); 
            
            //퇴교자 - 과목별 시험채점결과정보 삭제
            stuOutMapper.deleteRejExResultSpec(requestMap);
         
            //퇴교자 - 리포트 제출 정보 삭제
            stuOutMapper.deleteRejReportSubmitSpec(requestMap);
            
            //퇴교자 - 과목수강정보 삭제
            stuOutMapper.deleteRejStuLecSpec(requestMap);
            
            //수강신청 정보 변경. (grchk = 'Y')
            DataMap lecMap = new DataMap();
			lecMap.setString("grchk", "Y");
			lecMap.setString("luserno", luserno);
            lecMap.setString("grcode", grcode);
            lecMap.setString("grseq", grseq);
            lecMap.setString("userno", userno);
            lectureApplyMapper.updateAppInfoGrChk(lecMap);
            
            resultValue++;
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultValue;
	}
	
	/**
	 * 집합교육 대상자 선정.
	 */
	public int execStuEnterApproval(DataMap requestMap, String luserno) throws BizException{
		int resultValue = 0;
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            String grseqStartexamYn = requestMap.getString("startexamYn");
            
            String chkBox = "";
            String userno = "";
            
            //체크선택한 사람은 승인자 이므로 그대로 두고 선택되지 않은 사람은 탈락시킨다.
            for(int i = 1 ; i <= requestMap.getInt("listCnt") ; i++){
            	chkBox = requestMap.getString("chk"+i);
            	userno = requestMap.getString("hidUserno"+i);
            	
            	//선택 되지 않았으면.
            	if(chkBox.equals("")){
            		//퇴교자 수강 정보 백업
            		stuOutMapper.insertRejStuLecSpec(requestMap);

                    //퇴교자 과제 제출 백업
            		stuOutMapper.insertRejReportSubmitSpec(requestMap);
                    
                    //퇴교자 - 과목별 시험채점결과정보 백업
            		stuOutMapper.insertRejExresultSpec(requestMap);  
                    
                    //과목별 시험채점결과정보 삭제
            		stuOutMapper.deleteExResultSpec(requestMap); 
            
                    //리포트 제출 정보 삭제
            		stuOutMapper.deleteReportSubmitSpec(requestMap);
                    
                    //과목수강정보 삭제
            		stuOutMapper.deleteStuLecSpec(requestMap);
                    
                    //수강신청 정보 변경. (grchk = 'P')
                    DataMap lecMap = new DataMap();
        			lecMap.setString("grchk", "P");
        			lecMap.setString("luserno", luserno);
                    lecMap.setString("grcode", grcode);
                    lecMap.setString("grseq", grseq);
                    lecMap.setString("userno", userno);
                    lectureApplyMapper.updateAppInfoGrChk(lecMap);
            	}else{ //체크 되었다면 선발 고사 승인 여부에 따라 처리.
            		if( grseqStartexamYn.equals("Y")){
                        //수강신청 정보 변경. (grchk = 'Y')
                        DataMap appMap = new DataMap();
                        appMap.setString("grchk", "Y");
                        appMap.setString("startexamYn", "Y");
                        appMap.setString("grcode", grcode);
                        appMap.setString("grseq", grseq);
                        appMap.setString("userno", userno);
                        stuEnterMapper.updateAppInfoGrChkAndStartExam(appMap);
            		}
            	} //end if
            } //end for
            resultValue++;
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultValue;
	}
	
	/**
	 * 
	 */
	public DataMap selectMemberBySimpleDataList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            
            for(int i = 0 ; i < requestMap.keySize("userno[]") ; i++){
        		if(i > 0) whereStr += ", ";
        		
        		whereStr += "'" + requestMap.getString("userno[]", i) + "'";
            }
            System.out.println("\n ## usercnt = " + whereStr);
            
            if(whereStr.equals(""))
            	resultMap = new DataMap();
            else{
            	resultMap = lectureApplyMapper.selectMemberBySimpleDataList(" AND USERNO IN (" + whereStr + ") ");
            }
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 교육중인 수강생 조회
	 */
	public DataMap stuMemberList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            
            if(!requestMap.getString("name").equals("")){
            	whereStr += " AND A.NAME LIKE '"+requestMap.getString("name")+"%'";
            }
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("date1", requestMap.getString("date1"));
            paramMap.put("date2", requestMap.getString("date2"));
            paramMap.put("whereStr", whereStr);
            
            int stuMemberListCount = stuEnterMapper.stuMemberListCount(paramMap);
            
            Map<String, Object> pageInfo = Util.getPageInfo(stuMemberListCount, requestMap);
        	pageInfo.put("date1", requestMap.getString("date1"));
			pageInfo.put("date2", requestMap.getString("date2"));
			pageInfo.put("whereStr", whereStr);
			
            resultMap = stuEnterMapper.stuMemberList(pageInfo);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}	
}
