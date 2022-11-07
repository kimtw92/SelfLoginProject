package loti.member.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.member.mapper.MemberMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;


/**
 * 회원관리
 * 작성일 5월 20일
 * 작성자 정 윤철
 * @author Administrator
 *
 */
@Service
public class MemberService extends BaseService {

	@Autowired
	MemberMapper memberMapper;
	
	public int ajaxCreateId2(DataMap requestMap) throws BizException{
		
		
	        int error = -1;
	        try {
	        		error = memberMapper.ajaxCreateId2(requestMap);	        
	            
	        } catch (java.sql.SQLException e) {
	        	error = -1;
	            throw new BizException(Message.getKey(e), e);
	        } 	            
	        return error;        
	}

	/**
	 * 계정관리 리스트
	 * 작성일 5월 27일
	 * 작성자 정윤철
	 * @return
	 * @throws Exception
	 */
		public DataMap selectMemberListAuth5(DataMap requestMap) throws BizException{
				    
			DataMap resultMap = null;       
	      
	        try {
	       	            
	            if(requestMap.getString("auth").equals("5")){
	            	
	            	//강사회원조회 라디오박스 체크드를 위해서 셋시킴
	            	requestMap.setString("checked5","checked");
	        	}
	            
	            int totalCnt = memberMapper.selectMemberListAuth5Count(requestMap);
	        	
	        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
	        	
	        	requestMap.set("page", pageInfo);
	        	            
	        	//기관코드관리 리스트	
	        	resultMap = memberMapper.selectMemberListAuth5(requestMap);
	        	
	            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			    resultMap.set("PAGE_INFO", pageNavi);

	        	
	        	

	        	
	        } catch (SQLException e) {
	            throw new BizException(Message.getKey(e), e);
	        } finally {
	           
	        }
	        return resultMap;        
		}

		/**
		 * 계정관리 리스트
		 * 작성일 5월 27일
		 * 작성자 정윤철
		 * @return
		 * @throws Exception
		 */
			public DataMap selectMemberListAuth(DataMap requestMap) throws BizException{
				
		       
				DataMap resultMap = null;
		        
		        try {		        			        	
		        	
		        	if(requestMap.getString("auth").equals("10")){
		            	//학적부회원 검색  
		            	
		            	requestMap.setString("checked10","checked");
		            	
		        	}else if(requestMap.getString("auth").equals("")){
		        		//일반회원 검색		        	
		            	
		        		requestMap.setString("checked","checked");
		        	}
		        	
		        		int totalCnt = memberMapper.selectMemberListAuthCount(requestMap);
			        	
			        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
			        	
			        	requestMap.set("page", pageInfo);
			        	
			        	//기관코드관리 리스트
		            	resultMap = memberMapper.selectMemberListAuth(requestMap);
			            
			            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
					    resultMap.set("PAGE_INFO", pageNavi);

		        		
		        	
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		            
		        }
		        return resultMap;        
			}

		/**
		 * 기관선택명 가져오기
		 * 작성일 5월 27일
		 * 작성자 정윤철
		 * @return
		 * @throws Exception
		 */
	public DataMap selectDeptList() throws BizException{		
     
		DataMap resultMap = null;
        
        try {        
        	//기관선택명 가져오기
        	resultMap = memberMapper.selectDeptList();        	
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
           
        }
        return resultMap;        
	}

	/**
	 * 전체 멤버수 가져오기
	 * 작성일 5월 27일
	 * 작성자 정윤철
	 * @return
	 * @throws Exception
	 */
		public DataMap selectTotalMemberRow() throws BizException{
			
	        
			DataMap resultMap = null;
	        
	        try {
	           
	        	//기관선택명 가져오기
	        	resultMap = memberMapper.selectTotalMemberRow();
	        	
	            
	        } catch (SQLException e) {
	            throw new BizException(Message.getKey(e), e);
	        } finally {
	            
	        }
	        return resultMap;        
		}

		/**
		 * ID발급 회원 카운터 수 구하기
		 * 작성일 5월 27일
		 * 작성자 정윤철
		 * @return
		 * @throws Exception
		 */
			public DataMap selectIdRow() throws BizException{
						   
				DataMap resultMap = null;
		        
		        try {
		       
		        	//기관선택명 가져오기
		        	resultMap = memberMapper.selectIdRow();
		        	
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		
		        }
		        return resultMap;        
			}

