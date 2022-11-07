package loti.courseMgr.service;

import java.sql.SQLException;

import loti.courseMgr.mapper.ResultHtmlMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class ResultHtmlService extends BaseService {

	@Autowired
	private ResultHtmlMapper resultHtmlMapper;
	
	public String getBaseHtml(){
		StringBuffer returnBuffer = new StringBuffer();
		
		returnBuffer.append("<center> \n");
		returnBuffer.append("    <table border=\"0\" width=\"700px\" height=\"1050px\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse;table-layout:fixed;\">  \n");
		returnBuffer.append("        <tr>  \n");
		returnBuffer.append("            <td height=\"1050px\" width=\"700px\" valign=\"top\" style='border-left-width:0.12mm; border-left-color:#000000; border-left-style:none;border-right-width:0.12mm; border-right-color:#000000; border-right-style:none;border-top-width:0.12mm; border-top-color:#000000; border-top-style:none;border-bottom-width:0.12mm; border-bottom-color:#000000; border-bottom-style:none;'>  \n");
		returnBuffer.append("                <P STYLE='font-family:\"궁서체\";font-size:21px;color:\"#000000\";text-align:justify;line-height:34px;text-indent:0px;margin-left:0px;margin-right:0px;margin-top:0px;margin-bottom:0px;'>  \n");
		returnBuffer.append("                    <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" height=\"100%\">  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td height=\"40\">  \n");
		returnBuffer.append("                                <P STYLE='font-family:\"궁서체\";font-size:24px;color:\"#000000\";line-height:38px;text-indent:0px;margin-left:0px;margin-right:0px;margin-top:0px;margin-bottom:0px;'>  \n");
		returnBuffer.append("                                    &nbsp;&nbsp;&nbsp;제&nbsp;{수료번호}&nbsp;호  \n");
		returnBuffer.append("                                </p>  \n");
		returnBuffer.append("                            </td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td height=50></td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td align=center height=\"102\">  \n");
		returnBuffer.append("                                <SPAN STYLE='font-family:\"궁서체\";font-size:70px;color:\"#000000\";font-weight:\"bold\";line-height:102px;text-align:center;'>수&nbsp;료&nbsp;증</SPAN>  \n");
		returnBuffer.append("                            </td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td height=50></td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td align=right height=\"50\">  \n");
		returnBuffer.append("                                <P STYLE='font-family:\"궁서체\";font-size:24px;color:\"#000000\";line-height:48px;text-indent:0px;margin-left:0px;margin-right:0px;margin-top:0px;margin-bottom:0px;'>  \n");
		returnBuffer.append("                                    &nbsp;&nbsp;{소속기관} {상세기관}  \n");
		returnBuffer.append("                                </p>  \n");
		returnBuffer.append("                            </td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td align=right height=\"60\">  \n");
		returnBuffer.append("                                <P STYLE='font-family:\"궁서체\";font-size:24px;color:\"#000000\";line-height:40px;text-indent:0px;margin-left:0px;margin-right:0px;margin-top:0px;margin-bottom:0px;'>  \n");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";font-size:22px;color:\"#000000\";line-height:40px;'>{직급명}</SPAN>&nbsp;  \n");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";font-size:31px;color:\"#000000\";line-height:60px;'>{성명}</SPAN>  \n");
		returnBuffer.append("                                </p> \n");
		returnBuffer.append("                            </td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td height=60></td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td align=center height=\"*\" valign=\"top\">  \n");
		returnBuffer.append("                                <div STYLE='font-family:\"궁서체\";font-size:33px;color:\"#000000\";line-height:53px;text-indent:0px;margin-left:0px;margin-right:0px;margin-top:0px;margin-bottom:0px;'>");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";font-size:30px;color:\"#000000\";font-weight:\"bold\";line-height:53px;'>&nbsp;&nbsp;&nbsp;&nbsp;위 사람은 </SPAN>");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";font-size:30px;color:\"#000000\";font-weight:\"bold\";line-height:53px;'> {년도}년도  {기수} {과정명} </SPAN>");
		returnBuffer.append("                                </div>");
		//returnBuffer.append("                                </p>  \n");
		returnBuffer.append("                                <div STYLE='font-family:\"궁서체\";font-size:33px;color:\"#000000\";line-height:53px;text-indent:0px;margin-left:0px;margin-right:0px;margin-top:0px;margin-bottom:0px;'>");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";font-size:30px;color:\"#000000\";font-weight:\"bold\";line-height:53px;text-align:justify;'></SPAN>");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";font-size:30px;color:\"#000000\";font-weight:\"bold\";line-height:53px;text-align:justify;'>&nbsp;&nbsp;교육훈련과정을 마치었으므로 이 증서를</SPAN>");
		//returnBuffer.append("                                </p>  \n");
		returnBuffer.append("                                </div>");
		returnBuffer.append("                                <div STYLE='font-family:\"궁서체\";font-size:33px;color:\"#000000\";line-height:53px;text-indent:0px;margin-left:0px;margin-right:0px;margin-top:0px;margin-bottom:0px;'>");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";font-size:30px;color:\"#000000\";font-weight:\"bold\";line-height:53px;text-align:justify;'>&nbsp;&nbsp;수여합니다.</SPAN>");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";font-size:24px;color:\"#000000\";line-height:38px;text-align:justify;'>({교육시작일}~{교육종료일})</SPAN>");
		//returnBuffer.append("                                </p>  \n");
		returnBuffer.append("                                </div>");
		returnBuffer.append("                            </td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td height=60></td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td align=center height=\"50\">  \n");
		returnBuffer.append("                                <P STYLE='font-family:\"궁서체\";font-size:29px;color:\"#000000\";line-height:47px;text-indent:0px;margin-left:0px;margin-right:0px;margin-top:0px;margin-bottom:0px;'>  \n");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";font-size:29px;color:\"#000000\";line-height:47px;'>{현재일자}</SPAN>  \n");
		returnBuffer.append("                                </p>  \n");
		returnBuffer.append("                            </td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td height=70></td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                        <tr>  \n");
		returnBuffer.append("                            <td align=center height=\"50\">  \n");
		returnBuffer.append("                                <P STYLE='font-family:\"궁서체\";font-size:27px;color:\"#000000\";line-height:50px;text-indent:0px;margin-left:0px;margin-right:0px;margin-top:0px;margin-bottom:0px;'>  \n");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";letter-spacing:-5px;font-size:29px;color:\"#000000\";line-height:47px;'>인천광역시지방공무원교육원장</SPAN>  \n");
		returnBuffer.append("                                    <SPAN STYLE='font-family:\"궁서체\";font-size:33px;color:\"#000000\";line-height:53px;'>{교육원장명} </SPAN>  \n");
		returnBuffer.append("                                </p>  \n");
		returnBuffer.append("                            </td>  \n");
		returnBuffer.append("                        </tr>  \n");
		returnBuffer.append("                    </table>  \n");
		returnBuffer.append("                </p>  \n");
		returnBuffer.append("            </td>  \n");
		returnBuffer.append("        </tr>  \n");
		returnBuffer.append("    </table> \n");
		returnBuffer.append("</center> \n");

		return returnBuffer.toString();
	}

	/**
	 * 수료증 HTML 상세 보기
	 */
	public DataMap selectResultDocRow(int no) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = resultHtmlMapper.selectResultDocRow(no);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 
	 */
	public int execResultHtmlReset(DataMap requestMap, String sessUserNo) throws BizException{
		int returnValue = 0;
        
        try {
        	DataMap objMap = new DataMap();
            objMap.setNullToInitialize(true);
            
            objMap.setString("no", "0");
            objMap.setString("title", "시스템 초기 HTML");
            objMap.setString("useYn", "Y");
            objMap.setString("content", getBaseHtml());
            objMap.setString("luserno", sessUserNo);
            
            if(requestMap.getString("no").equals("0"))
            	returnValue = resultHtmlMapper.updateResultDoc(objMap);
            else
            	returnValue = resultHtmlMapper.insertResultDoc(objMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;
	}
	
	/**
	 * 수료증 HTML 수정
	 */
	public int updateResultHtml(DataMap requestMap, String sessUserNo) throws BizException{
		int returnValue = 0;
        
        try {
        	requestMap.setString("useYn", "Y");
            requestMap.setString("luserno", sessUserNo);
            
            returnValue = resultHtmlMapper.updateResultDoc(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;
	}
}
