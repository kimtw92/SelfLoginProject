package ut.lib.support;

import java.io.Reader;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.StringTokenizer;

import ut.lib.log.Log;
import ut.lib.util.Util;

/**
 * <B>NRsConverter</B>
 * - ResultSet을 파싱하여 DataMap로 변환하는 메서드를 포함하고 있다.
 * @author  miru
 * @version 2005. 7. 02.
 */
public class RsConverter {

    public RsConverter() {
    }

    /**
     * ResultSet을 파싱하여 DataMap 객체에 담아 return한다.
     * @return DataMap
     */
    public static DataMap toDataMap(ResultSet rs) throws SQLException {
        try {
            ResultSetMetaData rsMetaData = rs.getMetaData();
            int colCnt = rsMetaData.getColumnCount();

            String[] colName = new String[colCnt];
            int[] colType = new int[colCnt];
            int[] max = new int[colCnt];
            int limit = 0;
            DataMap map = new DataMap("RESULT_SET");

            while(rs.next()) {

                if (limit == 0) {

                    for (int i = 0; i < colCnt; i++) {
                        if (i == 0) {
                            colName[i] = getAttributeName(rsMetaData.getColumnName(i+1).toLowerCase());
                            max[i] = 0;
                        } else {
                            for (int j = 0; j < i; j++) {
                                if (colName[j].equals(getAttributeName(rsMetaData.getColumnName(i+1).toLowerCase()))) {
                                    colName[i] = getAttributeName(rsMetaData.getColumnName(i+1).toLowerCase()) + "_" + new Integer(max[j]+1).toString();
                                    max[i] = 0;
                                    max[j] += 1;
                                    break;
                                } else {
                                    if (j == i - 1) {
                                        colName[i] = getAttributeName(rsMetaData.getColumnName(i+1).toLowerCase());
                                        max[i] = 0;
                                    }
                                }
                            }
                        }
                        colType[i] = rsMetaData.getColumnType(i+1);
                    }
                }

                for(int k = 0; k < colCnt; k++) {
                    if (colType[k] == 2005) {			// CLOB 처리
        				Reader input = rs.getCharacterStream(k+1);
        	            String content = "";
        				try {
							content = Util.getClob(input);
						} catch (Exception e1) {

						} finally {
							map.add(colName[k], content);
						}

                    } else if (colType[k] == 12 || colType[k] == 1) {
                        String tempStr = rs.getString(k+1);
                        if (tempStr != null) {
                            tempStr = rs.getString(k+1).trim();
                        }
                        map.add(colName[k], tempStr);
                    } else {
                        if(colType[k] == 2) {
                            BigDecimal bigdecimal = rs.getBigDecimal(k+1);
                            if(bigdecimal == null)
                            	map.addString(colName[k], "0");
                            else
                                if(bigdecimal.scale() > 0)
                                {
                                    double d = bigdecimal.doubleValue();
                                    if(d < 3.4028234663852886E+038D){
                                    	map.addFloat(colName[k], bigdecimal.floatValue());
                                    }
                                    else
                                    	map.addDouble(colName[k], d);
                                } else
                                {
                                    long l = bigdecimal.longValue();
                                    if(l < 0x7fffffffL)
                                    	map.addInt(colName[k], bigdecimal.intValue());
                                    else
                                    	map.addLong(colName[k], l);
                                }
                        } else {
                        	map.add(colName[k], rs.getObject(k+1));
                        }
                    }
                }
                limit++;
            }
            return map;
        } catch(SQLException e) {
            Log.error("samsungfund.lib.support.RsConverter", "[Exception in RsConverter] Error occured while extracting data from ResultSet");
            throw e;
        }
    }

    /**
     * Column명을 변환하여 리턴한다.
     * ex. REG_DATE - regDate
     * @return DataMap
     */
    public static String getAttributeName(String s) {
        String s1 = "";
        StringTokenizer token = new StringTokenizer(s, "_");
        int size = token.countTokens();

        for(int i = 0; i < size; i++) {
            if (i == 0) {
                s1 = s1 + token.nextToken();
            } else {
                String s2 = token.nextToken();
                s1 = s1 + s2.substring(0, 1).toUpperCase() + s2.substring(1, s2.length());
            }
        }
        return s1;
    }
    
    public static synchronized Map<String, Object> keyToCamel(Map<String,Object> map){
    	String newKey = null;
    	String nowKey = null;
    	for(Entry<String, Object> entry : map.entrySet()){
    		nowKey = entry.getKey();
    		newKey = getAttributeName(nowKey);
    		map.put(newKey, map.remove(nowKey));
    	}
    	return map;
    }
    
    public static synchronized List<Map<String, Object>> keyToCamel(List<Map<String,Object>> listMap){
    	for(Map<String, Object> map : listMap){
    		keyToCamel(map);
    	}
    	return listMap;
    }

}