			/**
			 * 멤버정보 가져오기
			 * 작성일 5월 27일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
				public DataMap selectMemberInfoRow(String userNo) throws BizException{
								        
					DataMap resultMap = null;
			        
			        try {			          		            
			         
			        	//멤버정보 가져오기
			        	resultMap = memberMapper.selectMemberInfoRow(userNo);			        	
			            
			        } catch (SQLException e) {
			            throw new BizException(Message.getKey(e), e);
			        } finally {
			          
			        }
			        return resultMap;        
				}

			/**
			 * 부서 검색
			 * 작성일 5월 28일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			public DataMap selectLdapCodeList(String dept) throws BizException{
				
		        
				DataMap resultMap = null;
		        
		        try {
		           		         
		            resultMap = memberMapper.selectLdapCodeList(dept);
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		           
		        }
		        return resultMap;        
			}

			/**
			 * 부서 검색
			 * 작성일 5월 28일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			public  DataMap selectPartCodeList(String dept) throws BizException{
				
		       
				DataMap resultMap = null;
		        
		        try {
		            
		            resultMap = memberMapper.selectPartCodeList(dept);
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		           
		        }
		        return resultMap;        
			}

			public int memberCheckID(String user_id) throws BizException{
						       
		        int errorcode = -1;
		        
		        try {     		            
		          
		            errorcode = memberMapper.memberCheckID(user_id);
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		           
		        }
		        return errorcode;        
			}

			/**
			 * 부서 검색
			 * 작성일 5월 28일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			@Transactional
			public int modifyMember(DataMap reqeustMap) throws BizException{
				
		        
		        int returnvalue = 0;
		        try {
		            		        	
		        	reqeustMap.setString("ldapname", "".equals(Util.nvl(reqeustMap.getString("ldapcode"), "")) ? null:reqeustMap.getString("ldapname"));  
		        	
		        	if (reqeustMap.getString("userId").length() > 4){					
		        	
		        		
		        		returnvalue  = memberMapper.modifyMember_userId(reqeustMap);
		        		
					} else {
						returnvalue  = memberMapper.modifyMember2(reqeustMap);
					}
		        	
		        	
		          
		            
		            
		        } catch (SQLException e) {
		        	
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		            
		        }
		        return returnvalue ;        
			}

			/**
			 * 
			 * @param sDate
			 * @param eDate
			 * @param dept
			 * @param name
			 * @return
			 * @throws Exception
			 */
			public DataMap selectStdyDocDeptList(DataMap requestMap) throws BizException{
				
		       
				DataMap resultMap = null;
		        String sDate = "";
		        String eDate = "";
		              
		      
		        try {
		         
		   /*         sDate = requestMap.getString("sDate") + "000000";
		            eDate = requestMap.getString("eDate") + "000000";
		            requestMap.setString("sDate", sDate);
		            requestMap.setString("eDate", eDate);*/
		    		//조회시 쿼리들을 추가 시키기 위해서 변수 하나를 지정한다.		    		
		    		
		    		
		        	//기관선택명 가져오기
		        	resultMap = memberMapper.selectStudyDocList(requestMap);
		        	
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		            
		        }
		        return resultMap;        
			}

