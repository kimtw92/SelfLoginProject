package ut.lib.util;

import java.sql.SQLException;
/**
 * <B>NMessage</B>
 * - SQLException 관련 메시지 정의 클래스
 * @author  miru
 * @version 2005. 7. 02.
 */
public class Message {

    /**
     * exception의 에러코드에 해당하는 메시지를 리턴한다.
     * @param SQLException
     * @return 메시지
     */
    public static String getKey(SQLException e) {
        if (e.getErrorCode()==1) {
            return "DB.MSG01";
        } else {
            return "DB.MSG00";
        }
    }
}
