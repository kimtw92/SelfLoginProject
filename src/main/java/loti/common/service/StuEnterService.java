package loti.common.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.common.mapper.StuEnterMapper;
import loti.common.mapper.StuOutMapper;
import loti.courseMgr.mapper.LectureApplyMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class StuEnterService extends BaseService {

	@Autowired
	private StuEnterMapper stuEnterMapper;
	
	@Autowired
	private LectureApplyMapper lectureApplyMapper;
	
	@Autowired
	@Qualifier("commonStuOutMapper")
	private StuOutMapper stuOutMapper;

	/**
	 * 간략한 유저 정보 가져오기. (주민등록검색 및 로그인 등급에 따라.)
	 * @param resno
	 * @param sessClass
	 * @param sessDept
	 * @return
	 * @throws Exception
	 */
	public DataMap selectMemberSimpleByResnoRow(String resno, String sessClass, String sessDept) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("sessClass", sessClass); // Constants.ADMIN_SESS_CLASS_DEPT가 같을 조건
            params.put("resno", resno);
            params.put("sessDept", sessDept);
            
            resultMap = stuEnterMapper.selectMemberSimpleByResnoRow(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	//2010.01.12 - woni82
	//관리자가 회원의 수강신청을 관리자 페이지에서 하여 줌.
	//회원의 주민등록번호 조회에서 아이디 조회로 변경함.
	/**
	 * 간략한 유저 정보 가져오기. (userid 및 로그인 등급에 따라.)
	 * @param resno
	 * @param sessClass
	 * @param sessDept
	 * @return
	 * @throws Exception
	 */
	public DataMap selectMemberSimpleByUseridRow(String userid, String sessClass, String sessDept, String ldapcode) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
		    Map<String, Object> params = new HashMap<String, Object>();
		    
		    params.put("userid", userid);
		    params.put("sessClass", sessClass);
		    params.put("sessDept", sessDept);
		    params.put("ldapcode", ldapcode);
		    params.put("ADMIN_SESS_CLASS_DEPT", Constants.ADMIN_SESS_CLASS_DEPT);
		    
            resultMap = stuEnterMapper.selectMemberSimpleByUseridRow(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	//
	/**
	 * 간략한 유저 정보 가져오기. (이름검색 및 로그인 등급에 따라.)
	 * @param name
	 * @param sessClass
	 * @param sessDept
	 * @return
	 * @throws Exception
	 */
	public DataMap selectMemberSimpleByNameRow(String name, String sessClass, String sessDept, String ldapcode) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            String whereStr = "";
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr = " AND dept = '" + sessDept + "' ";
            
		    if("6289999".equals(sessDept)) {
		    	whereStr += "  AND LDAPCODE = '" + ldapcode + "'  ";
            }
		    
		    Map<String, Object> params = new HashMap<String, Object>();
		    
		    params.put("name", name);
		    params.put("sessClass", sessClass);
		    params.put("sessDept", sessDept);
		    params.put("ldapcode", ldapcode);
		    params.put("ADMIN_SESS_CLASS_DEPT", Constants.ADMIN_SESS_CLASS_DEPT);
		    
            resultMap = stuEnterMapper.selectMemberSimpleByNameRow(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 수강신청 기간 확인.
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public int selectGrseqEapplyedChk(String grcode, String grseq) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultValue = stuEnterMapper.selectGrseqEapplyedChk(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	
	/**
	 * 1차 승인기간 확인
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public int selectGrseqEndsentChk(String grcode, String grseq) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultValue = stuEnterMapper.selectGrseqEndsentChk(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	
	/**
	 * 회원정보 수정.
	 * @param userMap
	 * @return
	 * @throws Exception
	 */
	public int updateMemberSimple(DataMap userMap) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
        	userMap.setString("deptnm", "".equals(Util.nvl(userMap.getString("PART_DATA"),"")) ? null:userMap.getString("deptsub"));
        	
            resultValue = stuEnterMapper.updateMemberSimple(userMap);
                          
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	
	/**
	 * 회원 주민등록 번호로 중복 확인.
	 * @param userno
	 * @return
	 * @throws Exception
	 */
	public int selectMemberResnoChk(String resno)  throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            resultValue = stuEnterMapper.selectMemberResnoChk(resno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 교육생 직접 입력 실행.
	 * @param userMap
	 * @param sessClass
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int execStuEnter(DataMap requestMap, String sessClass, String sessUserno) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
			if(!requestMap.getString("userno").equals("")){ //userno가 있으면 update
				
				//개인정보 업데이트 체크시
				if(requestMap.getString("memberUpdateYN").equals("Y")){
					//회원 정보 수정.
					stuEnterMapper.updateMemberSimple(requestMap);
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
//				requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno")
				int tmpResult = stuEnterMapper.selectAppInfoMemberChk(requestMap);
				
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
					
					requestMap.setString("updateStr", updateStr);
					
					//수강신청 테이블 업데이트
//					updateStr, requestMap.getString("dept"), requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno")
					resultValue = stuEnterMapper.updateAppInfoDirect(requestMap);
					
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
			
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 교육생(입교자) 리스트 - 부서기관 where
	 * @param grcode
	 * @param grseq
	 * @param sessClass
	 * @param sessDept
	 * @param pagingInfoMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectAppInfoBySessAndDeptList(String grcode, String grseq, String ldapcode, String sessClass, String sessDept, DataMap pagingInfoMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            pagingInfoMap.setString("grcode", grcode);
            pagingInfoMap.setString("grseq", grseq);
            pagingInfoMap.setString("sessClass", sessClass);
            pagingInfoMap.setString("sessDept", sessDept);
            pagingInfoMap.setString("ldapcode", ldapcode);
            pagingInfoMap.setString("ADMIN_SESS_CLASS_DEPT", Constants.ADMIN_SESS_CLASS_DEPT);
            pagingInfoMap.setString("ADMIN_SESS_CLASS_PART", Constants.ADMIN_SESS_CLASS_PART);
            
            resultMap = stuEnterMapper.selectAppInfoBySessAndDeptList2(pagingInfoMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 교육생(입교자) 리스트 - no pageing
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectAppInfoBySessAndDeptList(String grcode, String grseq) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);

            resultMap = stuEnterMapper.selectAppInfoBySessAndDeptList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	
	
	/**
	 * 교육생(입교자) 조회 리스트 페이징 제외한(엑셀)
	 * @param grcode
	 * @param grseq
	 * @param sessClass
	 * @param sessDept
	 * @return
	 * @throws Exception
	 */
	public DataMap selectAppInfoBySessAndDeptList(String grcode, String grseq, String sessClass, String sessDept, String parmsDept) throws Exception{
		
        DataMap resultMap = null;
        
        try {
            
            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("grcode", grcode);
            params.put("grseq", grseq);
            params.put("sessClass", sessClass);
            params.put("sessDept", sessDept);
            params.put("parmsDept", parmsDept);
            params.put("ADMIN_SESS_CLASS_DEPT", Constants.ADMIN_SESS_CLASS_DEPT);
            params.put("ADMIN_SESS_CLASS_PART", Constants.ADMIN_SESS_CLASS_PART);
            
            resultMap = stuEnterMapper.selectAppInfoBySessAndDeptList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	public DataMap selectAppInfoBySessAndDeptList2(String grcode, String grseq, String ldapcode, String sessClass, String sessDept, String parmsDept) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
		    Map<String, Object> params = new HashMap<String, Object>();
		    
		    params.put("grcode", grcode);
		    params.put("grseq", grseq);
		    params.put("ldapcode", ldapcode);
		    params.put("sessClass", sessClass);
		    params.put("sessDept", sessDept);
		    params.put("parmsDept", parmsDept);
		    params.put("ADMIN_SESS_CLASS_DEPT", Constants.ADMIN_SESS_CLASS_DEPT);
		    params.put("ADMIN_SESS_CLASS_PART", Constants.ADMIN_SESS_CLASS_PART);
		    
            resultMap = stuEnterMapper.selectAppInfoBySessAndDeptList2(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 수강생정보 수정 및 회원 정보 수정.
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int updateAppInfo(DataMap requestMap) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            //수강신청 기관 및 부서 정보수정.
            stuEnterMapper.updateAppInfoByDeptAndJik(requestMap);
            
            //회원정보 수정 (직급, 기관, 소속)
            stuEnterMapper.updateMemberByDept(requestMap);
            
            resultValue++;
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 수강생의 기관 리스트
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectDeptByAppInfoList(String grcode, String grseq) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultMap = stuEnterMapper.selectDeptByAppInfoList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 기관/계급명 CROSS 통계
	 * @param deptMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectDeptDogsCrossList(String grcode, String grseq, DataMap deptMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            String sumStr = "";
            String decodeDeptStr = "";
            String decodeDogsStr = "";
            
            for(int i = 0; i < deptMap.keySize("dept"); i++){
            	
            	sumStr += " SUM(DEPT"+(i+1)+") AS DEPT"+(i+1)+",  ";
            	
            	decodeDeptStr += " DECODE(C.DEPT,'"+deptMap.getString("dept", i)+"', C.COUNT_SUM, 0) AS DEPT"+(i+1)+", ";
            	
            	decodeDogsStr += " DECODE(A.DEPT,'"+deptMap.getString("dept", i)+"', A.COUNT_USER, 0) AS DEPT"+(i+1)+", ";
            	
            }
            
            if(deptMap.keySize("dept") > 0){
            	
            	Map<String, Object> params = new HashMap<String, Object>();
            
            	params.put("grcode", grcode);
            	params.put("grseq", grseq);
            	params.put("sumStr", sumStr);
            	params.put("decodeDeptStr", decodeDeptStr);
            	params.put("decodeDogsStr", decodeDogsStr);
            	
            	resultMap = stuEnterMapper.selectDeptDogsCrossList(params);
            }else
            	resultMap = new DataMap();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 수강생의 직렬 리스트 
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectJikrByAppInfoList(String grcode, String grseq) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultMap = stuEnterMapper.selectJikrByAppInfoList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 직렬/계급명 CROSS 통계
	 * @param grcode
	 * @param grseq
	 * @param jikrMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectJikrDogsCrossList(String grcode, String grseq, DataMap jikrMap) throws Exception{
		
        DataMap resultMap = null;
        
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
            	
            	Map<String, Object> params = new HashMap<String, Object>();
            	
            	params.put("grcode", grcode);
            	params.put("grseq", grseq);
            	params.put("sumStr", sumStr);
            	params.put("decodeJikrStr", decodeJikrStr);
            	
            	resultMap = stuEnterMapper.selectJikrDogsCrossList(params);
            	
            }else
            	resultMap = new DataMap();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 수강신청 회원의 수강일 이후 임용일의 경과일 및 임용일 (신규채용자 과정에서 사용.)
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectAppInfoUpsdateRow(String grcode, String grseq) throws Exception{
		
        DataMap resultMap = new DataMap();
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            DataMap listMap = stuEnterMapper.selectAppMemberUpsdateList(params);
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
            
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 수강신청자 재직기간별 경과일 리스트.
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectAppInfoUpsdateRowBySysdate(String grcode, String grseq) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultMap = stuEnterMapper.selectAppInfoUpsdateRowBySysdate(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 수강신청자 연령별 정보
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectAppInfoStatisticsByAgeRow(String grcode, String grseq) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultMap = stuEnterMapper.selectAppInfoStatisticsByAgeRow(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 수강신청자 학력별 리스트
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectAppInfoStatisticsBySchoolRow(String grcode, String grseq) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            DataMap schTmpMap = stuEnterMapper.selectAppInfoStatisticsBySchoolList(params);
                                    
    		if(schTmpMap == null) schTmpMap = new DataMap();
    		schTmpMap.setNullToInitialize(true);
    		
    		resultMap = new DataMap();
    		int totCnt = 0;
    		for(int i = 0; i < schTmpMap.keySize("school"); i++){
    			resultMap.addString(schTmpMap.getString("school", i), schTmpMap.getString("schCnt", i));
    			totCnt += schTmpMap.getInt("schCnt", i);
    		}
    		resultMap.addInt("sum", totCnt);
    		
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 수강신청자 거주지별 리스트
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectAppInfoStatisticsByAddrRow(String grcode, String grseq) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            DataMap tmpMap = stuEnterMapper.selectAppInfoStatisticsByAddrList(params);
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
    		
    		
    		
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 사이버교육이 종료 여부
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public int selectSubjSeqEndDateChkByCyber(String grcode, String grseq) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultValue = stuEnterMapper.selectSubjSeqEndDateChkByCyber(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 집합 교육 입과 대상자 리스트
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectAppInfoByMemberList(String grcode, String grseq, String grchk) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	params.put("grchk", grchk);
        	
            resultMap = stuEnterMapper.selectAppInfoByMemberList(params);

    		
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 교육생 복원
	 * @param requestMap
	 * @param luserno
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int execReStuEnter(DataMap requestMap, String luserno) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            String userno = requestMap.getString("userno");
            
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
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	
	/**
	 * 집합교육 대상자 선정.
	 * @param requestMap
	 * @param luserno
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int execStuEnterApproval(DataMap requestMap, String luserno) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            String grseqStartexamYn = requestMap.getString("startexamYn");
            
            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("grcode", grcode);
            params.put("grseq", grseq);
            
            String chkBox = "";
            String userno = "";
            
            //체크선택한 사람은 승인자 이므로 그대로 두고 선택되지 않은 사람은 탈락시킨다.
            for(int i = 1 ; i <= requestMap.getInt("listCnt") ; i++){
            	
            	chkBox = requestMap.getString("chk"+i);
            	userno = requestMap.getString("hidUserno"+i);
            	
            	//선택 되지 않았으면.
            	if(chkBox.equals("")){
            		
            		params.put("userno", userno);
                    
                    //퇴교자 수강 정보 백업
                    stuOutMapper.insertRejStuLecSpec(params);

                    //퇴교자 과제 제출 백업
                    stuOutMapper.insertRejReportSubmitSpec(params);
                    
                    //퇴교자 - 과목별 시험채점결과정보 백업
                    stuOutMapper.insertRejExresultSpec(params);  
                    
                    
                    //과목별 시험채점결과정보 삭제
                    stuOutMapper.deleteExResultSpec(params); 
            
                    //리포트 제출 정보 삭제
                    stuOutMapper.deleteReportSubmitSpec(params);
                    
                    //과목수강정보 삭제
                    stuOutMapper.deleteStuLecSpec(params);
                    
                    
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
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectMemberBySimpleDataList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
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
    		
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 교육중인 수강생 조회
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap stuMemberList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
	    	int totalCnt = stuEnterMapper.stuMemberListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = stuEnterMapper.stuMemberList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}	
}
