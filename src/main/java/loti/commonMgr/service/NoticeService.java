package loti.commonMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.common.mapper.CommonMapper;
import loti.commonMgr.mapper.NoticeMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service
public class NoticeService extends BaseService {
	
	@Autowired
	private NoticeMapper noticeMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	/**
	 * 공지 등록
	 * 
	 * @param requestMap
	 * @param groupFileNo
	 * @param userNo
	 * @return
	 * @throws Exception
	 */
	public int insertNotice(DataMap requestMap, int groupFileNo, String userNo)
			throws Exception {

		int resultValue = 0;

		try {

			int max = noticeMapper.selectNoticeMaxNo();
			
			requestMap.setInt("max", max+1);
			requestMap.setInt("groupFileNo", groupFileNo);
			requestMap.setString("userNo", userNo);
			
			resultValue = noticeMapper.insertNotice(requestMap);

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}

		return resultValue;

	}

	/**
	 * 공지 삭제.
	 * 
	 * @param grCode
	 * @param grSeq
	 * @param no
	 * @return
	 * @throws Exception
	 */
	public int deleteNotice(String seq, String wuserno) throws Exception {

		int resultValue = 0;

		try {

			Map<String, Object> params = new HashMap<String, Object>();
			
			params.put("seq", seq);
			params.put("wuserno", wuserno);
			
			resultValue = noticeMapper.deleteNotice(params);

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}

		return resultValue;

	}

	/**
	 * 공지 수정.
	 * 
	 * @param requestMap
	 * @param groupFileNo
	 * @param userNo
	 * @return
	 * @throws Exception
	 */
	public int updateNotice(DataMap requestMap, int groupFileNo)
			throws Exception {

		int resultValue = 0;

		try {

			requestMap.setInt("groupFileNo", groupFileNo);
			
			resultValue = noticeMapper.updateNotice(requestMap);

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}

		return resultValue;

	}

	/**
	 * 대상자 검색
	 * 
	 * @param searchKey
	 * @param searchValue
	 * @param requestMap
	 * @return
	 */
	public DataMap selectSearchPerList(String searchKey, String searchValue,
			String searchText, DataMap requestMap) throws Exception {
		DataMap resultMap = null;

		try {

			requestMap.setString("searchKey", searchKey);
			requestMap.setString("searchValue", searchValue);
			requestMap.setString("searchText", searchText);

	    	int totalCnt = noticeMapper.selectSearchPerListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
        	resultMap = noticeMapper.selectSearchPerList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
			

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	/**
	 * 개인 그룹 공지 관리 리스트
	 * 
	 * @param whereStr
	 * @param pagingInfoMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectNotiPerGrpList(String searchKey, String searchValue,
			String userNo, DataMap pagingInfoMap) throws Exception {

		DataMap resultMap = null;

		try {

			pagingInfoMap.setString("searchKey", searchKey);
			pagingInfoMap.setString("searchValue", searchValue);
			pagingInfoMap.setString("userNo", userNo);

	    	int totalCnt = noticeMapper.selectNotiPerGrpListCount(pagingInfoMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, pagingInfoMap);
        	
        	pagingInfoMap.set("page", pageInfo);
        	
            resultMap = noticeMapper.selectNotiPerGrpList(pagingInfoMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
			

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	/**
	 * 개인 그룹 공지 관리 상세보기
	 * 
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectNotiPerGrpRow(int seq, String qu) throws Exception {

		DataMap resultMap = null;
		try {

			resultMap = noticeMapper.selectNotiPerGrpRow(seq);
			resultMap.setNullToInitialize(true);

			// 이름 및 권한명
			String tmpStr = resultMap.getString("notiPart");
			System.out.println("\n ##1 tmpStr = " + tmpStr);
			tmpStr = tmpStr.replaceAll("\\]\\[", ",");
			tmpStr = tmpStr.replaceAll("\\] \\[", ",");
			tmpStr = tmpStr.replaceAll("\\]", "");
			tmpStr = tmpStr.replaceAll("\\[", "");
			System.out.println("\n ##2 tmpStr = " + tmpStr);

			String[] tmpStrArr = tmpStr.split(",");

			// View Mode일 경우에는 해당되는 사용자 및 관리자 리스트를 보여준다.
			String notiPartName = ""; // 최종 이름 및 권한명.
			if (qu.equals("view")) {
				if (resultMap.getString("notiGubun").equals("P")) {
					for (int i = 0; i < tmpStrArr.length; i++) {
						if (!notiPartName.equals(""))
							notiPartName += ",";
						notiPartName += commonMapper.selectUserNameString(tmpStrArr[i]);
					}
					resultMap.add("notiPartName", notiPartName);
				} else {
					for (int i = 0; i < tmpStrArr.length; i++) {
						if (!notiPartName.equals(""))
							notiPartName += ",";
						notiPartName += commonMapper.selectGadminString(tmpStrArr[i]);
					}
					resultMap.add("notiPartName", notiPartName);
				}
			}
			// Update Mode일 경우에는 해당되는 사용자 및 관리자 리스트를 보여준다.
			if (qu.equals("update")) {
				DataMap optionMap = new DataMap();
				if (resultMap.getString("notiGubun").equals("P")) {
					for (int i = 0; i < tmpStrArr.length; i++) {
						optionMap.add("name", noticeMapper.searchName(tmpStrArr[i]).getString("name") + "(" + tmpStrArr[i] + ")");
						optionMap.add("no", tmpStrArr[i]);
					}
					resultMap.add("optionMap", optionMap);
				} else {
					for (int i = 0; i < tmpStrArr.length; i++) {
						optionMap.add("group", tmpStrArr[i]);
					}
					resultMap.add("selectedGroup", optionMap);
				}
			}

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	/**
	 * 개인 그룹 공지 관리 방문자수 증가.
	 * 
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public int updateNotiPerGrpVisitCnt(int seq) throws Exception {

		int returnValue = 0;

		try {

			returnValue = noticeMapper.updateNotiPerGrpVisitCnt(seq);

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return returnValue;
	}
}