			/**
			 * 학적부관리 학력 리스트
			 * 작성일 6월 02일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			public DataMap selectEducationalRow() throws BizException{
				
		     
				DataMap resultMap = null;
		        
		        try {
		                  resultMap = memberMapper.selectEducationalRow();
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		           
		        }
		        return resultMap;        
			}		
			
			
			/**
			 * 개인별 학적부 자료 수정
			 * 작성일 : 6월 02일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			@Transactional
			public int modifyStudyExec(DataMap requestMap) throws BizException{
				
		       
		        int returnValue = 0;
		        
		        try {		          
		            
		            returnValue = memberMapper.modifyStudyExec(requestMap);
		          
		        } catch (SQLException e) {
		        
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		            
		        }
		        return returnValue;        
			}

			/**
			 * 특수권한 리스트 
			 * 작성일 : 6월 02일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			public DataMap selectGadminList() throws BizException{
				
		     
				DataMap resultMap = null;
		        
		        try {
		            
		            resultMap = memberMapper.selectGadminList();
		             
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		          
		        }
		        return resultMap;        
			}

			/**
			 * 특스권한자 리스트
			 * 작성일 6월 02일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			public DataMap selectManagerList(DataMap pagingMap) throws BizException{
				
		    
				DataMap resultMap = null;
		        
		        try {
		        	    int totalCnt = memberMapper.selectManagerListCount(pagingMap);
			        	
			        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, pagingMap);
			        	
			        	pagingMap.set("page", pageInfo);			        	            			      
			           	resultMap = memberMapper.selectManagerList(pagingMap);
			           	
			           	
			            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			            resultMap.set("PAGE_INFO", pageNavi); 
		           
			       
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		          
		        }
		        return resultMap;        
			}

			/**
			 * 특수 권한 ROW데이터
			 * 작성일 5월 27일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
				public DataMap selectGadminRow() throws BizException{
								        
					DataMap  resultMap = null;
			        
			        try {
			          
			        	
			        	
			        	//기관선택명 가져오기
			        	resultMap = memberMapper.selectGadminRow();
			        	
			            
			        } catch (SQLException e) {
			            throw new BizException(Message.getKey(e), e);
			        } finally {
			           
			        }
			        return resultMap;        
				}

				/**
				 * 특스권한자 리스트
				 * 작성일 6월 02일
				 * 작성자 정윤철
				 * @return
				 * @throws Exception
				 */
				public DataMap selectAdminHistoryList(DataMap pagingMap) throws BizException{
					
			        
					DataMap resultMap = null;
			        
			        try {
			        	
			        		int totalCnt = memberMapper.selectAdminHistoryListCount(pagingMap);
				        	
				        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, pagingMap);
				        	
				        	pagingMap.set("page", pageInfo);		
				        	
				            resultMap = memberMapper.selectAdminHistoryList(pagingMap);
				        	 
				            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
				            resultMap.set("PAGE_INFO", pageNavi); 
			           
		
			            
			        } catch (SQLException e) {
			            throw new BizException(Message.getKey(e), e);
			        } finally {
			         
			        }
			        return resultMap;        
				}

				/**
				 * 특수 권한 중복체크
				 * 작성일 6월 04일
				 * 작성자 정윤철
				 * @return
				 * @throws Exception
				 */
					public int selectGadminCount(DataMap requestMap) throws BizException{

				        int returnValue = 0;
				        try {
				           
				        	//기관선택명 가져오기
				        	returnValue = memberMapper.selectGadminCount(requestMap);
				        	
				        } catch (SQLException e) {
				            throw new BizException(Message.getKey(e), e);
				        } finally {
				           
				        }
				        return returnValue;        
					}

				/**
	 * 회원검색
	 * 작성일 6월 04일
	 * 작성자 정윤철
	 * @return
	 * @throws Exception
	 */
		public DataMap selectMemberSearchList(DataMap requestMap) throws BizException{
			
	        
	        DataMap resultMap = null;
	        
	        try {
	          
	        	//회원검색
	        	resultMap = memberMapper.selectMemberList(requestMap);
	        	
	            
	        } catch (SQLException e) {
	            throw new BizException(Message.getKey(e), e);
	        } finally {
	          
	        }
	        return resultMap;        
		}

		/**
		 * 특수권한 인서트
		 * 작성일 : 6월 04일
		 * 작성자 정윤철
		 * @return
		 * @throws Exception
		 */
		@Transactional
		public int insertAdminExec(DataMap requestMap) throws BizException{
			
	       
	        int returnValue = 0;
	        
	        try {
	            
	            
	            returnValue = memberMapper.insertAdminExec(requestMap);
	           
	        } catch (SQLException e) {
	        
	            throw new BizException(Message.getKey(e), e);
	        } finally {
	            
	        }
	        return returnValue;        
		}

		/**
		 * 특수 권한 삭제 잔여 권한 체크
		 * 작성일 6월 04일
		 * 작성자 정윤철
		 * @return
		 * @throws Exception
		 */
			public int selectGadminSaveCount(DataMap requestMap) throws BizException{

		       
		        int returnValue = 0;
		        try {
		            
		        	//권한 체크
		        	returnValue = memberMapper.selectGadminSaveCount(requestMap);
		        	

		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		            
		        }
		        return returnValue;        
			}

			/**
			 * 특수권한 삭제
			 * 작성일 : 6월 04일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			@Transactional
			public int deleteManager(DataMap requestMap) throws BizException{
				
		        
		        int returnValue = 0;
		        try {
		           
		            returnValue = memberMapper.deleteManager(requestMap);
		            
		        
		        } catch (SQLException e) {
		        
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		         
		        }
		        return returnValue;  
			}
			
			
			/**
			 * 특수권환 수정(프론트단에서는 삭제기능으로 되어있음) 
			 * 작성일 : 6월 04일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			@Transactional
			public int updateGadmin(String userNo) throws BizException{
				
		        
		        int returnValue = 0;
		        try {
		        
		            returnValue = memberMapper.updateGadmin(userNo);
		            
		        } catch (SQLException e) {		        	
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		            
		        }
		        return returnValue;  
			}
			
			
			/**
			 * 특수권환 수정(권한 디세이블) 
			 * 작성일 : 6월 04일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			@Transactional
			public int updateDisabledGadmin(DataMap requestMap) throws BizException{
				
		        
		        int returnValue = 0;
		        try {		          
		            
		            returnValue = memberMapper.updateDisabledGadmin(requestMap);
		       
		        } catch (SQLException e) {
		        	
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		           
		        }
		        return returnValue;  
			}
			
			
			/**
			 * 특수권한 삭제시 TB_GADMIN_HISTORY에 데이터를 쌓아둬야 한다.
			 * 작성일 : 6월 04일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			@Transactional
			public int insertGadminHistroy(DataMap requestMap) throws BizException{
						      
		        int returnValue = 0;
		        
		        try {
		            returnValue = memberMapper.insertGadminHistroy(requestMap);
		           
		        } catch (SQLException e) {
		        	
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		            
		        }
		        return returnValue;  
			}

			/**
			 * 개인별 학적부 자료 수정폼
			 * 작성일 : 6월 02일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			public DataMap selectSchoolRegRow(String userno, String linkGrseq, String grcode) throws BizException{
				
		        
		        DataMap resultMap = null;
		        
		        try {
		            
		        	Map<String, Object> params = new HashMap<String, Object>();
		        	
		        	params.put("userno", userno);
		        	params.put("linkGrseq", linkGrseq);
		        	params.put("grcode", grcode);
		        	
		            resultMap = memberMapper.selectSchoolRegRow(params);
		             
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		            
		        }
		        return resultMap;        
			}

			/**
			 * 학적부관리 수료조회 리스트
			 * 작성일 6월 02일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			public DataMap selectCompleteList(DataMap requestMap) throws BizException{
				
		       
		        DataMap resultMap = null;
		        
		        try {
		            resultMap = memberMapper.selectCompleteList(requestMap);
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		           
		        }
		        return resultMap;        
			}

			/**
			 * 학적부관리 학적조회 리스트
			 * 작성일 6월 02일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			public DataMap selectSchoolRegList(DataMap requestMap) throws BizException{
				
		       
		        DataMap resultMap = null;
		        
		        try {
		            resultMap = memberMapper.selectSchoolRegList(requestMap);
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		           
		        }
		        return resultMap;        
			}

			
			/**
			 * 학적부관리 개인별 리스트
			 * 작성일 5월 28일
			 * 작성자 정윤철
			 * @return
			 * @throws Exception
			 */
			public DataMap selectstudyPersonList(DataMap requestMap)  throws Exception{
				
		        
		        DataMap resultMap = null;
		        
		        try {
		            resultMap = memberMapper.selectstudyPersonList(requestMap);
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		           
		        }
		        return resultMap;        
			}

			/**
			 * 가점입력 인원 검색 함수
			 * @author CHJ - 080814
			 * @param smode
			 * @param grcode
			 * @param grseq
			 * @param search
			 * @return
			 * @throws Exception
			 */
			public DataMap selectPointSearchPerson(String smode,String grcode,String grseq,String search) throws Exception{

		        
		        DataMap resultMap = null;		      
		        try {
		               	if(smode.equals("stumas")){
		    				
		               		Map<String, Object> params = new HashMap<String, Object>();
		               		
		               		params.put("grcode", grcode);
		               		params.put("grseq", grseq);
		               		params.put("search", search);
		               		
		    				resultMap = memberMapper.selectPointSearchPerson(params);	
		    	
		    			}else{
		    				resultMap = memberMapper.selectPointSearchPerson2(search);
		    			}
		    					            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		           
		        }
		        return resultMap;        
			}

			/**
			 * 가점입력 학생장/부학생장 변경(선택)
			 * @param requestMap
			 * @return
			 * @throws Exception
			 */
			public int updatePointPerson(DataMap requestMap) throws Exception{
				int returnValue = 0;

				try {
		            
					returnValue=memberMapper.updatePointPerson(requestMap);
				 
				} catch (SQLException e) {
					throw new BizException(Message.getKey(e), e);
				} finally {
				}
				return returnValue;        
			}

			/**
			 * 가점입력 학생장/부학생장 변경(취소)
			 * @param requestMap
			 * @return
			 * @throws Exception
			 */
			public int deletePointPerson(DataMap requestMap) throws Exception{
				int returnValue = 0;

				try {
		            
					returnValue=memberMapper.deletePointPerson(requestMap);
					 
					} catch (SQLException e) {
						throw new BizException(Message.getKey(e), e);
					} finally {
					return returnValue;        
				}
			}

			/**
			 * 교육내역서, 출강강사 내역서 등록 실행
			 * @param requestMap
			 * @return
			 * @throws Exception
			 */
			public int insertBreakDownExec(DataMap requestMap) throws Exception{
				int returnValue = 0;

				try {
		            
					returnValue=memberMapper.insertBreakDownExec(requestMap);
					 
					} catch (SQLException e) {
						throw new BizException(Message.getKey(e), e);
					} finally {
					}
					return returnValue;        
			}

			public int ajaxCreateId(DataMap requestMap) throws Exception{
				
		        int error = -1;
		        try {
		            error = memberMapper.ajaxCreateId(requestMap);
		            
		        } catch (SQLException e) {
		            throw new BizException(Message.getKey(e), e);
		        } finally {
		        }
		        return error;        
			}
}
