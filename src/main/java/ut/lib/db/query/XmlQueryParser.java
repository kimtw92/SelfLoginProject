package ut.lib.db.query;


import java.util.HashMap;
import java.util.Map;
import org.w3c.dom.*;

import ut.lib.exception.BizException;
import ut.lib.log.Log;
import ut.lib.util.Constants;
import ut.lib.util.XmlDomUtil;

/**
 * <B>XmlQueryParser</B>
 * - XML 파일에서 해당 query를 로딩하기 위한 클래스이다.
 * @author  miru
 * @version 2005. 6. 16.
 */
public class XmlQueryParser {
    
    private static XmlQueryParser parser = null;
    private static Map queryXmlMap = null;
    
    private static int i = 0;
    
    private XmlQueryParser() {
        queryXmlMap = new HashMap();
        
        i++;                        
     }
    
    /**
     * XmlQueryParser 인스턴스를 리턴한다.
     * @return XmlQueryParser instance
     */    
    public static XmlQueryParser getInstance() {
   //     if (parser == null) {
   //        parser = new XmlQueryParser();      
   //     }
   //     return parser;
    	
    	return new XmlQueryParser();
    }    
    
    /**
     * XML 파일에서 query를 리턴한다.
     * @param XML 파일명
     * @param query element name
     * @return query
     */     
    public String getSql(String xmlFile, String queryName) throws Exception {
        Element element = null;
        if (!Constants.QUERY_DEBUG && queryXmlMap != null && queryXmlMap.containsKey(xmlFile)) {
            element = (Element)queryXmlMap.get(xmlFile);
        } else {
            element = XmlDomUtil.loadXmlDocument(Constants.QUERY + xmlFile);
            queryXmlMap.put(xmlFile, element);
        }
        
        return parseXml(element, queryName);
    }
    
    
    private String parseXml(Element element, String queryName) throws Exception {
        String query = null;
        if (element != null) {
            query = XmlDomUtil.getTagValue(element, "statement", queryName);
        } else {
            Log.error(this.getClass(), "[Exception in XmlQueryParser] Element is null");
            throw new BizException("COMMON.MSG03");
        }
        
        if (query == null) {
            Log.error(this.getClass(), "[Exception in XmlQueryParser] Query is null");
            throw new BizException("COMMON.MSG04");            
        }
        
        return query;
    }    
    
    /**
     * Map에 저장되어있는 쿼리를 reset 한다.
     */         
    public void reset() {
        synchronized(this) {
            if(queryXmlMap != null) {
                queryXmlMap.clear();
            }
        }
    }
}
